return {
	Play120431001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 120431001
		arg_1_1.duration_ = 8.73

		local var_1_0 = {
			zh = 6.1,
			ja = 8.733
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
				arg_1_0:Play120431002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST31"

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
				local var_4_5 = arg_1_1.bgs_.ST31

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
					if iter_4_0 ~= "ST31" then
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

			local var_4_22 = 0
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "effect"

				arg_1_1:AudioAction(var_4_24, var_4_25, "se_story_120_04", "se_story_120_04_street_loop", "")
			end

			local var_4_26 = "1076ui_story"

			if arg_1_1.actors_[var_4_26] == nil then
				local var_4_27 = Asset.Load("Char/" .. "1076ui_story")

				if not isNil(var_4_27) then
					local var_4_28 = Object.Instantiate(Asset.Load("Char/" .. "1076ui_story"), arg_1_1.stage_.transform)

					var_4_28.name = var_4_26
					var_4_28.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_26] = var_4_28

					local var_4_29 = var_4_28:GetComponentInChildren(typeof(CharacterEffect))

					var_4_29.enabled = true

					local var_4_30 = GameObjectTools.GetOrAddComponent(var_4_28, typeof(DynamicBoneHelper))

					if var_4_30 then
						var_4_30:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_29.transform, false)

					arg_1_1.var_[var_4_26 .. "Animator"] = var_4_29.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_26 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_26 .. "LipSync"] = var_4_29.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_31 = arg_1_1.actors_["1076ui_story"].transform
			local var_4_32 = 1.8

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				arg_1_1.var_.moveOldPos1076ui_story = var_4_31.localPosition
			end

			local var_4_33 = 0.001

			if var_4_32 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				local var_4_34 = (arg_1_1.time_ - var_4_32) / var_4_33
				local var_4_35 = Vector3.New(-0.7, -1.06, -6.2)

				var_4_31.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1076ui_story, var_4_35, var_4_34)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_31.position

				var_4_31.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_31.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_31.localEulerAngles = var_4_37
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				var_4_31.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_4_38 = manager.ui.mainCamera.transform.position - var_4_31.position

				var_4_31.forward = Vector3.New(var_4_38.x, var_4_38.y, var_4_38.z)

				local var_4_39 = var_4_31.localEulerAngles

				var_4_39.z = 0
				var_4_39.x = 0
				var_4_31.localEulerAngles = var_4_39
			end

			local var_4_40 = 1.8

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_4_41 = 1.8

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_4_42 = arg_1_1.actors_["1076ui_story"]
			local var_4_43 = 1.8

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 and not isNil(var_4_42) and arg_1_1.var_.characterEffect1076ui_story == nil then
				arg_1_1.var_.characterEffect1076ui_story = var_4_42:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_44 = 0.2

			if var_4_43 <= arg_1_1.time_ and arg_1_1.time_ < var_4_43 + var_4_44 and not isNil(var_4_42) then
				local var_4_45 = (arg_1_1.time_ - var_4_43) / var_4_44

				if arg_1_1.var_.characterEffect1076ui_story and not isNil(var_4_42) then
					arg_1_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_43 + var_4_44 and arg_1_1.time_ < var_4_43 + var_4_44 + arg_4_0 and not isNil(var_4_42) and arg_1_1.var_.characterEffect1076ui_story then
				arg_1_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_4_46 = 0.233333333333333
			local var_4_47 = 1

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				local var_4_48 = "play"
				local var_4_49 = "music"

				arg_1_1:AudioAction(var_4_48, var_4_49, "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_4_50 = ""
				local var_4_51 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

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

			local var_4_52 = 0
			local var_4_53 = 0.2

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				local var_4_54 = "play"
				local var_4_55 = "music"

				arg_1_1:AudioAction(var_4_54, var_4_55, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_56 = ""
				local var_4_57 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_58 = 2
			local var_4_59 = 0.45

			if var_4_58 < arg_1_1.time_ and arg_1_1.time_ <= var_4_58 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_60 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_60:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_61 = arg_1_1:FormatText(StoryNameCfg[389].name)

				arg_1_1.leftNameTxt_.text = var_4_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_62 = arg_1_1:GetWordFromCfg(120431001)
				local var_4_63 = arg_1_1:FormatText(var_4_62.content)

				arg_1_1.text_.text = var_4_63

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_64 = 18
				local var_4_65 = utf8.len(var_4_63)
				local var_4_66 = var_4_64 <= 0 and var_4_59 or var_4_59 * (var_4_65 / var_4_64)

				if var_4_66 > 0 and var_4_59 < var_4_66 then
					arg_1_1.talkMaxDuration = var_4_66
					var_4_58 = var_4_58 + 0.3

					if var_4_66 + var_4_58 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_66 + var_4_58
					end
				end

				arg_1_1.text_.text = var_4_63
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431001", "story_v_out_120431.awb") ~= 0 then
					local var_4_67 = manager.audio:GetVoiceLength("story_v_out_120431", "120431001", "story_v_out_120431.awb") / 1000

					if var_4_67 + var_4_58 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_67 + var_4_58
					end

					if var_4_62.prefab_name ~= "" and arg_1_1.actors_[var_4_62.prefab_name] ~= nil then
						local var_4_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_62.prefab_name].transform, "story_v_out_120431", "120431001", "story_v_out_120431.awb")

						arg_1_1:RecordAudio("120431001", var_4_68)
						arg_1_1:RecordAudio("120431001", var_4_68)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_120431", "120431001", "story_v_out_120431.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_120431", "120431001", "story_v_out_120431.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_69 = var_4_58 + 0.3
			local var_4_70 = math.max(var_4_59, arg_1_1.talkMaxDuration)

			if var_4_69 <= arg_1_1.time_ and arg_1_1.time_ < var_4_69 + var_4_70 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_69) / var_4_70

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_69 + var_4_70 and arg_1_1.time_ < var_4_69 + var_4_70 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
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
	Play120431002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 120431002
		arg_9_1.duration_ = 4.6

		local var_9_0 = {
			zh = 2.233,
			ja = 4.6
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
				arg_9_0:Play120431003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1084ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_12_6 = arg_9_1.actors_["1084ui_story"]
			local var_12_7 = 0

			if var_12_7 < arg_9_1.time_ and arg_9_1.time_ <= var_12_7 + arg_12_0 and not isNil(var_12_6) and arg_9_1.var_.characterEffect1084ui_story == nil then
				arg_9_1.var_.characterEffect1084ui_story = var_12_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_8 = 0.2

			if var_12_7 <= arg_9_1.time_ and arg_9_1.time_ < var_12_7 + var_12_8 and not isNil(var_12_6) then
				local var_12_9 = (arg_9_1.time_ - var_12_7) / var_12_8

				if arg_9_1.var_.characterEffect1084ui_story and not isNil(var_12_6) then
					arg_9_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_7 + var_12_8 and arg_9_1.time_ < var_12_7 + var_12_8 + arg_12_0 and not isNil(var_12_6) and arg_9_1.var_.characterEffect1084ui_story then
				arg_9_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_12_10 = arg_9_1.actors_["1084ui_story"].transform
			local var_12_11 = 0

			if var_12_11 < arg_9_1.time_ and arg_9_1.time_ <= var_12_11 + arg_12_0 then
				arg_9_1.var_.moveOldPos1084ui_story = var_12_10.localPosition
			end

			local var_12_12 = 0.001

			if var_12_11 <= arg_9_1.time_ and arg_9_1.time_ < var_12_11 + var_12_12 then
				local var_12_13 = (arg_9_1.time_ - var_12_11) / var_12_12
				local var_12_14 = Vector3.New(0.7, -0.97, -6)

				var_12_10.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1084ui_story, var_12_14, var_12_13)

				local var_12_15 = manager.ui.mainCamera.transform.position - var_12_10.position

				var_12_10.forward = Vector3.New(var_12_15.x, var_12_15.y, var_12_15.z)

				local var_12_16 = var_12_10.localEulerAngles

				var_12_16.z = 0
				var_12_16.x = 0
				var_12_10.localEulerAngles = var_12_16
			end

			if arg_9_1.time_ >= var_12_11 + var_12_12 and arg_9_1.time_ < var_12_11 + var_12_12 + arg_12_0 then
				var_12_10.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_12_17 = manager.ui.mainCamera.transform.position - var_12_10.position

				var_12_10.forward = Vector3.New(var_12_17.x, var_12_17.y, var_12_17.z)

				local var_12_18 = var_12_10.localEulerAngles

				var_12_18.z = 0
				var_12_18.x = 0
				var_12_10.localEulerAngles = var_12_18
			end

			local var_12_19 = arg_9_1.actors_["1076ui_story"]
			local var_12_20 = 0

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 and not isNil(var_12_19) and arg_9_1.var_.characterEffect1076ui_story == nil then
				arg_9_1.var_.characterEffect1076ui_story = var_12_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_21 = 0.2

			if var_12_20 <= arg_9_1.time_ and arg_9_1.time_ < var_12_20 + var_12_21 and not isNil(var_12_19) then
				local var_12_22 = (arg_9_1.time_ - var_12_20) / var_12_21

				if arg_9_1.var_.characterEffect1076ui_story and not isNil(var_12_19) then
					local var_12_23 = Mathf.Lerp(0, 0.5, var_12_22)

					arg_9_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1076ui_story.fillRatio = var_12_23
				end
			end

			if arg_9_1.time_ >= var_12_20 + var_12_21 and arg_9_1.time_ < var_12_20 + var_12_21 + arg_12_0 and not isNil(var_12_19) and arg_9_1.var_.characterEffect1076ui_story then
				local var_12_24 = 0.5

				arg_9_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1076ui_story.fillRatio = var_12_24
			end

			local var_12_25 = 0

			if var_12_25 < arg_9_1.time_ and arg_9_1.time_ <= var_12_25 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_12_26 = 0
			local var_12_27 = 0.3

			if var_12_26 < arg_9_1.time_ and arg_9_1.time_ <= var_12_26 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_28 = arg_9_1:FormatText(StoryNameCfg[6].name)

				arg_9_1.leftNameTxt_.text = var_12_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_29 = arg_9_1:GetWordFromCfg(120431002)
				local var_12_30 = arg_9_1:FormatText(var_12_29.content)

				arg_9_1.text_.text = var_12_30

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_31 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431002", "story_v_out_120431.awb") ~= 0 then
					local var_12_34 = manager.audio:GetVoiceLength("story_v_out_120431", "120431002", "story_v_out_120431.awb") / 1000

					if var_12_34 + var_12_26 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_34 + var_12_26
					end

					if var_12_29.prefab_name ~= "" and arg_9_1.actors_[var_12_29.prefab_name] ~= nil then
						local var_12_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_29.prefab_name].transform, "story_v_out_120431", "120431002", "story_v_out_120431.awb")

						arg_9_1:RecordAudio("120431002", var_12_35)
						arg_9_1:RecordAudio("120431002", var_12_35)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_120431", "120431002", "story_v_out_120431.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_120431", "120431002", "story_v_out_120431.awb")
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
				actorName = "1084ui_story",
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
	Play120431003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 120431003
		arg_13_1.duration_ = 4.4

		local var_13_0 = {
			zh = 2.433,
			ja = 4.4
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
				arg_13_0:Play120431004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_16_1 = 0
			local var_16_2 = 0.275

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_3 = arg_13_1:FormatText(StoryNameCfg[6].name)

				arg_13_1.leftNameTxt_.text = var_16_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_4 = arg_13_1:GetWordFromCfg(120431003)
				local var_16_5 = arg_13_1:FormatText(var_16_4.content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_6 = 11
				local var_16_7 = utf8.len(var_16_5)
				local var_16_8 = var_16_6 <= 0 and var_16_2 or var_16_2 * (var_16_7 / var_16_6)

				if var_16_8 > 0 and var_16_2 < var_16_8 then
					arg_13_1.talkMaxDuration = var_16_8

					if var_16_8 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431003", "story_v_out_120431.awb") ~= 0 then
					local var_16_9 = manager.audio:GetVoiceLength("story_v_out_120431", "120431003", "story_v_out_120431.awb") / 1000

					if var_16_9 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_1
					end

					if var_16_4.prefab_name ~= "" and arg_13_1.actors_[var_16_4.prefab_name] ~= nil then
						local var_16_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_4.prefab_name].transform, "story_v_out_120431", "120431003", "story_v_out_120431.awb")

						arg_13_1:RecordAudio("120431003", var_16_10)
						arg_13_1:RecordAudio("120431003", var_16_10)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_120431", "120431003", "story_v_out_120431.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_120431", "120431003", "story_v_out_120431.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_11 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_11 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_11

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_11 and arg_13_1.time_ < var_16_1 + var_16_11 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play120431004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 120431004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play120431005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1084ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1084ui_story == nil then
				arg_17_1.var_.characterEffect1084ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1084ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1084ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1084ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1084ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 0.45

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_8 = arg_17_1:FormatText(StoryNameCfg[7].name)

				arg_17_1.leftNameTxt_.text = var_20_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_9 = arg_17_1:GetWordFromCfg(120431004)
				local var_20_10 = arg_17_1:FormatText(var_20_9.content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 18
				local var_20_12 = utf8.len(var_20_10)
				local var_20_13 = var_20_11 <= 0 and var_20_7 or var_20_7 * (var_20_12 / var_20_11)

				if var_20_13 > 0 and var_20_7 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_10
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_14 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_14 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_14

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_14 and arg_17_1.time_ < var_20_6 + var_20_14 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play120431005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 120431005
		arg_21_1.duration_ = 4.9

		local var_21_0 = {
			zh = 3.4,
			ja = 4.9
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
				arg_21_0:Play120431006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1084ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1084ui_story == nil then
				arg_21_1.var_.characterEffect1084ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1084ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1084ui_story then
				arg_21_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_24_4 = 0

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_24_5 = 0
			local var_24_6 = 0.325

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_7 = arg_21_1:FormatText(StoryNameCfg[6].name)

				arg_21_1.leftNameTxt_.text = var_24_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_8 = arg_21_1:GetWordFromCfg(120431005)
				local var_24_9 = arg_21_1:FormatText(var_24_8.content)

				arg_21_1.text_.text = var_24_9

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 13
				local var_24_11 = utf8.len(var_24_9)
				local var_24_12 = var_24_10 <= 0 and var_24_6 or var_24_6 * (var_24_11 / var_24_10)

				if var_24_12 > 0 and var_24_6 < var_24_12 then
					arg_21_1.talkMaxDuration = var_24_12

					if var_24_12 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_12 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_9
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431005", "story_v_out_120431.awb") ~= 0 then
					local var_24_13 = manager.audio:GetVoiceLength("story_v_out_120431", "120431005", "story_v_out_120431.awb") / 1000

					if var_24_13 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_5
					end

					if var_24_8.prefab_name ~= "" and arg_21_1.actors_[var_24_8.prefab_name] ~= nil then
						local var_24_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_8.prefab_name].transform, "story_v_out_120431", "120431005", "story_v_out_120431.awb")

						arg_21_1:RecordAudio("120431005", var_24_14)
						arg_21_1:RecordAudio("120431005", var_24_14)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_120431", "120431005", "story_v_out_120431.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_120431", "120431005", "story_v_out_120431.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_15 = math.max(var_24_6, arg_21_1.talkMaxDuration)

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_15 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_5) / var_24_15

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_5 + var_24_15 and arg_21_1.time_ < var_24_5 + var_24_15 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play120431006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 120431006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play120431007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1084ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1084ui_story == nil then
				arg_25_1.var_.characterEffect1084ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1084ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1084ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1084ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1084ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 1.125

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_8 = arg_25_1:GetWordFromCfg(120431006)
				local var_28_9 = arg_25_1:FormatText(var_28_8.content)

				arg_25_1.text_.text = var_28_9

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 45
				local var_28_11 = utf8.len(var_28_9)
				local var_28_12 = var_28_10 <= 0 and var_28_7 or var_28_7 * (var_28_11 / var_28_10)

				if var_28_12 > 0 and var_28_7 < var_28_12 then
					arg_25_1.talkMaxDuration = var_28_12

					if var_28_12 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_9
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_13 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_13 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_13

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_13 and arg_25_1.time_ < var_28_6 + var_28_13 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play120431007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 120431007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play120431008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.9

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(120431007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 36
				local var_32_5 = utf8.len(var_32_3)
				local var_32_6 = var_32_4 <= 0 and var_32_1 or var_32_1 * (var_32_5 / var_32_4)

				if var_32_6 > 0 and var_32_1 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_7 and arg_29_1.time_ < var_32_0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play120431008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 120431008
		arg_33_1.duration_ = 3.8

		local var_33_0 = {
			zh = 1.999999999999,
			ja = 3.8
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
				arg_33_0:Play120431009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1084ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1084ui_story == nil then
				arg_33_1.var_.characterEffect1084ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.2

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1084ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1084ui_story then
				arg_33_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_36_4 = 0

			if var_36_4 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_36_5 = 0
			local var_36_6 = 0.275

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_7 = arg_33_1:FormatText(StoryNameCfg[6].name)

				arg_33_1.leftNameTxt_.text = var_36_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:GetWordFromCfg(120431008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431008", "story_v_out_120431.awb") ~= 0 then
					local var_36_13 = manager.audio:GetVoiceLength("story_v_out_120431", "120431008", "story_v_out_120431.awb") / 1000

					if var_36_13 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_5
					end

					if var_36_8.prefab_name ~= "" and arg_33_1.actors_[var_36_8.prefab_name] ~= nil then
						local var_36_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_8.prefab_name].transform, "story_v_out_120431", "120431008", "story_v_out_120431.awb")

						arg_33_1:RecordAudio("120431008", var_36_14)
						arg_33_1:RecordAudio("120431008", var_36_14)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_120431", "120431008", "story_v_out_120431.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_120431", "120431008", "story_v_out_120431.awb")
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
	Play120431009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 120431009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play120431010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1084ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1084ui_story == nil then
				arg_37_1.var_.characterEffect1084ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1084ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1084ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1084ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1084ui_story.fillRatio = var_40_5
			end

			local var_40_6 = 0
			local var_40_7 = 0.75

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_8 = arg_37_1:FormatText(StoryNameCfg[7].name)

				arg_37_1.leftNameTxt_.text = var_40_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_9 = arg_37_1:GetWordFromCfg(120431009)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 30
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
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_14 and arg_37_1.time_ < var_40_6 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play120431010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 120431010
		arg_41_1.duration_ = 7.33

		local var_41_0 = {
			zh = 1.8,
			ja = 7.333
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
				arg_41_0:Play120431011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1076ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1076ui_story == nil then
				arg_41_1.var_.characterEffect1076ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1076ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1076ui_story then
				arg_41_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_44_4 = 0
			local var_44_5 = 0.175

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_6 = arg_41_1:FormatText(StoryNameCfg[389].name)

				arg_41_1.leftNameTxt_.text = var_44_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_7 = arg_41_1:GetWordFromCfg(120431010)
				local var_44_8 = arg_41_1:FormatText(var_44_7.content)

				arg_41_1.text_.text = var_44_8

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 7
				local var_44_10 = utf8.len(var_44_8)
				local var_44_11 = var_44_9 <= 0 and var_44_5 or var_44_5 * (var_44_10 / var_44_9)

				if var_44_11 > 0 and var_44_5 < var_44_11 then
					arg_41_1.talkMaxDuration = var_44_11

					if var_44_11 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_8
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431010", "story_v_out_120431.awb") ~= 0 then
					local var_44_12 = manager.audio:GetVoiceLength("story_v_out_120431", "120431010", "story_v_out_120431.awb") / 1000

					if var_44_12 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_4
					end

					if var_44_7.prefab_name ~= "" and arg_41_1.actors_[var_44_7.prefab_name] ~= nil then
						local var_44_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_7.prefab_name].transform, "story_v_out_120431", "120431010", "story_v_out_120431.awb")

						arg_41_1:RecordAudio("120431010", var_44_13)
						arg_41_1:RecordAudio("120431010", var_44_13)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_120431", "120431010", "story_v_out_120431.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_120431", "120431010", "story_v_out_120431.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_14 and arg_41_1.time_ < var_44_4 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play120431011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 120431011
		arg_45_1.duration_ = 2.2

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play120431012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1084ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1084ui_story == nil then
				arg_45_1.var_.characterEffect1084ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1084ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1084ui_story then
				arg_45_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_48_4 = 0

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_48_5 = arg_45_1.actors_["1076ui_story"]
			local var_48_6 = 0

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.characterEffect1076ui_story == nil then
				arg_45_1.var_.characterEffect1076ui_story = var_48_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_7 = 0.2

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_7 and not isNil(var_48_5) then
				local var_48_8 = (arg_45_1.time_ - var_48_6) / var_48_7

				if arg_45_1.var_.characterEffect1076ui_story and not isNil(var_48_5) then
					local var_48_9 = Mathf.Lerp(0, 0.5, var_48_8)

					arg_45_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1076ui_story.fillRatio = var_48_9
				end
			end

			if arg_45_1.time_ >= var_48_6 + var_48_7 and arg_45_1.time_ < var_48_6 + var_48_7 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.characterEffect1076ui_story then
				local var_48_10 = 0.5

				arg_45_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1076ui_story.fillRatio = var_48_10
			end

			local var_48_11 = 0
			local var_48_12 = 0.05

			if var_48_11 < arg_45_1.time_ and arg_45_1.time_ <= var_48_11 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_13 = arg_45_1:FormatText(StoryNameCfg[401].name)

				arg_45_1.leftNameTxt_.text = var_48_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_14 = arg_45_1:GetWordFromCfg(120431011)
				local var_48_15 = arg_45_1:FormatText(var_48_14.content)

				arg_45_1.text_.text = var_48_15

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_16 = 2
				local var_48_17 = utf8.len(var_48_15)
				local var_48_18 = var_48_16 <= 0 and var_48_12 or var_48_12 * (var_48_17 / var_48_16)

				if var_48_18 > 0 and var_48_12 < var_48_18 then
					arg_45_1.talkMaxDuration = var_48_18

					if var_48_18 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_18 + var_48_11
					end
				end

				arg_45_1.text_.text = var_48_15
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431011", "story_v_out_120431.awb") ~= 0 then
					local var_48_19 = manager.audio:GetVoiceLength("story_v_out_120431", "120431011", "story_v_out_120431.awb") / 1000

					if var_48_19 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_19 + var_48_11
					end

					if var_48_14.prefab_name ~= "" and arg_45_1.actors_[var_48_14.prefab_name] ~= nil then
						local var_48_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_14.prefab_name].transform, "story_v_out_120431", "120431011", "story_v_out_120431.awb")

						arg_45_1:RecordAudio("120431011", var_48_20)
						arg_45_1:RecordAudio("120431011", var_48_20)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_120431", "120431011", "story_v_out_120431.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_120431", "120431011", "story_v_out_120431.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_21 = math.max(var_48_12, arg_45_1.talkMaxDuration)

			if var_48_11 <= arg_45_1.time_ and arg_45_1.time_ < var_48_11 + var_48_21 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_11) / var_48_21

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_11 + var_48_21 and arg_45_1.time_ < var_48_11 + var_48_21 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play120431012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 120431012
		arg_49_1.duration_ = 6.5

		local var_49_0 = {
			zh = 5.466,
			ja = 6.5
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
				arg_49_0:Play120431013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1084ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1084ui_story == nil then
				arg_49_1.var_.characterEffect1084ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1084ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1084ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1084ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1084ui_story.fillRatio = var_52_5
			end

			local var_52_6 = arg_49_1.actors_["1076ui_story"]
			local var_52_7 = 0

			if var_52_7 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect1076ui_story == nil then
				arg_49_1.var_.characterEffect1076ui_story = var_52_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_8 = 0.2

			if var_52_7 <= arg_49_1.time_ and arg_49_1.time_ < var_52_7 + var_52_8 and not isNil(var_52_6) then
				local var_52_9 = (arg_49_1.time_ - var_52_7) / var_52_8

				if arg_49_1.var_.characterEffect1076ui_story and not isNil(var_52_6) then
					arg_49_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_7 + var_52_8 and arg_49_1.time_ < var_52_7 + var_52_8 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect1076ui_story then
				arg_49_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_52_10 = 0
			local var_52_11 = 0.55

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_12 = arg_49_1:FormatText(StoryNameCfg[389].name)

				arg_49_1.leftNameTxt_.text = var_52_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_13 = arg_49_1:GetWordFromCfg(120431012)
				local var_52_14 = arg_49_1:FormatText(var_52_13.content)

				arg_49_1.text_.text = var_52_14

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_15 = 22
				local var_52_16 = utf8.len(var_52_14)
				local var_52_17 = var_52_15 <= 0 and var_52_11 or var_52_11 * (var_52_16 / var_52_15)

				if var_52_17 > 0 and var_52_11 < var_52_17 then
					arg_49_1.talkMaxDuration = var_52_17

					if var_52_17 + var_52_10 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_17 + var_52_10
					end
				end

				arg_49_1.text_.text = var_52_14
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431012", "story_v_out_120431.awb") ~= 0 then
					local var_52_18 = manager.audio:GetVoiceLength("story_v_out_120431", "120431012", "story_v_out_120431.awb") / 1000

					if var_52_18 + var_52_10 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_18 + var_52_10
					end

					if var_52_13.prefab_name ~= "" and arg_49_1.actors_[var_52_13.prefab_name] ~= nil then
						local var_52_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_13.prefab_name].transform, "story_v_out_120431", "120431012", "story_v_out_120431.awb")

						arg_49_1:RecordAudio("120431012", var_52_19)
						arg_49_1:RecordAudio("120431012", var_52_19)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_120431", "120431012", "story_v_out_120431.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_120431", "120431012", "story_v_out_120431.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_20 = math.max(var_52_11, arg_49_1.talkMaxDuration)

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_20 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_10) / var_52_20

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_10 + var_52_20 and arg_49_1.time_ < var_52_10 + var_52_20 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play120431013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 120431013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play120431014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1076ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1076ui_story == nil then
				arg_53_1.var_.characterEffect1076ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1076ui_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1076ui_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1076ui_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1076ui_story.fillRatio = var_56_5
			end

			local var_56_6 = 0
			local var_56_7 = 0.75

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

				local var_56_8 = arg_53_1:GetWordFromCfg(120431013)
				local var_56_9 = arg_53_1:FormatText(var_56_8.content)

				arg_53_1.text_.text = var_56_9

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 30
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
	Play120431014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 120431014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play120431015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.4

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[7].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(120431014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 16
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
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_8 and arg_57_1.time_ < var_60_0 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play120431015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 120431015
		arg_61_1.duration_ = 5.63

		local var_61_0 = {
			zh = 5.633,
			ja = 5.5
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
				arg_61_0:Play120431016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1076ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1076ui_story == nil then
				arg_61_1.var_.characterEffect1076ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1076ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1076ui_story then
				arg_61_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_64_4 = 0
			local var_64_5 = 0.55

			if var_64_4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_6 = arg_61_1:FormatText(StoryNameCfg[389].name)

				arg_61_1.leftNameTxt_.text = var_64_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_7 = arg_61_1:GetWordFromCfg(120431015)
				local var_64_8 = arg_61_1:FormatText(var_64_7.content)

				arg_61_1.text_.text = var_64_8

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 22
				local var_64_10 = utf8.len(var_64_8)
				local var_64_11 = var_64_9 <= 0 and var_64_5 or var_64_5 * (var_64_10 / var_64_9)

				if var_64_11 > 0 and var_64_5 < var_64_11 then
					arg_61_1.talkMaxDuration = var_64_11

					if var_64_11 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_8
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431015", "story_v_out_120431.awb") ~= 0 then
					local var_64_12 = manager.audio:GetVoiceLength("story_v_out_120431", "120431015", "story_v_out_120431.awb") / 1000

					if var_64_12 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_4
					end

					if var_64_7.prefab_name ~= "" and arg_61_1.actors_[var_64_7.prefab_name] ~= nil then
						local var_64_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_7.prefab_name].transform, "story_v_out_120431", "120431015", "story_v_out_120431.awb")

						arg_61_1:RecordAudio("120431015", var_64_13)
						arg_61_1:RecordAudio("120431015", var_64_13)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_120431", "120431015", "story_v_out_120431.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_120431", "120431015", "story_v_out_120431.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_14 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_14 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_14

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_14 and arg_61_1.time_ < var_64_4 + var_64_14 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play120431016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 120431016
		arg_65_1.duration_ = 9

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play120431017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_1 = 2

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_1 then
				local var_68_2 = (arg_65_1.time_ - var_68_0) / var_68_1
				local var_68_3 = Color.New(0, 0, 0)

				var_68_3.a = Mathf.Lerp(0, 1, var_68_2)
				arg_65_1.mask_.color = var_68_3
			end

			if arg_65_1.time_ >= var_68_0 + var_68_1 and arg_65_1.time_ < var_68_0 + var_68_1 + arg_68_0 then
				local var_68_4 = Color.New(0, 0, 0)

				var_68_4.a = 1
				arg_65_1.mask_.color = var_68_4
			end

			local var_68_5 = 2

			if var_68_5 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_6 = 2

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_6 then
				local var_68_7 = (arg_65_1.time_ - var_68_5) / var_68_6
				local var_68_8 = Color.New(0, 0, 0)

				var_68_8.a = Mathf.Lerp(1, 0, var_68_7)
				arg_65_1.mask_.color = var_68_8
			end

			if arg_65_1.time_ >= var_68_5 + var_68_6 and arg_65_1.time_ < var_68_5 + var_68_6 + arg_68_0 then
				local var_68_9 = Color.New(0, 0, 0)
				local var_68_10 = 0

				arg_65_1.mask_.enabled = false
				var_68_9.a = var_68_10
				arg_65_1.mask_.color = var_68_9
			end

			local var_68_11 = arg_65_1.actors_["1084ui_story"].transform
			local var_68_12 = 1.966

			if var_68_12 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.var_.moveOldPos1084ui_story = var_68_11.localPosition
			end

			local var_68_13 = 0.001

			if var_68_12 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_13 then
				local var_68_14 = (arg_65_1.time_ - var_68_12) / var_68_13
				local var_68_15 = Vector3.New(0, 100, 0)

				var_68_11.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1084ui_story, var_68_15, var_68_14)

				local var_68_16 = manager.ui.mainCamera.transform.position - var_68_11.position

				var_68_11.forward = Vector3.New(var_68_16.x, var_68_16.y, var_68_16.z)

				local var_68_17 = var_68_11.localEulerAngles

				var_68_17.z = 0
				var_68_17.x = 0
				var_68_11.localEulerAngles = var_68_17
			end

			if arg_65_1.time_ >= var_68_12 + var_68_13 and arg_65_1.time_ < var_68_12 + var_68_13 + arg_68_0 then
				var_68_11.localPosition = Vector3.New(0, 100, 0)

				local var_68_18 = manager.ui.mainCamera.transform.position - var_68_11.position

				var_68_11.forward = Vector3.New(var_68_18.x, var_68_18.y, var_68_18.z)

				local var_68_19 = var_68_11.localEulerAngles

				var_68_19.z = 0
				var_68_19.x = 0
				var_68_11.localEulerAngles = var_68_19
			end

			local var_68_20 = arg_65_1.actors_["1076ui_story"].transform
			local var_68_21 = 1.966

			if var_68_21 < arg_65_1.time_ and arg_65_1.time_ <= var_68_21 + arg_68_0 then
				arg_65_1.var_.moveOldPos1076ui_story = var_68_20.localPosition
			end

			local var_68_22 = 0.001

			if var_68_21 <= arg_65_1.time_ and arg_65_1.time_ < var_68_21 + var_68_22 then
				local var_68_23 = (arg_65_1.time_ - var_68_21) / var_68_22
				local var_68_24 = Vector3.New(0, 100, 0)

				var_68_20.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1076ui_story, var_68_24, var_68_23)

				local var_68_25 = manager.ui.mainCamera.transform.position - var_68_20.position

				var_68_20.forward = Vector3.New(var_68_25.x, var_68_25.y, var_68_25.z)

				local var_68_26 = var_68_20.localEulerAngles

				var_68_26.z = 0
				var_68_26.x = 0
				var_68_20.localEulerAngles = var_68_26
			end

			if arg_65_1.time_ >= var_68_21 + var_68_22 and arg_65_1.time_ < var_68_21 + var_68_22 + arg_68_0 then
				var_68_20.localPosition = Vector3.New(0, 100, 0)

				local var_68_27 = manager.ui.mainCamera.transform.position - var_68_20.position

				var_68_20.forward = Vector3.New(var_68_27.x, var_68_27.y, var_68_27.z)

				local var_68_28 = var_68_20.localEulerAngles

				var_68_28.z = 0
				var_68_28.x = 0
				var_68_20.localEulerAngles = var_68_28
			end

			if arg_65_1.frameCnt_ <= 1 then
				arg_65_1.dialog_:SetActive(false)
			end

			local var_68_29 = 4
			local var_68_30 = 0.675

			if var_68_29 < arg_65_1.time_ and arg_65_1.time_ <= var_68_29 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_31 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_31:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_32 = arg_65_1:GetWordFromCfg(120431016)
				local var_68_33 = arg_65_1:FormatText(var_68_32.content)

				arg_65_1.text_.text = var_68_33

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_34 = 27
				local var_68_35 = utf8.len(var_68_33)
				local var_68_36 = var_68_34 <= 0 and var_68_30 or var_68_30 * (var_68_35 / var_68_34)

				if var_68_36 > 0 and var_68_30 < var_68_36 then
					arg_65_1.talkMaxDuration = var_68_36
					var_68_29 = var_68_29 + 0.3

					if var_68_36 + var_68_29 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_36 + var_68_29
					end
				end

				arg_65_1.text_.text = var_68_33
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_37 = var_68_29 + 0.3
			local var_68_38 = math.max(var_68_30, arg_65_1.talkMaxDuration)

			if var_68_37 <= arg_65_1.time_ and arg_65_1.time_ < var_68_37 + var_68_38 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_37) / var_68_38

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_37 + var_68_38 and arg_65_1.time_ < var_68_37 + var_68_38 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play120431017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 120431017
		arg_71_1.duration_ = 3.9

		local var_71_0 = {
			zh = 2.666,
			ja = 3.9
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
				arg_71_0:Play120431018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 0.275

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[402].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_3 = arg_71_1:GetWordFromCfg(120431017)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 11
				local var_74_6 = utf8.len(var_74_4)
				local var_74_7 = var_74_5 <= 0 and var_74_1 or var_74_1 * (var_74_6 / var_74_5)

				if var_74_7 > 0 and var_74_1 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_0
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431017", "story_v_out_120431.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431017", "story_v_out_120431.awb") / 1000

					if var_74_8 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_0
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_out_120431", "120431017", "story_v_out_120431.awb")

						arg_71_1:RecordAudio("120431017", var_74_9)
						arg_71_1:RecordAudio("120431017", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_120431", "120431017", "story_v_out_120431.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_120431", "120431017", "story_v_out_120431.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_10 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_10 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_10

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_10 and arg_71_1.time_ < var_74_0 + var_74_10 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play120431018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 120431018
		arg_75_1.duration_ = 2.5

		local var_75_0 = {
			zh = 0.999999999999,
			ja = 2.5
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
				arg_75_0:Play120431019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1076ui_story"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1076ui_story == nil then
				arg_75_1.var_.characterEffect1076ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.2

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect1076ui_story and not isNil(var_78_0) then
					arg_75_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1076ui_story then
				arg_75_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_78_4 = arg_75_1.actors_["1076ui_story"].transform
			local var_78_5 = 0

			if var_78_5 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				arg_75_1.var_.moveOldPos1076ui_story = var_78_4.localPosition
			end

			local var_78_6 = 0.001

			if var_78_5 <= arg_75_1.time_ and arg_75_1.time_ < var_78_5 + var_78_6 then
				local var_78_7 = (arg_75_1.time_ - var_78_5) / var_78_6
				local var_78_8 = Vector3.New(0, -1.06, -6.2)

				var_78_4.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1076ui_story, var_78_8, var_78_7)

				local var_78_9 = manager.ui.mainCamera.transform.position - var_78_4.position

				var_78_4.forward = Vector3.New(var_78_9.x, var_78_9.y, var_78_9.z)

				local var_78_10 = var_78_4.localEulerAngles

				var_78_10.z = 0
				var_78_10.x = 0
				var_78_4.localEulerAngles = var_78_10
			end

			if arg_75_1.time_ >= var_78_5 + var_78_6 and arg_75_1.time_ < var_78_5 + var_78_6 + arg_78_0 then
				var_78_4.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_78_11 = manager.ui.mainCamera.transform.position - var_78_4.position

				var_78_4.forward = Vector3.New(var_78_11.x, var_78_11.y, var_78_11.z)

				local var_78_12 = var_78_4.localEulerAngles

				var_78_12.z = 0
				var_78_12.x = 0
				var_78_4.localEulerAngles = var_78_12
			end

			local var_78_13 = 0
			local var_78_14 = 0.05

			if var_78_13 < arg_75_1.time_ and arg_75_1.time_ <= var_78_13 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_15 = arg_75_1:FormatText(StoryNameCfg[389].name)

				arg_75_1.leftNameTxt_.text = var_78_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_16 = arg_75_1:GetWordFromCfg(120431018)
				local var_78_17 = arg_75_1:FormatText(var_78_16.content)

				arg_75_1.text_.text = var_78_17

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_18 = 2
				local var_78_19 = utf8.len(var_78_17)
				local var_78_20 = var_78_18 <= 0 and var_78_14 or var_78_14 * (var_78_19 / var_78_18)

				if var_78_20 > 0 and var_78_14 < var_78_20 then
					arg_75_1.talkMaxDuration = var_78_20

					if var_78_20 + var_78_13 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_20 + var_78_13
					end
				end

				arg_75_1.text_.text = var_78_17
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431018", "story_v_out_120431.awb") ~= 0 then
					local var_78_21 = manager.audio:GetVoiceLength("story_v_out_120431", "120431018", "story_v_out_120431.awb") / 1000

					if var_78_21 + var_78_13 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_21 + var_78_13
					end

					if var_78_16.prefab_name ~= "" and arg_75_1.actors_[var_78_16.prefab_name] ~= nil then
						local var_78_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_16.prefab_name].transform, "story_v_out_120431", "120431018", "story_v_out_120431.awb")

						arg_75_1:RecordAudio("120431018", var_78_22)
						arg_75_1:RecordAudio("120431018", var_78_22)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_120431", "120431018", "story_v_out_120431.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_120431", "120431018", "story_v_out_120431.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_23 = math.max(var_78_14, arg_75_1.talkMaxDuration)

			if var_78_13 <= arg_75_1.time_ and arg_75_1.time_ < var_78_13 + var_78_23 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_13) / var_78_23

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_13 + var_78_23 and arg_75_1.time_ < var_78_13 + var_78_23 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play120431019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 120431019
		arg_79_1.duration_ = 6.47

		local var_79_0 = {
			zh = 6.166,
			ja = 6.466
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
				arg_79_0:Play120431020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1076ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1076ui_story == nil then
				arg_79_1.var_.characterEffect1076ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.2

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect1076ui_story and not isNil(var_82_0) then
					local var_82_4 = Mathf.Lerp(0, 0.5, var_82_3)

					arg_79_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1076ui_story.fillRatio = var_82_4
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1076ui_story then
				local var_82_5 = 0.5

				arg_79_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1076ui_story.fillRatio = var_82_5
			end

			local var_82_6 = 0
			local var_82_7 = 0.75

			if var_82_6 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_8 = arg_79_1:FormatText(StoryNameCfg[403].name)

				arg_79_1.leftNameTxt_.text = var_82_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_9 = arg_79_1:GetWordFromCfg(120431019)
				local var_82_10 = arg_79_1:FormatText(var_82_9.content)

				arg_79_1.text_.text = var_82_10

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_11 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431019", "story_v_out_120431.awb") ~= 0 then
					local var_82_14 = manager.audio:GetVoiceLength("story_v_out_120431", "120431019", "story_v_out_120431.awb") / 1000

					if var_82_14 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_14 + var_82_6
					end

					if var_82_9.prefab_name ~= "" and arg_79_1.actors_[var_82_9.prefab_name] ~= nil then
						local var_82_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_9.prefab_name].transform, "story_v_out_120431", "120431019", "story_v_out_120431.awb")

						arg_79_1:RecordAudio("120431019", var_82_15)
						arg_79_1:RecordAudio("120431019", var_82_15)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_120431", "120431019", "story_v_out_120431.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_120431", "120431019", "story_v_out_120431.awb")
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
	Play120431020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 120431020
		arg_83_1.duration_ = 10.87

		local var_83_0 = {
			zh = 8.033,
			ja = 10.866
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
				arg_83_0:Play120431021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 1.05

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_2 = arg_83_1:FormatText(StoryNameCfg[402].name)

				arg_83_1.leftNameTxt_.text = var_86_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:GetWordFromCfg(120431020)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 42
				local var_86_6 = utf8.len(var_86_4)
				local var_86_7 = var_86_5 <= 0 and var_86_1 or var_86_1 * (var_86_6 / var_86_5)

				if var_86_7 > 0 and var_86_1 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431020", "story_v_out_120431.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431020", "story_v_out_120431.awb") / 1000

					if var_86_8 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_0
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_120431", "120431020", "story_v_out_120431.awb")

						arg_83_1:RecordAudio("120431020", var_86_9)
						arg_83_1:RecordAudio("120431020", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_120431", "120431020", "story_v_out_120431.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_120431", "120431020", "story_v_out_120431.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_10 and arg_83_1.time_ < var_86_0 + var_86_10 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play120431021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 120431021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play120431022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 0.875

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_2 = arg_87_1:GetWordFromCfg(120431021)
				local var_90_3 = arg_87_1:FormatText(var_90_2.content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 35
				local var_90_5 = utf8.len(var_90_3)
				local var_90_6 = var_90_4 <= 0 and var_90_1 or var_90_1 * (var_90_5 / var_90_4)

				if var_90_6 > 0 and var_90_1 < var_90_6 then
					arg_87_1.talkMaxDuration = var_90_6

					if var_90_6 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_6 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_7 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_7 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_7

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_7 and arg_87_1.time_ < var_90_0 + var_90_7 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play120431022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 120431022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play120431023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 0.75

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_2 = arg_91_1:GetWordFromCfg(120431022)
				local var_94_3 = arg_91_1:FormatText(var_94_2.content)

				arg_91_1.text_.text = var_94_3

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 30
				local var_94_5 = utf8.len(var_94_3)
				local var_94_6 = var_94_4 <= 0 and var_94_1 or var_94_1 * (var_94_5 / var_94_4)

				if var_94_6 > 0 and var_94_1 < var_94_6 then
					arg_91_1.talkMaxDuration = var_94_6

					if var_94_6 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_6 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_3
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_7 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_7 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_7

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_7 and arg_91_1.time_ < var_94_0 + var_94_7 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play120431023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 120431023
		arg_95_1.duration_ = 8.97

		local var_95_0 = {
			zh = 5.7,
			ja = 8.966
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
				arg_95_0:Play120431024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1076ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1076ui_story == nil then
				arg_95_1.var_.characterEffect1076ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.2

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect1076ui_story and not isNil(var_98_0) then
					arg_95_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1076ui_story then
				arg_95_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_98_4 = 0
			local var_98_5 = 0.675

			if var_98_4 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_6 = arg_95_1:FormatText(StoryNameCfg[389].name)

				arg_95_1.leftNameTxt_.text = var_98_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_7 = arg_95_1:GetWordFromCfg(120431023)
				local var_98_8 = arg_95_1:FormatText(var_98_7.content)

				arg_95_1.text_.text = var_98_8

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 27
				local var_98_10 = utf8.len(var_98_8)
				local var_98_11 = var_98_9 <= 0 and var_98_5 or var_98_5 * (var_98_10 / var_98_9)

				if var_98_11 > 0 and var_98_5 < var_98_11 then
					arg_95_1.talkMaxDuration = var_98_11

					if var_98_11 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_11 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_8
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431023", "story_v_out_120431.awb") ~= 0 then
					local var_98_12 = manager.audio:GetVoiceLength("story_v_out_120431", "120431023", "story_v_out_120431.awb") / 1000

					if var_98_12 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_12 + var_98_4
					end

					if var_98_7.prefab_name ~= "" and arg_95_1.actors_[var_98_7.prefab_name] ~= nil then
						local var_98_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_7.prefab_name].transform, "story_v_out_120431", "120431023", "story_v_out_120431.awb")

						arg_95_1:RecordAudio("120431023", var_98_13)
						arg_95_1:RecordAudio("120431023", var_98_13)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_120431", "120431023", "story_v_out_120431.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_120431", "120431023", "story_v_out_120431.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_14 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_14 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_14

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_14 and arg_95_1.time_ < var_98_4 + var_98_14 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play120431024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 120431024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play120431025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1076ui_story"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos1076ui_story = var_102_0.localPosition
			end

			local var_102_2 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2
				local var_102_4 = Vector3.New(0, 100, 0)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1076ui_story, var_102_4, var_102_3)

				local var_102_5 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_5.x, var_102_5.y, var_102_5.z)

				local var_102_6 = var_102_0.localEulerAngles

				var_102_6.z = 0
				var_102_6.x = 0
				var_102_0.localEulerAngles = var_102_6
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(0, 100, 0)

				local var_102_7 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_7.x, var_102_7.y, var_102_7.z)

				local var_102_8 = var_102_0.localEulerAngles

				var_102_8.z = 0
				var_102_8.x = 0
				var_102_0.localEulerAngles = var_102_8
			end

			local var_102_9 = 0
			local var_102_10 = 1.2

			if var_102_9 < arg_99_1.time_ and arg_99_1.time_ <= var_102_9 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_11 = arg_99_1:GetWordFromCfg(120431024)
				local var_102_12 = arg_99_1:FormatText(var_102_11.content)

				arg_99_1.text_.text = var_102_12

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_13 = 48
				local var_102_14 = utf8.len(var_102_12)
				local var_102_15 = var_102_13 <= 0 and var_102_10 or var_102_10 * (var_102_14 / var_102_13)

				if var_102_15 > 0 and var_102_10 < var_102_15 then
					arg_99_1.talkMaxDuration = var_102_15

					if var_102_15 + var_102_9 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_15 + var_102_9
					end
				end

				arg_99_1.text_.text = var_102_12
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_16 = math.max(var_102_10, arg_99_1.talkMaxDuration)

			if var_102_9 <= arg_99_1.time_ and arg_99_1.time_ < var_102_9 + var_102_16 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_9) / var_102_16

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_9 + var_102_16 and arg_99_1.time_ < var_102_9 + var_102_16 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play120431025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 120431025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play120431026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 0.525

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_2 = arg_103_1:GetWordFromCfg(120431025)
				local var_106_3 = arg_103_1:FormatText(var_106_2.content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 21
				local var_106_5 = utf8.len(var_106_3)
				local var_106_6 = var_106_4 <= 0 and var_106_1 or var_106_1 * (var_106_5 / var_106_4)

				if var_106_6 > 0 and var_106_1 < var_106_6 then
					arg_103_1.talkMaxDuration = var_106_6

					if var_106_6 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_6 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_7 and arg_103_1.time_ < var_106_0 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play120431026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 120431026
		arg_107_1.duration_ = 5.47

		local var_107_0 = {
			zh = 4.4,
			ja = 5.466
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
				arg_107_0:Play120431027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1084ui_story"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos1084ui_story = var_110_0.localPosition
			end

			local var_110_2 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2
				local var_110_4 = Vector3.New(-0.7, -0.97, -6)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1084ui_story, var_110_4, var_110_3)

				local var_110_5 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_5.x, var_110_5.y, var_110_5.z)

				local var_110_6 = var_110_0.localEulerAngles

				var_110_6.z = 0
				var_110_6.x = 0
				var_110_0.localEulerAngles = var_110_6
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_110_7 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_7.x, var_110_7.y, var_110_7.z)

				local var_110_8 = var_110_0.localEulerAngles

				var_110_8.z = 0
				var_110_8.x = 0
				var_110_0.localEulerAngles = var_110_8
			end

			local var_110_9 = arg_107_1.actors_["1084ui_story"]
			local var_110_10 = 0

			if var_110_10 < arg_107_1.time_ and arg_107_1.time_ <= var_110_10 + arg_110_0 and not isNil(var_110_9) and arg_107_1.var_.characterEffect1084ui_story == nil then
				arg_107_1.var_.characterEffect1084ui_story = var_110_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_11 = 0.2

			if var_110_10 <= arg_107_1.time_ and arg_107_1.time_ < var_110_10 + var_110_11 and not isNil(var_110_9) then
				local var_110_12 = (arg_107_1.time_ - var_110_10) / var_110_11

				if arg_107_1.var_.characterEffect1084ui_story and not isNil(var_110_9) then
					arg_107_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_10 + var_110_11 and arg_107_1.time_ < var_110_10 + var_110_11 + arg_110_0 and not isNil(var_110_9) and arg_107_1.var_.characterEffect1084ui_story then
				arg_107_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_110_13 = 0

			if var_110_13 < arg_107_1.time_ and arg_107_1.time_ <= var_110_13 + arg_110_0 then
				arg_107_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_110_14 = 0

			if var_110_14 < arg_107_1.time_ and arg_107_1.time_ <= var_110_14 + arg_110_0 then
				arg_107_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_110_15 = 0
			local var_110_16 = 0.425

			if var_110_15 < arg_107_1.time_ and arg_107_1.time_ <= var_110_15 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_17 = arg_107_1:FormatText(StoryNameCfg[6].name)

				arg_107_1.leftNameTxt_.text = var_110_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_18 = arg_107_1:GetWordFromCfg(120431026)
				local var_110_19 = arg_107_1:FormatText(var_110_18.content)

				arg_107_1.text_.text = var_110_19

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_20 = 17
				local var_110_21 = utf8.len(var_110_19)
				local var_110_22 = var_110_20 <= 0 and var_110_16 or var_110_16 * (var_110_21 / var_110_20)

				if var_110_22 > 0 and var_110_16 < var_110_22 then
					arg_107_1.talkMaxDuration = var_110_22

					if var_110_22 + var_110_15 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_22 + var_110_15
					end
				end

				arg_107_1.text_.text = var_110_19
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431026", "story_v_out_120431.awb") ~= 0 then
					local var_110_23 = manager.audio:GetVoiceLength("story_v_out_120431", "120431026", "story_v_out_120431.awb") / 1000

					if var_110_23 + var_110_15 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_23 + var_110_15
					end

					if var_110_18.prefab_name ~= "" and arg_107_1.actors_[var_110_18.prefab_name] ~= nil then
						local var_110_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_18.prefab_name].transform, "story_v_out_120431", "120431026", "story_v_out_120431.awb")

						arg_107_1:RecordAudio("120431026", var_110_24)
						arg_107_1:RecordAudio("120431026", var_110_24)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_120431", "120431026", "story_v_out_120431.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_120431", "120431026", "story_v_out_120431.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_25 = math.max(var_110_16, arg_107_1.talkMaxDuration)

			if var_110_15 <= arg_107_1.time_ and arg_107_1.time_ < var_110_15 + var_110_25 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_15) / var_110_25

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_15 + var_110_25 and arg_107_1.time_ < var_110_15 + var_110_25 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
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

		arg_107_1:InitPlayNodeList()
	end,
	Play120431027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 120431027
		arg_111_1.duration_ = 1.4

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play120431028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1076ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1076ui_story == nil then
				arg_111_1.var_.characterEffect1076ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.2

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect1076ui_story and not isNil(var_114_0) then
					arg_111_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1076ui_story then
				arg_111_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_114_4 = arg_111_1.actors_["1076ui_story"].transform
			local var_114_5 = 0

			if var_114_5 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 then
				arg_111_1.var_.moveOldPos1076ui_story = var_114_4.localPosition
			end

			local var_114_6 = 0.001

			if var_114_5 <= arg_111_1.time_ and arg_111_1.time_ < var_114_5 + var_114_6 then
				local var_114_7 = (arg_111_1.time_ - var_114_5) / var_114_6
				local var_114_8 = Vector3.New(0.7, -1.06, -6.2)

				var_114_4.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1076ui_story, var_114_8, var_114_7)

				local var_114_9 = manager.ui.mainCamera.transform.position - var_114_4.position

				var_114_4.forward = Vector3.New(var_114_9.x, var_114_9.y, var_114_9.z)

				local var_114_10 = var_114_4.localEulerAngles

				var_114_10.z = 0
				var_114_10.x = 0
				var_114_4.localEulerAngles = var_114_10
			end

			if arg_111_1.time_ >= var_114_5 + var_114_6 and arg_111_1.time_ < var_114_5 + var_114_6 + arg_114_0 then
				var_114_4.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_114_11 = manager.ui.mainCamera.transform.position - var_114_4.position

				var_114_4.forward = Vector3.New(var_114_11.x, var_114_11.y, var_114_11.z)

				local var_114_12 = var_114_4.localEulerAngles

				var_114_12.z = 0
				var_114_12.x = 0
				var_114_4.localEulerAngles = var_114_12
			end

			local var_114_13 = arg_111_1.actors_["1084ui_story"]
			local var_114_14 = 0

			if var_114_14 < arg_111_1.time_ and arg_111_1.time_ <= var_114_14 + arg_114_0 and not isNil(var_114_13) and arg_111_1.var_.characterEffect1084ui_story == nil then
				arg_111_1.var_.characterEffect1084ui_story = var_114_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_15 = 0.2

			if var_114_14 <= arg_111_1.time_ and arg_111_1.time_ < var_114_14 + var_114_15 and not isNil(var_114_13) then
				local var_114_16 = (arg_111_1.time_ - var_114_14) / var_114_15

				if arg_111_1.var_.characterEffect1084ui_story and not isNil(var_114_13) then
					local var_114_17 = Mathf.Lerp(0, 0.5, var_114_16)

					arg_111_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1084ui_story.fillRatio = var_114_17
				end
			end

			if arg_111_1.time_ >= var_114_14 + var_114_15 and arg_111_1.time_ < var_114_14 + var_114_15 + arg_114_0 and not isNil(var_114_13) and arg_111_1.var_.characterEffect1084ui_story then
				local var_114_18 = 0.5

				arg_111_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1084ui_story.fillRatio = var_114_18
			end

			local var_114_19 = 0
			local var_114_20 = 0.125

			if var_114_19 < arg_111_1.time_ and arg_111_1.time_ <= var_114_19 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_21 = arg_111_1:FormatText(StoryNameCfg[389].name)

				arg_111_1.leftNameTxt_.text = var_114_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_22 = arg_111_1:GetWordFromCfg(120431027)
				local var_114_23 = arg_111_1:FormatText(var_114_22.content)

				arg_111_1.text_.text = var_114_23

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_24 = 5
				local var_114_25 = utf8.len(var_114_23)
				local var_114_26 = var_114_24 <= 0 and var_114_20 or var_114_20 * (var_114_25 / var_114_24)

				if var_114_26 > 0 and var_114_20 < var_114_26 then
					arg_111_1.talkMaxDuration = var_114_26

					if var_114_26 + var_114_19 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_26 + var_114_19
					end
				end

				arg_111_1.text_.text = var_114_23
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431027", "story_v_out_120431.awb") ~= 0 then
					local var_114_27 = manager.audio:GetVoiceLength("story_v_out_120431", "120431027", "story_v_out_120431.awb") / 1000

					if var_114_27 + var_114_19 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_27 + var_114_19
					end

					if var_114_22.prefab_name ~= "" and arg_111_1.actors_[var_114_22.prefab_name] ~= nil then
						local var_114_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_22.prefab_name].transform, "story_v_out_120431", "120431027", "story_v_out_120431.awb")

						arg_111_1:RecordAudio("120431027", var_114_28)
						arg_111_1:RecordAudio("120431027", var_114_28)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_120431", "120431027", "story_v_out_120431.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_120431", "120431027", "story_v_out_120431.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_29 = math.max(var_114_20, arg_111_1.talkMaxDuration)

			if var_114_19 <= arg_111_1.time_ and arg_111_1.time_ < var_114_19 + var_114_29 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_19) / var_114_29

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_19 + var_114_29 and arg_111_1.time_ < var_114_19 + var_114_29 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play120431028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 120431028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play120431029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1076ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1076ui_story == nil then
				arg_115_1.var_.characterEffect1076ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.2

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1076ui_story and not isNil(var_118_0) then
					local var_118_4 = Mathf.Lerp(0, 0.5, var_118_3)

					arg_115_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1076ui_story.fillRatio = var_118_4
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1076ui_story then
				local var_118_5 = 0.5

				arg_115_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1076ui_story.fillRatio = var_118_5
			end

			local var_118_6 = 0
			local var_118_7 = 0.775

			if var_118_6 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_8 = arg_115_1:GetWordFromCfg(120431028)
				local var_118_9 = arg_115_1:FormatText(var_118_8.content)

				arg_115_1.text_.text = var_118_9

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_10 = 31
				local var_118_11 = utf8.len(var_118_9)
				local var_118_12 = var_118_10 <= 0 and var_118_7 or var_118_7 * (var_118_11 / var_118_10)

				if var_118_12 > 0 and var_118_7 < var_118_12 then
					arg_115_1.talkMaxDuration = var_118_12

					if var_118_12 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_12 + var_118_6
					end
				end

				arg_115_1.text_.text = var_118_9
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_13 = math.max(var_118_7, arg_115_1.talkMaxDuration)

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_13 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_6) / var_118_13

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_6 + var_118_13 and arg_115_1.time_ < var_118_6 + var_118_13 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play120431029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 120431029
		arg_119_1.duration_ = 8.4

		local var_119_0 = {
			zh = 5.366,
			ja = 8.4
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
				arg_119_0:Play120431030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 1

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				local var_122_2 = "stop"
				local var_122_3 = "effect"

				arg_119_1:AudioAction(var_122_2, var_122_3, "se_story_120_04", "se_story_120_04_street_loop", "")
			end

			local var_122_4 = arg_119_1.actors_["1076ui_story"]
			local var_122_5 = 0

			if var_122_5 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 and not isNil(var_122_4) and arg_119_1.var_.characterEffect1076ui_story == nil then
				arg_119_1.var_.characterEffect1076ui_story = var_122_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_6 = 0.2

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_6 and not isNil(var_122_4) then
				local var_122_7 = (arg_119_1.time_ - var_122_5) / var_122_6

				if arg_119_1.var_.characterEffect1076ui_story and not isNil(var_122_4) then
					arg_119_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_5 + var_122_6 and arg_119_1.time_ < var_122_5 + var_122_6 + arg_122_0 and not isNil(var_122_4) and arg_119_1.var_.characterEffect1076ui_story then
				arg_119_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_122_8 = 0
			local var_122_9 = 0.575

			if var_122_8 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_10 = arg_119_1:FormatText(StoryNameCfg[389].name)

				arg_119_1.leftNameTxt_.text = var_122_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_11 = arg_119_1:GetWordFromCfg(120431029)
				local var_122_12 = arg_119_1:FormatText(var_122_11.content)

				arg_119_1.text_.text = var_122_12

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_13 = 23
				local var_122_14 = utf8.len(var_122_12)
				local var_122_15 = var_122_13 <= 0 and var_122_9 or var_122_9 * (var_122_14 / var_122_13)

				if var_122_15 > 0 and var_122_9 < var_122_15 then
					arg_119_1.talkMaxDuration = var_122_15

					if var_122_15 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_15 + var_122_8
					end
				end

				arg_119_1.text_.text = var_122_12
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431029", "story_v_out_120431.awb") ~= 0 then
					local var_122_16 = manager.audio:GetVoiceLength("story_v_out_120431", "120431029", "story_v_out_120431.awb") / 1000

					if var_122_16 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_16 + var_122_8
					end

					if var_122_11.prefab_name ~= "" and arg_119_1.actors_[var_122_11.prefab_name] ~= nil then
						local var_122_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_11.prefab_name].transform, "story_v_out_120431", "120431029", "story_v_out_120431.awb")

						arg_119_1:RecordAudio("120431029", var_122_17)
						arg_119_1:RecordAudio("120431029", var_122_17)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_120431", "120431029", "story_v_out_120431.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_120431", "120431029", "story_v_out_120431.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_18 = math.max(var_122_9, arg_119_1.talkMaxDuration)

			if var_122_8 <= arg_119_1.time_ and arg_119_1.time_ < var_122_8 + var_122_18 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_8) / var_122_18

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_8 + var_122_18 and arg_119_1.time_ < var_122_8 + var_122_18 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play120431030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 120431030
		arg_123_1.duration_ = 7.13

		local var_123_0 = {
			zh = 7.133,
			ja = 6.866
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
				arg_123_0:Play120431031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.475

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_2 = arg_123_1:FormatText(StoryNameCfg[389].name)

				arg_123_1.leftNameTxt_.text = var_126_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:GetWordFromCfg(120431030)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 19
				local var_126_6 = utf8.len(var_126_4)
				local var_126_7 = var_126_5 <= 0 and var_126_1 or var_126_1 * (var_126_6 / var_126_5)

				if var_126_7 > 0 and var_126_1 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431030", "story_v_out_120431.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431030", "story_v_out_120431.awb") / 1000

					if var_126_8 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_0
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_120431", "120431030", "story_v_out_120431.awb")

						arg_123_1:RecordAudio("120431030", var_126_9)
						arg_123_1:RecordAudio("120431030", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_120431", "120431030", "story_v_out_120431.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_120431", "120431030", "story_v_out_120431.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_10 and arg_123_1.time_ < var_126_0 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play120431031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 120431031
		arg_127_1.duration_ = 9

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play120431032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = "ST32a"

			if arg_127_1.bgs_[var_130_0] == nil then
				local var_130_1 = Object.Instantiate(arg_127_1.paintGo_)

				var_130_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_130_0)
				var_130_1.name = var_130_0
				var_130_1.transform.parent = arg_127_1.stage_.transform
				var_130_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.bgs_[var_130_0] = var_130_1
			end

			local var_130_2 = 2

			if var_130_2 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 then
				local var_130_3 = manager.ui.mainCamera.transform.localPosition
				local var_130_4 = Vector3.New(0, 0, 10) + Vector3.New(var_130_3.x, var_130_3.y, 0)
				local var_130_5 = arg_127_1.bgs_.ST32a

				var_130_5.transform.localPosition = var_130_4
				var_130_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_130_6 = var_130_5:GetComponent("SpriteRenderer")

				if var_130_6 and var_130_6.sprite then
					local var_130_7 = (var_130_5.transform.localPosition - var_130_3).z
					local var_130_8 = manager.ui.mainCameraCom_
					local var_130_9 = 2 * var_130_7 * Mathf.Tan(var_130_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_130_10 = var_130_9 * var_130_8.aspect
					local var_130_11 = var_130_6.sprite.bounds.size.x
					local var_130_12 = var_130_6.sprite.bounds.size.y
					local var_130_13 = var_130_10 / var_130_11
					local var_130_14 = var_130_9 / var_130_12
					local var_130_15 = var_130_14 < var_130_13 and var_130_13 or var_130_14

					var_130_5.transform.localScale = Vector3.New(var_130_15, var_130_15, 0)
				end

				for iter_130_0, iter_130_1 in pairs(arg_127_1.bgs_) do
					if iter_130_0 ~= "ST32a" then
						iter_130_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_130_16 = 0

			if var_130_16 < arg_127_1.time_ and arg_127_1.time_ <= var_130_16 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_17 = 2

			if var_130_16 <= arg_127_1.time_ and arg_127_1.time_ < var_130_16 + var_130_17 then
				local var_130_18 = (arg_127_1.time_ - var_130_16) / var_130_17
				local var_130_19 = Color.New(0, 0, 0)

				var_130_19.a = Mathf.Lerp(0, 1, var_130_18)
				arg_127_1.mask_.color = var_130_19
			end

			if arg_127_1.time_ >= var_130_16 + var_130_17 and arg_127_1.time_ < var_130_16 + var_130_17 + arg_130_0 then
				local var_130_20 = Color.New(0, 0, 0)

				var_130_20.a = 1
				arg_127_1.mask_.color = var_130_20
			end

			local var_130_21 = 2

			if var_130_21 < arg_127_1.time_ and arg_127_1.time_ <= var_130_21 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_22 = 2

			if var_130_21 <= arg_127_1.time_ and arg_127_1.time_ < var_130_21 + var_130_22 then
				local var_130_23 = (arg_127_1.time_ - var_130_21) / var_130_22
				local var_130_24 = Color.New(0, 0, 0)

				var_130_24.a = Mathf.Lerp(1, 0, var_130_23)
				arg_127_1.mask_.color = var_130_24
			end

			if arg_127_1.time_ >= var_130_21 + var_130_22 and arg_127_1.time_ < var_130_21 + var_130_22 + arg_130_0 then
				local var_130_25 = Color.New(0, 0, 0)
				local var_130_26 = 0

				arg_127_1.mask_.enabled = false
				var_130_25.a = var_130_26
				arg_127_1.mask_.color = var_130_25
			end

			local var_130_27 = 0
			local var_130_28 = 1

			if var_130_27 < arg_127_1.time_ and arg_127_1.time_ <= var_130_27 + arg_130_0 then
				local var_130_29 = "play"
				local var_130_30 = "effect"

				arg_127_1:AudioAction(var_130_29, var_130_30, "se_story_120_04", "se_story_120_04_hotpot_loop", "")
			end

			local var_130_31 = arg_127_1.actors_["1076ui_story"].transform
			local var_130_32 = 1.966

			if var_130_32 < arg_127_1.time_ and arg_127_1.time_ <= var_130_32 + arg_130_0 then
				arg_127_1.var_.moveOldPos1076ui_story = var_130_31.localPosition
			end

			local var_130_33 = 0.001

			if var_130_32 <= arg_127_1.time_ and arg_127_1.time_ < var_130_32 + var_130_33 then
				local var_130_34 = (arg_127_1.time_ - var_130_32) / var_130_33
				local var_130_35 = Vector3.New(0, 100, 0)

				var_130_31.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1076ui_story, var_130_35, var_130_34)

				local var_130_36 = manager.ui.mainCamera.transform.position - var_130_31.position

				var_130_31.forward = Vector3.New(var_130_36.x, var_130_36.y, var_130_36.z)

				local var_130_37 = var_130_31.localEulerAngles

				var_130_37.z = 0
				var_130_37.x = 0
				var_130_31.localEulerAngles = var_130_37
			end

			if arg_127_1.time_ >= var_130_32 + var_130_33 and arg_127_1.time_ < var_130_32 + var_130_33 + arg_130_0 then
				var_130_31.localPosition = Vector3.New(0, 100, 0)

				local var_130_38 = manager.ui.mainCamera.transform.position - var_130_31.position

				var_130_31.forward = Vector3.New(var_130_38.x, var_130_38.y, var_130_38.z)

				local var_130_39 = var_130_31.localEulerAngles

				var_130_39.z = 0
				var_130_39.x = 0
				var_130_31.localEulerAngles = var_130_39
			end

			local var_130_40 = arg_127_1.actors_["1084ui_story"].transform
			local var_130_41 = 1.966

			if var_130_41 < arg_127_1.time_ and arg_127_1.time_ <= var_130_41 + arg_130_0 then
				arg_127_1.var_.moveOldPos1084ui_story = var_130_40.localPosition
			end

			local var_130_42 = 0.001

			if var_130_41 <= arg_127_1.time_ and arg_127_1.time_ < var_130_41 + var_130_42 then
				local var_130_43 = (arg_127_1.time_ - var_130_41) / var_130_42
				local var_130_44 = Vector3.New(0, 100, 0)

				var_130_40.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1084ui_story, var_130_44, var_130_43)

				local var_130_45 = manager.ui.mainCamera.transform.position - var_130_40.position

				var_130_40.forward = Vector3.New(var_130_45.x, var_130_45.y, var_130_45.z)

				local var_130_46 = var_130_40.localEulerAngles

				var_130_46.z = 0
				var_130_46.x = 0
				var_130_40.localEulerAngles = var_130_46
			end

			if arg_127_1.time_ >= var_130_41 + var_130_42 and arg_127_1.time_ < var_130_41 + var_130_42 + arg_130_0 then
				var_130_40.localPosition = Vector3.New(0, 100, 0)

				local var_130_47 = manager.ui.mainCamera.transform.position - var_130_40.position

				var_130_40.forward = Vector3.New(var_130_47.x, var_130_47.y, var_130_47.z)

				local var_130_48 = var_130_40.localEulerAngles

				var_130_48.z = 0
				var_130_48.x = 0
				var_130_40.localEulerAngles = var_130_48
			end

			if arg_127_1.frameCnt_ <= 1 then
				arg_127_1.dialog_:SetActive(false)
			end

			local var_130_49 = 4
			local var_130_50 = 0.675

			if var_130_49 < arg_127_1.time_ and arg_127_1.time_ <= var_130_49 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				arg_127_1.dialog_:SetActive(true)

				arg_127_1.dialogCg_.alpha = 0

				local var_130_51 = LeanTween.value(arg_127_1.dialog_, 0, 1, 0.3)

				var_130_51:setOnUpdate(LuaHelper.FloatAction(function(arg_131_0)
					arg_127_1.dialogCg_.alpha = arg_131_0
				end))
				var_130_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_127_1.dialog_)
					var_130_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_127_1.duration_ = arg_127_1.duration_ + 0.3

				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_52 = arg_127_1:GetWordFromCfg(120431031)
				local var_130_53 = arg_127_1:FormatText(var_130_52.content)

				arg_127_1.text_.text = var_130_53

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_54 = 27
				local var_130_55 = utf8.len(var_130_53)
				local var_130_56 = var_130_54 <= 0 and var_130_50 or var_130_50 * (var_130_55 / var_130_54)

				if var_130_56 > 0 and var_130_50 < var_130_56 then
					arg_127_1.talkMaxDuration = var_130_56
					var_130_49 = var_130_49 + 0.3

					if var_130_56 + var_130_49 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_56 + var_130_49
					end
				end

				arg_127_1.text_.text = var_130_53
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_57 = var_130_49 + 0.3
			local var_130_58 = math.max(var_130_50, arg_127_1.talkMaxDuration)

			if var_130_57 <= arg_127_1.time_ and arg_127_1.time_ < var_130_57 + var_130_58 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_57) / var_130_58

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_57 + var_130_58 and arg_127_1.time_ < var_130_57 + var_130_58 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play120431032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 120431032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play120431033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 1.025

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_2 = arg_133_1:GetWordFromCfg(120431032)
				local var_136_3 = arg_133_1:FormatText(var_136_2.content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 41
				local var_136_5 = utf8.len(var_136_3)
				local var_136_6 = var_136_4 <= 0 and var_136_1 or var_136_1 * (var_136_5 / var_136_4)

				if var_136_6 > 0 and var_136_1 < var_136_6 then
					arg_133_1.talkMaxDuration = var_136_6

					if var_136_6 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_7 and arg_133_1.time_ < var_136_0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play120431033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 120431033
		arg_137_1.duration_ = 8

		local var_137_0 = {
			zh = 5.6,
			ja = 8
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
				arg_137_0:Play120431034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = "1075ui_story"

			if arg_137_1.actors_[var_140_0] == nil then
				local var_140_1 = Asset.Load("Char/" .. "1075ui_story")

				if not isNil(var_140_1) then
					local var_140_2 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_137_1.stage_.transform)

					var_140_2.name = var_140_0
					var_140_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_137_1.actors_[var_140_0] = var_140_2

					local var_140_3 = var_140_2:GetComponentInChildren(typeof(CharacterEffect))

					var_140_3.enabled = true

					local var_140_4 = GameObjectTools.GetOrAddComponent(var_140_2, typeof(DynamicBoneHelper))

					if var_140_4 then
						var_140_4:EnableDynamicBone(false)
					end

					arg_137_1:ShowWeapon(var_140_3.transform, false)

					arg_137_1.var_[var_140_0 .. "Animator"] = var_140_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_137_1.var_[var_140_0 .. "Animator"].applyRootMotion = true
					arg_137_1.var_[var_140_0 .. "LipSync"] = var_140_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_140_5 = arg_137_1.actors_["1075ui_story"].transform
			local var_140_6 = 0

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.var_.moveOldPos1075ui_story = var_140_5.localPosition
			end

			local var_140_7 = 0.001

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_7 then
				local var_140_8 = (arg_137_1.time_ - var_140_6) / var_140_7
				local var_140_9 = Vector3.New(-0.7, -1.055, -6.16)

				var_140_5.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1075ui_story, var_140_9, var_140_8)

				local var_140_10 = manager.ui.mainCamera.transform.position - var_140_5.position

				var_140_5.forward = Vector3.New(var_140_10.x, var_140_10.y, var_140_10.z)

				local var_140_11 = var_140_5.localEulerAngles

				var_140_11.z = 0
				var_140_11.x = 0
				var_140_5.localEulerAngles = var_140_11
			end

			if arg_137_1.time_ >= var_140_6 + var_140_7 and arg_137_1.time_ < var_140_6 + var_140_7 + arg_140_0 then
				var_140_5.localPosition = Vector3.New(-0.7, -1.055, -6.16)

				local var_140_12 = manager.ui.mainCamera.transform.position - var_140_5.position

				var_140_5.forward = Vector3.New(var_140_12.x, var_140_12.y, var_140_12.z)

				local var_140_13 = var_140_5.localEulerAngles

				var_140_13.z = 0
				var_140_13.x = 0
				var_140_5.localEulerAngles = var_140_13
			end

			local var_140_14 = 0

			if var_140_14 < arg_137_1.time_ and arg_137_1.time_ <= var_140_14 + arg_140_0 then
				arg_137_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_140_15 = 0

			if var_140_15 < arg_137_1.time_ and arg_137_1.time_ <= var_140_15 + arg_140_0 then
				arg_137_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_140_16 = arg_137_1.actors_["1075ui_story"]
			local var_140_17 = 0

			if var_140_17 < arg_137_1.time_ and arg_137_1.time_ <= var_140_17 + arg_140_0 and not isNil(var_140_16) and arg_137_1.var_.characterEffect1075ui_story == nil then
				arg_137_1.var_.characterEffect1075ui_story = var_140_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_18 = 0.2

			if var_140_17 <= arg_137_1.time_ and arg_137_1.time_ < var_140_17 + var_140_18 and not isNil(var_140_16) then
				local var_140_19 = (arg_137_1.time_ - var_140_17) / var_140_18

				if arg_137_1.var_.characterEffect1075ui_story and not isNil(var_140_16) then
					arg_137_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_17 + var_140_18 and arg_137_1.time_ < var_140_17 + var_140_18 + arg_140_0 and not isNil(var_140_16) and arg_137_1.var_.characterEffect1075ui_story then
				arg_137_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_140_20 = 0
			local var_140_21 = 0.725

			if var_140_20 < arg_137_1.time_ and arg_137_1.time_ <= var_140_20 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_22 = arg_137_1:FormatText(StoryNameCfg[381].name)

				arg_137_1.leftNameTxt_.text = var_140_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_23 = arg_137_1:GetWordFromCfg(120431033)
				local var_140_24 = arg_137_1:FormatText(var_140_23.content)

				arg_137_1.text_.text = var_140_24

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_25 = 29
				local var_140_26 = utf8.len(var_140_24)
				local var_140_27 = var_140_25 <= 0 and var_140_21 or var_140_21 * (var_140_26 / var_140_25)

				if var_140_27 > 0 and var_140_21 < var_140_27 then
					arg_137_1.talkMaxDuration = var_140_27

					if var_140_27 + var_140_20 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_27 + var_140_20
					end
				end

				arg_137_1.text_.text = var_140_24
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431033", "story_v_out_120431.awb") ~= 0 then
					local var_140_28 = manager.audio:GetVoiceLength("story_v_out_120431", "120431033", "story_v_out_120431.awb") / 1000

					if var_140_28 + var_140_20 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_28 + var_140_20
					end

					if var_140_23.prefab_name ~= "" and arg_137_1.actors_[var_140_23.prefab_name] ~= nil then
						local var_140_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_23.prefab_name].transform, "story_v_out_120431", "120431033", "story_v_out_120431.awb")

						arg_137_1:RecordAudio("120431033", var_140_29)
						arg_137_1:RecordAudio("120431033", var_140_29)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_120431", "120431033", "story_v_out_120431.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_120431", "120431033", "story_v_out_120431.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_30 = math.max(var_140_21, arg_137_1.talkMaxDuration)

			if var_140_20 <= arg_137_1.time_ and arg_137_1.time_ < var_140_20 + var_140_30 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_20) / var_140_30

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_20 + var_140_30 and arg_137_1.time_ < var_140_20 + var_140_30 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play120431034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 120431034
		arg_141_1.duration_ = 12

		local var_141_0 = {
			zh = 9.6,
			ja = 12
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
				arg_141_0:Play120431035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = "1069ui_story"

			if arg_141_1.actors_[var_144_0] == nil then
				local var_144_1 = Asset.Load("Char/" .. "1069ui_story")

				if not isNil(var_144_1) then
					local var_144_2 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_141_1.stage_.transform)

					var_144_2.name = var_144_0
					var_144_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_141_1.actors_[var_144_0] = var_144_2

					local var_144_3 = var_144_2:GetComponentInChildren(typeof(CharacterEffect))

					var_144_3.enabled = true

					local var_144_4 = GameObjectTools.GetOrAddComponent(var_144_2, typeof(DynamicBoneHelper))

					if var_144_4 then
						var_144_4:EnableDynamicBone(false)
					end

					arg_141_1:ShowWeapon(var_144_3.transform, false)

					arg_141_1.var_[var_144_0 .. "Animator"] = var_144_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_141_1.var_[var_144_0 .. "Animator"].applyRootMotion = true
					arg_141_1.var_[var_144_0 .. "LipSync"] = var_144_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_144_5 = arg_141_1.actors_["1069ui_story"].transform
			local var_144_6 = 0

			if var_144_6 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.var_.moveOldPos1069ui_story = var_144_5.localPosition
			end

			local var_144_7 = 0.001

			if var_144_6 <= arg_141_1.time_ and arg_141_1.time_ < var_144_6 + var_144_7 then
				local var_144_8 = (arg_141_1.time_ - var_144_6) / var_144_7
				local var_144_9 = Vector3.New(0.7, -1, -6)

				var_144_5.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1069ui_story, var_144_9, var_144_8)

				local var_144_10 = manager.ui.mainCamera.transform.position - var_144_5.position

				var_144_5.forward = Vector3.New(var_144_10.x, var_144_10.y, var_144_10.z)

				local var_144_11 = var_144_5.localEulerAngles

				var_144_11.z = 0
				var_144_11.x = 0
				var_144_5.localEulerAngles = var_144_11
			end

			if arg_141_1.time_ >= var_144_6 + var_144_7 and arg_141_1.time_ < var_144_6 + var_144_7 + arg_144_0 then
				var_144_5.localPosition = Vector3.New(0.7, -1, -6)

				local var_144_12 = manager.ui.mainCamera.transform.position - var_144_5.position

				var_144_5.forward = Vector3.New(var_144_12.x, var_144_12.y, var_144_12.z)

				local var_144_13 = var_144_5.localEulerAngles

				var_144_13.z = 0
				var_144_13.x = 0
				var_144_5.localEulerAngles = var_144_13
			end

			local var_144_14 = arg_141_1.actors_["1075ui_story"]
			local var_144_15 = 0

			if var_144_15 < arg_141_1.time_ and arg_141_1.time_ <= var_144_15 + arg_144_0 and not isNil(var_144_14) and arg_141_1.var_.characterEffect1075ui_story == nil then
				arg_141_1.var_.characterEffect1075ui_story = var_144_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_16 = 0.2

			if var_144_15 <= arg_141_1.time_ and arg_141_1.time_ < var_144_15 + var_144_16 and not isNil(var_144_14) then
				local var_144_17 = (arg_141_1.time_ - var_144_15) / var_144_16

				if arg_141_1.var_.characterEffect1075ui_story and not isNil(var_144_14) then
					local var_144_18 = Mathf.Lerp(0, 0.5, var_144_17)

					arg_141_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1075ui_story.fillRatio = var_144_18
				end
			end

			if arg_141_1.time_ >= var_144_15 + var_144_16 and arg_141_1.time_ < var_144_15 + var_144_16 + arg_144_0 and not isNil(var_144_14) and arg_141_1.var_.characterEffect1075ui_story then
				local var_144_19 = 0.5

				arg_141_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1075ui_story.fillRatio = var_144_19
			end

			local var_144_20 = arg_141_1.actors_["1069ui_story"]
			local var_144_21 = 0

			if var_144_21 < arg_141_1.time_ and arg_141_1.time_ <= var_144_21 + arg_144_0 and not isNil(var_144_20) and arg_141_1.var_.characterEffect1069ui_story == nil then
				arg_141_1.var_.characterEffect1069ui_story = var_144_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_22 = 0.2

			if var_144_21 <= arg_141_1.time_ and arg_141_1.time_ < var_144_21 + var_144_22 and not isNil(var_144_20) then
				local var_144_23 = (arg_141_1.time_ - var_144_21) / var_144_22

				if arg_141_1.var_.characterEffect1069ui_story and not isNil(var_144_20) then
					arg_141_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_21 + var_144_22 and arg_141_1.time_ < var_144_21 + var_144_22 + arg_144_0 and not isNil(var_144_20) and arg_141_1.var_.characterEffect1069ui_story then
				arg_141_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_144_24 = 0

			if var_144_24 < arg_141_1.time_ and arg_141_1.time_ <= var_144_24 + arg_144_0 then
				arg_141_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action4_1")
			end

			local var_144_25 = 0

			if var_144_25 < arg_141_1.time_ and arg_141_1.time_ <= var_144_25 + arg_144_0 then
				arg_141_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_144_26 = 0
			local var_144_27 = 1.1

			if var_144_26 < arg_141_1.time_ and arg_141_1.time_ <= var_144_26 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_28 = arg_141_1:FormatText(StoryNameCfg[378].name)

				arg_141_1.leftNameTxt_.text = var_144_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_29 = arg_141_1:GetWordFromCfg(120431034)
				local var_144_30 = arg_141_1:FormatText(var_144_29.content)

				arg_141_1.text_.text = var_144_30

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_31 = 44
				local var_144_32 = utf8.len(var_144_30)
				local var_144_33 = var_144_31 <= 0 and var_144_27 or var_144_27 * (var_144_32 / var_144_31)

				if var_144_33 > 0 and var_144_27 < var_144_33 then
					arg_141_1.talkMaxDuration = var_144_33

					if var_144_33 + var_144_26 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_33 + var_144_26
					end
				end

				arg_141_1.text_.text = var_144_30
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431034", "story_v_out_120431.awb") ~= 0 then
					local var_144_34 = manager.audio:GetVoiceLength("story_v_out_120431", "120431034", "story_v_out_120431.awb") / 1000

					if var_144_34 + var_144_26 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_34 + var_144_26
					end

					if var_144_29.prefab_name ~= "" and arg_141_1.actors_[var_144_29.prefab_name] ~= nil then
						local var_144_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_29.prefab_name].transform, "story_v_out_120431", "120431034", "story_v_out_120431.awb")

						arg_141_1:RecordAudio("120431034", var_144_35)
						arg_141_1:RecordAudio("120431034", var_144_35)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_120431", "120431034", "story_v_out_120431.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_120431", "120431034", "story_v_out_120431.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_36 = math.max(var_144_27, arg_141_1.talkMaxDuration)

			if var_144_26 <= arg_141_1.time_ and arg_141_1.time_ < var_144_26 + var_144_36 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_26) / var_144_36

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_26 + var_144_36 and arg_141_1.time_ < var_144_26 + var_144_36 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play120431035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 120431035
		arg_145_1.duration_ = 1.8

		local var_145_0 = {
			zh = 1.766,
			ja = 1.8
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
				arg_145_0:Play120431036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1069ui_story"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1069ui_story == nil then
				arg_145_1.var_.characterEffect1069ui_story = var_148_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.2

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.characterEffect1069ui_story and not isNil(var_148_0) then
					local var_148_4 = Mathf.Lerp(0, 0.5, var_148_3)

					arg_145_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1069ui_story.fillRatio = var_148_4
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1069ui_story then
				local var_148_5 = 0.5

				arg_145_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1069ui_story.fillRatio = var_148_5
			end

			local var_148_6 = arg_145_1.actors_["1075ui_story"]
			local var_148_7 = 0

			if var_148_7 < arg_145_1.time_ and arg_145_1.time_ <= var_148_7 + arg_148_0 and not isNil(var_148_6) and arg_145_1.var_.characterEffect1075ui_story == nil then
				arg_145_1.var_.characterEffect1075ui_story = var_148_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_8 = 0.2

			if var_148_7 <= arg_145_1.time_ and arg_145_1.time_ < var_148_7 + var_148_8 and not isNil(var_148_6) then
				local var_148_9 = (arg_145_1.time_ - var_148_7) / var_148_8

				if arg_145_1.var_.characterEffect1075ui_story and not isNil(var_148_6) then
					arg_145_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_7 + var_148_8 and arg_145_1.time_ < var_148_7 + var_148_8 + arg_148_0 and not isNil(var_148_6) and arg_145_1.var_.characterEffect1075ui_story then
				arg_145_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_148_10 = 0
			local var_148_11 = 0.15

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_12 = arg_145_1:FormatText(StoryNameCfg[381].name)

				arg_145_1.leftNameTxt_.text = var_148_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_13 = arg_145_1:GetWordFromCfg(120431035)
				local var_148_14 = arg_145_1:FormatText(var_148_13.content)

				arg_145_1.text_.text = var_148_14

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_15 = 6
				local var_148_16 = utf8.len(var_148_14)
				local var_148_17 = var_148_15 <= 0 and var_148_11 or var_148_11 * (var_148_16 / var_148_15)

				if var_148_17 > 0 and var_148_11 < var_148_17 then
					arg_145_1.talkMaxDuration = var_148_17

					if var_148_17 + var_148_10 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_17 + var_148_10
					end
				end

				arg_145_1.text_.text = var_148_14
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431035", "story_v_out_120431.awb") ~= 0 then
					local var_148_18 = manager.audio:GetVoiceLength("story_v_out_120431", "120431035", "story_v_out_120431.awb") / 1000

					if var_148_18 + var_148_10 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_18 + var_148_10
					end

					if var_148_13.prefab_name ~= "" and arg_145_1.actors_[var_148_13.prefab_name] ~= nil then
						local var_148_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_13.prefab_name].transform, "story_v_out_120431", "120431035", "story_v_out_120431.awb")

						arg_145_1:RecordAudio("120431035", var_148_19)
						arg_145_1:RecordAudio("120431035", var_148_19)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_120431", "120431035", "story_v_out_120431.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_120431", "120431035", "story_v_out_120431.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_20 = math.max(var_148_11, arg_145_1.talkMaxDuration)

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_20 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_10) / var_148_20

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_10 + var_148_20 and arg_145_1.time_ < var_148_10 + var_148_20 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play120431036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 120431036
		arg_149_1.duration_ = 6.9

		local var_149_0 = {
			zh = 4.966,
			ja = 6.9
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
				arg_149_0:Play120431037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1069ui_story"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1069ui_story == nil then
				arg_149_1.var_.characterEffect1069ui_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.2

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.characterEffect1069ui_story and not isNil(var_152_0) then
					arg_149_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1069ui_story then
				arg_149_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_152_4 = arg_149_1.actors_["1075ui_story"]
			local var_152_5 = 0

			if var_152_5 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect1075ui_story == nil then
				arg_149_1.var_.characterEffect1075ui_story = var_152_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_6 = 0.2

			if var_152_5 <= arg_149_1.time_ and arg_149_1.time_ < var_152_5 + var_152_6 and not isNil(var_152_4) then
				local var_152_7 = (arg_149_1.time_ - var_152_5) / var_152_6

				if arg_149_1.var_.characterEffect1075ui_story and not isNil(var_152_4) then
					local var_152_8 = Mathf.Lerp(0, 0.5, var_152_7)

					arg_149_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1075ui_story.fillRatio = var_152_8
				end
			end

			if arg_149_1.time_ >= var_152_5 + var_152_6 and arg_149_1.time_ < var_152_5 + var_152_6 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect1075ui_story then
				local var_152_9 = 0.5

				arg_149_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1075ui_story.fillRatio = var_152_9
			end

			local var_152_10 = 0
			local var_152_11 = 0.575

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_12 = arg_149_1:FormatText(StoryNameCfg[378].name)

				arg_149_1.leftNameTxt_.text = var_152_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_13 = arg_149_1:GetWordFromCfg(120431036)
				local var_152_14 = arg_149_1:FormatText(var_152_13.content)

				arg_149_1.text_.text = var_152_14

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_15 = 22
				local var_152_16 = utf8.len(var_152_14)
				local var_152_17 = var_152_15 <= 0 and var_152_11 or var_152_11 * (var_152_16 / var_152_15)

				if var_152_17 > 0 and var_152_11 < var_152_17 then
					arg_149_1.talkMaxDuration = var_152_17

					if var_152_17 + var_152_10 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_17 + var_152_10
					end
				end

				arg_149_1.text_.text = var_152_14
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431036", "story_v_out_120431.awb") ~= 0 then
					local var_152_18 = manager.audio:GetVoiceLength("story_v_out_120431", "120431036", "story_v_out_120431.awb") / 1000

					if var_152_18 + var_152_10 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_18 + var_152_10
					end

					if var_152_13.prefab_name ~= "" and arg_149_1.actors_[var_152_13.prefab_name] ~= nil then
						local var_152_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_13.prefab_name].transform, "story_v_out_120431", "120431036", "story_v_out_120431.awb")

						arg_149_1:RecordAudio("120431036", var_152_19)
						arg_149_1:RecordAudio("120431036", var_152_19)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_120431", "120431036", "story_v_out_120431.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_120431", "120431036", "story_v_out_120431.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_20 = math.max(var_152_11, arg_149_1.talkMaxDuration)

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_20 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_10) / var_152_20

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_10 + var_152_20 and arg_149_1.time_ < var_152_10 + var_152_20 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play120431037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 120431037
		arg_153_1.duration_ = 5.2

		local var_153_0 = {
			zh = 5.2,
			ja = 4.133
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
				arg_153_0:Play120431038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 1.025

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[378].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:GetWordFromCfg(120431037)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 41
				local var_156_6 = utf8.len(var_156_4)
				local var_156_7 = var_156_5 <= 0 and var_156_1 or var_156_1 * (var_156_6 / var_156_5)

				if var_156_7 > 0 and var_156_1 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431037", "story_v_out_120431.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431037", "story_v_out_120431.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_120431", "120431037", "story_v_out_120431.awb")

						arg_153_1:RecordAudio("120431037", var_156_9)
						arg_153_1:RecordAudio("120431037", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_120431", "120431037", "story_v_out_120431.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_120431", "120431037", "story_v_out_120431.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_10 and arg_153_1.time_ < var_156_0 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play120431038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 120431038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play120431039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1069ui_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1069ui_story == nil then
				arg_157_1.var_.characterEffect1069ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.2

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect1069ui_story and not isNil(var_160_0) then
					local var_160_4 = Mathf.Lerp(0, 0.5, var_160_3)

					arg_157_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1069ui_story.fillRatio = var_160_4
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1069ui_story then
				local var_160_5 = 0.5

				arg_157_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1069ui_story.fillRatio = var_160_5
			end

			local var_160_6 = 0
			local var_160_7 = 0.125

			if var_160_6 < arg_157_1.time_ and arg_157_1.time_ <= var_160_6 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_8 = arg_157_1:FormatText(StoryNameCfg[7].name)

				arg_157_1.leftNameTxt_.text = var_160_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_9 = arg_157_1:GetWordFromCfg(120431038)
				local var_160_10 = arg_157_1:FormatText(var_160_9.content)

				arg_157_1.text_.text = var_160_10

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_11 = 5
				local var_160_12 = utf8.len(var_160_10)
				local var_160_13 = var_160_11 <= 0 and var_160_7 or var_160_7 * (var_160_12 / var_160_11)

				if var_160_13 > 0 and var_160_7 < var_160_13 then
					arg_157_1.talkMaxDuration = var_160_13

					if var_160_13 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_13 + var_160_6
					end
				end

				arg_157_1.text_.text = var_160_10
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_14 = math.max(var_160_7, arg_157_1.talkMaxDuration)

			if var_160_6 <= arg_157_1.time_ and arg_157_1.time_ < var_160_6 + var_160_14 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_6) / var_160_14

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_6 + var_160_14 and arg_157_1.time_ < var_160_6 + var_160_14 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play120431039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 120431039
		arg_161_1.duration_ = 7

		local var_161_0 = {
			zh = 3.8,
			ja = 7
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
				arg_161_0:Play120431040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1069ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1069ui_story == nil then
				arg_161_1.var_.characterEffect1069ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.2

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect1069ui_story and not isNil(var_164_0) then
					arg_161_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1069ui_story then
				arg_161_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_164_4 = 0
			local var_164_5 = 0.5

			if var_164_4 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_6 = arg_161_1:FormatText(StoryNameCfg[378].name)

				arg_161_1.leftNameTxt_.text = var_164_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_7 = arg_161_1:GetWordFromCfg(120431039)
				local var_164_8 = arg_161_1:FormatText(var_164_7.content)

				arg_161_1.text_.text = var_164_8

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_9 = 20
				local var_164_10 = utf8.len(var_164_8)
				local var_164_11 = var_164_9 <= 0 and var_164_5 or var_164_5 * (var_164_10 / var_164_9)

				if var_164_11 > 0 and var_164_5 < var_164_11 then
					arg_161_1.talkMaxDuration = var_164_11

					if var_164_11 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_11 + var_164_4
					end
				end

				arg_161_1.text_.text = var_164_8
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431039", "story_v_out_120431.awb") ~= 0 then
					local var_164_12 = manager.audio:GetVoiceLength("story_v_out_120431", "120431039", "story_v_out_120431.awb") / 1000

					if var_164_12 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_12 + var_164_4
					end

					if var_164_7.prefab_name ~= "" and arg_161_1.actors_[var_164_7.prefab_name] ~= nil then
						local var_164_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_7.prefab_name].transform, "story_v_out_120431", "120431039", "story_v_out_120431.awb")

						arg_161_1:RecordAudio("120431039", var_164_13)
						arg_161_1:RecordAudio("120431039", var_164_13)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_120431", "120431039", "story_v_out_120431.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_120431", "120431039", "story_v_out_120431.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_14 = math.max(var_164_5, arg_161_1.talkMaxDuration)

			if var_164_4 <= arg_161_1.time_ and arg_161_1.time_ < var_164_4 + var_164_14 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_4) / var_164_14

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_4 + var_164_14 and arg_161_1.time_ < var_164_4 + var_164_14 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play120431040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 120431040
		arg_165_1.duration_ = 9.5

		local var_165_0 = {
			zh = 7.233,
			ja = 9.5
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
				arg_165_0:Play120431041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.875

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[378].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:GetWordFromCfg(120431040)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 35
				local var_168_6 = utf8.len(var_168_4)
				local var_168_7 = var_168_5 <= 0 and var_168_1 or var_168_1 * (var_168_6 / var_168_5)

				if var_168_7 > 0 and var_168_1 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431040", "story_v_out_120431.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431040", "story_v_out_120431.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_120431", "120431040", "story_v_out_120431.awb")

						arg_165_1:RecordAudio("120431040", var_168_9)
						arg_165_1:RecordAudio("120431040", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_120431", "120431040", "story_v_out_120431.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_120431", "120431040", "story_v_out_120431.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_10 and arg_165_1.time_ < var_168_0 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play120431041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 120431041
		arg_169_1.duration_ = 5.57

		local var_169_0 = {
			zh = 4.833,
			ja = 5.566
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
				arg_169_0:Play120431042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1069ui_story"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1069ui_story == nil then
				arg_169_1.var_.characterEffect1069ui_story = var_172_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.2

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.characterEffect1069ui_story and not isNil(var_172_0) then
					local var_172_4 = Mathf.Lerp(0, 0.5, var_172_3)

					arg_169_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1069ui_story.fillRatio = var_172_4
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1069ui_story then
				local var_172_5 = 0.5

				arg_169_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1069ui_story.fillRatio = var_172_5
			end

			local var_172_6 = arg_169_1.actors_["1075ui_story"]
			local var_172_7 = 0

			if var_172_7 < arg_169_1.time_ and arg_169_1.time_ <= var_172_7 + arg_172_0 and not isNil(var_172_6) and arg_169_1.var_.characterEffect1075ui_story == nil then
				arg_169_1.var_.characterEffect1075ui_story = var_172_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_8 = 0.2

			if var_172_7 <= arg_169_1.time_ and arg_169_1.time_ < var_172_7 + var_172_8 and not isNil(var_172_6) then
				local var_172_9 = (arg_169_1.time_ - var_172_7) / var_172_8

				if arg_169_1.var_.characterEffect1075ui_story and not isNil(var_172_6) then
					arg_169_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_7 + var_172_8 and arg_169_1.time_ < var_172_7 + var_172_8 + arg_172_0 and not isNil(var_172_6) and arg_169_1.var_.characterEffect1075ui_story then
				arg_169_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_172_10 = 0

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 then
				arg_169_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_172_11 = 0

			if var_172_11 < arg_169_1.time_ and arg_169_1.time_ <= var_172_11 + arg_172_0 then
				arg_169_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_172_12 = 0
			local var_172_13 = 0.6

			if var_172_12 < arg_169_1.time_ and arg_169_1.time_ <= var_172_12 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_14 = arg_169_1:FormatText(StoryNameCfg[381].name)

				arg_169_1.leftNameTxt_.text = var_172_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_15 = arg_169_1:GetWordFromCfg(120431041)
				local var_172_16 = arg_169_1:FormatText(var_172_15.content)

				arg_169_1.text_.text = var_172_16

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_17 = 24
				local var_172_18 = utf8.len(var_172_16)
				local var_172_19 = var_172_17 <= 0 and var_172_13 or var_172_13 * (var_172_18 / var_172_17)

				if var_172_19 > 0 and var_172_13 < var_172_19 then
					arg_169_1.talkMaxDuration = var_172_19

					if var_172_19 + var_172_12 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_19 + var_172_12
					end
				end

				arg_169_1.text_.text = var_172_16
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431041", "story_v_out_120431.awb") ~= 0 then
					local var_172_20 = manager.audio:GetVoiceLength("story_v_out_120431", "120431041", "story_v_out_120431.awb") / 1000

					if var_172_20 + var_172_12 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_20 + var_172_12
					end

					if var_172_15.prefab_name ~= "" and arg_169_1.actors_[var_172_15.prefab_name] ~= nil then
						local var_172_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_15.prefab_name].transform, "story_v_out_120431", "120431041", "story_v_out_120431.awb")

						arg_169_1:RecordAudio("120431041", var_172_21)
						arg_169_1:RecordAudio("120431041", var_172_21)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_120431", "120431041", "story_v_out_120431.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_120431", "120431041", "story_v_out_120431.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_22 = math.max(var_172_13, arg_169_1.talkMaxDuration)

			if var_172_12 <= arg_169_1.time_ and arg_169_1.time_ < var_172_12 + var_172_22 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_12) / var_172_22

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_12 + var_172_22 and arg_169_1.time_ < var_172_12 + var_172_22 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play120431042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 120431042
		arg_173_1.duration_ = 13.5

		local var_173_0 = {
			zh = 7.066,
			ja = 13.5
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
				arg_173_0:Play120431043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_176_2 = 0
			local var_176_3 = 0.925

			if var_176_2 < arg_173_1.time_ and arg_173_1.time_ <= var_176_2 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_4 = arg_173_1:FormatText(StoryNameCfg[381].name)

				arg_173_1.leftNameTxt_.text = var_176_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_5 = arg_173_1:GetWordFromCfg(120431042)
				local var_176_6 = arg_173_1:FormatText(var_176_5.content)

				arg_173_1.text_.text = var_176_6

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_7 = 37
				local var_176_8 = utf8.len(var_176_6)
				local var_176_9 = var_176_7 <= 0 and var_176_3 or var_176_3 * (var_176_8 / var_176_7)

				if var_176_9 > 0 and var_176_3 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_2
					end
				end

				arg_173_1.text_.text = var_176_6
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431042", "story_v_out_120431.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_120431", "120431042", "story_v_out_120431.awb") / 1000

					if var_176_10 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_2
					end

					if var_176_5.prefab_name ~= "" and arg_173_1.actors_[var_176_5.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_5.prefab_name].transform, "story_v_out_120431", "120431042", "story_v_out_120431.awb")

						arg_173_1:RecordAudio("120431042", var_176_11)
						arg_173_1:RecordAudio("120431042", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_120431", "120431042", "story_v_out_120431.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_120431", "120431042", "story_v_out_120431.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_3, arg_173_1.talkMaxDuration)

			if var_176_2 <= arg_173_1.time_ and arg_173_1.time_ < var_176_2 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_2) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_2 + var_176_12 and arg_173_1.time_ < var_176_2 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play120431043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 120431043
		arg_177_1.duration_ = 8.23

		local var_177_0 = {
			zh = 5.066,
			ja = 8.233
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
				arg_177_0:Play120431044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1075ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1075ui_story == nil then
				arg_177_1.var_.characterEffect1075ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.2

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect1075ui_story and not isNil(var_180_0) then
					local var_180_4 = Mathf.Lerp(0, 0.5, var_180_3)

					arg_177_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1075ui_story.fillRatio = var_180_4
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1075ui_story then
				local var_180_5 = 0.5

				arg_177_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1075ui_story.fillRatio = var_180_5
			end

			local var_180_6 = arg_177_1.actors_["1069ui_story"]
			local var_180_7 = 0

			if var_180_7 < arg_177_1.time_ and arg_177_1.time_ <= var_180_7 + arg_180_0 and not isNil(var_180_6) and arg_177_1.var_.characterEffect1069ui_story == nil then
				arg_177_1.var_.characterEffect1069ui_story = var_180_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_8 = 0.2

			if var_180_7 <= arg_177_1.time_ and arg_177_1.time_ < var_180_7 + var_180_8 and not isNil(var_180_6) then
				local var_180_9 = (arg_177_1.time_ - var_180_7) / var_180_8

				if arg_177_1.var_.characterEffect1069ui_story and not isNil(var_180_6) then
					arg_177_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_7 + var_180_8 and arg_177_1.time_ < var_180_7 + var_180_8 + arg_180_0 and not isNil(var_180_6) and arg_177_1.var_.characterEffect1069ui_story then
				arg_177_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_180_10 = 0

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 then
				arg_177_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069actionlink/1069action442")
			end

			local var_180_11 = 0

			if var_180_11 < arg_177_1.time_ and arg_177_1.time_ <= var_180_11 + arg_180_0 then
				arg_177_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_180_12 = 0
			local var_180_13 = 0.65

			if var_180_12 < arg_177_1.time_ and arg_177_1.time_ <= var_180_12 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_14 = arg_177_1:FormatText(StoryNameCfg[378].name)

				arg_177_1.leftNameTxt_.text = var_180_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_15 = arg_177_1:GetWordFromCfg(120431043)
				local var_180_16 = arg_177_1:FormatText(var_180_15.content)

				arg_177_1.text_.text = var_180_16

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_17 = 26
				local var_180_18 = utf8.len(var_180_16)
				local var_180_19 = var_180_17 <= 0 and var_180_13 or var_180_13 * (var_180_18 / var_180_17)

				if var_180_19 > 0 and var_180_13 < var_180_19 then
					arg_177_1.talkMaxDuration = var_180_19

					if var_180_19 + var_180_12 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_19 + var_180_12
					end
				end

				arg_177_1.text_.text = var_180_16
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431043", "story_v_out_120431.awb") ~= 0 then
					local var_180_20 = manager.audio:GetVoiceLength("story_v_out_120431", "120431043", "story_v_out_120431.awb") / 1000

					if var_180_20 + var_180_12 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_20 + var_180_12
					end

					if var_180_15.prefab_name ~= "" and arg_177_1.actors_[var_180_15.prefab_name] ~= nil then
						local var_180_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_15.prefab_name].transform, "story_v_out_120431", "120431043", "story_v_out_120431.awb")

						arg_177_1:RecordAudio("120431043", var_180_21)
						arg_177_1:RecordAudio("120431043", var_180_21)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_120431", "120431043", "story_v_out_120431.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_120431", "120431043", "story_v_out_120431.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_22 = math.max(var_180_13, arg_177_1.talkMaxDuration)

			if var_180_12 <= arg_177_1.time_ and arg_177_1.time_ < var_180_12 + var_180_22 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_12) / var_180_22

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_12 + var_180_22 and arg_177_1.time_ < var_180_12 + var_180_22 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play120431044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 120431044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play120431045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1069ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1069ui_story == nil then
				arg_181_1.var_.characterEffect1069ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.2

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect1069ui_story and not isNil(var_184_0) then
					local var_184_4 = Mathf.Lerp(0, 0.5, var_184_3)

					arg_181_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1069ui_story.fillRatio = var_184_4
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1069ui_story then
				local var_184_5 = 0.5

				arg_181_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1069ui_story.fillRatio = var_184_5
			end

			local var_184_6 = 0
			local var_184_7 = 0.325

			if var_184_6 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_8 = arg_181_1:FormatText(StoryNameCfg[7].name)

				arg_181_1.leftNameTxt_.text = var_184_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_9 = arg_181_1:GetWordFromCfg(120431044)
				local var_184_10 = arg_181_1:FormatText(var_184_9.content)

				arg_181_1.text_.text = var_184_10

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_11 = 13
				local var_184_12 = utf8.len(var_184_10)
				local var_184_13 = var_184_11 <= 0 and var_184_7 or var_184_7 * (var_184_12 / var_184_11)

				if var_184_13 > 0 and var_184_7 < var_184_13 then
					arg_181_1.talkMaxDuration = var_184_13

					if var_184_13 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_10
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_14 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_14 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_14

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_14 and arg_181_1.time_ < var_184_6 + var_184_14 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play120431045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 120431045
		arg_185_1.duration_ = 5.57

		local var_185_0 = {
			zh = 2.966,
			ja = 5.566
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play120431046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1069ui_story"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1069ui_story == nil then
				arg_185_1.var_.characterEffect1069ui_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.2

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.characterEffect1069ui_story and not isNil(var_188_0) then
					arg_185_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1069ui_story then
				arg_185_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_188_4 = 0
			local var_188_5 = 0.375

			if var_188_4 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_6 = arg_185_1:FormatText(StoryNameCfg[378].name)

				arg_185_1.leftNameTxt_.text = var_188_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_7 = arg_185_1:GetWordFromCfg(120431045)
				local var_188_8 = arg_185_1:FormatText(var_188_7.content)

				arg_185_1.text_.text = var_188_8

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_9 = 15
				local var_188_10 = utf8.len(var_188_8)
				local var_188_11 = var_188_9 <= 0 and var_188_5 or var_188_5 * (var_188_10 / var_188_9)

				if var_188_11 > 0 and var_188_5 < var_188_11 then
					arg_185_1.talkMaxDuration = var_188_11

					if var_188_11 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_11 + var_188_4
					end
				end

				arg_185_1.text_.text = var_188_8
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431045", "story_v_out_120431.awb") ~= 0 then
					local var_188_12 = manager.audio:GetVoiceLength("story_v_out_120431", "120431045", "story_v_out_120431.awb") / 1000

					if var_188_12 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_12 + var_188_4
					end

					if var_188_7.prefab_name ~= "" and arg_185_1.actors_[var_188_7.prefab_name] ~= nil then
						local var_188_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_7.prefab_name].transform, "story_v_out_120431", "120431045", "story_v_out_120431.awb")

						arg_185_1:RecordAudio("120431045", var_188_13)
						arg_185_1:RecordAudio("120431045", var_188_13)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_120431", "120431045", "story_v_out_120431.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_120431", "120431045", "story_v_out_120431.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_14 = math.max(var_188_5, arg_185_1.talkMaxDuration)

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_14 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_4) / var_188_14

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_4 + var_188_14 and arg_185_1.time_ < var_188_4 + var_188_14 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play120431046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 120431046
		arg_189_1.duration_ = 16.07

		local var_189_0 = {
			zh = 8,
			ja = 16.066
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
				arg_189_0:Play120431047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1075ui_story"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1075ui_story == nil then
				arg_189_1.var_.characterEffect1075ui_story = var_192_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.2

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.characterEffect1075ui_story and not isNil(var_192_0) then
					arg_189_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1075ui_story then
				arg_189_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_192_4 = arg_189_1.actors_["1069ui_story"]
			local var_192_5 = 0

			if var_192_5 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 and not isNil(var_192_4) and arg_189_1.var_.characterEffect1069ui_story == nil then
				arg_189_1.var_.characterEffect1069ui_story = var_192_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_6 = 0.2

			if var_192_5 <= arg_189_1.time_ and arg_189_1.time_ < var_192_5 + var_192_6 and not isNil(var_192_4) then
				local var_192_7 = (arg_189_1.time_ - var_192_5) / var_192_6

				if arg_189_1.var_.characterEffect1069ui_story and not isNil(var_192_4) then
					local var_192_8 = Mathf.Lerp(0, 0.5, var_192_7)

					arg_189_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1069ui_story.fillRatio = var_192_8
				end
			end

			if arg_189_1.time_ >= var_192_5 + var_192_6 and arg_189_1.time_ < var_192_5 + var_192_6 + arg_192_0 and not isNil(var_192_4) and arg_189_1.var_.characterEffect1069ui_story then
				local var_192_9 = 0.5

				arg_189_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1069ui_story.fillRatio = var_192_9
			end

			local var_192_10 = 0
			local var_192_11 = 0.95

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_12 = arg_189_1:FormatText(StoryNameCfg[381].name)

				arg_189_1.leftNameTxt_.text = var_192_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_13 = arg_189_1:GetWordFromCfg(120431046)
				local var_192_14 = arg_189_1:FormatText(var_192_13.content)

				arg_189_1.text_.text = var_192_14

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_15 = 38
				local var_192_16 = utf8.len(var_192_14)
				local var_192_17 = var_192_15 <= 0 and var_192_11 or var_192_11 * (var_192_16 / var_192_15)

				if var_192_17 > 0 and var_192_11 < var_192_17 then
					arg_189_1.talkMaxDuration = var_192_17

					if var_192_17 + var_192_10 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_17 + var_192_10
					end
				end

				arg_189_1.text_.text = var_192_14
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431046", "story_v_out_120431.awb") ~= 0 then
					local var_192_18 = manager.audio:GetVoiceLength("story_v_out_120431", "120431046", "story_v_out_120431.awb") / 1000

					if var_192_18 + var_192_10 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_18 + var_192_10
					end

					if var_192_13.prefab_name ~= "" and arg_189_1.actors_[var_192_13.prefab_name] ~= nil then
						local var_192_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_13.prefab_name].transform, "story_v_out_120431", "120431046", "story_v_out_120431.awb")

						arg_189_1:RecordAudio("120431046", var_192_19)
						arg_189_1:RecordAudio("120431046", var_192_19)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_120431", "120431046", "story_v_out_120431.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_120431", "120431046", "story_v_out_120431.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_20 = math.max(var_192_11, arg_189_1.talkMaxDuration)

			if var_192_10 <= arg_189_1.time_ and arg_189_1.time_ < var_192_10 + var_192_20 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_10) / var_192_20

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_10 + var_192_20 and arg_189_1.time_ < var_192_10 + var_192_20 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play120431047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 120431047
		arg_193_1.duration_ = 7.87

		local var_193_0 = {
			zh = 3.966,
			ja = 7.866
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
				arg_193_0:Play120431048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1075ui_story"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1075ui_story == nil then
				arg_193_1.var_.characterEffect1075ui_story = var_196_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.2

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.characterEffect1075ui_story and not isNil(var_196_0) then
					local var_196_4 = Mathf.Lerp(0, 0.5, var_196_3)

					arg_193_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1075ui_story.fillRatio = var_196_4
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1075ui_story then
				local var_196_5 = 0.5

				arg_193_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1075ui_story.fillRatio = var_196_5
			end

			local var_196_6 = arg_193_1.actors_["1069ui_story"]
			local var_196_7 = 0

			if var_196_7 < arg_193_1.time_ and arg_193_1.time_ <= var_196_7 + arg_196_0 and not isNil(var_196_6) and arg_193_1.var_.characterEffect1069ui_story == nil then
				arg_193_1.var_.characterEffect1069ui_story = var_196_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_8 = 0.2

			if var_196_7 <= arg_193_1.time_ and arg_193_1.time_ < var_196_7 + var_196_8 and not isNil(var_196_6) then
				local var_196_9 = (arg_193_1.time_ - var_196_7) / var_196_8

				if arg_193_1.var_.characterEffect1069ui_story and not isNil(var_196_6) then
					arg_193_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_7 + var_196_8 and arg_193_1.time_ < var_196_7 + var_196_8 + arg_196_0 and not isNil(var_196_6) and arg_193_1.var_.characterEffect1069ui_story then
				arg_193_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_196_10 = 0
			local var_196_11 = 0.525

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_12 = arg_193_1:FormatText(StoryNameCfg[378].name)

				arg_193_1.leftNameTxt_.text = var_196_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_13 = arg_193_1:GetWordFromCfg(120431047)
				local var_196_14 = arg_193_1:FormatText(var_196_13.content)

				arg_193_1.text_.text = var_196_14

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_15 = 21
				local var_196_16 = utf8.len(var_196_14)
				local var_196_17 = var_196_15 <= 0 and var_196_11 or var_196_11 * (var_196_16 / var_196_15)

				if var_196_17 > 0 and var_196_11 < var_196_17 then
					arg_193_1.talkMaxDuration = var_196_17

					if var_196_17 + var_196_10 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_17 + var_196_10
					end
				end

				arg_193_1.text_.text = var_196_14
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431047", "story_v_out_120431.awb") ~= 0 then
					local var_196_18 = manager.audio:GetVoiceLength("story_v_out_120431", "120431047", "story_v_out_120431.awb") / 1000

					if var_196_18 + var_196_10 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_18 + var_196_10
					end

					if var_196_13.prefab_name ~= "" and arg_193_1.actors_[var_196_13.prefab_name] ~= nil then
						local var_196_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_13.prefab_name].transform, "story_v_out_120431", "120431047", "story_v_out_120431.awb")

						arg_193_1:RecordAudio("120431047", var_196_19)
						arg_193_1:RecordAudio("120431047", var_196_19)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_120431", "120431047", "story_v_out_120431.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_120431", "120431047", "story_v_out_120431.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_20 = math.max(var_196_11, arg_193_1.talkMaxDuration)

			if var_196_10 <= arg_193_1.time_ and arg_193_1.time_ < var_196_10 + var_196_20 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_10) / var_196_20

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_10 + var_196_20 and arg_193_1.time_ < var_196_10 + var_196_20 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play120431048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 120431048
		arg_197_1.duration_ = 5.9

		local var_197_0 = {
			zh = 5.9,
			ja = 4.733
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play120431049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.65

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[378].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_3 = arg_197_1:GetWordFromCfg(120431048)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 26
				local var_200_6 = utf8.len(var_200_4)
				local var_200_7 = var_200_5 <= 0 and var_200_1 or var_200_1 * (var_200_6 / var_200_5)

				if var_200_7 > 0 and var_200_1 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_4
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431048", "story_v_out_120431.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431048", "story_v_out_120431.awb") / 1000

					if var_200_8 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_0
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_out_120431", "120431048", "story_v_out_120431.awb")

						arg_197_1:RecordAudio("120431048", var_200_9)
						arg_197_1:RecordAudio("120431048", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_120431", "120431048", "story_v_out_120431.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_120431", "120431048", "story_v_out_120431.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_10 and arg_197_1.time_ < var_200_0 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play120431049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 120431049
		arg_201_1.duration_ = 4.93

		local var_201_0 = {
			zh = 4.933,
			ja = 3.466
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play120431050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1075ui_story"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1075ui_story == nil then
				arg_201_1.var_.characterEffect1075ui_story = var_204_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.2

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.characterEffect1075ui_story and not isNil(var_204_0) then
					arg_201_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1075ui_story then
				arg_201_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_204_4 = arg_201_1.actors_["1069ui_story"]
			local var_204_5 = 0

			if var_204_5 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.characterEffect1069ui_story == nil then
				arg_201_1.var_.characterEffect1069ui_story = var_204_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_6 = 0.2

			if var_204_5 <= arg_201_1.time_ and arg_201_1.time_ < var_204_5 + var_204_6 and not isNil(var_204_4) then
				local var_204_7 = (arg_201_1.time_ - var_204_5) / var_204_6

				if arg_201_1.var_.characterEffect1069ui_story and not isNil(var_204_4) then
					local var_204_8 = Mathf.Lerp(0, 0.5, var_204_7)

					arg_201_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1069ui_story.fillRatio = var_204_8
				end
			end

			if arg_201_1.time_ >= var_204_5 + var_204_6 and arg_201_1.time_ < var_204_5 + var_204_6 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.characterEffect1069ui_story then
				local var_204_9 = 0.5

				arg_201_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1069ui_story.fillRatio = var_204_9
			end

			local var_204_10 = 0

			if var_204_10 < arg_201_1.time_ and arg_201_1.time_ <= var_204_10 + arg_204_0 then
				arg_201_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action3_1")
			end

			local var_204_11 = 0

			if var_204_11 < arg_201_1.time_ and arg_201_1.time_ <= var_204_11 + arg_204_0 then
				arg_201_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_204_12 = 0
			local var_204_13 = 0.425

			if var_204_12 < arg_201_1.time_ and arg_201_1.time_ <= var_204_12 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_14 = arg_201_1:FormatText(StoryNameCfg[381].name)

				arg_201_1.leftNameTxt_.text = var_204_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_15 = arg_201_1:GetWordFromCfg(120431049)
				local var_204_16 = arg_201_1:FormatText(var_204_15.content)

				arg_201_1.text_.text = var_204_16

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_17 = 17
				local var_204_18 = utf8.len(var_204_16)
				local var_204_19 = var_204_17 <= 0 and var_204_13 or var_204_13 * (var_204_18 / var_204_17)

				if var_204_19 > 0 and var_204_13 < var_204_19 then
					arg_201_1.talkMaxDuration = var_204_19

					if var_204_19 + var_204_12 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_19 + var_204_12
					end
				end

				arg_201_1.text_.text = var_204_16
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431049", "story_v_out_120431.awb") ~= 0 then
					local var_204_20 = manager.audio:GetVoiceLength("story_v_out_120431", "120431049", "story_v_out_120431.awb") / 1000

					if var_204_20 + var_204_12 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_20 + var_204_12
					end

					if var_204_15.prefab_name ~= "" and arg_201_1.actors_[var_204_15.prefab_name] ~= nil then
						local var_204_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_15.prefab_name].transform, "story_v_out_120431", "120431049", "story_v_out_120431.awb")

						arg_201_1:RecordAudio("120431049", var_204_21)
						arg_201_1:RecordAudio("120431049", var_204_21)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_120431", "120431049", "story_v_out_120431.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_120431", "120431049", "story_v_out_120431.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_22 = math.max(var_204_13, arg_201_1.talkMaxDuration)

			if var_204_12 <= arg_201_1.time_ and arg_201_1.time_ < var_204_12 + var_204_22 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_12) / var_204_22

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_12 + var_204_22 and arg_201_1.time_ < var_204_12 + var_204_22 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play120431050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 120431050
		arg_205_1.duration_ = 9.77

		local var_205_0 = {
			zh = 5.1,
			ja = 9.766
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play120431051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action3_2")
			end

			local var_208_1 = 0
			local var_208_2 = 0.725

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_3 = arg_205_1:FormatText(StoryNameCfg[381].name)

				arg_205_1.leftNameTxt_.text = var_208_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_4 = arg_205_1:GetWordFromCfg(120431050)
				local var_208_5 = arg_205_1:FormatText(var_208_4.content)

				arg_205_1.text_.text = var_208_5

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_6 = 29
				local var_208_7 = utf8.len(var_208_5)
				local var_208_8 = var_208_6 <= 0 and var_208_2 or var_208_2 * (var_208_7 / var_208_6)

				if var_208_8 > 0 and var_208_2 < var_208_8 then
					arg_205_1.talkMaxDuration = var_208_8

					if var_208_8 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_1
					end
				end

				arg_205_1.text_.text = var_208_5
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431050", "story_v_out_120431.awb") ~= 0 then
					local var_208_9 = manager.audio:GetVoiceLength("story_v_out_120431", "120431050", "story_v_out_120431.awb") / 1000

					if var_208_9 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_9 + var_208_1
					end

					if var_208_4.prefab_name ~= "" and arg_205_1.actors_[var_208_4.prefab_name] ~= nil then
						local var_208_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_4.prefab_name].transform, "story_v_out_120431", "120431050", "story_v_out_120431.awb")

						arg_205_1:RecordAudio("120431050", var_208_10)
						arg_205_1:RecordAudio("120431050", var_208_10)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_120431", "120431050", "story_v_out_120431.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_120431", "120431050", "story_v_out_120431.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_11 = math.max(var_208_2, arg_205_1.talkMaxDuration)

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_11 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_1) / var_208_11

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_1 + var_208_11 and arg_205_1.time_ < var_208_1 + var_208_11 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play120431051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 120431051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play120431052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.666666666666667
			local var_212_1 = 0.166666666666667

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				local var_212_2 = "play"
				local var_212_3 = "effect"

				arg_209_1:AudioAction(var_212_2, var_212_3, "se_story_120_04", "se_story_120_04_footsteps01", "")
			end

			local var_212_4 = 0
			local var_212_5 = 0.266666666666667

			if var_212_4 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				local var_212_6 = "stop"
				local var_212_7 = "music"

				arg_209_1:AudioAction(var_212_6, var_212_7, "se_story_120_04", "se_story_120_04_hotpot_loop", "")

				local var_212_8 = ""
				local var_212_9 = manager.audio:GetAudioName("se_story_120_04", "se_story_120_04_hotpot_loop")

				if var_212_9 ~= "" then
					if arg_209_1.bgmTxt_.text ~= var_212_9 and arg_209_1.bgmTxt_.text ~= "" then
						if arg_209_1.bgmTxt2_.text ~= "" then
							arg_209_1.bgmTxt_.text = arg_209_1.bgmTxt2_.text
						end

						arg_209_1.bgmTxt2_.text = var_212_9

						arg_209_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_209_1.bgmTxt_.text = var_212_9
						arg_209_1.bgmTxt2_.text = var_212_9
					end

					if arg_209_1.bgmTimer then
						arg_209_1.bgmTimer:Stop()

						arg_209_1.bgmTimer = nil
					end

					if arg_209_1.settingData.show_music_name == 1 then
						arg_209_1.musicController:SetSelectedState("show")
						arg_209_1.musicAnimator_:Play("open", 0, 0)

						if arg_209_1.settingData.music_time ~= 0 then
							arg_209_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_209_1.settingData.music_time), function()
								if arg_209_1 == nil or isNil(arg_209_1.bgmTxt_) then
									return
								end

								arg_209_1.musicController:SetSelectedState("hide")
								arg_209_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_212_10 = arg_209_1.actors_["1075ui_story"]
			local var_212_11 = 0

			if var_212_11 < arg_209_1.time_ and arg_209_1.time_ <= var_212_11 + arg_212_0 and not isNil(var_212_10) and arg_209_1.var_.characterEffect1075ui_story == nil then
				arg_209_1.var_.characterEffect1075ui_story = var_212_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_12 = 0.2

			if var_212_11 <= arg_209_1.time_ and arg_209_1.time_ < var_212_11 + var_212_12 and not isNil(var_212_10) then
				local var_212_13 = (arg_209_1.time_ - var_212_11) / var_212_12

				if arg_209_1.var_.characterEffect1075ui_story and not isNil(var_212_10) then
					local var_212_14 = Mathf.Lerp(0, 0.5, var_212_13)

					arg_209_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1075ui_story.fillRatio = var_212_14
				end
			end

			if arg_209_1.time_ >= var_212_11 + var_212_12 and arg_209_1.time_ < var_212_11 + var_212_12 + arg_212_0 and not isNil(var_212_10) and arg_209_1.var_.characterEffect1075ui_story then
				local var_212_15 = 0.5

				arg_209_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1075ui_story.fillRatio = var_212_15
			end

			local var_212_16 = 0
			local var_212_17 = 1.15

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_18 = arg_209_1:GetWordFromCfg(120431051)
				local var_212_19 = arg_209_1:FormatText(var_212_18.content)

				arg_209_1.text_.text = var_212_19

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_20 = 46
				local var_212_21 = utf8.len(var_212_19)
				local var_212_22 = var_212_20 <= 0 and var_212_17 or var_212_17 * (var_212_21 / var_212_20)

				if var_212_22 > 0 and var_212_17 < var_212_22 then
					arg_209_1.talkMaxDuration = var_212_22

					if var_212_22 + var_212_16 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_22 + var_212_16
					end
				end

				arg_209_1.text_.text = var_212_19
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_23 = math.max(var_212_17, arg_209_1.talkMaxDuration)

			if var_212_16 <= arg_209_1.time_ and arg_209_1.time_ < var_212_16 + var_212_23 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_16) / var_212_23

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_16 + var_212_23 and arg_209_1.time_ < var_212_16 + var_212_23 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play120431052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 120431052
		arg_214_1.duration_ = 8.37

		local var_214_0 = {
			zh = 4.1,
			ja = 8.366
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
				arg_214_0:Play120431053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0
			local var_217_1 = 0.5

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_2 = arg_214_1:FormatText(StoryNameCfg[36].name)

				arg_214_1.leftNameTxt_.text = var_217_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_3 = arg_214_1:GetWordFromCfg(120431052)
				local var_217_4 = arg_214_1:FormatText(var_217_3.content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431052", "story_v_out_120431.awb") ~= 0 then
					local var_217_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431052", "story_v_out_120431.awb") / 1000

					if var_217_8 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_8 + var_217_0
					end

					if var_217_3.prefab_name ~= "" and arg_214_1.actors_[var_217_3.prefab_name] ~= nil then
						local var_217_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_3.prefab_name].transform, "story_v_out_120431", "120431052", "story_v_out_120431.awb")

						arg_214_1:RecordAudio("120431052", var_217_9)
						arg_214_1:RecordAudio("120431052", var_217_9)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_120431", "120431052", "story_v_out_120431.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_120431", "120431052", "story_v_out_120431.awb")
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
	Play120431053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 120431053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play120431054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0
			local var_221_1 = 0.925

			if var_221_0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_2 = arg_218_1:GetWordFromCfg(120431053)
				local var_221_3 = arg_218_1:FormatText(var_221_2.content)

				arg_218_1.text_.text = var_221_3

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_4 = 37
				local var_221_5 = utf8.len(var_221_3)
				local var_221_6 = var_221_4 <= 0 and var_221_1 or var_221_1 * (var_221_5 / var_221_4)

				if var_221_6 > 0 and var_221_1 < var_221_6 then
					arg_218_1.talkMaxDuration = var_221_6

					if var_221_6 + var_221_0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_6 + var_221_0
					end
				end

				arg_218_1.text_.text = var_221_3
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_7 = math.max(var_221_1, arg_218_1.talkMaxDuration)

			if var_221_0 <= arg_218_1.time_ and arg_218_1.time_ < var_221_0 + var_221_7 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_0) / var_221_7

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_0 + var_221_7 and arg_218_1.time_ < var_221_0 + var_221_7 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play120431054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 120431054
		arg_222_1.duration_ = 3.03

		local var_222_0 = {
			zh = 2.5,
			ja = 3.033
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play120431055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["1075ui_story"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect1075ui_story == nil then
				arg_222_1.var_.characterEffect1075ui_story = var_225_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.2

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.characterEffect1075ui_story and not isNil(var_225_0) then
					arg_222_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect1075ui_story then
				arg_222_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_225_4 = 0

			if var_225_4 < arg_222_1.time_ and arg_222_1.time_ <= var_225_4 + arg_225_0 then
				arg_222_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_225_5 = 0
			local var_225_6 = 0.175

			if var_225_5 < arg_222_1.time_ and arg_222_1.time_ <= var_225_5 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_7 = arg_222_1:FormatText(StoryNameCfg[381].name)

				arg_222_1.leftNameTxt_.text = var_225_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_8 = arg_222_1:GetWordFromCfg(120431054)
				local var_225_9 = arg_222_1:FormatText(var_225_8.content)

				arg_222_1.text_.text = var_225_9

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_10 = 7
				local var_225_11 = utf8.len(var_225_9)
				local var_225_12 = var_225_10 <= 0 and var_225_6 or var_225_6 * (var_225_11 / var_225_10)

				if var_225_12 > 0 and var_225_6 < var_225_12 then
					arg_222_1.talkMaxDuration = var_225_12

					if var_225_12 + var_225_5 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_12 + var_225_5
					end
				end

				arg_222_1.text_.text = var_225_9
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431054", "story_v_out_120431.awb") ~= 0 then
					local var_225_13 = manager.audio:GetVoiceLength("story_v_out_120431", "120431054", "story_v_out_120431.awb") / 1000

					if var_225_13 + var_225_5 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_13 + var_225_5
					end

					if var_225_8.prefab_name ~= "" and arg_222_1.actors_[var_225_8.prefab_name] ~= nil then
						local var_225_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_8.prefab_name].transform, "story_v_out_120431", "120431054", "story_v_out_120431.awb")

						arg_222_1:RecordAudio("120431054", var_225_14)
						arg_222_1:RecordAudio("120431054", var_225_14)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_120431", "120431054", "story_v_out_120431.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_120431", "120431054", "story_v_out_120431.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_15 = math.max(var_225_6, arg_222_1.talkMaxDuration)

			if var_225_5 <= arg_222_1.time_ and arg_222_1.time_ < var_225_5 + var_225_15 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_5) / var_225_15

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_5 + var_225_15 and arg_222_1.time_ < var_225_5 + var_225_15 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play120431055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 120431055
		arg_226_1.duration_ = 6.93

		local var_226_0 = {
			zh = 3.9,
			ja = 6.933
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
				arg_226_0:Play120431056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["1075ui_story"]
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1075ui_story == nil then
				arg_226_1.var_.characterEffect1075ui_story = var_229_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_2 = 0.2

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 and not isNil(var_229_0) then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2

				if arg_226_1.var_.characterEffect1075ui_story and not isNil(var_229_0) then
					local var_229_4 = Mathf.Lerp(0, 0.5, var_229_3)

					arg_226_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_226_1.var_.characterEffect1075ui_story.fillRatio = var_229_4
				end
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1075ui_story then
				local var_229_5 = 0.5

				arg_226_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_226_1.var_.characterEffect1075ui_story.fillRatio = var_229_5
			end

			local var_229_6 = "1029ui_story"

			if arg_226_1.actors_[var_229_6] == nil then
				local var_229_7 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_229_7) then
					local var_229_8 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_226_1.stage_.transform)

					var_229_8.name = var_229_6
					var_229_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_226_1.actors_[var_229_6] = var_229_8

					local var_229_9 = var_229_8:GetComponentInChildren(typeof(CharacterEffect))

					var_229_9.enabled = true

					local var_229_10 = GameObjectTools.GetOrAddComponent(var_229_8, typeof(DynamicBoneHelper))

					if var_229_10 then
						var_229_10:EnableDynamicBone(false)
					end

					arg_226_1:ShowWeapon(var_229_9.transform, false)

					arg_226_1.var_[var_229_6 .. "Animator"] = var_229_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_226_1.var_[var_229_6 .. "Animator"].applyRootMotion = true
					arg_226_1.var_[var_229_6 .. "LipSync"] = var_229_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_229_11 = arg_226_1.actors_["1029ui_story"].transform
			local var_229_12 = 0

			if var_229_12 < arg_226_1.time_ and arg_226_1.time_ <= var_229_12 + arg_229_0 then
				arg_226_1.var_.moveOldPos1029ui_story = var_229_11.localPosition
			end

			local var_229_13 = 0.001

			if var_229_12 <= arg_226_1.time_ and arg_226_1.time_ < var_229_12 + var_229_13 then
				local var_229_14 = (arg_226_1.time_ - var_229_12) / var_229_13
				local var_229_15 = Vector3.New(0.7, -1.09, -6.2)

				var_229_11.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1029ui_story, var_229_15, var_229_14)

				local var_229_16 = manager.ui.mainCamera.transform.position - var_229_11.position

				var_229_11.forward = Vector3.New(var_229_16.x, var_229_16.y, var_229_16.z)

				local var_229_17 = var_229_11.localEulerAngles

				var_229_17.z = 0
				var_229_17.x = 0
				var_229_11.localEulerAngles = var_229_17
			end

			if arg_226_1.time_ >= var_229_12 + var_229_13 and arg_226_1.time_ < var_229_12 + var_229_13 + arg_229_0 then
				var_229_11.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_229_18 = manager.ui.mainCamera.transform.position - var_229_11.position

				var_229_11.forward = Vector3.New(var_229_18.x, var_229_18.y, var_229_18.z)

				local var_229_19 = var_229_11.localEulerAngles

				var_229_19.z = 0
				var_229_19.x = 0
				var_229_11.localEulerAngles = var_229_19
			end

			local var_229_20 = arg_226_1.actors_["1069ui_story"].transform
			local var_229_21 = 0

			if var_229_21 < arg_226_1.time_ and arg_226_1.time_ <= var_229_21 + arg_229_0 then
				arg_226_1.var_.moveOldPos1069ui_story = var_229_20.localPosition
			end

			local var_229_22 = 0.001

			if var_229_21 <= arg_226_1.time_ and arg_226_1.time_ < var_229_21 + var_229_22 then
				local var_229_23 = (arg_226_1.time_ - var_229_21) / var_229_22
				local var_229_24 = Vector3.New(0, 100, 0)

				var_229_20.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1069ui_story, var_229_24, var_229_23)

				local var_229_25 = manager.ui.mainCamera.transform.position - var_229_20.position

				var_229_20.forward = Vector3.New(var_229_25.x, var_229_25.y, var_229_25.z)

				local var_229_26 = var_229_20.localEulerAngles

				var_229_26.z = 0
				var_229_26.x = 0
				var_229_20.localEulerAngles = var_229_26
			end

			if arg_226_1.time_ >= var_229_21 + var_229_22 and arg_226_1.time_ < var_229_21 + var_229_22 + arg_229_0 then
				var_229_20.localPosition = Vector3.New(0, 100, 0)

				local var_229_27 = manager.ui.mainCamera.transform.position - var_229_20.position

				var_229_20.forward = Vector3.New(var_229_27.x, var_229_27.y, var_229_27.z)

				local var_229_28 = var_229_20.localEulerAngles

				var_229_28.z = 0
				var_229_28.x = 0
				var_229_20.localEulerAngles = var_229_28
			end

			local var_229_29 = 0

			if var_229_29 < arg_226_1.time_ and arg_226_1.time_ <= var_229_29 + arg_229_0 then
				arg_226_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_229_30 = 0

			if var_229_30 < arg_226_1.time_ and arg_226_1.time_ <= var_229_30 + arg_229_0 then
				arg_226_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_229_31 = 0
			local var_229_32 = 0.325

			if var_229_31 < arg_226_1.time_ and arg_226_1.time_ <= var_229_31 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_33 = arg_226_1:FormatText(StoryNameCfg[319].name)

				arg_226_1.leftNameTxt_.text = var_229_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_34 = arg_226_1:GetWordFromCfg(120431055)
				local var_229_35 = arg_226_1:FormatText(var_229_34.content)

				arg_226_1.text_.text = var_229_35

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_36 = 13
				local var_229_37 = utf8.len(var_229_35)
				local var_229_38 = var_229_36 <= 0 and var_229_32 or var_229_32 * (var_229_37 / var_229_36)

				if var_229_38 > 0 and var_229_32 < var_229_38 then
					arg_226_1.talkMaxDuration = var_229_38

					if var_229_38 + var_229_31 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_38 + var_229_31
					end
				end

				arg_226_1.text_.text = var_229_35
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431055", "story_v_out_120431.awb") ~= 0 then
					local var_229_39 = manager.audio:GetVoiceLength("story_v_out_120431", "120431055", "story_v_out_120431.awb") / 1000

					if var_229_39 + var_229_31 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_39 + var_229_31
					end

					if var_229_34.prefab_name ~= "" and arg_226_1.actors_[var_229_34.prefab_name] ~= nil then
						local var_229_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_34.prefab_name].transform, "story_v_out_120431", "120431055", "story_v_out_120431.awb")

						arg_226_1:RecordAudio("120431055", var_229_40)
						arg_226_1:RecordAudio("120431055", var_229_40)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_120431", "120431055", "story_v_out_120431.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_120431", "120431055", "story_v_out_120431.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_41 = math.max(var_229_32, arg_226_1.talkMaxDuration)

			if var_229_31 <= arg_226_1.time_ and arg_226_1.time_ < var_229_31 + var_229_41 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_31) / var_229_41

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_31 + var_229_41 and arg_226_1.time_ < var_229_31 + var_229_41 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play120431056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 120431056
		arg_230_1.duration_ = 9.77

		local var_230_0 = {
			zh = 4.766,
			ja = 9.766
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play120431057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["1075ui_story"].transform
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.var_.moveOldPos1075ui_story = var_233_0.localPosition
			end

			local var_233_2 = 0.001

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2
				local var_233_4 = Vector3.New(0, 100, 0)

				var_233_0.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1075ui_story, var_233_4, var_233_3)

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

			local var_233_9 = arg_230_1.actors_["1069ui_story"].transform
			local var_233_10 = 0

			if var_233_10 < arg_230_1.time_ and arg_230_1.time_ <= var_233_10 + arg_233_0 then
				arg_230_1.var_.moveOldPos1069ui_story = var_233_9.localPosition
			end

			local var_233_11 = 0.001

			if var_233_10 <= arg_230_1.time_ and arg_230_1.time_ < var_233_10 + var_233_11 then
				local var_233_12 = (arg_230_1.time_ - var_233_10) / var_233_11
				local var_233_13 = Vector3.New(-0.7, -1, -6)

				var_233_9.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1069ui_story, var_233_13, var_233_12)

				local var_233_14 = manager.ui.mainCamera.transform.position - var_233_9.position

				var_233_9.forward = Vector3.New(var_233_14.x, var_233_14.y, var_233_14.z)

				local var_233_15 = var_233_9.localEulerAngles

				var_233_15.z = 0
				var_233_15.x = 0
				var_233_9.localEulerAngles = var_233_15
			end

			if arg_230_1.time_ >= var_233_10 + var_233_11 and arg_230_1.time_ < var_233_10 + var_233_11 + arg_233_0 then
				var_233_9.localPosition = Vector3.New(-0.7, -1, -6)

				local var_233_16 = manager.ui.mainCamera.transform.position - var_233_9.position

				var_233_9.forward = Vector3.New(var_233_16.x, var_233_16.y, var_233_16.z)

				local var_233_17 = var_233_9.localEulerAngles

				var_233_17.z = 0
				var_233_17.x = 0
				var_233_9.localEulerAngles = var_233_17
			end

			local var_233_18 = 0

			if var_233_18 < arg_230_1.time_ and arg_230_1.time_ <= var_233_18 + arg_233_0 then
				arg_230_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			local var_233_19 = arg_230_1.actors_["1069ui_story"]
			local var_233_20 = 0

			if var_233_20 < arg_230_1.time_ and arg_230_1.time_ <= var_233_20 + arg_233_0 and not isNil(var_233_19) and arg_230_1.var_.characterEffect1069ui_story == nil then
				arg_230_1.var_.characterEffect1069ui_story = var_233_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_21 = 0.2

			if var_233_20 <= arg_230_1.time_ and arg_230_1.time_ < var_233_20 + var_233_21 and not isNil(var_233_19) then
				local var_233_22 = (arg_230_1.time_ - var_233_20) / var_233_21

				if arg_230_1.var_.characterEffect1069ui_story and not isNil(var_233_19) then
					arg_230_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= var_233_20 + var_233_21 and arg_230_1.time_ < var_233_20 + var_233_21 + arg_233_0 and not isNil(var_233_19) and arg_230_1.var_.characterEffect1069ui_story then
				arg_230_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_233_23 = arg_230_1.actors_["1029ui_story"]
			local var_233_24 = 0

			if var_233_24 < arg_230_1.time_ and arg_230_1.time_ <= var_233_24 + arg_233_0 and not isNil(var_233_23) and arg_230_1.var_.characterEffect1029ui_story == nil then
				arg_230_1.var_.characterEffect1029ui_story = var_233_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_25 = 0.2

			if var_233_24 <= arg_230_1.time_ and arg_230_1.time_ < var_233_24 + var_233_25 and not isNil(var_233_23) then
				local var_233_26 = (arg_230_1.time_ - var_233_24) / var_233_25

				if arg_230_1.var_.characterEffect1029ui_story and not isNil(var_233_23) then
					local var_233_27 = Mathf.Lerp(0, 0.5, var_233_26)

					arg_230_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_230_1.var_.characterEffect1029ui_story.fillRatio = var_233_27
				end
			end

			if arg_230_1.time_ >= var_233_24 + var_233_25 and arg_230_1.time_ < var_233_24 + var_233_25 + arg_233_0 and not isNil(var_233_23) and arg_230_1.var_.characterEffect1029ui_story then
				local var_233_28 = 0.5

				arg_230_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_230_1.var_.characterEffect1029ui_story.fillRatio = var_233_28
			end

			local var_233_29 = 0
			local var_233_30 = 0.6

			if var_233_29 < arg_230_1.time_ and arg_230_1.time_ <= var_233_29 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_31 = arg_230_1:FormatText(StoryNameCfg[378].name)

				arg_230_1.leftNameTxt_.text = var_233_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_32 = arg_230_1:GetWordFromCfg(120431056)
				local var_233_33 = arg_230_1:FormatText(var_233_32.content)

				arg_230_1.text_.text = var_233_33

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_34 = 24
				local var_233_35 = utf8.len(var_233_33)
				local var_233_36 = var_233_34 <= 0 and var_233_30 or var_233_30 * (var_233_35 / var_233_34)

				if var_233_36 > 0 and var_233_30 < var_233_36 then
					arg_230_1.talkMaxDuration = var_233_36

					if var_233_36 + var_233_29 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_36 + var_233_29
					end
				end

				arg_230_1.text_.text = var_233_33
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431056", "story_v_out_120431.awb") ~= 0 then
					local var_233_37 = manager.audio:GetVoiceLength("story_v_out_120431", "120431056", "story_v_out_120431.awb") / 1000

					if var_233_37 + var_233_29 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_37 + var_233_29
					end

					if var_233_32.prefab_name ~= "" and arg_230_1.actors_[var_233_32.prefab_name] ~= nil then
						local var_233_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_32.prefab_name].transform, "story_v_out_120431", "120431056", "story_v_out_120431.awb")

						arg_230_1:RecordAudio("120431056", var_233_38)
						arg_230_1:RecordAudio("120431056", var_233_38)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_120431", "120431056", "story_v_out_120431.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_120431", "120431056", "story_v_out_120431.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_39 = math.max(var_233_30, arg_230_1.talkMaxDuration)

			if var_233_29 <= arg_230_1.time_ and arg_230_1.time_ < var_233_29 + var_233_39 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_29) / var_233_39

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_29 + var_233_39 and arg_230_1.time_ < var_233_29 + var_233_39 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play120431057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 120431057
		arg_234_1.duration_ = 6.23

		local var_234_0 = {
			zh = 5.1,
			ja = 6.233
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play120431058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["1029ui_story"]
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1029ui_story == nil then
				arg_234_1.var_.characterEffect1029ui_story = var_237_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.2

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 and not isNil(var_237_0) then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2

				if arg_234_1.var_.characterEffect1029ui_story and not isNil(var_237_0) then
					arg_234_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1029ui_story then
				arg_234_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_237_4 = arg_234_1.actors_["1069ui_story"]
			local var_237_5 = 0

			if var_237_5 < arg_234_1.time_ and arg_234_1.time_ <= var_237_5 + arg_237_0 and not isNil(var_237_4) and arg_234_1.var_.characterEffect1069ui_story == nil then
				arg_234_1.var_.characterEffect1069ui_story = var_237_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_6 = 0.2

			if var_237_5 <= arg_234_1.time_ and arg_234_1.time_ < var_237_5 + var_237_6 and not isNil(var_237_4) then
				local var_237_7 = (arg_234_1.time_ - var_237_5) / var_237_6

				if arg_234_1.var_.characterEffect1069ui_story and not isNil(var_237_4) then
					local var_237_8 = Mathf.Lerp(0, 0.5, var_237_7)

					arg_234_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_234_1.var_.characterEffect1069ui_story.fillRatio = var_237_8
				end
			end

			if arg_234_1.time_ >= var_237_5 + var_237_6 and arg_234_1.time_ < var_237_5 + var_237_6 + arg_237_0 and not isNil(var_237_4) and arg_234_1.var_.characterEffect1069ui_story then
				local var_237_9 = 0.5

				arg_234_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_234_1.var_.characterEffect1069ui_story.fillRatio = var_237_9
			end

			local var_237_10 = 0
			local var_237_11 = 0.425

			if var_237_10 < arg_234_1.time_ and arg_234_1.time_ <= var_237_10 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_12 = arg_234_1:FormatText(StoryNameCfg[319].name)

				arg_234_1.leftNameTxt_.text = var_237_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_13 = arg_234_1:GetWordFromCfg(120431057)
				local var_237_14 = arg_234_1:FormatText(var_237_13.content)

				arg_234_1.text_.text = var_237_14

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_15 = 17
				local var_237_16 = utf8.len(var_237_14)
				local var_237_17 = var_237_15 <= 0 and var_237_11 or var_237_11 * (var_237_16 / var_237_15)

				if var_237_17 > 0 and var_237_11 < var_237_17 then
					arg_234_1.talkMaxDuration = var_237_17

					if var_237_17 + var_237_10 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_17 + var_237_10
					end
				end

				arg_234_1.text_.text = var_237_14
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431057", "story_v_out_120431.awb") ~= 0 then
					local var_237_18 = manager.audio:GetVoiceLength("story_v_out_120431", "120431057", "story_v_out_120431.awb") / 1000

					if var_237_18 + var_237_10 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_18 + var_237_10
					end

					if var_237_13.prefab_name ~= "" and arg_234_1.actors_[var_237_13.prefab_name] ~= nil then
						local var_237_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_13.prefab_name].transform, "story_v_out_120431", "120431057", "story_v_out_120431.awb")

						arg_234_1:RecordAudio("120431057", var_237_19)
						arg_234_1:RecordAudio("120431057", var_237_19)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_120431", "120431057", "story_v_out_120431.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_120431", "120431057", "story_v_out_120431.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_20 = math.max(var_237_11, arg_234_1.talkMaxDuration)

			if var_237_10 <= arg_234_1.time_ and arg_234_1.time_ < var_237_10 + var_237_20 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_10) / var_237_20

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_10 + var_237_20 and arg_234_1.time_ < var_237_10 + var_237_20 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play120431058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 120431058
		arg_238_1.duration_ = 2.07

		local var_238_0 = {
			zh = 1.6,
			ja = 2.066
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
				arg_238_0:Play120431059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0
			local var_241_1 = 0.175

			if var_241_0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_2 = arg_238_1:FormatText(StoryNameCfg[319].name)

				arg_238_1.leftNameTxt_.text = var_241_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_3 = arg_238_1:GetWordFromCfg(120431058)
				local var_241_4 = arg_238_1:FormatText(var_241_3.content)

				arg_238_1.text_.text = var_241_4

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 7
				local var_241_6 = utf8.len(var_241_4)
				local var_241_7 = var_241_5 <= 0 and var_241_1 or var_241_1 * (var_241_6 / var_241_5)

				if var_241_7 > 0 and var_241_1 < var_241_7 then
					arg_238_1.talkMaxDuration = var_241_7

					if var_241_7 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_7 + var_241_0
					end
				end

				arg_238_1.text_.text = var_241_4
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431058", "story_v_out_120431.awb") ~= 0 then
					local var_241_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431058", "story_v_out_120431.awb") / 1000

					if var_241_8 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_8 + var_241_0
					end

					if var_241_3.prefab_name ~= "" and arg_238_1.actors_[var_241_3.prefab_name] ~= nil then
						local var_241_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_3.prefab_name].transform, "story_v_out_120431", "120431058", "story_v_out_120431.awb")

						arg_238_1:RecordAudio("120431058", var_241_9)
						arg_238_1:RecordAudio("120431058", var_241_9)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_120431", "120431058", "story_v_out_120431.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_120431", "120431058", "story_v_out_120431.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_10 = math.max(var_241_1, arg_238_1.talkMaxDuration)

			if var_241_0 <= arg_238_1.time_ and arg_238_1.time_ < var_241_0 + var_241_10 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_0) / var_241_10

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_0 + var_241_10 and arg_238_1.time_ < var_241_0 + var_241_10 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play120431059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 120431059
		arg_242_1.duration_ = 7.53

		local var_242_0 = {
			zh = 6.066,
			ja = 7.533
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play120431060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["1075ui_story"].transform
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 then
				arg_242_1.var_.moveOldPos1075ui_story = var_245_0.localPosition
			end

			local var_245_2 = 0.001

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2
				local var_245_4 = Vector3.New(-0.7, -1.055, -6.16)

				var_245_0.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1075ui_story, var_245_4, var_245_3)

				local var_245_5 = manager.ui.mainCamera.transform.position - var_245_0.position

				var_245_0.forward = Vector3.New(var_245_5.x, var_245_5.y, var_245_5.z)

				local var_245_6 = var_245_0.localEulerAngles

				var_245_6.z = 0
				var_245_6.x = 0
				var_245_0.localEulerAngles = var_245_6
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 then
				var_245_0.localPosition = Vector3.New(-0.7, -1.055, -6.16)

				local var_245_7 = manager.ui.mainCamera.transform.position - var_245_0.position

				var_245_0.forward = Vector3.New(var_245_7.x, var_245_7.y, var_245_7.z)

				local var_245_8 = var_245_0.localEulerAngles

				var_245_8.z = 0
				var_245_8.x = 0
				var_245_0.localEulerAngles = var_245_8
			end

			local var_245_9 = arg_242_1.actors_["1029ui_story"]
			local var_245_10 = 0

			if var_245_10 < arg_242_1.time_ and arg_242_1.time_ <= var_245_10 + arg_245_0 and not isNil(var_245_9) and arg_242_1.var_.characterEffect1029ui_story == nil then
				arg_242_1.var_.characterEffect1029ui_story = var_245_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_11 = 0.2

			if var_245_10 <= arg_242_1.time_ and arg_242_1.time_ < var_245_10 + var_245_11 and not isNil(var_245_9) then
				local var_245_12 = (arg_242_1.time_ - var_245_10) / var_245_11

				if arg_242_1.var_.characterEffect1029ui_story and not isNil(var_245_9) then
					local var_245_13 = Mathf.Lerp(0, 0.5, var_245_12)

					arg_242_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_242_1.var_.characterEffect1029ui_story.fillRatio = var_245_13
				end
			end

			if arg_242_1.time_ >= var_245_10 + var_245_11 and arg_242_1.time_ < var_245_10 + var_245_11 + arg_245_0 and not isNil(var_245_9) and arg_242_1.var_.characterEffect1029ui_story then
				local var_245_14 = 0.5

				arg_242_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_242_1.var_.characterEffect1029ui_story.fillRatio = var_245_14
			end

			local var_245_15 = arg_242_1.actors_["1075ui_story"]
			local var_245_16 = 0

			if var_245_16 < arg_242_1.time_ and arg_242_1.time_ <= var_245_16 + arg_245_0 and not isNil(var_245_15) and arg_242_1.var_.characterEffect1075ui_story == nil then
				arg_242_1.var_.characterEffect1075ui_story = var_245_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_17 = 0.2

			if var_245_16 <= arg_242_1.time_ and arg_242_1.time_ < var_245_16 + var_245_17 and not isNil(var_245_15) then
				local var_245_18 = (arg_242_1.time_ - var_245_16) / var_245_17

				if arg_242_1.var_.characterEffect1075ui_story and not isNil(var_245_15) then
					arg_242_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= var_245_16 + var_245_17 and arg_242_1.time_ < var_245_16 + var_245_17 + arg_245_0 and not isNil(var_245_15) and arg_242_1.var_.characterEffect1075ui_story then
				arg_242_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_245_19 = arg_242_1.actors_["1069ui_story"].transform
			local var_245_20 = 0

			if var_245_20 < arg_242_1.time_ and arg_242_1.time_ <= var_245_20 + arg_245_0 then
				arg_242_1.var_.moveOldPos1069ui_story = var_245_19.localPosition
			end

			local var_245_21 = 0.001

			if var_245_20 <= arg_242_1.time_ and arg_242_1.time_ < var_245_20 + var_245_21 then
				local var_245_22 = (arg_242_1.time_ - var_245_20) / var_245_21
				local var_245_23 = Vector3.New(0, 100, 0)

				var_245_19.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1069ui_story, var_245_23, var_245_22)

				local var_245_24 = manager.ui.mainCamera.transform.position - var_245_19.position

				var_245_19.forward = Vector3.New(var_245_24.x, var_245_24.y, var_245_24.z)

				local var_245_25 = var_245_19.localEulerAngles

				var_245_25.z = 0
				var_245_25.x = 0
				var_245_19.localEulerAngles = var_245_25
			end

			if arg_242_1.time_ >= var_245_20 + var_245_21 and arg_242_1.time_ < var_245_20 + var_245_21 + arg_245_0 then
				var_245_19.localPosition = Vector3.New(0, 100, 0)

				local var_245_26 = manager.ui.mainCamera.transform.position - var_245_19.position

				var_245_19.forward = Vector3.New(var_245_26.x, var_245_26.y, var_245_26.z)

				local var_245_27 = var_245_19.localEulerAngles

				var_245_27.z = 0
				var_245_27.x = 0
				var_245_19.localEulerAngles = var_245_27
			end

			local var_245_28 = 0

			if var_245_28 < arg_242_1.time_ and arg_242_1.time_ <= var_245_28 + arg_245_0 then
				arg_242_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_245_29 = 0

			if var_245_29 < arg_242_1.time_ and arg_242_1.time_ <= var_245_29 + arg_245_0 then
				arg_242_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_245_30 = 0
			local var_245_31 = 0.75

			if var_245_30 < arg_242_1.time_ and arg_242_1.time_ <= var_245_30 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_32 = arg_242_1:FormatText(StoryNameCfg[381].name)

				arg_242_1.leftNameTxt_.text = var_245_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_33 = arg_242_1:GetWordFromCfg(120431059)
				local var_245_34 = arg_242_1:FormatText(var_245_33.content)

				arg_242_1.text_.text = var_245_34

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_35 = 29
				local var_245_36 = utf8.len(var_245_34)
				local var_245_37 = var_245_35 <= 0 and var_245_31 or var_245_31 * (var_245_36 / var_245_35)

				if var_245_37 > 0 and var_245_31 < var_245_37 then
					arg_242_1.talkMaxDuration = var_245_37

					if var_245_37 + var_245_30 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_37 + var_245_30
					end
				end

				arg_242_1.text_.text = var_245_34
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431059", "story_v_out_120431.awb") ~= 0 then
					local var_245_38 = manager.audio:GetVoiceLength("story_v_out_120431", "120431059", "story_v_out_120431.awb") / 1000

					if var_245_38 + var_245_30 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_38 + var_245_30
					end

					if var_245_33.prefab_name ~= "" and arg_242_1.actors_[var_245_33.prefab_name] ~= nil then
						local var_245_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_33.prefab_name].transform, "story_v_out_120431", "120431059", "story_v_out_120431.awb")

						arg_242_1:RecordAudio("120431059", var_245_39)
						arg_242_1:RecordAudio("120431059", var_245_39)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_120431", "120431059", "story_v_out_120431.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_120431", "120431059", "story_v_out_120431.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_40 = math.max(var_245_31, arg_242_1.talkMaxDuration)

			if var_245_30 <= arg_242_1.time_ and arg_242_1.time_ < var_245_30 + var_245_40 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_30) / var_245_40

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_30 + var_245_40 and arg_242_1.time_ < var_245_30 + var_245_40 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play120431060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 120431060
		arg_246_1.duration_ = 6.3

		local var_246_0 = {
			zh = 6.266,
			ja = 6.3
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play120431061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0

			if var_249_0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_0 + arg_249_0 then
				arg_246_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_249_2 = 0
			local var_249_3 = 0.6

			if var_249_2 < arg_246_1.time_ and arg_246_1.time_ <= var_249_2 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_4 = arg_246_1:FormatText(StoryNameCfg[381].name)

				arg_246_1.leftNameTxt_.text = var_249_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_5 = arg_246_1:GetWordFromCfg(120431060)
				local var_249_6 = arg_246_1:FormatText(var_249_5.content)

				arg_246_1.text_.text = var_249_6

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_7 = 24
				local var_249_8 = utf8.len(var_249_6)
				local var_249_9 = var_249_7 <= 0 and var_249_3 or var_249_3 * (var_249_8 / var_249_7)

				if var_249_9 > 0 and var_249_3 < var_249_9 then
					arg_246_1.talkMaxDuration = var_249_9

					if var_249_9 + var_249_2 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_9 + var_249_2
					end
				end

				arg_246_1.text_.text = var_249_6
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431060", "story_v_out_120431.awb") ~= 0 then
					local var_249_10 = manager.audio:GetVoiceLength("story_v_out_120431", "120431060", "story_v_out_120431.awb") / 1000

					if var_249_10 + var_249_2 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_10 + var_249_2
					end

					if var_249_5.prefab_name ~= "" and arg_246_1.actors_[var_249_5.prefab_name] ~= nil then
						local var_249_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_5.prefab_name].transform, "story_v_out_120431", "120431060", "story_v_out_120431.awb")

						arg_246_1:RecordAudio("120431060", var_249_11)
						arg_246_1:RecordAudio("120431060", var_249_11)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_120431", "120431060", "story_v_out_120431.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_120431", "120431060", "story_v_out_120431.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_12 = math.max(var_249_3, arg_246_1.talkMaxDuration)

			if var_249_2 <= arg_246_1.time_ and arg_246_1.time_ < var_249_2 + var_249_12 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_2) / var_249_12

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_2 + var_249_12 and arg_246_1.time_ < var_249_2 + var_249_12 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play120431061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 120431061
		arg_250_1.duration_ = 10.1

		local var_250_0 = {
			zh = 5.6,
			ja = 10.1
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
				arg_250_0:Play120431062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_253_1 = arg_250_1.actors_["1075ui_story"]
			local var_253_2 = 0

			if var_253_2 < arg_250_1.time_ and arg_250_1.time_ <= var_253_2 + arg_253_0 and not isNil(var_253_1) and arg_250_1.var_.characterEffect1075ui_story == nil then
				arg_250_1.var_.characterEffect1075ui_story = var_253_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_3 = 0.2

			if var_253_2 <= arg_250_1.time_ and arg_250_1.time_ < var_253_2 + var_253_3 and not isNil(var_253_1) then
				local var_253_4 = (arg_250_1.time_ - var_253_2) / var_253_3

				if arg_250_1.var_.characterEffect1075ui_story and not isNil(var_253_1) then
					local var_253_5 = Mathf.Lerp(0, 0.5, var_253_4)

					arg_250_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_250_1.var_.characterEffect1075ui_story.fillRatio = var_253_5
				end
			end

			if arg_250_1.time_ >= var_253_2 + var_253_3 and arg_250_1.time_ < var_253_2 + var_253_3 + arg_253_0 and not isNil(var_253_1) and arg_250_1.var_.characterEffect1075ui_story then
				local var_253_6 = 0.5

				arg_250_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_250_1.var_.characterEffect1075ui_story.fillRatio = var_253_6
			end

			local var_253_7 = arg_250_1.actors_["1084ui_story"]
			local var_253_8 = 0

			if var_253_8 < arg_250_1.time_ and arg_250_1.time_ <= var_253_8 + arg_253_0 and not isNil(var_253_7) and arg_250_1.var_.characterEffect1084ui_story == nil then
				arg_250_1.var_.characterEffect1084ui_story = var_253_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_9 = 0.2

			if var_253_8 <= arg_250_1.time_ and arg_250_1.time_ < var_253_8 + var_253_9 and not isNil(var_253_7) then
				local var_253_10 = (arg_250_1.time_ - var_253_8) / var_253_9

				if arg_250_1.var_.characterEffect1084ui_story and not isNil(var_253_7) then
					arg_250_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= var_253_8 + var_253_9 and arg_250_1.time_ < var_253_8 + var_253_9 + arg_253_0 and not isNil(var_253_7) and arg_250_1.var_.characterEffect1084ui_story then
				arg_250_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_253_11 = arg_250_1.actors_["1084ui_story"].transform
			local var_253_12 = 0

			if var_253_12 < arg_250_1.time_ and arg_250_1.time_ <= var_253_12 + arg_253_0 then
				arg_250_1.var_.moveOldPos1084ui_story = var_253_11.localPosition
			end

			local var_253_13 = 0.001

			if var_253_12 <= arg_250_1.time_ and arg_250_1.time_ < var_253_12 + var_253_13 then
				local var_253_14 = (arg_250_1.time_ - var_253_12) / var_253_13
				local var_253_15 = Vector3.New(0, -0.97, -6)

				var_253_11.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1084ui_story, var_253_15, var_253_14)

				local var_253_16 = manager.ui.mainCamera.transform.position - var_253_11.position

				var_253_11.forward = Vector3.New(var_253_16.x, var_253_16.y, var_253_16.z)

				local var_253_17 = var_253_11.localEulerAngles

				var_253_17.z = 0
				var_253_17.x = 0
				var_253_11.localEulerAngles = var_253_17
			end

			if arg_250_1.time_ >= var_253_12 + var_253_13 and arg_250_1.time_ < var_253_12 + var_253_13 + arg_253_0 then
				var_253_11.localPosition = Vector3.New(0, -0.97, -6)

				local var_253_18 = manager.ui.mainCamera.transform.position - var_253_11.position

				var_253_11.forward = Vector3.New(var_253_18.x, var_253_18.y, var_253_18.z)

				local var_253_19 = var_253_11.localEulerAngles

				var_253_19.z = 0
				var_253_19.x = 0
				var_253_11.localEulerAngles = var_253_19
			end

			local var_253_20 = arg_250_1.actors_["1075ui_story"].transform
			local var_253_21 = 0

			if var_253_21 < arg_250_1.time_ and arg_250_1.time_ <= var_253_21 + arg_253_0 then
				arg_250_1.var_.moveOldPos1075ui_story = var_253_20.localPosition
			end

			local var_253_22 = 0.001

			if var_253_21 <= arg_250_1.time_ and arg_250_1.time_ < var_253_21 + var_253_22 then
				local var_253_23 = (arg_250_1.time_ - var_253_21) / var_253_22
				local var_253_24 = Vector3.New(0, 100, 0)

				var_253_20.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1075ui_story, var_253_24, var_253_23)

				local var_253_25 = manager.ui.mainCamera.transform.position - var_253_20.position

				var_253_20.forward = Vector3.New(var_253_25.x, var_253_25.y, var_253_25.z)

				local var_253_26 = var_253_20.localEulerAngles

				var_253_26.z = 0
				var_253_26.x = 0
				var_253_20.localEulerAngles = var_253_26
			end

			if arg_250_1.time_ >= var_253_21 + var_253_22 and arg_250_1.time_ < var_253_21 + var_253_22 + arg_253_0 then
				var_253_20.localPosition = Vector3.New(0, 100, 0)

				local var_253_27 = manager.ui.mainCamera.transform.position - var_253_20.position

				var_253_20.forward = Vector3.New(var_253_27.x, var_253_27.y, var_253_27.z)

				local var_253_28 = var_253_20.localEulerAngles

				var_253_28.z = 0
				var_253_28.x = 0
				var_253_20.localEulerAngles = var_253_28
			end

			local var_253_29 = arg_250_1.actors_["1029ui_story"].transform
			local var_253_30 = 0

			if var_253_30 < arg_250_1.time_ and arg_250_1.time_ <= var_253_30 + arg_253_0 then
				arg_250_1.var_.moveOldPos1029ui_story = var_253_29.localPosition
			end

			local var_253_31 = 0.001

			if var_253_30 <= arg_250_1.time_ and arg_250_1.time_ < var_253_30 + var_253_31 then
				local var_253_32 = (arg_250_1.time_ - var_253_30) / var_253_31
				local var_253_33 = Vector3.New(0, 100, 0)

				var_253_29.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1029ui_story, var_253_33, var_253_32)

				local var_253_34 = manager.ui.mainCamera.transform.position - var_253_29.position

				var_253_29.forward = Vector3.New(var_253_34.x, var_253_34.y, var_253_34.z)

				local var_253_35 = var_253_29.localEulerAngles

				var_253_35.z = 0
				var_253_35.x = 0
				var_253_29.localEulerAngles = var_253_35
			end

			if arg_250_1.time_ >= var_253_30 + var_253_31 and arg_250_1.time_ < var_253_30 + var_253_31 + arg_253_0 then
				var_253_29.localPosition = Vector3.New(0, 100, 0)

				local var_253_36 = manager.ui.mainCamera.transform.position - var_253_29.position

				var_253_29.forward = Vector3.New(var_253_36.x, var_253_36.y, var_253_36.z)

				local var_253_37 = var_253_29.localEulerAngles

				var_253_37.z = 0
				var_253_37.x = 0
				var_253_29.localEulerAngles = var_253_37
			end

			local var_253_38 = 0

			if var_253_38 < arg_250_1.time_ and arg_250_1.time_ <= var_253_38 + arg_253_0 then
				arg_250_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_253_39 = 0
			local var_253_40 = 0.575

			if var_253_39 < arg_250_1.time_ and arg_250_1.time_ <= var_253_39 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_41 = arg_250_1:FormatText(StoryNameCfg[6].name)

				arg_250_1.leftNameTxt_.text = var_253_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_42 = arg_250_1:GetWordFromCfg(120431061)
				local var_253_43 = arg_250_1:FormatText(var_253_42.content)

				arg_250_1.text_.text = var_253_43

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_44 = 23
				local var_253_45 = utf8.len(var_253_43)
				local var_253_46 = var_253_44 <= 0 and var_253_40 or var_253_40 * (var_253_45 / var_253_44)

				if var_253_46 > 0 and var_253_40 < var_253_46 then
					arg_250_1.talkMaxDuration = var_253_46

					if var_253_46 + var_253_39 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_46 + var_253_39
					end
				end

				arg_250_1.text_.text = var_253_43
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431061", "story_v_out_120431.awb") ~= 0 then
					local var_253_47 = manager.audio:GetVoiceLength("story_v_out_120431", "120431061", "story_v_out_120431.awb") / 1000

					if var_253_47 + var_253_39 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_47 + var_253_39
					end

					if var_253_42.prefab_name ~= "" and arg_250_1.actors_[var_253_42.prefab_name] ~= nil then
						local var_253_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_42.prefab_name].transform, "story_v_out_120431", "120431061", "story_v_out_120431.awb")

						arg_250_1:RecordAudio("120431061", var_253_48)
						arg_250_1:RecordAudio("120431061", var_253_48)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_120431", "120431061", "story_v_out_120431.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_120431", "120431061", "story_v_out_120431.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_49 = math.max(var_253_40, arg_250_1.talkMaxDuration)

			if var_253_39 <= arg_250_1.time_ and arg_250_1.time_ < var_253_39 + var_253_49 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_39) / var_253_49

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_39 + var_253_49 and arg_250_1.time_ < var_253_39 + var_253_49 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play120431062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 120431062
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play120431063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1084ui_story"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1084ui_story == nil then
				arg_254_1.var_.characterEffect1084ui_story = var_257_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.2

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.characterEffect1084ui_story and not isNil(var_257_0) then
					local var_257_4 = Mathf.Lerp(0, 0.5, var_257_3)

					arg_254_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1084ui_story.fillRatio = var_257_4
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1084ui_story then
				local var_257_5 = 0.5

				arg_254_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1084ui_story.fillRatio = var_257_5
			end

			local var_257_6 = 0
			local var_257_7 = 0.3

			if var_257_6 < arg_254_1.time_ and arg_254_1.time_ <= var_257_6 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_8 = arg_254_1:FormatText(StoryNameCfg[7].name)

				arg_254_1.leftNameTxt_.text = var_257_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, true)
				arg_254_1.iconController_:SetSelectedState("hero")

				arg_254_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_254_1.callingController_:SetSelectedState("normal")

				arg_254_1.keyicon_.color = Color.New(1, 1, 1)
				arg_254_1.icon_.color = Color.New(1, 1, 1)

				local var_257_9 = arg_254_1:GetWordFromCfg(120431062)
				local var_257_10 = arg_254_1:FormatText(var_257_9.content)

				arg_254_1.text_.text = var_257_10

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_11 = 12
				local var_257_12 = utf8.len(var_257_10)
				local var_257_13 = var_257_11 <= 0 and var_257_7 or var_257_7 * (var_257_12 / var_257_11)

				if var_257_13 > 0 and var_257_7 < var_257_13 then
					arg_254_1.talkMaxDuration = var_257_13

					if var_257_13 + var_257_6 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_13 + var_257_6
					end
				end

				arg_254_1.text_.text = var_257_10
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_14 = math.max(var_257_7, arg_254_1.talkMaxDuration)

			if var_257_6 <= arg_254_1.time_ and arg_254_1.time_ < var_257_6 + var_257_14 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_6) / var_257_14

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_6 + var_257_14 and arg_254_1.time_ < var_257_6 + var_257_14 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play120431063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 120431063
		arg_258_1.duration_ = 4.23

		local var_258_0 = {
			zh = 2.033,
			ja = 4.233
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play120431064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["1084ui_story"].transform
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.var_.moveOldPos1084ui_story = var_261_0.localPosition
			end

			local var_261_2 = 0.001

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2
				local var_261_4 = Vector3.New(0, 100, 0)

				var_261_0.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1084ui_story, var_261_4, var_261_3)

				local var_261_5 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_5.x, var_261_5.y, var_261_5.z)

				local var_261_6 = var_261_0.localEulerAngles

				var_261_6.z = 0
				var_261_6.x = 0
				var_261_0.localEulerAngles = var_261_6
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 then
				var_261_0.localPosition = Vector3.New(0, 100, 0)

				local var_261_7 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_7.x, var_261_7.y, var_261_7.z)

				local var_261_8 = var_261_0.localEulerAngles

				var_261_8.z = 0
				var_261_8.x = 0
				var_261_0.localEulerAngles = var_261_8
			end

			local var_261_9 = arg_258_1.actors_["1069ui_story"].transform
			local var_261_10 = 0

			if var_261_10 < arg_258_1.time_ and arg_258_1.time_ <= var_261_10 + arg_261_0 then
				arg_258_1.var_.moveOldPos1069ui_story = var_261_9.localPosition
			end

			local var_261_11 = 0.001

			if var_261_10 <= arg_258_1.time_ and arg_258_1.time_ < var_261_10 + var_261_11 then
				local var_261_12 = (arg_258_1.time_ - var_261_10) / var_261_11
				local var_261_13 = Vector3.New(0, -1, -6)

				var_261_9.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1069ui_story, var_261_13, var_261_12)

				local var_261_14 = manager.ui.mainCamera.transform.position - var_261_9.position

				var_261_9.forward = Vector3.New(var_261_14.x, var_261_14.y, var_261_14.z)

				local var_261_15 = var_261_9.localEulerAngles

				var_261_15.z = 0
				var_261_15.x = 0
				var_261_9.localEulerAngles = var_261_15
			end

			if arg_258_1.time_ >= var_261_10 + var_261_11 and arg_258_1.time_ < var_261_10 + var_261_11 + arg_261_0 then
				var_261_9.localPosition = Vector3.New(0, -1, -6)

				local var_261_16 = manager.ui.mainCamera.transform.position - var_261_9.position

				var_261_9.forward = Vector3.New(var_261_16.x, var_261_16.y, var_261_16.z)

				local var_261_17 = var_261_9.localEulerAngles

				var_261_17.z = 0
				var_261_17.x = 0
				var_261_9.localEulerAngles = var_261_17
			end

			local var_261_18 = 0

			if var_261_18 < arg_258_1.time_ and arg_258_1.time_ <= var_261_18 + arg_261_0 then
				arg_258_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			local var_261_19 = 0

			if var_261_19 < arg_258_1.time_ and arg_258_1.time_ <= var_261_19 + arg_261_0 then
				arg_258_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_261_20 = arg_258_1.actors_["1069ui_story"]
			local var_261_21 = 0

			if var_261_21 < arg_258_1.time_ and arg_258_1.time_ <= var_261_21 + arg_261_0 and not isNil(var_261_20) and arg_258_1.var_.characterEffect1069ui_story == nil then
				arg_258_1.var_.characterEffect1069ui_story = var_261_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_22 = 0.2

			if var_261_21 <= arg_258_1.time_ and arg_258_1.time_ < var_261_21 + var_261_22 and not isNil(var_261_20) then
				local var_261_23 = (arg_258_1.time_ - var_261_21) / var_261_22

				if arg_258_1.var_.characterEffect1069ui_story and not isNil(var_261_20) then
					arg_258_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= var_261_21 + var_261_22 and arg_258_1.time_ < var_261_21 + var_261_22 + arg_261_0 and not isNil(var_261_20) and arg_258_1.var_.characterEffect1069ui_story then
				arg_258_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_261_24 = 0
			local var_261_25 = 0.3

			if var_261_24 < arg_258_1.time_ and arg_258_1.time_ <= var_261_24 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_26 = arg_258_1:FormatText(StoryNameCfg[378].name)

				arg_258_1.leftNameTxt_.text = var_261_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_27 = arg_258_1:GetWordFromCfg(120431063)
				local var_261_28 = arg_258_1:FormatText(var_261_27.content)

				arg_258_1.text_.text = var_261_28

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_29 = 12
				local var_261_30 = utf8.len(var_261_28)
				local var_261_31 = var_261_29 <= 0 and var_261_25 or var_261_25 * (var_261_30 / var_261_29)

				if var_261_31 > 0 and var_261_25 < var_261_31 then
					arg_258_1.talkMaxDuration = var_261_31

					if var_261_31 + var_261_24 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_31 + var_261_24
					end
				end

				arg_258_1.text_.text = var_261_28
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431063", "story_v_out_120431.awb") ~= 0 then
					local var_261_32 = manager.audio:GetVoiceLength("story_v_out_120431", "120431063", "story_v_out_120431.awb") / 1000

					if var_261_32 + var_261_24 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_32 + var_261_24
					end

					if var_261_27.prefab_name ~= "" and arg_258_1.actors_[var_261_27.prefab_name] ~= nil then
						local var_261_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_27.prefab_name].transform, "story_v_out_120431", "120431063", "story_v_out_120431.awb")

						arg_258_1:RecordAudio("120431063", var_261_33)
						arg_258_1:RecordAudio("120431063", var_261_33)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_120431", "120431063", "story_v_out_120431.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_120431", "120431063", "story_v_out_120431.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_34 = math.max(var_261_25, arg_258_1.talkMaxDuration)

			if var_261_24 <= arg_258_1.time_ and arg_258_1.time_ < var_261_24 + var_261_34 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_24) / var_261_34

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_24 + var_261_34 and arg_258_1.time_ < var_261_24 + var_261_34 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play120431064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 120431064
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play120431065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["1069ui_story"].transform
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.var_.moveOldPos1069ui_story = var_265_0.localPosition
			end

			local var_265_2 = 0.001

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2
				local var_265_4 = Vector3.New(0, 100, 0)

				var_265_0.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1069ui_story, var_265_4, var_265_3)

				local var_265_5 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_5.x, var_265_5.y, var_265_5.z)

				local var_265_6 = var_265_0.localEulerAngles

				var_265_6.z = 0
				var_265_6.x = 0
				var_265_0.localEulerAngles = var_265_6
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 then
				var_265_0.localPosition = Vector3.New(0, 100, 0)

				local var_265_7 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_7.x, var_265_7.y, var_265_7.z)

				local var_265_8 = var_265_0.localEulerAngles

				var_265_8.z = 0
				var_265_8.x = 0
				var_265_0.localEulerAngles = var_265_8
			end

			local var_265_9 = 0
			local var_265_10 = 0.575

			if var_265_9 < arg_262_1.time_ and arg_262_1.time_ <= var_265_9 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_11 = arg_262_1:GetWordFromCfg(120431064)
				local var_265_12 = arg_262_1:FormatText(var_265_11.content)

				arg_262_1.text_.text = var_265_12

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_13 = 23
				local var_265_14 = utf8.len(var_265_12)
				local var_265_15 = var_265_13 <= 0 and var_265_10 or var_265_10 * (var_265_14 / var_265_13)

				if var_265_15 > 0 and var_265_10 < var_265_15 then
					arg_262_1.talkMaxDuration = var_265_15

					if var_265_15 + var_265_9 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_15 + var_265_9
					end
				end

				arg_262_1.text_.text = var_265_12
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_16 = math.max(var_265_10, arg_262_1.talkMaxDuration)

			if var_265_9 <= arg_262_1.time_ and arg_262_1.time_ < var_265_9 + var_265_16 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_9) / var_265_16

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_9 + var_265_16 and arg_262_1.time_ < var_265_9 + var_265_16 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play120431065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 120431065
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play120431066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0
			local var_269_1 = 0.3

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_2 = arg_266_1:FormatText(StoryNameCfg[7].name)

				arg_266_1.leftNameTxt_.text = var_269_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_3 = arg_266_1:GetWordFromCfg(120431065)
				local var_269_4 = arg_266_1:FormatText(var_269_3.content)

				arg_266_1.text_.text = var_269_4

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 12
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
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_8 = math.max(var_269_1, arg_266_1.talkMaxDuration)

			if var_269_0 <= arg_266_1.time_ and arg_266_1.time_ < var_269_0 + var_269_8 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_0) / var_269_8

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_0 + var_269_8 and arg_266_1.time_ < var_269_0 + var_269_8 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play120431066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 120431066
		arg_270_1.duration_ = 7

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play120431067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.mask_.enabled = true
				arg_270_1.mask_.raycastTarget = true

				arg_270_1:SetGaussion(false)
			end

			local var_273_1 = 2

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_1 then
				local var_273_2 = (arg_270_1.time_ - var_273_0) / var_273_1
				local var_273_3 = Color.New(1, 1, 1)

				var_273_3.a = Mathf.Lerp(1, 0, var_273_2)
				arg_270_1.mask_.color = var_273_3
			end

			if arg_270_1.time_ >= var_273_0 + var_273_1 and arg_270_1.time_ < var_273_0 + var_273_1 + arg_273_0 then
				local var_273_4 = Color.New(1, 1, 1)
				local var_273_5 = 0

				arg_270_1.mask_.enabled = false
				var_273_4.a = var_273_5
				arg_270_1.mask_.color = var_273_4
			end

			if arg_270_1.frameCnt_ <= 1 then
				arg_270_1.dialog_:SetActive(false)
			end

			local var_273_6 = 2
			local var_273_7 = 0.8

			if var_273_6 < arg_270_1.time_ and arg_270_1.time_ <= var_273_6 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0

				arg_270_1.dialog_:SetActive(true)

				arg_270_1.dialogCg_.alpha = 0

				local var_273_8 = LeanTween.value(arg_270_1.dialog_, 0, 1, 0.3)

				var_273_8:setOnUpdate(LuaHelper.FloatAction(function(arg_274_0)
					arg_270_1.dialogCg_.alpha = arg_274_0
				end))
				var_273_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_270_1.dialog_)
					var_273_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_270_1.duration_ = arg_270_1.duration_ + 0.3

				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_9 = arg_270_1:GetWordFromCfg(120431066)
				local var_273_10 = arg_270_1:FormatText(var_273_9.content)

				arg_270_1.text_.text = var_273_10

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_11 = 32
				local var_273_12 = utf8.len(var_273_10)
				local var_273_13 = var_273_11 <= 0 and var_273_7 or var_273_7 * (var_273_12 / var_273_11)

				if var_273_13 > 0 and var_273_7 < var_273_13 then
					arg_270_1.talkMaxDuration = var_273_13
					var_273_6 = var_273_6 + 0.3

					if var_273_13 + var_273_6 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_13 + var_273_6
					end
				end

				arg_270_1.text_.text = var_273_10
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_14 = var_273_6 + 0.3
			local var_273_15 = math.max(var_273_7, arg_270_1.talkMaxDuration)

			if var_273_14 <= arg_270_1.time_ and arg_270_1.time_ < var_273_14 + var_273_15 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_14) / var_273_15

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_14 + var_273_15 and arg_270_1.time_ < var_273_14 + var_273_15 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play120431067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 120431067
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play120431068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0
			local var_279_1 = 0.275

			if var_279_0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_2 = arg_276_1:FormatText(StoryNameCfg[7].name)

				arg_276_1.leftNameTxt_.text = var_279_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_3 = arg_276_1:GetWordFromCfg(120431067)
				local var_279_4 = arg_276_1:FormatText(var_279_3.content)

				arg_276_1.text_.text = var_279_4

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_5 = 11
				local var_279_6 = utf8.len(var_279_4)
				local var_279_7 = var_279_5 <= 0 and var_279_1 or var_279_1 * (var_279_6 / var_279_5)

				if var_279_7 > 0 and var_279_1 < var_279_7 then
					arg_276_1.talkMaxDuration = var_279_7

					if var_279_7 + var_279_0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_7 + var_279_0
					end
				end

				arg_276_1.text_.text = var_279_4
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_8 = math.max(var_279_1, arg_276_1.talkMaxDuration)

			if var_279_0 <= arg_276_1.time_ and arg_276_1.time_ < var_279_0 + var_279_8 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_0) / var_279_8

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_0 + var_279_8 and arg_276_1.time_ < var_279_0 + var_279_8 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play120431068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 120431068
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play120431069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0
			local var_283_1 = 1

			if var_283_0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, false)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_2 = arg_280_1:GetWordFromCfg(120431068)
				local var_283_3 = arg_280_1:FormatText(var_283_2.content)

				arg_280_1.text_.text = var_283_3

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_4 = 40
				local var_283_5 = utf8.len(var_283_3)
				local var_283_6 = var_283_4 <= 0 and var_283_1 or var_283_1 * (var_283_5 / var_283_4)

				if var_283_6 > 0 and var_283_1 < var_283_6 then
					arg_280_1.talkMaxDuration = var_283_6

					if var_283_6 + var_283_0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_6 + var_283_0
					end
				end

				arg_280_1.text_.text = var_283_3
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_7 = math.max(var_283_1, arg_280_1.talkMaxDuration)

			if var_283_0 <= arg_280_1.time_ and arg_280_1.time_ < var_283_0 + var_283_7 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_0) / var_283_7

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_0 + var_283_7 and arg_280_1.time_ < var_283_0 + var_283_7 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play120431069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 120431069
		arg_284_1.duration_ = 8.7

		local var_284_0 = {
			zh = 2.2,
			ja = 8.7
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
				arg_284_0:Play120431070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["1076ui_story"].transform
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1.var_.moveOldPos1076ui_story = var_287_0.localPosition
			end

			local var_287_2 = 0.001

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / var_287_2
				local var_287_4 = Vector3.New(0, -1.06, -6.2)

				var_287_0.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1076ui_story, var_287_4, var_287_3)

				local var_287_5 = manager.ui.mainCamera.transform.position - var_287_0.position

				var_287_0.forward = Vector3.New(var_287_5.x, var_287_5.y, var_287_5.z)

				local var_287_6 = var_287_0.localEulerAngles

				var_287_6.z = 0
				var_287_6.x = 0
				var_287_0.localEulerAngles = var_287_6
			end

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 then
				var_287_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_287_7 = manager.ui.mainCamera.transform.position - var_287_0.position

				var_287_0.forward = Vector3.New(var_287_7.x, var_287_7.y, var_287_7.z)

				local var_287_8 = var_287_0.localEulerAngles

				var_287_8.z = 0
				var_287_8.x = 0
				var_287_0.localEulerAngles = var_287_8
			end

			local var_287_9 = 0

			if var_287_9 < arg_284_1.time_ and arg_284_1.time_ <= var_287_9 + arg_287_0 then
				arg_284_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_287_10 = 0

			if var_287_10 < arg_284_1.time_ and arg_284_1.time_ <= var_287_10 + arg_287_0 then
				arg_284_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_287_11 = arg_284_1.actors_["1076ui_story"]
			local var_287_12 = 0

			if var_287_12 < arg_284_1.time_ and arg_284_1.time_ <= var_287_12 + arg_287_0 and not isNil(var_287_11) and arg_284_1.var_.characterEffect1076ui_story == nil then
				arg_284_1.var_.characterEffect1076ui_story = var_287_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_13 = 0.2

			if var_287_12 <= arg_284_1.time_ and arg_284_1.time_ < var_287_12 + var_287_13 and not isNil(var_287_11) then
				local var_287_14 = (arg_284_1.time_ - var_287_12) / var_287_13

				if arg_284_1.var_.characterEffect1076ui_story and not isNil(var_287_11) then
					arg_284_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_284_1.time_ >= var_287_12 + var_287_13 and arg_284_1.time_ < var_287_12 + var_287_13 + arg_287_0 and not isNil(var_287_11) and arg_284_1.var_.characterEffect1076ui_story then
				arg_284_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_287_15 = 0
			local var_287_16 = 0.3

			if var_287_15 < arg_284_1.time_ and arg_284_1.time_ <= var_287_15 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_17 = arg_284_1:FormatText(StoryNameCfg[389].name)

				arg_284_1.leftNameTxt_.text = var_287_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_18 = arg_284_1:GetWordFromCfg(120431069)
				local var_287_19 = arg_284_1:FormatText(var_287_18.content)

				arg_284_1.text_.text = var_287_19

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_20 = 12
				local var_287_21 = utf8.len(var_287_19)
				local var_287_22 = var_287_20 <= 0 and var_287_16 or var_287_16 * (var_287_21 / var_287_20)

				if var_287_22 > 0 and var_287_16 < var_287_22 then
					arg_284_1.talkMaxDuration = var_287_22

					if var_287_22 + var_287_15 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_22 + var_287_15
					end
				end

				arg_284_1.text_.text = var_287_19
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431069", "story_v_out_120431.awb") ~= 0 then
					local var_287_23 = manager.audio:GetVoiceLength("story_v_out_120431", "120431069", "story_v_out_120431.awb") / 1000

					if var_287_23 + var_287_15 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_23 + var_287_15
					end

					if var_287_18.prefab_name ~= "" and arg_284_1.actors_[var_287_18.prefab_name] ~= nil then
						local var_287_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_18.prefab_name].transform, "story_v_out_120431", "120431069", "story_v_out_120431.awb")

						arg_284_1:RecordAudio("120431069", var_287_24)
						arg_284_1:RecordAudio("120431069", var_287_24)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_120431", "120431069", "story_v_out_120431.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_120431", "120431069", "story_v_out_120431.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_25 = math.max(var_287_16, arg_284_1.talkMaxDuration)

			if var_287_15 <= arg_284_1.time_ and arg_284_1.time_ < var_287_15 + var_287_25 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_15) / var_287_25

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_15 + var_287_25 and arg_284_1.time_ < var_287_15 + var_287_25 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play120431070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 120431070
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play120431071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["1076ui_story"]
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect1076ui_story == nil then
				arg_288_1.var_.characterEffect1076ui_story = var_291_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_2 = 0.2

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 and not isNil(var_291_0) then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2

				if arg_288_1.var_.characterEffect1076ui_story and not isNil(var_291_0) then
					local var_291_4 = Mathf.Lerp(0, 0.5, var_291_3)

					arg_288_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_288_1.var_.characterEffect1076ui_story.fillRatio = var_291_4
				end
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect1076ui_story then
				local var_291_5 = 0.5

				arg_288_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_288_1.var_.characterEffect1076ui_story.fillRatio = var_291_5
			end

			local var_291_6 = 0
			local var_291_7 = 0.35

			if var_291_6 < arg_288_1.time_ and arg_288_1.time_ <= var_291_6 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_8 = arg_288_1:FormatText(StoryNameCfg[7].name)

				arg_288_1.leftNameTxt_.text = var_291_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_9 = arg_288_1:GetWordFromCfg(120431070)
				local var_291_10 = arg_288_1:FormatText(var_291_9.content)

				arg_288_1.text_.text = var_291_10

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_11 = 14
				local var_291_12 = utf8.len(var_291_10)
				local var_291_13 = var_291_11 <= 0 and var_291_7 or var_291_7 * (var_291_12 / var_291_11)

				if var_291_13 > 0 and var_291_7 < var_291_13 then
					arg_288_1.talkMaxDuration = var_291_13

					if var_291_13 + var_291_6 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_13 + var_291_6
					end
				end

				arg_288_1.text_.text = var_291_10
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_14 = math.max(var_291_7, arg_288_1.talkMaxDuration)

			if var_291_6 <= arg_288_1.time_ and arg_288_1.time_ < var_291_6 + var_291_14 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_6) / var_291_14

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_6 + var_291_14 and arg_288_1.time_ < var_291_6 + var_291_14 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play120431071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 120431071
		arg_292_1.duration_ = 7

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play120431072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = "STblack"

			if arg_292_1.bgs_[var_295_0] == nil then
				local var_295_1 = Object.Instantiate(arg_292_1.paintGo_)

				var_295_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_295_0)
				var_295_1.name = var_295_0
				var_295_1.transform.parent = arg_292_1.stage_.transform
				var_295_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_292_1.bgs_[var_295_0] = var_295_1
			end

			local var_295_2 = 2

			if var_295_2 < arg_292_1.time_ and arg_292_1.time_ <= var_295_2 + arg_295_0 then
				local var_295_3 = manager.ui.mainCamera.transform.localPosition
				local var_295_4 = Vector3.New(0, 0, 10) + Vector3.New(var_295_3.x, var_295_3.y, 0)
				local var_295_5 = arg_292_1.bgs_.STblack

				var_295_5.transform.localPosition = var_295_4
				var_295_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_295_6 = var_295_5:GetComponent("SpriteRenderer")

				if var_295_6 and var_295_6.sprite then
					local var_295_7 = (var_295_5.transform.localPosition - var_295_3).z
					local var_295_8 = manager.ui.mainCameraCom_
					local var_295_9 = 2 * var_295_7 * Mathf.Tan(var_295_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_295_10 = var_295_9 * var_295_8.aspect
					local var_295_11 = var_295_6.sprite.bounds.size.x
					local var_295_12 = var_295_6.sprite.bounds.size.y
					local var_295_13 = var_295_10 / var_295_11
					local var_295_14 = var_295_9 / var_295_12
					local var_295_15 = var_295_14 < var_295_13 and var_295_13 or var_295_14

					var_295_5.transform.localScale = Vector3.New(var_295_15, var_295_15, 0)
				end

				for iter_295_0, iter_295_1 in pairs(arg_292_1.bgs_) do
					if iter_295_0 ~= "STblack" then
						iter_295_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_295_16 = 0

			if var_295_16 < arg_292_1.time_ and arg_292_1.time_ <= var_295_16 + arg_295_0 then
				arg_292_1.mask_.enabled = true
				arg_292_1.mask_.raycastTarget = true

				arg_292_1:SetGaussion(false)
			end

			local var_295_17 = 2

			if var_295_16 <= arg_292_1.time_ and arg_292_1.time_ < var_295_16 + var_295_17 then
				local var_295_18 = (arg_292_1.time_ - var_295_16) / var_295_17
				local var_295_19 = Color.New(0, 0, 0)

				var_295_19.a = Mathf.Lerp(0, 1, var_295_18)
				arg_292_1.mask_.color = var_295_19
			end

			if arg_292_1.time_ >= var_295_16 + var_295_17 and arg_292_1.time_ < var_295_16 + var_295_17 + arg_295_0 then
				local var_295_20 = Color.New(0, 0, 0)

				var_295_20.a = 1
				arg_292_1.mask_.color = var_295_20
			end

			local var_295_21 = 2

			if var_295_21 < arg_292_1.time_ and arg_292_1.time_ <= var_295_21 + arg_295_0 then
				arg_292_1.mask_.enabled = true
				arg_292_1.mask_.raycastTarget = true

				arg_292_1:SetGaussion(false)
			end

			local var_295_22 = 1

			if var_295_21 <= arg_292_1.time_ and arg_292_1.time_ < var_295_21 + var_295_22 then
				local var_295_23 = (arg_292_1.time_ - var_295_21) / var_295_22
				local var_295_24 = Color.New(0, 0, 0)

				var_295_24.a = Mathf.Lerp(1, 0, var_295_23)
				arg_292_1.mask_.color = var_295_24
			end

			if arg_292_1.time_ >= var_295_21 + var_295_22 and arg_292_1.time_ < var_295_21 + var_295_22 + arg_295_0 then
				local var_295_25 = Color.New(0, 0, 0)
				local var_295_26 = 0

				arg_292_1.mask_.enabled = false
				var_295_25.a = var_295_26
				arg_292_1.mask_.color = var_295_25
			end

			local var_295_27 = arg_292_1.actors_["1076ui_story"].transform
			local var_295_28 = 1.966

			if var_295_28 < arg_292_1.time_ and arg_292_1.time_ <= var_295_28 + arg_295_0 then
				arg_292_1.var_.moveOldPos1076ui_story = var_295_27.localPosition
			end

			local var_295_29 = 0.001

			if var_295_28 <= arg_292_1.time_ and arg_292_1.time_ < var_295_28 + var_295_29 then
				local var_295_30 = (arg_292_1.time_ - var_295_28) / var_295_29
				local var_295_31 = Vector3.New(0, 100, 0)

				var_295_27.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1076ui_story, var_295_31, var_295_30)

				local var_295_32 = manager.ui.mainCamera.transform.position - var_295_27.position

				var_295_27.forward = Vector3.New(var_295_32.x, var_295_32.y, var_295_32.z)

				local var_295_33 = var_295_27.localEulerAngles

				var_295_33.z = 0
				var_295_33.x = 0
				var_295_27.localEulerAngles = var_295_33
			end

			if arg_292_1.time_ >= var_295_28 + var_295_29 and arg_292_1.time_ < var_295_28 + var_295_29 + arg_295_0 then
				var_295_27.localPosition = Vector3.New(0, 100, 0)

				local var_295_34 = manager.ui.mainCamera.transform.position - var_295_27.position

				var_295_27.forward = Vector3.New(var_295_34.x, var_295_34.y, var_295_34.z)

				local var_295_35 = var_295_27.localEulerAngles

				var_295_35.z = 0
				var_295_35.x = 0
				var_295_27.localEulerAngles = var_295_35
			end

			if arg_292_1.frameCnt_ <= 1 then
				arg_292_1.dialog_:SetActive(false)
			end

			local var_295_36 = 2
			local var_295_37 = 0.4

			if var_295_36 < arg_292_1.time_ and arg_292_1.time_ <= var_295_36 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0

				arg_292_1.dialog_:SetActive(true)

				arg_292_1.dialogCg_.alpha = 0

				local var_295_38 = LeanTween.value(arg_292_1.dialog_, 0, 1, 0.3)

				var_295_38:setOnUpdate(LuaHelper.FloatAction(function(arg_296_0)
					arg_292_1.dialogCg_.alpha = arg_296_0
				end))
				var_295_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_292_1.dialog_)
					var_295_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_292_1.duration_ = arg_292_1.duration_ + 0.3

				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_39 = arg_292_1:GetWordFromCfg(120431071)
				local var_295_40 = arg_292_1:FormatText(var_295_39.content)

				arg_292_1.text_.text = var_295_40

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_41 = 16
				local var_295_42 = utf8.len(var_295_40)
				local var_295_43 = var_295_41 <= 0 and var_295_37 or var_295_37 * (var_295_42 / var_295_41)

				if var_295_43 > 0 and var_295_37 < var_295_43 then
					arg_292_1.talkMaxDuration = var_295_43
					var_295_36 = var_295_36 + 0.3

					if var_295_43 + var_295_36 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_43 + var_295_36
					end
				end

				arg_292_1.text_.text = var_295_40
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_44 = var_295_36 + 0.3
			local var_295_45 = math.max(var_295_37, arg_292_1.talkMaxDuration)

			if var_295_44 <= arg_292_1.time_ and arg_292_1.time_ < var_295_44 + var_295_45 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_44) / var_295_45

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_44 + var_295_45 and arg_292_1.time_ < var_295_44 + var_295_45 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play120431072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 120431072
		arg_298_1.duration_ = 5.25

		local var_298_0 = {
			zh = 5.25,
			ja = 4.716
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play120431073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = "XH0205"

			if arg_298_1.bgs_[var_301_0] == nil then
				local var_301_1 = Object.Instantiate(arg_298_1.paintGo_)

				var_301_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_301_0)
				var_301_1.name = var_301_0
				var_301_1.transform.parent = arg_298_1.stage_.transform
				var_301_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_298_1.bgs_[var_301_0] = var_301_1
			end

			local var_301_2 = 0

			if var_301_2 < arg_298_1.time_ and arg_298_1.time_ <= var_301_2 + arg_301_0 then
				local var_301_3 = manager.ui.mainCamera.transform.localPosition
				local var_301_4 = Vector3.New(0, 0, 10) + Vector3.New(var_301_3.x, var_301_3.y, 0)
				local var_301_5 = arg_298_1.bgs_.XH0205

				var_301_5.transform.localPosition = var_301_4
				var_301_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_301_6 = var_301_5:GetComponent("SpriteRenderer")

				if var_301_6 and var_301_6.sprite then
					local var_301_7 = (var_301_5.transform.localPosition - var_301_3).z
					local var_301_8 = manager.ui.mainCameraCom_
					local var_301_9 = 2 * var_301_7 * Mathf.Tan(var_301_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_301_10 = var_301_9 * var_301_8.aspect
					local var_301_11 = var_301_6.sprite.bounds.size.x
					local var_301_12 = var_301_6.sprite.bounds.size.y
					local var_301_13 = var_301_10 / var_301_11
					local var_301_14 = var_301_9 / var_301_12
					local var_301_15 = var_301_14 < var_301_13 and var_301_13 or var_301_14

					var_301_5.transform.localScale = Vector3.New(var_301_15, var_301_15, 0)
				end

				for iter_301_0, iter_301_1 in pairs(arg_298_1.bgs_) do
					if iter_301_0 ~= "XH0205" then
						iter_301_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_301_16 = 0

			if var_301_16 < arg_298_1.time_ and arg_298_1.time_ <= var_301_16 + arg_301_0 then
				arg_298_1.mask_.enabled = true
				arg_298_1.mask_.raycastTarget = true

				arg_298_1:SetGaussion(false)
			end

			local var_301_17 = 3.5

			if var_301_16 <= arg_298_1.time_ and arg_298_1.time_ < var_301_16 + var_301_17 then
				local var_301_18 = (arg_298_1.time_ - var_301_16) / var_301_17
				local var_301_19 = Color.New(0, 0, 0)

				var_301_19.a = Mathf.Lerp(1, 0, var_301_18)
				arg_298_1.mask_.color = var_301_19
			end

			if arg_298_1.time_ >= var_301_16 + var_301_17 and arg_298_1.time_ < var_301_16 + var_301_17 + arg_301_0 then
				local var_301_20 = Color.New(0, 0, 0)
				local var_301_21 = 0

				arg_298_1.mask_.enabled = false
				var_301_20.a = var_301_21
				arg_298_1.mask_.color = var_301_20
			end

			if arg_298_1.frameCnt_ <= 1 then
				arg_298_1.dialog_:SetActive(false)
			end

			local var_301_22 = 3.35
			local var_301_23 = 0.15

			if var_301_22 < arg_298_1.time_ and arg_298_1.time_ <= var_301_22 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0

				arg_298_1.dialog_:SetActive(true)

				arg_298_1.dialogCg_.alpha = 0

				local var_301_24 = LeanTween.value(arg_298_1.dialog_, 0, 1, 0.3)

				var_301_24:setOnUpdate(LuaHelper.FloatAction(function(arg_302_0)
					arg_298_1.dialogCg_.alpha = arg_302_0
				end))
				var_301_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_298_1.dialog_)
					var_301_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_298_1.duration_ = arg_298_1.duration_ + 0.3

				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_25 = arg_298_1:FormatText(StoryNameCfg[6].name)

				arg_298_1.leftNameTxt_.text = var_301_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_26 = arg_298_1:GetWordFromCfg(120431072)
				local var_301_27 = arg_298_1:FormatText(var_301_26.content)

				arg_298_1.text_.text = var_301_27

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_28 = 6
				local var_301_29 = utf8.len(var_301_27)
				local var_301_30 = var_301_28 <= 0 and var_301_23 or var_301_23 * (var_301_29 / var_301_28)

				if var_301_30 > 0 and var_301_23 < var_301_30 then
					arg_298_1.talkMaxDuration = var_301_30
					var_301_22 = var_301_22 + 0.3

					if var_301_30 + var_301_22 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_30 + var_301_22
					end
				end

				arg_298_1.text_.text = var_301_27
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431072", "story_v_out_120431.awb") ~= 0 then
					local var_301_31 = manager.audio:GetVoiceLength("story_v_out_120431", "120431072", "story_v_out_120431.awb") / 1000

					if var_301_31 + var_301_22 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_31 + var_301_22
					end

					if var_301_26.prefab_name ~= "" and arg_298_1.actors_[var_301_26.prefab_name] ~= nil then
						local var_301_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_26.prefab_name].transform, "story_v_out_120431", "120431072", "story_v_out_120431.awb")

						arg_298_1:RecordAudio("120431072", var_301_32)
						arg_298_1:RecordAudio("120431072", var_301_32)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_120431", "120431072", "story_v_out_120431.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_120431", "120431072", "story_v_out_120431.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_33 = var_301_22 + 0.3
			local var_301_34 = math.max(var_301_23, arg_298_1.talkMaxDuration)

			if var_301_33 <= arg_298_1.time_ and arg_298_1.time_ < var_301_33 + var_301_34 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_33) / var_301_34

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_33 + var_301_34 and arg_298_1.time_ < var_301_33 + var_301_34 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play120431073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 120431073
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play120431074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0
			local var_307_1 = 0.825

			if var_307_0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_2 = arg_304_1:GetWordFromCfg(120431073)
				local var_307_3 = arg_304_1:FormatText(var_307_2.content)

				arg_304_1.text_.text = var_307_3

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_4 = 33
				local var_307_5 = utf8.len(var_307_3)
				local var_307_6 = var_307_4 <= 0 and var_307_1 or var_307_1 * (var_307_5 / var_307_4)

				if var_307_6 > 0 and var_307_1 < var_307_6 then
					arg_304_1.talkMaxDuration = var_307_6

					if var_307_6 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_6 + var_307_0
					end
				end

				arg_304_1.text_.text = var_307_3
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_7 = math.max(var_307_1, arg_304_1.talkMaxDuration)

			if var_307_0 <= arg_304_1.time_ and arg_304_1.time_ < var_307_0 + var_307_7 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_0) / var_307_7

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_0 + var_307_7 and arg_304_1.time_ < var_307_0 + var_307_7 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play120431074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 120431074
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play120431075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0
			local var_311_1 = 1.175

			if var_311_0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_2 = arg_308_1:GetWordFromCfg(120431074)
				local var_311_3 = arg_308_1:FormatText(var_311_2.content)

				arg_308_1.text_.text = var_311_3

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_4 = 47
				local var_311_5 = utf8.len(var_311_3)
				local var_311_6 = var_311_4 <= 0 and var_311_1 or var_311_1 * (var_311_5 / var_311_4)

				if var_311_6 > 0 and var_311_1 < var_311_6 then
					arg_308_1.talkMaxDuration = var_311_6

					if var_311_6 + var_311_0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_6 + var_311_0
					end
				end

				arg_308_1.text_.text = var_311_3
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_7 = math.max(var_311_1, arg_308_1.talkMaxDuration)

			if var_311_0 <= arg_308_1.time_ and arg_308_1.time_ < var_311_0 + var_311_7 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_0) / var_311_7

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_0 + var_311_7 and arg_308_1.time_ < var_311_0 + var_311_7 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play120431075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 120431075
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play120431076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0
			local var_315_1 = 0.5

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

				local var_315_3 = arg_312_1:GetWordFromCfg(120431075)
				local var_315_4 = arg_312_1:FormatText(var_315_3.content)

				arg_312_1.text_.text = var_315_4

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_5 = 20
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
	Play120431076 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 120431076
		arg_316_1.duration_ = 7.43

		local var_316_0 = {
			zh = 3.666,
			ja = 7.433
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
				arg_316_0:Play120431077(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0
			local var_319_1 = 0.35

			if var_319_0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_2 = arg_316_1:FormatText(StoryNameCfg[319].name)

				arg_316_1.leftNameTxt_.text = var_319_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_3 = arg_316_1:GetWordFromCfg(120431076)
				local var_319_4 = arg_316_1:FormatText(var_319_3.content)

				arg_316_1.text_.text = var_319_4

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431076", "story_v_out_120431.awb") ~= 0 then
					local var_319_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431076", "story_v_out_120431.awb") / 1000

					if var_319_8 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_8 + var_319_0
					end

					if var_319_3.prefab_name ~= "" and arg_316_1.actors_[var_319_3.prefab_name] ~= nil then
						local var_319_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_3.prefab_name].transform, "story_v_out_120431", "120431076", "story_v_out_120431.awb")

						arg_316_1:RecordAudio("120431076", var_319_9)
						arg_316_1:RecordAudio("120431076", var_319_9)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_120431", "120431076", "story_v_out_120431.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_120431", "120431076", "story_v_out_120431.awb")
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
	Play120431077 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 120431077
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play120431078(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0
			local var_323_1 = 0.575

			if var_323_0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_2 = arg_320_1:FormatText(StoryNameCfg[7].name)

				arg_320_1.leftNameTxt_.text = var_323_2

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

				local var_323_3 = arg_320_1:GetWordFromCfg(120431077)
				local var_323_4 = arg_320_1:FormatText(var_323_3.content)

				arg_320_1.text_.text = var_323_4

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_5 = 22
				local var_323_6 = utf8.len(var_323_4)
				local var_323_7 = var_323_5 <= 0 and var_323_1 or var_323_1 * (var_323_6 / var_323_5)

				if var_323_7 > 0 and var_323_1 < var_323_7 then
					arg_320_1.talkMaxDuration = var_323_7

					if var_323_7 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_7 + var_323_0
					end
				end

				arg_320_1.text_.text = var_323_4
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_8 = math.max(var_323_1, arg_320_1.talkMaxDuration)

			if var_323_0 <= arg_320_1.time_ and arg_320_1.time_ < var_323_0 + var_323_8 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_0) / var_323_8

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_0 + var_323_8 and arg_320_1.time_ < var_323_0 + var_323_8 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play120431078 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 120431078
		arg_324_1.duration_ = 4.9

		local var_324_0 = {
			zh = 4.9,
			ja = 4.366
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
				arg_324_0:Play120431079(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0
			local var_327_1 = 0.5

			if var_327_0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_2 = arg_324_1:FormatText(StoryNameCfg[378].name)

				arg_324_1.leftNameTxt_.text = var_327_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_3 = arg_324_1:GetWordFromCfg(120431078)
				local var_327_4 = arg_324_1:FormatText(var_327_3.content)

				arg_324_1.text_.text = var_327_4

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_5 = 20
				local var_327_6 = utf8.len(var_327_4)
				local var_327_7 = var_327_5 <= 0 and var_327_1 or var_327_1 * (var_327_6 / var_327_5)

				if var_327_7 > 0 and var_327_1 < var_327_7 then
					arg_324_1.talkMaxDuration = var_327_7

					if var_327_7 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_7 + var_327_0
					end
				end

				arg_324_1.text_.text = var_327_4
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431078", "story_v_out_120431.awb") ~= 0 then
					local var_327_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431078", "story_v_out_120431.awb") / 1000

					if var_327_8 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_8 + var_327_0
					end

					if var_327_3.prefab_name ~= "" and arg_324_1.actors_[var_327_3.prefab_name] ~= nil then
						local var_327_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_3.prefab_name].transform, "story_v_out_120431", "120431078", "story_v_out_120431.awb")

						arg_324_1:RecordAudio("120431078", var_327_9)
						arg_324_1:RecordAudio("120431078", var_327_9)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_120431", "120431078", "story_v_out_120431.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_120431", "120431078", "story_v_out_120431.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_10 = math.max(var_327_1, arg_324_1.talkMaxDuration)

			if var_327_0 <= arg_324_1.time_ and arg_324_1.time_ < var_327_0 + var_327_10 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_0) / var_327_10

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_0 + var_327_10 and arg_324_1.time_ < var_327_0 + var_327_10 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play120431079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 120431079
		arg_328_1.duration_ = 4.97

		local var_328_0 = {
			zh = 3.7,
			ja = 4.966
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
				arg_328_0:Play120431080(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0
			local var_331_1 = 0.475

			if var_331_0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_2 = arg_328_1:FormatText(StoryNameCfg[6].name)

				arg_328_1.leftNameTxt_.text = var_331_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_3 = arg_328_1:GetWordFromCfg(120431079)
				local var_331_4 = arg_328_1:FormatText(var_331_3.content)

				arg_328_1.text_.text = var_331_4

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_5 = 19
				local var_331_6 = utf8.len(var_331_4)
				local var_331_7 = var_331_5 <= 0 and var_331_1 or var_331_1 * (var_331_6 / var_331_5)

				if var_331_7 > 0 and var_331_1 < var_331_7 then
					arg_328_1.talkMaxDuration = var_331_7

					if var_331_7 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_7 + var_331_0
					end
				end

				arg_328_1.text_.text = var_331_4
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431079", "story_v_out_120431.awb") ~= 0 then
					local var_331_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431079", "story_v_out_120431.awb") / 1000

					if var_331_8 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_8 + var_331_0
					end

					if var_331_3.prefab_name ~= "" and arg_328_1.actors_[var_331_3.prefab_name] ~= nil then
						local var_331_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_3.prefab_name].transform, "story_v_out_120431", "120431079", "story_v_out_120431.awb")

						arg_328_1:RecordAudio("120431079", var_331_9)
						arg_328_1:RecordAudio("120431079", var_331_9)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_120431", "120431079", "story_v_out_120431.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_120431", "120431079", "story_v_out_120431.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_10 = math.max(var_331_1, arg_328_1.talkMaxDuration)

			if var_331_0 <= arg_328_1.time_ and arg_328_1.time_ < var_331_0 + var_331_10 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_0) / var_331_10

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_0 + var_331_10 and arg_328_1.time_ < var_331_0 + var_331_10 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play120431080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 120431080
		arg_332_1.duration_ = 4.9

		local var_332_0 = {
			zh = 2.9,
			ja = 4.9
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
				arg_332_0:Play120431081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0
			local var_335_1 = 0.4

			if var_335_0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_0 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_2 = arg_332_1:FormatText(StoryNameCfg[378].name)

				arg_332_1.leftNameTxt_.text = var_335_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_3 = arg_332_1:GetWordFromCfg(120431080)
				local var_335_4 = arg_332_1:FormatText(var_335_3.content)

				arg_332_1.text_.text = var_335_4

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_5 = 16
				local var_335_6 = utf8.len(var_335_4)
				local var_335_7 = var_335_5 <= 0 and var_335_1 or var_335_1 * (var_335_6 / var_335_5)

				if var_335_7 > 0 and var_335_1 < var_335_7 then
					arg_332_1.talkMaxDuration = var_335_7

					if var_335_7 + var_335_0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_7 + var_335_0
					end
				end

				arg_332_1.text_.text = var_335_4
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431080", "story_v_out_120431.awb") ~= 0 then
					local var_335_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431080", "story_v_out_120431.awb") / 1000

					if var_335_8 + var_335_0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_8 + var_335_0
					end

					if var_335_3.prefab_name ~= "" and arg_332_1.actors_[var_335_3.prefab_name] ~= nil then
						local var_335_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_3.prefab_name].transform, "story_v_out_120431", "120431080", "story_v_out_120431.awb")

						arg_332_1:RecordAudio("120431080", var_335_9)
						arg_332_1:RecordAudio("120431080", var_335_9)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_120431", "120431080", "story_v_out_120431.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_120431", "120431080", "story_v_out_120431.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_10 = math.max(var_335_1, arg_332_1.talkMaxDuration)

			if var_335_0 <= arg_332_1.time_ and arg_332_1.time_ < var_335_0 + var_335_10 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_0) / var_335_10

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_0 + var_335_10 and arg_332_1.time_ < var_335_0 + var_335_10 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play120431081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 120431081
		arg_336_1.duration_ = 6.83

		local var_336_0 = {
			zh = 6.833,
			ja = 5.833
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
				arg_336_0:Play120431082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0
			local var_339_1 = 0.625

			if var_339_0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_2 = arg_336_1:FormatText(StoryNameCfg[381].name)

				arg_336_1.leftNameTxt_.text = var_339_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_3 = arg_336_1:GetWordFromCfg(120431081)
				local var_339_4 = arg_336_1:FormatText(var_339_3.content)

				arg_336_1.text_.text = var_339_4

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_5 = 25
				local var_339_6 = utf8.len(var_339_4)
				local var_339_7 = var_339_5 <= 0 and var_339_1 or var_339_1 * (var_339_6 / var_339_5)

				if var_339_7 > 0 and var_339_1 < var_339_7 then
					arg_336_1.talkMaxDuration = var_339_7

					if var_339_7 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_7 + var_339_0
					end
				end

				arg_336_1.text_.text = var_339_4
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431081", "story_v_out_120431.awb") ~= 0 then
					local var_339_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431081", "story_v_out_120431.awb") / 1000

					if var_339_8 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_8 + var_339_0
					end

					if var_339_3.prefab_name ~= "" and arg_336_1.actors_[var_339_3.prefab_name] ~= nil then
						local var_339_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_3.prefab_name].transform, "story_v_out_120431", "120431081", "story_v_out_120431.awb")

						arg_336_1:RecordAudio("120431081", var_339_9)
						arg_336_1:RecordAudio("120431081", var_339_9)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_120431", "120431081", "story_v_out_120431.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_120431", "120431081", "story_v_out_120431.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_10 = math.max(var_339_1, arg_336_1.talkMaxDuration)

			if var_339_0 <= arg_336_1.time_ and arg_336_1.time_ < var_339_0 + var_339_10 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_0) / var_339_10

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_0 + var_339_10 and arg_336_1.time_ < var_339_0 + var_339_10 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play120431082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 120431082
		arg_340_1.duration_ = 5.7

		local var_340_0 = {
			zh = 4.266,
			ja = 5.7
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play120431083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0
			local var_343_1 = 0.55

			if var_343_0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_2 = arg_340_1:FormatText(StoryNameCfg[378].name)

				arg_340_1.leftNameTxt_.text = var_343_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_3 = arg_340_1:GetWordFromCfg(120431082)
				local var_343_4 = arg_340_1:FormatText(var_343_3.content)

				arg_340_1.text_.text = var_343_4

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_5 = 22
				local var_343_6 = utf8.len(var_343_4)
				local var_343_7 = var_343_5 <= 0 and var_343_1 or var_343_1 * (var_343_6 / var_343_5)

				if var_343_7 > 0 and var_343_1 < var_343_7 then
					arg_340_1.talkMaxDuration = var_343_7

					if var_343_7 + var_343_0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_7 + var_343_0
					end
				end

				arg_340_1.text_.text = var_343_4
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431082", "story_v_out_120431.awb") ~= 0 then
					local var_343_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431082", "story_v_out_120431.awb") / 1000

					if var_343_8 + var_343_0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_8 + var_343_0
					end

					if var_343_3.prefab_name ~= "" and arg_340_1.actors_[var_343_3.prefab_name] ~= nil then
						local var_343_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_3.prefab_name].transform, "story_v_out_120431", "120431082", "story_v_out_120431.awb")

						arg_340_1:RecordAudio("120431082", var_343_9)
						arg_340_1:RecordAudio("120431082", var_343_9)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_120431", "120431082", "story_v_out_120431.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_120431", "120431082", "story_v_out_120431.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_10 = math.max(var_343_1, arg_340_1.talkMaxDuration)

			if var_343_0 <= arg_340_1.time_ and arg_340_1.time_ < var_343_0 + var_343_10 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_0) / var_343_10

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_0 + var_343_10 and arg_340_1.time_ < var_343_0 + var_343_10 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play120431083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 120431083
		arg_344_1.duration_ = 13.1

		local var_344_0 = {
			zh = 12,
			ja = 13.1
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
				arg_344_0:Play120431084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0
			local var_347_1 = 1.25

			if var_347_0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_2 = arg_344_1:FormatText(StoryNameCfg[389].name)

				arg_344_1.leftNameTxt_.text = var_347_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_3 = arg_344_1:GetWordFromCfg(120431083)
				local var_347_4 = arg_344_1:FormatText(var_347_3.content)

				arg_344_1.text_.text = var_347_4

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_5 = 50
				local var_347_6 = utf8.len(var_347_4)
				local var_347_7 = var_347_5 <= 0 and var_347_1 or var_347_1 * (var_347_6 / var_347_5)

				if var_347_7 > 0 and var_347_1 < var_347_7 then
					arg_344_1.talkMaxDuration = var_347_7

					if var_347_7 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_7 + var_347_0
					end
				end

				arg_344_1.text_.text = var_347_4
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431083", "story_v_out_120431.awb") ~= 0 then
					local var_347_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431083", "story_v_out_120431.awb") / 1000

					if var_347_8 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_8 + var_347_0
					end

					if var_347_3.prefab_name ~= "" and arg_344_1.actors_[var_347_3.prefab_name] ~= nil then
						local var_347_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_3.prefab_name].transform, "story_v_out_120431", "120431083", "story_v_out_120431.awb")

						arg_344_1:RecordAudio("120431083", var_347_9)
						arg_344_1:RecordAudio("120431083", var_347_9)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_120431", "120431083", "story_v_out_120431.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_120431", "120431083", "story_v_out_120431.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_10 = math.max(var_347_1, arg_344_1.talkMaxDuration)

			if var_347_0 <= arg_344_1.time_ and arg_344_1.time_ < var_347_0 + var_347_10 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_0) / var_347_10

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_0 + var_347_10 and arg_344_1.time_ < var_347_0 + var_347_10 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play120431084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 120431084
		arg_348_1.duration_ = 5.3

		local var_348_0 = {
			zh = 3.1,
			ja = 5.3
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
				arg_348_0:Play120431085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0
			local var_351_1 = 0.275

			if var_351_0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_2 = arg_348_1:FormatText(StoryNameCfg[389].name)

				arg_348_1.leftNameTxt_.text = var_351_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_3 = arg_348_1:GetWordFromCfg(120431084)
				local var_351_4 = arg_348_1:FormatText(var_351_3.content)

				arg_348_1.text_.text = var_351_4

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431084", "story_v_out_120431.awb") ~= 0 then
					local var_351_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431084", "story_v_out_120431.awb") / 1000

					if var_351_8 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_8 + var_351_0
					end

					if var_351_3.prefab_name ~= "" and arg_348_1.actors_[var_351_3.prefab_name] ~= nil then
						local var_351_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_3.prefab_name].transform, "story_v_out_120431", "120431084", "story_v_out_120431.awb")

						arg_348_1:RecordAudio("120431084", var_351_9)
						arg_348_1:RecordAudio("120431084", var_351_9)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_120431", "120431084", "story_v_out_120431.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_120431", "120431084", "story_v_out_120431.awb")
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
	Play120431085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 120431085
		arg_352_1.duration_ = 8.37

		local var_352_0 = {
			zh = 5.966,
			ja = 8.366
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
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play120431086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 0
			local var_355_1 = 0.65

			if var_355_0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_2 = arg_352_1:FormatText(StoryNameCfg[319].name)

				arg_352_1.leftNameTxt_.text = var_355_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_3 = arg_352_1:GetWordFromCfg(120431085)
				local var_355_4 = arg_352_1:FormatText(var_355_3.content)

				arg_352_1.text_.text = var_355_4

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_5 = 26
				local var_355_6 = utf8.len(var_355_4)
				local var_355_7 = var_355_5 <= 0 and var_355_1 or var_355_1 * (var_355_6 / var_355_5)

				if var_355_7 > 0 and var_355_1 < var_355_7 then
					arg_352_1.talkMaxDuration = var_355_7

					if var_355_7 + var_355_0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_7 + var_355_0
					end
				end

				arg_352_1.text_.text = var_355_4
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431085", "story_v_out_120431.awb") ~= 0 then
					local var_355_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431085", "story_v_out_120431.awb") / 1000

					if var_355_8 + var_355_0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_8 + var_355_0
					end

					if var_355_3.prefab_name ~= "" and arg_352_1.actors_[var_355_3.prefab_name] ~= nil then
						local var_355_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_3.prefab_name].transform, "story_v_out_120431", "120431085", "story_v_out_120431.awb")

						arg_352_1:RecordAudio("120431085", var_355_9)
						arg_352_1:RecordAudio("120431085", var_355_9)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_120431", "120431085", "story_v_out_120431.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_120431", "120431085", "story_v_out_120431.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_10 = math.max(var_355_1, arg_352_1.talkMaxDuration)

			if var_355_0 <= arg_352_1.time_ and arg_352_1.time_ < var_355_0 + var_355_10 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_0) / var_355_10

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_0 + var_355_10 and arg_352_1.time_ < var_355_0 + var_355_10 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play120431086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 120431086
		arg_356_1.duration_ = 6

		local var_356_0 = {
			zh = 4.533,
			ja = 6
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play120431087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0
			local var_359_1 = 0.3

			if var_359_0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_2 = arg_356_1:FormatText(StoryNameCfg[389].name)

				arg_356_1.leftNameTxt_.text = var_359_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_3 = arg_356_1:GetWordFromCfg(120431086)
				local var_359_4 = arg_356_1:FormatText(var_359_3.content)

				arg_356_1.text_.text = var_359_4

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_5 = 12
				local var_359_6 = utf8.len(var_359_4)
				local var_359_7 = var_359_5 <= 0 and var_359_1 or var_359_1 * (var_359_6 / var_359_5)

				if var_359_7 > 0 and var_359_1 < var_359_7 then
					arg_356_1.talkMaxDuration = var_359_7

					if var_359_7 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_7 + var_359_0
					end
				end

				arg_356_1.text_.text = var_359_4
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431086", "story_v_out_120431.awb") ~= 0 then
					local var_359_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431086", "story_v_out_120431.awb") / 1000

					if var_359_8 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_8 + var_359_0
					end

					if var_359_3.prefab_name ~= "" and arg_356_1.actors_[var_359_3.prefab_name] ~= nil then
						local var_359_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_3.prefab_name].transform, "story_v_out_120431", "120431086", "story_v_out_120431.awb")

						arg_356_1:RecordAudio("120431086", var_359_9)
						arg_356_1:RecordAudio("120431086", var_359_9)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_120431", "120431086", "story_v_out_120431.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_120431", "120431086", "story_v_out_120431.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_10 = math.max(var_359_1, arg_356_1.talkMaxDuration)

			if var_359_0 <= arg_356_1.time_ and arg_356_1.time_ < var_359_0 + var_359_10 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_0) / var_359_10

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_0 + var_359_10 and arg_356_1.time_ < var_359_0 + var_359_10 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play120431087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 120431087
		arg_360_1.duration_ = 5.07

		local var_360_0 = {
			zh = 4.8,
			ja = 5.066
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play120431088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0
			local var_363_1 = 0.4

			if var_363_0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_2 = arg_360_1:FormatText(StoryNameCfg[319].name)

				arg_360_1.leftNameTxt_.text = var_363_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_3 = arg_360_1:GetWordFromCfg(120431087)
				local var_363_4 = arg_360_1:FormatText(var_363_3.content)

				arg_360_1.text_.text = var_363_4

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_5 = 16
				local var_363_6 = utf8.len(var_363_4)
				local var_363_7 = var_363_5 <= 0 and var_363_1 or var_363_1 * (var_363_6 / var_363_5)

				if var_363_7 > 0 and var_363_1 < var_363_7 then
					arg_360_1.talkMaxDuration = var_363_7

					if var_363_7 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_7 + var_363_0
					end
				end

				arg_360_1.text_.text = var_363_4
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431087", "story_v_out_120431.awb") ~= 0 then
					local var_363_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431087", "story_v_out_120431.awb") / 1000

					if var_363_8 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_8 + var_363_0
					end

					if var_363_3.prefab_name ~= "" and arg_360_1.actors_[var_363_3.prefab_name] ~= nil then
						local var_363_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_3.prefab_name].transform, "story_v_out_120431", "120431087", "story_v_out_120431.awb")

						arg_360_1:RecordAudio("120431087", var_363_9)
						arg_360_1:RecordAudio("120431087", var_363_9)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_120431", "120431087", "story_v_out_120431.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_120431", "120431087", "story_v_out_120431.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_10 = math.max(var_363_1, arg_360_1.talkMaxDuration)

			if var_363_0 <= arg_360_1.time_ and arg_360_1.time_ < var_363_0 + var_363_10 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_0) / var_363_10

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_0 + var_363_10 and arg_360_1.time_ < var_363_0 + var_363_10 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play120431088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 120431088
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play120431089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0
			local var_367_1 = 0.875

			if var_367_0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_2 = arg_364_1:FormatText(StoryNameCfg[7].name)

				arg_364_1.leftNameTxt_.text = var_367_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_3 = arg_364_1:GetWordFromCfg(120431088)
				local var_367_4 = arg_364_1:FormatText(var_367_3.content)

				arg_364_1.text_.text = var_367_4

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_5 = 35
				local var_367_6 = utf8.len(var_367_4)
				local var_367_7 = var_367_5 <= 0 and var_367_1 or var_367_1 * (var_367_6 / var_367_5)

				if var_367_7 > 0 and var_367_1 < var_367_7 then
					arg_364_1.talkMaxDuration = var_367_7

					if var_367_7 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_7 + var_367_0
					end
				end

				arg_364_1.text_.text = var_367_4
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_8 = math.max(var_367_1, arg_364_1.talkMaxDuration)

			if var_367_0 <= arg_364_1.time_ and arg_364_1.time_ < var_367_0 + var_367_8 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_0) / var_367_8

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_0 + var_367_8 and arg_364_1.time_ < var_367_0 + var_367_8 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play120431089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 120431089
		arg_368_1.duration_ = 9.03

		local var_368_0 = {
			zh = 5.3,
			ja = 9.033
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play120431090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0
			local var_371_1 = 0.45

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_2 = arg_368_1:FormatText(StoryNameCfg[389].name)

				arg_368_1.leftNameTxt_.text = var_371_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_3 = arg_368_1:GetWordFromCfg(120431089)
				local var_371_4 = arg_368_1:FormatText(var_371_3.content)

				arg_368_1.text_.text = var_371_4

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_5 = 18
				local var_371_6 = utf8.len(var_371_4)
				local var_371_7 = var_371_5 <= 0 and var_371_1 or var_371_1 * (var_371_6 / var_371_5)

				if var_371_7 > 0 and var_371_1 < var_371_7 then
					arg_368_1.talkMaxDuration = var_371_7

					if var_371_7 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_7 + var_371_0
					end
				end

				arg_368_1.text_.text = var_371_4
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431089", "story_v_out_120431.awb") ~= 0 then
					local var_371_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431089", "story_v_out_120431.awb") / 1000

					if var_371_8 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_8 + var_371_0
					end

					if var_371_3.prefab_name ~= "" and arg_368_1.actors_[var_371_3.prefab_name] ~= nil then
						local var_371_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_3.prefab_name].transform, "story_v_out_120431", "120431089", "story_v_out_120431.awb")

						arg_368_1:RecordAudio("120431089", var_371_9)
						arg_368_1:RecordAudio("120431089", var_371_9)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_120431", "120431089", "story_v_out_120431.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_120431", "120431089", "story_v_out_120431.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_10 = math.max(var_371_1, arg_368_1.talkMaxDuration)

			if var_371_0 <= arg_368_1.time_ and arg_368_1.time_ < var_371_0 + var_371_10 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_0) / var_371_10

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_0 + var_371_10 and arg_368_1.time_ < var_371_0 + var_371_10 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play120431090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 120431090
		arg_372_1.duration_ = 9.57

		local var_372_0 = {
			zh = 3.766,
			ja = 9.566
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
				arg_372_0:Play120431091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0
			local var_375_1 = 0.6

			if var_375_0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_2 = arg_372_1:FormatText(StoryNameCfg[389].name)

				arg_372_1.leftNameTxt_.text = var_375_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_3 = arg_372_1:GetWordFromCfg(120431090)
				local var_375_4 = arg_372_1:FormatText(var_375_3.content)

				arg_372_1.text_.text = var_375_4

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_5 = 24
				local var_375_6 = utf8.len(var_375_4)
				local var_375_7 = var_375_5 <= 0 and var_375_1 or var_375_1 * (var_375_6 / var_375_5)

				if var_375_7 > 0 and var_375_1 < var_375_7 then
					arg_372_1.talkMaxDuration = var_375_7

					if var_375_7 + var_375_0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_7 + var_375_0
					end
				end

				arg_372_1.text_.text = var_375_4
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431090", "story_v_out_120431.awb") ~= 0 then
					local var_375_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431090", "story_v_out_120431.awb") / 1000

					if var_375_8 + var_375_0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_8 + var_375_0
					end

					if var_375_3.prefab_name ~= "" and arg_372_1.actors_[var_375_3.prefab_name] ~= nil then
						local var_375_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_3.prefab_name].transform, "story_v_out_120431", "120431090", "story_v_out_120431.awb")

						arg_372_1:RecordAudio("120431090", var_375_9)
						arg_372_1:RecordAudio("120431090", var_375_9)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_120431", "120431090", "story_v_out_120431.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_120431", "120431090", "story_v_out_120431.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_10 = math.max(var_375_1, arg_372_1.talkMaxDuration)

			if var_375_0 <= arg_372_1.time_ and arg_372_1.time_ < var_375_0 + var_375_10 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_0) / var_375_10

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_0 + var_375_10 and arg_372_1.time_ < var_375_0 + var_375_10 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play120431091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 120431091
		arg_376_1.duration_ = 0.02

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"

			SetActive(arg_376_1.choicesGo_, true)

			for iter_377_0, iter_377_1 in ipairs(arg_376_1.choices_) do
				local var_377_0 = iter_377_0 <= 1

				SetActive(iter_377_1.go, var_377_0)
			end

			arg_376_1.choices_[1].txt.text = arg_376_1:FormatText(StoryChoiceCfg[388].name)
			arg_376_1.choices_[2].txt.text = arg_376_1:FormatText(StoryChoiceCfg[389].name)
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play120431092(arg_376_1)
			end

			arg_376_1:RecordChoiceLog(120431091, 388, 389)
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			return
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play120431092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 120431092
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play120431093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0
			local var_383_1 = 0.35

			if var_383_0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_2 = arg_380_1:FormatText(StoryNameCfg[7].name)

				arg_380_1.leftNameTxt_.text = var_383_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_3 = arg_380_1:GetWordFromCfg(120431092)
				local var_383_4 = arg_380_1:FormatText(var_383_3.content)

				arg_380_1.text_.text = var_383_4

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_5 = 14
				local var_383_6 = utf8.len(var_383_4)
				local var_383_7 = var_383_5 <= 0 and var_383_1 or var_383_1 * (var_383_6 / var_383_5)

				if var_383_7 > 0 and var_383_1 < var_383_7 then
					arg_380_1.talkMaxDuration = var_383_7

					if var_383_7 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_7 + var_383_0
					end
				end

				arg_380_1.text_.text = var_383_4
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_8 = math.max(var_383_1, arg_380_1.talkMaxDuration)

			if var_383_0 <= arg_380_1.time_ and arg_380_1.time_ < var_383_0 + var_383_8 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_0) / var_383_8

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_0 + var_383_8 and arg_380_1.time_ < var_383_0 + var_383_8 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play120431093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 120431093
		arg_384_1.duration_ = 5.03

		local var_384_0 = {
			zh = 2.233,
			ja = 5.033
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play120431094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0
			local var_387_1 = 0.275

			if var_387_0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_2 = arg_384_1:FormatText(StoryNameCfg[6].name)

				arg_384_1.leftNameTxt_.text = var_387_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_3 = arg_384_1:GetWordFromCfg(120431093)
				local var_387_4 = arg_384_1:FormatText(var_387_3.content)

				arg_384_1.text_.text = var_387_4

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_5 = 11
				local var_387_6 = utf8.len(var_387_4)
				local var_387_7 = var_387_5 <= 0 and var_387_1 or var_387_1 * (var_387_6 / var_387_5)

				if var_387_7 > 0 and var_387_1 < var_387_7 then
					arg_384_1.talkMaxDuration = var_387_7

					if var_387_7 + var_387_0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_7 + var_387_0
					end
				end

				arg_384_1.text_.text = var_387_4
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431093", "story_v_out_120431.awb") ~= 0 then
					local var_387_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431093", "story_v_out_120431.awb") / 1000

					if var_387_8 + var_387_0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_8 + var_387_0
					end

					if var_387_3.prefab_name ~= "" and arg_384_1.actors_[var_387_3.prefab_name] ~= nil then
						local var_387_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_3.prefab_name].transform, "story_v_out_120431", "120431093", "story_v_out_120431.awb")

						arg_384_1:RecordAudio("120431093", var_387_9)
						arg_384_1:RecordAudio("120431093", var_387_9)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_120431", "120431093", "story_v_out_120431.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_120431", "120431093", "story_v_out_120431.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_10 = math.max(var_387_1, arg_384_1.talkMaxDuration)

			if var_387_0 <= arg_384_1.time_ and arg_384_1.time_ < var_387_0 + var_387_10 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_0) / var_387_10

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_0 + var_387_10 and arg_384_1.time_ < var_387_0 + var_387_10 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play120431094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 120431094
		arg_388_1.duration_ = 4.3

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play120431095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 2

			if var_391_0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_0 + arg_391_0 then
				arg_388_1.fswbg_:SetActive(true)
				arg_388_1.dialog_:SetActive(false)

				arg_388_1.fswtw_.percent = 0

				local var_391_1 = arg_388_1:GetWordFromCfg(120431094)
				local var_391_2 = arg_388_1:FormatText(var_391_1.content)

				arg_388_1.fswt_.text = var_391_2

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.fswt_)

				arg_388_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_388_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_388_1.fswtw_:SetDirty()

				arg_388_1.typewritterCharCountI18N = 0

				SetActive(arg_388_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_388_1:ShowNextGo(false)
			end

			local var_391_3 = 2.01666666666667

			if var_391_3 < arg_388_1.time_ and arg_388_1.time_ <= var_391_3 + arg_391_0 then
				arg_388_1.var_.oldValueTypewriter = arg_388_1.fswtw_.percent

				SetActive(arg_388_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_388_1:ShowNextGo(false)
			end

			local var_391_4 = 21
			local var_391_5 = 1.4
			local var_391_6 = arg_388_1:GetWordFromCfg(120431094)
			local var_391_7 = arg_388_1:FormatText(var_391_6.content)
			local var_391_8, var_391_9 = arg_388_1:GetPercentByPara(var_391_7, 1)

			if var_391_3 < arg_388_1.time_ and arg_388_1.time_ <= var_391_3 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0

				local var_391_10 = var_391_4 <= 0 and var_391_5 or var_391_5 * ((var_391_9 - arg_388_1.typewritterCharCountI18N) / var_391_4)

				if var_391_10 > 0 and var_391_5 < var_391_10 then
					arg_388_1.talkMaxDuration = var_391_10

					if var_391_10 + var_391_3 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_10 + var_391_3
					end
				end
			end

			local var_391_11 = 1.4
			local var_391_12 = math.max(var_391_11, arg_388_1.talkMaxDuration)

			if var_391_3 <= arg_388_1.time_ and arg_388_1.time_ < var_391_3 + var_391_12 then
				local var_391_13 = (arg_388_1.time_ - var_391_3) / var_391_12

				arg_388_1.fswtw_.percent = Mathf.Lerp(arg_388_1.var_.oldValueTypewriter, var_391_8, var_391_13)
				arg_388_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_388_1.fswtw_:SetDirty()
			end

			if arg_388_1.time_ >= var_391_3 + var_391_12 and arg_388_1.time_ < var_391_3 + var_391_12 + arg_391_0 then
				arg_388_1.fswtw_.percent = var_391_8

				arg_388_1.fswtw_:SetDirty()
				arg_388_1:ShowNextGo(true)

				arg_388_1.typewritterCharCountI18N = var_391_9
			end

			local var_391_14 = 0

			if var_391_14 < arg_388_1.time_ and arg_388_1.time_ <= var_391_14 + arg_391_0 then
				arg_388_1.mask_.enabled = true
				arg_388_1.mask_.raycastTarget = true

				arg_388_1:SetGaussion(false)
			end

			local var_391_15 = 2

			if var_391_14 <= arg_388_1.time_ and arg_388_1.time_ < var_391_14 + var_391_15 then
				local var_391_16 = (arg_388_1.time_ - var_391_14) / var_391_15
				local var_391_17 = Color.New(0, 0, 0)

				var_391_17.a = Mathf.Lerp(0, 1, var_391_16)
				arg_388_1.mask_.color = var_391_17
			end

			if arg_388_1.time_ >= var_391_14 + var_391_15 and arg_388_1.time_ < var_391_14 + var_391_15 + arg_391_0 then
				local var_391_18 = Color.New(0, 0, 0)

				var_391_18.a = 1
				arg_388_1.mask_.color = var_391_18
			end

			local var_391_19 = 2

			if var_391_19 < arg_388_1.time_ and arg_388_1.time_ <= var_391_19 + arg_391_0 then
				arg_388_1.mask_.enabled = true
				arg_388_1.mask_.raycastTarget = true

				arg_388_1:SetGaussion(false)
			end

			local var_391_20 = 2

			if var_391_19 <= arg_388_1.time_ and arg_388_1.time_ < var_391_19 + var_391_20 then
				local var_391_21 = (arg_388_1.time_ - var_391_19) / var_391_20
				local var_391_22 = Color.New(0, 0, 0)

				var_391_22.a = Mathf.Lerp(1, 0, var_391_21)
				arg_388_1.mask_.color = var_391_22
			end

			if arg_388_1.time_ >= var_391_19 + var_391_20 and arg_388_1.time_ < var_391_19 + var_391_20 + arg_391_0 then
				local var_391_23 = Color.New(0, 0, 0)
				local var_391_24 = 0

				arg_388_1.mask_.enabled = false
				var_391_23.a = var_391_24
				arg_388_1.mask_.color = var_391_23
			end

			local var_391_25 = 2

			if var_391_25 < arg_388_1.time_ and arg_388_1.time_ <= var_391_25 + arg_391_0 then
				local var_391_26 = arg_388_1.fswbg_.transform:Find("textbox/adapt/content") or arg_388_1.fswbg_.transform:Find("textbox/content")
				local var_391_27 = arg_388_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_391_28 = var_391_26:GetComponent("Text")
				local var_391_29 = var_391_26:GetComponent("RectTransform")

				var_391_28.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_391_29.offsetMin = Vector2.New(0, 0)
				var_391_29.offsetMax = Vector2.New(0, 0)
			end

			local var_391_30 = 1.7
			local var_391_31 = 1

			if var_391_30 < arg_388_1.time_ and arg_388_1.time_ <= var_391_30 + arg_391_0 then
				local var_391_32 = "play"
				local var_391_33 = "music"

				arg_388_1:AudioAction(var_391_32, var_391_33, "ui_battle", "ui_battle_stopbgm", "")

				local var_391_34 = ""
				local var_391_35 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_391_35 ~= "" then
					if arg_388_1.bgmTxt_.text ~= var_391_35 and arg_388_1.bgmTxt_.text ~= "" then
						if arg_388_1.bgmTxt2_.text ~= "" then
							arg_388_1.bgmTxt_.text = arg_388_1.bgmTxt2_.text
						end

						arg_388_1.bgmTxt2_.text = var_391_35

						arg_388_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_388_1.bgmTxt_.text = var_391_35
						arg_388_1.bgmTxt2_.text = var_391_35
					end

					if arg_388_1.bgmTimer then
						arg_388_1.bgmTimer:Stop()

						arg_388_1.bgmTimer = nil
					end

					if arg_388_1.settingData.show_music_name == 1 then
						arg_388_1.musicController:SetSelectedState("show")
						arg_388_1.musicAnimator_:Play("open", 0, 0)

						if arg_388_1.settingData.music_time ~= 0 then
							arg_388_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_388_1.settingData.music_time), function()
								if arg_388_1 == nil or isNil(arg_388_1.bgmTxt_) then
									return
								end

								arg_388_1.musicController:SetSelectedState("hide")
								arg_388_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play120431095 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 120431095
		arg_393_1.duration_ = 2.02

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play120431096(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0

			if var_396_0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_0 + arg_396_0 then
				arg_393_1.fswbg_:SetActive(true)
				arg_393_1.dialog_:SetActive(false)

				arg_393_1.fswtw_.percent = 0

				local var_396_1 = arg_393_1:GetWordFromCfg(120431095)
				local var_396_2 = arg_393_1:FormatText(var_396_1.content)

				arg_393_1.fswt_.text = var_396_2

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.fswt_)

				arg_393_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_393_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_393_1.fswtw_:SetDirty()

				arg_393_1.typewritterCharCountI18N = 0

				SetActive(arg_393_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_393_1:ShowNextGo(false)
			end

			local var_396_3 = 0.0166666666666667

			if var_396_3 < arg_393_1.time_ and arg_393_1.time_ <= var_396_3 + arg_396_0 then
				arg_393_1.var_.oldValueTypewriter = arg_393_1.fswtw_.percent

				SetActive(arg_393_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_393_1:ShowNextGo(false)
			end

			local var_396_4 = 30
			local var_396_5 = 2
			local var_396_6 = arg_393_1:GetWordFromCfg(120431095)
			local var_396_7 = arg_393_1:FormatText(var_396_6.content)
			local var_396_8, var_396_9 = arg_393_1:GetPercentByPara(var_396_7, 1)

			if var_396_3 < arg_393_1.time_ and arg_393_1.time_ <= var_396_3 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0

				local var_396_10 = var_396_4 <= 0 and var_396_5 or var_396_5 * ((var_396_9 - arg_393_1.typewritterCharCountI18N) / var_396_4)

				if var_396_10 > 0 and var_396_5 < var_396_10 then
					arg_393_1.talkMaxDuration = var_396_10

					if var_396_10 + var_396_3 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_10 + var_396_3
					end
				end
			end

			local var_396_11 = 2
			local var_396_12 = math.max(var_396_11, arg_393_1.talkMaxDuration)

			if var_396_3 <= arg_393_1.time_ and arg_393_1.time_ < var_396_3 + var_396_12 then
				local var_396_13 = (arg_393_1.time_ - var_396_3) / var_396_12

				arg_393_1.fswtw_.percent = Mathf.Lerp(arg_393_1.var_.oldValueTypewriter, var_396_8, var_396_13)
				arg_393_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_393_1.fswtw_:SetDirty()
			end

			if arg_393_1.time_ >= var_396_3 + var_396_12 and arg_393_1.time_ < var_396_3 + var_396_12 + arg_396_0 then
				arg_393_1.fswtw_.percent = var_396_8

				arg_393_1.fswtw_:SetDirty()
				arg_393_1:ShowNextGo(true)

				arg_393_1.typewritterCharCountI18N = var_396_9
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play120431096 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 120431096
		arg_397_1.duration_ = 3.55

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play120431097(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0

			if var_400_0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_0 + arg_400_0 then
				arg_397_1.fswbg_:SetActive(true)
				arg_397_1.dialog_:SetActive(false)

				arg_397_1.fswtw_.percent = 0

				local var_400_1 = arg_397_1:GetWordFromCfg(120431096)
				local var_400_2 = arg_397_1:FormatText(var_400_1.content)

				arg_397_1.fswt_.text = var_400_2

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.fswt_)

				arg_397_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_397_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_397_1.fswtw_:SetDirty()

				arg_397_1.typewritterCharCountI18N = 0

				SetActive(arg_397_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_397_1:ShowNextGo(false)
			end

			local var_400_3 = 0.0166666666666666

			if var_400_3 < arg_397_1.time_ and arg_397_1.time_ <= var_400_3 + arg_400_0 then
				arg_397_1.var_.oldValueTypewriter = arg_397_1.fswtw_.percent

				SetActive(arg_397_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_397_1:ShowNextGo(false)
			end

			local var_400_4 = 53
			local var_400_5 = 3.53333333333333
			local var_400_6 = arg_397_1:GetWordFromCfg(120431096)
			local var_400_7 = arg_397_1:FormatText(var_400_6.content)
			local var_400_8, var_400_9 = arg_397_1:GetPercentByPara(var_400_7, 1)

			if var_400_3 < arg_397_1.time_ and arg_397_1.time_ <= var_400_3 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0

				local var_400_10 = var_400_4 <= 0 and var_400_5 or var_400_5 * ((var_400_9 - arg_397_1.typewritterCharCountI18N) / var_400_4)

				if var_400_10 > 0 and var_400_5 < var_400_10 then
					arg_397_1.talkMaxDuration = var_400_10

					if var_400_10 + var_400_3 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_10 + var_400_3
					end
				end
			end

			local var_400_11 = 3.53333333333333
			local var_400_12 = math.max(var_400_11, arg_397_1.talkMaxDuration)

			if var_400_3 <= arg_397_1.time_ and arg_397_1.time_ < var_400_3 + var_400_12 then
				local var_400_13 = (arg_397_1.time_ - var_400_3) / var_400_12

				arg_397_1.fswtw_.percent = Mathf.Lerp(arg_397_1.var_.oldValueTypewriter, var_400_8, var_400_13)
				arg_397_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_397_1.fswtw_:SetDirty()
			end

			if arg_397_1.time_ >= var_400_3 + var_400_12 and arg_397_1.time_ < var_400_3 + var_400_12 + arg_400_0 then
				arg_397_1.fswtw_.percent = var_400_8

				arg_397_1.fswtw_:SetDirty()
				arg_397_1:ShowNextGo(true)

				arg_397_1.typewritterCharCountI18N = var_400_9
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play120431097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 120431097
		arg_401_1.duration_ = 1

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play120431098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0

			if var_404_0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_0 + arg_404_0 then
				arg_401_1.fswbg_:SetActive(true)
				arg_401_1.dialog_:SetActive(false)

				arg_401_1.fswtw_.percent = 0

				local var_404_1 = arg_401_1:GetWordFromCfg(120431097)
				local var_404_2 = arg_401_1:FormatText(var_404_1.content)

				arg_401_1.fswt_.text = var_404_2

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.fswt_)

				arg_401_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_401_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_401_1.fswtw_:SetDirty()

				arg_401_1.typewritterCharCountI18N = 0

				SetActive(arg_401_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_401_1:ShowNextGo(false)
			end

			local var_404_3 = 0.0166666666666666

			if var_404_3 < arg_401_1.time_ and arg_401_1.time_ <= var_404_3 + arg_404_0 then
				arg_401_1.var_.oldValueTypewriter = arg_401_1.fswtw_.percent

				SetActive(arg_401_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_401_1:ShowNextGo(false)
			end

			local var_404_4 = 8
			local var_404_5 = 0.533333333333333
			local var_404_6 = arg_401_1:GetWordFromCfg(120431097)
			local var_404_7 = arg_401_1:FormatText(var_404_6.content)
			local var_404_8, var_404_9 = arg_401_1:GetPercentByPara(var_404_7, 1)

			if var_404_3 < arg_401_1.time_ and arg_401_1.time_ <= var_404_3 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0

				local var_404_10 = var_404_4 <= 0 and var_404_5 or var_404_5 * ((var_404_9 - arg_401_1.typewritterCharCountI18N) / var_404_4)

				if var_404_10 > 0 and var_404_5 < var_404_10 then
					arg_401_1.talkMaxDuration = var_404_10

					if var_404_10 + var_404_3 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_10 + var_404_3
					end
				end
			end

			local var_404_11 = 0.533333333333333
			local var_404_12 = math.max(var_404_11, arg_401_1.talkMaxDuration)

			if var_404_3 <= arg_401_1.time_ and arg_401_1.time_ < var_404_3 + var_404_12 then
				local var_404_13 = (arg_401_1.time_ - var_404_3) / var_404_12

				arg_401_1.fswtw_.percent = Mathf.Lerp(arg_401_1.var_.oldValueTypewriter, var_404_8, var_404_13)
				arg_401_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_401_1.fswtw_:SetDirty()
			end

			if arg_401_1.time_ >= var_404_3 + var_404_12 and arg_401_1.time_ < var_404_3 + var_404_12 + arg_404_0 then
				arg_401_1.fswtw_.percent = var_404_8

				arg_401_1.fswtw_:SetDirty()
				arg_401_1:ShowNextGo(true)

				arg_401_1.typewritterCharCountI18N = var_404_9
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play120431098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 120431098
		arg_405_1.duration_ = 7.57

		local var_405_0 = {
			zh = 6.366666666666,
			ja = 7.566
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
				arg_405_0:Play120431099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = "ST31a"

			if arg_405_1.bgs_[var_408_0] == nil then
				local var_408_1 = Object.Instantiate(arg_405_1.paintGo_)

				var_408_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_408_0)
				var_408_1.name = var_408_0
				var_408_1.transform.parent = arg_405_1.stage_.transform
				var_408_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_405_1.bgs_[var_408_0] = var_408_1
			end

			local var_408_2 = 2

			if var_408_2 < arg_405_1.time_ and arg_405_1.time_ <= var_408_2 + arg_408_0 then
				local var_408_3 = manager.ui.mainCamera.transform.localPosition
				local var_408_4 = Vector3.New(0, 0, 10) + Vector3.New(var_408_3.x, var_408_3.y, 0)
				local var_408_5 = arg_405_1.bgs_.ST31a

				var_408_5.transform.localPosition = var_408_4
				var_408_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_408_6 = var_408_5:GetComponent("SpriteRenderer")

				if var_408_6 and var_408_6.sprite then
					local var_408_7 = (var_408_5.transform.localPosition - var_408_3).z
					local var_408_8 = manager.ui.mainCameraCom_
					local var_408_9 = 2 * var_408_7 * Mathf.Tan(var_408_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_408_10 = var_408_9 * var_408_8.aspect
					local var_408_11 = var_408_6.sprite.bounds.size.x
					local var_408_12 = var_408_6.sprite.bounds.size.y
					local var_408_13 = var_408_10 / var_408_11
					local var_408_14 = var_408_9 / var_408_12
					local var_408_15 = var_408_14 < var_408_13 and var_408_13 or var_408_14

					var_408_5.transform.localScale = Vector3.New(var_408_15, var_408_15, 0)
				end

				for iter_408_0, iter_408_1 in pairs(arg_405_1.bgs_) do
					if iter_408_0 ~= "ST31a" then
						iter_408_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_408_16 = 0

			if var_408_16 < arg_405_1.time_ and arg_405_1.time_ <= var_408_16 + arg_408_0 then
				arg_405_1.mask_.enabled = true
				arg_405_1.mask_.raycastTarget = true

				arg_405_1:SetGaussion(false)
			end

			local var_408_17 = 2

			if var_408_16 <= arg_405_1.time_ and arg_405_1.time_ < var_408_16 + var_408_17 then
				local var_408_18 = (arg_405_1.time_ - var_408_16) / var_408_17
				local var_408_19 = Color.New(0, 0, 0)

				var_408_19.a = Mathf.Lerp(0, 1, var_408_18)
				arg_405_1.mask_.color = var_408_19
			end

			if arg_405_1.time_ >= var_408_16 + var_408_17 and arg_405_1.time_ < var_408_16 + var_408_17 + arg_408_0 then
				local var_408_20 = Color.New(0, 0, 0)

				var_408_20.a = 1
				arg_405_1.mask_.color = var_408_20
			end

			local var_408_21 = 2

			if var_408_21 < arg_405_1.time_ and arg_405_1.time_ <= var_408_21 + arg_408_0 then
				arg_405_1.mask_.enabled = true
				arg_405_1.mask_.raycastTarget = true

				arg_405_1:SetGaussion(false)
			end

			local var_408_22 = 2

			if var_408_21 <= arg_405_1.time_ and arg_405_1.time_ < var_408_21 + var_408_22 then
				local var_408_23 = (arg_405_1.time_ - var_408_21) / var_408_22
				local var_408_24 = Color.New(0, 0, 0)

				var_408_24.a = Mathf.Lerp(1, 0, var_408_23)
				arg_405_1.mask_.color = var_408_24
			end

			if arg_405_1.time_ >= var_408_21 + var_408_22 and arg_405_1.time_ < var_408_21 + var_408_22 + arg_408_0 then
				local var_408_25 = Color.New(0, 0, 0)
				local var_408_26 = 0

				arg_405_1.mask_.enabled = false
				var_408_25.a = var_408_26
				arg_405_1.mask_.color = var_408_25
			end

			local var_408_27 = 1.98333333333333

			if var_408_27 < arg_405_1.time_ and arg_405_1.time_ <= var_408_27 + arg_408_0 then
				arg_405_1.fswbg_:SetActive(false)
				arg_405_1.dialog_:SetActive(false)
				SetActive(arg_405_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_405_1:ShowNextGo(false)
			end

			local var_408_28 = arg_405_1.actors_["1029ui_story"].transform
			local var_408_29 = 3.8

			if var_408_29 < arg_405_1.time_ and arg_405_1.time_ <= var_408_29 + arg_408_0 then
				arg_405_1.var_.moveOldPos1029ui_story = var_408_28.localPosition
			end

			local var_408_30 = 0.001

			if var_408_29 <= arg_405_1.time_ and arg_405_1.time_ < var_408_29 + var_408_30 then
				local var_408_31 = (arg_405_1.time_ - var_408_29) / var_408_30
				local var_408_32 = Vector3.New(0, -1.09, -6.2)

				var_408_28.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1029ui_story, var_408_32, var_408_31)

				local var_408_33 = manager.ui.mainCamera.transform.position - var_408_28.position

				var_408_28.forward = Vector3.New(var_408_33.x, var_408_33.y, var_408_33.z)

				local var_408_34 = var_408_28.localEulerAngles

				var_408_34.z = 0
				var_408_34.x = 0
				var_408_28.localEulerAngles = var_408_34
			end

			if arg_405_1.time_ >= var_408_29 + var_408_30 and arg_405_1.time_ < var_408_29 + var_408_30 + arg_408_0 then
				var_408_28.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_408_35 = manager.ui.mainCamera.transform.position - var_408_28.position

				var_408_28.forward = Vector3.New(var_408_35.x, var_408_35.y, var_408_35.z)

				local var_408_36 = var_408_28.localEulerAngles

				var_408_36.z = 0
				var_408_36.x = 0
				var_408_28.localEulerAngles = var_408_36
			end

			local var_408_37 = 3.8

			if var_408_37 < arg_405_1.time_ and arg_405_1.time_ <= var_408_37 + arg_408_0 then
				arg_405_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_408_38 = 3.8

			if var_408_38 < arg_405_1.time_ and arg_405_1.time_ <= var_408_38 + arg_408_0 then
				arg_405_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_408_39 = arg_405_1.actors_["1029ui_story"]
			local var_408_40 = 3.8

			if var_408_40 < arg_405_1.time_ and arg_405_1.time_ <= var_408_40 + arg_408_0 and not isNil(var_408_39) and arg_405_1.var_.characterEffect1029ui_story == nil then
				arg_405_1.var_.characterEffect1029ui_story = var_408_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_41 = 0.2

			if var_408_40 <= arg_405_1.time_ and arg_405_1.time_ < var_408_40 + var_408_41 and not isNil(var_408_39) then
				local var_408_42 = (arg_405_1.time_ - var_408_40) / var_408_41

				if arg_405_1.var_.characterEffect1029ui_story and not isNil(var_408_39) then
					arg_405_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= var_408_40 + var_408_41 and arg_405_1.time_ < var_408_40 + var_408_41 + arg_408_0 and not isNil(var_408_39) and arg_405_1.var_.characterEffect1029ui_story then
				arg_405_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_408_43 = 1.86666666666667
			local var_408_44 = 1

			if var_408_43 < arg_405_1.time_ and arg_405_1.time_ <= var_408_43 + arg_408_0 then
				local var_408_45 = "play"
				local var_408_46 = "music"

				arg_405_1:AudioAction(var_408_45, var_408_46, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_408_47 = ""
				local var_408_48 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if var_408_48 ~= "" then
					if arg_405_1.bgmTxt_.text ~= var_408_48 and arg_405_1.bgmTxt_.text ~= "" then
						if arg_405_1.bgmTxt2_.text ~= "" then
							arg_405_1.bgmTxt_.text = arg_405_1.bgmTxt2_.text
						end

						arg_405_1.bgmTxt2_.text = var_408_48

						arg_405_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_405_1.bgmTxt_.text = var_408_48
						arg_405_1.bgmTxt2_.text = var_408_48
					end

					if arg_405_1.bgmTimer then
						arg_405_1.bgmTimer:Stop()

						arg_405_1.bgmTimer = nil
					end

					if arg_405_1.settingData.show_music_name == 1 then
						arg_405_1.musicController:SetSelectedState("show")
						arg_405_1.musicAnimator_:Play("open", 0, 0)

						if arg_405_1.settingData.music_time ~= 0 then
							arg_405_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_405_1.settingData.music_time), function()
								if arg_405_1 == nil or isNil(arg_405_1.bgmTxt_) then
									return
								end

								arg_405_1.musicController:SetSelectedState("hide")
								arg_405_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_405_1.frameCnt_ <= 1 then
				arg_405_1.dialog_:SetActive(false)
			end

			local var_408_49 = 4
			local var_408_50 = 0.125

			if var_408_49 < arg_405_1.time_ and arg_405_1.time_ <= var_408_49 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0

				arg_405_1.dialog_:SetActive(true)

				arg_405_1.dialogCg_.alpha = 0

				local var_408_51 = LeanTween.value(arg_405_1.dialog_, 0, 1, 0.3)

				var_408_51:setOnUpdate(LuaHelper.FloatAction(function(arg_410_0)
					arg_405_1.dialogCg_.alpha = arg_410_0
				end))
				var_408_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_405_1.dialog_)
					var_408_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_405_1.duration_ = arg_405_1.duration_ + 0.3

				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_52 = arg_405_1:FormatText(StoryNameCfg[319].name)

				arg_405_1.leftNameTxt_.text = var_408_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_53 = arg_405_1:GetWordFromCfg(120431098)
				local var_408_54 = arg_405_1:FormatText(var_408_53.content)

				arg_405_1.text_.text = var_408_54

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_55 = 5
				local var_408_56 = utf8.len(var_408_54)
				local var_408_57 = var_408_55 <= 0 and var_408_50 or var_408_50 * (var_408_56 / var_408_55)

				if var_408_57 > 0 and var_408_50 < var_408_57 then
					arg_405_1.talkMaxDuration = var_408_57
					var_408_49 = var_408_49 + 0.3

					if var_408_57 + var_408_49 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_57 + var_408_49
					end
				end

				arg_405_1.text_.text = var_408_54
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431098", "story_v_out_120431.awb") ~= 0 then
					local var_408_58 = manager.audio:GetVoiceLength("story_v_out_120431", "120431098", "story_v_out_120431.awb") / 1000

					if var_408_58 + var_408_49 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_58 + var_408_49
					end

					if var_408_53.prefab_name ~= "" and arg_405_1.actors_[var_408_53.prefab_name] ~= nil then
						local var_408_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_53.prefab_name].transform, "story_v_out_120431", "120431098", "story_v_out_120431.awb")

						arg_405_1:RecordAudio("120431098", var_408_59)
						arg_405_1:RecordAudio("120431098", var_408_59)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_120431", "120431098", "story_v_out_120431.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_120431", "120431098", "story_v_out_120431.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_60 = var_408_49 + 0.3
			local var_408_61 = math.max(var_408_50, arg_405_1.talkMaxDuration)

			if var_408_60 <= arg_405_1.time_ and arg_405_1.time_ < var_408_60 + var_408_61 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_60) / var_408_61

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_60 + var_408_61 and arg_405_1.time_ < var_408_60 + var_408_61 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play120431099 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 120431099
		arg_412_1.duration_ = 5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play120431100(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = arg_412_1.actors_["1029ui_story"]
			local var_415_1 = 0

			if var_415_1 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 and not isNil(var_415_0) and arg_412_1.var_.characterEffect1029ui_story == nil then
				arg_412_1.var_.characterEffect1029ui_story = var_415_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_2 = 0.2

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_2 and not isNil(var_415_0) then
				local var_415_3 = (arg_412_1.time_ - var_415_1) / var_415_2

				if arg_412_1.var_.characterEffect1029ui_story and not isNil(var_415_0) then
					local var_415_4 = Mathf.Lerp(0, 0.5, var_415_3)

					arg_412_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_412_1.var_.characterEffect1029ui_story.fillRatio = var_415_4
				end
			end

			if arg_412_1.time_ >= var_415_1 + var_415_2 and arg_412_1.time_ < var_415_1 + var_415_2 + arg_415_0 and not isNil(var_415_0) and arg_412_1.var_.characterEffect1029ui_story then
				local var_415_5 = 0.5

				arg_412_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_412_1.var_.characterEffect1029ui_story.fillRatio = var_415_5
			end

			local var_415_6 = 0
			local var_415_7 = 1

			if var_415_6 < arg_412_1.time_ and arg_412_1.time_ <= var_415_6 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, false)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_8 = arg_412_1:GetWordFromCfg(120431099)
				local var_415_9 = arg_412_1:FormatText(var_415_8.content)

				arg_412_1.text_.text = var_415_9

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_10 = 40
				local var_415_11 = utf8.len(var_415_9)
				local var_415_12 = var_415_10 <= 0 and var_415_7 or var_415_7 * (var_415_11 / var_415_10)

				if var_415_12 > 0 and var_415_7 < var_415_12 then
					arg_412_1.talkMaxDuration = var_415_12

					if var_415_12 + var_415_6 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_12 + var_415_6
					end
				end

				arg_412_1.text_.text = var_415_9
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_13 = math.max(var_415_7, arg_412_1.talkMaxDuration)

			if var_415_6 <= arg_412_1.time_ and arg_412_1.time_ < var_415_6 + var_415_13 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_6) / var_415_13

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_6 + var_415_13 and arg_412_1.time_ < var_415_6 + var_415_13 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play120431100 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 120431100
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play120431101(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0
			local var_419_1 = 0.825

			if var_419_0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, false)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_2 = arg_416_1:GetWordFromCfg(120431100)
				local var_419_3 = arg_416_1:FormatText(var_419_2.content)

				arg_416_1.text_.text = var_419_3

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_4 = 33
				local var_419_5 = utf8.len(var_419_3)
				local var_419_6 = var_419_4 <= 0 and var_419_1 or var_419_1 * (var_419_5 / var_419_4)

				if var_419_6 > 0 and var_419_1 < var_419_6 then
					arg_416_1.talkMaxDuration = var_419_6

					if var_419_6 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_6 + var_419_0
					end
				end

				arg_416_1.text_.text = var_419_3
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_7 = math.max(var_419_1, arg_416_1.talkMaxDuration)

			if var_419_0 <= arg_416_1.time_ and arg_416_1.time_ < var_419_0 + var_419_7 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_0) / var_419_7

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_0 + var_419_7 and arg_416_1.time_ < var_419_0 + var_419_7 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play120431101 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 120431101
		arg_420_1.duration_ = 8.47

		local var_420_0 = {
			zh = 7.066,
			ja = 8.466
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play120431102(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["1029ui_story"]
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect1029ui_story == nil then
				arg_420_1.var_.characterEffect1029ui_story = var_423_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_2 = 0.2

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_2 and not isNil(var_423_0) then
				local var_423_3 = (arg_420_1.time_ - var_423_1) / var_423_2

				if arg_420_1.var_.characterEffect1029ui_story and not isNil(var_423_0) then
					arg_420_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_420_1.time_ >= var_423_1 + var_423_2 and arg_420_1.time_ < var_423_1 + var_423_2 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect1029ui_story then
				arg_420_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_423_4 = 0
			local var_423_5 = 0.825

			if var_423_4 < arg_420_1.time_ and arg_420_1.time_ <= var_423_4 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_6 = arg_420_1:FormatText(StoryNameCfg[319].name)

				arg_420_1.leftNameTxt_.text = var_423_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_7 = arg_420_1:GetWordFromCfg(120431101)
				local var_423_8 = arg_420_1:FormatText(var_423_7.content)

				arg_420_1.text_.text = var_423_8

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_9 = 33
				local var_423_10 = utf8.len(var_423_8)
				local var_423_11 = var_423_9 <= 0 and var_423_5 or var_423_5 * (var_423_10 / var_423_9)

				if var_423_11 > 0 and var_423_5 < var_423_11 then
					arg_420_1.talkMaxDuration = var_423_11

					if var_423_11 + var_423_4 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_11 + var_423_4
					end
				end

				arg_420_1.text_.text = var_423_8
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431101", "story_v_out_120431.awb") ~= 0 then
					local var_423_12 = manager.audio:GetVoiceLength("story_v_out_120431", "120431101", "story_v_out_120431.awb") / 1000

					if var_423_12 + var_423_4 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_12 + var_423_4
					end

					if var_423_7.prefab_name ~= "" and arg_420_1.actors_[var_423_7.prefab_name] ~= nil then
						local var_423_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_7.prefab_name].transform, "story_v_out_120431", "120431101", "story_v_out_120431.awb")

						arg_420_1:RecordAudio("120431101", var_423_13)
						arg_420_1:RecordAudio("120431101", var_423_13)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_120431", "120431101", "story_v_out_120431.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_120431", "120431101", "story_v_out_120431.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_14 = math.max(var_423_5, arg_420_1.talkMaxDuration)

			if var_423_4 <= arg_420_1.time_ and arg_420_1.time_ < var_423_4 + var_423_14 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_4) / var_423_14

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_4 + var_423_14 and arg_420_1.time_ < var_423_4 + var_423_14 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play120431102 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 120431102
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play120431103(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = arg_424_1.actors_["1029ui_story"]
			local var_427_1 = 0

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.characterEffect1029ui_story == nil then
				arg_424_1.var_.characterEffect1029ui_story = var_427_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_2 = 0.2

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_2 and not isNil(var_427_0) then
				local var_427_3 = (arg_424_1.time_ - var_427_1) / var_427_2

				if arg_424_1.var_.characterEffect1029ui_story and not isNil(var_427_0) then
					local var_427_4 = Mathf.Lerp(0, 0.5, var_427_3)

					arg_424_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_424_1.var_.characterEffect1029ui_story.fillRatio = var_427_4
				end
			end

			if arg_424_1.time_ >= var_427_1 + var_427_2 and arg_424_1.time_ < var_427_1 + var_427_2 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.characterEffect1029ui_story then
				local var_427_5 = 0.5

				arg_424_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_424_1.var_.characterEffect1029ui_story.fillRatio = var_427_5
			end

			local var_427_6 = 0
			local var_427_7 = 0.25

			if var_427_6 < arg_424_1.time_ and arg_424_1.time_ <= var_427_6 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_8 = arg_424_1:FormatText(StoryNameCfg[7].name)

				arg_424_1.leftNameTxt_.text = var_427_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, true)
				arg_424_1.iconController_:SetSelectedState("hero")

				arg_424_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_424_1.callingController_:SetSelectedState("normal")

				arg_424_1.keyicon_.color = Color.New(1, 1, 1)
				arg_424_1.icon_.color = Color.New(1, 1, 1)

				local var_427_9 = arg_424_1:GetWordFromCfg(120431102)
				local var_427_10 = arg_424_1:FormatText(var_427_9.content)

				arg_424_1.text_.text = var_427_10

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_11 = 10
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
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_14 = math.max(var_427_7, arg_424_1.talkMaxDuration)

			if var_427_6 <= arg_424_1.time_ and arg_424_1.time_ < var_427_6 + var_427_14 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_6) / var_427_14

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_6 + var_427_14 and arg_424_1.time_ < var_427_6 + var_427_14 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play120431103 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 120431103
		arg_428_1.duration_ = 4.13

		local var_428_0 = {
			zh = 4.133,
			ja = 4.033
		}
		local var_428_1 = manager.audio:GetLocalizationFlag()

		if var_428_0[var_428_1] ~= nil then
			arg_428_1.duration_ = var_428_0[var_428_1]
		end

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play120431104(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = arg_428_1.actors_["1029ui_story"]
			local var_431_1 = 0

			if var_431_1 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.characterEffect1029ui_story == nil then
				arg_428_1.var_.characterEffect1029ui_story = var_431_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_2 = 0.2

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_2 and not isNil(var_431_0) then
				local var_431_3 = (arg_428_1.time_ - var_431_1) / var_431_2

				if arg_428_1.var_.characterEffect1029ui_story and not isNil(var_431_0) then
					arg_428_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_428_1.time_ >= var_431_1 + var_431_2 and arg_428_1.time_ < var_431_1 + var_431_2 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.characterEffect1029ui_story then
				arg_428_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_431_4 = 0

			if var_431_4 < arg_428_1.time_ and arg_428_1.time_ <= var_431_4 + arg_431_0 then
				arg_428_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_431_5 = 0

			if var_431_5 < arg_428_1.time_ and arg_428_1.time_ <= var_431_5 + arg_431_0 then
				arg_428_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_431_6 = 0
			local var_431_7 = 0.325

			if var_431_6 < arg_428_1.time_ and arg_428_1.time_ <= var_431_6 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_8 = arg_428_1:FormatText(StoryNameCfg[319].name)

				arg_428_1.leftNameTxt_.text = var_431_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_9 = arg_428_1:GetWordFromCfg(120431103)
				local var_431_10 = arg_428_1:FormatText(var_431_9.content)

				arg_428_1.text_.text = var_431_10

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_11 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431103", "story_v_out_120431.awb") ~= 0 then
					local var_431_14 = manager.audio:GetVoiceLength("story_v_out_120431", "120431103", "story_v_out_120431.awb") / 1000

					if var_431_14 + var_431_6 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_14 + var_431_6
					end

					if var_431_9.prefab_name ~= "" and arg_428_1.actors_[var_431_9.prefab_name] ~= nil then
						local var_431_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_9.prefab_name].transform, "story_v_out_120431", "120431103", "story_v_out_120431.awb")

						arg_428_1:RecordAudio("120431103", var_431_15)
						arg_428_1:RecordAudio("120431103", var_431_15)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_out_120431", "120431103", "story_v_out_120431.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_out_120431", "120431103", "story_v_out_120431.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_16 = math.max(var_431_7, arg_428_1.talkMaxDuration)

			if var_431_6 <= arg_428_1.time_ and arg_428_1.time_ < var_431_6 + var_431_16 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_6) / var_431_16

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_6 + var_431_16 and arg_428_1.time_ < var_431_6 + var_431_16 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play120431104 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 120431104
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play120431105(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0

			if var_435_0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_0 + arg_435_0 then
				arg_432_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_435_1 = arg_432_1.actors_["1029ui_story"]
			local var_435_2 = 0

			if var_435_2 < arg_432_1.time_ and arg_432_1.time_ <= var_435_2 + arg_435_0 and not isNil(var_435_1) and arg_432_1.var_.characterEffect1029ui_story == nil then
				arg_432_1.var_.characterEffect1029ui_story = var_435_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_3 = 0.2

			if var_435_2 <= arg_432_1.time_ and arg_432_1.time_ < var_435_2 + var_435_3 and not isNil(var_435_1) then
				local var_435_4 = (arg_432_1.time_ - var_435_2) / var_435_3

				if arg_432_1.var_.characterEffect1029ui_story and not isNil(var_435_1) then
					local var_435_5 = Mathf.Lerp(0, 0.5, var_435_4)

					arg_432_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_432_1.var_.characterEffect1029ui_story.fillRatio = var_435_5
				end
			end

			if arg_432_1.time_ >= var_435_2 + var_435_3 and arg_432_1.time_ < var_435_2 + var_435_3 + arg_435_0 and not isNil(var_435_1) and arg_432_1.var_.characterEffect1029ui_story then
				local var_435_6 = 0.5

				arg_432_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_432_1.var_.characterEffect1029ui_story.fillRatio = var_435_6
			end

			local var_435_7 = 0
			local var_435_8 = 0.5

			if var_435_7 < arg_432_1.time_ and arg_432_1.time_ <= var_435_7 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_9 = arg_432_1:FormatText(StoryNameCfg[7].name)

				arg_432_1.leftNameTxt_.text = var_435_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, true)
				arg_432_1.iconController_:SetSelectedState("hero")

				arg_432_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_432_1.callingController_:SetSelectedState("normal")

				arg_432_1.keyicon_.color = Color.New(1, 1, 1)
				arg_432_1.icon_.color = Color.New(1, 1, 1)

				local var_435_10 = arg_432_1:GetWordFromCfg(120431104)
				local var_435_11 = arg_432_1:FormatText(var_435_10.content)

				arg_432_1.text_.text = var_435_11

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_12 = 20
				local var_435_13 = utf8.len(var_435_11)
				local var_435_14 = var_435_12 <= 0 and var_435_8 or var_435_8 * (var_435_13 / var_435_12)

				if var_435_14 > 0 and var_435_8 < var_435_14 then
					arg_432_1.talkMaxDuration = var_435_14

					if var_435_14 + var_435_7 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_14 + var_435_7
					end
				end

				arg_432_1.text_.text = var_435_11
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_15 = math.max(var_435_8, arg_432_1.talkMaxDuration)

			if var_435_7 <= arg_432_1.time_ and arg_432_1.time_ < var_435_7 + var_435_15 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_7) / var_435_15

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_7 + var_435_15 and arg_432_1.time_ < var_435_7 + var_435_15 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play120431105 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 120431105
		arg_436_1.duration_ = 4.2

		local var_436_0 = {
			zh = 3.066,
			ja = 4.2
		}
		local var_436_1 = manager.audio:GetLocalizationFlag()

		if var_436_0[var_436_1] ~= nil then
			arg_436_1.duration_ = var_436_0[var_436_1]
		end

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play120431106(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = arg_436_1.actors_["1029ui_story"]
			local var_439_1 = 0

			if var_439_1 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.characterEffect1029ui_story == nil then
				arg_436_1.var_.characterEffect1029ui_story = var_439_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_2 = 0.2

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_2 and not isNil(var_439_0) then
				local var_439_3 = (arg_436_1.time_ - var_439_1) / var_439_2

				if arg_436_1.var_.characterEffect1029ui_story and not isNil(var_439_0) then
					arg_436_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_436_1.time_ >= var_439_1 + var_439_2 and arg_436_1.time_ < var_439_1 + var_439_2 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.characterEffect1029ui_story then
				arg_436_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_439_4 = 0
			local var_439_5 = 0.3

			if var_439_4 < arg_436_1.time_ and arg_436_1.time_ <= var_439_4 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				local var_439_6 = arg_436_1:FormatText(StoryNameCfg[319].name)

				arg_436_1.leftNameTxt_.text = var_439_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_7 = arg_436_1:GetWordFromCfg(120431105)
				local var_439_8 = arg_436_1:FormatText(var_439_7.content)

				arg_436_1.text_.text = var_439_8

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_9 = 12
				local var_439_10 = utf8.len(var_439_8)
				local var_439_11 = var_439_9 <= 0 and var_439_5 or var_439_5 * (var_439_10 / var_439_9)

				if var_439_11 > 0 and var_439_5 < var_439_11 then
					arg_436_1.talkMaxDuration = var_439_11

					if var_439_11 + var_439_4 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_11 + var_439_4
					end
				end

				arg_436_1.text_.text = var_439_8
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431105", "story_v_out_120431.awb") ~= 0 then
					local var_439_12 = manager.audio:GetVoiceLength("story_v_out_120431", "120431105", "story_v_out_120431.awb") / 1000

					if var_439_12 + var_439_4 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_12 + var_439_4
					end

					if var_439_7.prefab_name ~= "" and arg_436_1.actors_[var_439_7.prefab_name] ~= nil then
						local var_439_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_7.prefab_name].transform, "story_v_out_120431", "120431105", "story_v_out_120431.awb")

						arg_436_1:RecordAudio("120431105", var_439_13)
						arg_436_1:RecordAudio("120431105", var_439_13)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_out_120431", "120431105", "story_v_out_120431.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_out_120431", "120431105", "story_v_out_120431.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_14 = math.max(var_439_5, arg_436_1.talkMaxDuration)

			if var_439_4 <= arg_436_1.time_ and arg_436_1.time_ < var_439_4 + var_439_14 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_4) / var_439_14

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_4 + var_439_14 and arg_436_1.time_ < var_439_4 + var_439_14 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play120431106 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 120431106
		arg_440_1.duration_ = 7.87

		local var_440_0 = {
			zh = 5.233,
			ja = 7.866
		}
		local var_440_1 = manager.audio:GetLocalizationFlag()

		if var_440_0[var_440_1] ~= nil then
			arg_440_1.duration_ = var_440_0[var_440_1]
		end

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play120431107(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = 0
			local var_443_1 = 0.7

			if var_443_0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_0 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_2 = arg_440_1:FormatText(StoryNameCfg[319].name)

				arg_440_1.leftNameTxt_.text = var_443_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_3 = arg_440_1:GetWordFromCfg(120431106)
				local var_443_4 = arg_440_1:FormatText(var_443_3.content)

				arg_440_1.text_.text = var_443_4

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_5 = 28
				local var_443_6 = utf8.len(var_443_4)
				local var_443_7 = var_443_5 <= 0 and var_443_1 or var_443_1 * (var_443_6 / var_443_5)

				if var_443_7 > 0 and var_443_1 < var_443_7 then
					arg_440_1.talkMaxDuration = var_443_7

					if var_443_7 + var_443_0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_7 + var_443_0
					end
				end

				arg_440_1.text_.text = var_443_4
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431106", "story_v_out_120431.awb") ~= 0 then
					local var_443_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431106", "story_v_out_120431.awb") / 1000

					if var_443_8 + var_443_0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_8 + var_443_0
					end

					if var_443_3.prefab_name ~= "" and arg_440_1.actors_[var_443_3.prefab_name] ~= nil then
						local var_443_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_3.prefab_name].transform, "story_v_out_120431", "120431106", "story_v_out_120431.awb")

						arg_440_1:RecordAudio("120431106", var_443_9)
						arg_440_1:RecordAudio("120431106", var_443_9)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_120431", "120431106", "story_v_out_120431.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_120431", "120431106", "story_v_out_120431.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_10 = math.max(var_443_1, arg_440_1.talkMaxDuration)

			if var_443_0 <= arg_440_1.time_ and arg_440_1.time_ < var_443_0 + var_443_10 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_0) / var_443_10

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_0 + var_443_10 and arg_440_1.time_ < var_443_0 + var_443_10 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play120431107 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 120431107
		arg_444_1.duration_ = 2.5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play120431108(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = arg_444_1.actors_["1029ui_story"]
			local var_447_1 = 0

			if var_447_1 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.characterEffect1029ui_story == nil then
				arg_444_1.var_.characterEffect1029ui_story = var_447_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_2 = 0.2

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_2 and not isNil(var_447_0) then
				local var_447_3 = (arg_444_1.time_ - var_447_1) / var_447_2

				if arg_444_1.var_.characterEffect1029ui_story and not isNil(var_447_0) then
					local var_447_4 = Mathf.Lerp(0, 0.5, var_447_3)

					arg_444_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_444_1.var_.characterEffect1029ui_story.fillRatio = var_447_4
				end
			end

			if arg_444_1.time_ >= var_447_1 + var_447_2 and arg_444_1.time_ < var_447_1 + var_447_2 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.characterEffect1029ui_story then
				local var_447_5 = 0.5

				arg_444_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_444_1.var_.characterEffect1029ui_story.fillRatio = var_447_5
			end

			local var_447_6 = arg_444_1.actors_["1029ui_story"].transform
			local var_447_7 = 0

			if var_447_7 < arg_444_1.time_ and arg_444_1.time_ <= var_447_7 + arg_447_0 then
				arg_444_1.var_.moveOldPos1029ui_story = var_447_6.localPosition
			end

			local var_447_8 = 0.001

			if var_447_7 <= arg_444_1.time_ and arg_444_1.time_ < var_447_7 + var_447_8 then
				local var_447_9 = (arg_444_1.time_ - var_447_7) / var_447_8
				local var_447_10 = Vector3.New(-0.7, -1.09, -6.2)

				var_447_6.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos1029ui_story, var_447_10, var_447_9)

				local var_447_11 = manager.ui.mainCamera.transform.position - var_447_6.position

				var_447_6.forward = Vector3.New(var_447_11.x, var_447_11.y, var_447_11.z)

				local var_447_12 = var_447_6.localEulerAngles

				var_447_12.z = 0
				var_447_12.x = 0
				var_447_6.localEulerAngles = var_447_12
			end

			if arg_444_1.time_ >= var_447_7 + var_447_8 and arg_444_1.time_ < var_447_7 + var_447_8 + arg_447_0 then
				var_447_6.localPosition = Vector3.New(-0.7, -1.09, -6.2)

				local var_447_13 = manager.ui.mainCamera.transform.position - var_447_6.position

				var_447_6.forward = Vector3.New(var_447_13.x, var_447_13.y, var_447_13.z)

				local var_447_14 = var_447_6.localEulerAngles

				var_447_14.z = 0
				var_447_14.x = 0
				var_447_6.localEulerAngles = var_447_14
			end

			local var_447_15 = arg_444_1.actors_["1084ui_story"].transform
			local var_447_16 = 0

			if var_447_16 < arg_444_1.time_ and arg_444_1.time_ <= var_447_16 + arg_447_0 then
				arg_444_1.var_.moveOldPos1084ui_story = var_447_15.localPosition
			end

			local var_447_17 = 0.001

			if var_447_16 <= arg_444_1.time_ and arg_444_1.time_ < var_447_16 + var_447_17 then
				local var_447_18 = (arg_444_1.time_ - var_447_16) / var_447_17
				local var_447_19 = Vector3.New(0.7, -0.97, -6)

				var_447_15.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos1084ui_story, var_447_19, var_447_18)

				local var_447_20 = manager.ui.mainCamera.transform.position - var_447_15.position

				var_447_15.forward = Vector3.New(var_447_20.x, var_447_20.y, var_447_20.z)

				local var_447_21 = var_447_15.localEulerAngles

				var_447_21.z = 0
				var_447_21.x = 0
				var_447_15.localEulerAngles = var_447_21
			end

			if arg_444_1.time_ >= var_447_16 + var_447_17 and arg_444_1.time_ < var_447_16 + var_447_17 + arg_447_0 then
				var_447_15.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_447_22 = manager.ui.mainCamera.transform.position - var_447_15.position

				var_447_15.forward = Vector3.New(var_447_22.x, var_447_22.y, var_447_22.z)

				local var_447_23 = var_447_15.localEulerAngles

				var_447_23.z = 0
				var_447_23.x = 0
				var_447_15.localEulerAngles = var_447_23
			end

			local var_447_24 = 0

			if var_447_24 < arg_444_1.time_ and arg_444_1.time_ <= var_447_24 + arg_447_0 then
				arg_444_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_447_25 = 0

			if var_447_25 < arg_444_1.time_ and arg_444_1.time_ <= var_447_25 + arg_447_0 then
				arg_444_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_447_26 = arg_444_1.actors_["1084ui_story"]
			local var_447_27 = 0

			if var_447_27 < arg_444_1.time_ and arg_444_1.time_ <= var_447_27 + arg_447_0 and not isNil(var_447_26) and arg_444_1.var_.characterEffect1084ui_story == nil then
				arg_444_1.var_.characterEffect1084ui_story = var_447_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_28 = 0.2

			if var_447_27 <= arg_444_1.time_ and arg_444_1.time_ < var_447_27 + var_447_28 and not isNil(var_447_26) then
				local var_447_29 = (arg_444_1.time_ - var_447_27) / var_447_28

				if arg_444_1.var_.characterEffect1084ui_story and not isNil(var_447_26) then
					arg_444_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_444_1.time_ >= var_447_27 + var_447_28 and arg_444_1.time_ < var_447_27 + var_447_28 + arg_447_0 and not isNil(var_447_26) and arg_444_1.var_.characterEffect1084ui_story then
				arg_444_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_447_30 = 0
			local var_447_31 = 0.05

			if var_447_30 < arg_444_1.time_ and arg_444_1.time_ <= var_447_30 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_32 = arg_444_1:FormatText(StoryNameCfg[6].name)

				arg_444_1.leftNameTxt_.text = var_447_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_33 = arg_444_1:GetWordFromCfg(120431107)
				local var_447_34 = arg_444_1:FormatText(var_447_33.content)

				arg_444_1.text_.text = var_447_34

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_35 = 2
				local var_447_36 = utf8.len(var_447_34)
				local var_447_37 = var_447_35 <= 0 and var_447_31 or var_447_31 * (var_447_36 / var_447_35)

				if var_447_37 > 0 and var_447_31 < var_447_37 then
					arg_444_1.talkMaxDuration = var_447_37

					if var_447_37 + var_447_30 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_37 + var_447_30
					end
				end

				arg_444_1.text_.text = var_447_34
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431107", "story_v_out_120431.awb") ~= 0 then
					local var_447_38 = manager.audio:GetVoiceLength("story_v_out_120431", "120431107", "story_v_out_120431.awb") / 1000

					if var_447_38 + var_447_30 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_38 + var_447_30
					end

					if var_447_33.prefab_name ~= "" and arg_444_1.actors_[var_447_33.prefab_name] ~= nil then
						local var_447_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_33.prefab_name].transform, "story_v_out_120431", "120431107", "story_v_out_120431.awb")

						arg_444_1:RecordAudio("120431107", var_447_39)
						arg_444_1:RecordAudio("120431107", var_447_39)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_120431", "120431107", "story_v_out_120431.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_120431", "120431107", "story_v_out_120431.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_40 = math.max(var_447_31, arg_444_1.talkMaxDuration)

			if var_447_30 <= arg_444_1.time_ and arg_444_1.time_ < var_447_30 + var_447_40 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_30) / var_447_40

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_30 + var_447_40 and arg_444_1.time_ < var_447_30 + var_447_40 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_444_1:InitPlayNodeList()
	end,
	Play120431108 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 120431108
		arg_448_1.duration_ = 6.3

		local var_448_0 = {
			zh = 5,
			ja = 6.3
		}
		local var_448_1 = manager.audio:GetLocalizationFlag()

		if var_448_0[var_448_1] ~= nil then
			arg_448_1.duration_ = var_448_0[var_448_1]
		end

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play120431109(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = 0

			if var_451_0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_0 + arg_451_0 then
				arg_448_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action447")
			end

			local var_451_1 = 0

			if var_451_1 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 then
				arg_448_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_451_2 = 0
			local var_451_3 = 0.525

			if var_451_2 < arg_448_1.time_ and arg_448_1.time_ <= var_451_2 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_4 = arg_448_1:FormatText(StoryNameCfg[6].name)

				arg_448_1.leftNameTxt_.text = var_451_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_5 = arg_448_1:GetWordFromCfg(120431108)
				local var_451_6 = arg_448_1:FormatText(var_451_5.content)

				arg_448_1.text_.text = var_451_6

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_7 = 21
				local var_451_8 = utf8.len(var_451_6)
				local var_451_9 = var_451_7 <= 0 and var_451_3 or var_451_3 * (var_451_8 / var_451_7)

				if var_451_9 > 0 and var_451_3 < var_451_9 then
					arg_448_1.talkMaxDuration = var_451_9

					if var_451_9 + var_451_2 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_9 + var_451_2
					end
				end

				arg_448_1.text_.text = var_451_6
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431108", "story_v_out_120431.awb") ~= 0 then
					local var_451_10 = manager.audio:GetVoiceLength("story_v_out_120431", "120431108", "story_v_out_120431.awb") / 1000

					if var_451_10 + var_451_2 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_10 + var_451_2
					end

					if var_451_5.prefab_name ~= "" and arg_448_1.actors_[var_451_5.prefab_name] ~= nil then
						local var_451_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_5.prefab_name].transform, "story_v_out_120431", "120431108", "story_v_out_120431.awb")

						arg_448_1:RecordAudio("120431108", var_451_11)
						arg_448_1:RecordAudio("120431108", var_451_11)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_out_120431", "120431108", "story_v_out_120431.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_out_120431", "120431108", "story_v_out_120431.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_12 = math.max(var_451_3, arg_448_1.talkMaxDuration)

			if var_451_2 <= arg_448_1.time_ and arg_448_1.time_ < var_451_2 + var_451_12 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_2) / var_451_12

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_2 + var_451_12 and arg_448_1.time_ < var_451_2 + var_451_12 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play120431109 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 120431109
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play120431110(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = arg_452_1.actors_["1084ui_story"]
			local var_455_1 = 0

			if var_455_1 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.characterEffect1084ui_story == nil then
				arg_452_1.var_.characterEffect1084ui_story = var_455_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_2 = 0.2

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_2 and not isNil(var_455_0) then
				local var_455_3 = (arg_452_1.time_ - var_455_1) / var_455_2

				if arg_452_1.var_.characterEffect1084ui_story and not isNil(var_455_0) then
					local var_455_4 = Mathf.Lerp(0, 0.5, var_455_3)

					arg_452_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_452_1.var_.characterEffect1084ui_story.fillRatio = var_455_4
				end
			end

			if arg_452_1.time_ >= var_455_1 + var_455_2 and arg_452_1.time_ < var_455_1 + var_455_2 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.characterEffect1084ui_story then
				local var_455_5 = 0.5

				arg_452_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_452_1.var_.characterEffect1084ui_story.fillRatio = var_455_5
			end

			local var_455_6 = 0
			local var_455_7 = 0.225

			if var_455_6 < arg_452_1.time_ and arg_452_1.time_ <= var_455_6 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_8 = arg_452_1:FormatText(StoryNameCfg[7].name)

				arg_452_1.leftNameTxt_.text = var_455_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, true)
				arg_452_1.iconController_:SetSelectedState("hero")

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_9 = arg_452_1:GetWordFromCfg(120431109)
				local var_455_10 = arg_452_1:FormatText(var_455_9.content)

				arg_452_1.text_.text = var_455_10

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_11 = 9
				local var_455_12 = utf8.len(var_455_10)
				local var_455_13 = var_455_11 <= 0 and var_455_7 or var_455_7 * (var_455_12 / var_455_11)

				if var_455_13 > 0 and var_455_7 < var_455_13 then
					arg_452_1.talkMaxDuration = var_455_13

					if var_455_13 + var_455_6 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_13 + var_455_6
					end
				end

				arg_452_1.text_.text = var_455_10
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_14 = math.max(var_455_7, arg_452_1.talkMaxDuration)

			if var_455_6 <= arg_452_1.time_ and arg_452_1.time_ < var_455_6 + var_455_14 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_6) / var_455_14

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_6 + var_455_14 and arg_452_1.time_ < var_455_6 + var_455_14 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play120431110 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 120431110
		arg_456_1.duration_ = 6.07

		local var_456_0 = {
			zh = 4.566,
			ja = 6.066
		}
		local var_456_1 = manager.audio:GetLocalizationFlag()

		if var_456_0[var_456_1] ~= nil then
			arg_456_1.duration_ = var_456_0[var_456_1]
		end

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play120431111(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = arg_456_1.actors_["1084ui_story"]
			local var_459_1 = 0

			if var_459_1 < arg_456_1.time_ and arg_456_1.time_ <= var_459_1 + arg_459_0 and not isNil(var_459_0) and arg_456_1.var_.characterEffect1084ui_story == nil then
				arg_456_1.var_.characterEffect1084ui_story = var_459_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_2 = 0.2

			if var_459_1 <= arg_456_1.time_ and arg_456_1.time_ < var_459_1 + var_459_2 and not isNil(var_459_0) then
				local var_459_3 = (arg_456_1.time_ - var_459_1) / var_459_2

				if arg_456_1.var_.characterEffect1084ui_story and not isNil(var_459_0) then
					arg_456_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_456_1.time_ >= var_459_1 + var_459_2 and arg_456_1.time_ < var_459_1 + var_459_2 + arg_459_0 and not isNil(var_459_0) and arg_456_1.var_.characterEffect1084ui_story then
				arg_456_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_459_4 = 0

			if var_459_4 < arg_456_1.time_ and arg_456_1.time_ <= var_459_4 + arg_459_0 then
				arg_456_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_459_5 = 0

			if var_459_5 < arg_456_1.time_ and arg_456_1.time_ <= var_459_5 + arg_459_0 then
				arg_456_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_459_6 = 0
			local var_459_7 = 0.45

			if var_459_6 < arg_456_1.time_ and arg_456_1.time_ <= var_459_6 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_8 = arg_456_1:FormatText(StoryNameCfg[6].name)

				arg_456_1.leftNameTxt_.text = var_459_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_9 = arg_456_1:GetWordFromCfg(120431110)
				local var_459_10 = arg_456_1:FormatText(var_459_9.content)

				arg_456_1.text_.text = var_459_10

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_11 = 17
				local var_459_12 = utf8.len(var_459_10)
				local var_459_13 = var_459_11 <= 0 and var_459_7 or var_459_7 * (var_459_12 / var_459_11)

				if var_459_13 > 0 and var_459_7 < var_459_13 then
					arg_456_1.talkMaxDuration = var_459_13

					if var_459_13 + var_459_6 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_13 + var_459_6
					end
				end

				arg_456_1.text_.text = var_459_10
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431110", "story_v_out_120431.awb") ~= 0 then
					local var_459_14 = manager.audio:GetVoiceLength("story_v_out_120431", "120431110", "story_v_out_120431.awb") / 1000

					if var_459_14 + var_459_6 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_14 + var_459_6
					end

					if var_459_9.prefab_name ~= "" and arg_456_1.actors_[var_459_9.prefab_name] ~= nil then
						local var_459_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_9.prefab_name].transform, "story_v_out_120431", "120431110", "story_v_out_120431.awb")

						arg_456_1:RecordAudio("120431110", var_459_15)
						arg_456_1:RecordAudio("120431110", var_459_15)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_120431", "120431110", "story_v_out_120431.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_120431", "120431110", "story_v_out_120431.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_16 = math.max(var_459_7, arg_456_1.talkMaxDuration)

			if var_459_6 <= arg_456_1.time_ and arg_456_1.time_ < var_459_6 + var_459_16 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_6) / var_459_16

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_6 + var_459_16 and arg_456_1.time_ < var_459_6 + var_459_16 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play120431111 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 120431111
		arg_460_1.duration_ = 4.53

		local var_460_0 = {
			zh = 3.3,
			ja = 4.533
		}
		local var_460_1 = manager.audio:GetLocalizationFlag()

		if var_460_0[var_460_1] ~= nil then
			arg_460_1.duration_ = var_460_0[var_460_1]
		end

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play120431112(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = 0
			local var_463_1 = 0.425

			if var_463_0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_0 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				local var_463_2 = arg_460_1:FormatText(StoryNameCfg[6].name)

				arg_460_1.leftNameTxt_.text = var_463_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_3 = arg_460_1:GetWordFromCfg(120431111)
				local var_463_4 = arg_460_1:FormatText(var_463_3.content)

				arg_460_1.text_.text = var_463_4

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_5 = 17
				local var_463_6 = utf8.len(var_463_4)
				local var_463_7 = var_463_5 <= 0 and var_463_1 or var_463_1 * (var_463_6 / var_463_5)

				if var_463_7 > 0 and var_463_1 < var_463_7 then
					arg_460_1.talkMaxDuration = var_463_7

					if var_463_7 + var_463_0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_7 + var_463_0
					end
				end

				arg_460_1.text_.text = var_463_4
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431111", "story_v_out_120431.awb") ~= 0 then
					local var_463_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431111", "story_v_out_120431.awb") / 1000

					if var_463_8 + var_463_0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_8 + var_463_0
					end

					if var_463_3.prefab_name ~= "" and arg_460_1.actors_[var_463_3.prefab_name] ~= nil then
						local var_463_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_3.prefab_name].transform, "story_v_out_120431", "120431111", "story_v_out_120431.awb")

						arg_460_1:RecordAudio("120431111", var_463_9)
						arg_460_1:RecordAudio("120431111", var_463_9)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_out_120431", "120431111", "story_v_out_120431.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_out_120431", "120431111", "story_v_out_120431.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_10 = math.max(var_463_1, arg_460_1.talkMaxDuration)

			if var_463_0 <= arg_460_1.time_ and arg_460_1.time_ < var_463_0 + var_463_10 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_0) / var_463_10

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_0 + var_463_10 and arg_460_1.time_ < var_463_0 + var_463_10 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play120431112 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 120431112
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play120431113(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = 0
			local var_467_1 = 0.575

			if var_467_0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_0 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				local var_467_2 = arg_464_1:FormatText(StoryNameCfg[7].name)

				arg_464_1.leftNameTxt_.text = var_467_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, true)
				arg_464_1.iconController_:SetSelectedState("hero")

				arg_464_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_464_1.callingController_:SetSelectedState("normal")

				arg_464_1.keyicon_.color = Color.New(1, 1, 1)
				arg_464_1.icon_.color = Color.New(1, 1, 1)

				local var_467_3 = arg_464_1:GetWordFromCfg(120431112)
				local var_467_4 = arg_464_1:FormatText(var_467_3.content)

				arg_464_1.text_.text = var_467_4

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_5 = 23
				local var_467_6 = utf8.len(var_467_4)
				local var_467_7 = var_467_5 <= 0 and var_467_1 or var_467_1 * (var_467_6 / var_467_5)

				if var_467_7 > 0 and var_467_1 < var_467_7 then
					arg_464_1.talkMaxDuration = var_467_7

					if var_467_7 + var_467_0 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_7 + var_467_0
					end
				end

				arg_464_1.text_.text = var_467_4
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_8 = math.max(var_467_1, arg_464_1.talkMaxDuration)

			if var_467_0 <= arg_464_1.time_ and arg_464_1.time_ < var_467_0 + var_467_8 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_0) / var_467_8

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_0 + var_467_8 and arg_464_1.time_ < var_467_0 + var_467_8 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play120431113 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 120431113
		arg_468_1.duration_ = 6.7

		local var_468_0 = {
			zh = 4.066,
			ja = 6.7
		}
		local var_468_1 = manager.audio:GetLocalizationFlag()

		if var_468_0[var_468_1] ~= nil then
			arg_468_1.duration_ = var_468_0[var_468_1]
		end

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play120431114(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0
			local var_471_1 = 0.45

			if var_471_0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				local var_471_2 = arg_468_1:FormatText(StoryNameCfg[6].name)

				arg_468_1.leftNameTxt_.text = var_471_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_3 = arg_468_1:GetWordFromCfg(120431113)
				local var_471_4 = arg_468_1:FormatText(var_471_3.content)

				arg_468_1.text_.text = var_471_4

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_5 = 18
				local var_471_6 = utf8.len(var_471_4)
				local var_471_7 = var_471_5 <= 0 and var_471_1 or var_471_1 * (var_471_6 / var_471_5)

				if var_471_7 > 0 and var_471_1 < var_471_7 then
					arg_468_1.talkMaxDuration = var_471_7

					if var_471_7 + var_471_0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_7 + var_471_0
					end
				end

				arg_468_1.text_.text = var_471_4
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431113", "story_v_out_120431.awb") ~= 0 then
					local var_471_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431113", "story_v_out_120431.awb") / 1000

					if var_471_8 + var_471_0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_8 + var_471_0
					end

					if var_471_3.prefab_name ~= "" and arg_468_1.actors_[var_471_3.prefab_name] ~= nil then
						local var_471_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_3.prefab_name].transform, "story_v_out_120431", "120431113", "story_v_out_120431.awb")

						arg_468_1:RecordAudio("120431113", var_471_9)
						arg_468_1:RecordAudio("120431113", var_471_9)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_out_120431", "120431113", "story_v_out_120431.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_out_120431", "120431113", "story_v_out_120431.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_10 = math.max(var_471_1, arg_468_1.talkMaxDuration)

			if var_471_0 <= arg_468_1.time_ and arg_468_1.time_ < var_471_0 + var_471_10 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_0) / var_471_10

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_0 + var_471_10 and arg_468_1.time_ < var_471_0 + var_471_10 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play120431114 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 120431114
		arg_472_1.duration_ = 9.23

		local var_472_0 = {
			zh = 4.733,
			ja = 9.233
		}
		local var_472_1 = manager.audio:GetLocalizationFlag()

		if var_472_0[var_472_1] ~= nil then
			arg_472_1.duration_ = var_472_0[var_472_1]
		end

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play120431115(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = 0
			local var_475_1 = 0.65

			if var_475_0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_0 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_2 = arg_472_1:FormatText(StoryNameCfg[6].name)

				arg_472_1.leftNameTxt_.text = var_475_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_3 = arg_472_1:GetWordFromCfg(120431114)
				local var_475_4 = arg_472_1:FormatText(var_475_3.content)

				arg_472_1.text_.text = var_475_4

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_5 = 26
				local var_475_6 = utf8.len(var_475_4)
				local var_475_7 = var_475_5 <= 0 and var_475_1 or var_475_1 * (var_475_6 / var_475_5)

				if var_475_7 > 0 and var_475_1 < var_475_7 then
					arg_472_1.talkMaxDuration = var_475_7

					if var_475_7 + var_475_0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_7 + var_475_0
					end
				end

				arg_472_1.text_.text = var_475_4
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431114", "story_v_out_120431.awb") ~= 0 then
					local var_475_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431114", "story_v_out_120431.awb") / 1000

					if var_475_8 + var_475_0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_8 + var_475_0
					end

					if var_475_3.prefab_name ~= "" and arg_472_1.actors_[var_475_3.prefab_name] ~= nil then
						local var_475_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_3.prefab_name].transform, "story_v_out_120431", "120431114", "story_v_out_120431.awb")

						arg_472_1:RecordAudio("120431114", var_475_9)
						arg_472_1:RecordAudio("120431114", var_475_9)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_120431", "120431114", "story_v_out_120431.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_120431", "120431114", "story_v_out_120431.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_10 = math.max(var_475_1, arg_472_1.talkMaxDuration)

			if var_475_0 <= arg_472_1.time_ and arg_472_1.time_ < var_475_0 + var_475_10 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_0) / var_475_10

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_0 + var_475_10 and arg_472_1.time_ < var_475_0 + var_475_10 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play120431115 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 120431115
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play120431116(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = arg_476_1.actors_["1084ui_story"].transform
			local var_479_1 = 0

			if var_479_1 < arg_476_1.time_ and arg_476_1.time_ <= var_479_1 + arg_479_0 then
				arg_476_1.var_.moveOldPos1084ui_story = var_479_0.localPosition
			end

			local var_479_2 = 0.001

			if var_479_1 <= arg_476_1.time_ and arg_476_1.time_ < var_479_1 + var_479_2 then
				local var_479_3 = (arg_476_1.time_ - var_479_1) / var_479_2
				local var_479_4 = Vector3.New(0, 100, 0)

				var_479_0.localPosition = Vector3.Lerp(arg_476_1.var_.moveOldPos1084ui_story, var_479_4, var_479_3)

				local var_479_5 = manager.ui.mainCamera.transform.position - var_479_0.position

				var_479_0.forward = Vector3.New(var_479_5.x, var_479_5.y, var_479_5.z)

				local var_479_6 = var_479_0.localEulerAngles

				var_479_6.z = 0
				var_479_6.x = 0
				var_479_0.localEulerAngles = var_479_6
			end

			if arg_476_1.time_ >= var_479_1 + var_479_2 and arg_476_1.time_ < var_479_1 + var_479_2 + arg_479_0 then
				var_479_0.localPosition = Vector3.New(0, 100, 0)

				local var_479_7 = manager.ui.mainCamera.transform.position - var_479_0.position

				var_479_0.forward = Vector3.New(var_479_7.x, var_479_7.y, var_479_7.z)

				local var_479_8 = var_479_0.localEulerAngles

				var_479_8.z = 0
				var_479_8.x = 0
				var_479_0.localEulerAngles = var_479_8
			end

			local var_479_9 = arg_476_1.actors_["1029ui_story"].transform
			local var_479_10 = 0

			if var_479_10 < arg_476_1.time_ and arg_476_1.time_ <= var_479_10 + arg_479_0 then
				arg_476_1.var_.moveOldPos1029ui_story = var_479_9.localPosition
			end

			local var_479_11 = 0.001

			if var_479_10 <= arg_476_1.time_ and arg_476_1.time_ < var_479_10 + var_479_11 then
				local var_479_12 = (arg_476_1.time_ - var_479_10) / var_479_11
				local var_479_13 = Vector3.New(0, 100, 0)

				var_479_9.localPosition = Vector3.Lerp(arg_476_1.var_.moveOldPos1029ui_story, var_479_13, var_479_12)

				local var_479_14 = manager.ui.mainCamera.transform.position - var_479_9.position

				var_479_9.forward = Vector3.New(var_479_14.x, var_479_14.y, var_479_14.z)

				local var_479_15 = var_479_9.localEulerAngles

				var_479_15.z = 0
				var_479_15.x = 0
				var_479_9.localEulerAngles = var_479_15
			end

			if arg_476_1.time_ >= var_479_10 + var_479_11 and arg_476_1.time_ < var_479_10 + var_479_11 + arg_479_0 then
				var_479_9.localPosition = Vector3.New(0, 100, 0)

				local var_479_16 = manager.ui.mainCamera.transform.position - var_479_9.position

				var_479_9.forward = Vector3.New(var_479_16.x, var_479_16.y, var_479_16.z)

				local var_479_17 = var_479_9.localEulerAngles

				var_479_17.z = 0
				var_479_17.x = 0
				var_479_9.localEulerAngles = var_479_17
			end

			local var_479_18 = 0
			local var_479_19 = 1.05

			if var_479_18 < arg_476_1.time_ and arg_476_1.time_ <= var_479_18 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, false)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_20 = arg_476_1:GetWordFromCfg(120431115)
				local var_479_21 = arg_476_1:FormatText(var_479_20.content)

				arg_476_1.text_.text = var_479_21

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_22 = 42
				local var_479_23 = utf8.len(var_479_21)
				local var_479_24 = var_479_22 <= 0 and var_479_19 or var_479_19 * (var_479_23 / var_479_22)

				if var_479_24 > 0 and var_479_19 < var_479_24 then
					arg_476_1.talkMaxDuration = var_479_24

					if var_479_24 + var_479_18 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_24 + var_479_18
					end
				end

				arg_476_1.text_.text = var_479_21
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_25 = math.max(var_479_19, arg_476_1.talkMaxDuration)

			if var_479_18 <= arg_476_1.time_ and arg_476_1.time_ < var_479_18 + var_479_25 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_18) / var_479_25

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_18 + var_479_25 and arg_476_1.time_ < var_479_18 + var_479_25 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_476_1:InitPlayNodeList()
	end,
	Play120431116 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 120431116
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play120431117(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = 0
			local var_483_1 = 0.725

			if var_483_0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_0 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, false)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_2 = arg_480_1:GetWordFromCfg(120431116)
				local var_483_3 = arg_480_1:FormatText(var_483_2.content)

				arg_480_1.text_.text = var_483_3

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_4 = 29
				local var_483_5 = utf8.len(var_483_3)
				local var_483_6 = var_483_4 <= 0 and var_483_1 or var_483_1 * (var_483_5 / var_483_4)

				if var_483_6 > 0 and var_483_1 < var_483_6 then
					arg_480_1.talkMaxDuration = var_483_6

					if var_483_6 + var_483_0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_6 + var_483_0
					end
				end

				arg_480_1.text_.text = var_483_3
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_7 = math.max(var_483_1, arg_480_1.talkMaxDuration)

			if var_483_0 <= arg_480_1.time_ and arg_480_1.time_ < var_483_0 + var_483_7 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_0) / var_483_7

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_0 + var_483_7 and arg_480_1.time_ < var_483_0 + var_483_7 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play120431117 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 120431117
		arg_484_1.duration_ = 8.17

		local var_484_0 = {
			zh = 5.033,
			ja = 8.166
		}
		local var_484_1 = manager.audio:GetLocalizationFlag()

		if var_484_0[var_484_1] ~= nil then
			arg_484_1.duration_ = var_484_0[var_484_1]
		end

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play120431118(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = arg_484_1.actors_["1029ui_story"].transform
			local var_487_1 = 0

			if var_487_1 < arg_484_1.time_ and arg_484_1.time_ <= var_487_1 + arg_487_0 then
				arg_484_1.var_.moveOldPos1029ui_story = var_487_0.localPosition
			end

			local var_487_2 = 0.001

			if var_487_1 <= arg_484_1.time_ and arg_484_1.time_ < var_487_1 + var_487_2 then
				local var_487_3 = (arg_484_1.time_ - var_487_1) / var_487_2
				local var_487_4 = Vector3.New(0, -1.09, -6.2)

				var_487_0.localPosition = Vector3.Lerp(arg_484_1.var_.moveOldPos1029ui_story, var_487_4, var_487_3)

				local var_487_5 = manager.ui.mainCamera.transform.position - var_487_0.position

				var_487_0.forward = Vector3.New(var_487_5.x, var_487_5.y, var_487_5.z)

				local var_487_6 = var_487_0.localEulerAngles

				var_487_6.z = 0
				var_487_6.x = 0
				var_487_0.localEulerAngles = var_487_6
			end

			if arg_484_1.time_ >= var_487_1 + var_487_2 and arg_484_1.time_ < var_487_1 + var_487_2 + arg_487_0 then
				var_487_0.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_487_7 = manager.ui.mainCamera.transform.position - var_487_0.position

				var_487_0.forward = Vector3.New(var_487_7.x, var_487_7.y, var_487_7.z)

				local var_487_8 = var_487_0.localEulerAngles

				var_487_8.z = 0
				var_487_8.x = 0
				var_487_0.localEulerAngles = var_487_8
			end

			local var_487_9 = 0

			if var_487_9 < arg_484_1.time_ and arg_484_1.time_ <= var_487_9 + arg_487_0 then
				arg_484_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_487_10 = 0

			if var_487_10 < arg_484_1.time_ and arg_484_1.time_ <= var_487_10 + arg_487_0 then
				arg_484_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_487_11 = arg_484_1.actors_["1029ui_story"]
			local var_487_12 = 0

			if var_487_12 < arg_484_1.time_ and arg_484_1.time_ <= var_487_12 + arg_487_0 and not isNil(var_487_11) and arg_484_1.var_.characterEffect1029ui_story == nil then
				arg_484_1.var_.characterEffect1029ui_story = var_487_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_487_13 = 0.2

			if var_487_12 <= arg_484_1.time_ and arg_484_1.time_ < var_487_12 + var_487_13 and not isNil(var_487_11) then
				local var_487_14 = (arg_484_1.time_ - var_487_12) / var_487_13

				if arg_484_1.var_.characterEffect1029ui_story and not isNil(var_487_11) then
					arg_484_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_484_1.time_ >= var_487_12 + var_487_13 and arg_484_1.time_ < var_487_12 + var_487_13 + arg_487_0 and not isNil(var_487_11) and arg_484_1.var_.characterEffect1029ui_story then
				arg_484_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_487_15 = 0
			local var_487_16 = 0.45

			if var_487_15 < arg_484_1.time_ and arg_484_1.time_ <= var_487_15 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				local var_487_17 = arg_484_1:FormatText(StoryNameCfg[319].name)

				arg_484_1.leftNameTxt_.text = var_487_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_18 = arg_484_1:GetWordFromCfg(120431117)
				local var_487_19 = arg_484_1:FormatText(var_487_18.content)

				arg_484_1.text_.text = var_487_19

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_20 = 18
				local var_487_21 = utf8.len(var_487_19)
				local var_487_22 = var_487_20 <= 0 and var_487_16 or var_487_16 * (var_487_21 / var_487_20)

				if var_487_22 > 0 and var_487_16 < var_487_22 then
					arg_484_1.talkMaxDuration = var_487_22

					if var_487_22 + var_487_15 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_22 + var_487_15
					end
				end

				arg_484_1.text_.text = var_487_19
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431117", "story_v_out_120431.awb") ~= 0 then
					local var_487_23 = manager.audio:GetVoiceLength("story_v_out_120431", "120431117", "story_v_out_120431.awb") / 1000

					if var_487_23 + var_487_15 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_23 + var_487_15
					end

					if var_487_18.prefab_name ~= "" and arg_484_1.actors_[var_487_18.prefab_name] ~= nil then
						local var_487_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_18.prefab_name].transform, "story_v_out_120431", "120431117", "story_v_out_120431.awb")

						arg_484_1:RecordAudio("120431117", var_487_24)
						arg_484_1:RecordAudio("120431117", var_487_24)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_out_120431", "120431117", "story_v_out_120431.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_out_120431", "120431117", "story_v_out_120431.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_25 = math.max(var_487_16, arg_484_1.talkMaxDuration)

			if var_487_15 <= arg_484_1.time_ and arg_484_1.time_ < var_487_15 + var_487_25 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_15) / var_487_25

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_15 + var_487_25 and arg_484_1.time_ < var_487_15 + var_487_25 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_484_1:InitPlayNodeList()
	end,
	Play120431118 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 120431118
		arg_488_1.duration_ = 5

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play120431119(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = arg_488_1.actors_["1029ui_story"]
			local var_491_1 = 0

			if var_491_1 < arg_488_1.time_ and arg_488_1.time_ <= var_491_1 + arg_491_0 and not isNil(var_491_0) and arg_488_1.var_.characterEffect1029ui_story == nil then
				arg_488_1.var_.characterEffect1029ui_story = var_491_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_2 = 0.2

			if var_491_1 <= arg_488_1.time_ and arg_488_1.time_ < var_491_1 + var_491_2 and not isNil(var_491_0) then
				local var_491_3 = (arg_488_1.time_ - var_491_1) / var_491_2

				if arg_488_1.var_.characterEffect1029ui_story and not isNil(var_491_0) then
					local var_491_4 = Mathf.Lerp(0, 0.5, var_491_3)

					arg_488_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_488_1.var_.characterEffect1029ui_story.fillRatio = var_491_4
				end
			end

			if arg_488_1.time_ >= var_491_1 + var_491_2 and arg_488_1.time_ < var_491_1 + var_491_2 + arg_491_0 and not isNil(var_491_0) and arg_488_1.var_.characterEffect1029ui_story then
				local var_491_5 = 0.5

				arg_488_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_488_1.var_.characterEffect1029ui_story.fillRatio = var_491_5
			end

			local var_491_6 = 0
			local var_491_7 = 0.175

			if var_491_6 < arg_488_1.time_ and arg_488_1.time_ <= var_491_6 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				local var_491_8 = arg_488_1:FormatText(StoryNameCfg[7].name)

				arg_488_1.leftNameTxt_.text = var_491_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, true)
				arg_488_1.iconController_:SetSelectedState("hero")

				arg_488_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_488_1.callingController_:SetSelectedState("normal")

				arg_488_1.keyicon_.color = Color.New(1, 1, 1)
				arg_488_1.icon_.color = Color.New(1, 1, 1)

				local var_491_9 = arg_488_1:GetWordFromCfg(120431118)
				local var_491_10 = arg_488_1:FormatText(var_491_9.content)

				arg_488_1.text_.text = var_491_10

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_11 = 7
				local var_491_12 = utf8.len(var_491_10)
				local var_491_13 = var_491_11 <= 0 and var_491_7 or var_491_7 * (var_491_12 / var_491_11)

				if var_491_13 > 0 and var_491_7 < var_491_13 then
					arg_488_1.talkMaxDuration = var_491_13

					if var_491_13 + var_491_6 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_13 + var_491_6
					end
				end

				arg_488_1.text_.text = var_491_10
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)
				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_14 = math.max(var_491_7, arg_488_1.talkMaxDuration)

			if var_491_6 <= arg_488_1.time_ and arg_488_1.time_ < var_491_6 + var_491_14 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_6) / var_491_14

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_6 + var_491_14 and arg_488_1.time_ < var_491_6 + var_491_14 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play120431119 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 120431119
		arg_492_1.duration_ = 5.5

		local var_492_0 = {
			zh = 1.933,
			ja = 5.5
		}
		local var_492_1 = manager.audio:GetLocalizationFlag()

		if var_492_0[var_492_1] ~= nil then
			arg_492_1.duration_ = var_492_0[var_492_1]
		end

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play120431120(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = arg_492_1.actors_["1029ui_story"]
			local var_495_1 = 0

			if var_495_1 < arg_492_1.time_ and arg_492_1.time_ <= var_495_1 + arg_495_0 and not isNil(var_495_0) and arg_492_1.var_.characterEffect1029ui_story == nil then
				arg_492_1.var_.characterEffect1029ui_story = var_495_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_495_2 = 0.2

			if var_495_1 <= arg_492_1.time_ and arg_492_1.time_ < var_495_1 + var_495_2 and not isNil(var_495_0) then
				local var_495_3 = (arg_492_1.time_ - var_495_1) / var_495_2

				if arg_492_1.var_.characterEffect1029ui_story and not isNil(var_495_0) then
					arg_492_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_492_1.time_ >= var_495_1 + var_495_2 and arg_492_1.time_ < var_495_1 + var_495_2 + arg_495_0 and not isNil(var_495_0) and arg_492_1.var_.characterEffect1029ui_story then
				arg_492_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_495_4 = 0
			local var_495_5 = 0.2

			if var_495_4 < arg_492_1.time_ and arg_492_1.time_ <= var_495_4 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				local var_495_6 = arg_492_1:FormatText(StoryNameCfg[319].name)

				arg_492_1.leftNameTxt_.text = var_495_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_7 = arg_492_1:GetWordFromCfg(120431119)
				local var_495_8 = arg_492_1:FormatText(var_495_7.content)

				arg_492_1.text_.text = var_495_8

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_9 = 8
				local var_495_10 = utf8.len(var_495_8)
				local var_495_11 = var_495_9 <= 0 and var_495_5 or var_495_5 * (var_495_10 / var_495_9)

				if var_495_11 > 0 and var_495_5 < var_495_11 then
					arg_492_1.talkMaxDuration = var_495_11

					if var_495_11 + var_495_4 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_11 + var_495_4
					end
				end

				arg_492_1.text_.text = var_495_8
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431119", "story_v_out_120431.awb") ~= 0 then
					local var_495_12 = manager.audio:GetVoiceLength("story_v_out_120431", "120431119", "story_v_out_120431.awb") / 1000

					if var_495_12 + var_495_4 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_12 + var_495_4
					end

					if var_495_7.prefab_name ~= "" and arg_492_1.actors_[var_495_7.prefab_name] ~= nil then
						local var_495_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_7.prefab_name].transform, "story_v_out_120431", "120431119", "story_v_out_120431.awb")

						arg_492_1:RecordAudio("120431119", var_495_13)
						arg_492_1:RecordAudio("120431119", var_495_13)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_out_120431", "120431119", "story_v_out_120431.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_out_120431", "120431119", "story_v_out_120431.awb")
				end

				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_14 = math.max(var_495_5, arg_492_1.talkMaxDuration)

			if var_495_4 <= arg_492_1.time_ and arg_492_1.time_ < var_495_4 + var_495_14 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_4) / var_495_14

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_4 + var_495_14 and arg_492_1.time_ < var_495_4 + var_495_14 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {}

		arg_492_1:InitPlayNodeList()
	end,
	Play120431120 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 120431120
		arg_496_1.duration_ = 3.77

		local var_496_0 = {
			zh = 1.633,
			ja = 3.766
		}
		local var_496_1 = manager.audio:GetLocalizationFlag()

		if var_496_0[var_496_1] ~= nil then
			arg_496_1.duration_ = var_496_0[var_496_1]
		end

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play120431121(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = 0
			local var_499_1 = 0.175

			if var_499_0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_0 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				local var_499_2 = arg_496_1:FormatText(StoryNameCfg[319].name)

				arg_496_1.leftNameTxt_.text = var_499_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_3 = arg_496_1:GetWordFromCfg(120431120)
				local var_499_4 = arg_496_1:FormatText(var_499_3.content)

				arg_496_1.text_.text = var_499_4

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_5 = 7
				local var_499_6 = utf8.len(var_499_4)
				local var_499_7 = var_499_5 <= 0 and var_499_1 or var_499_1 * (var_499_6 / var_499_5)

				if var_499_7 > 0 and var_499_1 < var_499_7 then
					arg_496_1.talkMaxDuration = var_499_7

					if var_499_7 + var_499_0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_7 + var_499_0
					end
				end

				arg_496_1.text_.text = var_499_4
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431120", "story_v_out_120431.awb") ~= 0 then
					local var_499_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431120", "story_v_out_120431.awb") / 1000

					if var_499_8 + var_499_0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_8 + var_499_0
					end

					if var_499_3.prefab_name ~= "" and arg_496_1.actors_[var_499_3.prefab_name] ~= nil then
						local var_499_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_496_1.actors_[var_499_3.prefab_name].transform, "story_v_out_120431", "120431120", "story_v_out_120431.awb")

						arg_496_1:RecordAudio("120431120", var_499_9)
						arg_496_1:RecordAudio("120431120", var_499_9)
					else
						arg_496_1:AudioAction("play", "voice", "story_v_out_120431", "120431120", "story_v_out_120431.awb")
					end

					arg_496_1:RecordHistoryTalkVoice("story_v_out_120431", "120431120", "story_v_out_120431.awb")
				end

				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_10 = math.max(var_499_1, arg_496_1.talkMaxDuration)

			if var_499_0 <= arg_496_1.time_ and arg_496_1.time_ < var_499_0 + var_499_10 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_0) / var_499_10

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_0 + var_499_10 and arg_496_1.time_ < var_499_0 + var_499_10 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play120431121 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 120431121
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play120431122(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = arg_500_1.actors_["1029ui_story"]
			local var_503_1 = 0

			if var_503_1 < arg_500_1.time_ and arg_500_1.time_ <= var_503_1 + arg_503_0 and not isNil(var_503_0) and arg_500_1.var_.characterEffect1029ui_story == nil then
				arg_500_1.var_.characterEffect1029ui_story = var_503_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_503_2 = 0.2

			if var_503_1 <= arg_500_1.time_ and arg_500_1.time_ < var_503_1 + var_503_2 and not isNil(var_503_0) then
				local var_503_3 = (arg_500_1.time_ - var_503_1) / var_503_2

				if arg_500_1.var_.characterEffect1029ui_story and not isNil(var_503_0) then
					local var_503_4 = Mathf.Lerp(0, 0.5, var_503_3)

					arg_500_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_500_1.var_.characterEffect1029ui_story.fillRatio = var_503_4
				end
			end

			if arg_500_1.time_ >= var_503_1 + var_503_2 and arg_500_1.time_ < var_503_1 + var_503_2 + arg_503_0 and not isNil(var_503_0) and arg_500_1.var_.characterEffect1029ui_story then
				local var_503_5 = 0.5

				arg_500_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_500_1.var_.characterEffect1029ui_story.fillRatio = var_503_5
			end

			local var_503_6 = 0
			local var_503_7 = 0.45

			if var_503_6 < arg_500_1.time_ and arg_500_1.time_ <= var_503_6 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				local var_503_8 = arg_500_1:FormatText(StoryNameCfg[7].name)

				arg_500_1.leftNameTxt_.text = var_503_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, true)
				arg_500_1.iconController_:SetSelectedState("hero")

				arg_500_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_500_1.callingController_:SetSelectedState("normal")

				arg_500_1.keyicon_.color = Color.New(1, 1, 1)
				arg_500_1.icon_.color = Color.New(1, 1, 1)

				local var_503_9 = arg_500_1:GetWordFromCfg(120431121)
				local var_503_10 = arg_500_1:FormatText(var_503_9.content)

				arg_500_1.text_.text = var_503_10

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_11 = 18
				local var_503_12 = utf8.len(var_503_10)
				local var_503_13 = var_503_11 <= 0 and var_503_7 or var_503_7 * (var_503_12 / var_503_11)

				if var_503_13 > 0 and var_503_7 < var_503_13 then
					arg_500_1.talkMaxDuration = var_503_13

					if var_503_13 + var_503_6 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_13 + var_503_6
					end
				end

				arg_500_1.text_.text = var_503_10
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_14 = math.max(var_503_7, arg_500_1.talkMaxDuration)

			if var_503_6 <= arg_500_1.time_ and arg_500_1.time_ < var_503_6 + var_503_14 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_6) / var_503_14

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_6 + var_503_14 and arg_500_1.time_ < var_503_6 + var_503_14 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play120431122 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 120431122
		arg_504_1.duration_ = 6.2

		local var_504_0 = {
			zh = 4,
			ja = 6.2
		}
		local var_504_1 = manager.audio:GetLocalizationFlag()

		if var_504_0[var_504_1] ~= nil then
			arg_504_1.duration_ = var_504_0[var_504_1]
		end

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play120431123(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = arg_504_1.actors_["1029ui_story"]
			local var_507_1 = 0

			if var_507_1 < arg_504_1.time_ and arg_504_1.time_ <= var_507_1 + arg_507_0 and not isNil(var_507_0) and arg_504_1.var_.characterEffect1029ui_story == nil then
				arg_504_1.var_.characterEffect1029ui_story = var_507_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_507_2 = 0.2

			if var_507_1 <= arg_504_1.time_ and arg_504_1.time_ < var_507_1 + var_507_2 and not isNil(var_507_0) then
				local var_507_3 = (arg_504_1.time_ - var_507_1) / var_507_2

				if arg_504_1.var_.characterEffect1029ui_story and not isNil(var_507_0) then
					arg_504_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_504_1.time_ >= var_507_1 + var_507_2 and arg_504_1.time_ < var_507_1 + var_507_2 + arg_507_0 and not isNil(var_507_0) and arg_504_1.var_.characterEffect1029ui_story then
				arg_504_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_507_4 = 0
			local var_507_5 = 0.425

			if var_507_4 < arg_504_1.time_ and arg_504_1.time_ <= var_507_4 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				local var_507_6 = arg_504_1:FormatText(StoryNameCfg[319].name)

				arg_504_1.leftNameTxt_.text = var_507_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_7 = arg_504_1:GetWordFromCfg(120431122)
				local var_507_8 = arg_504_1:FormatText(var_507_7.content)

				arg_504_1.text_.text = var_507_8

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_9 = 17
				local var_507_10 = utf8.len(var_507_8)
				local var_507_11 = var_507_9 <= 0 and var_507_5 or var_507_5 * (var_507_10 / var_507_9)

				if var_507_11 > 0 and var_507_5 < var_507_11 then
					arg_504_1.talkMaxDuration = var_507_11

					if var_507_11 + var_507_4 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_11 + var_507_4
					end
				end

				arg_504_1.text_.text = var_507_8
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431122", "story_v_out_120431.awb") ~= 0 then
					local var_507_12 = manager.audio:GetVoiceLength("story_v_out_120431", "120431122", "story_v_out_120431.awb") / 1000

					if var_507_12 + var_507_4 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_12 + var_507_4
					end

					if var_507_7.prefab_name ~= "" and arg_504_1.actors_[var_507_7.prefab_name] ~= nil then
						local var_507_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_7.prefab_name].transform, "story_v_out_120431", "120431122", "story_v_out_120431.awb")

						arg_504_1:RecordAudio("120431122", var_507_13)
						arg_504_1:RecordAudio("120431122", var_507_13)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_out_120431", "120431122", "story_v_out_120431.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_out_120431", "120431122", "story_v_out_120431.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_14 = math.max(var_507_5, arg_504_1.talkMaxDuration)

			if var_507_4 <= arg_504_1.time_ and arg_504_1.time_ < var_507_4 + var_507_14 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_4) / var_507_14

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_4 + var_507_14 and arg_504_1.time_ < var_507_4 + var_507_14 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play120431123 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 120431123
		arg_508_1.duration_ = 5

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play120431124(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = arg_508_1.actors_["1029ui_story"]
			local var_511_1 = 0

			if var_511_1 < arg_508_1.time_ and arg_508_1.time_ <= var_511_1 + arg_511_0 and not isNil(var_511_0) and arg_508_1.var_.characterEffect1029ui_story == nil then
				arg_508_1.var_.characterEffect1029ui_story = var_511_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_511_2 = 0.2

			if var_511_1 <= arg_508_1.time_ and arg_508_1.time_ < var_511_1 + var_511_2 and not isNil(var_511_0) then
				local var_511_3 = (arg_508_1.time_ - var_511_1) / var_511_2

				if arg_508_1.var_.characterEffect1029ui_story and not isNil(var_511_0) then
					local var_511_4 = Mathf.Lerp(0, 0.5, var_511_3)

					arg_508_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_508_1.var_.characterEffect1029ui_story.fillRatio = var_511_4
				end
			end

			if arg_508_1.time_ >= var_511_1 + var_511_2 and arg_508_1.time_ < var_511_1 + var_511_2 + arg_511_0 and not isNil(var_511_0) and arg_508_1.var_.characterEffect1029ui_story then
				local var_511_5 = 0.5

				arg_508_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_508_1.var_.characterEffect1029ui_story.fillRatio = var_511_5
			end

			local var_511_6 = 0
			local var_511_7 = 0.725

			if var_511_6 < arg_508_1.time_ and arg_508_1.time_ <= var_511_6 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_8 = arg_508_1:FormatText(StoryNameCfg[7].name)

				arg_508_1.leftNameTxt_.text = var_511_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, true)
				arg_508_1.iconController_:SetSelectedState("hero")

				arg_508_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_508_1.callingController_:SetSelectedState("normal")

				arg_508_1.keyicon_.color = Color.New(1, 1, 1)
				arg_508_1.icon_.color = Color.New(1, 1, 1)

				local var_511_9 = arg_508_1:GetWordFromCfg(120431123)
				local var_511_10 = arg_508_1:FormatText(var_511_9.content)

				arg_508_1.text_.text = var_511_10

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_11 = 29
				local var_511_12 = utf8.len(var_511_10)
				local var_511_13 = var_511_11 <= 0 and var_511_7 or var_511_7 * (var_511_12 / var_511_11)

				if var_511_13 > 0 and var_511_7 < var_511_13 then
					arg_508_1.talkMaxDuration = var_511_13

					if var_511_13 + var_511_6 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_13 + var_511_6
					end
				end

				arg_508_1.text_.text = var_511_10
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)
				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_14 = math.max(var_511_7, arg_508_1.talkMaxDuration)

			if var_511_6 <= arg_508_1.time_ and arg_508_1.time_ < var_511_6 + var_511_14 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_6) / var_511_14

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_6 + var_511_14 and arg_508_1.time_ < var_511_6 + var_511_14 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play120431124 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 120431124
		arg_512_1.duration_ = 4.8

		local var_512_0 = {
			zh = 4.8,
			ja = 3.1
		}
		local var_512_1 = manager.audio:GetLocalizationFlag()

		if var_512_0[var_512_1] ~= nil then
			arg_512_1.duration_ = var_512_0[var_512_1]
		end

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play120431125(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = arg_512_1.actors_["1029ui_story"]
			local var_515_1 = 0

			if var_515_1 < arg_512_1.time_ and arg_512_1.time_ <= var_515_1 + arg_515_0 and not isNil(var_515_0) and arg_512_1.var_.characterEffect1029ui_story == nil then
				arg_512_1.var_.characterEffect1029ui_story = var_515_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_515_2 = 0.2

			if var_515_1 <= arg_512_1.time_ and arg_512_1.time_ < var_515_1 + var_515_2 and not isNil(var_515_0) then
				local var_515_3 = (arg_512_1.time_ - var_515_1) / var_515_2

				if arg_512_1.var_.characterEffect1029ui_story and not isNil(var_515_0) then
					arg_512_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_512_1.time_ >= var_515_1 + var_515_2 and arg_512_1.time_ < var_515_1 + var_515_2 + arg_515_0 and not isNil(var_515_0) and arg_512_1.var_.characterEffect1029ui_story then
				arg_512_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_515_4 = 0
			local var_515_5 = 0.375

			if var_515_4 < arg_512_1.time_ and arg_512_1.time_ <= var_515_4 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				local var_515_6 = arg_512_1:FormatText(StoryNameCfg[319].name)

				arg_512_1.leftNameTxt_.text = var_515_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_7 = arg_512_1:GetWordFromCfg(120431124)
				local var_515_8 = arg_512_1:FormatText(var_515_7.content)

				arg_512_1.text_.text = var_515_8

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_9 = 15
				local var_515_10 = utf8.len(var_515_8)
				local var_515_11 = var_515_9 <= 0 and var_515_5 or var_515_5 * (var_515_10 / var_515_9)

				if var_515_11 > 0 and var_515_5 < var_515_11 then
					arg_512_1.talkMaxDuration = var_515_11

					if var_515_11 + var_515_4 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_11 + var_515_4
					end
				end

				arg_512_1.text_.text = var_515_8
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431124", "story_v_out_120431.awb") ~= 0 then
					local var_515_12 = manager.audio:GetVoiceLength("story_v_out_120431", "120431124", "story_v_out_120431.awb") / 1000

					if var_515_12 + var_515_4 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_12 + var_515_4
					end

					if var_515_7.prefab_name ~= "" and arg_512_1.actors_[var_515_7.prefab_name] ~= nil then
						local var_515_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_7.prefab_name].transform, "story_v_out_120431", "120431124", "story_v_out_120431.awb")

						arg_512_1:RecordAudio("120431124", var_515_13)
						arg_512_1:RecordAudio("120431124", var_515_13)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_out_120431", "120431124", "story_v_out_120431.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_out_120431", "120431124", "story_v_out_120431.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_14 = math.max(var_515_5, arg_512_1.talkMaxDuration)

			if var_515_4 <= arg_512_1.time_ and arg_512_1.time_ < var_515_4 + var_515_14 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_4) / var_515_14

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_4 + var_515_14 and arg_512_1.time_ < var_515_4 + var_515_14 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {}

		arg_512_1:InitPlayNodeList()
	end,
	Play120431125 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 120431125
		arg_516_1.duration_ = 5

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play120431126(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = arg_516_1.actors_["1029ui_story"]
			local var_519_1 = 0

			if var_519_1 < arg_516_1.time_ and arg_516_1.time_ <= var_519_1 + arg_519_0 and not isNil(var_519_0) and arg_516_1.var_.characterEffect1029ui_story == nil then
				arg_516_1.var_.characterEffect1029ui_story = var_519_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_2 = 0.2

			if var_519_1 <= arg_516_1.time_ and arg_516_1.time_ < var_519_1 + var_519_2 and not isNil(var_519_0) then
				local var_519_3 = (arg_516_1.time_ - var_519_1) / var_519_2

				if arg_516_1.var_.characterEffect1029ui_story and not isNil(var_519_0) then
					local var_519_4 = Mathf.Lerp(0, 0.5, var_519_3)

					arg_516_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_516_1.var_.characterEffect1029ui_story.fillRatio = var_519_4
				end
			end

			if arg_516_1.time_ >= var_519_1 + var_519_2 and arg_516_1.time_ < var_519_1 + var_519_2 + arg_519_0 and not isNil(var_519_0) and arg_516_1.var_.characterEffect1029ui_story then
				local var_519_5 = 0.5

				arg_516_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_516_1.var_.characterEffect1029ui_story.fillRatio = var_519_5
			end

			local var_519_6 = 0
			local var_519_7 = 0.2

			if var_519_6 < arg_516_1.time_ and arg_516_1.time_ <= var_519_6 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				local var_519_8 = arg_516_1:FormatText(StoryNameCfg[7].name)

				arg_516_1.leftNameTxt_.text = var_519_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, true)
				arg_516_1.iconController_:SetSelectedState("hero")

				arg_516_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_516_1.callingController_:SetSelectedState("normal")

				arg_516_1.keyicon_.color = Color.New(1, 1, 1)
				arg_516_1.icon_.color = Color.New(1, 1, 1)

				local var_519_9 = arg_516_1:GetWordFromCfg(120431125)
				local var_519_10 = arg_516_1:FormatText(var_519_9.content)

				arg_516_1.text_.text = var_519_10

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_11 = 8
				local var_519_12 = utf8.len(var_519_10)
				local var_519_13 = var_519_11 <= 0 and var_519_7 or var_519_7 * (var_519_12 / var_519_11)

				if var_519_13 > 0 and var_519_7 < var_519_13 then
					arg_516_1.talkMaxDuration = var_519_13

					if var_519_13 + var_519_6 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_13 + var_519_6
					end
				end

				arg_516_1.text_.text = var_519_10
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)
				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_14 = math.max(var_519_7, arg_516_1.talkMaxDuration)

			if var_519_6 <= arg_516_1.time_ and arg_516_1.time_ < var_519_6 + var_519_14 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_6) / var_519_14

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_6 + var_519_14 and arg_516_1.time_ < var_519_6 + var_519_14 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {}

		arg_516_1:InitPlayNodeList()
	end,
	Play120431126 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 120431126
		arg_520_1.duration_ = 5

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play120431127(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = 0
			local var_523_1 = 0.7

			if var_523_0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_0 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, false)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_2 = arg_520_1:GetWordFromCfg(120431126)
				local var_523_3 = arg_520_1:FormatText(var_523_2.content)

				arg_520_1.text_.text = var_523_3

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_4 = 28
				local var_523_5 = utf8.len(var_523_3)
				local var_523_6 = var_523_4 <= 0 and var_523_1 or var_523_1 * (var_523_5 / var_523_4)

				if var_523_6 > 0 and var_523_1 < var_523_6 then
					arg_520_1.talkMaxDuration = var_523_6

					if var_523_6 + var_523_0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_6 + var_523_0
					end
				end

				arg_520_1.text_.text = var_523_3
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)
				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_7 = math.max(var_523_1, arg_520_1.talkMaxDuration)

			if var_523_0 <= arg_520_1.time_ and arg_520_1.time_ < var_523_0 + var_523_7 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_0) / var_523_7

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_0 + var_523_7 and arg_520_1.time_ < var_523_0 + var_523_7 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play120431127 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 120431127
		arg_524_1.duration_ = 11.5

		local var_524_0 = {
			zh = 10.466,
			ja = 11.5
		}
		local var_524_1 = manager.audio:GetLocalizationFlag()

		if var_524_0[var_524_1] ~= nil then
			arg_524_1.duration_ = var_524_0[var_524_1]
		end

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play120431128(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = arg_524_1.actors_["1029ui_story"]
			local var_527_1 = 0

			if var_527_1 < arg_524_1.time_ and arg_524_1.time_ <= var_527_1 + arg_527_0 and not isNil(var_527_0) and arg_524_1.var_.characterEffect1029ui_story == nil then
				arg_524_1.var_.characterEffect1029ui_story = var_527_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_527_2 = 0.2

			if var_527_1 <= arg_524_1.time_ and arg_524_1.time_ < var_527_1 + var_527_2 and not isNil(var_527_0) then
				local var_527_3 = (arg_524_1.time_ - var_527_1) / var_527_2

				if arg_524_1.var_.characterEffect1029ui_story and not isNil(var_527_0) then
					arg_524_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_524_1.time_ >= var_527_1 + var_527_2 and arg_524_1.time_ < var_527_1 + var_527_2 + arg_527_0 and not isNil(var_527_0) and arg_524_1.var_.characterEffect1029ui_story then
				arg_524_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_527_4 = 0
			local var_527_5 = 1

			if var_527_4 < arg_524_1.time_ and arg_524_1.time_ <= var_527_4 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				local var_527_6 = arg_524_1:FormatText(StoryNameCfg[319].name)

				arg_524_1.leftNameTxt_.text = var_527_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_7 = arg_524_1:GetWordFromCfg(120431127)
				local var_527_8 = arg_524_1:FormatText(var_527_7.content)

				arg_524_1.text_.text = var_527_8

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_9 = 40
				local var_527_10 = utf8.len(var_527_8)
				local var_527_11 = var_527_9 <= 0 and var_527_5 or var_527_5 * (var_527_10 / var_527_9)

				if var_527_11 > 0 and var_527_5 < var_527_11 then
					arg_524_1.talkMaxDuration = var_527_11

					if var_527_11 + var_527_4 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_11 + var_527_4
					end
				end

				arg_524_1.text_.text = var_527_8
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431127", "story_v_out_120431.awb") ~= 0 then
					local var_527_12 = manager.audio:GetVoiceLength("story_v_out_120431", "120431127", "story_v_out_120431.awb") / 1000

					if var_527_12 + var_527_4 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_12 + var_527_4
					end

					if var_527_7.prefab_name ~= "" and arg_524_1.actors_[var_527_7.prefab_name] ~= nil then
						local var_527_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_524_1.actors_[var_527_7.prefab_name].transform, "story_v_out_120431", "120431127", "story_v_out_120431.awb")

						arg_524_1:RecordAudio("120431127", var_527_13)
						arg_524_1:RecordAudio("120431127", var_527_13)
					else
						arg_524_1:AudioAction("play", "voice", "story_v_out_120431", "120431127", "story_v_out_120431.awb")
					end

					arg_524_1:RecordHistoryTalkVoice("story_v_out_120431", "120431127", "story_v_out_120431.awb")
				end

				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_14 = math.max(var_527_5, arg_524_1.talkMaxDuration)

			if var_527_4 <= arg_524_1.time_ and arg_524_1.time_ < var_527_4 + var_527_14 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_4) / var_527_14

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_4 + var_527_14 and arg_524_1.time_ < var_527_4 + var_527_14 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play120431128 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 120431128
		arg_528_1.duration_ = 12.8

		local var_528_0 = {
			zh = 12.8,
			ja = 12.766
		}
		local var_528_1 = manager.audio:GetLocalizationFlag()

		if var_528_0[var_528_1] ~= nil then
			arg_528_1.duration_ = var_528_0[var_528_1]
		end

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play120431129(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 0

			if var_531_0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_0 + arg_531_0 then
				arg_528_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_531_1 = 0
			local var_531_2 = 1.275

			if var_531_1 < arg_528_1.time_ and arg_528_1.time_ <= var_531_1 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				local var_531_3 = arg_528_1:FormatText(StoryNameCfg[319].name)

				arg_528_1.leftNameTxt_.text = var_531_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_4 = arg_528_1:GetWordFromCfg(120431128)
				local var_531_5 = arg_528_1:FormatText(var_531_4.content)

				arg_528_1.text_.text = var_531_5

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_6 = 51
				local var_531_7 = utf8.len(var_531_5)
				local var_531_8 = var_531_6 <= 0 and var_531_2 or var_531_2 * (var_531_7 / var_531_6)

				if var_531_8 > 0 and var_531_2 < var_531_8 then
					arg_528_1.talkMaxDuration = var_531_8

					if var_531_8 + var_531_1 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_8 + var_531_1
					end
				end

				arg_528_1.text_.text = var_531_5
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431128", "story_v_out_120431.awb") ~= 0 then
					local var_531_9 = manager.audio:GetVoiceLength("story_v_out_120431", "120431128", "story_v_out_120431.awb") / 1000

					if var_531_9 + var_531_1 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_9 + var_531_1
					end

					if var_531_4.prefab_name ~= "" and arg_528_1.actors_[var_531_4.prefab_name] ~= nil then
						local var_531_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_4.prefab_name].transform, "story_v_out_120431", "120431128", "story_v_out_120431.awb")

						arg_528_1:RecordAudio("120431128", var_531_10)
						arg_528_1:RecordAudio("120431128", var_531_10)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_out_120431", "120431128", "story_v_out_120431.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_out_120431", "120431128", "story_v_out_120431.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_11 = math.max(var_531_2, arg_528_1.talkMaxDuration)

			if var_531_1 <= arg_528_1.time_ and arg_528_1.time_ < var_531_1 + var_531_11 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_1) / var_531_11

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_1 + var_531_11 and arg_528_1.time_ < var_531_1 + var_531_11 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play120431129 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 120431129
		arg_532_1.duration_ = 1.33

		local var_532_0 = {
			zh = 1.333,
			ja = 1.166
		}
		local var_532_1 = manager.audio:GetLocalizationFlag()

		if var_532_0[var_532_1] ~= nil then
			arg_532_1.duration_ = var_532_0[var_532_1]
		end

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play120431130(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0
			local var_535_1 = 0.1

			if var_535_0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				local var_535_2 = arg_532_1:FormatText(StoryNameCfg[319].name)

				arg_532_1.leftNameTxt_.text = var_535_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_3 = arg_532_1:GetWordFromCfg(120431129)
				local var_535_4 = arg_532_1:FormatText(var_535_3.content)

				arg_532_1.text_.text = var_535_4

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_5 = 4
				local var_535_6 = utf8.len(var_535_4)
				local var_535_7 = var_535_5 <= 0 and var_535_1 or var_535_1 * (var_535_6 / var_535_5)

				if var_535_7 > 0 and var_535_1 < var_535_7 then
					arg_532_1.talkMaxDuration = var_535_7

					if var_535_7 + var_535_0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_7 + var_535_0
					end
				end

				arg_532_1.text_.text = var_535_4
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431129", "story_v_out_120431.awb") ~= 0 then
					local var_535_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431129", "story_v_out_120431.awb") / 1000

					if var_535_8 + var_535_0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_8 + var_535_0
					end

					if var_535_3.prefab_name ~= "" and arg_532_1.actors_[var_535_3.prefab_name] ~= nil then
						local var_535_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_532_1.actors_[var_535_3.prefab_name].transform, "story_v_out_120431", "120431129", "story_v_out_120431.awb")

						arg_532_1:RecordAudio("120431129", var_535_9)
						arg_532_1:RecordAudio("120431129", var_535_9)
					else
						arg_532_1:AudioAction("play", "voice", "story_v_out_120431", "120431129", "story_v_out_120431.awb")
					end

					arg_532_1:RecordHistoryTalkVoice("story_v_out_120431", "120431129", "story_v_out_120431.awb")
				end

				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_10 = math.max(var_535_1, arg_532_1.talkMaxDuration)

			if var_535_0 <= arg_532_1.time_ and arg_532_1.time_ < var_535_0 + var_535_10 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_0) / var_535_10

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_0 + var_535_10 and arg_532_1.time_ < var_535_0 + var_535_10 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play120431130 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 120431130
		arg_536_1.duration_ = 5

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play120431131(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = arg_536_1.actors_["1029ui_story"]
			local var_539_1 = 0

			if var_539_1 < arg_536_1.time_ and arg_536_1.time_ <= var_539_1 + arg_539_0 and not isNil(var_539_0) and arg_536_1.var_.characterEffect1029ui_story == nil then
				arg_536_1.var_.characterEffect1029ui_story = var_539_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_539_2 = 0.2

			if var_539_1 <= arg_536_1.time_ and arg_536_1.time_ < var_539_1 + var_539_2 and not isNil(var_539_0) then
				local var_539_3 = (arg_536_1.time_ - var_539_1) / var_539_2

				if arg_536_1.var_.characterEffect1029ui_story and not isNil(var_539_0) then
					local var_539_4 = Mathf.Lerp(0, 0.5, var_539_3)

					arg_536_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_536_1.var_.characterEffect1029ui_story.fillRatio = var_539_4
				end
			end

			if arg_536_1.time_ >= var_539_1 + var_539_2 and arg_536_1.time_ < var_539_1 + var_539_2 + arg_539_0 and not isNil(var_539_0) and arg_536_1.var_.characterEffect1029ui_story then
				local var_539_5 = 0.5

				arg_536_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_536_1.var_.characterEffect1029ui_story.fillRatio = var_539_5
			end

			local var_539_6 = 0
			local var_539_7 = 0.75

			if var_539_6 < arg_536_1.time_ and arg_536_1.time_ <= var_539_6 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, false)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_8 = arg_536_1:GetWordFromCfg(120431130)
				local var_539_9 = arg_536_1:FormatText(var_539_8.content)

				arg_536_1.text_.text = var_539_9

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_10 = 30
				local var_539_11 = utf8.len(var_539_9)
				local var_539_12 = var_539_10 <= 0 and var_539_7 or var_539_7 * (var_539_11 / var_539_10)

				if var_539_12 > 0 and var_539_7 < var_539_12 then
					arg_536_1.talkMaxDuration = var_539_12

					if var_539_12 + var_539_6 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_12 + var_539_6
					end
				end

				arg_536_1.text_.text = var_539_9
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)
				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_13 = math.max(var_539_7, arg_536_1.talkMaxDuration)

			if var_539_6 <= arg_536_1.time_ and arg_536_1.time_ < var_539_6 + var_539_13 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_6) / var_539_13

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_6 + var_539_13 and arg_536_1.time_ < var_539_6 + var_539_13 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play120431131 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 120431131
		arg_540_1.duration_ = 3.2

		local var_540_0 = {
			zh = 1.933,
			ja = 3.2
		}
		local var_540_1 = manager.audio:GetLocalizationFlag()

		if var_540_0[var_540_1] ~= nil then
			arg_540_1.duration_ = var_540_0[var_540_1]
		end

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play120431132(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = arg_540_1.actors_["1029ui_story"]
			local var_543_1 = 0

			if var_543_1 < arg_540_1.time_ and arg_540_1.time_ <= var_543_1 + arg_543_0 and not isNil(var_543_0) and arg_540_1.var_.characterEffect1029ui_story == nil then
				arg_540_1.var_.characterEffect1029ui_story = var_543_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_543_2 = 0.2

			if var_543_1 <= arg_540_1.time_ and arg_540_1.time_ < var_543_1 + var_543_2 and not isNil(var_543_0) then
				local var_543_3 = (arg_540_1.time_ - var_543_1) / var_543_2

				if arg_540_1.var_.characterEffect1029ui_story and not isNil(var_543_0) then
					arg_540_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_540_1.time_ >= var_543_1 + var_543_2 and arg_540_1.time_ < var_543_1 + var_543_2 + arg_543_0 and not isNil(var_543_0) and arg_540_1.var_.characterEffect1029ui_story then
				arg_540_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_543_4 = 0
			local var_543_5 = 0.225

			if var_543_4 < arg_540_1.time_ and arg_540_1.time_ <= var_543_4 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				local var_543_6 = arg_540_1:FormatText(StoryNameCfg[319].name)

				arg_540_1.leftNameTxt_.text = var_543_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_7 = arg_540_1:GetWordFromCfg(120431131)
				local var_543_8 = arg_540_1:FormatText(var_543_7.content)

				arg_540_1.text_.text = var_543_8

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_9 = 9
				local var_543_10 = utf8.len(var_543_8)
				local var_543_11 = var_543_9 <= 0 and var_543_5 or var_543_5 * (var_543_10 / var_543_9)

				if var_543_11 > 0 and var_543_5 < var_543_11 then
					arg_540_1.talkMaxDuration = var_543_11

					if var_543_11 + var_543_4 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_11 + var_543_4
					end
				end

				arg_540_1.text_.text = var_543_8
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431131", "story_v_out_120431.awb") ~= 0 then
					local var_543_12 = manager.audio:GetVoiceLength("story_v_out_120431", "120431131", "story_v_out_120431.awb") / 1000

					if var_543_12 + var_543_4 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_12 + var_543_4
					end

					if var_543_7.prefab_name ~= "" and arg_540_1.actors_[var_543_7.prefab_name] ~= nil then
						local var_543_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_540_1.actors_[var_543_7.prefab_name].transform, "story_v_out_120431", "120431131", "story_v_out_120431.awb")

						arg_540_1:RecordAudio("120431131", var_543_13)
						arg_540_1:RecordAudio("120431131", var_543_13)
					else
						arg_540_1:AudioAction("play", "voice", "story_v_out_120431", "120431131", "story_v_out_120431.awb")
					end

					arg_540_1:RecordHistoryTalkVoice("story_v_out_120431", "120431131", "story_v_out_120431.awb")
				end

				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_14 = math.max(var_543_5, arg_540_1.talkMaxDuration)

			if var_543_4 <= arg_540_1.time_ and arg_540_1.time_ < var_543_4 + var_543_14 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_4) / var_543_14

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_4 + var_543_14 and arg_540_1.time_ < var_543_4 + var_543_14 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play120431132 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 120431132
		arg_544_1.duration_ = 9

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play120431133(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = 0

			if var_547_0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_0 + arg_547_0 then
				arg_544_1.mask_.enabled = true
				arg_544_1.mask_.raycastTarget = true

				arg_544_1:SetGaussion(false)
			end

			local var_547_1 = 2

			if var_547_0 <= arg_544_1.time_ and arg_544_1.time_ < var_547_0 + var_547_1 then
				local var_547_2 = (arg_544_1.time_ - var_547_0) / var_547_1
				local var_547_3 = Color.New(0, 0, 0)

				var_547_3.a = Mathf.Lerp(0, 1, var_547_2)
				arg_544_1.mask_.color = var_547_3
			end

			if arg_544_1.time_ >= var_547_0 + var_547_1 and arg_544_1.time_ < var_547_0 + var_547_1 + arg_547_0 then
				local var_547_4 = Color.New(0, 0, 0)

				var_547_4.a = 1
				arg_544_1.mask_.color = var_547_4
			end

			local var_547_5 = 2

			if var_547_5 < arg_544_1.time_ and arg_544_1.time_ <= var_547_5 + arg_547_0 then
				arg_544_1.mask_.enabled = true
				arg_544_1.mask_.raycastTarget = true

				arg_544_1:SetGaussion(false)
			end

			local var_547_6 = 2

			if var_547_5 <= arg_544_1.time_ and arg_544_1.time_ < var_547_5 + var_547_6 then
				local var_547_7 = (arg_544_1.time_ - var_547_5) / var_547_6
				local var_547_8 = Color.New(0, 0, 0)

				var_547_8.a = Mathf.Lerp(1, 0, var_547_7)
				arg_544_1.mask_.color = var_547_8
			end

			if arg_544_1.time_ >= var_547_5 + var_547_6 and arg_544_1.time_ < var_547_5 + var_547_6 + arg_547_0 then
				local var_547_9 = Color.New(0, 0, 0)
				local var_547_10 = 0

				arg_544_1.mask_.enabled = false
				var_547_9.a = var_547_10
				arg_544_1.mask_.color = var_547_9
			end

			local var_547_11 = arg_544_1.actors_["1029ui_story"].transform
			local var_547_12 = 1.966

			if var_547_12 < arg_544_1.time_ and arg_544_1.time_ <= var_547_12 + arg_547_0 then
				arg_544_1.var_.moveOldPos1029ui_story = var_547_11.localPosition
			end

			local var_547_13 = 0.001

			if var_547_12 <= arg_544_1.time_ and arg_544_1.time_ < var_547_12 + var_547_13 then
				local var_547_14 = (arg_544_1.time_ - var_547_12) / var_547_13
				local var_547_15 = Vector3.New(0, 100, 0)

				var_547_11.localPosition = Vector3.Lerp(arg_544_1.var_.moveOldPos1029ui_story, var_547_15, var_547_14)

				local var_547_16 = manager.ui.mainCamera.transform.position - var_547_11.position

				var_547_11.forward = Vector3.New(var_547_16.x, var_547_16.y, var_547_16.z)

				local var_547_17 = var_547_11.localEulerAngles

				var_547_17.z = 0
				var_547_17.x = 0
				var_547_11.localEulerAngles = var_547_17
			end

			if arg_544_1.time_ >= var_547_12 + var_547_13 and arg_544_1.time_ < var_547_12 + var_547_13 + arg_547_0 then
				var_547_11.localPosition = Vector3.New(0, 100, 0)

				local var_547_18 = manager.ui.mainCamera.transform.position - var_547_11.position

				var_547_11.forward = Vector3.New(var_547_18.x, var_547_18.y, var_547_18.z)

				local var_547_19 = var_547_11.localEulerAngles

				var_547_19.z = 0
				var_547_19.x = 0
				var_547_11.localEulerAngles = var_547_19
			end

			if arg_544_1.frameCnt_ <= 1 then
				arg_544_1.dialog_:SetActive(false)
			end

			local var_547_20 = 4
			local var_547_21 = 1.1

			if var_547_20 < arg_544_1.time_ and arg_544_1.time_ <= var_547_20 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0

				arg_544_1.dialog_:SetActive(true)

				arg_544_1.dialogCg_.alpha = 0

				local var_547_22 = LeanTween.value(arg_544_1.dialog_, 0, 1, 0.3)

				var_547_22:setOnUpdate(LuaHelper.FloatAction(function(arg_548_0)
					arg_544_1.dialogCg_.alpha = arg_548_0
				end))
				var_547_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_544_1.dialog_)
					var_547_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_544_1.duration_ = arg_544_1.duration_ + 0.3

				SetActive(arg_544_1.leftNameGo_, false)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_23 = arg_544_1:GetWordFromCfg(120431132)
				local var_547_24 = arg_544_1:FormatText(var_547_23.content)

				arg_544_1.text_.text = var_547_24

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_25 = 44
				local var_547_26 = utf8.len(var_547_24)
				local var_547_27 = var_547_25 <= 0 and var_547_21 or var_547_21 * (var_547_26 / var_547_25)

				if var_547_27 > 0 and var_547_21 < var_547_27 then
					arg_544_1.talkMaxDuration = var_547_27
					var_547_20 = var_547_20 + 0.3

					if var_547_27 + var_547_20 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_27 + var_547_20
					end
				end

				arg_544_1.text_.text = var_547_24
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)
				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_28 = var_547_20 + 0.3
			local var_547_29 = math.max(var_547_21, arg_544_1.talkMaxDuration)

			if var_547_28 <= arg_544_1.time_ and arg_544_1.time_ < var_547_28 + var_547_29 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_28) / var_547_29

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_28 + var_547_29 and arg_544_1.time_ < var_547_28 + var_547_29 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_544_1:InitPlayNodeList()
	end,
	Play120431133 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 120431133
		arg_550_1.duration_ = 11.7

		local var_550_0 = {
			zh = 7.666,
			ja = 11.7
		}
		local var_550_1 = manager.audio:GetLocalizationFlag()

		if var_550_0[var_550_1] ~= nil then
			arg_550_1.duration_ = var_550_0[var_550_1]
		end

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play120431134(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = arg_550_1.actors_["1084ui_story"].transform
			local var_553_1 = 0

			if var_553_1 < arg_550_1.time_ and arg_550_1.time_ <= var_553_1 + arg_553_0 then
				arg_550_1.var_.moveOldPos1084ui_story = var_553_0.localPosition
			end

			local var_553_2 = 0.001

			if var_553_1 <= arg_550_1.time_ and arg_550_1.time_ < var_553_1 + var_553_2 then
				local var_553_3 = (arg_550_1.time_ - var_553_1) / var_553_2
				local var_553_4 = Vector3.New(0, -0.97, -6)

				var_553_0.localPosition = Vector3.Lerp(arg_550_1.var_.moveOldPos1084ui_story, var_553_4, var_553_3)

				local var_553_5 = manager.ui.mainCamera.transform.position - var_553_0.position

				var_553_0.forward = Vector3.New(var_553_5.x, var_553_5.y, var_553_5.z)

				local var_553_6 = var_553_0.localEulerAngles

				var_553_6.z = 0
				var_553_6.x = 0
				var_553_0.localEulerAngles = var_553_6
			end

			if arg_550_1.time_ >= var_553_1 + var_553_2 and arg_550_1.time_ < var_553_1 + var_553_2 + arg_553_0 then
				var_553_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_553_7 = manager.ui.mainCamera.transform.position - var_553_0.position

				var_553_0.forward = Vector3.New(var_553_7.x, var_553_7.y, var_553_7.z)

				local var_553_8 = var_553_0.localEulerAngles

				var_553_8.z = 0
				var_553_8.x = 0
				var_553_0.localEulerAngles = var_553_8
			end

			local var_553_9 = 0

			if var_553_9 < arg_550_1.time_ and arg_550_1.time_ <= var_553_9 + arg_553_0 then
				arg_550_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_553_10 = 0

			if var_553_10 < arg_550_1.time_ and arg_550_1.time_ <= var_553_10 + arg_553_0 then
				arg_550_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_553_11 = arg_550_1.actors_["1084ui_story"]
			local var_553_12 = 0

			if var_553_12 < arg_550_1.time_ and arg_550_1.time_ <= var_553_12 + arg_553_0 and not isNil(var_553_11) and arg_550_1.var_.characterEffect1084ui_story == nil then
				arg_550_1.var_.characterEffect1084ui_story = var_553_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_553_13 = 0.2

			if var_553_12 <= arg_550_1.time_ and arg_550_1.time_ < var_553_12 + var_553_13 and not isNil(var_553_11) then
				local var_553_14 = (arg_550_1.time_ - var_553_12) / var_553_13

				if arg_550_1.var_.characterEffect1084ui_story and not isNil(var_553_11) then
					arg_550_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_550_1.time_ >= var_553_12 + var_553_13 and arg_550_1.time_ < var_553_12 + var_553_13 + arg_553_0 and not isNil(var_553_11) and arg_550_1.var_.characterEffect1084ui_story then
				arg_550_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_553_15 = 0
			local var_553_16 = 0.95

			if var_553_15 < arg_550_1.time_ and arg_550_1.time_ <= var_553_15 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, true)

				local var_553_17 = arg_550_1:FormatText(StoryNameCfg[6].name)

				arg_550_1.leftNameTxt_.text = var_553_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_550_1.leftNameTxt_.transform)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1.leftNameTxt_.text)
				SetActive(arg_550_1.iconTrs_.gameObject, false)
				arg_550_1.callingController_:SetSelectedState("normal")

				local var_553_18 = arg_550_1:GetWordFromCfg(120431133)
				local var_553_19 = arg_550_1:FormatText(var_553_18.content)

				arg_550_1.text_.text = var_553_19

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_20 = 38
				local var_553_21 = utf8.len(var_553_19)
				local var_553_22 = var_553_20 <= 0 and var_553_16 or var_553_16 * (var_553_21 / var_553_20)

				if var_553_22 > 0 and var_553_16 < var_553_22 then
					arg_550_1.talkMaxDuration = var_553_22

					if var_553_22 + var_553_15 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_22 + var_553_15
					end
				end

				arg_550_1.text_.text = var_553_19
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431133", "story_v_out_120431.awb") ~= 0 then
					local var_553_23 = manager.audio:GetVoiceLength("story_v_out_120431", "120431133", "story_v_out_120431.awb") / 1000

					if var_553_23 + var_553_15 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_23 + var_553_15
					end

					if var_553_18.prefab_name ~= "" and arg_550_1.actors_[var_553_18.prefab_name] ~= nil then
						local var_553_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_550_1.actors_[var_553_18.prefab_name].transform, "story_v_out_120431", "120431133", "story_v_out_120431.awb")

						arg_550_1:RecordAudio("120431133", var_553_24)
						arg_550_1:RecordAudio("120431133", var_553_24)
					else
						arg_550_1:AudioAction("play", "voice", "story_v_out_120431", "120431133", "story_v_out_120431.awb")
					end

					arg_550_1:RecordHistoryTalkVoice("story_v_out_120431", "120431133", "story_v_out_120431.awb")
				end

				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_25 = math.max(var_553_16, arg_550_1.talkMaxDuration)

			if var_553_15 <= arg_550_1.time_ and arg_550_1.time_ < var_553_15 + var_553_25 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - var_553_15) / var_553_25

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= var_553_15 + var_553_25 and arg_550_1.time_ < var_553_15 + var_553_25 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {
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

		arg_550_1:InitPlayNodeList()
	end,
	Play120431134 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 120431134
		arg_554_1.duration_ = 9.8

		local var_554_0 = {
			zh = 7.233,
			ja = 9.8
		}
		local var_554_1 = manager.audio:GetLocalizationFlag()

		if var_554_0[var_554_1] ~= nil then
			arg_554_1.duration_ = var_554_0[var_554_1]
		end

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play120431135(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = 0

			if var_557_0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_0 + arg_557_0 then
				arg_554_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action437")
			end

			local var_557_1 = 0

			if var_557_1 < arg_554_1.time_ and arg_554_1.time_ <= var_557_1 + arg_557_0 then
				arg_554_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_557_2 = 0
			local var_557_3 = 0.625

			if var_557_2 < arg_554_1.time_ and arg_554_1.time_ <= var_557_2 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				local var_557_4 = arg_554_1:FormatText(StoryNameCfg[6].name)

				arg_554_1.leftNameTxt_.text = var_557_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_5 = arg_554_1:GetWordFromCfg(120431134)
				local var_557_6 = arg_554_1:FormatText(var_557_5.content)

				arg_554_1.text_.text = var_557_6

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_7 = 24
				local var_557_8 = utf8.len(var_557_6)
				local var_557_9 = var_557_7 <= 0 and var_557_3 or var_557_3 * (var_557_8 / var_557_7)

				if var_557_9 > 0 and var_557_3 < var_557_9 then
					arg_554_1.talkMaxDuration = var_557_9

					if var_557_9 + var_557_2 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_9 + var_557_2
					end
				end

				arg_554_1.text_.text = var_557_6
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431134", "story_v_out_120431.awb") ~= 0 then
					local var_557_10 = manager.audio:GetVoiceLength("story_v_out_120431", "120431134", "story_v_out_120431.awb") / 1000

					if var_557_10 + var_557_2 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_10 + var_557_2
					end

					if var_557_5.prefab_name ~= "" and arg_554_1.actors_[var_557_5.prefab_name] ~= nil then
						local var_557_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_5.prefab_name].transform, "story_v_out_120431", "120431134", "story_v_out_120431.awb")

						arg_554_1:RecordAudio("120431134", var_557_11)
						arg_554_1:RecordAudio("120431134", var_557_11)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_out_120431", "120431134", "story_v_out_120431.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_out_120431", "120431134", "story_v_out_120431.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_12 = math.max(var_557_3, arg_554_1.talkMaxDuration)

			if var_557_2 <= arg_554_1.time_ and arg_554_1.time_ < var_557_2 + var_557_12 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_2) / var_557_12

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_2 + var_557_12 and arg_554_1.time_ < var_557_2 + var_557_12 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play120431135 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 120431135
		arg_558_1.duration_ = 3

		local var_558_0 = {
			zh = 1.433,
			ja = 3
		}
		local var_558_1 = manager.audio:GetLocalizationFlag()

		if var_558_0[var_558_1] ~= nil then
			arg_558_1.duration_ = var_558_0[var_558_1]
		end

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play120431136(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = arg_558_1.actors_["1084ui_story"]
			local var_561_1 = 0

			if var_561_1 < arg_558_1.time_ and arg_558_1.time_ <= var_561_1 + arg_561_0 and not isNil(var_561_0) and arg_558_1.var_.characterEffect1084ui_story == nil then
				arg_558_1.var_.characterEffect1084ui_story = var_561_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_561_2 = 0.2

			if var_561_1 <= arg_558_1.time_ and arg_558_1.time_ < var_561_1 + var_561_2 and not isNil(var_561_0) then
				local var_561_3 = (arg_558_1.time_ - var_561_1) / var_561_2

				if arg_558_1.var_.characterEffect1084ui_story and not isNil(var_561_0) then
					local var_561_4 = Mathf.Lerp(0, 0.5, var_561_3)

					arg_558_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_558_1.var_.characterEffect1084ui_story.fillRatio = var_561_4
				end
			end

			if arg_558_1.time_ >= var_561_1 + var_561_2 and arg_558_1.time_ < var_561_1 + var_561_2 + arg_561_0 and not isNil(var_561_0) and arg_558_1.var_.characterEffect1084ui_story then
				local var_561_5 = 0.5

				arg_558_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_558_1.var_.characterEffect1084ui_story.fillRatio = var_561_5
			end

			local var_561_6 = 0
			local var_561_7 = 0.125

			if var_561_6 < arg_558_1.time_ and arg_558_1.time_ <= var_561_6 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				local var_561_8 = arg_558_1:FormatText(StoryNameCfg[389].name)

				arg_558_1.leftNameTxt_.text = var_561_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, true)
				arg_558_1.iconController_:SetSelectedState("hero")

				arg_558_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1076")

				arg_558_1.callingController_:SetSelectedState("normal")

				arg_558_1.keyicon_.color = Color.New(1, 1, 1)
				arg_558_1.icon_.color = Color.New(1, 1, 1)

				local var_561_9 = arg_558_1:GetWordFromCfg(120431135)
				local var_561_10 = arg_558_1:FormatText(var_561_9.content)

				arg_558_1.text_.text = var_561_10

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_11 = 5
				local var_561_12 = utf8.len(var_561_10)
				local var_561_13 = var_561_11 <= 0 and var_561_7 or var_561_7 * (var_561_12 / var_561_11)

				if var_561_13 > 0 and var_561_7 < var_561_13 then
					arg_558_1.talkMaxDuration = var_561_13

					if var_561_13 + var_561_6 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_13 + var_561_6
					end
				end

				arg_558_1.text_.text = var_561_10
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431135", "story_v_out_120431.awb") ~= 0 then
					local var_561_14 = manager.audio:GetVoiceLength("story_v_out_120431", "120431135", "story_v_out_120431.awb") / 1000

					if var_561_14 + var_561_6 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_14 + var_561_6
					end

					if var_561_9.prefab_name ~= "" and arg_558_1.actors_[var_561_9.prefab_name] ~= nil then
						local var_561_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_558_1.actors_[var_561_9.prefab_name].transform, "story_v_out_120431", "120431135", "story_v_out_120431.awb")

						arg_558_1:RecordAudio("120431135", var_561_15)
						arg_558_1:RecordAudio("120431135", var_561_15)
					else
						arg_558_1:AudioAction("play", "voice", "story_v_out_120431", "120431135", "story_v_out_120431.awb")
					end

					arg_558_1:RecordHistoryTalkVoice("story_v_out_120431", "120431135", "story_v_out_120431.awb")
				end

				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_16 = math.max(var_561_7, arg_558_1.talkMaxDuration)

			if var_561_6 <= arg_558_1.time_ and arg_558_1.time_ < var_561_6 + var_561_16 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_6) / var_561_16

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_6 + var_561_16 and arg_558_1.time_ < var_561_6 + var_561_16 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play120431136 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 120431136
		arg_562_1.duration_ = 5

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play120431137(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = arg_562_1.actors_["1084ui_story"].transform
			local var_565_1 = 0

			if var_565_1 < arg_562_1.time_ and arg_562_1.time_ <= var_565_1 + arg_565_0 then
				arg_562_1.var_.moveOldPos1084ui_story = var_565_0.localPosition
			end

			local var_565_2 = 0.001

			if var_565_1 <= arg_562_1.time_ and arg_562_1.time_ < var_565_1 + var_565_2 then
				local var_565_3 = (arg_562_1.time_ - var_565_1) / var_565_2
				local var_565_4 = Vector3.New(0, 100, 0)

				var_565_0.localPosition = Vector3.Lerp(arg_562_1.var_.moveOldPos1084ui_story, var_565_4, var_565_3)

				local var_565_5 = manager.ui.mainCamera.transform.position - var_565_0.position

				var_565_0.forward = Vector3.New(var_565_5.x, var_565_5.y, var_565_5.z)

				local var_565_6 = var_565_0.localEulerAngles

				var_565_6.z = 0
				var_565_6.x = 0
				var_565_0.localEulerAngles = var_565_6
			end

			if arg_562_1.time_ >= var_565_1 + var_565_2 and arg_562_1.time_ < var_565_1 + var_565_2 + arg_565_0 then
				var_565_0.localPosition = Vector3.New(0, 100, 0)

				local var_565_7 = manager.ui.mainCamera.transform.position - var_565_0.position

				var_565_0.forward = Vector3.New(var_565_7.x, var_565_7.y, var_565_7.z)

				local var_565_8 = var_565_0.localEulerAngles

				var_565_8.z = 0
				var_565_8.x = 0
				var_565_0.localEulerAngles = var_565_8
			end

			local var_565_9 = 0
			local var_565_10 = 1.55

			if var_565_9 < arg_562_1.time_ and arg_562_1.time_ <= var_565_9 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, false)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_11 = arg_562_1:GetWordFromCfg(120431136)
				local var_565_12 = arg_562_1:FormatText(var_565_11.content)

				arg_562_1.text_.text = var_565_12

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_13 = 62
				local var_565_14 = utf8.len(var_565_12)
				local var_565_15 = var_565_13 <= 0 and var_565_10 or var_565_10 * (var_565_14 / var_565_13)

				if var_565_15 > 0 and var_565_10 < var_565_15 then
					arg_562_1.talkMaxDuration = var_565_15

					if var_565_15 + var_565_9 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_15 + var_565_9
					end
				end

				arg_562_1.text_.text = var_565_12
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)
				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_16 = math.max(var_565_10, arg_562_1.talkMaxDuration)

			if var_565_9 <= arg_562_1.time_ and arg_562_1.time_ < var_565_9 + var_565_16 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_9) / var_565_16

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_9 + var_565_16 and arg_562_1.time_ < var_565_9 + var_565_16 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {
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

		arg_562_1:InitPlayNodeList()
	end,
	Play120431137 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 120431137
		arg_566_1.duration_ = 10.87

		local var_566_0 = {
			zh = 6.6,
			ja = 10.866
		}
		local var_566_1 = manager.audio:GetLocalizationFlag()

		if var_566_0[var_566_1] ~= nil then
			arg_566_1.duration_ = var_566_0[var_566_1]
		end

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play120431138(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			local var_569_0 = 0

			if var_569_0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_0 + arg_569_0 then
				arg_566_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_569_1 = arg_566_1.actors_["1084ui_story"]
			local var_569_2 = 0

			if var_569_2 < arg_566_1.time_ and arg_566_1.time_ <= var_569_2 + arg_569_0 and not isNil(var_569_1) and arg_566_1.var_.characterEffect1084ui_story == nil then
				arg_566_1.var_.characterEffect1084ui_story = var_569_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_569_3 = 0.2

			if var_569_2 <= arg_566_1.time_ and arg_566_1.time_ < var_569_2 + var_569_3 and not isNil(var_569_1) then
				local var_569_4 = (arg_566_1.time_ - var_569_2) / var_569_3

				if arg_566_1.var_.characterEffect1084ui_story and not isNil(var_569_1) then
					arg_566_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_566_1.time_ >= var_569_2 + var_569_3 and arg_566_1.time_ < var_569_2 + var_569_3 + arg_569_0 and not isNil(var_569_1) and arg_566_1.var_.characterEffect1084ui_story then
				arg_566_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_569_5 = arg_566_1.actors_["1084ui_story"].transform
			local var_569_6 = 0

			if var_569_6 < arg_566_1.time_ and arg_566_1.time_ <= var_569_6 + arg_569_0 then
				arg_566_1.var_.moveOldPos1084ui_story = var_569_5.localPosition
			end

			local var_569_7 = 0.001

			if var_569_6 <= arg_566_1.time_ and arg_566_1.time_ < var_569_6 + var_569_7 then
				local var_569_8 = (arg_566_1.time_ - var_569_6) / var_569_7
				local var_569_9 = Vector3.New(-0.7, -0.97, -6)

				var_569_5.localPosition = Vector3.Lerp(arg_566_1.var_.moveOldPos1084ui_story, var_569_9, var_569_8)

				local var_569_10 = manager.ui.mainCamera.transform.position - var_569_5.position

				var_569_5.forward = Vector3.New(var_569_10.x, var_569_10.y, var_569_10.z)

				local var_569_11 = var_569_5.localEulerAngles

				var_569_11.z = 0
				var_569_11.x = 0
				var_569_5.localEulerAngles = var_569_11
			end

			if arg_566_1.time_ >= var_569_6 + var_569_7 and arg_566_1.time_ < var_569_6 + var_569_7 + arg_569_0 then
				var_569_5.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_569_12 = manager.ui.mainCamera.transform.position - var_569_5.position

				var_569_5.forward = Vector3.New(var_569_12.x, var_569_12.y, var_569_12.z)

				local var_569_13 = var_569_5.localEulerAngles

				var_569_13.z = 0
				var_569_13.x = 0
				var_569_5.localEulerAngles = var_569_13
			end

			local var_569_14 = 0

			if var_569_14 < arg_566_1.time_ and arg_566_1.time_ <= var_569_14 + arg_569_0 then
				arg_566_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_569_15 = 0
			local var_569_16 = 0.525

			if var_569_15 < arg_566_1.time_ and arg_566_1.time_ <= var_569_15 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				local var_569_17 = arg_566_1:FormatText(StoryNameCfg[6].name)

				arg_566_1.leftNameTxt_.text = var_569_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_18 = arg_566_1:GetWordFromCfg(120431137)
				local var_569_19 = arg_566_1:FormatText(var_569_18.content)

				arg_566_1.text_.text = var_569_19

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_20 = 21
				local var_569_21 = utf8.len(var_569_19)
				local var_569_22 = var_569_20 <= 0 and var_569_16 or var_569_16 * (var_569_21 / var_569_20)

				if var_569_22 > 0 and var_569_16 < var_569_22 then
					arg_566_1.talkMaxDuration = var_569_22

					if var_569_22 + var_569_15 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_22 + var_569_15
					end
				end

				arg_566_1.text_.text = var_569_19
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431137", "story_v_out_120431.awb") ~= 0 then
					local var_569_23 = manager.audio:GetVoiceLength("story_v_out_120431", "120431137", "story_v_out_120431.awb") / 1000

					if var_569_23 + var_569_15 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_23 + var_569_15
					end

					if var_569_18.prefab_name ~= "" and arg_566_1.actors_[var_569_18.prefab_name] ~= nil then
						local var_569_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_18.prefab_name].transform, "story_v_out_120431", "120431137", "story_v_out_120431.awb")

						arg_566_1:RecordAudio("120431137", var_569_24)
						arg_566_1:RecordAudio("120431137", var_569_24)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_out_120431", "120431137", "story_v_out_120431.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_out_120431", "120431137", "story_v_out_120431.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_25 = math.max(var_569_16, arg_566_1.talkMaxDuration)

			if var_569_15 <= arg_566_1.time_ and arg_566_1.time_ < var_569_15 + var_569_25 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_15) / var_569_25

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_15 + var_569_25 and arg_566_1.time_ < var_569_15 + var_569_25 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {
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

		arg_566_1:InitPlayNodeList()
	end,
	Play120431138 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 120431138
		arg_570_1.duration_ = 5.63

		local var_570_0 = {
			zh = 1.999999999999,
			ja = 5.633
		}
		local var_570_1 = manager.audio:GetLocalizationFlag()

		if var_570_0[var_570_1] ~= nil then
			arg_570_1.duration_ = var_570_0[var_570_1]
		end

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play120431139(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			local var_573_0 = arg_570_1.actors_["1084ui_story"]
			local var_573_1 = 0

			if var_573_1 < arg_570_1.time_ and arg_570_1.time_ <= var_573_1 + arg_573_0 and not isNil(var_573_0) and arg_570_1.var_.characterEffect1084ui_story == nil then
				arg_570_1.var_.characterEffect1084ui_story = var_573_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_573_2 = 0.2

			if var_573_1 <= arg_570_1.time_ and arg_570_1.time_ < var_573_1 + var_573_2 and not isNil(var_573_0) then
				local var_573_3 = (arg_570_1.time_ - var_573_1) / var_573_2

				if arg_570_1.var_.characterEffect1084ui_story and not isNil(var_573_0) then
					local var_573_4 = Mathf.Lerp(0, 0.5, var_573_3)

					arg_570_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_570_1.var_.characterEffect1084ui_story.fillRatio = var_573_4
				end
			end

			if arg_570_1.time_ >= var_573_1 + var_573_2 and arg_570_1.time_ < var_573_1 + var_573_2 + arg_573_0 and not isNil(var_573_0) and arg_570_1.var_.characterEffect1084ui_story then
				local var_573_5 = 0.5

				arg_570_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_570_1.var_.characterEffect1084ui_story.fillRatio = var_573_5
			end

			local var_573_6 = arg_570_1.actors_["1076ui_story"].transform
			local var_573_7 = 0

			if var_573_7 < arg_570_1.time_ and arg_570_1.time_ <= var_573_7 + arg_573_0 then
				arg_570_1.var_.moveOldPos1076ui_story = var_573_6.localPosition
			end

			local var_573_8 = 0.001

			if var_573_7 <= arg_570_1.time_ and arg_570_1.time_ < var_573_7 + var_573_8 then
				local var_573_9 = (arg_570_1.time_ - var_573_7) / var_573_8
				local var_573_10 = Vector3.New(0.7, -1.06, -6.2)

				var_573_6.localPosition = Vector3.Lerp(arg_570_1.var_.moveOldPos1076ui_story, var_573_10, var_573_9)

				local var_573_11 = manager.ui.mainCamera.transform.position - var_573_6.position

				var_573_6.forward = Vector3.New(var_573_11.x, var_573_11.y, var_573_11.z)

				local var_573_12 = var_573_6.localEulerAngles

				var_573_12.z = 0
				var_573_12.x = 0
				var_573_6.localEulerAngles = var_573_12
			end

			if arg_570_1.time_ >= var_573_7 + var_573_8 and arg_570_1.time_ < var_573_7 + var_573_8 + arg_573_0 then
				var_573_6.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_573_13 = manager.ui.mainCamera.transform.position - var_573_6.position

				var_573_6.forward = Vector3.New(var_573_13.x, var_573_13.y, var_573_13.z)

				local var_573_14 = var_573_6.localEulerAngles

				var_573_14.z = 0
				var_573_14.x = 0
				var_573_6.localEulerAngles = var_573_14
			end

			local var_573_15 = 0

			if var_573_15 < arg_570_1.time_ and arg_570_1.time_ <= var_573_15 + arg_573_0 then
				arg_570_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_573_16 = arg_570_1.actors_["1076ui_story"]
			local var_573_17 = 0

			if var_573_17 < arg_570_1.time_ and arg_570_1.time_ <= var_573_17 + arg_573_0 and not isNil(var_573_16) and arg_570_1.var_.characterEffect1076ui_story == nil then
				arg_570_1.var_.characterEffect1076ui_story = var_573_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_573_18 = 0.2

			if var_573_17 <= arg_570_1.time_ and arg_570_1.time_ < var_573_17 + var_573_18 and not isNil(var_573_16) then
				local var_573_19 = (arg_570_1.time_ - var_573_17) / var_573_18

				if arg_570_1.var_.characterEffect1076ui_story and not isNil(var_573_16) then
					arg_570_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_570_1.time_ >= var_573_17 + var_573_18 and arg_570_1.time_ < var_573_17 + var_573_18 + arg_573_0 and not isNil(var_573_16) and arg_570_1.var_.characterEffect1076ui_story then
				arg_570_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_573_20 = 0
			local var_573_21 = 0.15

			if var_573_20 < arg_570_1.time_ and arg_570_1.time_ <= var_573_20 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				local var_573_22 = arg_570_1:FormatText(StoryNameCfg[389].name)

				arg_570_1.leftNameTxt_.text = var_573_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_23 = arg_570_1:GetWordFromCfg(120431138)
				local var_573_24 = arg_570_1:FormatText(var_573_23.content)

				arg_570_1.text_.text = var_573_24

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_25 = 6
				local var_573_26 = utf8.len(var_573_24)
				local var_573_27 = var_573_25 <= 0 and var_573_21 or var_573_21 * (var_573_26 / var_573_25)

				if var_573_27 > 0 and var_573_21 < var_573_27 then
					arg_570_1.talkMaxDuration = var_573_27

					if var_573_27 + var_573_20 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_27 + var_573_20
					end
				end

				arg_570_1.text_.text = var_573_24
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431138", "story_v_out_120431.awb") ~= 0 then
					local var_573_28 = manager.audio:GetVoiceLength("story_v_out_120431", "120431138", "story_v_out_120431.awb") / 1000

					if var_573_28 + var_573_20 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_28 + var_573_20
					end

					if var_573_23.prefab_name ~= "" and arg_570_1.actors_[var_573_23.prefab_name] ~= nil then
						local var_573_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_570_1.actors_[var_573_23.prefab_name].transform, "story_v_out_120431", "120431138", "story_v_out_120431.awb")

						arg_570_1:RecordAudio("120431138", var_573_29)
						arg_570_1:RecordAudio("120431138", var_573_29)
					else
						arg_570_1:AudioAction("play", "voice", "story_v_out_120431", "120431138", "story_v_out_120431.awb")
					end

					arg_570_1:RecordHistoryTalkVoice("story_v_out_120431", "120431138", "story_v_out_120431.awb")
				end

				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_30 = math.max(var_573_21, arg_570_1.talkMaxDuration)

			if var_573_20 <= arg_570_1.time_ and arg_570_1.time_ < var_573_20 + var_573_30 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_20) / var_573_30

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_20 + var_573_30 and arg_570_1.time_ < var_573_20 + var_573_30 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_570_1:InitPlayNodeList()
	end,
	Play120431139 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 120431139
		arg_574_1.duration_ = 5

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play120431140(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			local var_577_0 = arg_574_1.actors_["1076ui_story"]
			local var_577_1 = 0

			if var_577_1 < arg_574_1.time_ and arg_574_1.time_ <= var_577_1 + arg_577_0 and not isNil(var_577_0) and arg_574_1.var_.characterEffect1076ui_story == nil then
				arg_574_1.var_.characterEffect1076ui_story = var_577_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_577_2 = 0.2

			if var_577_1 <= arg_574_1.time_ and arg_574_1.time_ < var_577_1 + var_577_2 and not isNil(var_577_0) then
				local var_577_3 = (arg_574_1.time_ - var_577_1) / var_577_2

				if arg_574_1.var_.characterEffect1076ui_story and not isNil(var_577_0) then
					local var_577_4 = Mathf.Lerp(0, 0.5, var_577_3)

					arg_574_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_574_1.var_.characterEffect1076ui_story.fillRatio = var_577_4
				end
			end

			if arg_574_1.time_ >= var_577_1 + var_577_2 and arg_574_1.time_ < var_577_1 + var_577_2 + arg_577_0 and not isNil(var_577_0) and arg_574_1.var_.characterEffect1076ui_story then
				local var_577_5 = 0.5

				arg_574_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_574_1.var_.characterEffect1076ui_story.fillRatio = var_577_5
			end

			local var_577_6 = 0
			local var_577_7 = 1.35

			if var_577_6 < arg_574_1.time_ and arg_574_1.time_ <= var_577_6 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, false)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_574_1.iconTrs_.gameObject, false)
				arg_574_1.callingController_:SetSelectedState("normal")

				local var_577_8 = arg_574_1:GetWordFromCfg(120431139)
				local var_577_9 = arg_574_1:FormatText(var_577_8.content)

				arg_574_1.text_.text = var_577_9

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_10 = 54
				local var_577_11 = utf8.len(var_577_9)
				local var_577_12 = var_577_10 <= 0 and var_577_7 or var_577_7 * (var_577_11 / var_577_10)

				if var_577_12 > 0 and var_577_7 < var_577_12 then
					arg_574_1.talkMaxDuration = var_577_12

					if var_577_12 + var_577_6 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_12 + var_577_6
					end
				end

				arg_574_1.text_.text = var_577_9
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)
				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_13 = math.max(var_577_7, arg_574_1.talkMaxDuration)

			if var_577_6 <= arg_574_1.time_ and arg_574_1.time_ < var_577_6 + var_577_13 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_6) / var_577_13

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_6 + var_577_13 and arg_574_1.time_ < var_577_6 + var_577_13 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	Play120431140 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 120431140
		arg_578_1.duration_ = 12.07

		local var_578_0 = {
			zh = 7.233,
			ja = 12.066
		}
		local var_578_1 = manager.audio:GetLocalizationFlag()

		if var_578_0[var_578_1] ~= nil then
			arg_578_1.duration_ = var_578_0[var_578_1]
		end

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play120431141(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			local var_581_0 = arg_578_1.actors_["1076ui_story"]
			local var_581_1 = 0

			if var_581_1 < arg_578_1.time_ and arg_578_1.time_ <= var_581_1 + arg_581_0 and not isNil(var_581_0) and arg_578_1.var_.characterEffect1076ui_story == nil then
				arg_578_1.var_.characterEffect1076ui_story = var_581_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_581_2 = 0.2

			if var_581_1 <= arg_578_1.time_ and arg_578_1.time_ < var_581_1 + var_581_2 and not isNil(var_581_0) then
				local var_581_3 = (arg_578_1.time_ - var_581_1) / var_581_2

				if arg_578_1.var_.characterEffect1076ui_story and not isNil(var_581_0) then
					arg_578_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_578_1.time_ >= var_581_1 + var_581_2 and arg_578_1.time_ < var_581_1 + var_581_2 + arg_581_0 and not isNil(var_581_0) and arg_578_1.var_.characterEffect1076ui_story then
				arg_578_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_581_4 = 0
			local var_581_5 = 0.825

			if var_581_4 < arg_578_1.time_ and arg_578_1.time_ <= var_581_4 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, true)

				local var_581_6 = arg_578_1:FormatText(StoryNameCfg[389].name)

				arg_578_1.leftNameTxt_.text = var_581_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, false)
				arg_578_1.callingController_:SetSelectedState("normal")

				local var_581_7 = arg_578_1:GetWordFromCfg(120431140)
				local var_581_8 = arg_578_1:FormatText(var_581_7.content)

				arg_578_1.text_.text = var_581_8

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_9 = 33
				local var_581_10 = utf8.len(var_581_8)
				local var_581_11 = var_581_9 <= 0 and var_581_5 or var_581_5 * (var_581_10 / var_581_9)

				if var_581_11 > 0 and var_581_5 < var_581_11 then
					arg_578_1.talkMaxDuration = var_581_11

					if var_581_11 + var_581_4 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_11 + var_581_4
					end
				end

				arg_578_1.text_.text = var_581_8
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431140", "story_v_out_120431.awb") ~= 0 then
					local var_581_12 = manager.audio:GetVoiceLength("story_v_out_120431", "120431140", "story_v_out_120431.awb") / 1000

					if var_581_12 + var_581_4 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_12 + var_581_4
					end

					if var_581_7.prefab_name ~= "" and arg_578_1.actors_[var_581_7.prefab_name] ~= nil then
						local var_581_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_578_1.actors_[var_581_7.prefab_name].transform, "story_v_out_120431", "120431140", "story_v_out_120431.awb")

						arg_578_1:RecordAudio("120431140", var_581_13)
						arg_578_1:RecordAudio("120431140", var_581_13)
					else
						arg_578_1:AudioAction("play", "voice", "story_v_out_120431", "120431140", "story_v_out_120431.awb")
					end

					arg_578_1:RecordHistoryTalkVoice("story_v_out_120431", "120431140", "story_v_out_120431.awb")
				end

				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_14 = math.max(var_581_5, arg_578_1.talkMaxDuration)

			if var_581_4 <= arg_578_1.time_ and arg_578_1.time_ < var_581_4 + var_581_14 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_4) / var_581_14

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_4 + var_581_14 and arg_578_1.time_ < var_581_4 + var_581_14 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {}

		arg_578_1:InitPlayNodeList()
	end,
	Play120431141 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 120431141
		arg_582_1.duration_ = 3.3

		local var_582_0 = {
			zh = 2.566,
			ja = 3.3
		}
		local var_582_1 = manager.audio:GetLocalizationFlag()

		if var_582_0[var_582_1] ~= nil then
			arg_582_1.duration_ = var_582_0[var_582_1]
		end

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play120431142(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			local var_585_0 = arg_582_1.actors_["1084ui_story"]
			local var_585_1 = 0

			if var_585_1 < arg_582_1.time_ and arg_582_1.time_ <= var_585_1 + arg_585_0 and not isNil(var_585_0) and arg_582_1.var_.characterEffect1084ui_story == nil then
				arg_582_1.var_.characterEffect1084ui_story = var_585_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_585_2 = 0.2

			if var_585_1 <= arg_582_1.time_ and arg_582_1.time_ < var_585_1 + var_585_2 and not isNil(var_585_0) then
				local var_585_3 = (arg_582_1.time_ - var_585_1) / var_585_2

				if arg_582_1.var_.characterEffect1084ui_story and not isNil(var_585_0) then
					arg_582_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_582_1.time_ >= var_585_1 + var_585_2 and arg_582_1.time_ < var_585_1 + var_585_2 + arg_585_0 and not isNil(var_585_0) and arg_582_1.var_.characterEffect1084ui_story then
				arg_582_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_585_4 = 0

			if var_585_4 < arg_582_1.time_ and arg_582_1.time_ <= var_585_4 + arg_585_0 then
				arg_582_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_585_5 = arg_582_1.actors_["1076ui_story"]
			local var_585_6 = 0

			if var_585_6 < arg_582_1.time_ and arg_582_1.time_ <= var_585_6 + arg_585_0 and not isNil(var_585_5) and arg_582_1.var_.characterEffect1076ui_story == nil then
				arg_582_1.var_.characterEffect1076ui_story = var_585_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_585_7 = 0.2

			if var_585_6 <= arg_582_1.time_ and arg_582_1.time_ < var_585_6 + var_585_7 and not isNil(var_585_5) then
				local var_585_8 = (arg_582_1.time_ - var_585_6) / var_585_7

				if arg_582_1.var_.characterEffect1076ui_story and not isNil(var_585_5) then
					local var_585_9 = Mathf.Lerp(0, 0.5, var_585_8)

					arg_582_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_582_1.var_.characterEffect1076ui_story.fillRatio = var_585_9
				end
			end

			if arg_582_1.time_ >= var_585_6 + var_585_7 and arg_582_1.time_ < var_585_6 + var_585_7 + arg_585_0 and not isNil(var_585_5) and arg_582_1.var_.characterEffect1076ui_story then
				local var_585_10 = 0.5

				arg_582_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_582_1.var_.characterEffect1076ui_story.fillRatio = var_585_10
			end

			local var_585_11 = 0

			if var_585_11 < arg_582_1.time_ and arg_582_1.time_ <= var_585_11 + arg_585_0 then
				arg_582_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			local var_585_12 = 0
			local var_585_13 = 0.125

			if var_585_12 < arg_582_1.time_ and arg_582_1.time_ <= var_585_12 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, true)

				local var_585_14 = arg_582_1:FormatText(StoryNameCfg[6].name)

				arg_582_1.leftNameTxt_.text = var_585_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_582_1.leftNameTxt_.transform)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1.leftNameTxt_.text)
				SetActive(arg_582_1.iconTrs_.gameObject, false)
				arg_582_1.callingController_:SetSelectedState("normal")

				local var_585_15 = arg_582_1:GetWordFromCfg(120431141)
				local var_585_16 = arg_582_1:FormatText(var_585_15.content)

				arg_582_1.text_.text = var_585_16

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_17 = 5
				local var_585_18 = utf8.len(var_585_16)
				local var_585_19 = var_585_17 <= 0 and var_585_13 or var_585_13 * (var_585_18 / var_585_17)

				if var_585_19 > 0 and var_585_13 < var_585_19 then
					arg_582_1.talkMaxDuration = var_585_19

					if var_585_19 + var_585_12 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_19 + var_585_12
					end
				end

				arg_582_1.text_.text = var_585_16
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431141", "story_v_out_120431.awb") ~= 0 then
					local var_585_20 = manager.audio:GetVoiceLength("story_v_out_120431", "120431141", "story_v_out_120431.awb") / 1000

					if var_585_20 + var_585_12 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_20 + var_585_12
					end

					if var_585_15.prefab_name ~= "" and arg_582_1.actors_[var_585_15.prefab_name] ~= nil then
						local var_585_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_582_1.actors_[var_585_15.prefab_name].transform, "story_v_out_120431", "120431141", "story_v_out_120431.awb")

						arg_582_1:RecordAudio("120431141", var_585_21)
						arg_582_1:RecordAudio("120431141", var_585_21)
					else
						arg_582_1:AudioAction("play", "voice", "story_v_out_120431", "120431141", "story_v_out_120431.awb")
					end

					arg_582_1:RecordHistoryTalkVoice("story_v_out_120431", "120431141", "story_v_out_120431.awb")
				end

				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_22 = math.max(var_585_13, arg_582_1.talkMaxDuration)

			if var_585_12 <= arg_582_1.time_ and arg_582_1.time_ < var_585_12 + var_585_22 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_12) / var_585_22

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_12 + var_585_22 and arg_582_1.time_ < var_585_12 + var_585_22 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {}

		arg_582_1:InitPlayNodeList()
	end,
	Play120431142 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 120431142
		arg_586_1.duration_ = 13.33

		local var_586_0 = {
			zh = 6.033,
			ja = 13.333
		}
		local var_586_1 = manager.audio:GetLocalizationFlag()

		if var_586_0[var_586_1] ~= nil then
			arg_586_1.duration_ = var_586_0[var_586_1]
		end

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
		end

		function arg_586_1.playNext_(arg_588_0)
			if arg_588_0 == 1 then
				arg_586_0:Play120431143(arg_586_1)
			end
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			local var_589_0 = arg_586_1.actors_["1076ui_story"]
			local var_589_1 = 0

			if var_589_1 < arg_586_1.time_ and arg_586_1.time_ <= var_589_1 + arg_589_0 and not isNil(var_589_0) and arg_586_1.var_.characterEffect1076ui_story == nil then
				arg_586_1.var_.characterEffect1076ui_story = var_589_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_589_2 = 0.2

			if var_589_1 <= arg_586_1.time_ and arg_586_1.time_ < var_589_1 + var_589_2 and not isNil(var_589_0) then
				local var_589_3 = (arg_586_1.time_ - var_589_1) / var_589_2

				if arg_586_1.var_.characterEffect1076ui_story and not isNil(var_589_0) then
					arg_586_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_586_1.time_ >= var_589_1 + var_589_2 and arg_586_1.time_ < var_589_1 + var_589_2 + arg_589_0 and not isNil(var_589_0) and arg_586_1.var_.characterEffect1076ui_story then
				arg_586_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_589_4 = arg_586_1.actors_["1084ui_story"]
			local var_589_5 = 0

			if var_589_5 < arg_586_1.time_ and arg_586_1.time_ <= var_589_5 + arg_589_0 and not isNil(var_589_4) and arg_586_1.var_.characterEffect1084ui_story == nil then
				arg_586_1.var_.characterEffect1084ui_story = var_589_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_589_6 = 0.2

			if var_589_5 <= arg_586_1.time_ and arg_586_1.time_ < var_589_5 + var_589_6 and not isNil(var_589_4) then
				local var_589_7 = (arg_586_1.time_ - var_589_5) / var_589_6

				if arg_586_1.var_.characterEffect1084ui_story and not isNil(var_589_4) then
					local var_589_8 = Mathf.Lerp(0, 0.5, var_589_7)

					arg_586_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_586_1.var_.characterEffect1084ui_story.fillRatio = var_589_8
				end
			end

			if arg_586_1.time_ >= var_589_5 + var_589_6 and arg_586_1.time_ < var_589_5 + var_589_6 + arg_589_0 and not isNil(var_589_4) and arg_586_1.var_.characterEffect1084ui_story then
				local var_589_9 = 0.5

				arg_586_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_586_1.var_.characterEffect1084ui_story.fillRatio = var_589_9
			end

			local var_589_10 = 0
			local var_589_11 = 0.575

			if var_589_10 < arg_586_1.time_ and arg_586_1.time_ <= var_589_10 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, true)

				local var_589_12 = arg_586_1:FormatText(StoryNameCfg[389].name)

				arg_586_1.leftNameTxt_.text = var_589_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_586_1.leftNameTxt_.transform)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1.leftNameTxt_.text)
				SetActive(arg_586_1.iconTrs_.gameObject, false)
				arg_586_1.callingController_:SetSelectedState("normal")

				local var_589_13 = arg_586_1:GetWordFromCfg(120431142)
				local var_589_14 = arg_586_1:FormatText(var_589_13.content)

				arg_586_1.text_.text = var_589_14

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_15 = 23
				local var_589_16 = utf8.len(var_589_14)
				local var_589_17 = var_589_15 <= 0 and var_589_11 or var_589_11 * (var_589_16 / var_589_15)

				if var_589_17 > 0 and var_589_11 < var_589_17 then
					arg_586_1.talkMaxDuration = var_589_17

					if var_589_17 + var_589_10 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_17 + var_589_10
					end
				end

				arg_586_1.text_.text = var_589_14
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431142", "story_v_out_120431.awb") ~= 0 then
					local var_589_18 = manager.audio:GetVoiceLength("story_v_out_120431", "120431142", "story_v_out_120431.awb") / 1000

					if var_589_18 + var_589_10 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_18 + var_589_10
					end

					if var_589_13.prefab_name ~= "" and arg_586_1.actors_[var_589_13.prefab_name] ~= nil then
						local var_589_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_586_1.actors_[var_589_13.prefab_name].transform, "story_v_out_120431", "120431142", "story_v_out_120431.awb")

						arg_586_1:RecordAudio("120431142", var_589_19)
						arg_586_1:RecordAudio("120431142", var_589_19)
					else
						arg_586_1:AudioAction("play", "voice", "story_v_out_120431", "120431142", "story_v_out_120431.awb")
					end

					arg_586_1:RecordHistoryTalkVoice("story_v_out_120431", "120431142", "story_v_out_120431.awb")
				end

				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_20 = math.max(var_589_11, arg_586_1.talkMaxDuration)

			if var_589_10 <= arg_586_1.time_ and arg_586_1.time_ < var_589_10 + var_589_20 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - var_589_10) / var_589_20

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= var_589_10 + var_589_20 and arg_586_1.time_ < var_589_10 + var_589_20 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {}

		arg_586_1:InitPlayNodeList()
	end,
	Play120431143 = function(arg_590_0, arg_590_1)
		arg_590_1.time_ = 0
		arg_590_1.frameCnt_ = 0
		arg_590_1.state_ = "playing"
		arg_590_1.curTalkId_ = 120431143
		arg_590_1.duration_ = 2.27

		local var_590_0 = {
			zh = 1.999999999999,
			ja = 2.266
		}
		local var_590_1 = manager.audio:GetLocalizationFlag()

		if var_590_0[var_590_1] ~= nil then
			arg_590_1.duration_ = var_590_0[var_590_1]
		end

		SetActive(arg_590_1.tipsGo_, false)

		function arg_590_1.onSingleLineFinish_()
			arg_590_1.onSingleLineUpdate_ = nil
			arg_590_1.onSingleLineFinish_ = nil
			arg_590_1.state_ = "waiting"
		end

		function arg_590_1.playNext_(arg_592_0)
			if arg_592_0 == 1 then
				arg_590_0:Play120431144(arg_590_1)
			end
		end

		function arg_590_1.onSingleLineUpdate_(arg_593_0)
			local var_593_0 = arg_590_1.actors_["1076ui_story"]
			local var_593_1 = 0

			if var_593_1 < arg_590_1.time_ and arg_590_1.time_ <= var_593_1 + arg_593_0 and not isNil(var_593_0) and arg_590_1.var_.characterEffect1076ui_story == nil then
				arg_590_1.var_.characterEffect1076ui_story = var_593_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_593_2 = 0.2

			if var_593_1 <= arg_590_1.time_ and arg_590_1.time_ < var_593_1 + var_593_2 and not isNil(var_593_0) then
				local var_593_3 = (arg_590_1.time_ - var_593_1) / var_593_2

				if arg_590_1.var_.characterEffect1076ui_story and not isNil(var_593_0) then
					local var_593_4 = Mathf.Lerp(0, 0.5, var_593_3)

					arg_590_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_590_1.var_.characterEffect1076ui_story.fillRatio = var_593_4
				end
			end

			if arg_590_1.time_ >= var_593_1 + var_593_2 and arg_590_1.time_ < var_593_1 + var_593_2 + arg_593_0 and not isNil(var_593_0) and arg_590_1.var_.characterEffect1076ui_story then
				local var_593_5 = 0.5

				arg_590_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_590_1.var_.characterEffect1076ui_story.fillRatio = var_593_5
			end

			local var_593_6 = arg_590_1.actors_["1084ui_story"]
			local var_593_7 = 0

			if var_593_7 < arg_590_1.time_ and arg_590_1.time_ <= var_593_7 + arg_593_0 and not isNil(var_593_6) and arg_590_1.var_.characterEffect1084ui_story == nil then
				arg_590_1.var_.characterEffect1084ui_story = var_593_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_593_8 = 0.2

			if var_593_7 <= arg_590_1.time_ and arg_590_1.time_ < var_593_7 + var_593_8 and not isNil(var_593_6) then
				local var_593_9 = (arg_590_1.time_ - var_593_7) / var_593_8

				if arg_590_1.var_.characterEffect1084ui_story and not isNil(var_593_6) then
					arg_590_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_590_1.time_ >= var_593_7 + var_593_8 and arg_590_1.time_ < var_593_7 + var_593_8 + arg_593_0 and not isNil(var_593_6) and arg_590_1.var_.characterEffect1084ui_story then
				arg_590_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_593_10 = 0

			if var_593_10 < arg_590_1.time_ and arg_590_1.time_ <= var_593_10 + arg_593_0 then
				arg_590_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_593_11 = 0
			local var_593_12 = 0.15

			if var_593_11 < arg_590_1.time_ and arg_590_1.time_ <= var_593_11 + arg_593_0 then
				arg_590_1.talkMaxDuration = 0
				arg_590_1.dialogCg_.alpha = 1

				arg_590_1.dialog_:SetActive(true)
				SetActive(arg_590_1.leftNameGo_, true)

				local var_593_13 = arg_590_1:FormatText(StoryNameCfg[6].name)

				arg_590_1.leftNameTxt_.text = var_593_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_590_1.leftNameTxt_.transform)

				arg_590_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_590_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_590_1:RecordName(arg_590_1.leftNameTxt_.text)
				SetActive(arg_590_1.iconTrs_.gameObject, false)
				arg_590_1.callingController_:SetSelectedState("normal")

				local var_593_14 = arg_590_1:GetWordFromCfg(120431143)
				local var_593_15 = arg_590_1:FormatText(var_593_14.content)

				arg_590_1.text_.text = var_593_15

				LuaForUtil.ClearLinePrefixSymbol(arg_590_1.text_)

				local var_593_16 = 6
				local var_593_17 = utf8.len(var_593_15)
				local var_593_18 = var_593_16 <= 0 and var_593_12 or var_593_12 * (var_593_17 / var_593_16)

				if var_593_18 > 0 and var_593_12 < var_593_18 then
					arg_590_1.talkMaxDuration = var_593_18

					if var_593_18 + var_593_11 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_18 + var_593_11
					end
				end

				arg_590_1.text_.text = var_593_15
				arg_590_1.typewritter.percent = 0

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431143", "story_v_out_120431.awb") ~= 0 then
					local var_593_19 = manager.audio:GetVoiceLength("story_v_out_120431", "120431143", "story_v_out_120431.awb") / 1000

					if var_593_19 + var_593_11 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_19 + var_593_11
					end

					if var_593_14.prefab_name ~= "" and arg_590_1.actors_[var_593_14.prefab_name] ~= nil then
						local var_593_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_590_1.actors_[var_593_14.prefab_name].transform, "story_v_out_120431", "120431143", "story_v_out_120431.awb")

						arg_590_1:RecordAudio("120431143", var_593_20)
						arg_590_1:RecordAudio("120431143", var_593_20)
					else
						arg_590_1:AudioAction("play", "voice", "story_v_out_120431", "120431143", "story_v_out_120431.awb")
					end

					arg_590_1:RecordHistoryTalkVoice("story_v_out_120431", "120431143", "story_v_out_120431.awb")
				end

				arg_590_1:RecordContent(arg_590_1.text_.text)
			end

			local var_593_21 = math.max(var_593_12, arg_590_1.talkMaxDuration)

			if var_593_11 <= arg_590_1.time_ and arg_590_1.time_ < var_593_11 + var_593_21 then
				arg_590_1.typewritter.percent = (arg_590_1.time_ - var_593_11) / var_593_21

				arg_590_1.typewritter:SetDirty()
			end

			if arg_590_1.time_ >= var_593_11 + var_593_21 and arg_590_1.time_ < var_593_11 + var_593_21 + arg_593_0 then
				arg_590_1.typewritter.percent = 1

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(true)
			end
		end

		arg_590_1.nodeConfigList_ = {}

		arg_590_1:InitPlayNodeList()
	end,
	Play120431144 = function(arg_594_0, arg_594_1)
		arg_594_1.time_ = 0
		arg_594_1.frameCnt_ = 0
		arg_594_1.state_ = "playing"
		arg_594_1.curTalkId_ = 120431144
		arg_594_1.duration_ = 5

		SetActive(arg_594_1.tipsGo_, false)

		function arg_594_1.onSingleLineFinish_()
			arg_594_1.onSingleLineUpdate_ = nil
			arg_594_1.onSingleLineFinish_ = nil
			arg_594_1.state_ = "waiting"
		end

		function arg_594_1.playNext_(arg_596_0)
			if arg_596_0 == 1 then
				arg_594_0:Play120431145(arg_594_1)
			end
		end

		function arg_594_1.onSingleLineUpdate_(arg_597_0)
			local var_597_0 = 0
			local var_597_1 = 0.3

			if var_597_0 < arg_594_1.time_ and arg_594_1.time_ <= var_597_0 + arg_597_0 then
				arg_594_1.talkMaxDuration = 0
				arg_594_1.dialogCg_.alpha = 1

				arg_594_1.dialog_:SetActive(true)
				SetActive(arg_594_1.leftNameGo_, false)

				arg_594_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_594_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_594_1:RecordName(arg_594_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_594_1.iconTrs_.gameObject, false)
				arg_594_1.callingController_:SetSelectedState("normal")

				local var_597_2 = arg_594_1:GetWordFromCfg(120431144)
				local var_597_3 = arg_594_1:FormatText(var_597_2.content)

				arg_594_1.text_.text = var_597_3

				LuaForUtil.ClearLinePrefixSymbol(arg_594_1.text_)

				local var_597_4 = 12
				local var_597_5 = utf8.len(var_597_3)
				local var_597_6 = var_597_4 <= 0 and var_597_1 or var_597_1 * (var_597_5 / var_597_4)

				if var_597_6 > 0 and var_597_1 < var_597_6 then
					arg_594_1.talkMaxDuration = var_597_6

					if var_597_6 + var_597_0 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_6 + var_597_0
					end
				end

				arg_594_1.text_.text = var_597_3
				arg_594_1.typewritter.percent = 0

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(false)
				arg_594_1:RecordContent(arg_594_1.text_.text)
			end

			local var_597_7 = math.max(var_597_1, arg_594_1.talkMaxDuration)

			if var_597_0 <= arg_594_1.time_ and arg_594_1.time_ < var_597_0 + var_597_7 then
				arg_594_1.typewritter.percent = (arg_594_1.time_ - var_597_0) / var_597_7

				arg_594_1.typewritter:SetDirty()
			end

			if arg_594_1.time_ >= var_597_0 + var_597_7 and arg_594_1.time_ < var_597_0 + var_597_7 + arg_597_0 then
				arg_594_1.typewritter.percent = 1

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(true)
			end
		end

		arg_594_1.nodeConfigList_ = {}

		arg_594_1:InitPlayNodeList()
	end,
	Play120431145 = function(arg_598_0, arg_598_1)
		arg_598_1.time_ = 0
		arg_598_1.frameCnt_ = 0
		arg_598_1.state_ = "playing"
		arg_598_1.curTalkId_ = 120431145
		arg_598_1.duration_ = 9

		SetActive(arg_598_1.tipsGo_, false)

		function arg_598_1.onSingleLineFinish_()
			arg_598_1.onSingleLineUpdate_ = nil
			arg_598_1.onSingleLineFinish_ = nil
			arg_598_1.state_ = "waiting"
		end

		function arg_598_1.playNext_(arg_600_0)
			if arg_600_0 == 1 then
				arg_598_0:Play120431146(arg_598_1)
			end
		end

		function arg_598_1.onSingleLineUpdate_(arg_601_0)
			local var_601_0 = "XH0206"

			if arg_598_1.bgs_[var_601_0] == nil then
				local var_601_1 = Object.Instantiate(arg_598_1.paintGo_)

				var_601_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_601_0)
				var_601_1.name = var_601_0
				var_601_1.transform.parent = arg_598_1.stage_.transform
				var_601_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_598_1.bgs_[var_601_0] = var_601_1
			end

			local var_601_2 = 2

			if var_601_2 < arg_598_1.time_ and arg_598_1.time_ <= var_601_2 + arg_601_0 then
				local var_601_3 = manager.ui.mainCamera.transform.localPosition
				local var_601_4 = Vector3.New(0, 0, 10) + Vector3.New(var_601_3.x, var_601_3.y, 0)
				local var_601_5 = arg_598_1.bgs_.XH0206

				var_601_5.transform.localPosition = var_601_4
				var_601_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_601_6 = var_601_5:GetComponent("SpriteRenderer")

				if var_601_6 and var_601_6.sprite then
					local var_601_7 = (var_601_5.transform.localPosition - var_601_3).z
					local var_601_8 = manager.ui.mainCameraCom_
					local var_601_9 = 2 * var_601_7 * Mathf.Tan(var_601_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_601_10 = var_601_9 * var_601_8.aspect
					local var_601_11 = var_601_6.sprite.bounds.size.x
					local var_601_12 = var_601_6.sprite.bounds.size.y
					local var_601_13 = var_601_10 / var_601_11
					local var_601_14 = var_601_9 / var_601_12
					local var_601_15 = var_601_14 < var_601_13 and var_601_13 or var_601_14

					var_601_5.transform.localScale = Vector3.New(var_601_15, var_601_15, 0)
				end

				for iter_601_0, iter_601_1 in pairs(arg_598_1.bgs_) do
					if iter_601_0 ~= "XH0206" then
						iter_601_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_601_16 = 0

			if var_601_16 < arg_598_1.time_ and arg_598_1.time_ <= var_601_16 + arg_601_0 then
				arg_598_1.mask_.enabled = true
				arg_598_1.mask_.raycastTarget = true

				arg_598_1:SetGaussion(false)
			end

			local var_601_17 = 2

			if var_601_16 <= arg_598_1.time_ and arg_598_1.time_ < var_601_16 + var_601_17 then
				local var_601_18 = (arg_598_1.time_ - var_601_16) / var_601_17
				local var_601_19 = Color.New(0, 0, 0)

				var_601_19.a = Mathf.Lerp(0, 1, var_601_18)
				arg_598_1.mask_.color = var_601_19
			end

			if arg_598_1.time_ >= var_601_16 + var_601_17 and arg_598_1.time_ < var_601_16 + var_601_17 + arg_601_0 then
				local var_601_20 = Color.New(0, 0, 0)

				var_601_20.a = 1
				arg_598_1.mask_.color = var_601_20
			end

			local var_601_21 = 2

			if var_601_21 < arg_598_1.time_ and arg_598_1.time_ <= var_601_21 + arg_601_0 then
				arg_598_1.mask_.enabled = true
				arg_598_1.mask_.raycastTarget = true

				arg_598_1:SetGaussion(false)
			end

			local var_601_22 = 2

			if var_601_21 <= arg_598_1.time_ and arg_598_1.time_ < var_601_21 + var_601_22 then
				local var_601_23 = (arg_598_1.time_ - var_601_21) / var_601_22
				local var_601_24 = Color.New(0, 0, 0)

				var_601_24.a = Mathf.Lerp(1, 0, var_601_23)
				arg_598_1.mask_.color = var_601_24
			end

			if arg_598_1.time_ >= var_601_21 + var_601_22 and arg_598_1.time_ < var_601_21 + var_601_22 + arg_601_0 then
				local var_601_25 = Color.New(0, 0, 0)
				local var_601_26 = 0

				arg_598_1.mask_.enabled = false
				var_601_25.a = var_601_26
				arg_598_1.mask_.color = var_601_25
			end

			local var_601_27 = arg_598_1.actors_["1076ui_story"].transform
			local var_601_28 = 1.966

			if var_601_28 < arg_598_1.time_ and arg_598_1.time_ <= var_601_28 + arg_601_0 then
				arg_598_1.var_.moveOldPos1076ui_story = var_601_27.localPosition
			end

			local var_601_29 = 0.001

			if var_601_28 <= arg_598_1.time_ and arg_598_1.time_ < var_601_28 + var_601_29 then
				local var_601_30 = (arg_598_1.time_ - var_601_28) / var_601_29
				local var_601_31 = Vector3.New(0, 100, 0)

				var_601_27.localPosition = Vector3.Lerp(arg_598_1.var_.moveOldPos1076ui_story, var_601_31, var_601_30)

				local var_601_32 = manager.ui.mainCamera.transform.position - var_601_27.position

				var_601_27.forward = Vector3.New(var_601_32.x, var_601_32.y, var_601_32.z)

				local var_601_33 = var_601_27.localEulerAngles

				var_601_33.z = 0
				var_601_33.x = 0
				var_601_27.localEulerAngles = var_601_33
			end

			if arg_598_1.time_ >= var_601_28 + var_601_29 and arg_598_1.time_ < var_601_28 + var_601_29 + arg_601_0 then
				var_601_27.localPosition = Vector3.New(0, 100, 0)

				local var_601_34 = manager.ui.mainCamera.transform.position - var_601_27.position

				var_601_27.forward = Vector3.New(var_601_34.x, var_601_34.y, var_601_34.z)

				local var_601_35 = var_601_27.localEulerAngles

				var_601_35.z = 0
				var_601_35.x = 0
				var_601_27.localEulerAngles = var_601_35
			end

			local var_601_36 = arg_598_1.actors_["1084ui_story"].transform
			local var_601_37 = 1.966

			if var_601_37 < arg_598_1.time_ and arg_598_1.time_ <= var_601_37 + arg_601_0 then
				arg_598_1.var_.moveOldPos1084ui_story = var_601_36.localPosition
			end

			local var_601_38 = 0.001

			if var_601_37 <= arg_598_1.time_ and arg_598_1.time_ < var_601_37 + var_601_38 then
				local var_601_39 = (arg_598_1.time_ - var_601_37) / var_601_38
				local var_601_40 = Vector3.New(0, 100, 0)

				var_601_36.localPosition = Vector3.Lerp(arg_598_1.var_.moveOldPos1084ui_story, var_601_40, var_601_39)

				local var_601_41 = manager.ui.mainCamera.transform.position - var_601_36.position

				var_601_36.forward = Vector3.New(var_601_41.x, var_601_41.y, var_601_41.z)

				local var_601_42 = var_601_36.localEulerAngles

				var_601_42.z = 0
				var_601_42.x = 0
				var_601_36.localEulerAngles = var_601_42
			end

			if arg_598_1.time_ >= var_601_37 + var_601_38 and arg_598_1.time_ < var_601_37 + var_601_38 + arg_601_0 then
				var_601_36.localPosition = Vector3.New(0, 100, 0)

				local var_601_43 = manager.ui.mainCamera.transform.position - var_601_36.position

				var_601_36.forward = Vector3.New(var_601_43.x, var_601_43.y, var_601_43.z)

				local var_601_44 = var_601_36.localEulerAngles

				var_601_44.z = 0
				var_601_44.x = 0
				var_601_36.localEulerAngles = var_601_44
			end

			local var_601_45 = arg_598_1.bgs_.XH0206.transform
			local var_601_46 = 2

			if var_601_46 < arg_598_1.time_ and arg_598_1.time_ <= var_601_46 + arg_601_0 then
				arg_598_1.var_.moveOldPosXH0206 = var_601_45.localPosition
			end

			local var_601_47 = 0.001

			if var_601_46 <= arg_598_1.time_ and arg_598_1.time_ < var_601_46 + var_601_47 then
				local var_601_48 = (arg_598_1.time_ - var_601_46) / var_601_47
				local var_601_49 = Vector3.New(0, 1, 9.5)

				var_601_45.localPosition = Vector3.Lerp(arg_598_1.var_.moveOldPosXH0206, var_601_49, var_601_48)
			end

			if arg_598_1.time_ >= var_601_46 + var_601_47 and arg_598_1.time_ < var_601_46 + var_601_47 + arg_601_0 then
				var_601_45.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_601_50 = arg_598_1.bgs_.XH0206.transform
			local var_601_51 = 2.034

			if var_601_51 < arg_598_1.time_ and arg_598_1.time_ <= var_601_51 + arg_601_0 then
				arg_598_1.var_.moveOldPosXH0206 = var_601_50.localPosition
			end

			local var_601_52 = 4.5

			if var_601_51 <= arg_598_1.time_ and arg_598_1.time_ < var_601_51 + var_601_52 then
				local var_601_53 = (arg_598_1.time_ - var_601_51) / var_601_52
				local var_601_54 = Vector3.New(0, 1, 10)

				var_601_50.localPosition = Vector3.Lerp(arg_598_1.var_.moveOldPosXH0206, var_601_54, var_601_53)
			end

			if arg_598_1.time_ >= var_601_51 + var_601_52 and arg_598_1.time_ < var_601_51 + var_601_52 + arg_601_0 then
				var_601_50.localPosition = Vector3.New(0, 1, 10)
			end

			local var_601_55 = 4

			if var_601_55 < arg_598_1.time_ and arg_598_1.time_ <= var_601_55 + arg_601_0 then
				arg_598_1.allBtn_.enabled = false
			end

			local var_601_56 = 2.534

			if arg_598_1.time_ >= var_601_55 + var_601_56 and arg_598_1.time_ < var_601_55 + var_601_56 + arg_601_0 then
				arg_598_1.allBtn_.enabled = true
			end

			if arg_598_1.frameCnt_ <= 1 then
				arg_598_1.dialog_:SetActive(false)
			end

			local var_601_57 = 4
			local var_601_58 = 1.075

			if var_601_57 < arg_598_1.time_ and arg_598_1.time_ <= var_601_57 + arg_601_0 then
				arg_598_1.talkMaxDuration = 0

				arg_598_1.dialog_:SetActive(true)

				arg_598_1.dialogCg_.alpha = 0

				local var_601_59 = LeanTween.value(arg_598_1.dialog_, 0, 1, 0.3)

				var_601_59:setOnUpdate(LuaHelper.FloatAction(function(arg_602_0)
					arg_598_1.dialogCg_.alpha = arg_602_0
				end))
				var_601_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_598_1.dialog_)
					var_601_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_598_1.duration_ = arg_598_1.duration_ + 0.3

				SetActive(arg_598_1.leftNameGo_, false)

				arg_598_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_598_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_598_1:RecordName(arg_598_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_598_1.iconTrs_.gameObject, false)
				arg_598_1.callingController_:SetSelectedState("normal")

				local var_601_60 = arg_598_1:GetWordFromCfg(120431145)
				local var_601_61 = arg_598_1:FormatText(var_601_60.content)

				arg_598_1.text_.text = var_601_61

				LuaForUtil.ClearLinePrefixSymbol(arg_598_1.text_)

				local var_601_62 = 43
				local var_601_63 = utf8.len(var_601_61)
				local var_601_64 = var_601_62 <= 0 and var_601_58 or var_601_58 * (var_601_63 / var_601_62)

				if var_601_64 > 0 and var_601_58 < var_601_64 then
					arg_598_1.talkMaxDuration = var_601_64
					var_601_57 = var_601_57 + 0.3

					if var_601_64 + var_601_57 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_64 + var_601_57
					end
				end

				arg_598_1.text_.text = var_601_61
				arg_598_1.typewritter.percent = 0

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(false)
				arg_598_1:RecordContent(arg_598_1.text_.text)
			end

			local var_601_65 = var_601_57 + 0.3
			local var_601_66 = math.max(var_601_58, arg_598_1.talkMaxDuration)

			if var_601_65 <= arg_598_1.time_ and arg_598_1.time_ < var_601_65 + var_601_66 then
				arg_598_1.typewritter.percent = (arg_598_1.time_ - var_601_65) / var_601_66

				arg_598_1.typewritter:SetDirty()
			end

			if arg_598_1.time_ >= var_601_65 + var_601_66 and arg_598_1.time_ < var_601_65 + var_601_66 + arg_601_0 then
				arg_598_1.typewritter.percent = 1

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(true)
			end
		end

		arg_598_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "XH0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_598_1:InitPlayNodeList()
	end,
	Play120431146 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 120431146
		arg_604_1.duration_ = 5

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play120431147(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			local var_607_0 = 0
			local var_607_1 = 0.9

			if var_607_0 < arg_604_1.time_ and arg_604_1.time_ <= var_607_0 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, false)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_604_1.iconTrs_.gameObject, false)
				arg_604_1.callingController_:SetSelectedState("normal")

				local var_607_2 = arg_604_1:GetWordFromCfg(120431146)
				local var_607_3 = arg_604_1:FormatText(var_607_2.content)

				arg_604_1.text_.text = var_607_3

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_4 = 36
				local var_607_5 = utf8.len(var_607_3)
				local var_607_6 = var_607_4 <= 0 and var_607_1 or var_607_1 * (var_607_5 / var_607_4)

				if var_607_6 > 0 and var_607_1 < var_607_6 then
					arg_604_1.talkMaxDuration = var_607_6

					if var_607_6 + var_607_0 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_6 + var_607_0
					end
				end

				arg_604_1.text_.text = var_607_3
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)
				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_7 = math.max(var_607_1, arg_604_1.talkMaxDuration)

			if var_607_0 <= arg_604_1.time_ and arg_604_1.time_ < var_607_0 + var_607_7 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_0) / var_607_7

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_0 + var_607_7 and arg_604_1.time_ < var_607_0 + var_607_7 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {}

		arg_604_1:InitPlayNodeList()
	end,
	Play120431147 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 120431147
		arg_608_1.duration_ = 5.2

		local var_608_0 = {
			zh = 1.433,
			ja = 5.2
		}
		local var_608_1 = manager.audio:GetLocalizationFlag()

		if var_608_0[var_608_1] ~= nil then
			arg_608_1.duration_ = var_608_0[var_608_1]
		end

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play120431148(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			local var_611_0 = 0
			local var_611_1 = 0.125

			if var_611_0 < arg_608_1.time_ and arg_608_1.time_ <= var_611_0 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, true)

				local var_611_2 = arg_608_1:FormatText(StoryNameCfg[389].name)

				arg_608_1.leftNameTxt_.text = var_611_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_608_1.leftNameTxt_.transform)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1.leftNameTxt_.text)
				SetActive(arg_608_1.iconTrs_.gameObject, false)
				arg_608_1.callingController_:SetSelectedState("normal")

				local var_611_3 = arg_608_1:GetWordFromCfg(120431147)
				local var_611_4 = arg_608_1:FormatText(var_611_3.content)

				arg_608_1.text_.text = var_611_4

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_5 = 5
				local var_611_6 = utf8.len(var_611_4)
				local var_611_7 = var_611_5 <= 0 and var_611_1 or var_611_1 * (var_611_6 / var_611_5)

				if var_611_7 > 0 and var_611_1 < var_611_7 then
					arg_608_1.talkMaxDuration = var_611_7

					if var_611_7 + var_611_0 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_7 + var_611_0
					end
				end

				arg_608_1.text_.text = var_611_4
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431147", "story_v_out_120431.awb") ~= 0 then
					local var_611_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431147", "story_v_out_120431.awb") / 1000

					if var_611_8 + var_611_0 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_8 + var_611_0
					end

					if var_611_3.prefab_name ~= "" and arg_608_1.actors_[var_611_3.prefab_name] ~= nil then
						local var_611_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_608_1.actors_[var_611_3.prefab_name].transform, "story_v_out_120431", "120431147", "story_v_out_120431.awb")

						arg_608_1:RecordAudio("120431147", var_611_9)
						arg_608_1:RecordAudio("120431147", var_611_9)
					else
						arg_608_1:AudioAction("play", "voice", "story_v_out_120431", "120431147", "story_v_out_120431.awb")
					end

					arg_608_1:RecordHistoryTalkVoice("story_v_out_120431", "120431147", "story_v_out_120431.awb")
				end

				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_10 = math.max(var_611_1, arg_608_1.talkMaxDuration)

			if var_611_0 <= arg_608_1.time_ and arg_608_1.time_ < var_611_0 + var_611_10 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_0) / var_611_10

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_0 + var_611_10 and arg_608_1.time_ < var_611_0 + var_611_10 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {}

		arg_608_1:InitPlayNodeList()
	end,
	Play120431148 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 120431148
		arg_612_1.duration_ = 8.33

		local var_612_0 = {
			zh = 8.333,
			ja = 8.266
		}
		local var_612_1 = manager.audio:GetLocalizationFlag()

		if var_612_0[var_612_1] ~= nil then
			arg_612_1.duration_ = var_612_0[var_612_1]
		end

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
		end

		function arg_612_1.playNext_(arg_614_0)
			if arg_614_0 == 1 then
				arg_612_0:Play120431149(arg_612_1)
			end
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			local var_615_0 = 0
			local var_615_1 = 0.675

			if var_615_0 < arg_612_1.time_ and arg_612_1.time_ <= var_615_0 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, true)

				local var_615_2 = arg_612_1:FormatText(StoryNameCfg[6].name)

				arg_612_1.leftNameTxt_.text = var_615_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_612_1.leftNameTxt_.transform)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1.leftNameTxt_.text)
				SetActive(arg_612_1.iconTrs_.gameObject, false)
				arg_612_1.callingController_:SetSelectedState("normal")

				local var_615_3 = arg_612_1:GetWordFromCfg(120431148)
				local var_615_4 = arg_612_1:FormatText(var_615_3.content)

				arg_612_1.text_.text = var_615_4

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_5 = 27
				local var_615_6 = utf8.len(var_615_4)
				local var_615_7 = var_615_5 <= 0 and var_615_1 or var_615_1 * (var_615_6 / var_615_5)

				if var_615_7 > 0 and var_615_1 < var_615_7 then
					arg_612_1.talkMaxDuration = var_615_7

					if var_615_7 + var_615_0 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_7 + var_615_0
					end
				end

				arg_612_1.text_.text = var_615_4
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431148", "story_v_out_120431.awb") ~= 0 then
					local var_615_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431148", "story_v_out_120431.awb") / 1000

					if var_615_8 + var_615_0 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_8 + var_615_0
					end

					if var_615_3.prefab_name ~= "" and arg_612_1.actors_[var_615_3.prefab_name] ~= nil then
						local var_615_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_612_1.actors_[var_615_3.prefab_name].transform, "story_v_out_120431", "120431148", "story_v_out_120431.awb")

						arg_612_1:RecordAudio("120431148", var_615_9)
						arg_612_1:RecordAudio("120431148", var_615_9)
					else
						arg_612_1:AudioAction("play", "voice", "story_v_out_120431", "120431148", "story_v_out_120431.awb")
					end

					arg_612_1:RecordHistoryTalkVoice("story_v_out_120431", "120431148", "story_v_out_120431.awb")
				end

				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_10 = math.max(var_615_1, arg_612_1.talkMaxDuration)

			if var_615_0 <= arg_612_1.time_ and arg_612_1.time_ < var_615_0 + var_615_10 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - var_615_0) / var_615_10

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= var_615_0 + var_615_10 and arg_612_1.time_ < var_615_0 + var_615_10 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {}

		arg_612_1:InitPlayNodeList()
	end,
	Play120431149 = function(arg_616_0, arg_616_1)
		arg_616_1.time_ = 0
		arg_616_1.frameCnt_ = 0
		arg_616_1.state_ = "playing"
		arg_616_1.curTalkId_ = 120431149
		arg_616_1.duration_ = 6.17

		local var_616_0 = {
			zh = 1.8,
			ja = 6.166
		}
		local var_616_1 = manager.audio:GetLocalizationFlag()

		if var_616_0[var_616_1] ~= nil then
			arg_616_1.duration_ = var_616_0[var_616_1]
		end

		SetActive(arg_616_1.tipsGo_, false)

		function arg_616_1.onSingleLineFinish_()
			arg_616_1.onSingleLineUpdate_ = nil
			arg_616_1.onSingleLineFinish_ = nil
			arg_616_1.state_ = "waiting"
		end

		function arg_616_1.playNext_(arg_618_0)
			if arg_618_0 == 1 then
				arg_616_0:Play120431150(arg_616_1)
			end
		end

		function arg_616_1.onSingleLineUpdate_(arg_619_0)
			local var_619_0 = 0
			local var_619_1 = 0.125

			if var_619_0 < arg_616_1.time_ and arg_616_1.time_ <= var_619_0 + arg_619_0 then
				arg_616_1.talkMaxDuration = 0
				arg_616_1.dialogCg_.alpha = 1

				arg_616_1.dialog_:SetActive(true)
				SetActive(arg_616_1.leftNameGo_, true)

				local var_619_2 = arg_616_1:FormatText(StoryNameCfg[389].name)

				arg_616_1.leftNameTxt_.text = var_619_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_616_1.leftNameTxt_.transform)

				arg_616_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_616_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_616_1:RecordName(arg_616_1.leftNameTxt_.text)
				SetActive(arg_616_1.iconTrs_.gameObject, false)
				arg_616_1.callingController_:SetSelectedState("normal")

				local var_619_3 = arg_616_1:GetWordFromCfg(120431149)
				local var_619_4 = arg_616_1:FormatText(var_619_3.content)

				arg_616_1.text_.text = var_619_4

				LuaForUtil.ClearLinePrefixSymbol(arg_616_1.text_)

				local var_619_5 = 5
				local var_619_6 = utf8.len(var_619_4)
				local var_619_7 = var_619_5 <= 0 and var_619_1 or var_619_1 * (var_619_6 / var_619_5)

				if var_619_7 > 0 and var_619_1 < var_619_7 then
					arg_616_1.talkMaxDuration = var_619_7

					if var_619_7 + var_619_0 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_7 + var_619_0
					end
				end

				arg_616_1.text_.text = var_619_4
				arg_616_1.typewritter.percent = 0

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431149", "story_v_out_120431.awb") ~= 0 then
					local var_619_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431149", "story_v_out_120431.awb") / 1000

					if var_619_8 + var_619_0 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_8 + var_619_0
					end

					if var_619_3.prefab_name ~= "" and arg_616_1.actors_[var_619_3.prefab_name] ~= nil then
						local var_619_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_616_1.actors_[var_619_3.prefab_name].transform, "story_v_out_120431", "120431149", "story_v_out_120431.awb")

						arg_616_1:RecordAudio("120431149", var_619_9)
						arg_616_1:RecordAudio("120431149", var_619_9)
					else
						arg_616_1:AudioAction("play", "voice", "story_v_out_120431", "120431149", "story_v_out_120431.awb")
					end

					arg_616_1:RecordHistoryTalkVoice("story_v_out_120431", "120431149", "story_v_out_120431.awb")
				end

				arg_616_1:RecordContent(arg_616_1.text_.text)
			end

			local var_619_10 = math.max(var_619_1, arg_616_1.talkMaxDuration)

			if var_619_0 <= arg_616_1.time_ and arg_616_1.time_ < var_619_0 + var_619_10 then
				arg_616_1.typewritter.percent = (arg_616_1.time_ - var_619_0) / var_619_10

				arg_616_1.typewritter:SetDirty()
			end

			if arg_616_1.time_ >= var_619_0 + var_619_10 and arg_616_1.time_ < var_619_0 + var_619_10 + arg_619_0 then
				arg_616_1.typewritter.percent = 1

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(true)
			end
		end

		arg_616_1.nodeConfigList_ = {}

		arg_616_1:InitPlayNodeList()
	end,
	Play120431150 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 120431150
		arg_620_1.duration_ = 7.57

		local var_620_0 = {
			zh = 7.333,
			ja = 7.566
		}
		local var_620_1 = manager.audio:GetLocalizationFlag()

		if var_620_0[var_620_1] ~= nil then
			arg_620_1.duration_ = var_620_0[var_620_1]
		end

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play120431151(arg_620_1)
			end
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			local var_623_0 = 0
			local var_623_1 = 0.575

			if var_623_0 < arg_620_1.time_ and arg_620_1.time_ <= var_623_0 + arg_623_0 then
				arg_620_1.talkMaxDuration = 0
				arg_620_1.dialogCg_.alpha = 1

				arg_620_1.dialog_:SetActive(true)
				SetActive(arg_620_1.leftNameGo_, true)

				local var_623_2 = arg_620_1:FormatText(StoryNameCfg[6].name)

				arg_620_1.leftNameTxt_.text = var_623_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_620_1.leftNameTxt_.transform)

				arg_620_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_620_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_620_1:RecordName(arg_620_1.leftNameTxt_.text)
				SetActive(arg_620_1.iconTrs_.gameObject, false)
				arg_620_1.callingController_:SetSelectedState("normal")

				local var_623_3 = arg_620_1:GetWordFromCfg(120431150)
				local var_623_4 = arg_620_1:FormatText(var_623_3.content)

				arg_620_1.text_.text = var_623_4

				LuaForUtil.ClearLinePrefixSymbol(arg_620_1.text_)

				local var_623_5 = 23
				local var_623_6 = utf8.len(var_623_4)
				local var_623_7 = var_623_5 <= 0 and var_623_1 or var_623_1 * (var_623_6 / var_623_5)

				if var_623_7 > 0 and var_623_1 < var_623_7 then
					arg_620_1.talkMaxDuration = var_623_7

					if var_623_7 + var_623_0 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_7 + var_623_0
					end
				end

				arg_620_1.text_.text = var_623_4
				arg_620_1.typewritter.percent = 0

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431150", "story_v_out_120431.awb") ~= 0 then
					local var_623_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431150", "story_v_out_120431.awb") / 1000

					if var_623_8 + var_623_0 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_8 + var_623_0
					end

					if var_623_3.prefab_name ~= "" and arg_620_1.actors_[var_623_3.prefab_name] ~= nil then
						local var_623_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_620_1.actors_[var_623_3.prefab_name].transform, "story_v_out_120431", "120431150", "story_v_out_120431.awb")

						arg_620_1:RecordAudio("120431150", var_623_9)
						arg_620_1:RecordAudio("120431150", var_623_9)
					else
						arg_620_1:AudioAction("play", "voice", "story_v_out_120431", "120431150", "story_v_out_120431.awb")
					end

					arg_620_1:RecordHistoryTalkVoice("story_v_out_120431", "120431150", "story_v_out_120431.awb")
				end

				arg_620_1:RecordContent(arg_620_1.text_.text)
			end

			local var_623_10 = math.max(var_623_1, arg_620_1.talkMaxDuration)

			if var_623_0 <= arg_620_1.time_ and arg_620_1.time_ < var_623_0 + var_623_10 then
				arg_620_1.typewritter.percent = (arg_620_1.time_ - var_623_0) / var_623_10

				arg_620_1.typewritter:SetDirty()
			end

			if arg_620_1.time_ >= var_623_0 + var_623_10 and arg_620_1.time_ < var_623_0 + var_623_10 + arg_623_0 then
				arg_620_1.typewritter.percent = 1

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(true)
			end
		end

		arg_620_1.nodeConfigList_ = {}

		arg_620_1:InitPlayNodeList()
	end,
	Play120431151 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 120431151
		arg_624_1.duration_ = 10.97

		local var_624_0 = {
			zh = 8.266,
			ja = 10.966
		}
		local var_624_1 = manager.audio:GetLocalizationFlag()

		if var_624_0[var_624_1] ~= nil then
			arg_624_1.duration_ = var_624_0[var_624_1]
		end

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
		end

		function arg_624_1.playNext_(arg_626_0)
			if arg_626_0 == 1 then
				arg_624_0:Play120431152(arg_624_1)
			end
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			local var_627_0 = 0
			local var_627_1 = 0.9

			if var_627_0 < arg_624_1.time_ and arg_624_1.time_ <= var_627_0 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0
				arg_624_1.dialogCg_.alpha = 1

				arg_624_1.dialog_:SetActive(true)
				SetActive(arg_624_1.leftNameGo_, true)

				local var_627_2 = arg_624_1:FormatText(StoryNameCfg[6].name)

				arg_624_1.leftNameTxt_.text = var_627_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_624_1.leftNameTxt_.transform)

				arg_624_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_624_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_624_1:RecordName(arg_624_1.leftNameTxt_.text)
				SetActive(arg_624_1.iconTrs_.gameObject, false)
				arg_624_1.callingController_:SetSelectedState("normal")

				local var_627_3 = arg_624_1:GetWordFromCfg(120431151)
				local var_627_4 = arg_624_1:FormatText(var_627_3.content)

				arg_624_1.text_.text = var_627_4

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.text_)

				local var_627_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431151", "story_v_out_120431.awb") ~= 0 then
					local var_627_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431151", "story_v_out_120431.awb") / 1000

					if var_627_8 + var_627_0 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_8 + var_627_0
					end

					if var_627_3.prefab_name ~= "" and arg_624_1.actors_[var_627_3.prefab_name] ~= nil then
						local var_627_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_624_1.actors_[var_627_3.prefab_name].transform, "story_v_out_120431", "120431151", "story_v_out_120431.awb")

						arg_624_1:RecordAudio("120431151", var_627_9)
						arg_624_1:RecordAudio("120431151", var_627_9)
					else
						arg_624_1:AudioAction("play", "voice", "story_v_out_120431", "120431151", "story_v_out_120431.awb")
					end

					arg_624_1:RecordHistoryTalkVoice("story_v_out_120431", "120431151", "story_v_out_120431.awb")
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

		arg_624_1.nodeConfigList_ = {}

		arg_624_1:InitPlayNodeList()
	end,
	Play120431152 = function(arg_628_0, arg_628_1)
		arg_628_1.time_ = 0
		arg_628_1.frameCnt_ = 0
		arg_628_1.state_ = "playing"
		arg_628_1.curTalkId_ = 120431152
		arg_628_1.duration_ = 14.37

		local var_628_0 = {
			zh = 11.666,
			ja = 14.366
		}
		local var_628_1 = manager.audio:GetLocalizationFlag()

		if var_628_0[var_628_1] ~= nil then
			arg_628_1.duration_ = var_628_0[var_628_1]
		end

		SetActive(arg_628_1.tipsGo_, false)

		function arg_628_1.onSingleLineFinish_()
			arg_628_1.onSingleLineUpdate_ = nil
			arg_628_1.onSingleLineFinish_ = nil
			arg_628_1.state_ = "waiting"
		end

		function arg_628_1.playNext_(arg_630_0)
			if arg_630_0 == 1 then
				arg_628_0:Play120431153(arg_628_1)
			end
		end

		function arg_628_1.onSingleLineUpdate_(arg_631_0)
			local var_631_0 = 0
			local var_631_1 = 1.175

			if var_631_0 < arg_628_1.time_ and arg_628_1.time_ <= var_631_0 + arg_631_0 then
				arg_628_1.talkMaxDuration = 0
				arg_628_1.dialogCg_.alpha = 1

				arg_628_1.dialog_:SetActive(true)
				SetActive(arg_628_1.leftNameGo_, true)

				local var_631_2 = arg_628_1:FormatText(StoryNameCfg[6].name)

				arg_628_1.leftNameTxt_.text = var_631_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_628_1.leftNameTxt_.transform)

				arg_628_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_628_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_628_1:RecordName(arg_628_1.leftNameTxt_.text)
				SetActive(arg_628_1.iconTrs_.gameObject, false)
				arg_628_1.callingController_:SetSelectedState("normal")

				local var_631_3 = arg_628_1:GetWordFromCfg(120431152)
				local var_631_4 = arg_628_1:FormatText(var_631_3.content)

				arg_628_1.text_.text = var_631_4

				LuaForUtil.ClearLinePrefixSymbol(arg_628_1.text_)

				local var_631_5 = 47
				local var_631_6 = utf8.len(var_631_4)
				local var_631_7 = var_631_5 <= 0 and var_631_1 or var_631_1 * (var_631_6 / var_631_5)

				if var_631_7 > 0 and var_631_1 < var_631_7 then
					arg_628_1.talkMaxDuration = var_631_7

					if var_631_7 + var_631_0 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_7 + var_631_0
					end
				end

				arg_628_1.text_.text = var_631_4
				arg_628_1.typewritter.percent = 0

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431152", "story_v_out_120431.awb") ~= 0 then
					local var_631_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431152", "story_v_out_120431.awb") / 1000

					if var_631_8 + var_631_0 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_8 + var_631_0
					end

					if var_631_3.prefab_name ~= "" and arg_628_1.actors_[var_631_3.prefab_name] ~= nil then
						local var_631_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_628_1.actors_[var_631_3.prefab_name].transform, "story_v_out_120431", "120431152", "story_v_out_120431.awb")

						arg_628_1:RecordAudio("120431152", var_631_9)
						arg_628_1:RecordAudio("120431152", var_631_9)
					else
						arg_628_1:AudioAction("play", "voice", "story_v_out_120431", "120431152", "story_v_out_120431.awb")
					end

					arg_628_1:RecordHistoryTalkVoice("story_v_out_120431", "120431152", "story_v_out_120431.awb")
				end

				arg_628_1:RecordContent(arg_628_1.text_.text)
			end

			local var_631_10 = math.max(var_631_1, arg_628_1.talkMaxDuration)

			if var_631_0 <= arg_628_1.time_ and arg_628_1.time_ < var_631_0 + var_631_10 then
				arg_628_1.typewritter.percent = (arg_628_1.time_ - var_631_0) / var_631_10

				arg_628_1.typewritter:SetDirty()
			end

			if arg_628_1.time_ >= var_631_0 + var_631_10 and arg_628_1.time_ < var_631_0 + var_631_10 + arg_631_0 then
				arg_628_1.typewritter.percent = 1

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(true)
			end
		end

		arg_628_1.nodeConfigList_ = {}

		arg_628_1:InitPlayNodeList()
	end,
	Play120431153 = function(arg_632_0, arg_632_1)
		arg_632_1.time_ = 0
		arg_632_1.frameCnt_ = 0
		arg_632_1.state_ = "playing"
		arg_632_1.curTalkId_ = 120431153
		arg_632_1.duration_ = 2.1

		local var_632_0 = {
			zh = 1.433,
			ja = 2.1
		}
		local var_632_1 = manager.audio:GetLocalizationFlag()

		if var_632_0[var_632_1] ~= nil then
			arg_632_1.duration_ = var_632_0[var_632_1]
		end

		SetActive(arg_632_1.tipsGo_, false)

		function arg_632_1.onSingleLineFinish_()
			arg_632_1.onSingleLineUpdate_ = nil
			arg_632_1.onSingleLineFinish_ = nil
			arg_632_1.state_ = "waiting"
		end

		function arg_632_1.playNext_(arg_634_0)
			if arg_634_0 == 1 then
				arg_632_0:Play120431154(arg_632_1)
			end
		end

		function arg_632_1.onSingleLineUpdate_(arg_635_0)
			local var_635_0 = 0
			local var_635_1 = 0.1

			if var_635_0 < arg_632_1.time_ and arg_632_1.time_ <= var_635_0 + arg_635_0 then
				arg_632_1.talkMaxDuration = 0
				arg_632_1.dialogCg_.alpha = 1

				arg_632_1.dialog_:SetActive(true)
				SetActive(arg_632_1.leftNameGo_, true)

				local var_635_2 = arg_632_1:FormatText(StoryNameCfg[389].name)

				arg_632_1.leftNameTxt_.text = var_635_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_632_1.leftNameTxt_.transform)

				arg_632_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_632_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_632_1:RecordName(arg_632_1.leftNameTxt_.text)
				SetActive(arg_632_1.iconTrs_.gameObject, false)
				arg_632_1.callingController_:SetSelectedState("normal")

				local var_635_3 = arg_632_1:GetWordFromCfg(120431153)
				local var_635_4 = arg_632_1:FormatText(var_635_3.content)

				arg_632_1.text_.text = var_635_4

				LuaForUtil.ClearLinePrefixSymbol(arg_632_1.text_)

				local var_635_5 = 4
				local var_635_6 = utf8.len(var_635_4)
				local var_635_7 = var_635_5 <= 0 and var_635_1 or var_635_1 * (var_635_6 / var_635_5)

				if var_635_7 > 0 and var_635_1 < var_635_7 then
					arg_632_1.talkMaxDuration = var_635_7

					if var_635_7 + var_635_0 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_7 + var_635_0
					end
				end

				arg_632_1.text_.text = var_635_4
				arg_632_1.typewritter.percent = 0

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431153", "story_v_out_120431.awb") ~= 0 then
					local var_635_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431153", "story_v_out_120431.awb") / 1000

					if var_635_8 + var_635_0 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_8 + var_635_0
					end

					if var_635_3.prefab_name ~= "" and arg_632_1.actors_[var_635_3.prefab_name] ~= nil then
						local var_635_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_632_1.actors_[var_635_3.prefab_name].transform, "story_v_out_120431", "120431153", "story_v_out_120431.awb")

						arg_632_1:RecordAudio("120431153", var_635_9)
						arg_632_1:RecordAudio("120431153", var_635_9)
					else
						arg_632_1:AudioAction("play", "voice", "story_v_out_120431", "120431153", "story_v_out_120431.awb")
					end

					arg_632_1:RecordHistoryTalkVoice("story_v_out_120431", "120431153", "story_v_out_120431.awb")
				end

				arg_632_1:RecordContent(arg_632_1.text_.text)
			end

			local var_635_10 = math.max(var_635_1, arg_632_1.talkMaxDuration)

			if var_635_0 <= arg_632_1.time_ and arg_632_1.time_ < var_635_0 + var_635_10 then
				arg_632_1.typewritter.percent = (arg_632_1.time_ - var_635_0) / var_635_10

				arg_632_1.typewritter:SetDirty()
			end

			if arg_632_1.time_ >= var_635_0 + var_635_10 and arg_632_1.time_ < var_635_0 + var_635_10 + arg_635_0 then
				arg_632_1.typewritter.percent = 1

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(true)
			end
		end

		arg_632_1.nodeConfigList_ = {}

		arg_632_1:InitPlayNodeList()
	end,
	Play120431154 = function(arg_636_0, arg_636_1)
		arg_636_1.time_ = 0
		arg_636_1.frameCnt_ = 0
		arg_636_1.state_ = "playing"
		arg_636_1.curTalkId_ = 120431154
		arg_636_1.duration_ = 4.53

		local var_636_0 = {
			zh = 4.166,
			ja = 4.533
		}
		local var_636_1 = manager.audio:GetLocalizationFlag()

		if var_636_0[var_636_1] ~= nil then
			arg_636_1.duration_ = var_636_0[var_636_1]
		end

		SetActive(arg_636_1.tipsGo_, false)

		function arg_636_1.onSingleLineFinish_()
			arg_636_1.onSingleLineUpdate_ = nil
			arg_636_1.onSingleLineFinish_ = nil
			arg_636_1.state_ = "waiting"
		end

		function arg_636_1.playNext_(arg_638_0)
			if arg_638_0 == 1 then
				arg_636_0:Play120431155(arg_636_1)
			end
		end

		function arg_636_1.onSingleLineUpdate_(arg_639_0)
			local var_639_0 = 0
			local var_639_1 = 0.5

			if var_639_0 < arg_636_1.time_ and arg_636_1.time_ <= var_639_0 + arg_639_0 then
				arg_636_1.talkMaxDuration = 0
				arg_636_1.dialogCg_.alpha = 1

				arg_636_1.dialog_:SetActive(true)
				SetActive(arg_636_1.leftNameGo_, true)

				local var_639_2 = arg_636_1:FormatText(StoryNameCfg[6].name)

				arg_636_1.leftNameTxt_.text = var_639_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_636_1.leftNameTxt_.transform)

				arg_636_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_636_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_636_1:RecordName(arg_636_1.leftNameTxt_.text)
				SetActive(arg_636_1.iconTrs_.gameObject, false)
				arg_636_1.callingController_:SetSelectedState("normal")

				local var_639_3 = arg_636_1:GetWordFromCfg(120431154)
				local var_639_4 = arg_636_1:FormatText(var_639_3.content)

				arg_636_1.text_.text = var_639_4

				LuaForUtil.ClearLinePrefixSymbol(arg_636_1.text_)

				local var_639_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431154", "story_v_out_120431.awb") ~= 0 then
					local var_639_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431154", "story_v_out_120431.awb") / 1000

					if var_639_8 + var_639_0 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_8 + var_639_0
					end

					if var_639_3.prefab_name ~= "" and arg_636_1.actors_[var_639_3.prefab_name] ~= nil then
						local var_639_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_636_1.actors_[var_639_3.prefab_name].transform, "story_v_out_120431", "120431154", "story_v_out_120431.awb")

						arg_636_1:RecordAudio("120431154", var_639_9)
						arg_636_1:RecordAudio("120431154", var_639_9)
					else
						arg_636_1:AudioAction("play", "voice", "story_v_out_120431", "120431154", "story_v_out_120431.awb")
					end

					arg_636_1:RecordHistoryTalkVoice("story_v_out_120431", "120431154", "story_v_out_120431.awb")
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
	Play120431155 = function(arg_640_0, arg_640_1)
		arg_640_1.time_ = 0
		arg_640_1.frameCnt_ = 0
		arg_640_1.state_ = "playing"
		arg_640_1.curTalkId_ = 120431155
		arg_640_1.duration_ = 4

		local var_640_0 = {
			zh = 2.333,
			ja = 4
		}
		local var_640_1 = manager.audio:GetLocalizationFlag()

		if var_640_0[var_640_1] ~= nil then
			arg_640_1.duration_ = var_640_0[var_640_1]
		end

		SetActive(arg_640_1.tipsGo_, false)

		function arg_640_1.onSingleLineFinish_()
			arg_640_1.onSingleLineUpdate_ = nil
			arg_640_1.onSingleLineFinish_ = nil
			arg_640_1.state_ = "waiting"
		end

		function arg_640_1.playNext_(arg_642_0)
			if arg_642_0 == 1 then
				arg_640_0:Play120431156(arg_640_1)
			end
		end

		function arg_640_1.onSingleLineUpdate_(arg_643_0)
			local var_643_0 = 0
			local var_643_1 = 0.25

			if var_643_0 < arg_640_1.time_ and arg_640_1.time_ <= var_643_0 + arg_643_0 then
				arg_640_1.talkMaxDuration = 0
				arg_640_1.dialogCg_.alpha = 1

				arg_640_1.dialog_:SetActive(true)
				SetActive(arg_640_1.leftNameGo_, true)

				local var_643_2 = arg_640_1:FormatText(StoryNameCfg[389].name)

				arg_640_1.leftNameTxt_.text = var_643_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_640_1.leftNameTxt_.transform)

				arg_640_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_640_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_640_1:RecordName(arg_640_1.leftNameTxt_.text)
				SetActive(arg_640_1.iconTrs_.gameObject, false)
				arg_640_1.callingController_:SetSelectedState("normal")

				local var_643_3 = arg_640_1:GetWordFromCfg(120431155)
				local var_643_4 = arg_640_1:FormatText(var_643_3.content)

				arg_640_1.text_.text = var_643_4

				LuaForUtil.ClearLinePrefixSymbol(arg_640_1.text_)

				local var_643_5 = 10
				local var_643_6 = utf8.len(var_643_4)
				local var_643_7 = var_643_5 <= 0 and var_643_1 or var_643_1 * (var_643_6 / var_643_5)

				if var_643_7 > 0 and var_643_1 < var_643_7 then
					arg_640_1.talkMaxDuration = var_643_7

					if var_643_7 + var_643_0 > arg_640_1.duration_ then
						arg_640_1.duration_ = var_643_7 + var_643_0
					end
				end

				arg_640_1.text_.text = var_643_4
				arg_640_1.typewritter.percent = 0

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431155", "story_v_out_120431.awb") ~= 0 then
					local var_643_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431155", "story_v_out_120431.awb") / 1000

					if var_643_8 + var_643_0 > arg_640_1.duration_ then
						arg_640_1.duration_ = var_643_8 + var_643_0
					end

					if var_643_3.prefab_name ~= "" and arg_640_1.actors_[var_643_3.prefab_name] ~= nil then
						local var_643_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_640_1.actors_[var_643_3.prefab_name].transform, "story_v_out_120431", "120431155", "story_v_out_120431.awb")

						arg_640_1:RecordAudio("120431155", var_643_9)
						arg_640_1:RecordAudio("120431155", var_643_9)
					else
						arg_640_1:AudioAction("play", "voice", "story_v_out_120431", "120431155", "story_v_out_120431.awb")
					end

					arg_640_1:RecordHistoryTalkVoice("story_v_out_120431", "120431155", "story_v_out_120431.awb")
				end

				arg_640_1:RecordContent(arg_640_1.text_.text)
			end

			local var_643_10 = math.max(var_643_1, arg_640_1.talkMaxDuration)

			if var_643_0 <= arg_640_1.time_ and arg_640_1.time_ < var_643_0 + var_643_10 then
				arg_640_1.typewritter.percent = (arg_640_1.time_ - var_643_0) / var_643_10

				arg_640_1.typewritter:SetDirty()
			end

			if arg_640_1.time_ >= var_643_0 + var_643_10 and arg_640_1.time_ < var_643_0 + var_643_10 + arg_643_0 then
				arg_640_1.typewritter.percent = 1

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(true)
			end
		end

		arg_640_1.nodeConfigList_ = {}

		arg_640_1:InitPlayNodeList()
	end,
	Play120431156 = function(arg_644_0, arg_644_1)
		arg_644_1.time_ = 0
		arg_644_1.frameCnt_ = 0
		arg_644_1.state_ = "playing"
		arg_644_1.curTalkId_ = 120431156
		arg_644_1.duration_ = 16.7

		local var_644_0 = {
			zh = 10.133,
			ja = 16.7
		}
		local var_644_1 = manager.audio:GetLocalizationFlag()

		if var_644_0[var_644_1] ~= nil then
			arg_644_1.duration_ = var_644_0[var_644_1]
		end

		SetActive(arg_644_1.tipsGo_, false)

		function arg_644_1.onSingleLineFinish_()
			arg_644_1.onSingleLineUpdate_ = nil
			arg_644_1.onSingleLineFinish_ = nil
			arg_644_1.state_ = "waiting"
		end

		function arg_644_1.playNext_(arg_646_0)
			if arg_646_0 == 1 then
				arg_644_0:Play120431157(arg_644_1)
			end
		end

		function arg_644_1.onSingleLineUpdate_(arg_647_0)
			local var_647_0 = 0
			local var_647_1 = 0.975

			if var_647_0 < arg_644_1.time_ and arg_644_1.time_ <= var_647_0 + arg_647_0 then
				arg_644_1.talkMaxDuration = 0
				arg_644_1.dialogCg_.alpha = 1

				arg_644_1.dialog_:SetActive(true)
				SetActive(arg_644_1.leftNameGo_, true)

				local var_647_2 = arg_644_1:FormatText(StoryNameCfg[389].name)

				arg_644_1.leftNameTxt_.text = var_647_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_644_1.leftNameTxt_.transform)

				arg_644_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_644_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_644_1:RecordName(arg_644_1.leftNameTxt_.text)
				SetActive(arg_644_1.iconTrs_.gameObject, false)
				arg_644_1.callingController_:SetSelectedState("normal")

				local var_647_3 = arg_644_1:GetWordFromCfg(120431156)
				local var_647_4 = arg_644_1:FormatText(var_647_3.content)

				arg_644_1.text_.text = var_647_4

				LuaForUtil.ClearLinePrefixSymbol(arg_644_1.text_)

				local var_647_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431156", "story_v_out_120431.awb") ~= 0 then
					local var_647_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431156", "story_v_out_120431.awb") / 1000

					if var_647_8 + var_647_0 > arg_644_1.duration_ then
						arg_644_1.duration_ = var_647_8 + var_647_0
					end

					if var_647_3.prefab_name ~= "" and arg_644_1.actors_[var_647_3.prefab_name] ~= nil then
						local var_647_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_644_1.actors_[var_647_3.prefab_name].transform, "story_v_out_120431", "120431156", "story_v_out_120431.awb")

						arg_644_1:RecordAudio("120431156", var_647_9)
						arg_644_1:RecordAudio("120431156", var_647_9)
					else
						arg_644_1:AudioAction("play", "voice", "story_v_out_120431", "120431156", "story_v_out_120431.awb")
					end

					arg_644_1:RecordHistoryTalkVoice("story_v_out_120431", "120431156", "story_v_out_120431.awb")
				end

				arg_644_1:RecordContent(arg_644_1.text_.text)
			end

			local var_647_10 = math.max(var_647_1, arg_644_1.talkMaxDuration)

			if var_647_0 <= arg_644_1.time_ and arg_644_1.time_ < var_647_0 + var_647_10 then
				arg_644_1.typewritter.percent = (arg_644_1.time_ - var_647_0) / var_647_10

				arg_644_1.typewritter:SetDirty()
			end

			if arg_644_1.time_ >= var_647_0 + var_647_10 and arg_644_1.time_ < var_647_0 + var_647_10 + arg_647_0 then
				arg_644_1.typewritter.percent = 1

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(true)
			end
		end

		arg_644_1.nodeConfigList_ = {}

		arg_644_1:InitPlayNodeList()
	end,
	Play120431157 = function(arg_648_0, arg_648_1)
		arg_648_1.time_ = 0
		arg_648_1.frameCnt_ = 0
		arg_648_1.state_ = "playing"
		arg_648_1.curTalkId_ = 120431157
		arg_648_1.duration_ = 20.87

		local var_648_0 = {
			zh = 7.666,
			ja = 20.866
		}
		local var_648_1 = manager.audio:GetLocalizationFlag()

		if var_648_0[var_648_1] ~= nil then
			arg_648_1.duration_ = var_648_0[var_648_1]
		end

		SetActive(arg_648_1.tipsGo_, false)

		function arg_648_1.onSingleLineFinish_()
			arg_648_1.onSingleLineUpdate_ = nil
			arg_648_1.onSingleLineFinish_ = nil
			arg_648_1.state_ = "waiting"
		end

		function arg_648_1.playNext_(arg_650_0)
			if arg_650_0 == 1 then
				arg_648_0:Play120431158(arg_648_1)
			end
		end

		function arg_648_1.onSingleLineUpdate_(arg_651_0)
			local var_651_0 = 0
			local var_651_1 = 0.775

			if var_651_0 < arg_648_1.time_ and arg_648_1.time_ <= var_651_0 + arg_651_0 then
				arg_648_1.talkMaxDuration = 0
				arg_648_1.dialogCg_.alpha = 1

				arg_648_1.dialog_:SetActive(true)
				SetActive(arg_648_1.leftNameGo_, true)

				local var_651_2 = arg_648_1:FormatText(StoryNameCfg[389].name)

				arg_648_1.leftNameTxt_.text = var_651_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_648_1.leftNameTxt_.transform)

				arg_648_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_648_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_648_1:RecordName(arg_648_1.leftNameTxt_.text)
				SetActive(arg_648_1.iconTrs_.gameObject, false)
				arg_648_1.callingController_:SetSelectedState("normal")

				local var_651_3 = arg_648_1:GetWordFromCfg(120431157)
				local var_651_4 = arg_648_1:FormatText(var_651_3.content)

				arg_648_1.text_.text = var_651_4

				LuaForUtil.ClearLinePrefixSymbol(arg_648_1.text_)

				local var_651_5 = 31
				local var_651_6 = utf8.len(var_651_4)
				local var_651_7 = var_651_5 <= 0 and var_651_1 or var_651_1 * (var_651_6 / var_651_5)

				if var_651_7 > 0 and var_651_1 < var_651_7 then
					arg_648_1.talkMaxDuration = var_651_7

					if var_651_7 + var_651_0 > arg_648_1.duration_ then
						arg_648_1.duration_ = var_651_7 + var_651_0
					end
				end

				arg_648_1.text_.text = var_651_4
				arg_648_1.typewritter.percent = 0

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431157", "story_v_out_120431.awb") ~= 0 then
					local var_651_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431157", "story_v_out_120431.awb") / 1000

					if var_651_8 + var_651_0 > arg_648_1.duration_ then
						arg_648_1.duration_ = var_651_8 + var_651_0
					end

					if var_651_3.prefab_name ~= "" and arg_648_1.actors_[var_651_3.prefab_name] ~= nil then
						local var_651_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_648_1.actors_[var_651_3.prefab_name].transform, "story_v_out_120431", "120431157", "story_v_out_120431.awb")

						arg_648_1:RecordAudio("120431157", var_651_9)
						arg_648_1:RecordAudio("120431157", var_651_9)
					else
						arg_648_1:AudioAction("play", "voice", "story_v_out_120431", "120431157", "story_v_out_120431.awb")
					end

					arg_648_1:RecordHistoryTalkVoice("story_v_out_120431", "120431157", "story_v_out_120431.awb")
				end

				arg_648_1:RecordContent(arg_648_1.text_.text)
			end

			local var_651_10 = math.max(var_651_1, arg_648_1.talkMaxDuration)

			if var_651_0 <= arg_648_1.time_ and arg_648_1.time_ < var_651_0 + var_651_10 then
				arg_648_1.typewritter.percent = (arg_648_1.time_ - var_651_0) / var_651_10

				arg_648_1.typewritter:SetDirty()
			end

			if arg_648_1.time_ >= var_651_0 + var_651_10 and arg_648_1.time_ < var_651_0 + var_651_10 + arg_651_0 then
				arg_648_1.typewritter.percent = 1

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(true)
			end
		end

		arg_648_1.nodeConfigList_ = {}

		arg_648_1:InitPlayNodeList()
	end,
	Play120431158 = function(arg_652_0, arg_652_1)
		arg_652_1.time_ = 0
		arg_652_1.frameCnt_ = 0
		arg_652_1.state_ = "playing"
		arg_652_1.curTalkId_ = 120431158
		arg_652_1.duration_ = 13.2

		local var_652_0 = {
			zh = 9.766,
			ja = 13.2
		}
		local var_652_1 = manager.audio:GetLocalizationFlag()

		if var_652_0[var_652_1] ~= nil then
			arg_652_1.duration_ = var_652_0[var_652_1]
		end

		SetActive(arg_652_1.tipsGo_, false)

		function arg_652_1.onSingleLineFinish_()
			arg_652_1.onSingleLineUpdate_ = nil
			arg_652_1.onSingleLineFinish_ = nil
			arg_652_1.state_ = "waiting"
		end

		function arg_652_1.playNext_(arg_654_0)
			if arg_654_0 == 1 then
				arg_652_0:Play120431159(arg_652_1)
			end
		end

		function arg_652_1.onSingleLineUpdate_(arg_655_0)
			local var_655_0 = 0
			local var_655_1 = 1.1

			if var_655_0 < arg_652_1.time_ and arg_652_1.time_ <= var_655_0 + arg_655_0 then
				arg_652_1.talkMaxDuration = 0
				arg_652_1.dialogCg_.alpha = 1

				arg_652_1.dialog_:SetActive(true)
				SetActive(arg_652_1.leftNameGo_, true)

				local var_655_2 = arg_652_1:FormatText(StoryNameCfg[6].name)

				arg_652_1.leftNameTxt_.text = var_655_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_652_1.leftNameTxt_.transform)

				arg_652_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_652_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_652_1:RecordName(arg_652_1.leftNameTxt_.text)
				SetActive(arg_652_1.iconTrs_.gameObject, false)
				arg_652_1.callingController_:SetSelectedState("normal")

				local var_655_3 = arg_652_1:GetWordFromCfg(120431158)
				local var_655_4 = arg_652_1:FormatText(var_655_3.content)

				arg_652_1.text_.text = var_655_4

				LuaForUtil.ClearLinePrefixSymbol(arg_652_1.text_)

				local var_655_5 = 44
				local var_655_6 = utf8.len(var_655_4)
				local var_655_7 = var_655_5 <= 0 and var_655_1 or var_655_1 * (var_655_6 / var_655_5)

				if var_655_7 > 0 and var_655_1 < var_655_7 then
					arg_652_1.talkMaxDuration = var_655_7

					if var_655_7 + var_655_0 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_7 + var_655_0
					end
				end

				arg_652_1.text_.text = var_655_4
				arg_652_1.typewritter.percent = 0

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431158", "story_v_out_120431.awb") ~= 0 then
					local var_655_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431158", "story_v_out_120431.awb") / 1000

					if var_655_8 + var_655_0 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_8 + var_655_0
					end

					if var_655_3.prefab_name ~= "" and arg_652_1.actors_[var_655_3.prefab_name] ~= nil then
						local var_655_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_652_1.actors_[var_655_3.prefab_name].transform, "story_v_out_120431", "120431158", "story_v_out_120431.awb")

						arg_652_1:RecordAudio("120431158", var_655_9)
						arg_652_1:RecordAudio("120431158", var_655_9)
					else
						arg_652_1:AudioAction("play", "voice", "story_v_out_120431", "120431158", "story_v_out_120431.awb")
					end

					arg_652_1:RecordHistoryTalkVoice("story_v_out_120431", "120431158", "story_v_out_120431.awb")
				end

				arg_652_1:RecordContent(arg_652_1.text_.text)
			end

			local var_655_10 = math.max(var_655_1, arg_652_1.talkMaxDuration)

			if var_655_0 <= arg_652_1.time_ and arg_652_1.time_ < var_655_0 + var_655_10 then
				arg_652_1.typewritter.percent = (arg_652_1.time_ - var_655_0) / var_655_10

				arg_652_1.typewritter:SetDirty()
			end

			if arg_652_1.time_ >= var_655_0 + var_655_10 and arg_652_1.time_ < var_655_0 + var_655_10 + arg_655_0 then
				arg_652_1.typewritter.percent = 1

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(true)
			end
		end

		arg_652_1.nodeConfigList_ = {}

		arg_652_1:InitPlayNodeList()
	end,
	Play120431159 = function(arg_656_0, arg_656_1)
		arg_656_1.time_ = 0
		arg_656_1.frameCnt_ = 0
		arg_656_1.state_ = "playing"
		arg_656_1.curTalkId_ = 120431159
		arg_656_1.duration_ = 11.67

		local var_656_0 = {
			zh = 10.666,
			ja = 11.666
		}
		local var_656_1 = manager.audio:GetLocalizationFlag()

		if var_656_0[var_656_1] ~= nil then
			arg_656_1.duration_ = var_656_0[var_656_1]
		end

		SetActive(arg_656_1.tipsGo_, false)

		function arg_656_1.onSingleLineFinish_()
			arg_656_1.onSingleLineUpdate_ = nil
			arg_656_1.onSingleLineFinish_ = nil
			arg_656_1.state_ = "waiting"
		end

		function arg_656_1.playNext_(arg_658_0)
			if arg_658_0 == 1 then
				arg_656_0:Play120431160(arg_656_1)
			end
		end

		function arg_656_1.onSingleLineUpdate_(arg_659_0)
			local var_659_0 = 0
			local var_659_1 = 0.75

			if var_659_0 < arg_656_1.time_ and arg_656_1.time_ <= var_659_0 + arg_659_0 then
				arg_656_1.talkMaxDuration = 0
				arg_656_1.dialogCg_.alpha = 1

				arg_656_1.dialog_:SetActive(true)
				SetActive(arg_656_1.leftNameGo_, true)

				local var_659_2 = arg_656_1:FormatText(StoryNameCfg[389].name)

				arg_656_1.leftNameTxt_.text = var_659_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_656_1.leftNameTxt_.transform)

				arg_656_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_656_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_656_1:RecordName(arg_656_1.leftNameTxt_.text)
				SetActive(arg_656_1.iconTrs_.gameObject, false)
				arg_656_1.callingController_:SetSelectedState("normal")

				local var_659_3 = arg_656_1:GetWordFromCfg(120431159)
				local var_659_4 = arg_656_1:FormatText(var_659_3.content)

				arg_656_1.text_.text = var_659_4

				LuaForUtil.ClearLinePrefixSymbol(arg_656_1.text_)

				local var_659_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431159", "story_v_out_120431.awb") ~= 0 then
					local var_659_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431159", "story_v_out_120431.awb") / 1000

					if var_659_8 + var_659_0 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_8 + var_659_0
					end

					if var_659_3.prefab_name ~= "" and arg_656_1.actors_[var_659_3.prefab_name] ~= nil then
						local var_659_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_656_1.actors_[var_659_3.prefab_name].transform, "story_v_out_120431", "120431159", "story_v_out_120431.awb")

						arg_656_1:RecordAudio("120431159", var_659_9)
						arg_656_1:RecordAudio("120431159", var_659_9)
					else
						arg_656_1:AudioAction("play", "voice", "story_v_out_120431", "120431159", "story_v_out_120431.awb")
					end

					arg_656_1:RecordHistoryTalkVoice("story_v_out_120431", "120431159", "story_v_out_120431.awb")
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
	Play120431160 = function(arg_660_0, arg_660_1)
		arg_660_1.time_ = 0
		arg_660_1.frameCnt_ = 0
		arg_660_1.state_ = "playing"
		arg_660_1.curTalkId_ = 120431160
		arg_660_1.duration_ = 16.17

		local var_660_0 = {
			zh = 11,
			ja = 16.166
		}
		local var_660_1 = manager.audio:GetLocalizationFlag()

		if var_660_0[var_660_1] ~= nil then
			arg_660_1.duration_ = var_660_0[var_660_1]
		end

		SetActive(arg_660_1.tipsGo_, false)

		function arg_660_1.onSingleLineFinish_()
			arg_660_1.onSingleLineUpdate_ = nil
			arg_660_1.onSingleLineFinish_ = nil
			arg_660_1.state_ = "waiting"
		end

		function arg_660_1.playNext_(arg_662_0)
			if arg_662_0 == 1 then
				arg_660_0:Play120431161(arg_660_1)
			end
		end

		function arg_660_1.onSingleLineUpdate_(arg_663_0)
			local var_663_0 = 0
			local var_663_1 = 1.1

			if var_663_0 < arg_660_1.time_ and arg_660_1.time_ <= var_663_0 + arg_663_0 then
				arg_660_1.talkMaxDuration = 0
				arg_660_1.dialogCg_.alpha = 1

				arg_660_1.dialog_:SetActive(true)
				SetActive(arg_660_1.leftNameGo_, true)

				local var_663_2 = arg_660_1:FormatText(StoryNameCfg[389].name)

				arg_660_1.leftNameTxt_.text = var_663_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_660_1.leftNameTxt_.transform)

				arg_660_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_660_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_660_1:RecordName(arg_660_1.leftNameTxt_.text)
				SetActive(arg_660_1.iconTrs_.gameObject, false)
				arg_660_1.callingController_:SetSelectedState("normal")

				local var_663_3 = arg_660_1:GetWordFromCfg(120431160)
				local var_663_4 = arg_660_1:FormatText(var_663_3.content)

				arg_660_1.text_.text = var_663_4

				LuaForUtil.ClearLinePrefixSymbol(arg_660_1.text_)

				local var_663_5 = 44
				local var_663_6 = utf8.len(var_663_4)
				local var_663_7 = var_663_5 <= 0 and var_663_1 or var_663_1 * (var_663_6 / var_663_5)

				if var_663_7 > 0 and var_663_1 < var_663_7 then
					arg_660_1.talkMaxDuration = var_663_7

					if var_663_7 + var_663_0 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_7 + var_663_0
					end
				end

				arg_660_1.text_.text = var_663_4
				arg_660_1.typewritter.percent = 0

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431160", "story_v_out_120431.awb") ~= 0 then
					local var_663_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431160", "story_v_out_120431.awb") / 1000

					if var_663_8 + var_663_0 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_8 + var_663_0
					end

					if var_663_3.prefab_name ~= "" and arg_660_1.actors_[var_663_3.prefab_name] ~= nil then
						local var_663_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_660_1.actors_[var_663_3.prefab_name].transform, "story_v_out_120431", "120431160", "story_v_out_120431.awb")

						arg_660_1:RecordAudio("120431160", var_663_9)
						arg_660_1:RecordAudio("120431160", var_663_9)
					else
						arg_660_1:AudioAction("play", "voice", "story_v_out_120431", "120431160", "story_v_out_120431.awb")
					end

					arg_660_1:RecordHistoryTalkVoice("story_v_out_120431", "120431160", "story_v_out_120431.awb")
				end

				arg_660_1:RecordContent(arg_660_1.text_.text)
			end

			local var_663_10 = math.max(var_663_1, arg_660_1.talkMaxDuration)

			if var_663_0 <= arg_660_1.time_ and arg_660_1.time_ < var_663_0 + var_663_10 then
				arg_660_1.typewritter.percent = (arg_660_1.time_ - var_663_0) / var_663_10

				arg_660_1.typewritter:SetDirty()
			end

			if arg_660_1.time_ >= var_663_0 + var_663_10 and arg_660_1.time_ < var_663_0 + var_663_10 + arg_663_0 then
				arg_660_1.typewritter.percent = 1

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(true)
			end
		end

		arg_660_1.nodeConfigList_ = {}

		arg_660_1:InitPlayNodeList()
	end,
	Play120431161 = function(arg_664_0, arg_664_1)
		arg_664_1.time_ = 0
		arg_664_1.frameCnt_ = 0
		arg_664_1.state_ = "playing"
		arg_664_1.curTalkId_ = 120431161
		arg_664_1.duration_ = 2.7

		local var_664_0 = {
			zh = 1.766,
			ja = 2.7
		}
		local var_664_1 = manager.audio:GetLocalizationFlag()

		if var_664_0[var_664_1] ~= nil then
			arg_664_1.duration_ = var_664_0[var_664_1]
		end

		SetActive(arg_664_1.tipsGo_, false)

		function arg_664_1.onSingleLineFinish_()
			arg_664_1.onSingleLineUpdate_ = nil
			arg_664_1.onSingleLineFinish_ = nil
			arg_664_1.state_ = "waiting"
		end

		function arg_664_1.playNext_(arg_666_0)
			if arg_666_0 == 1 then
				arg_664_0:Play120431162(arg_664_1)
			end
		end

		function arg_664_1.onSingleLineUpdate_(arg_667_0)
			local var_667_0 = 0
			local var_667_1 = 0.125

			if var_667_0 < arg_664_1.time_ and arg_664_1.time_ <= var_667_0 + arg_667_0 then
				arg_664_1.talkMaxDuration = 0
				arg_664_1.dialogCg_.alpha = 1

				arg_664_1.dialog_:SetActive(true)
				SetActive(arg_664_1.leftNameGo_, true)

				local var_667_2 = arg_664_1:FormatText(StoryNameCfg[6].name)

				arg_664_1.leftNameTxt_.text = var_667_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_664_1.leftNameTxt_.transform)

				arg_664_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_664_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_664_1:RecordName(arg_664_1.leftNameTxt_.text)
				SetActive(arg_664_1.iconTrs_.gameObject, false)
				arg_664_1.callingController_:SetSelectedState("normal")

				local var_667_3 = arg_664_1:GetWordFromCfg(120431161)
				local var_667_4 = arg_664_1:FormatText(var_667_3.content)

				arg_664_1.text_.text = var_667_4

				LuaForUtil.ClearLinePrefixSymbol(arg_664_1.text_)

				local var_667_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431161", "story_v_out_120431.awb") ~= 0 then
					local var_667_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431161", "story_v_out_120431.awb") / 1000

					if var_667_8 + var_667_0 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_8 + var_667_0
					end

					if var_667_3.prefab_name ~= "" and arg_664_1.actors_[var_667_3.prefab_name] ~= nil then
						local var_667_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_664_1.actors_[var_667_3.prefab_name].transform, "story_v_out_120431", "120431161", "story_v_out_120431.awb")

						arg_664_1:RecordAudio("120431161", var_667_9)
						arg_664_1:RecordAudio("120431161", var_667_9)
					else
						arg_664_1:AudioAction("play", "voice", "story_v_out_120431", "120431161", "story_v_out_120431.awb")
					end

					arg_664_1:RecordHistoryTalkVoice("story_v_out_120431", "120431161", "story_v_out_120431.awb")
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
	Play120431162 = function(arg_668_0, arg_668_1)
		arg_668_1.time_ = 0
		arg_668_1.frameCnt_ = 0
		arg_668_1.state_ = "playing"
		arg_668_1.curTalkId_ = 120431162
		arg_668_1.duration_ = 16.77

		local var_668_0 = {
			zh = 10.233,
			ja = 16.766
		}
		local var_668_1 = manager.audio:GetLocalizationFlag()

		if var_668_0[var_668_1] ~= nil then
			arg_668_1.duration_ = var_668_0[var_668_1]
		end

		SetActive(arg_668_1.tipsGo_, false)

		function arg_668_1.onSingleLineFinish_()
			arg_668_1.onSingleLineUpdate_ = nil
			arg_668_1.onSingleLineFinish_ = nil
			arg_668_1.state_ = "waiting"
		end

		function arg_668_1.playNext_(arg_670_0)
			if arg_670_0 == 1 then
				arg_668_0:Play120431163(arg_668_1)
			end
		end

		function arg_668_1.onSingleLineUpdate_(arg_671_0)
			local var_671_0 = 0
			local var_671_1 = 0.95

			if var_671_0 < arg_668_1.time_ and arg_668_1.time_ <= var_671_0 + arg_671_0 then
				arg_668_1.talkMaxDuration = 0
				arg_668_1.dialogCg_.alpha = 1

				arg_668_1.dialog_:SetActive(true)
				SetActive(arg_668_1.leftNameGo_, true)

				local var_671_2 = arg_668_1:FormatText(StoryNameCfg[389].name)

				arg_668_1.leftNameTxt_.text = var_671_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_668_1.leftNameTxt_.transform)

				arg_668_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_668_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_668_1:RecordName(arg_668_1.leftNameTxt_.text)
				SetActive(arg_668_1.iconTrs_.gameObject, false)
				arg_668_1.callingController_:SetSelectedState("normal")

				local var_671_3 = arg_668_1:GetWordFromCfg(120431162)
				local var_671_4 = arg_668_1:FormatText(var_671_3.content)

				arg_668_1.text_.text = var_671_4

				LuaForUtil.ClearLinePrefixSymbol(arg_668_1.text_)

				local var_671_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431162", "story_v_out_120431.awb") ~= 0 then
					local var_671_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431162", "story_v_out_120431.awb") / 1000

					if var_671_8 + var_671_0 > arg_668_1.duration_ then
						arg_668_1.duration_ = var_671_8 + var_671_0
					end

					if var_671_3.prefab_name ~= "" and arg_668_1.actors_[var_671_3.prefab_name] ~= nil then
						local var_671_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_668_1.actors_[var_671_3.prefab_name].transform, "story_v_out_120431", "120431162", "story_v_out_120431.awb")

						arg_668_1:RecordAudio("120431162", var_671_9)
						arg_668_1:RecordAudio("120431162", var_671_9)
					else
						arg_668_1:AudioAction("play", "voice", "story_v_out_120431", "120431162", "story_v_out_120431.awb")
					end

					arg_668_1:RecordHistoryTalkVoice("story_v_out_120431", "120431162", "story_v_out_120431.awb")
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
	Play120431163 = function(arg_672_0, arg_672_1)
		arg_672_1.time_ = 0
		arg_672_1.frameCnt_ = 0
		arg_672_1.state_ = "playing"
		arg_672_1.curTalkId_ = 120431163
		arg_672_1.duration_ = 11.47

		local var_672_0 = {
			zh = 9,
			ja = 11.466
		}
		local var_672_1 = manager.audio:GetLocalizationFlag()

		if var_672_0[var_672_1] ~= nil then
			arg_672_1.duration_ = var_672_0[var_672_1]
		end

		SetActive(arg_672_1.tipsGo_, false)

		function arg_672_1.onSingleLineFinish_()
			arg_672_1.onSingleLineUpdate_ = nil
			arg_672_1.onSingleLineFinish_ = nil
			arg_672_1.state_ = "waiting"
		end

		function arg_672_1.playNext_(arg_674_0)
			if arg_674_0 == 1 then
				arg_672_0:Play120431164(arg_672_1)
			end
		end

		function arg_672_1.onSingleLineUpdate_(arg_675_0)
			local var_675_0 = 0
			local var_675_1 = 0.775

			if var_675_0 < arg_672_1.time_ and arg_672_1.time_ <= var_675_0 + arg_675_0 then
				arg_672_1.talkMaxDuration = 0
				arg_672_1.dialogCg_.alpha = 1

				arg_672_1.dialog_:SetActive(true)
				SetActive(arg_672_1.leftNameGo_, true)

				local var_675_2 = arg_672_1:FormatText(StoryNameCfg[389].name)

				arg_672_1.leftNameTxt_.text = var_675_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_672_1.leftNameTxt_.transform)

				arg_672_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_672_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_672_1:RecordName(arg_672_1.leftNameTxt_.text)
				SetActive(arg_672_1.iconTrs_.gameObject, false)
				arg_672_1.callingController_:SetSelectedState("normal")

				local var_675_3 = arg_672_1:GetWordFromCfg(120431163)
				local var_675_4 = arg_672_1:FormatText(var_675_3.content)

				arg_672_1.text_.text = var_675_4

				LuaForUtil.ClearLinePrefixSymbol(arg_672_1.text_)

				local var_675_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431163", "story_v_out_120431.awb") ~= 0 then
					local var_675_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431163", "story_v_out_120431.awb") / 1000

					if var_675_8 + var_675_0 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_8 + var_675_0
					end

					if var_675_3.prefab_name ~= "" and arg_672_1.actors_[var_675_3.prefab_name] ~= nil then
						local var_675_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_672_1.actors_[var_675_3.prefab_name].transform, "story_v_out_120431", "120431163", "story_v_out_120431.awb")

						arg_672_1:RecordAudio("120431163", var_675_9)
						arg_672_1:RecordAudio("120431163", var_675_9)
					else
						arg_672_1:AudioAction("play", "voice", "story_v_out_120431", "120431163", "story_v_out_120431.awb")
					end

					arg_672_1:RecordHistoryTalkVoice("story_v_out_120431", "120431163", "story_v_out_120431.awb")
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
	Play120431164 = function(arg_676_0, arg_676_1)
		arg_676_1.time_ = 0
		arg_676_1.frameCnt_ = 0
		arg_676_1.state_ = "playing"
		arg_676_1.curTalkId_ = 120431164
		arg_676_1.duration_ = 10.07

		local var_676_0 = {
			zh = 7.133,
			ja = 10.066
		}
		local var_676_1 = manager.audio:GetLocalizationFlag()

		if var_676_0[var_676_1] ~= nil then
			arg_676_1.duration_ = var_676_0[var_676_1]
		end

		SetActive(arg_676_1.tipsGo_, false)

		function arg_676_1.onSingleLineFinish_()
			arg_676_1.onSingleLineUpdate_ = nil
			arg_676_1.onSingleLineFinish_ = nil
			arg_676_1.state_ = "waiting"
		end

		function arg_676_1.playNext_(arg_678_0)
			if arg_678_0 == 1 then
				arg_676_0:Play120431165(arg_676_1)
			end
		end

		function arg_676_1.onSingleLineUpdate_(arg_679_0)
			local var_679_0 = 0
			local var_679_1 = 0.65

			if var_679_0 < arg_676_1.time_ and arg_676_1.time_ <= var_679_0 + arg_679_0 then
				arg_676_1.talkMaxDuration = 0
				arg_676_1.dialogCg_.alpha = 1

				arg_676_1.dialog_:SetActive(true)
				SetActive(arg_676_1.leftNameGo_, true)

				local var_679_2 = arg_676_1:FormatText(StoryNameCfg[389].name)

				arg_676_1.leftNameTxt_.text = var_679_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_676_1.leftNameTxt_.transform)

				arg_676_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_676_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_676_1:RecordName(arg_676_1.leftNameTxt_.text)
				SetActive(arg_676_1.iconTrs_.gameObject, false)
				arg_676_1.callingController_:SetSelectedState("normal")

				local var_679_3 = arg_676_1:GetWordFromCfg(120431164)
				local var_679_4 = arg_676_1:FormatText(var_679_3.content)

				arg_676_1.text_.text = var_679_4

				LuaForUtil.ClearLinePrefixSymbol(arg_676_1.text_)

				local var_679_5 = 26
				local var_679_6 = utf8.len(var_679_4)
				local var_679_7 = var_679_5 <= 0 and var_679_1 or var_679_1 * (var_679_6 / var_679_5)

				if var_679_7 > 0 and var_679_1 < var_679_7 then
					arg_676_1.talkMaxDuration = var_679_7

					if var_679_7 + var_679_0 > arg_676_1.duration_ then
						arg_676_1.duration_ = var_679_7 + var_679_0
					end
				end

				arg_676_1.text_.text = var_679_4
				arg_676_1.typewritter.percent = 0

				arg_676_1.typewritter:SetDirty()
				arg_676_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431164", "story_v_out_120431.awb") ~= 0 then
					local var_679_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431164", "story_v_out_120431.awb") / 1000

					if var_679_8 + var_679_0 > arg_676_1.duration_ then
						arg_676_1.duration_ = var_679_8 + var_679_0
					end

					if var_679_3.prefab_name ~= "" and arg_676_1.actors_[var_679_3.prefab_name] ~= nil then
						local var_679_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_676_1.actors_[var_679_3.prefab_name].transform, "story_v_out_120431", "120431164", "story_v_out_120431.awb")

						arg_676_1:RecordAudio("120431164", var_679_9)
						arg_676_1:RecordAudio("120431164", var_679_9)
					else
						arg_676_1:AudioAction("play", "voice", "story_v_out_120431", "120431164", "story_v_out_120431.awb")
					end

					arg_676_1:RecordHistoryTalkVoice("story_v_out_120431", "120431164", "story_v_out_120431.awb")
				end

				arg_676_1:RecordContent(arg_676_1.text_.text)
			end

			local var_679_10 = math.max(var_679_1, arg_676_1.talkMaxDuration)

			if var_679_0 <= arg_676_1.time_ and arg_676_1.time_ < var_679_0 + var_679_10 then
				arg_676_1.typewritter.percent = (arg_676_1.time_ - var_679_0) / var_679_10

				arg_676_1.typewritter:SetDirty()
			end

			if arg_676_1.time_ >= var_679_0 + var_679_10 and arg_676_1.time_ < var_679_0 + var_679_10 + arg_679_0 then
				arg_676_1.typewritter.percent = 1

				arg_676_1.typewritter:SetDirty()
				arg_676_1:ShowNextGo(true)
			end
		end

		arg_676_1.nodeConfigList_ = {}

		arg_676_1:InitPlayNodeList()
	end,
	Play120431165 = function(arg_680_0, arg_680_1)
		arg_680_1.time_ = 0
		arg_680_1.frameCnt_ = 0
		arg_680_1.state_ = "playing"
		arg_680_1.curTalkId_ = 120431165
		arg_680_1.duration_ = 8.2

		local var_680_0 = {
			zh = 4.7,
			ja = 8.2
		}
		local var_680_1 = manager.audio:GetLocalizationFlag()

		if var_680_0[var_680_1] ~= nil then
			arg_680_1.duration_ = var_680_0[var_680_1]
		end

		SetActive(arg_680_1.tipsGo_, false)

		function arg_680_1.onSingleLineFinish_()
			arg_680_1.onSingleLineUpdate_ = nil
			arg_680_1.onSingleLineFinish_ = nil
			arg_680_1.state_ = "waiting"
		end

		function arg_680_1.playNext_(arg_682_0)
			if arg_682_0 == 1 then
				arg_680_0:Play120431166(arg_680_1)
			end
		end

		function arg_680_1.onSingleLineUpdate_(arg_683_0)
			local var_683_0 = 0
			local var_683_1 = 0.375

			if var_683_0 < arg_680_1.time_ and arg_680_1.time_ <= var_683_0 + arg_683_0 then
				arg_680_1.talkMaxDuration = 0
				arg_680_1.dialogCg_.alpha = 1

				arg_680_1.dialog_:SetActive(true)
				SetActive(arg_680_1.leftNameGo_, true)

				local var_683_2 = arg_680_1:FormatText(StoryNameCfg[6].name)

				arg_680_1.leftNameTxt_.text = var_683_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_680_1.leftNameTxt_.transform)

				arg_680_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_680_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_680_1:RecordName(arg_680_1.leftNameTxt_.text)
				SetActive(arg_680_1.iconTrs_.gameObject, false)
				arg_680_1.callingController_:SetSelectedState("normal")

				local var_683_3 = arg_680_1:GetWordFromCfg(120431165)
				local var_683_4 = arg_680_1:FormatText(var_683_3.content)

				arg_680_1.text_.text = var_683_4

				LuaForUtil.ClearLinePrefixSymbol(arg_680_1.text_)

				local var_683_5 = 15
				local var_683_6 = utf8.len(var_683_4)
				local var_683_7 = var_683_5 <= 0 and var_683_1 or var_683_1 * (var_683_6 / var_683_5)

				if var_683_7 > 0 and var_683_1 < var_683_7 then
					arg_680_1.talkMaxDuration = var_683_7

					if var_683_7 + var_683_0 > arg_680_1.duration_ then
						arg_680_1.duration_ = var_683_7 + var_683_0
					end
				end

				arg_680_1.text_.text = var_683_4
				arg_680_1.typewritter.percent = 0

				arg_680_1.typewritter:SetDirty()
				arg_680_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431165", "story_v_out_120431.awb") ~= 0 then
					local var_683_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431165", "story_v_out_120431.awb") / 1000

					if var_683_8 + var_683_0 > arg_680_1.duration_ then
						arg_680_1.duration_ = var_683_8 + var_683_0
					end

					if var_683_3.prefab_name ~= "" and arg_680_1.actors_[var_683_3.prefab_name] ~= nil then
						local var_683_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_680_1.actors_[var_683_3.prefab_name].transform, "story_v_out_120431", "120431165", "story_v_out_120431.awb")

						arg_680_1:RecordAudio("120431165", var_683_9)
						arg_680_1:RecordAudio("120431165", var_683_9)
					else
						arg_680_1:AudioAction("play", "voice", "story_v_out_120431", "120431165", "story_v_out_120431.awb")
					end

					arg_680_1:RecordHistoryTalkVoice("story_v_out_120431", "120431165", "story_v_out_120431.awb")
				end

				arg_680_1:RecordContent(arg_680_1.text_.text)
			end

			local var_683_10 = math.max(var_683_1, arg_680_1.talkMaxDuration)

			if var_683_0 <= arg_680_1.time_ and arg_680_1.time_ < var_683_0 + var_683_10 then
				arg_680_1.typewritter.percent = (arg_680_1.time_ - var_683_0) / var_683_10

				arg_680_1.typewritter:SetDirty()
			end

			if arg_680_1.time_ >= var_683_0 + var_683_10 and arg_680_1.time_ < var_683_0 + var_683_10 + arg_683_0 then
				arg_680_1.typewritter.percent = 1

				arg_680_1.typewritter:SetDirty()
				arg_680_1:ShowNextGo(true)
			end
		end

		arg_680_1.nodeConfigList_ = {}

		arg_680_1:InitPlayNodeList()
	end,
	Play120431166 = function(arg_684_0, arg_684_1)
		arg_684_1.time_ = 0
		arg_684_1.frameCnt_ = 0
		arg_684_1.state_ = "playing"
		arg_684_1.curTalkId_ = 120431166
		arg_684_1.duration_ = 8.43

		local var_684_0 = {
			zh = 7.033,
			ja = 8.433
		}
		local var_684_1 = manager.audio:GetLocalizationFlag()

		if var_684_0[var_684_1] ~= nil then
			arg_684_1.duration_ = var_684_0[var_684_1]
		end

		SetActive(arg_684_1.tipsGo_, false)

		function arg_684_1.onSingleLineFinish_()
			arg_684_1.onSingleLineUpdate_ = nil
			arg_684_1.onSingleLineFinish_ = nil
			arg_684_1.state_ = "waiting"
		end

		function arg_684_1.playNext_(arg_686_0)
			if arg_686_0 == 1 then
				arg_684_0:Play120431167(arg_684_1)
			end
		end

		function arg_684_1.onSingleLineUpdate_(arg_687_0)
			local var_687_0 = 0
			local var_687_1 = 0.7

			if var_687_0 < arg_684_1.time_ and arg_684_1.time_ <= var_687_0 + arg_687_0 then
				arg_684_1.talkMaxDuration = 0
				arg_684_1.dialogCg_.alpha = 1

				arg_684_1.dialog_:SetActive(true)
				SetActive(arg_684_1.leftNameGo_, true)

				local var_687_2 = arg_684_1:FormatText(StoryNameCfg[6].name)

				arg_684_1.leftNameTxt_.text = var_687_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_684_1.leftNameTxt_.transform)

				arg_684_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_684_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_684_1:RecordName(arg_684_1.leftNameTxt_.text)
				SetActive(arg_684_1.iconTrs_.gameObject, false)
				arg_684_1.callingController_:SetSelectedState("normal")

				local var_687_3 = arg_684_1:GetWordFromCfg(120431166)
				local var_687_4 = arg_684_1:FormatText(var_687_3.content)

				arg_684_1.text_.text = var_687_4

				LuaForUtil.ClearLinePrefixSymbol(arg_684_1.text_)

				local var_687_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431166", "story_v_out_120431.awb") ~= 0 then
					local var_687_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431166", "story_v_out_120431.awb") / 1000

					if var_687_8 + var_687_0 > arg_684_1.duration_ then
						arg_684_1.duration_ = var_687_8 + var_687_0
					end

					if var_687_3.prefab_name ~= "" and arg_684_1.actors_[var_687_3.prefab_name] ~= nil then
						local var_687_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_684_1.actors_[var_687_3.prefab_name].transform, "story_v_out_120431", "120431166", "story_v_out_120431.awb")

						arg_684_1:RecordAudio("120431166", var_687_9)
						arg_684_1:RecordAudio("120431166", var_687_9)
					else
						arg_684_1:AudioAction("play", "voice", "story_v_out_120431", "120431166", "story_v_out_120431.awb")
					end

					arg_684_1:RecordHistoryTalkVoice("story_v_out_120431", "120431166", "story_v_out_120431.awb")
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
	Play120431167 = function(arg_688_0, arg_688_1)
		arg_688_1.time_ = 0
		arg_688_1.frameCnt_ = 0
		arg_688_1.state_ = "playing"
		arg_688_1.curTalkId_ = 120431167
		arg_688_1.duration_ = 10.2

		local var_688_0 = {
			zh = 7.933,
			ja = 10.2
		}
		local var_688_1 = manager.audio:GetLocalizationFlag()

		if var_688_0[var_688_1] ~= nil then
			arg_688_1.duration_ = var_688_0[var_688_1]
		end

		SetActive(arg_688_1.tipsGo_, false)

		function arg_688_1.onSingleLineFinish_()
			arg_688_1.onSingleLineUpdate_ = nil
			arg_688_1.onSingleLineFinish_ = nil
			arg_688_1.state_ = "waiting"
		end

		function arg_688_1.playNext_(arg_690_0)
			if arg_690_0 == 1 then
				arg_688_0:Play120431168(arg_688_1)
			end
		end

		function arg_688_1.onSingleLineUpdate_(arg_691_0)
			local var_691_0 = 0
			local var_691_1 = 0.7

			if var_691_0 < arg_688_1.time_ and arg_688_1.time_ <= var_691_0 + arg_691_0 then
				arg_688_1.talkMaxDuration = 0
				arg_688_1.dialogCg_.alpha = 1

				arg_688_1.dialog_:SetActive(true)
				SetActive(arg_688_1.leftNameGo_, true)

				local var_691_2 = arg_688_1:FormatText(StoryNameCfg[389].name)

				arg_688_1.leftNameTxt_.text = var_691_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_688_1.leftNameTxt_.transform)

				arg_688_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_688_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_688_1:RecordName(arg_688_1.leftNameTxt_.text)
				SetActive(arg_688_1.iconTrs_.gameObject, false)
				arg_688_1.callingController_:SetSelectedState("normal")

				local var_691_3 = arg_688_1:GetWordFromCfg(120431167)
				local var_691_4 = arg_688_1:FormatText(var_691_3.content)

				arg_688_1.text_.text = var_691_4

				LuaForUtil.ClearLinePrefixSymbol(arg_688_1.text_)

				local var_691_5 = 28
				local var_691_6 = utf8.len(var_691_4)
				local var_691_7 = var_691_5 <= 0 and var_691_1 or var_691_1 * (var_691_6 / var_691_5)

				if var_691_7 > 0 and var_691_1 < var_691_7 then
					arg_688_1.talkMaxDuration = var_691_7

					if var_691_7 + var_691_0 > arg_688_1.duration_ then
						arg_688_1.duration_ = var_691_7 + var_691_0
					end
				end

				arg_688_1.text_.text = var_691_4
				arg_688_1.typewritter.percent = 0

				arg_688_1.typewritter:SetDirty()
				arg_688_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431167", "story_v_out_120431.awb") ~= 0 then
					local var_691_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431167", "story_v_out_120431.awb") / 1000

					if var_691_8 + var_691_0 > arg_688_1.duration_ then
						arg_688_1.duration_ = var_691_8 + var_691_0
					end

					if var_691_3.prefab_name ~= "" and arg_688_1.actors_[var_691_3.prefab_name] ~= nil then
						local var_691_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_688_1.actors_[var_691_3.prefab_name].transform, "story_v_out_120431", "120431167", "story_v_out_120431.awb")

						arg_688_1:RecordAudio("120431167", var_691_9)
						arg_688_1:RecordAudio("120431167", var_691_9)
					else
						arg_688_1:AudioAction("play", "voice", "story_v_out_120431", "120431167", "story_v_out_120431.awb")
					end

					arg_688_1:RecordHistoryTalkVoice("story_v_out_120431", "120431167", "story_v_out_120431.awb")
				end

				arg_688_1:RecordContent(arg_688_1.text_.text)
			end

			local var_691_10 = math.max(var_691_1, arg_688_1.talkMaxDuration)

			if var_691_0 <= arg_688_1.time_ and arg_688_1.time_ < var_691_0 + var_691_10 then
				arg_688_1.typewritter.percent = (arg_688_1.time_ - var_691_0) / var_691_10

				arg_688_1.typewritter:SetDirty()
			end

			if arg_688_1.time_ >= var_691_0 + var_691_10 and arg_688_1.time_ < var_691_0 + var_691_10 + arg_691_0 then
				arg_688_1.typewritter.percent = 1

				arg_688_1.typewritter:SetDirty()
				arg_688_1:ShowNextGo(true)
			end
		end

		arg_688_1.nodeConfigList_ = {}

		arg_688_1:InitPlayNodeList()
	end,
	Play120431168 = function(arg_692_0, arg_692_1)
		arg_692_1.time_ = 0
		arg_692_1.frameCnt_ = 0
		arg_692_1.state_ = "playing"
		arg_692_1.curTalkId_ = 120431168
		arg_692_1.duration_ = 14.1

		local var_692_0 = {
			zh = 9.6,
			ja = 14.1
		}
		local var_692_1 = manager.audio:GetLocalizationFlag()

		if var_692_0[var_692_1] ~= nil then
			arg_692_1.duration_ = var_692_0[var_692_1]
		end

		SetActive(arg_692_1.tipsGo_, false)

		function arg_692_1.onSingleLineFinish_()
			arg_692_1.onSingleLineUpdate_ = nil
			arg_692_1.onSingleLineFinish_ = nil
			arg_692_1.state_ = "waiting"
		end

		function arg_692_1.playNext_(arg_694_0)
			if arg_694_0 == 1 then
				arg_692_0:Play120431169(arg_692_1)
			end
		end

		function arg_692_1.onSingleLineUpdate_(arg_695_0)
			local var_695_0 = 0
			local var_695_1 = 1.025

			if var_695_0 < arg_692_1.time_ and arg_692_1.time_ <= var_695_0 + arg_695_0 then
				arg_692_1.talkMaxDuration = 0
				arg_692_1.dialogCg_.alpha = 1

				arg_692_1.dialog_:SetActive(true)
				SetActive(arg_692_1.leftNameGo_, true)

				local var_695_2 = arg_692_1:FormatText(StoryNameCfg[389].name)

				arg_692_1.leftNameTxt_.text = var_695_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_692_1.leftNameTxt_.transform)

				arg_692_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_692_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_692_1:RecordName(arg_692_1.leftNameTxt_.text)
				SetActive(arg_692_1.iconTrs_.gameObject, false)
				arg_692_1.callingController_:SetSelectedState("normal")

				local var_695_3 = arg_692_1:GetWordFromCfg(120431168)
				local var_695_4 = arg_692_1:FormatText(var_695_3.content)

				arg_692_1.text_.text = var_695_4

				LuaForUtil.ClearLinePrefixSymbol(arg_692_1.text_)

				local var_695_5 = 41
				local var_695_6 = utf8.len(var_695_4)
				local var_695_7 = var_695_5 <= 0 and var_695_1 or var_695_1 * (var_695_6 / var_695_5)

				if var_695_7 > 0 and var_695_1 < var_695_7 then
					arg_692_1.talkMaxDuration = var_695_7

					if var_695_7 + var_695_0 > arg_692_1.duration_ then
						arg_692_1.duration_ = var_695_7 + var_695_0
					end
				end

				arg_692_1.text_.text = var_695_4
				arg_692_1.typewritter.percent = 0

				arg_692_1.typewritter:SetDirty()
				arg_692_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431168", "story_v_out_120431.awb") ~= 0 then
					local var_695_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431168", "story_v_out_120431.awb") / 1000

					if var_695_8 + var_695_0 > arg_692_1.duration_ then
						arg_692_1.duration_ = var_695_8 + var_695_0
					end

					if var_695_3.prefab_name ~= "" and arg_692_1.actors_[var_695_3.prefab_name] ~= nil then
						local var_695_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_692_1.actors_[var_695_3.prefab_name].transform, "story_v_out_120431", "120431168", "story_v_out_120431.awb")

						arg_692_1:RecordAudio("120431168", var_695_9)
						arg_692_1:RecordAudio("120431168", var_695_9)
					else
						arg_692_1:AudioAction("play", "voice", "story_v_out_120431", "120431168", "story_v_out_120431.awb")
					end

					arg_692_1:RecordHistoryTalkVoice("story_v_out_120431", "120431168", "story_v_out_120431.awb")
				end

				arg_692_1:RecordContent(arg_692_1.text_.text)
			end

			local var_695_10 = math.max(var_695_1, arg_692_1.talkMaxDuration)

			if var_695_0 <= arg_692_1.time_ and arg_692_1.time_ < var_695_0 + var_695_10 then
				arg_692_1.typewritter.percent = (arg_692_1.time_ - var_695_0) / var_695_10

				arg_692_1.typewritter:SetDirty()
			end

			if arg_692_1.time_ >= var_695_0 + var_695_10 and arg_692_1.time_ < var_695_0 + var_695_10 + arg_695_0 then
				arg_692_1.typewritter.percent = 1

				arg_692_1.typewritter:SetDirty()
				arg_692_1:ShowNextGo(true)
			end
		end

		arg_692_1.nodeConfigList_ = {}

		arg_692_1:InitPlayNodeList()
	end,
	Play120431169 = function(arg_696_0, arg_696_1)
		arg_696_1.time_ = 0
		arg_696_1.frameCnt_ = 0
		arg_696_1.state_ = "playing"
		arg_696_1.curTalkId_ = 120431169
		arg_696_1.duration_ = 16.33

		local var_696_0 = {
			zh = 10.2,
			ja = 16.333
		}
		local var_696_1 = manager.audio:GetLocalizationFlag()

		if var_696_0[var_696_1] ~= nil then
			arg_696_1.duration_ = var_696_0[var_696_1]
		end

		SetActive(arg_696_1.tipsGo_, false)

		function arg_696_1.onSingleLineFinish_()
			arg_696_1.onSingleLineUpdate_ = nil
			arg_696_1.onSingleLineFinish_ = nil
			arg_696_1.state_ = "waiting"
		end

		function arg_696_1.playNext_(arg_698_0)
			if arg_698_0 == 1 then
				arg_696_0:Play120431170(arg_696_1)
			end
		end

		function arg_696_1.onSingleLineUpdate_(arg_699_0)
			local var_699_0 = 0
			local var_699_1 = 1.1

			if var_699_0 < arg_696_1.time_ and arg_696_1.time_ <= var_699_0 + arg_699_0 then
				arg_696_1.talkMaxDuration = 0
				arg_696_1.dialogCg_.alpha = 1

				arg_696_1.dialog_:SetActive(true)
				SetActive(arg_696_1.leftNameGo_, true)

				local var_699_2 = arg_696_1:FormatText(StoryNameCfg[389].name)

				arg_696_1.leftNameTxt_.text = var_699_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_696_1.leftNameTxt_.transform)

				arg_696_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_696_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_696_1:RecordName(arg_696_1.leftNameTxt_.text)
				SetActive(arg_696_1.iconTrs_.gameObject, false)
				arg_696_1.callingController_:SetSelectedState("normal")

				local var_699_3 = arg_696_1:GetWordFromCfg(120431169)
				local var_699_4 = arg_696_1:FormatText(var_699_3.content)

				arg_696_1.text_.text = var_699_4

				LuaForUtil.ClearLinePrefixSymbol(arg_696_1.text_)

				local var_699_5 = 44
				local var_699_6 = utf8.len(var_699_4)
				local var_699_7 = var_699_5 <= 0 and var_699_1 or var_699_1 * (var_699_6 / var_699_5)

				if var_699_7 > 0 and var_699_1 < var_699_7 then
					arg_696_1.talkMaxDuration = var_699_7

					if var_699_7 + var_699_0 > arg_696_1.duration_ then
						arg_696_1.duration_ = var_699_7 + var_699_0
					end
				end

				arg_696_1.text_.text = var_699_4
				arg_696_1.typewritter.percent = 0

				arg_696_1.typewritter:SetDirty()
				arg_696_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431169", "story_v_out_120431.awb") ~= 0 then
					local var_699_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431169", "story_v_out_120431.awb") / 1000

					if var_699_8 + var_699_0 > arg_696_1.duration_ then
						arg_696_1.duration_ = var_699_8 + var_699_0
					end

					if var_699_3.prefab_name ~= "" and arg_696_1.actors_[var_699_3.prefab_name] ~= nil then
						local var_699_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_696_1.actors_[var_699_3.prefab_name].transform, "story_v_out_120431", "120431169", "story_v_out_120431.awb")

						arg_696_1:RecordAudio("120431169", var_699_9)
						arg_696_1:RecordAudio("120431169", var_699_9)
					else
						arg_696_1:AudioAction("play", "voice", "story_v_out_120431", "120431169", "story_v_out_120431.awb")
					end

					arg_696_1:RecordHistoryTalkVoice("story_v_out_120431", "120431169", "story_v_out_120431.awb")
				end

				arg_696_1:RecordContent(arg_696_1.text_.text)
			end

			local var_699_10 = math.max(var_699_1, arg_696_1.talkMaxDuration)

			if var_699_0 <= arg_696_1.time_ and arg_696_1.time_ < var_699_0 + var_699_10 then
				arg_696_1.typewritter.percent = (arg_696_1.time_ - var_699_0) / var_699_10

				arg_696_1.typewritter:SetDirty()
			end

			if arg_696_1.time_ >= var_699_0 + var_699_10 and arg_696_1.time_ < var_699_0 + var_699_10 + arg_699_0 then
				arg_696_1.typewritter.percent = 1

				arg_696_1.typewritter:SetDirty()
				arg_696_1:ShowNextGo(true)
			end
		end

		arg_696_1.nodeConfigList_ = {}

		arg_696_1:InitPlayNodeList()
	end,
	Play120431170 = function(arg_700_0, arg_700_1)
		arg_700_1.time_ = 0
		arg_700_1.frameCnt_ = 0
		arg_700_1.state_ = "playing"
		arg_700_1.curTalkId_ = 120431170
		arg_700_1.duration_ = 8.53

		local var_700_0 = {
			zh = 6.766,
			ja = 8.533
		}
		local var_700_1 = manager.audio:GetLocalizationFlag()

		if var_700_0[var_700_1] ~= nil then
			arg_700_1.duration_ = var_700_0[var_700_1]
		end

		SetActive(arg_700_1.tipsGo_, false)

		function arg_700_1.onSingleLineFinish_()
			arg_700_1.onSingleLineUpdate_ = nil
			arg_700_1.onSingleLineFinish_ = nil
			arg_700_1.state_ = "waiting"
		end

		function arg_700_1.playNext_(arg_702_0)
			if arg_702_0 == 1 then
				arg_700_0:Play120431171(arg_700_1)
			end
		end

		function arg_700_1.onSingleLineUpdate_(arg_703_0)
			local var_703_0 = 0
			local var_703_1 = 0.7

			if var_703_0 < arg_700_1.time_ and arg_700_1.time_ <= var_703_0 + arg_703_0 then
				arg_700_1.talkMaxDuration = 0
				arg_700_1.dialogCg_.alpha = 1

				arg_700_1.dialog_:SetActive(true)
				SetActive(arg_700_1.leftNameGo_, true)

				local var_703_2 = arg_700_1:FormatText(StoryNameCfg[389].name)

				arg_700_1.leftNameTxt_.text = var_703_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_700_1.leftNameTxt_.transform)

				arg_700_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_700_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_700_1:RecordName(arg_700_1.leftNameTxt_.text)
				SetActive(arg_700_1.iconTrs_.gameObject, false)
				arg_700_1.callingController_:SetSelectedState("normal")

				local var_703_3 = arg_700_1:GetWordFromCfg(120431170)
				local var_703_4 = arg_700_1:FormatText(var_703_3.content)

				arg_700_1.text_.text = var_703_4

				LuaForUtil.ClearLinePrefixSymbol(arg_700_1.text_)

				local var_703_5 = 28
				local var_703_6 = utf8.len(var_703_4)
				local var_703_7 = var_703_5 <= 0 and var_703_1 or var_703_1 * (var_703_6 / var_703_5)

				if var_703_7 > 0 and var_703_1 < var_703_7 then
					arg_700_1.talkMaxDuration = var_703_7

					if var_703_7 + var_703_0 > arg_700_1.duration_ then
						arg_700_1.duration_ = var_703_7 + var_703_0
					end
				end

				arg_700_1.text_.text = var_703_4
				arg_700_1.typewritter.percent = 0

				arg_700_1.typewritter:SetDirty()
				arg_700_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431170", "story_v_out_120431.awb") ~= 0 then
					local var_703_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431170", "story_v_out_120431.awb") / 1000

					if var_703_8 + var_703_0 > arg_700_1.duration_ then
						arg_700_1.duration_ = var_703_8 + var_703_0
					end

					if var_703_3.prefab_name ~= "" and arg_700_1.actors_[var_703_3.prefab_name] ~= nil then
						local var_703_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_700_1.actors_[var_703_3.prefab_name].transform, "story_v_out_120431", "120431170", "story_v_out_120431.awb")

						arg_700_1:RecordAudio("120431170", var_703_9)
						arg_700_1:RecordAudio("120431170", var_703_9)
					else
						arg_700_1:AudioAction("play", "voice", "story_v_out_120431", "120431170", "story_v_out_120431.awb")
					end

					arg_700_1:RecordHistoryTalkVoice("story_v_out_120431", "120431170", "story_v_out_120431.awb")
				end

				arg_700_1:RecordContent(arg_700_1.text_.text)
			end

			local var_703_10 = math.max(var_703_1, arg_700_1.talkMaxDuration)

			if var_703_0 <= arg_700_1.time_ and arg_700_1.time_ < var_703_0 + var_703_10 then
				arg_700_1.typewritter.percent = (arg_700_1.time_ - var_703_0) / var_703_10

				arg_700_1.typewritter:SetDirty()
			end

			if arg_700_1.time_ >= var_703_0 + var_703_10 and arg_700_1.time_ < var_703_0 + var_703_10 + arg_703_0 then
				arg_700_1.typewritter.percent = 1

				arg_700_1.typewritter:SetDirty()
				arg_700_1:ShowNextGo(true)
			end
		end

		arg_700_1.nodeConfigList_ = {}

		arg_700_1:InitPlayNodeList()
	end,
	Play120431171 = function(arg_704_0, arg_704_1)
		arg_704_1.time_ = 0
		arg_704_1.frameCnt_ = 0
		arg_704_1.state_ = "playing"
		arg_704_1.curTalkId_ = 120431171
		arg_704_1.duration_ = 3.6

		local var_704_0 = {
			zh = 1.833,
			ja = 3.6
		}
		local var_704_1 = manager.audio:GetLocalizationFlag()

		if var_704_0[var_704_1] ~= nil then
			arg_704_1.duration_ = var_704_0[var_704_1]
		end

		SetActive(arg_704_1.tipsGo_, false)

		function arg_704_1.onSingleLineFinish_()
			arg_704_1.onSingleLineUpdate_ = nil
			arg_704_1.onSingleLineFinish_ = nil
			arg_704_1.state_ = "waiting"
		end

		function arg_704_1.playNext_(arg_706_0)
			if arg_706_0 == 1 then
				arg_704_0:Play120431172(arg_704_1)
			end
		end

		function arg_704_1.onSingleLineUpdate_(arg_707_0)
			local var_707_0 = 0
			local var_707_1 = 0.2

			if var_707_0 < arg_704_1.time_ and arg_704_1.time_ <= var_707_0 + arg_707_0 then
				arg_704_1.talkMaxDuration = 0
				arg_704_1.dialogCg_.alpha = 1

				arg_704_1.dialog_:SetActive(true)
				SetActive(arg_704_1.leftNameGo_, true)

				local var_707_2 = arg_704_1:FormatText(StoryNameCfg[6].name)

				arg_704_1.leftNameTxt_.text = var_707_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_704_1.leftNameTxt_.transform)

				arg_704_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_704_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_704_1:RecordName(arg_704_1.leftNameTxt_.text)
				SetActive(arg_704_1.iconTrs_.gameObject, false)
				arg_704_1.callingController_:SetSelectedState("normal")

				local var_707_3 = arg_704_1:GetWordFromCfg(120431171)
				local var_707_4 = arg_704_1:FormatText(var_707_3.content)

				arg_704_1.text_.text = var_707_4

				LuaForUtil.ClearLinePrefixSymbol(arg_704_1.text_)

				local var_707_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431171", "story_v_out_120431.awb") ~= 0 then
					local var_707_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431171", "story_v_out_120431.awb") / 1000

					if var_707_8 + var_707_0 > arg_704_1.duration_ then
						arg_704_1.duration_ = var_707_8 + var_707_0
					end

					if var_707_3.prefab_name ~= "" and arg_704_1.actors_[var_707_3.prefab_name] ~= nil then
						local var_707_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_704_1.actors_[var_707_3.prefab_name].transform, "story_v_out_120431", "120431171", "story_v_out_120431.awb")

						arg_704_1:RecordAudio("120431171", var_707_9)
						arg_704_1:RecordAudio("120431171", var_707_9)
					else
						arg_704_1:AudioAction("play", "voice", "story_v_out_120431", "120431171", "story_v_out_120431.awb")
					end

					arg_704_1:RecordHistoryTalkVoice("story_v_out_120431", "120431171", "story_v_out_120431.awb")
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
	Play120431172 = function(arg_708_0, arg_708_1)
		arg_708_1.time_ = 0
		arg_708_1.frameCnt_ = 0
		arg_708_1.state_ = "playing"
		arg_708_1.curTalkId_ = 120431172
		arg_708_1.duration_ = 11.5

		local var_708_0 = {
			zh = 5.9,
			ja = 11.5
		}
		local var_708_1 = manager.audio:GetLocalizationFlag()

		if var_708_0[var_708_1] ~= nil then
			arg_708_1.duration_ = var_708_0[var_708_1]
		end

		SetActive(arg_708_1.tipsGo_, false)

		function arg_708_1.onSingleLineFinish_()
			arg_708_1.onSingleLineUpdate_ = nil
			arg_708_1.onSingleLineFinish_ = nil
			arg_708_1.state_ = "waiting"
		end

		function arg_708_1.playNext_(arg_710_0)
			if arg_710_0 == 1 then
				arg_708_0:Play120431173(arg_708_1)
			end
		end

		function arg_708_1.onSingleLineUpdate_(arg_711_0)
			local var_711_0 = 0
			local var_711_1 = 0.55

			if var_711_0 < arg_708_1.time_ and arg_708_1.time_ <= var_711_0 + arg_711_0 then
				arg_708_1.talkMaxDuration = 0
				arg_708_1.dialogCg_.alpha = 1

				arg_708_1.dialog_:SetActive(true)
				SetActive(arg_708_1.leftNameGo_, true)

				local var_711_2 = arg_708_1:FormatText(StoryNameCfg[389].name)

				arg_708_1.leftNameTxt_.text = var_711_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_708_1.leftNameTxt_.transform)

				arg_708_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_708_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_708_1:RecordName(arg_708_1.leftNameTxt_.text)
				SetActive(arg_708_1.iconTrs_.gameObject, false)
				arg_708_1.callingController_:SetSelectedState("normal")

				local var_711_3 = arg_708_1:GetWordFromCfg(120431172)
				local var_711_4 = arg_708_1:FormatText(var_711_3.content)

				arg_708_1.text_.text = var_711_4

				LuaForUtil.ClearLinePrefixSymbol(arg_708_1.text_)

				local var_711_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431172", "story_v_out_120431.awb") ~= 0 then
					local var_711_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431172", "story_v_out_120431.awb") / 1000

					if var_711_8 + var_711_0 > arg_708_1.duration_ then
						arg_708_1.duration_ = var_711_8 + var_711_0
					end

					if var_711_3.prefab_name ~= "" and arg_708_1.actors_[var_711_3.prefab_name] ~= nil then
						local var_711_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_708_1.actors_[var_711_3.prefab_name].transform, "story_v_out_120431", "120431172", "story_v_out_120431.awb")

						arg_708_1:RecordAudio("120431172", var_711_9)
						arg_708_1:RecordAudio("120431172", var_711_9)
					else
						arg_708_1:AudioAction("play", "voice", "story_v_out_120431", "120431172", "story_v_out_120431.awb")
					end

					arg_708_1:RecordHistoryTalkVoice("story_v_out_120431", "120431172", "story_v_out_120431.awb")
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
	Play120431173 = function(arg_712_0, arg_712_1)
		arg_712_1.time_ = 0
		arg_712_1.frameCnt_ = 0
		arg_712_1.state_ = "playing"
		arg_712_1.curTalkId_ = 120431173
		arg_712_1.duration_ = 16.4

		local var_712_0 = {
			zh = 7.133,
			ja = 16.4
		}
		local var_712_1 = manager.audio:GetLocalizationFlag()

		if var_712_0[var_712_1] ~= nil then
			arg_712_1.duration_ = var_712_0[var_712_1]
		end

		SetActive(arg_712_1.tipsGo_, false)

		function arg_712_1.onSingleLineFinish_()
			arg_712_1.onSingleLineUpdate_ = nil
			arg_712_1.onSingleLineFinish_ = nil
			arg_712_1.state_ = "waiting"
		end

		function arg_712_1.playNext_(arg_714_0)
			if arg_714_0 == 1 then
				arg_712_0:Play120431174(arg_712_1)
			end
		end

		function arg_712_1.onSingleLineUpdate_(arg_715_0)
			local var_715_0 = 0
			local var_715_1 = 0.675

			if var_715_0 < arg_712_1.time_ and arg_712_1.time_ <= var_715_0 + arg_715_0 then
				arg_712_1.talkMaxDuration = 0
				arg_712_1.dialogCg_.alpha = 1

				arg_712_1.dialog_:SetActive(true)
				SetActive(arg_712_1.leftNameGo_, true)

				local var_715_2 = arg_712_1:FormatText(StoryNameCfg[389].name)

				arg_712_1.leftNameTxt_.text = var_715_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_712_1.leftNameTxt_.transform)

				arg_712_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_712_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_712_1:RecordName(arg_712_1.leftNameTxt_.text)
				SetActive(arg_712_1.iconTrs_.gameObject, false)
				arg_712_1.callingController_:SetSelectedState("normal")

				local var_715_3 = arg_712_1:GetWordFromCfg(120431173)
				local var_715_4 = arg_712_1:FormatText(var_715_3.content)

				arg_712_1.text_.text = var_715_4

				LuaForUtil.ClearLinePrefixSymbol(arg_712_1.text_)

				local var_715_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431173", "story_v_out_120431.awb") ~= 0 then
					local var_715_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431173", "story_v_out_120431.awb") / 1000

					if var_715_8 + var_715_0 > arg_712_1.duration_ then
						arg_712_1.duration_ = var_715_8 + var_715_0
					end

					if var_715_3.prefab_name ~= "" and arg_712_1.actors_[var_715_3.prefab_name] ~= nil then
						local var_715_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_712_1.actors_[var_715_3.prefab_name].transform, "story_v_out_120431", "120431173", "story_v_out_120431.awb")

						arg_712_1:RecordAudio("120431173", var_715_9)
						arg_712_1:RecordAudio("120431173", var_715_9)
					else
						arg_712_1:AudioAction("play", "voice", "story_v_out_120431", "120431173", "story_v_out_120431.awb")
					end

					arg_712_1:RecordHistoryTalkVoice("story_v_out_120431", "120431173", "story_v_out_120431.awb")
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
	Play120431174 = function(arg_716_0, arg_716_1)
		arg_716_1.time_ = 0
		arg_716_1.frameCnt_ = 0
		arg_716_1.state_ = "playing"
		arg_716_1.curTalkId_ = 120431174
		arg_716_1.duration_ = 19.33

		local var_716_0 = {
			zh = 11.333,
			ja = 19.333
		}
		local var_716_1 = manager.audio:GetLocalizationFlag()

		if var_716_0[var_716_1] ~= nil then
			arg_716_1.duration_ = var_716_0[var_716_1]
		end

		SetActive(arg_716_1.tipsGo_, false)

		function arg_716_1.onSingleLineFinish_()
			arg_716_1.onSingleLineUpdate_ = nil
			arg_716_1.onSingleLineFinish_ = nil
			arg_716_1.state_ = "waiting"
		end

		function arg_716_1.playNext_(arg_718_0)
			if arg_718_0 == 1 then
				arg_716_0:Play120431175(arg_716_1)
			end
		end

		function arg_716_1.onSingleLineUpdate_(arg_719_0)
			local var_719_0 = 0
			local var_719_1 = 0.95

			if var_719_0 < arg_716_1.time_ and arg_716_1.time_ <= var_719_0 + arg_719_0 then
				arg_716_1.talkMaxDuration = 0
				arg_716_1.dialogCg_.alpha = 1

				arg_716_1.dialog_:SetActive(true)
				SetActive(arg_716_1.leftNameGo_, true)

				local var_719_2 = arg_716_1:FormatText(StoryNameCfg[389].name)

				arg_716_1.leftNameTxt_.text = var_719_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_716_1.leftNameTxt_.transform)

				arg_716_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_716_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_716_1:RecordName(arg_716_1.leftNameTxt_.text)
				SetActive(arg_716_1.iconTrs_.gameObject, false)
				arg_716_1.callingController_:SetSelectedState("normal")

				local var_719_3 = arg_716_1:GetWordFromCfg(120431174)
				local var_719_4 = arg_716_1:FormatText(var_719_3.content)

				arg_716_1.text_.text = var_719_4

				LuaForUtil.ClearLinePrefixSymbol(arg_716_1.text_)

				local var_719_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431174", "story_v_out_120431.awb") ~= 0 then
					local var_719_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431174", "story_v_out_120431.awb") / 1000

					if var_719_8 + var_719_0 > arg_716_1.duration_ then
						arg_716_1.duration_ = var_719_8 + var_719_0
					end

					if var_719_3.prefab_name ~= "" and arg_716_1.actors_[var_719_3.prefab_name] ~= nil then
						local var_719_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_716_1.actors_[var_719_3.prefab_name].transform, "story_v_out_120431", "120431174", "story_v_out_120431.awb")

						arg_716_1:RecordAudio("120431174", var_719_9)
						arg_716_1:RecordAudio("120431174", var_719_9)
					else
						arg_716_1:AudioAction("play", "voice", "story_v_out_120431", "120431174", "story_v_out_120431.awb")
					end

					arg_716_1:RecordHistoryTalkVoice("story_v_out_120431", "120431174", "story_v_out_120431.awb")
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
	Play120431175 = function(arg_720_0, arg_720_1)
		arg_720_1.time_ = 0
		arg_720_1.frameCnt_ = 0
		arg_720_1.state_ = "playing"
		arg_720_1.curTalkId_ = 120431175
		arg_720_1.duration_ = 13.8

		local var_720_0 = {
			zh = 7.9,
			ja = 13.8
		}
		local var_720_1 = manager.audio:GetLocalizationFlag()

		if var_720_0[var_720_1] ~= nil then
			arg_720_1.duration_ = var_720_0[var_720_1]
		end

		SetActive(arg_720_1.tipsGo_, false)

		function arg_720_1.onSingleLineFinish_()
			arg_720_1.onSingleLineUpdate_ = nil
			arg_720_1.onSingleLineFinish_ = nil
			arg_720_1.state_ = "waiting"
			arg_720_1.auto_ = false
		end

		function arg_720_1.playNext_(arg_722_0)
			arg_720_1.onStoryFinished_()
		end

		function arg_720_1.onSingleLineUpdate_(arg_723_0)
			local var_723_0 = 0
			local var_723_1 = 0.675

			if var_723_0 < arg_720_1.time_ and arg_720_1.time_ <= var_723_0 + arg_723_0 then
				arg_720_1.talkMaxDuration = 0
				arg_720_1.dialogCg_.alpha = 1

				arg_720_1.dialog_:SetActive(true)
				SetActive(arg_720_1.leftNameGo_, true)

				local var_723_2 = arg_720_1:FormatText(StoryNameCfg[389].name)

				arg_720_1.leftNameTxt_.text = var_723_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_720_1.leftNameTxt_.transform)

				arg_720_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_720_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_720_1:RecordName(arg_720_1.leftNameTxt_.text)
				SetActive(arg_720_1.iconTrs_.gameObject, false)
				arg_720_1.callingController_:SetSelectedState("normal")

				local var_723_3 = arg_720_1:GetWordFromCfg(120431175)
				local var_723_4 = arg_720_1:FormatText(var_723_3.content)

				arg_720_1.text_.text = var_723_4

				LuaForUtil.ClearLinePrefixSymbol(arg_720_1.text_)

				local var_723_5 = 27
				local var_723_6 = utf8.len(var_723_4)
				local var_723_7 = var_723_5 <= 0 and var_723_1 or var_723_1 * (var_723_6 / var_723_5)

				if var_723_7 > 0 and var_723_1 < var_723_7 then
					arg_720_1.talkMaxDuration = var_723_7

					if var_723_7 + var_723_0 > arg_720_1.duration_ then
						arg_720_1.duration_ = var_723_7 + var_723_0
					end
				end

				arg_720_1.text_.text = var_723_4
				arg_720_1.typewritter.percent = 0

				arg_720_1.typewritter:SetDirty()
				arg_720_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120431", "120431175", "story_v_out_120431.awb") ~= 0 then
					local var_723_8 = manager.audio:GetVoiceLength("story_v_out_120431", "120431175", "story_v_out_120431.awb") / 1000

					if var_723_8 + var_723_0 > arg_720_1.duration_ then
						arg_720_1.duration_ = var_723_8 + var_723_0
					end

					if var_723_3.prefab_name ~= "" and arg_720_1.actors_[var_723_3.prefab_name] ~= nil then
						local var_723_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_720_1.actors_[var_723_3.prefab_name].transform, "story_v_out_120431", "120431175", "story_v_out_120431.awb")

						arg_720_1:RecordAudio("120431175", var_723_9)
						arg_720_1:RecordAudio("120431175", var_723_9)
					else
						arg_720_1:AudioAction("play", "voice", "story_v_out_120431", "120431175", "story_v_out_120431.awb")
					end

					arg_720_1:RecordHistoryTalkVoice("story_v_out_120431", "120431175", "story_v_out_120431.awb")
				end

				arg_720_1:RecordContent(arg_720_1.text_.text)
			end

			local var_723_10 = math.max(var_723_1, arg_720_1.talkMaxDuration)

			if var_723_0 <= arg_720_1.time_ and arg_720_1.time_ < var_723_0 + var_723_10 then
				arg_720_1.typewritter.percent = (arg_720_1.time_ - var_723_0) / var_723_10

				arg_720_1.typewritter:SetDirty()
			end

			if arg_720_1.time_ >= var_723_0 + var_723_10 and arg_720_1.time_ < var_723_0 + var_723_10 + arg_723_0 then
				arg_720_1.typewritter.percent = 1

				arg_720_1.typewritter:SetDirty()
				arg_720_1:ShowNextGo(true)
			end
		end

		arg_720_1.nodeConfigList_ = {}

		arg_720_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST31",
		"TextureConfig/Background/ST32a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/XH0205",
		"TextureConfig/Background/ST31a",
		"TextureConfig/Background/XH0206"
	},
	voices = {
		"story_v_out_120431.awb"
	}
}
