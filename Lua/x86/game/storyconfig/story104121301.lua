return {
	Play412131001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 412131001
		arg_1_1.duration_ = 10.13

		local var_1_0 = {
			zh = 9.46600000298023,
			ja = 10.1330000029802
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
				arg_1_0:Play412131002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST84a"

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
				local var_4_5 = arg_1_1.bgs_.ST84a

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
					if iter_4_0 ~= "ST84a" then
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

			local var_4_24 = "1066ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1066ui_story"].transform
			local var_4_30 = 1.8

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1066ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, -0.77, -6.1)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1066ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["1066ui_story"]
			local var_4_39 = 1.8

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1066ui_story == nil then
				arg_1_1.var_.characterEffect1066ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect1066ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1066ui_story then
				arg_1_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_4_42 = 1.8

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			local var_4_43 = 1.8

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_4_44 = 0
			local var_4_45 = 0.233333333333333

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

			local var_4_50 = 0.266666666666667
			local var_4_51 = 1

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_52 = "play"
				local var_4_53 = "music"

				arg_1_1:AudioAction(var_4_52, var_4_53, "bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream.awb")

				local var_4_54 = ""
				local var_4_55 = manager.audio:GetAudioName("bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_56 = 2.00000000298023
			local var_4_57 = 1.025

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_58 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_58:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_59 = arg_1_1:FormatText(StoryNameCfg[32].name)

				arg_1_1.leftNameTxt_.text = var_4_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_60 = arg_1_1:GetWordFromCfg(412131001)
				local var_4_61 = arg_1_1:FormatText(var_4_60.content)

				arg_1_1.text_.text = var_4_61

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_62 = 41
				local var_4_63 = utf8.len(var_4_61)
				local var_4_64 = var_4_62 <= 0 and var_4_57 or var_4_57 * (var_4_63 / var_4_62)

				if var_4_64 > 0 and var_4_57 < var_4_64 then
					arg_1_1.talkMaxDuration = var_4_64
					var_4_56 = var_4_56 + 0.3

					if var_4_64 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_64 + var_4_56
					end
				end

				arg_1_1.text_.text = var_4_61
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131001", "story_v_out_412131.awb") ~= 0 then
					local var_4_65 = manager.audio:GetVoiceLength("story_v_out_412131", "412131001", "story_v_out_412131.awb") / 1000

					if var_4_65 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_56
					end

					if var_4_60.prefab_name ~= "" and arg_1_1.actors_[var_4_60.prefab_name] ~= nil then
						local var_4_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_60.prefab_name].transform, "story_v_out_412131", "412131001", "story_v_out_412131.awb")

						arg_1_1:RecordAudio("412131001", var_4_66)
						arg_1_1:RecordAudio("412131001", var_4_66)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_412131", "412131001", "story_v_out_412131.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_412131", "412131001", "story_v_out_412131.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_67 = var_4_56 + 0.3
			local var_4_68 = math.max(var_4_57, arg_1_1.talkMaxDuration)

			if var_4_67 <= arg_1_1.time_ and arg_1_1.time_ < var_4_67 + var_4_68 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_67) / var_4_68

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_67 + var_4_68 and arg_1_1.time_ < var_4_67 + var_4_68 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play412131002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 412131002
		arg_9_1.duration_ = 13

		local var_9_0 = {
			zh = 9.4,
			ja = 13
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
				arg_9_0:Play412131003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.175

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[32].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:GetWordFromCfg(412131002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 47
				local var_12_6 = utf8.len(var_12_4)
				local var_12_7 = var_12_5 <= 0 and var_12_1 or var_12_1 * (var_12_6 / var_12_5)

				if var_12_7 > 0 and var_12_1 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131002", "story_v_out_412131.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_412131", "412131002", "story_v_out_412131.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_412131", "412131002", "story_v_out_412131.awb")

						arg_9_1:RecordAudio("412131002", var_12_9)
						arg_9_1:RecordAudio("412131002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_412131", "412131002", "story_v_out_412131.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_412131", "412131002", "story_v_out_412131.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_10 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_10 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_10

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_10 and arg_9_1.time_ < var_12_0 + var_12_10 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play412131003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 412131003
		arg_13_1.duration_ = 5.87

		local var_13_0 = {
			zh = 2.7,
			ja = 5.866
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
				arg_13_0:Play412131004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1097ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1097ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["1097ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos1097ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(0, -0.54, -6.3)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1097ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["1097ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1097ui_story == nil then
				arg_13_1.var_.characterEffect1097ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect1097ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1097ui_story then
				arg_13_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_16_20 = arg_13_1.actors_["1066ui_story"].transform
			local var_16_21 = 0

			if var_16_21 < arg_13_1.time_ and arg_13_1.time_ <= var_16_21 + arg_16_0 then
				arg_13_1.var_.moveOldPos1066ui_story = var_16_20.localPosition
			end

			local var_16_22 = 0.001

			if var_16_21 <= arg_13_1.time_ and arg_13_1.time_ < var_16_21 + var_16_22 then
				local var_16_23 = (arg_13_1.time_ - var_16_21) / var_16_22
				local var_16_24 = Vector3.New(0, 100, 0)

				var_16_20.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1066ui_story, var_16_24, var_16_23)

				local var_16_25 = manager.ui.mainCamera.transform.position - var_16_20.position

				var_16_20.forward = Vector3.New(var_16_25.x, var_16_25.y, var_16_25.z)

				local var_16_26 = var_16_20.localEulerAngles

				var_16_26.z = 0
				var_16_26.x = 0
				var_16_20.localEulerAngles = var_16_26
			end

			if arg_13_1.time_ >= var_16_21 + var_16_22 and arg_13_1.time_ < var_16_21 + var_16_22 + arg_16_0 then
				var_16_20.localPosition = Vector3.New(0, 100, 0)

				local var_16_27 = manager.ui.mainCamera.transform.position - var_16_20.position

				var_16_20.forward = Vector3.New(var_16_27.x, var_16_27.y, var_16_27.z)

				local var_16_28 = var_16_20.localEulerAngles

				var_16_28.z = 0
				var_16_28.x = 0
				var_16_20.localEulerAngles = var_16_28
			end

			local var_16_29 = arg_13_1.actors_["1066ui_story"]
			local var_16_30 = 0

			if var_16_30 < arg_13_1.time_ and arg_13_1.time_ <= var_16_30 + arg_16_0 and not isNil(var_16_29) and arg_13_1.var_.characterEffect1066ui_story == nil then
				arg_13_1.var_.characterEffect1066ui_story = var_16_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_31 = 0.200000002980232

			if var_16_30 <= arg_13_1.time_ and arg_13_1.time_ < var_16_30 + var_16_31 and not isNil(var_16_29) then
				local var_16_32 = (arg_13_1.time_ - var_16_30) / var_16_31

				if arg_13_1.var_.characterEffect1066ui_story and not isNil(var_16_29) then
					local var_16_33 = Mathf.Lerp(0, 0.5, var_16_32)

					arg_13_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1066ui_story.fillRatio = var_16_33
				end
			end

			if arg_13_1.time_ >= var_16_30 + var_16_31 and arg_13_1.time_ < var_16_30 + var_16_31 + arg_16_0 and not isNil(var_16_29) and arg_13_1.var_.characterEffect1066ui_story then
				local var_16_34 = 0.5

				arg_13_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1066ui_story.fillRatio = var_16_34
			end

			local var_16_35 = 0
			local var_16_36 = 0.25

			if var_16_35 < arg_13_1.time_ and arg_13_1.time_ <= var_16_35 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_37 = arg_13_1:FormatText(StoryNameCfg[216].name)

				arg_13_1.leftNameTxt_.text = var_16_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_38 = arg_13_1:GetWordFromCfg(412131003)
				local var_16_39 = arg_13_1:FormatText(var_16_38.content)

				arg_13_1.text_.text = var_16_39

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_40 = 10
				local var_16_41 = utf8.len(var_16_39)
				local var_16_42 = var_16_40 <= 0 and var_16_36 or var_16_36 * (var_16_41 / var_16_40)

				if var_16_42 > 0 and var_16_36 < var_16_42 then
					arg_13_1.talkMaxDuration = var_16_42

					if var_16_42 + var_16_35 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_42 + var_16_35
					end
				end

				arg_13_1.text_.text = var_16_39
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131003", "story_v_out_412131.awb") ~= 0 then
					local var_16_43 = manager.audio:GetVoiceLength("story_v_out_412131", "412131003", "story_v_out_412131.awb") / 1000

					if var_16_43 + var_16_35 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_43 + var_16_35
					end

					if var_16_38.prefab_name ~= "" and arg_13_1.actors_[var_16_38.prefab_name] ~= nil then
						local var_16_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_38.prefab_name].transform, "story_v_out_412131", "412131003", "story_v_out_412131.awb")

						arg_13_1:RecordAudio("412131003", var_16_44)
						arg_13_1:RecordAudio("412131003", var_16_44)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_412131", "412131003", "story_v_out_412131.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_412131", "412131003", "story_v_out_412131.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_45 = math.max(var_16_36, arg_13_1.talkMaxDuration)

			if var_16_35 <= arg_13_1.time_ and arg_13_1.time_ < var_16_35 + var_16_45 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_35) / var_16_45

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_35 + var_16_45 and arg_13_1.time_ < var_16_35 + var_16_45 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play412131004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 412131004
		arg_17_1.duration_ = 6.33

		local var_17_0 = {
			zh = 6.333,
			ja = 5.833
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play412131005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1066ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1066ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, -0.77, -6.1)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1066ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = arg_17_1.actors_["1066ui_story"]
			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1066ui_story == nil then
				arg_17_1.var_.characterEffect1066ui_story = var_20_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 and not isNil(var_20_9) then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11

				if arg_17_1.var_.characterEffect1066ui_story and not isNil(var_20_9) then
					arg_17_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1066ui_story then
				arg_17_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_20_13 = 0

			if var_20_13 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 then
				arg_17_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_2")
			end

			local var_20_14 = 0

			if var_20_14 < arg_17_1.time_ and arg_17_1.time_ <= var_20_14 + arg_20_0 then
				arg_17_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_20_15 = arg_17_1.actors_["1097ui_story"].transform
			local var_20_16 = 0

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1.var_.moveOldPos1097ui_story = var_20_15.localPosition
			end

			local var_20_17 = 0.001

			if var_20_16 <= arg_17_1.time_ and arg_17_1.time_ < var_20_16 + var_20_17 then
				local var_20_18 = (arg_17_1.time_ - var_20_16) / var_20_17
				local var_20_19 = Vector3.New(0, 100, 0)

				var_20_15.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1097ui_story, var_20_19, var_20_18)

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

			local var_20_24 = 0
			local var_20_25 = 0.575

			if var_20_24 < arg_17_1.time_ and arg_17_1.time_ <= var_20_24 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_26 = arg_17_1:FormatText(StoryNameCfg[32].name)

				arg_17_1.leftNameTxt_.text = var_20_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_27 = arg_17_1:GetWordFromCfg(412131004)
				local var_20_28 = arg_17_1:FormatText(var_20_27.content)

				arg_17_1.text_.text = var_20_28

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_29 = 23
				local var_20_30 = utf8.len(var_20_28)
				local var_20_31 = var_20_29 <= 0 and var_20_25 or var_20_25 * (var_20_30 / var_20_29)

				if var_20_31 > 0 and var_20_25 < var_20_31 then
					arg_17_1.talkMaxDuration = var_20_31

					if var_20_31 + var_20_24 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_31 + var_20_24
					end
				end

				arg_17_1.text_.text = var_20_28
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131004", "story_v_out_412131.awb") ~= 0 then
					local var_20_32 = manager.audio:GetVoiceLength("story_v_out_412131", "412131004", "story_v_out_412131.awb") / 1000

					if var_20_32 + var_20_24 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_32 + var_20_24
					end

					if var_20_27.prefab_name ~= "" and arg_17_1.actors_[var_20_27.prefab_name] ~= nil then
						local var_20_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_27.prefab_name].transform, "story_v_out_412131", "412131004", "story_v_out_412131.awb")

						arg_17_1:RecordAudio("412131004", var_20_33)
						arg_17_1:RecordAudio("412131004", var_20_33)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_412131", "412131004", "story_v_out_412131.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_412131", "412131004", "story_v_out_412131.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_34 = math.max(var_20_25, arg_17_1.talkMaxDuration)

			if var_20_24 <= arg_17_1.time_ and arg_17_1.time_ < var_20_24 + var_20_34 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_24) / var_20_34

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_24 + var_20_34 and arg_17_1.time_ < var_20_24 + var_20_34 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412131005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 412131005
		arg_21_1.duration_ = 7.1

		local var_21_0 = {
			zh = 7.10000000298023,
			ja = 7.00000000298023
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
				arg_21_0:Play412131006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "F01a"

			if arg_21_1.bgs_[var_24_0] == nil then
				local var_24_1 = Object.Instantiate(arg_21_1.paintGo_)

				var_24_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_24_0)
				var_24_1.name = var_24_0
				var_24_1.transform.parent = arg_21_1.stage_.transform
				var_24_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.bgs_[var_24_0] = var_24_1
			end

			local var_24_2 = 2.00000000298023

			if var_24_2 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				local var_24_3 = manager.ui.mainCamera.transform.localPosition
				local var_24_4 = Vector3.New(0, 0, 10) + Vector3.New(var_24_3.x, var_24_3.y, 0)
				local var_24_5 = arg_21_1.bgs_.F01a

				var_24_5.transform.localPosition = var_24_4
				var_24_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_24_6 = var_24_5:GetComponent("SpriteRenderer")

				if var_24_6 and var_24_6.sprite then
					local var_24_7 = (var_24_5.transform.localPosition - var_24_3).z
					local var_24_8 = manager.ui.mainCameraCom_
					local var_24_9 = 2 * var_24_7 * Mathf.Tan(var_24_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_24_10 = var_24_9 * var_24_8.aspect
					local var_24_11 = var_24_6.sprite.bounds.size.x
					local var_24_12 = var_24_6.sprite.bounds.size.y
					local var_24_13 = var_24_10 / var_24_11
					local var_24_14 = var_24_9 / var_24_12
					local var_24_15 = var_24_14 < var_24_13 and var_24_13 or var_24_14

					var_24_5.transform.localScale = Vector3.New(var_24_15, var_24_15, 0)
				end

				for iter_24_0, iter_24_1 in pairs(arg_21_1.bgs_) do
					if iter_24_0 ~= "F01a" then
						iter_24_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_24_16 = 4.00000000298023

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.allBtn_.enabled = false
			end

			local var_24_17 = 0.3

			if arg_21_1.time_ >= var_24_16 + var_24_17 and arg_21_1.time_ < var_24_16 + var_24_17 + arg_24_0 then
				arg_21_1.allBtn_.enabled = true
			end

			local var_24_18 = 0

			if var_24_18 < arg_21_1.time_ and arg_21_1.time_ <= var_24_18 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_19 = 2

			if var_24_18 <= arg_21_1.time_ and arg_21_1.time_ < var_24_18 + var_24_19 then
				local var_24_20 = (arg_21_1.time_ - var_24_18) / var_24_19
				local var_24_21 = Color.New(0, 0, 0)

				var_24_21.a = Mathf.Lerp(0, 1, var_24_20)
				arg_21_1.mask_.color = var_24_21
			end

			if arg_21_1.time_ >= var_24_18 + var_24_19 and arg_21_1.time_ < var_24_18 + var_24_19 + arg_24_0 then
				local var_24_22 = Color.New(0, 0, 0)

				var_24_22.a = 1
				arg_21_1.mask_.color = var_24_22
			end

			local var_24_23 = 2.00000000298023

			if var_24_23 < arg_21_1.time_ and arg_21_1.time_ <= var_24_23 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_24 = 2

			if var_24_23 <= arg_21_1.time_ and arg_21_1.time_ < var_24_23 + var_24_24 then
				local var_24_25 = (arg_21_1.time_ - var_24_23) / var_24_24
				local var_24_26 = Color.New(0, 0, 0)

				var_24_26.a = Mathf.Lerp(1, 0, var_24_25)
				arg_21_1.mask_.color = var_24_26
			end

			if arg_21_1.time_ >= var_24_23 + var_24_24 and arg_21_1.time_ < var_24_23 + var_24_24 + arg_24_0 then
				local var_24_27 = Color.New(0, 0, 0)
				local var_24_28 = 0

				arg_21_1.mask_.enabled = false
				var_24_27.a = var_24_28
				arg_21_1.mask_.color = var_24_27
			end

			local var_24_29 = "6046ui_story"

			if arg_21_1.actors_[var_24_29] == nil then
				local var_24_30 = Asset.Load("Char/" .. "6046ui_story")

				if not isNil(var_24_30) then
					local var_24_31 = Object.Instantiate(Asset.Load("Char/" .. "6046ui_story"), arg_21_1.stage_.transform)

					var_24_31.name = var_24_29
					var_24_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_29] = var_24_31

					local var_24_32 = var_24_31:GetComponentInChildren(typeof(CharacterEffect))

					var_24_32.enabled = true

					local var_24_33 = GameObjectTools.GetOrAddComponent(var_24_31, typeof(DynamicBoneHelper))

					if var_24_33 then
						var_24_33:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_32.transform, false)

					arg_21_1.var_[var_24_29 .. "Animator"] = var_24_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_29 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_29 .. "LipSync"] = var_24_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_34 = arg_21_1.actors_["6046ui_story"].transform
			local var_24_35 = 3.8

			if var_24_35 < arg_21_1.time_ and arg_21_1.time_ <= var_24_35 + arg_24_0 then
				arg_21_1.var_.moveOldPos6046ui_story = var_24_34.localPosition
			end

			local var_24_36 = 0.001

			if var_24_35 <= arg_21_1.time_ and arg_21_1.time_ < var_24_35 + var_24_36 then
				local var_24_37 = (arg_21_1.time_ - var_24_35) / var_24_36
				local var_24_38 = Vector3.New(-0.7, -0.5, -6.3)

				var_24_34.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos6046ui_story, var_24_38, var_24_37)

				local var_24_39 = manager.ui.mainCamera.transform.position - var_24_34.position

				var_24_34.forward = Vector3.New(var_24_39.x, var_24_39.y, var_24_39.z)

				local var_24_40 = var_24_34.localEulerAngles

				var_24_40.z = 0
				var_24_40.x = 0
				var_24_34.localEulerAngles = var_24_40
			end

			if arg_21_1.time_ >= var_24_35 + var_24_36 and arg_21_1.time_ < var_24_35 + var_24_36 + arg_24_0 then
				var_24_34.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_24_41 = manager.ui.mainCamera.transform.position - var_24_34.position

				var_24_34.forward = Vector3.New(var_24_41.x, var_24_41.y, var_24_41.z)

				local var_24_42 = var_24_34.localEulerAngles

				var_24_42.z = 0
				var_24_42.x = 0
				var_24_34.localEulerAngles = var_24_42
			end

			local var_24_43 = arg_21_1.actors_["6046ui_story"]
			local var_24_44 = 3.8

			if var_24_44 < arg_21_1.time_ and arg_21_1.time_ <= var_24_44 + arg_24_0 and not isNil(var_24_43) and arg_21_1.var_.characterEffect6046ui_story == nil then
				arg_21_1.var_.characterEffect6046ui_story = var_24_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_45 = 0.200000002980232

			if var_24_44 <= arg_21_1.time_ and arg_21_1.time_ < var_24_44 + var_24_45 and not isNil(var_24_43) then
				local var_24_46 = (arg_21_1.time_ - var_24_44) / var_24_45

				if arg_21_1.var_.characterEffect6046ui_story and not isNil(var_24_43) then
					arg_21_1.var_.characterEffect6046ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_44 + var_24_45 and arg_21_1.time_ < var_24_44 + var_24_45 + arg_24_0 and not isNil(var_24_43) and arg_21_1.var_.characterEffect6046ui_story then
				arg_21_1.var_.characterEffect6046ui_story.fillFlat = false
			end

			local var_24_47 = 3.8

			if var_24_47 < arg_21_1.time_ and arg_21_1.time_ <= var_24_47 + arg_24_0 then
				arg_21_1:PlayTimeline("6046ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_24_48 = 3.8

			if var_24_48 < arg_21_1.time_ and arg_21_1.time_ <= var_24_48 + arg_24_0 then
				arg_21_1:PlayTimeline("6046ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_49 = arg_21_1.actors_["1066ui_story"].transform
			local var_24_50 = 1.96599999815226

			if var_24_50 < arg_21_1.time_ and arg_21_1.time_ <= var_24_50 + arg_24_0 then
				arg_21_1.var_.moveOldPos1066ui_story = var_24_49.localPosition
			end

			local var_24_51 = 0.001

			if var_24_50 <= arg_21_1.time_ and arg_21_1.time_ < var_24_50 + var_24_51 then
				local var_24_52 = (arg_21_1.time_ - var_24_50) / var_24_51
				local var_24_53 = Vector3.New(0, 100, 0)

				var_24_49.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1066ui_story, var_24_53, var_24_52)

				local var_24_54 = manager.ui.mainCamera.transform.position - var_24_49.position

				var_24_49.forward = Vector3.New(var_24_54.x, var_24_54.y, var_24_54.z)

				local var_24_55 = var_24_49.localEulerAngles

				var_24_55.z = 0
				var_24_55.x = 0
				var_24_49.localEulerAngles = var_24_55
			end

			if arg_21_1.time_ >= var_24_50 + var_24_51 and arg_21_1.time_ < var_24_50 + var_24_51 + arg_24_0 then
				var_24_49.localPosition = Vector3.New(0, 100, 0)

				local var_24_56 = manager.ui.mainCamera.transform.position - var_24_49.position

				var_24_49.forward = Vector3.New(var_24_56.x, var_24_56.y, var_24_56.z)

				local var_24_57 = var_24_49.localEulerAngles

				var_24_57.z = 0
				var_24_57.x = 0
				var_24_49.localEulerAngles = var_24_57
			end

			local var_24_58 = arg_21_1.actors_["1066ui_story"]
			local var_24_59 = 1.96599999815226

			if var_24_59 < arg_21_1.time_ and arg_21_1.time_ <= var_24_59 + arg_24_0 and not isNil(var_24_58) and arg_21_1.var_.characterEffect1066ui_story == nil then
				arg_21_1.var_.characterEffect1066ui_story = var_24_58:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_60 = 0.034000001847744

			if var_24_59 <= arg_21_1.time_ and arg_21_1.time_ < var_24_59 + var_24_60 and not isNil(var_24_58) then
				local var_24_61 = (arg_21_1.time_ - var_24_59) / var_24_60

				if arg_21_1.var_.characterEffect1066ui_story and not isNil(var_24_58) then
					local var_24_62 = Mathf.Lerp(0, 0.5, var_24_61)

					arg_21_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1066ui_story.fillRatio = var_24_62
				end
			end

			if arg_21_1.time_ >= var_24_59 + var_24_60 and arg_21_1.time_ < var_24_59 + var_24_60 + arg_24_0 and not isNil(var_24_58) and arg_21_1.var_.characterEffect1066ui_story then
				local var_24_63 = 0.5

				arg_21_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1066ui_story.fillRatio = var_24_63
			end

			if arg_21_1.frameCnt_ <= 1 then
				arg_21_1.dialog_:SetActive(false)
			end

			local var_24_64 = 4.00000000298023
			local var_24_65 = 0.325

			if var_24_64 < arg_21_1.time_ and arg_21_1.time_ <= var_24_64 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_66 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_66:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_66:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_66:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_67 = arg_21_1:FormatText(StoryNameCfg[214].name)

				arg_21_1.leftNameTxt_.text = var_24_67

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_68 = arg_21_1:GetWordFromCfg(412131005)
				local var_24_69 = arg_21_1:FormatText(var_24_68.content)

				arg_21_1.text_.text = var_24_69

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_70 = 13
				local var_24_71 = utf8.len(var_24_69)
				local var_24_72 = var_24_70 <= 0 and var_24_65 or var_24_65 * (var_24_71 / var_24_70)

				if var_24_72 > 0 and var_24_65 < var_24_72 then
					arg_21_1.talkMaxDuration = var_24_72
					var_24_64 = var_24_64 + 0.3

					if var_24_72 + var_24_64 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_72 + var_24_64
					end
				end

				arg_21_1.text_.text = var_24_69
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131005", "story_v_out_412131.awb") ~= 0 then
					local var_24_73 = manager.audio:GetVoiceLength("story_v_out_412131", "412131005", "story_v_out_412131.awb") / 1000

					if var_24_73 + var_24_64 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_73 + var_24_64
					end

					if var_24_68.prefab_name ~= "" and arg_21_1.actors_[var_24_68.prefab_name] ~= nil then
						local var_24_74 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_68.prefab_name].transform, "story_v_out_412131", "412131005", "story_v_out_412131.awb")

						arg_21_1:RecordAudio("412131005", var_24_74)
						arg_21_1:RecordAudio("412131005", var_24_74)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_412131", "412131005", "story_v_out_412131.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_412131", "412131005", "story_v_out_412131.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_75 = var_24_64 + 0.3
			local var_24_76 = math.max(var_24_65, arg_21_1.talkMaxDuration)

			if var_24_75 <= arg_21_1.time_ and arg_21_1.time_ < var_24_75 + var_24_76 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_75) / var_24_76

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_75 + var_24_76 and arg_21_1.time_ < var_24_75 + var_24_76 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play412131006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 412131006
		arg_27_1.duration_ = 5.3

		local var_27_0 = {
			zh = 4.6,
			ja = 5.3
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
				arg_27_0:Play412131007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = "6045ui_story"

			if arg_27_1.actors_[var_30_0] == nil then
				local var_30_1 = Asset.Load("Char/" .. "6045ui_story")

				if not isNil(var_30_1) then
					local var_30_2 = Object.Instantiate(Asset.Load("Char/" .. "6045ui_story"), arg_27_1.stage_.transform)

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

			local var_30_5 = arg_27_1.actors_["6045ui_story"].transform
			local var_30_6 = 0

			if var_30_6 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 then
				arg_27_1.var_.moveOldPos6045ui_story = var_30_5.localPosition
			end

			local var_30_7 = 0.001

			if var_30_6 <= arg_27_1.time_ and arg_27_1.time_ < var_30_6 + var_30_7 then
				local var_30_8 = (arg_27_1.time_ - var_30_6) / var_30_7
				local var_30_9 = Vector3.New(0.7, -0.5, -6.3)

				var_30_5.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos6045ui_story, var_30_9, var_30_8)

				local var_30_10 = manager.ui.mainCamera.transform.position - var_30_5.position

				var_30_5.forward = Vector3.New(var_30_10.x, var_30_10.y, var_30_10.z)

				local var_30_11 = var_30_5.localEulerAngles

				var_30_11.z = 0
				var_30_11.x = 0
				var_30_5.localEulerAngles = var_30_11
			end

			if arg_27_1.time_ >= var_30_6 + var_30_7 and arg_27_1.time_ < var_30_6 + var_30_7 + arg_30_0 then
				var_30_5.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_30_12 = manager.ui.mainCamera.transform.position - var_30_5.position

				var_30_5.forward = Vector3.New(var_30_12.x, var_30_12.y, var_30_12.z)

				local var_30_13 = var_30_5.localEulerAngles

				var_30_13.z = 0
				var_30_13.x = 0
				var_30_5.localEulerAngles = var_30_13
			end

			local var_30_14 = arg_27_1.actors_["6045ui_story"]
			local var_30_15 = 0

			if var_30_15 < arg_27_1.time_ and arg_27_1.time_ <= var_30_15 + arg_30_0 and not isNil(var_30_14) and arg_27_1.var_.characterEffect6045ui_story == nil then
				arg_27_1.var_.characterEffect6045ui_story = var_30_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_16 = 0.200000002980232

			if var_30_15 <= arg_27_1.time_ and arg_27_1.time_ < var_30_15 + var_30_16 and not isNil(var_30_14) then
				local var_30_17 = (arg_27_1.time_ - var_30_15) / var_30_16

				if arg_27_1.var_.characterEffect6045ui_story and not isNil(var_30_14) then
					arg_27_1.var_.characterEffect6045ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_15 + var_30_16 and arg_27_1.time_ < var_30_15 + var_30_16 + arg_30_0 and not isNil(var_30_14) and arg_27_1.var_.characterEffect6045ui_story then
				arg_27_1.var_.characterEffect6045ui_story.fillFlat = false
			end

			local var_30_18 = 0

			if var_30_18 < arg_27_1.time_ and arg_27_1.time_ <= var_30_18 + arg_30_0 then
				arg_27_1:PlayTimeline("6045ui_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_30_19 = 0

			if var_30_19 < arg_27_1.time_ and arg_27_1.time_ <= var_30_19 + arg_30_0 then
				arg_27_1:PlayTimeline("6045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_30_20 = arg_27_1.actors_["6046ui_story"]
			local var_30_21 = 0

			if var_30_21 < arg_27_1.time_ and arg_27_1.time_ <= var_30_21 + arg_30_0 and not isNil(var_30_20) and arg_27_1.var_.characterEffect6046ui_story == nil then
				arg_27_1.var_.characterEffect6046ui_story = var_30_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_22 = 0.200000002980232

			if var_30_21 <= arg_27_1.time_ and arg_27_1.time_ < var_30_21 + var_30_22 and not isNil(var_30_20) then
				local var_30_23 = (arg_27_1.time_ - var_30_21) / var_30_22

				if arg_27_1.var_.characterEffect6046ui_story and not isNil(var_30_20) then
					local var_30_24 = Mathf.Lerp(0, 0.5, var_30_23)

					arg_27_1.var_.characterEffect6046ui_story.fillFlat = true
					arg_27_1.var_.characterEffect6046ui_story.fillRatio = var_30_24
				end
			end

			if arg_27_1.time_ >= var_30_21 + var_30_22 and arg_27_1.time_ < var_30_21 + var_30_22 + arg_30_0 and not isNil(var_30_20) and arg_27_1.var_.characterEffect6046ui_story then
				local var_30_25 = 0.5

				arg_27_1.var_.characterEffect6046ui_story.fillFlat = true
				arg_27_1.var_.characterEffect6046ui_story.fillRatio = var_30_25
			end

			local var_30_26 = 0
			local var_30_27 = 0.425

			if var_30_26 < arg_27_1.time_ and arg_27_1.time_ <= var_30_26 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_28 = arg_27_1:FormatText(StoryNameCfg[215].name)

				arg_27_1.leftNameTxt_.text = var_30_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_29 = arg_27_1:GetWordFromCfg(412131006)
				local var_30_30 = arg_27_1:FormatText(var_30_29.content)

				arg_27_1.text_.text = var_30_30

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_31 = 17
				local var_30_32 = utf8.len(var_30_30)
				local var_30_33 = var_30_31 <= 0 and var_30_27 or var_30_27 * (var_30_32 / var_30_31)

				if var_30_33 > 0 and var_30_27 < var_30_33 then
					arg_27_1.talkMaxDuration = var_30_33

					if var_30_33 + var_30_26 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_33 + var_30_26
					end
				end

				arg_27_1.text_.text = var_30_30
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131006", "story_v_out_412131.awb") ~= 0 then
					local var_30_34 = manager.audio:GetVoiceLength("story_v_out_412131", "412131006", "story_v_out_412131.awb") / 1000

					if var_30_34 + var_30_26 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_34 + var_30_26
					end

					if var_30_29.prefab_name ~= "" and arg_27_1.actors_[var_30_29.prefab_name] ~= nil then
						local var_30_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_29.prefab_name].transform, "story_v_out_412131", "412131006", "story_v_out_412131.awb")

						arg_27_1:RecordAudio("412131006", var_30_35)
						arg_27_1:RecordAudio("412131006", var_30_35)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_412131", "412131006", "story_v_out_412131.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_412131", "412131006", "story_v_out_412131.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_36 = math.max(var_30_27, arg_27_1.talkMaxDuration)

			if var_30_26 <= arg_27_1.time_ and arg_27_1.time_ < var_30_26 + var_30_36 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_26) / var_30_36

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_26 + var_30_36 and arg_27_1.time_ < var_30_26 + var_30_36 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045ui_story",
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
	Play412131007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 412131007
		arg_31_1.duration_ = 8.17

		local var_31_0 = {
			zh = 8.166,
			ja = 3.6
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
				arg_31_0:Play412131008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["6046ui_story"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos6046ui_story = var_34_0.localPosition
			end

			local var_34_2 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2
				local var_34_4 = Vector3.New(-0.7, -0.5, -6.3)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos6046ui_story, var_34_4, var_34_3)

				local var_34_5 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_5.x, var_34_5.y, var_34_5.z)

				local var_34_6 = var_34_0.localEulerAngles

				var_34_6.z = 0
				var_34_6.x = 0
				var_34_0.localEulerAngles = var_34_6
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_34_7 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_7.x, var_34_7.y, var_34_7.z)

				local var_34_8 = var_34_0.localEulerAngles

				var_34_8.z = 0
				var_34_8.x = 0
				var_34_0.localEulerAngles = var_34_8
			end

			local var_34_9 = arg_31_1.actors_["6046ui_story"]
			local var_34_10 = 0

			if var_34_10 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 and not isNil(var_34_9) and arg_31_1.var_.characterEffect6046ui_story == nil then
				arg_31_1.var_.characterEffect6046ui_story = var_34_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_11 = 0.200000002980232

			if var_34_10 <= arg_31_1.time_ and arg_31_1.time_ < var_34_10 + var_34_11 and not isNil(var_34_9) then
				local var_34_12 = (arg_31_1.time_ - var_34_10) / var_34_11

				if arg_31_1.var_.characterEffect6046ui_story and not isNil(var_34_9) then
					arg_31_1.var_.characterEffect6046ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_10 + var_34_11 and arg_31_1.time_ < var_34_10 + var_34_11 + arg_34_0 and not isNil(var_34_9) and arg_31_1.var_.characterEffect6046ui_story then
				arg_31_1.var_.characterEffect6046ui_story.fillFlat = false
			end

			local var_34_13 = 0

			if var_34_13 < arg_31_1.time_ and arg_31_1.time_ <= var_34_13 + arg_34_0 then
				arg_31_1:PlayTimeline("6046ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_34_14 = 0

			if var_34_14 < arg_31_1.time_ and arg_31_1.time_ <= var_34_14 + arg_34_0 then
				arg_31_1:PlayTimeline("6046ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_34_15 = arg_31_1.actors_["6045ui_story"]
			local var_34_16 = 0

			if var_34_16 < arg_31_1.time_ and arg_31_1.time_ <= var_34_16 + arg_34_0 and not isNil(var_34_15) and arg_31_1.var_.characterEffect6045ui_story == nil then
				arg_31_1.var_.characterEffect6045ui_story = var_34_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_17 = 0.200000002980232

			if var_34_16 <= arg_31_1.time_ and arg_31_1.time_ < var_34_16 + var_34_17 and not isNil(var_34_15) then
				local var_34_18 = (arg_31_1.time_ - var_34_16) / var_34_17

				if arg_31_1.var_.characterEffect6045ui_story and not isNil(var_34_15) then
					local var_34_19 = Mathf.Lerp(0, 0.5, var_34_18)

					arg_31_1.var_.characterEffect6045ui_story.fillFlat = true
					arg_31_1.var_.characterEffect6045ui_story.fillRatio = var_34_19
				end
			end

			if arg_31_1.time_ >= var_34_16 + var_34_17 and arg_31_1.time_ < var_34_16 + var_34_17 + arg_34_0 and not isNil(var_34_15) and arg_31_1.var_.characterEffect6045ui_story then
				local var_34_20 = 0.5

				arg_31_1.var_.characterEffect6045ui_story.fillFlat = true
				arg_31_1.var_.characterEffect6045ui_story.fillRatio = var_34_20
			end

			local var_34_21 = 0
			local var_34_22 = 0.675

			if var_34_21 < arg_31_1.time_ and arg_31_1.time_ <= var_34_21 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_23 = arg_31_1:FormatText(StoryNameCfg[214].name)

				arg_31_1.leftNameTxt_.text = var_34_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_24 = arg_31_1:GetWordFromCfg(412131007)
				local var_34_25 = arg_31_1:FormatText(var_34_24.content)

				arg_31_1.text_.text = var_34_25

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_26 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131007", "story_v_out_412131.awb") ~= 0 then
					local var_34_29 = manager.audio:GetVoiceLength("story_v_out_412131", "412131007", "story_v_out_412131.awb") / 1000

					if var_34_29 + var_34_21 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_29 + var_34_21
					end

					if var_34_24.prefab_name ~= "" and arg_31_1.actors_[var_34_24.prefab_name] ~= nil then
						local var_34_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_24.prefab_name].transform, "story_v_out_412131", "412131007", "story_v_out_412131.awb")

						arg_31_1:RecordAudio("412131007", var_34_30)
						arg_31_1:RecordAudio("412131007", var_34_30)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_412131", "412131007", "story_v_out_412131.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_412131", "412131007", "story_v_out_412131.awb")
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
				actorName = "6046ui_story",
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
	Play412131008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 412131008
		arg_35_1.duration_ = 8.07

		local var_35_0 = {
			zh = 8.066,
			ja = 6.9
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play412131009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 0.85

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_2 = arg_35_1:FormatText(StoryNameCfg[214].name)

				arg_35_1.leftNameTxt_.text = var_38_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_3 = arg_35_1:GetWordFromCfg(412131008)
				local var_38_4 = arg_35_1:FormatText(var_38_3.content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 34
				local var_38_6 = utf8.len(var_38_4)
				local var_38_7 = var_38_5 <= 0 and var_38_1 or var_38_1 * (var_38_6 / var_38_5)

				if var_38_7 > 0 and var_38_1 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_0
					end
				end

				arg_35_1.text_.text = var_38_4
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131008", "story_v_out_412131.awb") ~= 0 then
					local var_38_8 = manager.audio:GetVoiceLength("story_v_out_412131", "412131008", "story_v_out_412131.awb") / 1000

					if var_38_8 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_8 + var_38_0
					end

					if var_38_3.prefab_name ~= "" and arg_35_1.actors_[var_38_3.prefab_name] ~= nil then
						local var_38_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_3.prefab_name].transform, "story_v_out_412131", "412131008", "story_v_out_412131.awb")

						arg_35_1:RecordAudio("412131008", var_38_9)
						arg_35_1:RecordAudio("412131008", var_38_9)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_412131", "412131008", "story_v_out_412131.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_412131", "412131008", "story_v_out_412131.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_10 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_10 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_10

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_10 and arg_35_1.time_ < var_38_0 + var_38_10 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play412131009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 412131009
		arg_39_1.duration_ = 2.47

		local var_39_0 = {
			zh = 2.466,
			ja = 2.133
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play412131010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["6046ui_story"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect6046ui_story == nil then
				arg_39_1.var_.characterEffect6046ui_story = var_42_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 and not isNil(var_42_0) then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2

				if arg_39_1.var_.characterEffect6046ui_story and not isNil(var_42_0) then
					local var_42_4 = Mathf.Lerp(0, 0.5, var_42_3)

					arg_39_1.var_.characterEffect6046ui_story.fillFlat = true
					arg_39_1.var_.characterEffect6046ui_story.fillRatio = var_42_4
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect6046ui_story then
				local var_42_5 = 0.5

				arg_39_1.var_.characterEffect6046ui_story.fillFlat = true
				arg_39_1.var_.characterEffect6046ui_story.fillRatio = var_42_5
			end

			local var_42_6 = arg_39_1.actors_["6045ui_story"]
			local var_42_7 = 0

			if var_42_7 < arg_39_1.time_ and arg_39_1.time_ <= var_42_7 + arg_42_0 and not isNil(var_42_6) and arg_39_1.var_.characterEffect6045ui_story == nil then
				arg_39_1.var_.characterEffect6045ui_story = var_42_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_8 = 0.200000002980232

			if var_42_7 <= arg_39_1.time_ and arg_39_1.time_ < var_42_7 + var_42_8 and not isNil(var_42_6) then
				local var_42_9 = (arg_39_1.time_ - var_42_7) / var_42_8

				if arg_39_1.var_.characterEffect6045ui_story and not isNil(var_42_6) then
					arg_39_1.var_.characterEffect6045ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= var_42_7 + var_42_8 and arg_39_1.time_ < var_42_7 + var_42_8 + arg_42_0 and not isNil(var_42_6) and arg_39_1.var_.characterEffect6045ui_story then
				arg_39_1.var_.characterEffect6045ui_story.fillFlat = false
			end

			local var_42_10 = 0
			local var_42_11 = 0.2

			if var_42_10 < arg_39_1.time_ and arg_39_1.time_ <= var_42_10 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_12 = arg_39_1:FormatText(StoryNameCfg[215].name)

				arg_39_1.leftNameTxt_.text = var_42_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_13 = arg_39_1:GetWordFromCfg(412131009)
				local var_42_14 = arg_39_1:FormatText(var_42_13.content)

				arg_39_1.text_.text = var_42_14

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_15 = 8
				local var_42_16 = utf8.len(var_42_14)
				local var_42_17 = var_42_15 <= 0 and var_42_11 or var_42_11 * (var_42_16 / var_42_15)

				if var_42_17 > 0 and var_42_11 < var_42_17 then
					arg_39_1.talkMaxDuration = var_42_17

					if var_42_17 + var_42_10 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_17 + var_42_10
					end
				end

				arg_39_1.text_.text = var_42_14
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131009", "story_v_out_412131.awb") ~= 0 then
					local var_42_18 = manager.audio:GetVoiceLength("story_v_out_412131", "412131009", "story_v_out_412131.awb") / 1000

					if var_42_18 + var_42_10 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_18 + var_42_10
					end

					if var_42_13.prefab_name ~= "" and arg_39_1.actors_[var_42_13.prefab_name] ~= nil then
						local var_42_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_13.prefab_name].transform, "story_v_out_412131", "412131009", "story_v_out_412131.awb")

						arg_39_1:RecordAudio("412131009", var_42_19)
						arg_39_1:RecordAudio("412131009", var_42_19)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_412131", "412131009", "story_v_out_412131.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_412131", "412131009", "story_v_out_412131.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_20 = math.max(var_42_11, arg_39_1.talkMaxDuration)

			if var_42_10 <= arg_39_1.time_ and arg_39_1.time_ < var_42_10 + var_42_20 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_10) / var_42_20

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_10 + var_42_20 and arg_39_1.time_ < var_42_10 + var_42_20 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play412131010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 412131010
		arg_43_1.duration_ = 14.37

		local var_43_0 = {
			zh = 14.366,
			ja = 12.966
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play412131011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["6046ui_story"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect6046ui_story == nil then
				arg_43_1.var_.characterEffect6046ui_story = var_46_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 and not isNil(var_46_0) then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.characterEffect6046ui_story and not isNil(var_46_0) then
					arg_43_1.var_.characterEffect6046ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect6046ui_story then
				arg_43_1.var_.characterEffect6046ui_story.fillFlat = false
			end

			local var_46_4 = arg_43_1.actors_["6045ui_story"]
			local var_46_5 = 0

			if var_46_5 < arg_43_1.time_ and arg_43_1.time_ <= var_46_5 + arg_46_0 and not isNil(var_46_4) and arg_43_1.var_.characterEffect6045ui_story == nil then
				arg_43_1.var_.characterEffect6045ui_story = var_46_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_6 = 0.200000002980232

			if var_46_5 <= arg_43_1.time_ and arg_43_1.time_ < var_46_5 + var_46_6 and not isNil(var_46_4) then
				local var_46_7 = (arg_43_1.time_ - var_46_5) / var_46_6

				if arg_43_1.var_.characterEffect6045ui_story and not isNil(var_46_4) then
					local var_46_8 = Mathf.Lerp(0, 0.5, var_46_7)

					arg_43_1.var_.characterEffect6045ui_story.fillFlat = true
					arg_43_1.var_.characterEffect6045ui_story.fillRatio = var_46_8
				end
			end

			if arg_43_1.time_ >= var_46_5 + var_46_6 and arg_43_1.time_ < var_46_5 + var_46_6 + arg_46_0 and not isNil(var_46_4) and arg_43_1.var_.characterEffect6045ui_story then
				local var_46_9 = 0.5

				arg_43_1.var_.characterEffect6045ui_story.fillFlat = true
				arg_43_1.var_.characterEffect6045ui_story.fillRatio = var_46_9
			end

			local var_46_10 = 0
			local var_46_11 = 1.275

			if var_46_10 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_12 = arg_43_1:FormatText(StoryNameCfg[214].name)

				arg_43_1.leftNameTxt_.text = var_46_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_13 = arg_43_1:GetWordFromCfg(412131010)
				local var_46_14 = arg_43_1:FormatText(var_46_13.content)

				arg_43_1.text_.text = var_46_14

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_15 = 51
				local var_46_16 = utf8.len(var_46_14)
				local var_46_17 = var_46_15 <= 0 and var_46_11 or var_46_11 * (var_46_16 / var_46_15)

				if var_46_17 > 0 and var_46_11 < var_46_17 then
					arg_43_1.talkMaxDuration = var_46_17

					if var_46_17 + var_46_10 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_17 + var_46_10
					end
				end

				arg_43_1.text_.text = var_46_14
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131010", "story_v_out_412131.awb") ~= 0 then
					local var_46_18 = manager.audio:GetVoiceLength("story_v_out_412131", "412131010", "story_v_out_412131.awb") / 1000

					if var_46_18 + var_46_10 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_18 + var_46_10
					end

					if var_46_13.prefab_name ~= "" and arg_43_1.actors_[var_46_13.prefab_name] ~= nil then
						local var_46_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_13.prefab_name].transform, "story_v_out_412131", "412131010", "story_v_out_412131.awb")

						arg_43_1:RecordAudio("412131010", var_46_19)
						arg_43_1:RecordAudio("412131010", var_46_19)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_412131", "412131010", "story_v_out_412131.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_412131", "412131010", "story_v_out_412131.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_20 = math.max(var_46_11, arg_43_1.talkMaxDuration)

			if var_46_10 <= arg_43_1.time_ and arg_43_1.time_ < var_46_10 + var_46_20 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_10) / var_46_20

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_10 + var_46_20 and arg_43_1.time_ < var_46_10 + var_46_20 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play412131011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 412131011
		arg_47_1.duration_ = 12.47

		local var_47_0 = {
			zh = 12.466,
			ja = 10.666
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play412131012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["6045ui_story"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect6045ui_story == nil then
				arg_47_1.var_.characterEffect6045ui_story = var_50_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.characterEffect6045ui_story and not isNil(var_50_0) then
					arg_47_1.var_.characterEffect6045ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect6045ui_story then
				arg_47_1.var_.characterEffect6045ui_story.fillFlat = false
			end

			local var_50_4 = 0

			if var_50_4 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1:PlayTimeline("6045ui_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			local var_50_5 = 0

			if var_50_5 < arg_47_1.time_ and arg_47_1.time_ <= var_50_5 + arg_50_0 then
				arg_47_1:PlayTimeline("6045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_50_6 = arg_47_1.actors_["6046ui_story"]
			local var_50_7 = 0

			if var_50_7 < arg_47_1.time_ and arg_47_1.time_ <= var_50_7 + arg_50_0 and not isNil(var_50_6) and arg_47_1.var_.characterEffect6046ui_story == nil then
				arg_47_1.var_.characterEffect6046ui_story = var_50_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_8 = 0.200000002980232

			if var_50_7 <= arg_47_1.time_ and arg_47_1.time_ < var_50_7 + var_50_8 and not isNil(var_50_6) then
				local var_50_9 = (arg_47_1.time_ - var_50_7) / var_50_8

				if arg_47_1.var_.characterEffect6046ui_story and not isNil(var_50_6) then
					local var_50_10 = Mathf.Lerp(0, 0.5, var_50_9)

					arg_47_1.var_.characterEffect6046ui_story.fillFlat = true
					arg_47_1.var_.characterEffect6046ui_story.fillRatio = var_50_10
				end
			end

			if arg_47_1.time_ >= var_50_7 + var_50_8 and arg_47_1.time_ < var_50_7 + var_50_8 + arg_50_0 and not isNil(var_50_6) and arg_47_1.var_.characterEffect6046ui_story then
				local var_50_11 = 0.5

				arg_47_1.var_.characterEffect6046ui_story.fillFlat = true
				arg_47_1.var_.characterEffect6046ui_story.fillRatio = var_50_11
			end

			local var_50_12 = 0
			local var_50_13 = 1.05

			if var_50_12 < arg_47_1.time_ and arg_47_1.time_ <= var_50_12 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_14 = arg_47_1:FormatText(StoryNameCfg[215].name)

				arg_47_1.leftNameTxt_.text = var_50_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_15 = arg_47_1:GetWordFromCfg(412131011)
				local var_50_16 = arg_47_1:FormatText(var_50_15.content)

				arg_47_1.text_.text = var_50_16

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_17 = 42
				local var_50_18 = utf8.len(var_50_16)
				local var_50_19 = var_50_17 <= 0 and var_50_13 or var_50_13 * (var_50_18 / var_50_17)

				if var_50_19 > 0 and var_50_13 < var_50_19 then
					arg_47_1.talkMaxDuration = var_50_19

					if var_50_19 + var_50_12 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_19 + var_50_12
					end
				end

				arg_47_1.text_.text = var_50_16
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131011", "story_v_out_412131.awb") ~= 0 then
					local var_50_20 = manager.audio:GetVoiceLength("story_v_out_412131", "412131011", "story_v_out_412131.awb") / 1000

					if var_50_20 + var_50_12 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_20 + var_50_12
					end

					if var_50_15.prefab_name ~= "" and arg_47_1.actors_[var_50_15.prefab_name] ~= nil then
						local var_50_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_15.prefab_name].transform, "story_v_out_412131", "412131011", "story_v_out_412131.awb")

						arg_47_1:RecordAudio("412131011", var_50_21)
						arg_47_1:RecordAudio("412131011", var_50_21)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_412131", "412131011", "story_v_out_412131.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_412131", "412131011", "story_v_out_412131.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_22 = math.max(var_50_13, arg_47_1.talkMaxDuration)

			if var_50_12 <= arg_47_1.time_ and arg_47_1.time_ < var_50_12 + var_50_22 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_12) / var_50_22

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_12 + var_50_22 and arg_47_1.time_ < var_50_12 + var_50_22 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play412131012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 412131012
		arg_51_1.duration_ = 10.13

		local var_51_0 = {
			zh = 6.6,
			ja = 10.133
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play412131013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["6046ui_story"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect6046ui_story == nil then
				arg_51_1.var_.characterEffect6046ui_story = var_54_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.characterEffect6046ui_story and not isNil(var_54_0) then
					arg_51_1.var_.characterEffect6046ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect6046ui_story then
				arg_51_1.var_.characterEffect6046ui_story.fillFlat = false
			end

			local var_54_4 = 0

			if var_54_4 < arg_51_1.time_ and arg_51_1.time_ <= var_54_4 + arg_54_0 then
				arg_51_1:PlayTimeline("6046ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_54_5 = 0

			if var_54_5 < arg_51_1.time_ and arg_51_1.time_ <= var_54_5 + arg_54_0 then
				arg_51_1:PlayTimeline("6046ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_54_6 = arg_51_1.actors_["6045ui_story"]
			local var_54_7 = 0

			if var_54_7 < arg_51_1.time_ and arg_51_1.time_ <= var_54_7 + arg_54_0 and not isNil(var_54_6) and arg_51_1.var_.characterEffect6045ui_story == nil then
				arg_51_1.var_.characterEffect6045ui_story = var_54_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_8 = 0.200000002980232

			if var_54_7 <= arg_51_1.time_ and arg_51_1.time_ < var_54_7 + var_54_8 and not isNil(var_54_6) then
				local var_54_9 = (arg_51_1.time_ - var_54_7) / var_54_8

				if arg_51_1.var_.characterEffect6045ui_story and not isNil(var_54_6) then
					local var_54_10 = Mathf.Lerp(0, 0.5, var_54_9)

					arg_51_1.var_.characterEffect6045ui_story.fillFlat = true
					arg_51_1.var_.characterEffect6045ui_story.fillRatio = var_54_10
				end
			end

			if arg_51_1.time_ >= var_54_7 + var_54_8 and arg_51_1.time_ < var_54_7 + var_54_8 + arg_54_0 and not isNil(var_54_6) and arg_51_1.var_.characterEffect6045ui_story then
				local var_54_11 = 0.5

				arg_51_1.var_.characterEffect6045ui_story.fillFlat = true
				arg_51_1.var_.characterEffect6045ui_story.fillRatio = var_54_11
			end

			local var_54_12 = 0
			local var_54_13 = 0.6

			if var_54_12 < arg_51_1.time_ and arg_51_1.time_ <= var_54_12 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_14 = arg_51_1:FormatText(StoryNameCfg[214].name)

				arg_51_1.leftNameTxt_.text = var_54_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_15 = arg_51_1:GetWordFromCfg(412131012)
				local var_54_16 = arg_51_1:FormatText(var_54_15.content)

				arg_51_1.text_.text = var_54_16

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_17 = 24
				local var_54_18 = utf8.len(var_54_16)
				local var_54_19 = var_54_17 <= 0 and var_54_13 or var_54_13 * (var_54_18 / var_54_17)

				if var_54_19 > 0 and var_54_13 < var_54_19 then
					arg_51_1.talkMaxDuration = var_54_19

					if var_54_19 + var_54_12 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_19 + var_54_12
					end
				end

				arg_51_1.text_.text = var_54_16
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131012", "story_v_out_412131.awb") ~= 0 then
					local var_54_20 = manager.audio:GetVoiceLength("story_v_out_412131", "412131012", "story_v_out_412131.awb") / 1000

					if var_54_20 + var_54_12 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_20 + var_54_12
					end

					if var_54_15.prefab_name ~= "" and arg_51_1.actors_[var_54_15.prefab_name] ~= nil then
						local var_54_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_15.prefab_name].transform, "story_v_out_412131", "412131012", "story_v_out_412131.awb")

						arg_51_1:RecordAudio("412131012", var_54_21)
						arg_51_1:RecordAudio("412131012", var_54_21)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_412131", "412131012", "story_v_out_412131.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_412131", "412131012", "story_v_out_412131.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_22 = math.max(var_54_13, arg_51_1.talkMaxDuration)

			if var_54_12 <= arg_51_1.time_ and arg_51_1.time_ < var_54_12 + var_54_22 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_12) / var_54_22

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_12 + var_54_22 and arg_51_1.time_ < var_54_12 + var_54_22 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play412131013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 412131013
		arg_55_1.duration_ = 2.97

		local var_55_0 = {
			zh = 1.999999999999,
			ja = 2.966
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play412131014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["6045ui_story"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect6045ui_story == nil then
				arg_55_1.var_.characterEffect6045ui_story = var_58_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.characterEffect6045ui_story and not isNil(var_58_0) then
					arg_55_1.var_.characterEffect6045ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect6045ui_story then
				arg_55_1.var_.characterEffect6045ui_story.fillFlat = false
			end

			local var_58_4 = 0

			if var_58_4 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1:PlayTimeline("6045ui_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_2")
			end

			local var_58_5 = 0

			if var_58_5 < arg_55_1.time_ and arg_55_1.time_ <= var_58_5 + arg_58_0 then
				arg_55_1:PlayTimeline("6045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_58_6 = arg_55_1.actors_["6046ui_story"]
			local var_58_7 = 0

			if var_58_7 < arg_55_1.time_ and arg_55_1.time_ <= var_58_7 + arg_58_0 and not isNil(var_58_6) and arg_55_1.var_.characterEffect6046ui_story == nil then
				arg_55_1.var_.characterEffect6046ui_story = var_58_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_8 = 0.200000002980232

			if var_58_7 <= arg_55_1.time_ and arg_55_1.time_ < var_58_7 + var_58_8 and not isNil(var_58_6) then
				local var_58_9 = (arg_55_1.time_ - var_58_7) / var_58_8

				if arg_55_1.var_.characterEffect6046ui_story and not isNil(var_58_6) then
					local var_58_10 = Mathf.Lerp(0, 0.5, var_58_9)

					arg_55_1.var_.characterEffect6046ui_story.fillFlat = true
					arg_55_1.var_.characterEffect6046ui_story.fillRatio = var_58_10
				end
			end

			if arg_55_1.time_ >= var_58_7 + var_58_8 and arg_55_1.time_ < var_58_7 + var_58_8 + arg_58_0 and not isNil(var_58_6) and arg_55_1.var_.characterEffect6046ui_story then
				local var_58_11 = 0.5

				arg_55_1.var_.characterEffect6046ui_story.fillFlat = true
				arg_55_1.var_.characterEffect6046ui_story.fillRatio = var_58_11
			end

			local var_58_12 = 0
			local var_58_13 = 0.075

			if var_58_12 < arg_55_1.time_ and arg_55_1.time_ <= var_58_12 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_14 = arg_55_1:FormatText(StoryNameCfg[215].name)

				arg_55_1.leftNameTxt_.text = var_58_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_15 = arg_55_1:GetWordFromCfg(412131013)
				local var_58_16 = arg_55_1:FormatText(var_58_15.content)

				arg_55_1.text_.text = var_58_16

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_17 = 3
				local var_58_18 = utf8.len(var_58_16)
				local var_58_19 = var_58_17 <= 0 and var_58_13 or var_58_13 * (var_58_18 / var_58_17)

				if var_58_19 > 0 and var_58_13 < var_58_19 then
					arg_55_1.talkMaxDuration = var_58_19

					if var_58_19 + var_58_12 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_19 + var_58_12
					end
				end

				arg_55_1.text_.text = var_58_16
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131013", "story_v_out_412131.awb") ~= 0 then
					local var_58_20 = manager.audio:GetVoiceLength("story_v_out_412131", "412131013", "story_v_out_412131.awb") / 1000

					if var_58_20 + var_58_12 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_20 + var_58_12
					end

					if var_58_15.prefab_name ~= "" and arg_55_1.actors_[var_58_15.prefab_name] ~= nil then
						local var_58_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_15.prefab_name].transform, "story_v_out_412131", "412131013", "story_v_out_412131.awb")

						arg_55_1:RecordAudio("412131013", var_58_21)
						arg_55_1:RecordAudio("412131013", var_58_21)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_412131", "412131013", "story_v_out_412131.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_412131", "412131013", "story_v_out_412131.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_22 = math.max(var_58_13, arg_55_1.talkMaxDuration)

			if var_58_12 <= arg_55_1.time_ and arg_55_1.time_ < var_58_12 + var_58_22 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_12) / var_58_22

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_12 + var_58_22 and arg_55_1.time_ < var_58_12 + var_58_22 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play412131014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 412131014
		arg_59_1.duration_ = 8.43

		local var_59_0 = {
			zh = 7.6,
			ja = 8.433
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
				arg_59_0:Play412131015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = "F03_2"

			if arg_59_1.bgs_[var_62_0] == nil then
				local var_62_1 = Object.Instantiate(arg_59_1.paintGo_)

				var_62_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_62_0)
				var_62_1.name = var_62_0
				var_62_1.transform.parent = arg_59_1.stage_.transform
				var_62_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_59_1.bgs_[var_62_0] = var_62_1
			end

			local var_62_2 = 2

			if var_62_2 < arg_59_1.time_ and arg_59_1.time_ <= var_62_2 + arg_62_0 then
				local var_62_3 = manager.ui.mainCamera.transform.localPosition
				local var_62_4 = Vector3.New(0, 0, 10) + Vector3.New(var_62_3.x, var_62_3.y, 0)
				local var_62_5 = arg_59_1.bgs_.F03_2

				var_62_5.transform.localPosition = var_62_4
				var_62_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_62_6 = var_62_5:GetComponent("SpriteRenderer")

				if var_62_6 and var_62_6.sprite then
					local var_62_7 = (var_62_5.transform.localPosition - var_62_3).z
					local var_62_8 = manager.ui.mainCameraCom_
					local var_62_9 = 2 * var_62_7 * Mathf.Tan(var_62_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_62_10 = var_62_9 * var_62_8.aspect
					local var_62_11 = var_62_6.sprite.bounds.size.x
					local var_62_12 = var_62_6.sprite.bounds.size.y
					local var_62_13 = var_62_10 / var_62_11
					local var_62_14 = var_62_9 / var_62_12
					local var_62_15 = var_62_14 < var_62_13 and var_62_13 or var_62_14

					var_62_5.transform.localScale = Vector3.New(var_62_15, var_62_15, 0)
				end

				for iter_62_0, iter_62_1 in pairs(arg_59_1.bgs_) do
					if iter_62_0 ~= "F03_2" then
						iter_62_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_62_16 = 4

			if var_62_16 < arg_59_1.time_ and arg_59_1.time_ <= var_62_16 + arg_62_0 then
				arg_59_1.allBtn_.enabled = false
			end

			local var_62_17 = 0.3

			if arg_59_1.time_ >= var_62_16 + var_62_17 and arg_59_1.time_ < var_62_16 + var_62_17 + arg_62_0 then
				arg_59_1.allBtn_.enabled = true
			end

			local var_62_18 = 0

			if var_62_18 < arg_59_1.time_ and arg_59_1.time_ <= var_62_18 + arg_62_0 then
				arg_59_1.mask_.enabled = true
				arg_59_1.mask_.raycastTarget = true

				arg_59_1:SetGaussion(false)
			end

			local var_62_19 = 2

			if var_62_18 <= arg_59_1.time_ and arg_59_1.time_ < var_62_18 + var_62_19 then
				local var_62_20 = (arg_59_1.time_ - var_62_18) / var_62_19
				local var_62_21 = Color.New(0, 0, 0)

				var_62_21.a = Mathf.Lerp(0, 1, var_62_20)
				arg_59_1.mask_.color = var_62_21
			end

			if arg_59_1.time_ >= var_62_18 + var_62_19 and arg_59_1.time_ < var_62_18 + var_62_19 + arg_62_0 then
				local var_62_22 = Color.New(0, 0, 0)

				var_62_22.a = 1
				arg_59_1.mask_.color = var_62_22
			end

			local var_62_23 = 2

			if var_62_23 < arg_59_1.time_ and arg_59_1.time_ <= var_62_23 + arg_62_0 then
				arg_59_1.mask_.enabled = true
				arg_59_1.mask_.raycastTarget = true

				arg_59_1:SetGaussion(false)
			end

			local var_62_24 = 2

			if var_62_23 <= arg_59_1.time_ and arg_59_1.time_ < var_62_23 + var_62_24 then
				local var_62_25 = (arg_59_1.time_ - var_62_23) / var_62_24
				local var_62_26 = Color.New(0, 0, 0)

				var_62_26.a = Mathf.Lerp(1, 0, var_62_25)
				arg_59_1.mask_.color = var_62_26
			end

			if arg_59_1.time_ >= var_62_23 + var_62_24 and arg_59_1.time_ < var_62_23 + var_62_24 + arg_62_0 then
				local var_62_27 = Color.New(0, 0, 0)
				local var_62_28 = 0

				arg_59_1.mask_.enabled = false
				var_62_27.a = var_62_28
				arg_59_1.mask_.color = var_62_27
			end

			local var_62_29 = arg_59_1.actors_["6045ui_story"].transform
			local var_62_30 = 1.96599999815226

			if var_62_30 < arg_59_1.time_ and arg_59_1.time_ <= var_62_30 + arg_62_0 then
				arg_59_1.var_.moveOldPos6045ui_story = var_62_29.localPosition
			end

			local var_62_31 = 0.001

			if var_62_30 <= arg_59_1.time_ and arg_59_1.time_ < var_62_30 + var_62_31 then
				local var_62_32 = (arg_59_1.time_ - var_62_30) / var_62_31
				local var_62_33 = Vector3.New(0, 100, 0)

				var_62_29.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos6045ui_story, var_62_33, var_62_32)

				local var_62_34 = manager.ui.mainCamera.transform.position - var_62_29.position

				var_62_29.forward = Vector3.New(var_62_34.x, var_62_34.y, var_62_34.z)

				local var_62_35 = var_62_29.localEulerAngles

				var_62_35.z = 0
				var_62_35.x = 0
				var_62_29.localEulerAngles = var_62_35
			end

			if arg_59_1.time_ >= var_62_30 + var_62_31 and arg_59_1.time_ < var_62_30 + var_62_31 + arg_62_0 then
				var_62_29.localPosition = Vector3.New(0, 100, 0)

				local var_62_36 = manager.ui.mainCamera.transform.position - var_62_29.position

				var_62_29.forward = Vector3.New(var_62_36.x, var_62_36.y, var_62_36.z)

				local var_62_37 = var_62_29.localEulerAngles

				var_62_37.z = 0
				var_62_37.x = 0
				var_62_29.localEulerAngles = var_62_37
			end

			local var_62_38 = arg_59_1.actors_["6045ui_story"]
			local var_62_39 = 1.96599999815226

			if var_62_39 < arg_59_1.time_ and arg_59_1.time_ <= var_62_39 + arg_62_0 and not isNil(var_62_38) and arg_59_1.var_.characterEffect6045ui_story == nil then
				arg_59_1.var_.characterEffect6045ui_story = var_62_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_40 = 0.034000001847744

			if var_62_39 <= arg_59_1.time_ and arg_59_1.time_ < var_62_39 + var_62_40 and not isNil(var_62_38) then
				local var_62_41 = (arg_59_1.time_ - var_62_39) / var_62_40

				if arg_59_1.var_.characterEffect6045ui_story and not isNil(var_62_38) then
					local var_62_42 = Mathf.Lerp(0, 0.5, var_62_41)

					arg_59_1.var_.characterEffect6045ui_story.fillFlat = true
					arg_59_1.var_.characterEffect6045ui_story.fillRatio = var_62_42
				end
			end

			if arg_59_1.time_ >= var_62_39 + var_62_40 and arg_59_1.time_ < var_62_39 + var_62_40 + arg_62_0 and not isNil(var_62_38) and arg_59_1.var_.characterEffect6045ui_story then
				local var_62_43 = 0.5

				arg_59_1.var_.characterEffect6045ui_story.fillFlat = true
				arg_59_1.var_.characterEffect6045ui_story.fillRatio = var_62_43
			end

			local var_62_44 = arg_59_1.actors_["6046ui_story"].transform
			local var_62_45 = 1.96599999815226

			if var_62_45 < arg_59_1.time_ and arg_59_1.time_ <= var_62_45 + arg_62_0 then
				arg_59_1.var_.moveOldPos6046ui_story = var_62_44.localPosition
			end

			local var_62_46 = 0.001

			if var_62_45 <= arg_59_1.time_ and arg_59_1.time_ < var_62_45 + var_62_46 then
				local var_62_47 = (arg_59_1.time_ - var_62_45) / var_62_46
				local var_62_48 = Vector3.New(0, 100, 0)

				var_62_44.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos6046ui_story, var_62_48, var_62_47)

				local var_62_49 = manager.ui.mainCamera.transform.position - var_62_44.position

				var_62_44.forward = Vector3.New(var_62_49.x, var_62_49.y, var_62_49.z)

				local var_62_50 = var_62_44.localEulerAngles

				var_62_50.z = 0
				var_62_50.x = 0
				var_62_44.localEulerAngles = var_62_50
			end

			if arg_59_1.time_ >= var_62_45 + var_62_46 and arg_59_1.time_ < var_62_45 + var_62_46 + arg_62_0 then
				var_62_44.localPosition = Vector3.New(0, 100, 0)

				local var_62_51 = manager.ui.mainCamera.transform.position - var_62_44.position

				var_62_44.forward = Vector3.New(var_62_51.x, var_62_51.y, var_62_51.z)

				local var_62_52 = var_62_44.localEulerAngles

				var_62_52.z = 0
				var_62_52.x = 0
				var_62_44.localEulerAngles = var_62_52
			end

			local var_62_53 = arg_59_1.actors_["6046ui_story"]
			local var_62_54 = 1.96599999815226

			if var_62_54 < arg_59_1.time_ and arg_59_1.time_ <= var_62_54 + arg_62_0 and not isNil(var_62_53) and arg_59_1.var_.characterEffect6046ui_story == nil then
				arg_59_1.var_.characterEffect6046ui_story = var_62_53:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_55 = 0.034000001847744

			if var_62_54 <= arg_59_1.time_ and arg_59_1.time_ < var_62_54 + var_62_55 and not isNil(var_62_53) then
				local var_62_56 = (arg_59_1.time_ - var_62_54) / var_62_55

				if arg_59_1.var_.characterEffect6046ui_story and not isNil(var_62_53) then
					local var_62_57 = Mathf.Lerp(0, 0.5, var_62_56)

					arg_59_1.var_.characterEffect6046ui_story.fillFlat = true
					arg_59_1.var_.characterEffect6046ui_story.fillRatio = var_62_57
				end
			end

			if arg_59_1.time_ >= var_62_54 + var_62_55 and arg_59_1.time_ < var_62_54 + var_62_55 + arg_62_0 and not isNil(var_62_53) and arg_59_1.var_.characterEffect6046ui_story then
				local var_62_58 = 0.5

				arg_59_1.var_.characterEffect6046ui_story.fillFlat = true
				arg_59_1.var_.characterEffect6046ui_story.fillRatio = var_62_58
			end

			if arg_59_1.frameCnt_ <= 1 then
				arg_59_1.dialog_:SetActive(false)
			end

			local var_62_59 = 4
			local var_62_60 = 0.375

			if var_62_59 < arg_59_1.time_ and arg_59_1.time_ <= var_62_59 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0

				arg_59_1.dialog_:SetActive(true)

				arg_59_1.dialogCg_.alpha = 0

				local var_62_61 = LeanTween.value(arg_59_1.dialog_, 0, 1, 0.3)

				var_62_61:setOnUpdate(LuaHelper.FloatAction(function(arg_63_0)
					arg_59_1.dialogCg_.alpha = arg_63_0
				end))
				var_62_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_59_1.dialog_)
					var_62_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_59_1.duration_ = arg_59_1.duration_ + 0.3

				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_62 = arg_59_1:FormatText(StoryNameCfg[303].name)

				arg_59_1.leftNameTxt_.text = var_62_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_63 = arg_59_1:GetWordFromCfg(412131014)
				local var_62_64 = arg_59_1:FormatText(var_62_63.content)

				arg_59_1.text_.text = var_62_64

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_65 = 15
				local var_62_66 = utf8.len(var_62_64)
				local var_62_67 = var_62_65 <= 0 and var_62_60 or var_62_60 * (var_62_66 / var_62_65)

				if var_62_67 > 0 and var_62_60 < var_62_67 then
					arg_59_1.talkMaxDuration = var_62_67
					var_62_59 = var_62_59 + 0.3

					if var_62_67 + var_62_59 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_67 + var_62_59
					end
				end

				arg_59_1.text_.text = var_62_64
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131014", "story_v_out_412131.awb") ~= 0 then
					local var_62_68 = manager.audio:GetVoiceLength("story_v_out_412131", "412131014", "story_v_out_412131.awb") / 1000

					if var_62_68 + var_62_59 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_68 + var_62_59
					end

					if var_62_63.prefab_name ~= "" and arg_59_1.actors_[var_62_63.prefab_name] ~= nil then
						local var_62_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_63.prefab_name].transform, "story_v_out_412131", "412131014", "story_v_out_412131.awb")

						arg_59_1:RecordAudio("412131014", var_62_69)
						arg_59_1:RecordAudio("412131014", var_62_69)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_412131", "412131014", "story_v_out_412131.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_412131", "412131014", "story_v_out_412131.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_70 = var_62_59 + 0.3
			local var_62_71 = math.max(var_62_60, arg_59_1.talkMaxDuration)

			if var_62_70 <= arg_59_1.time_ and arg_59_1.time_ < var_62_70 + var_62_71 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_70) / var_62_71

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_70 + var_62_71 and arg_59_1.time_ < var_62_70 + var_62_71 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play412131015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 412131015
		arg_65_1.duration_ = 19.13

		local var_65_0 = {
			zh = 19.133,
			ja = 13.666
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
				arg_65_0:Play412131016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 2

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[304].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwa")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(412131015)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 79
				local var_68_6 = utf8.len(var_68_4)
				local var_68_7 = var_68_5 <= 0 and var_68_1 or var_68_1 * (var_68_6 / var_68_5)

				if var_68_7 > 0 and var_68_1 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131015", "story_v_out_412131.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_412131", "412131015", "story_v_out_412131.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_412131", "412131015", "story_v_out_412131.awb")

						arg_65_1:RecordAudio("412131015", var_68_9)
						arg_65_1:RecordAudio("412131015", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_412131", "412131015", "story_v_out_412131.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_412131", "412131015", "story_v_out_412131.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_10 and arg_65_1.time_ < var_68_0 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play412131016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 412131016
		arg_69_1.duration_ = 10.23

		local var_69_0 = {
			zh = 10.233,
			ja = 7.133
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
				arg_69_0:Play412131017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 1.175

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[303].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(412131016)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 47
				local var_72_6 = utf8.len(var_72_4)
				local var_72_7 = var_72_5 <= 0 and var_72_1 or var_72_1 * (var_72_6 / var_72_5)

				if var_72_7 > 0 and var_72_1 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131016", "story_v_out_412131.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_412131", "412131016", "story_v_out_412131.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_412131", "412131016", "story_v_out_412131.awb")

						arg_69_1:RecordAudio("412131016", var_72_9)
						arg_69_1:RecordAudio("412131016", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_412131", "412131016", "story_v_out_412131.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_412131", "412131016", "story_v_out_412131.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_10 and arg_69_1.time_ < var_72_0 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play412131017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 412131017
		arg_73_1.duration_ = 8.83

		local var_73_0 = {
			zh = 4.9,
			ja = 8.833
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
				arg_73_0:Play412131018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.575

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[304].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwa")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(412131017)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 23
				local var_76_6 = utf8.len(var_76_4)
				local var_76_7 = var_76_5 <= 0 and var_76_1 or var_76_1 * (var_76_6 / var_76_5)

				if var_76_7 > 0 and var_76_1 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131017", "story_v_out_412131.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_412131", "412131017", "story_v_out_412131.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_412131", "412131017", "story_v_out_412131.awb")

						arg_73_1:RecordAudio("412131017", var_76_9)
						arg_73_1:RecordAudio("412131017", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_412131", "412131017", "story_v_out_412131.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_412131", "412131017", "story_v_out_412131.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_10 and arg_73_1.time_ < var_76_0 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play412131018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 412131018
		arg_77_1.duration_ = 7.5

		local var_77_0 = {
			zh = 4.033,
			ja = 7.5
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
				arg_77_0:Play412131019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.5

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[303].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:GetWordFromCfg(412131018)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131018", "story_v_out_412131.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_412131", "412131018", "story_v_out_412131.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_412131", "412131018", "story_v_out_412131.awb")

						arg_77_1:RecordAudio("412131018", var_80_9)
						arg_77_1:RecordAudio("412131018", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_412131", "412131018", "story_v_out_412131.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_412131", "412131018", "story_v_out_412131.awb")
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
	Play412131019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 412131019
		arg_81_1.duration_ = 17.37

		local var_81_0 = {
			zh = 16.166,
			ja = 17.366
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
				arg_81_0:Play412131020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 1.725

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[304].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwa")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:GetWordFromCfg(412131019)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 69
				local var_84_6 = utf8.len(var_84_4)
				local var_84_7 = var_84_5 <= 0 and var_84_1 or var_84_1 * (var_84_6 / var_84_5)

				if var_84_7 > 0 and var_84_1 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131019", "story_v_out_412131.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_412131", "412131019", "story_v_out_412131.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_412131", "412131019", "story_v_out_412131.awb")

						arg_81_1:RecordAudio("412131019", var_84_9)
						arg_81_1:RecordAudio("412131019", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_412131", "412131019", "story_v_out_412131.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_412131", "412131019", "story_v_out_412131.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_10 and arg_81_1.time_ < var_84_0 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play412131020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 412131020
		arg_85_1.duration_ = 3.7

		local var_85_0 = {
			zh = 1.833,
			ja = 3.7
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
				arg_85_0:Play412131021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.15

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[303].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(412131020)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131020", "story_v_out_412131.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_412131", "412131020", "story_v_out_412131.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_412131", "412131020", "story_v_out_412131.awb")

						arg_85_1:RecordAudio("412131020", var_88_9)
						arg_85_1:RecordAudio("412131020", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_412131", "412131020", "story_v_out_412131.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_412131", "412131020", "story_v_out_412131.awb")
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
	Play412131021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 412131021
		arg_89_1.duration_ = 5.5

		local var_89_0 = {
			zh = 5.5,
			ja = 4.2
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
				arg_89_0:Play412131022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.4

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[303].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:GetWordFromCfg(412131021)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 16
				local var_92_6 = utf8.len(var_92_4)
				local var_92_7 = var_92_5 <= 0 and var_92_1 or var_92_1 * (var_92_6 / var_92_5)

				if var_92_7 > 0 and var_92_1 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131021", "story_v_out_412131.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_412131", "412131021", "story_v_out_412131.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_412131", "412131021", "story_v_out_412131.awb")

						arg_89_1:RecordAudio("412131021", var_92_9)
						arg_89_1:RecordAudio("412131021", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_412131", "412131021", "story_v_out_412131.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_412131", "412131021", "story_v_out_412131.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_10 and arg_89_1.time_ < var_92_0 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play412131022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 412131022
		arg_93_1.duration_ = 7.13

		local var_93_0 = {
			zh = 7.133,
			ja = 6.833
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
				arg_93_0:Play412131023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = "I09f"

			if arg_93_1.bgs_[var_96_0] == nil then
				local var_96_1 = Object.Instantiate(arg_93_1.paintGo_)

				var_96_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_96_0)
				var_96_1.name = var_96_0
				var_96_1.transform.parent = arg_93_1.stage_.transform
				var_96_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.bgs_[var_96_0] = var_96_1
			end

			local var_96_2 = 1.9

			if var_96_2 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				local var_96_3 = manager.ui.mainCamera.transform.localPosition
				local var_96_4 = Vector3.New(0, 0, 10) + Vector3.New(var_96_3.x, var_96_3.y, 0)
				local var_96_5 = arg_93_1.bgs_.I09f

				var_96_5.transform.localPosition = var_96_4
				var_96_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_96_6 = var_96_5:GetComponent("SpriteRenderer")

				if var_96_6 and var_96_6.sprite then
					local var_96_7 = (var_96_5.transform.localPosition - var_96_3).z
					local var_96_8 = manager.ui.mainCameraCom_
					local var_96_9 = 2 * var_96_7 * Mathf.Tan(var_96_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_96_10 = var_96_9 * var_96_8.aspect
					local var_96_11 = var_96_6.sprite.bounds.size.x
					local var_96_12 = var_96_6.sprite.bounds.size.y
					local var_96_13 = var_96_10 / var_96_11
					local var_96_14 = var_96_9 / var_96_12
					local var_96_15 = var_96_14 < var_96_13 and var_96_13 or var_96_14

					var_96_5.transform.localScale = Vector3.New(var_96_15, var_96_15, 0)
				end

				for iter_96_0, iter_96_1 in pairs(arg_93_1.bgs_) do
					if iter_96_0 ~= "I09f" then
						iter_96_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_96_16 = 4

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
				arg_93_1.allBtn_.enabled = false
			end

			local var_96_17 = 0.3

			if arg_93_1.time_ >= var_96_16 + var_96_17 and arg_93_1.time_ < var_96_16 + var_96_17 + arg_96_0 then
				arg_93_1.allBtn_.enabled = true
			end

			local var_96_18 = 0

			if var_96_18 < arg_93_1.time_ and arg_93_1.time_ <= var_96_18 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_19 = 2

			if var_96_18 <= arg_93_1.time_ and arg_93_1.time_ < var_96_18 + var_96_19 then
				local var_96_20 = (arg_93_1.time_ - var_96_18) / var_96_19
				local var_96_21 = Color.New(0, 0, 0)

				var_96_21.a = Mathf.Lerp(0, 1, var_96_20)
				arg_93_1.mask_.color = var_96_21
			end

			if arg_93_1.time_ >= var_96_18 + var_96_19 and arg_93_1.time_ < var_96_18 + var_96_19 + arg_96_0 then
				local var_96_22 = Color.New(0, 0, 0)

				var_96_22.a = 1
				arg_93_1.mask_.color = var_96_22
			end

			local var_96_23 = 2

			if var_96_23 < arg_93_1.time_ and arg_93_1.time_ <= var_96_23 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_24 = 2

			if var_96_23 <= arg_93_1.time_ and arg_93_1.time_ < var_96_23 + var_96_24 then
				local var_96_25 = (arg_93_1.time_ - var_96_23) / var_96_24
				local var_96_26 = Color.New(0, 0, 0)

				var_96_26.a = Mathf.Lerp(1, 0, var_96_25)
				arg_93_1.mask_.color = var_96_26
			end

			if arg_93_1.time_ >= var_96_23 + var_96_24 and arg_93_1.time_ < var_96_23 + var_96_24 + arg_96_0 then
				local var_96_27 = Color.New(0, 0, 0)
				local var_96_28 = 0

				arg_93_1.mask_.enabled = false
				var_96_27.a = var_96_28
				arg_93_1.mask_.color = var_96_27
			end

			local var_96_29 = "1197ui_story"

			if arg_93_1.actors_[var_96_29] == nil then
				local var_96_30 = Asset.Load("Char/" .. "1197ui_story")

				if not isNil(var_96_30) then
					local var_96_31 = Object.Instantiate(Asset.Load("Char/" .. "1197ui_story"), arg_93_1.stage_.transform)

					var_96_31.name = var_96_29
					var_96_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_93_1.actors_[var_96_29] = var_96_31

					local var_96_32 = var_96_31:GetComponentInChildren(typeof(CharacterEffect))

					var_96_32.enabled = true

					local var_96_33 = GameObjectTools.GetOrAddComponent(var_96_31, typeof(DynamicBoneHelper))

					if var_96_33 then
						var_96_33:EnableDynamicBone(false)
					end

					arg_93_1:ShowWeapon(var_96_32.transform, false)

					arg_93_1.var_[var_96_29 .. "Animator"] = var_96_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_93_1.var_[var_96_29 .. "Animator"].applyRootMotion = true
					arg_93_1.var_[var_96_29 .. "LipSync"] = var_96_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_96_34 = arg_93_1.actors_["1197ui_story"].transform
			local var_96_35 = 3.8

			if var_96_35 < arg_93_1.time_ and arg_93_1.time_ <= var_96_35 + arg_96_0 then
				arg_93_1.var_.moveOldPos1197ui_story = var_96_34.localPosition
			end

			local var_96_36 = 0.001

			if var_96_35 <= arg_93_1.time_ and arg_93_1.time_ < var_96_35 + var_96_36 then
				local var_96_37 = (arg_93_1.time_ - var_96_35) / var_96_36
				local var_96_38 = Vector3.New(-0.7, -0.545, -6.3)

				var_96_34.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1197ui_story, var_96_38, var_96_37)

				local var_96_39 = manager.ui.mainCamera.transform.position - var_96_34.position

				var_96_34.forward = Vector3.New(var_96_39.x, var_96_39.y, var_96_39.z)

				local var_96_40 = var_96_34.localEulerAngles

				var_96_40.z = 0
				var_96_40.x = 0
				var_96_34.localEulerAngles = var_96_40
			end

			if arg_93_1.time_ >= var_96_35 + var_96_36 and arg_93_1.time_ < var_96_35 + var_96_36 + arg_96_0 then
				var_96_34.localPosition = Vector3.New(-0.7, -0.545, -6.3)

				local var_96_41 = manager.ui.mainCamera.transform.position - var_96_34.position

				var_96_34.forward = Vector3.New(var_96_41.x, var_96_41.y, var_96_41.z)

				local var_96_42 = var_96_34.localEulerAngles

				var_96_42.z = 0
				var_96_42.x = 0
				var_96_34.localEulerAngles = var_96_42
			end

			local var_96_43 = arg_93_1.actors_["1197ui_story"]
			local var_96_44 = 3.8

			if var_96_44 < arg_93_1.time_ and arg_93_1.time_ <= var_96_44 + arg_96_0 and not isNil(var_96_43) and arg_93_1.var_.characterEffect1197ui_story == nil then
				arg_93_1.var_.characterEffect1197ui_story = var_96_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_45 = 0.200000002980232

			if var_96_44 <= arg_93_1.time_ and arg_93_1.time_ < var_96_44 + var_96_45 and not isNil(var_96_43) then
				local var_96_46 = (arg_93_1.time_ - var_96_44) / var_96_45

				if arg_93_1.var_.characterEffect1197ui_story and not isNil(var_96_43) then
					arg_93_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_44 + var_96_45 and arg_93_1.time_ < var_96_44 + var_96_45 + arg_96_0 and not isNil(var_96_43) and arg_93_1.var_.characterEffect1197ui_story then
				arg_93_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			local var_96_47 = 3.8

			if var_96_47 < arg_93_1.time_ and arg_93_1.time_ <= var_96_47 + arg_96_0 then
				arg_93_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action6_1")
			end

			local var_96_48 = 3.8

			if var_96_48 < arg_93_1.time_ and arg_93_1.time_ <= var_96_48 + arg_96_0 then
				arg_93_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if arg_93_1.frameCnt_ <= 1 then
				arg_93_1.dialog_:SetActive(false)
			end

			local var_96_49 = 3.9
			local var_96_50 = 0.325

			if var_96_49 < arg_93_1.time_ and arg_93_1.time_ <= var_96_49 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0

				arg_93_1.dialog_:SetActive(true)

				arg_93_1.dialogCg_.alpha = 0

				local var_96_51 = LeanTween.value(arg_93_1.dialog_, 0, 1, 0.3)

				var_96_51:setOnUpdate(LuaHelper.FloatAction(function(arg_97_0)
					arg_93_1.dialogCg_.alpha = arg_97_0
				end))
				var_96_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_93_1.dialog_)
					var_96_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_93_1.duration_ = arg_93_1.duration_ + 0.3

				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_52 = arg_93_1:FormatText(StoryNameCfg[216].name)

				arg_93_1.leftNameTxt_.text = var_96_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_53 = arg_93_1:GetWordFromCfg(412131022)
				local var_96_54 = arg_93_1:FormatText(var_96_53.content)

				arg_93_1.text_.text = var_96_54

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_55 = 13
				local var_96_56 = utf8.len(var_96_54)
				local var_96_57 = var_96_55 <= 0 and var_96_50 or var_96_50 * (var_96_56 / var_96_55)

				if var_96_57 > 0 and var_96_50 < var_96_57 then
					arg_93_1.talkMaxDuration = var_96_57
					var_96_49 = var_96_49 + 0.3

					if var_96_57 + var_96_49 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_57 + var_96_49
					end
				end

				arg_93_1.text_.text = var_96_54
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131022", "story_v_out_412131.awb") ~= 0 then
					local var_96_58 = manager.audio:GetVoiceLength("story_v_out_412131", "412131022", "story_v_out_412131.awb") / 1000

					if var_96_58 + var_96_49 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_58 + var_96_49
					end

					if var_96_53.prefab_name ~= "" and arg_93_1.actors_[var_96_53.prefab_name] ~= nil then
						local var_96_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_53.prefab_name].transform, "story_v_out_412131", "412131022", "story_v_out_412131.awb")

						arg_93_1:RecordAudio("412131022", var_96_59)
						arg_93_1:RecordAudio("412131022", var_96_59)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_412131", "412131022", "story_v_out_412131.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_412131", "412131022", "story_v_out_412131.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_60 = var_96_49 + 0.3
			local var_96_61 = math.max(var_96_50, arg_93_1.talkMaxDuration)

			if var_96_60 <= arg_93_1.time_ and arg_93_1.time_ < var_96_60 + var_96_61 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_60) / var_96_61

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_60 + var_96_61 and arg_93_1.time_ < var_96_60 + var_96_61 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play412131023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 412131023
		arg_99_1.duration_ = 9.73

		local var_99_0 = {
			zh = 7.466,
			ja = 9.733
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
				arg_99_0:Play412131024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = "10076ui_story"

			if arg_99_1.actors_[var_102_0] == nil then
				local var_102_1 = Asset.Load("Char/" .. "10076ui_story")

				if not isNil(var_102_1) then
					local var_102_2 = Object.Instantiate(Asset.Load("Char/" .. "10076ui_story"), arg_99_1.stage_.transform)

					var_102_2.name = var_102_0
					var_102_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_99_1.actors_[var_102_0] = var_102_2

					local var_102_3 = var_102_2:GetComponentInChildren(typeof(CharacterEffect))

					var_102_3.enabled = true

					local var_102_4 = GameObjectTools.GetOrAddComponent(var_102_2, typeof(DynamicBoneHelper))

					if var_102_4 then
						var_102_4:EnableDynamicBone(false)
					end

					arg_99_1:ShowWeapon(var_102_3.transform, false)

					arg_99_1.var_[var_102_0 .. "Animator"] = var_102_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_99_1.var_[var_102_0 .. "Animator"].applyRootMotion = true
					arg_99_1.var_[var_102_0 .. "LipSync"] = var_102_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_102_5 = arg_99_1.actors_["10076ui_story"].transform
			local var_102_6 = 0

			if var_102_6 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.var_.moveOldPos10076ui_story = var_102_5.localPosition
			end

			local var_102_7 = 0.001

			if var_102_6 <= arg_99_1.time_ and arg_99_1.time_ < var_102_6 + var_102_7 then
				local var_102_8 = (arg_99_1.time_ - var_102_6) / var_102_7
				local var_102_9 = Vector3.New(1, -0.35, -4)

				var_102_5.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10076ui_story, var_102_9, var_102_8)

				local var_102_10 = manager.ui.mainCamera.transform.position - var_102_5.position

				var_102_5.forward = Vector3.New(var_102_10.x, var_102_10.y, var_102_10.z)

				local var_102_11 = var_102_5.localEulerAngles

				var_102_11.z = 0
				var_102_11.x = 0
				var_102_5.localEulerAngles = var_102_11
			end

			if arg_99_1.time_ >= var_102_6 + var_102_7 and arg_99_1.time_ < var_102_6 + var_102_7 + arg_102_0 then
				var_102_5.localPosition = Vector3.New(1, -0.35, -4)

				local var_102_12 = manager.ui.mainCamera.transform.position - var_102_5.position

				var_102_5.forward = Vector3.New(var_102_12.x, var_102_12.y, var_102_12.z)

				local var_102_13 = var_102_5.localEulerAngles

				var_102_13.z = 0
				var_102_13.x = 0
				var_102_5.localEulerAngles = var_102_13
			end

			local var_102_14 = arg_99_1.actors_["10076ui_story"]
			local var_102_15 = 0

			if var_102_15 < arg_99_1.time_ and arg_99_1.time_ <= var_102_15 + arg_102_0 and not isNil(var_102_14) and arg_99_1.var_.characterEffect10076ui_story == nil then
				arg_99_1.var_.characterEffect10076ui_story = var_102_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_16 = 0.200000002980232

			if var_102_15 <= arg_99_1.time_ and arg_99_1.time_ < var_102_15 + var_102_16 and not isNil(var_102_14) then
				local var_102_17 = (arg_99_1.time_ - var_102_15) / var_102_16

				if arg_99_1.var_.characterEffect10076ui_story and not isNil(var_102_14) then
					arg_99_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_15 + var_102_16 and arg_99_1.time_ < var_102_15 + var_102_16 + arg_102_0 and not isNil(var_102_14) and arg_99_1.var_.characterEffect10076ui_story then
				arg_99_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			local var_102_18 = 0

			if var_102_18 < arg_99_1.time_ and arg_99_1.time_ <= var_102_18 + arg_102_0 then
				arg_99_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action4_1")
			end

			local var_102_19 = 0

			if var_102_19 < arg_99_1.time_ and arg_99_1.time_ <= var_102_19 + arg_102_0 then
				arg_99_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_102_20 = arg_99_1.actors_["1197ui_story"]
			local var_102_21 = 0

			if var_102_21 < arg_99_1.time_ and arg_99_1.time_ <= var_102_21 + arg_102_0 and not isNil(var_102_20) and arg_99_1.var_.characterEffect1197ui_story == nil then
				arg_99_1.var_.characterEffect1197ui_story = var_102_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_22 = 0.200000002980232

			if var_102_21 <= arg_99_1.time_ and arg_99_1.time_ < var_102_21 + var_102_22 and not isNil(var_102_20) then
				local var_102_23 = (arg_99_1.time_ - var_102_21) / var_102_22

				if arg_99_1.var_.characterEffect1197ui_story and not isNil(var_102_20) then
					local var_102_24 = Mathf.Lerp(0, 0.5, var_102_23)

					arg_99_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1197ui_story.fillRatio = var_102_24
				end
			end

			if arg_99_1.time_ >= var_102_21 + var_102_22 and arg_99_1.time_ < var_102_21 + var_102_22 + arg_102_0 and not isNil(var_102_20) and arg_99_1.var_.characterEffect1197ui_story then
				local var_102_25 = 0.5

				arg_99_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1197ui_story.fillRatio = var_102_25
			end

			local var_102_26 = 0
			local var_102_27 = 0.875

			if var_102_26 < arg_99_1.time_ and arg_99_1.time_ <= var_102_26 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_28 = arg_99_1:FormatText(StoryNameCfg[917].name)

				arg_99_1.leftNameTxt_.text = var_102_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_29 = arg_99_1:GetWordFromCfg(412131023)
				local var_102_30 = arg_99_1:FormatText(var_102_29.content)

				arg_99_1.text_.text = var_102_30

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_31 = 35
				local var_102_32 = utf8.len(var_102_30)
				local var_102_33 = var_102_31 <= 0 and var_102_27 or var_102_27 * (var_102_32 / var_102_31)

				if var_102_33 > 0 and var_102_27 < var_102_33 then
					arg_99_1.talkMaxDuration = var_102_33

					if var_102_33 + var_102_26 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_33 + var_102_26
					end
				end

				arg_99_1.text_.text = var_102_30
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131023", "story_v_out_412131.awb") ~= 0 then
					local var_102_34 = manager.audio:GetVoiceLength("story_v_out_412131", "412131023", "story_v_out_412131.awb") / 1000

					if var_102_34 + var_102_26 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_34 + var_102_26
					end

					if var_102_29.prefab_name ~= "" and arg_99_1.actors_[var_102_29.prefab_name] ~= nil then
						local var_102_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_29.prefab_name].transform, "story_v_out_412131", "412131023", "story_v_out_412131.awb")

						arg_99_1:RecordAudio("412131023", var_102_35)
						arg_99_1:RecordAudio("412131023", var_102_35)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_412131", "412131023", "story_v_out_412131.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_412131", "412131023", "story_v_out_412131.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_36 = math.max(var_102_27, arg_99_1.talkMaxDuration)

			if var_102_26 <= arg_99_1.time_ and arg_99_1.time_ < var_102_26 + var_102_36 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_26) / var_102_36

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_26 + var_102_36 and arg_99_1.time_ < var_102_26 + var_102_36 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play412131024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 412131024
		arg_103_1.duration_ = 9.9

		local var_103_0 = {
			zh = 8.966,
			ja = 9.9
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
				arg_103_0:Play412131025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1197ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1197ui_story == nil then
				arg_103_1.var_.characterEffect1197ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect1197ui_story and not isNil(var_106_0) then
					arg_103_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1197ui_story then
				arg_103_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			local var_106_4 = 0

			if var_106_4 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action6_2")
			end

			local var_106_5 = 0

			if var_106_5 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_106_6 = arg_103_1.actors_["10076ui_story"]
			local var_106_7 = 0

			if var_106_7 < arg_103_1.time_ and arg_103_1.time_ <= var_106_7 + arg_106_0 and not isNil(var_106_6) and arg_103_1.var_.characterEffect10076ui_story == nil then
				arg_103_1.var_.characterEffect10076ui_story = var_106_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_8 = 0.200000002980232

			if var_106_7 <= arg_103_1.time_ and arg_103_1.time_ < var_106_7 + var_106_8 and not isNil(var_106_6) then
				local var_106_9 = (arg_103_1.time_ - var_106_7) / var_106_8

				if arg_103_1.var_.characterEffect10076ui_story and not isNil(var_106_6) then
					local var_106_10 = Mathf.Lerp(0, 0.5, var_106_9)

					arg_103_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_103_1.var_.characterEffect10076ui_story.fillRatio = var_106_10
				end
			end

			if arg_103_1.time_ >= var_106_7 + var_106_8 and arg_103_1.time_ < var_106_7 + var_106_8 + arg_106_0 and not isNil(var_106_6) and arg_103_1.var_.characterEffect10076ui_story then
				local var_106_11 = 0.5

				arg_103_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_103_1.var_.characterEffect10076ui_story.fillRatio = var_106_11
			end

			local var_106_12 = 0
			local var_106_13 = 0.625

			if var_106_12 < arg_103_1.time_ and arg_103_1.time_ <= var_106_12 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_14 = arg_103_1:FormatText(StoryNameCfg[216].name)

				arg_103_1.leftNameTxt_.text = var_106_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_15 = arg_103_1:GetWordFromCfg(412131024)
				local var_106_16 = arg_103_1:FormatText(var_106_15.content)

				arg_103_1.text_.text = var_106_16

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_17 = 25
				local var_106_18 = utf8.len(var_106_16)
				local var_106_19 = var_106_17 <= 0 and var_106_13 or var_106_13 * (var_106_18 / var_106_17)

				if var_106_19 > 0 and var_106_13 < var_106_19 then
					arg_103_1.talkMaxDuration = var_106_19

					if var_106_19 + var_106_12 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_19 + var_106_12
					end
				end

				arg_103_1.text_.text = var_106_16
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131024", "story_v_out_412131.awb") ~= 0 then
					local var_106_20 = manager.audio:GetVoiceLength("story_v_out_412131", "412131024", "story_v_out_412131.awb") / 1000

					if var_106_20 + var_106_12 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_20 + var_106_12
					end

					if var_106_15.prefab_name ~= "" and arg_103_1.actors_[var_106_15.prefab_name] ~= nil then
						local var_106_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_15.prefab_name].transform, "story_v_out_412131", "412131024", "story_v_out_412131.awb")

						arg_103_1:RecordAudio("412131024", var_106_21)
						arg_103_1:RecordAudio("412131024", var_106_21)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_412131", "412131024", "story_v_out_412131.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_412131", "412131024", "story_v_out_412131.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_22 = math.max(var_106_13, arg_103_1.talkMaxDuration)

			if var_106_12 <= arg_103_1.time_ and arg_103_1.time_ < var_106_12 + var_106_22 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_12) / var_106_22

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_12 + var_106_22 and arg_103_1.time_ < var_106_12 + var_106_22 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play412131025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 412131025
		arg_107_1.duration_ = 9

		local var_107_0 = {
			zh = 4,
			ja = 9
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
				arg_107_0:Play412131026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = "10077ui_story"

			if arg_107_1.actors_[var_110_0] == nil then
				local var_110_1 = Asset.Load("Char/" .. "10077ui_story")

				if not isNil(var_110_1) then
					local var_110_2 = Object.Instantiate(Asset.Load("Char/" .. "10077ui_story"), arg_107_1.stage_.transform)

					var_110_2.name = var_110_0
					var_110_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_107_1.actors_[var_110_0] = var_110_2

					local var_110_3 = var_110_2:GetComponentInChildren(typeof(CharacterEffect))

					var_110_3.enabled = true

					local var_110_4 = GameObjectTools.GetOrAddComponent(var_110_2, typeof(DynamicBoneHelper))

					if var_110_4 then
						var_110_4:EnableDynamicBone(false)
					end

					arg_107_1:ShowWeapon(var_110_3.transform, false)

					arg_107_1.var_[var_110_0 .. "Animator"] = var_110_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_107_1.var_[var_110_0 .. "Animator"].applyRootMotion = true
					arg_107_1.var_[var_110_0 .. "LipSync"] = var_110_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_110_5 = arg_107_1.actors_["10077ui_story"].transform
			local var_110_6 = 0

			if var_110_6 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
				arg_107_1.var_.moveOldPos10077ui_story = var_110_5.localPosition
			end

			local var_110_7 = 0.001

			if var_110_6 <= arg_107_1.time_ and arg_107_1.time_ < var_110_6 + var_110_7 then
				local var_110_8 = (arg_107_1.time_ - var_110_6) / var_110_7
				local var_110_9 = Vector3.New(0, 0, -5)

				var_110_5.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10077ui_story, var_110_9, var_110_8)

				local var_110_10 = manager.ui.mainCamera.transform.position - var_110_5.position

				var_110_5.forward = Vector3.New(var_110_10.x, var_110_10.y, var_110_10.z)

				local var_110_11 = var_110_5.localEulerAngles

				var_110_11.z = 0
				var_110_11.x = 0
				var_110_5.localEulerAngles = var_110_11
			end

			if arg_107_1.time_ >= var_110_6 + var_110_7 and arg_107_1.time_ < var_110_6 + var_110_7 + arg_110_0 then
				var_110_5.localPosition = Vector3.New(0, 0, -5)

				local var_110_12 = manager.ui.mainCamera.transform.position - var_110_5.position

				var_110_5.forward = Vector3.New(var_110_12.x, var_110_12.y, var_110_12.z)

				local var_110_13 = var_110_5.localEulerAngles

				var_110_13.z = 0
				var_110_13.x = 0
				var_110_5.localEulerAngles = var_110_13
			end

			local var_110_14 = arg_107_1.actors_["10077ui_story"]
			local var_110_15 = 0

			if var_110_15 < arg_107_1.time_ and arg_107_1.time_ <= var_110_15 + arg_110_0 and not isNil(var_110_14) and arg_107_1.var_.characterEffect10077ui_story == nil then
				arg_107_1.var_.characterEffect10077ui_story = var_110_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_16 = 0.200000002980232

			if var_110_15 <= arg_107_1.time_ and arg_107_1.time_ < var_110_15 + var_110_16 and not isNil(var_110_14) then
				local var_110_17 = (arg_107_1.time_ - var_110_15) / var_110_16

				if arg_107_1.var_.characterEffect10077ui_story and not isNil(var_110_14) then
					arg_107_1.var_.characterEffect10077ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_15 + var_110_16 and arg_107_1.time_ < var_110_15 + var_110_16 + arg_110_0 and not isNil(var_110_14) and arg_107_1.var_.characterEffect10077ui_story then
				arg_107_1.var_.characterEffect10077ui_story.fillFlat = false
			end

			local var_110_18 = 0

			if var_110_18 < arg_107_1.time_ and arg_107_1.time_ <= var_110_18 + arg_110_0 then
				arg_107_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/story10077/story10077action/10077action3_1")
			end

			local var_110_19 = 0

			if var_110_19 < arg_107_1.time_ and arg_107_1.time_ <= var_110_19 + arg_110_0 then
				arg_107_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_110_20 = arg_107_1.actors_["1197ui_story"].transform
			local var_110_21 = 0

			if var_110_21 < arg_107_1.time_ and arg_107_1.time_ <= var_110_21 + arg_110_0 then
				arg_107_1.var_.moveOldPos1197ui_story = var_110_20.localPosition
			end

			local var_110_22 = 0.001

			if var_110_21 <= arg_107_1.time_ and arg_107_1.time_ < var_110_21 + var_110_22 then
				local var_110_23 = (arg_107_1.time_ - var_110_21) / var_110_22
				local var_110_24 = Vector3.New(0, 100, 0)

				var_110_20.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1197ui_story, var_110_24, var_110_23)

				local var_110_25 = manager.ui.mainCamera.transform.position - var_110_20.position

				var_110_20.forward = Vector3.New(var_110_25.x, var_110_25.y, var_110_25.z)

				local var_110_26 = var_110_20.localEulerAngles

				var_110_26.z = 0
				var_110_26.x = 0
				var_110_20.localEulerAngles = var_110_26
			end

			if arg_107_1.time_ >= var_110_21 + var_110_22 and arg_107_1.time_ < var_110_21 + var_110_22 + arg_110_0 then
				var_110_20.localPosition = Vector3.New(0, 100, 0)

				local var_110_27 = manager.ui.mainCamera.transform.position - var_110_20.position

				var_110_20.forward = Vector3.New(var_110_27.x, var_110_27.y, var_110_27.z)

				local var_110_28 = var_110_20.localEulerAngles

				var_110_28.z = 0
				var_110_28.x = 0
				var_110_20.localEulerAngles = var_110_28
			end

			local var_110_29 = arg_107_1.actors_["1197ui_story"]
			local var_110_30 = 0

			if var_110_30 < arg_107_1.time_ and arg_107_1.time_ <= var_110_30 + arg_110_0 and not isNil(var_110_29) and arg_107_1.var_.characterEffect1197ui_story == nil then
				arg_107_1.var_.characterEffect1197ui_story = var_110_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_31 = 0.200000002980232

			if var_110_30 <= arg_107_1.time_ and arg_107_1.time_ < var_110_30 + var_110_31 and not isNil(var_110_29) then
				local var_110_32 = (arg_107_1.time_ - var_110_30) / var_110_31

				if arg_107_1.var_.characterEffect1197ui_story and not isNil(var_110_29) then
					local var_110_33 = Mathf.Lerp(0, 0.5, var_110_32)

					arg_107_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1197ui_story.fillRatio = var_110_33
				end
			end

			if arg_107_1.time_ >= var_110_30 + var_110_31 and arg_107_1.time_ < var_110_30 + var_110_31 + arg_110_0 and not isNil(var_110_29) and arg_107_1.var_.characterEffect1197ui_story then
				local var_110_34 = 0.5

				arg_107_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1197ui_story.fillRatio = var_110_34
			end

			local var_110_35 = arg_107_1.actors_["10076ui_story"].transform
			local var_110_36 = 0

			if var_110_36 < arg_107_1.time_ and arg_107_1.time_ <= var_110_36 + arg_110_0 then
				arg_107_1.var_.moveOldPos10076ui_story = var_110_35.localPosition
			end

			local var_110_37 = 0.001

			if var_110_36 <= arg_107_1.time_ and arg_107_1.time_ < var_110_36 + var_110_37 then
				local var_110_38 = (arg_107_1.time_ - var_110_36) / var_110_37
				local var_110_39 = Vector3.New(0, 100, 0)

				var_110_35.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10076ui_story, var_110_39, var_110_38)

				local var_110_40 = manager.ui.mainCamera.transform.position - var_110_35.position

				var_110_35.forward = Vector3.New(var_110_40.x, var_110_40.y, var_110_40.z)

				local var_110_41 = var_110_35.localEulerAngles

				var_110_41.z = 0
				var_110_41.x = 0
				var_110_35.localEulerAngles = var_110_41
			end

			if arg_107_1.time_ >= var_110_36 + var_110_37 and arg_107_1.time_ < var_110_36 + var_110_37 + arg_110_0 then
				var_110_35.localPosition = Vector3.New(0, 100, 0)

				local var_110_42 = manager.ui.mainCamera.transform.position - var_110_35.position

				var_110_35.forward = Vector3.New(var_110_42.x, var_110_42.y, var_110_42.z)

				local var_110_43 = var_110_35.localEulerAngles

				var_110_43.z = 0
				var_110_43.x = 0
				var_110_35.localEulerAngles = var_110_43
			end

			local var_110_44 = arg_107_1.actors_["10076ui_story"]
			local var_110_45 = 0

			if var_110_45 < arg_107_1.time_ and arg_107_1.time_ <= var_110_45 + arg_110_0 and not isNil(var_110_44) and arg_107_1.var_.characterEffect10076ui_story == nil then
				arg_107_1.var_.characterEffect10076ui_story = var_110_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_46 = 0.200000002980232

			if var_110_45 <= arg_107_1.time_ and arg_107_1.time_ < var_110_45 + var_110_46 and not isNil(var_110_44) then
				local var_110_47 = (arg_107_1.time_ - var_110_45) / var_110_46

				if arg_107_1.var_.characterEffect10076ui_story and not isNil(var_110_44) then
					local var_110_48 = Mathf.Lerp(0, 0.5, var_110_47)

					arg_107_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_107_1.var_.characterEffect10076ui_story.fillRatio = var_110_48
				end
			end

			if arg_107_1.time_ >= var_110_45 + var_110_46 and arg_107_1.time_ < var_110_45 + var_110_46 + arg_110_0 and not isNil(var_110_44) and arg_107_1.var_.characterEffect10076ui_story then
				local var_110_49 = 0.5

				arg_107_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_107_1.var_.characterEffect10076ui_story.fillRatio = var_110_49
			end

			local var_110_50 = 0
			local var_110_51 = 0.6

			if var_110_50 < arg_107_1.time_ and arg_107_1.time_ <= var_110_50 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_52 = arg_107_1:FormatText(StoryNameCfg[922].name)

				arg_107_1.leftNameTxt_.text = var_110_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_53 = arg_107_1:GetWordFromCfg(412131025)
				local var_110_54 = arg_107_1:FormatText(var_110_53.content)

				arg_107_1.text_.text = var_110_54

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_55 = 24
				local var_110_56 = utf8.len(var_110_54)
				local var_110_57 = var_110_55 <= 0 and var_110_51 or var_110_51 * (var_110_56 / var_110_55)

				if var_110_57 > 0 and var_110_51 < var_110_57 then
					arg_107_1.talkMaxDuration = var_110_57

					if var_110_57 + var_110_50 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_57 + var_110_50
					end
				end

				arg_107_1.text_.text = var_110_54
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131025", "story_v_out_412131.awb") ~= 0 then
					local var_110_58 = manager.audio:GetVoiceLength("story_v_out_412131", "412131025", "story_v_out_412131.awb") / 1000

					if var_110_58 + var_110_50 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_58 + var_110_50
					end

					if var_110_53.prefab_name ~= "" and arg_107_1.actors_[var_110_53.prefab_name] ~= nil then
						local var_110_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_53.prefab_name].transform, "story_v_out_412131", "412131025", "story_v_out_412131.awb")

						arg_107_1:RecordAudio("412131025", var_110_59)
						arg_107_1:RecordAudio("412131025", var_110_59)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_412131", "412131025", "story_v_out_412131.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_412131", "412131025", "story_v_out_412131.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_60 = math.max(var_110_51, arg_107_1.talkMaxDuration)

			if var_110_50 <= arg_107_1.time_ and arg_107_1.time_ < var_110_50 + var_110_60 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_50) / var_110_60

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_50 + var_110_60 and arg_107_1.time_ < var_110_50 + var_110_60 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play412131026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 412131026
		arg_111_1.duration_ = 10.77

		local var_111_0 = {
			zh = 10.333,
			ja = 10.766
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play412131027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 1.125

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[922].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_3 = arg_111_1:GetWordFromCfg(412131026)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 45
				local var_114_6 = utf8.len(var_114_4)
				local var_114_7 = var_114_5 <= 0 and var_114_1 or var_114_1 * (var_114_6 / var_114_5)

				if var_114_7 > 0 and var_114_1 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131026", "story_v_out_412131.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_412131", "412131026", "story_v_out_412131.awb") / 1000

					if var_114_8 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_0
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_out_412131", "412131026", "story_v_out_412131.awb")

						arg_111_1:RecordAudio("412131026", var_114_9)
						arg_111_1:RecordAudio("412131026", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_412131", "412131026", "story_v_out_412131.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_412131", "412131026", "story_v_out_412131.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_10 and arg_111_1.time_ < var_114_0 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play412131027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 412131027
		arg_115_1.duration_ = 7.73

		local var_115_0 = {
			zh = 5.433,
			ja = 7.733
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
				arg_115_0:Play412131028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = "10078ui_story"

			if arg_115_1.actors_[var_118_0] == nil then
				local var_118_1 = Asset.Load("Char/" .. "10078ui_story")

				if not isNil(var_118_1) then
					local var_118_2 = Object.Instantiate(Asset.Load("Char/" .. "10078ui_story"), arg_115_1.stage_.transform)

					var_118_2.name = var_118_0
					var_118_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_115_1.actors_[var_118_0] = var_118_2

					local var_118_3 = var_118_2:GetComponentInChildren(typeof(CharacterEffect))

					var_118_3.enabled = true

					local var_118_4 = GameObjectTools.GetOrAddComponent(var_118_2, typeof(DynamicBoneHelper))

					if var_118_4 then
						var_118_4:EnableDynamicBone(false)
					end

					arg_115_1:ShowWeapon(var_118_3.transform, false)

					arg_115_1.var_[var_118_0 .. "Animator"] = var_118_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_115_1.var_[var_118_0 .. "Animator"].applyRootMotion = true
					arg_115_1.var_[var_118_0 .. "LipSync"] = var_118_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_118_5 = arg_115_1.actors_["10078ui_story"].transform
			local var_118_6 = 0

			if var_118_6 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.var_.moveOldPos10078ui_story = var_118_5.localPosition
			end

			local var_118_7 = 0.001

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_7 then
				local var_118_8 = (arg_115_1.time_ - var_118_6) / var_118_7
				local var_118_9 = Vector3.New(0, -0.5, -6.3)

				var_118_5.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10078ui_story, var_118_9, var_118_8)

				local var_118_10 = manager.ui.mainCamera.transform.position - var_118_5.position

				var_118_5.forward = Vector3.New(var_118_10.x, var_118_10.y, var_118_10.z)

				local var_118_11 = var_118_5.localEulerAngles

				var_118_11.z = 0
				var_118_11.x = 0
				var_118_5.localEulerAngles = var_118_11
			end

			if arg_115_1.time_ >= var_118_6 + var_118_7 and arg_115_1.time_ < var_118_6 + var_118_7 + arg_118_0 then
				var_118_5.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_118_12 = manager.ui.mainCamera.transform.position - var_118_5.position

				var_118_5.forward = Vector3.New(var_118_12.x, var_118_12.y, var_118_12.z)

				local var_118_13 = var_118_5.localEulerAngles

				var_118_13.z = 0
				var_118_13.x = 0
				var_118_5.localEulerAngles = var_118_13
			end

			local var_118_14 = arg_115_1.actors_["10078ui_story"]
			local var_118_15 = 0

			if var_118_15 < arg_115_1.time_ and arg_115_1.time_ <= var_118_15 + arg_118_0 and not isNil(var_118_14) and arg_115_1.var_.characterEffect10078ui_story == nil then
				arg_115_1.var_.characterEffect10078ui_story = var_118_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_16 = 0.200000002980232

			if var_118_15 <= arg_115_1.time_ and arg_115_1.time_ < var_118_15 + var_118_16 and not isNil(var_118_14) then
				local var_118_17 = (arg_115_1.time_ - var_118_15) / var_118_16

				if arg_115_1.var_.characterEffect10078ui_story and not isNil(var_118_14) then
					arg_115_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_15 + var_118_16 and arg_115_1.time_ < var_118_15 + var_118_16 + arg_118_0 and not isNil(var_118_14) and arg_115_1.var_.characterEffect10078ui_story then
				arg_115_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_118_18 = 0

			if var_118_18 < arg_115_1.time_ and arg_115_1.time_ <= var_118_18 + arg_118_0 then
				arg_115_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action5_1")
			end

			local var_118_19 = 0

			if var_118_19 < arg_115_1.time_ and arg_115_1.time_ <= var_118_19 + arg_118_0 then
				arg_115_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_20 = arg_115_1.actors_["10077ui_story"].transform
			local var_118_21 = 0

			if var_118_21 < arg_115_1.time_ and arg_115_1.time_ <= var_118_21 + arg_118_0 then
				arg_115_1.var_.moveOldPos10077ui_story = var_118_20.localPosition
			end

			local var_118_22 = 0.001

			if var_118_21 <= arg_115_1.time_ and arg_115_1.time_ < var_118_21 + var_118_22 then
				local var_118_23 = (arg_115_1.time_ - var_118_21) / var_118_22
				local var_118_24 = Vector3.New(0, 100, 0)

				var_118_20.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10077ui_story, var_118_24, var_118_23)

				local var_118_25 = manager.ui.mainCamera.transform.position - var_118_20.position

				var_118_20.forward = Vector3.New(var_118_25.x, var_118_25.y, var_118_25.z)

				local var_118_26 = var_118_20.localEulerAngles

				var_118_26.z = 0
				var_118_26.x = 0
				var_118_20.localEulerAngles = var_118_26
			end

			if arg_115_1.time_ >= var_118_21 + var_118_22 and arg_115_1.time_ < var_118_21 + var_118_22 + arg_118_0 then
				var_118_20.localPosition = Vector3.New(0, 100, 0)

				local var_118_27 = manager.ui.mainCamera.transform.position - var_118_20.position

				var_118_20.forward = Vector3.New(var_118_27.x, var_118_27.y, var_118_27.z)

				local var_118_28 = var_118_20.localEulerAngles

				var_118_28.z = 0
				var_118_28.x = 0
				var_118_20.localEulerAngles = var_118_28
			end

			local var_118_29 = arg_115_1.actors_["10077ui_story"]
			local var_118_30 = 0

			if var_118_30 < arg_115_1.time_ and arg_115_1.time_ <= var_118_30 + arg_118_0 and not isNil(var_118_29) and arg_115_1.var_.characterEffect10077ui_story == nil then
				arg_115_1.var_.characterEffect10077ui_story = var_118_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_31 = 0.200000002980232

			if var_118_30 <= arg_115_1.time_ and arg_115_1.time_ < var_118_30 + var_118_31 and not isNil(var_118_29) then
				local var_118_32 = (arg_115_1.time_ - var_118_30) / var_118_31

				if arg_115_1.var_.characterEffect10077ui_story and not isNil(var_118_29) then
					local var_118_33 = Mathf.Lerp(0, 0.5, var_118_32)

					arg_115_1.var_.characterEffect10077ui_story.fillFlat = true
					arg_115_1.var_.characterEffect10077ui_story.fillRatio = var_118_33
				end
			end

			if arg_115_1.time_ >= var_118_30 + var_118_31 and arg_115_1.time_ < var_118_30 + var_118_31 + arg_118_0 and not isNil(var_118_29) and arg_115_1.var_.characterEffect10077ui_story then
				local var_118_34 = 0.5

				arg_115_1.var_.characterEffect10077ui_story.fillFlat = true
				arg_115_1.var_.characterEffect10077ui_story.fillRatio = var_118_34
			end

			local var_118_35 = 0
			local var_118_36 = 0.475

			if var_118_35 < arg_115_1.time_ and arg_115_1.time_ <= var_118_35 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_37 = arg_115_1:FormatText(StoryNameCfg[919].name)

				arg_115_1.leftNameTxt_.text = var_118_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_38 = arg_115_1:GetWordFromCfg(412131027)
				local var_118_39 = arg_115_1:FormatText(var_118_38.content)

				arg_115_1.text_.text = var_118_39

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_40 = 19
				local var_118_41 = utf8.len(var_118_39)
				local var_118_42 = var_118_40 <= 0 and var_118_36 or var_118_36 * (var_118_41 / var_118_40)

				if var_118_42 > 0 and var_118_36 < var_118_42 then
					arg_115_1.talkMaxDuration = var_118_42

					if var_118_42 + var_118_35 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_42 + var_118_35
					end
				end

				arg_115_1.text_.text = var_118_39
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131027", "story_v_out_412131.awb") ~= 0 then
					local var_118_43 = manager.audio:GetVoiceLength("story_v_out_412131", "412131027", "story_v_out_412131.awb") / 1000

					if var_118_43 + var_118_35 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_43 + var_118_35
					end

					if var_118_38.prefab_name ~= "" and arg_115_1.actors_[var_118_38.prefab_name] ~= nil then
						local var_118_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_38.prefab_name].transform, "story_v_out_412131", "412131027", "story_v_out_412131.awb")

						arg_115_1:RecordAudio("412131027", var_118_44)
						arg_115_1:RecordAudio("412131027", var_118_44)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_412131", "412131027", "story_v_out_412131.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_412131", "412131027", "story_v_out_412131.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_45 = math.max(var_118_36, arg_115_1.talkMaxDuration)

			if var_118_35 <= arg_115_1.time_ and arg_115_1.time_ < var_118_35 + var_118_45 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_35) / var_118_45

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_35 + var_118_45 and arg_115_1.time_ < var_118_35 + var_118_45 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10077ui_story",
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
	Play412131028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 412131028
		arg_119_1.duration_ = 2.4

		local var_119_0 = {
			zh = 2.4,
			ja = 1.999999999999
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
				arg_119_0:Play412131029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1197ui_story"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos1197ui_story = var_122_0.localPosition
			end

			local var_122_2 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2
				local var_122_4 = Vector3.New(0, -0.545, -6.3)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1197ui_story, var_122_4, var_122_3)

				local var_122_5 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_5.x, var_122_5.y, var_122_5.z)

				local var_122_6 = var_122_0.localEulerAngles

				var_122_6.z = 0
				var_122_6.x = 0
				var_122_0.localEulerAngles = var_122_6
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(0, -0.545, -6.3)

				local var_122_7 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_7.x, var_122_7.y, var_122_7.z)

				local var_122_8 = var_122_0.localEulerAngles

				var_122_8.z = 0
				var_122_8.x = 0
				var_122_0.localEulerAngles = var_122_8
			end

			local var_122_9 = arg_119_1.actors_["1197ui_story"]
			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 and not isNil(var_122_9) and arg_119_1.var_.characterEffect1197ui_story == nil then
				arg_119_1.var_.characterEffect1197ui_story = var_122_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_11 = 0.200000002980232

			if var_122_10 <= arg_119_1.time_ and arg_119_1.time_ < var_122_10 + var_122_11 and not isNil(var_122_9) then
				local var_122_12 = (arg_119_1.time_ - var_122_10) / var_122_11

				if arg_119_1.var_.characterEffect1197ui_story and not isNil(var_122_9) then
					arg_119_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_10 + var_122_11 and arg_119_1.time_ < var_122_10 + var_122_11 + arg_122_0 and not isNil(var_122_9) and arg_119_1.var_.characterEffect1197ui_story then
				arg_119_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			local var_122_13 = 0

			if var_122_13 < arg_119_1.time_ and arg_119_1.time_ <= var_122_13 + arg_122_0 then
				arg_119_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_122_14 = arg_119_1.actors_["10078ui_story"].transform
			local var_122_15 = 0

			if var_122_15 < arg_119_1.time_ and arg_119_1.time_ <= var_122_15 + arg_122_0 then
				arg_119_1.var_.moveOldPos10078ui_story = var_122_14.localPosition
			end

			local var_122_16 = 0.001

			if var_122_15 <= arg_119_1.time_ and arg_119_1.time_ < var_122_15 + var_122_16 then
				local var_122_17 = (arg_119_1.time_ - var_122_15) / var_122_16
				local var_122_18 = Vector3.New(0, 100, 0)

				var_122_14.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10078ui_story, var_122_18, var_122_17)

				local var_122_19 = manager.ui.mainCamera.transform.position - var_122_14.position

				var_122_14.forward = Vector3.New(var_122_19.x, var_122_19.y, var_122_19.z)

				local var_122_20 = var_122_14.localEulerAngles

				var_122_20.z = 0
				var_122_20.x = 0
				var_122_14.localEulerAngles = var_122_20
			end

			if arg_119_1.time_ >= var_122_15 + var_122_16 and arg_119_1.time_ < var_122_15 + var_122_16 + arg_122_0 then
				var_122_14.localPosition = Vector3.New(0, 100, 0)

				local var_122_21 = manager.ui.mainCamera.transform.position - var_122_14.position

				var_122_14.forward = Vector3.New(var_122_21.x, var_122_21.y, var_122_21.z)

				local var_122_22 = var_122_14.localEulerAngles

				var_122_22.z = 0
				var_122_22.x = 0
				var_122_14.localEulerAngles = var_122_22
			end

			local var_122_23 = arg_119_1.actors_["10078ui_story"]
			local var_122_24 = 0

			if var_122_24 < arg_119_1.time_ and arg_119_1.time_ <= var_122_24 + arg_122_0 and not isNil(var_122_23) and arg_119_1.var_.characterEffect10078ui_story == nil then
				arg_119_1.var_.characterEffect10078ui_story = var_122_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_25 = 0.200000002980232

			if var_122_24 <= arg_119_1.time_ and arg_119_1.time_ < var_122_24 + var_122_25 and not isNil(var_122_23) then
				local var_122_26 = (arg_119_1.time_ - var_122_24) / var_122_25

				if arg_119_1.var_.characterEffect10078ui_story and not isNil(var_122_23) then
					local var_122_27 = Mathf.Lerp(0, 0.5, var_122_26)

					arg_119_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10078ui_story.fillRatio = var_122_27
				end
			end

			if arg_119_1.time_ >= var_122_24 + var_122_25 and arg_119_1.time_ < var_122_24 + var_122_25 + arg_122_0 and not isNil(var_122_23) and arg_119_1.var_.characterEffect10078ui_story then
				local var_122_28 = 0.5

				arg_119_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10078ui_story.fillRatio = var_122_28
			end

			local var_122_29 = 0
			local var_122_30 = 0.2

			if var_122_29 < arg_119_1.time_ and arg_119_1.time_ <= var_122_29 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_31 = arg_119_1:FormatText(StoryNameCfg[216].name)

				arg_119_1.leftNameTxt_.text = var_122_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_32 = arg_119_1:GetWordFromCfg(412131028)
				local var_122_33 = arg_119_1:FormatText(var_122_32.content)

				arg_119_1.text_.text = var_122_33

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_34 = 8
				local var_122_35 = utf8.len(var_122_33)
				local var_122_36 = var_122_34 <= 0 and var_122_30 or var_122_30 * (var_122_35 / var_122_34)

				if var_122_36 > 0 and var_122_30 < var_122_36 then
					arg_119_1.talkMaxDuration = var_122_36

					if var_122_36 + var_122_29 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_36 + var_122_29
					end
				end

				arg_119_1.text_.text = var_122_33
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131028", "story_v_out_412131.awb") ~= 0 then
					local var_122_37 = manager.audio:GetVoiceLength("story_v_out_412131", "412131028", "story_v_out_412131.awb") / 1000

					if var_122_37 + var_122_29 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_37 + var_122_29
					end

					if var_122_32.prefab_name ~= "" and arg_119_1.actors_[var_122_32.prefab_name] ~= nil then
						local var_122_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_32.prefab_name].transform, "story_v_out_412131", "412131028", "story_v_out_412131.awb")

						arg_119_1:RecordAudio("412131028", var_122_38)
						arg_119_1:RecordAudio("412131028", var_122_38)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_412131", "412131028", "story_v_out_412131.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_412131", "412131028", "story_v_out_412131.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_39 = math.max(var_122_30, arg_119_1.talkMaxDuration)

			if var_122_29 <= arg_119_1.time_ and arg_119_1.time_ < var_122_29 + var_122_39 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_29) / var_122_39

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_29 + var_122_39 and arg_119_1.time_ < var_122_29 + var_122_39 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play412131029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 412131029
		arg_123_1.duration_ = 6.17

		local var_123_0 = {
			zh = 5.666,
			ja = 6.166
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
				arg_123_0:Play412131030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10078ui_story"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos10078ui_story = var_126_0.localPosition
			end

			local var_126_2 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2
				local var_126_4 = Vector3.New(0, -0.5, -6.3)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10078ui_story, var_126_4, var_126_3)

				local var_126_5 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_5.x, var_126_5.y, var_126_5.z)

				local var_126_6 = var_126_0.localEulerAngles

				var_126_6.z = 0
				var_126_6.x = 0
				var_126_0.localEulerAngles = var_126_6
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_126_7 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_7.x, var_126_7.y, var_126_7.z)

				local var_126_8 = var_126_0.localEulerAngles

				var_126_8.z = 0
				var_126_8.x = 0
				var_126_0.localEulerAngles = var_126_8
			end

			local var_126_9 = arg_123_1.actors_["10078ui_story"]
			local var_126_10 = 0

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect10078ui_story == nil then
				arg_123_1.var_.characterEffect10078ui_story = var_126_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_11 = 0.200000002980232

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_11 and not isNil(var_126_9) then
				local var_126_12 = (arg_123_1.time_ - var_126_10) / var_126_11

				if arg_123_1.var_.characterEffect10078ui_story and not isNil(var_126_9) then
					arg_123_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_10 + var_126_11 and arg_123_1.time_ < var_126_10 + var_126_11 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect10078ui_story then
				arg_123_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_126_13 = 0

			if var_126_13 < arg_123_1.time_ and arg_123_1.time_ <= var_126_13 + arg_126_0 then
				arg_123_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action3_1")
			end

			local var_126_14 = 0

			if var_126_14 < arg_123_1.time_ and arg_123_1.time_ <= var_126_14 + arg_126_0 then
				arg_123_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_15 = arg_123_1.actors_["1197ui_story"].transform
			local var_126_16 = 0

			if var_126_16 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 then
				arg_123_1.var_.moveOldPos1197ui_story = var_126_15.localPosition
			end

			local var_126_17 = 0.001

			if var_126_16 <= arg_123_1.time_ and arg_123_1.time_ < var_126_16 + var_126_17 then
				local var_126_18 = (arg_123_1.time_ - var_126_16) / var_126_17
				local var_126_19 = Vector3.New(0, 100, 0)

				var_126_15.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1197ui_story, var_126_19, var_126_18)

				local var_126_20 = manager.ui.mainCamera.transform.position - var_126_15.position

				var_126_15.forward = Vector3.New(var_126_20.x, var_126_20.y, var_126_20.z)

				local var_126_21 = var_126_15.localEulerAngles

				var_126_21.z = 0
				var_126_21.x = 0
				var_126_15.localEulerAngles = var_126_21
			end

			if arg_123_1.time_ >= var_126_16 + var_126_17 and arg_123_1.time_ < var_126_16 + var_126_17 + arg_126_0 then
				var_126_15.localPosition = Vector3.New(0, 100, 0)

				local var_126_22 = manager.ui.mainCamera.transform.position - var_126_15.position

				var_126_15.forward = Vector3.New(var_126_22.x, var_126_22.y, var_126_22.z)

				local var_126_23 = var_126_15.localEulerAngles

				var_126_23.z = 0
				var_126_23.x = 0
				var_126_15.localEulerAngles = var_126_23
			end

			local var_126_24 = arg_123_1.actors_["1197ui_story"]
			local var_126_25 = 0

			if var_126_25 < arg_123_1.time_ and arg_123_1.time_ <= var_126_25 + arg_126_0 and not isNil(var_126_24) and arg_123_1.var_.characterEffect1197ui_story == nil then
				arg_123_1.var_.characterEffect1197ui_story = var_126_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_26 = 0.200000002980232

			if var_126_25 <= arg_123_1.time_ and arg_123_1.time_ < var_126_25 + var_126_26 and not isNil(var_126_24) then
				local var_126_27 = (arg_123_1.time_ - var_126_25) / var_126_26

				if arg_123_1.var_.characterEffect1197ui_story and not isNil(var_126_24) then
					local var_126_28 = Mathf.Lerp(0, 0.5, var_126_27)

					arg_123_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1197ui_story.fillRatio = var_126_28
				end
			end

			if arg_123_1.time_ >= var_126_25 + var_126_26 and arg_123_1.time_ < var_126_25 + var_126_26 + arg_126_0 and not isNil(var_126_24) and arg_123_1.var_.characterEffect1197ui_story then
				local var_126_29 = 0.5

				arg_123_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1197ui_story.fillRatio = var_126_29
			end

			local var_126_30 = 0
			local var_126_31 = 0.475

			if var_126_30 < arg_123_1.time_ and arg_123_1.time_ <= var_126_30 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_32 = arg_123_1:FormatText(StoryNameCfg[919].name)

				arg_123_1.leftNameTxt_.text = var_126_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_33 = arg_123_1:GetWordFromCfg(412131029)
				local var_126_34 = arg_123_1:FormatText(var_126_33.content)

				arg_123_1.text_.text = var_126_34

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_35 = 19
				local var_126_36 = utf8.len(var_126_34)
				local var_126_37 = var_126_35 <= 0 and var_126_31 or var_126_31 * (var_126_36 / var_126_35)

				if var_126_37 > 0 and var_126_31 < var_126_37 then
					arg_123_1.talkMaxDuration = var_126_37

					if var_126_37 + var_126_30 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_37 + var_126_30
					end
				end

				arg_123_1.text_.text = var_126_34
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131029", "story_v_out_412131.awb") ~= 0 then
					local var_126_38 = manager.audio:GetVoiceLength("story_v_out_412131", "412131029", "story_v_out_412131.awb") / 1000

					if var_126_38 + var_126_30 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_38 + var_126_30
					end

					if var_126_33.prefab_name ~= "" and arg_123_1.actors_[var_126_33.prefab_name] ~= nil then
						local var_126_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_33.prefab_name].transform, "story_v_out_412131", "412131029", "story_v_out_412131.awb")

						arg_123_1:RecordAudio("412131029", var_126_39)
						arg_123_1:RecordAudio("412131029", var_126_39)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_412131", "412131029", "story_v_out_412131.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_412131", "412131029", "story_v_out_412131.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_40 = math.max(var_126_31, arg_123_1.talkMaxDuration)

			if var_126_30 <= arg_123_1.time_ and arg_123_1.time_ < var_126_30 + var_126_40 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_30) / var_126_40

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_30 + var_126_40 and arg_123_1.time_ < var_126_30 + var_126_40 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
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
	Play412131030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 412131030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play412131031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10078ui_story"].transform
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos10078ui_story = var_130_0.localPosition
			end

			local var_130_2 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2
				local var_130_4 = Vector3.New(0, 100, 0)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10078ui_story, var_130_4, var_130_3)

				local var_130_5 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_5.x, var_130_5.y, var_130_5.z)

				local var_130_6 = var_130_0.localEulerAngles

				var_130_6.z = 0
				var_130_6.x = 0
				var_130_0.localEulerAngles = var_130_6
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(0, 100, 0)

				local var_130_7 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_7.x, var_130_7.y, var_130_7.z)

				local var_130_8 = var_130_0.localEulerAngles

				var_130_8.z = 0
				var_130_8.x = 0
				var_130_0.localEulerAngles = var_130_8
			end

			local var_130_9 = arg_127_1.actors_["10078ui_story"]
			local var_130_10 = 0

			if var_130_10 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 and not isNil(var_130_9) and arg_127_1.var_.characterEffect10078ui_story == nil then
				arg_127_1.var_.characterEffect10078ui_story = var_130_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_11 = 0.200000002980232

			if var_130_10 <= arg_127_1.time_ and arg_127_1.time_ < var_130_10 + var_130_11 and not isNil(var_130_9) then
				local var_130_12 = (arg_127_1.time_ - var_130_10) / var_130_11

				if arg_127_1.var_.characterEffect10078ui_story and not isNil(var_130_9) then
					local var_130_13 = Mathf.Lerp(0, 0.5, var_130_12)

					arg_127_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_127_1.var_.characterEffect10078ui_story.fillRatio = var_130_13
				end
			end

			if arg_127_1.time_ >= var_130_10 + var_130_11 and arg_127_1.time_ < var_130_10 + var_130_11 + arg_130_0 and not isNil(var_130_9) and arg_127_1.var_.characterEffect10078ui_story then
				local var_130_14 = 0.5

				arg_127_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_127_1.var_.characterEffect10078ui_story.fillRatio = var_130_14
			end

			local var_130_15 = 0
			local var_130_16 = 0.65

			if var_130_15 < arg_127_1.time_ and arg_127_1.time_ <= var_130_15 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_17 = arg_127_1:GetWordFromCfg(412131030)
				local var_130_18 = arg_127_1:FormatText(var_130_17.content)

				arg_127_1.text_.text = var_130_18

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_19 = 26
				local var_130_20 = utf8.len(var_130_18)
				local var_130_21 = var_130_19 <= 0 and var_130_16 or var_130_16 * (var_130_20 / var_130_19)

				if var_130_21 > 0 and var_130_16 < var_130_21 then
					arg_127_1.talkMaxDuration = var_130_21

					if var_130_21 + var_130_15 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_21 + var_130_15
					end
				end

				arg_127_1.text_.text = var_130_18
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_22 = math.max(var_130_16, arg_127_1.talkMaxDuration)

			if var_130_15 <= arg_127_1.time_ and arg_127_1.time_ < var_130_15 + var_130_22 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_15) / var_130_22

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_15 + var_130_22 and arg_127_1.time_ < var_130_15 + var_130_22 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412131031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 412131031
		arg_131_1.duration_ = 4.8

		local var_131_0 = {
			zh = 1.999999999999,
			ja = 4.8
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
				arg_131_0:Play412131032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10078ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos10078ui_story = var_134_0.localPosition
			end

			local var_134_2 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2
				local var_134_4 = Vector3.New(0, -0.5, -6.3)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10078ui_story, var_134_4, var_134_3)

				local var_134_5 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_5.x, var_134_5.y, var_134_5.z)

				local var_134_6 = var_134_0.localEulerAngles

				var_134_6.z = 0
				var_134_6.x = 0
				var_134_0.localEulerAngles = var_134_6
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_134_7 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_7.x, var_134_7.y, var_134_7.z)

				local var_134_8 = var_134_0.localEulerAngles

				var_134_8.z = 0
				var_134_8.x = 0
				var_134_0.localEulerAngles = var_134_8
			end

			local var_134_9 = arg_131_1.actors_["10078ui_story"]
			local var_134_10 = 0

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect10078ui_story == nil then
				arg_131_1.var_.characterEffect10078ui_story = var_134_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_11 = 0.200000002980232

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_11 and not isNil(var_134_9) then
				local var_134_12 = (arg_131_1.time_ - var_134_10) / var_134_11

				if arg_131_1.var_.characterEffect10078ui_story and not isNil(var_134_9) then
					arg_131_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_10 + var_134_11 and arg_131_1.time_ < var_134_10 + var_134_11 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect10078ui_story then
				arg_131_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_134_13 = 0

			if var_134_13 < arg_131_1.time_ and arg_131_1.time_ <= var_134_13 + arg_134_0 then
				arg_131_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_134_14 = 0

			if var_134_14 < arg_131_1.time_ and arg_131_1.time_ <= var_134_14 + arg_134_0 then
				arg_131_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action3_2")
			end

			local var_134_15 = 0
			local var_134_16 = 0.125

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_17 = arg_131_1:FormatText(StoryNameCfg[919].name)

				arg_131_1.leftNameTxt_.text = var_134_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_18 = arg_131_1:GetWordFromCfg(412131031)
				local var_134_19 = arg_131_1:FormatText(var_134_18.content)

				arg_131_1.text_.text = var_134_19

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_20 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131031", "story_v_out_412131.awb") ~= 0 then
					local var_134_23 = manager.audio:GetVoiceLength("story_v_out_412131", "412131031", "story_v_out_412131.awb") / 1000

					if var_134_23 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_23 + var_134_15
					end

					if var_134_18.prefab_name ~= "" and arg_131_1.actors_[var_134_18.prefab_name] ~= nil then
						local var_134_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_18.prefab_name].transform, "story_v_out_412131", "412131031", "story_v_out_412131.awb")

						arg_131_1:RecordAudio("412131031", var_134_24)
						arg_131_1:RecordAudio("412131031", var_134_24)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_412131", "412131031", "story_v_out_412131.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_412131", "412131031", "story_v_out_412131.awb")
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
				actorName = "10078ui_story",
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
	Play412131032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 412131032
		arg_135_1.duration_ = 6.23

		local var_135_0 = {
			zh = 5.433,
			ja = 6.233
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
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play412131033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = "10083ui_story"

			if arg_135_1.actors_[var_138_0] == nil then
				local var_138_1 = Asset.Load("Char/" .. "10083ui_story")

				if not isNil(var_138_1) then
					local var_138_2 = Object.Instantiate(Asset.Load("Char/" .. "10083ui_story"), arg_135_1.stage_.transform)

					var_138_2.name = var_138_0
					var_138_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_135_1.actors_[var_138_0] = var_138_2

					local var_138_3 = var_138_2:GetComponentInChildren(typeof(CharacterEffect))

					var_138_3.enabled = true

					local var_138_4 = GameObjectTools.GetOrAddComponent(var_138_2, typeof(DynamicBoneHelper))

					if var_138_4 then
						var_138_4:EnableDynamicBone(false)
					end

					arg_135_1:ShowWeapon(var_138_3.transform, false)

					arg_135_1.var_[var_138_0 .. "Animator"] = var_138_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_135_1.var_[var_138_0 .. "Animator"].applyRootMotion = true
					arg_135_1.var_[var_138_0 .. "LipSync"] = var_138_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_138_5 = arg_135_1.actors_["10083ui_story"].transform
			local var_138_6 = 0

			if var_138_6 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1.var_.moveOldPos10083ui_story = var_138_5.localPosition
			end

			local var_138_7 = 0.001

			if var_138_6 <= arg_135_1.time_ and arg_135_1.time_ < var_138_6 + var_138_7 then
				local var_138_8 = (arg_135_1.time_ - var_138_6) / var_138_7
				local var_138_9 = Vector3.New(0, -2.6, -2.8)

				var_138_5.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10083ui_story, var_138_9, var_138_8)

				local var_138_10 = manager.ui.mainCamera.transform.position - var_138_5.position

				var_138_5.forward = Vector3.New(var_138_10.x, var_138_10.y, var_138_10.z)

				local var_138_11 = var_138_5.localEulerAngles

				var_138_11.z = 0
				var_138_11.x = 0
				var_138_5.localEulerAngles = var_138_11
			end

			if arg_135_1.time_ >= var_138_6 + var_138_7 and arg_135_1.time_ < var_138_6 + var_138_7 + arg_138_0 then
				var_138_5.localPosition = Vector3.New(0, -2.6, -2.8)

				local var_138_12 = manager.ui.mainCamera.transform.position - var_138_5.position

				var_138_5.forward = Vector3.New(var_138_12.x, var_138_12.y, var_138_12.z)

				local var_138_13 = var_138_5.localEulerAngles

				var_138_13.z = 0
				var_138_13.x = 0
				var_138_5.localEulerAngles = var_138_13
			end

			local var_138_14 = arg_135_1.actors_["10083ui_story"]
			local var_138_15 = 0

			if var_138_15 < arg_135_1.time_ and arg_135_1.time_ <= var_138_15 + arg_138_0 and not isNil(var_138_14) and arg_135_1.var_.characterEffect10083ui_story == nil then
				arg_135_1.var_.characterEffect10083ui_story = var_138_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_16 = 0.200000002980232

			if var_138_15 <= arg_135_1.time_ and arg_135_1.time_ < var_138_15 + var_138_16 and not isNil(var_138_14) then
				local var_138_17 = (arg_135_1.time_ - var_138_15) / var_138_16

				if arg_135_1.var_.characterEffect10083ui_story and not isNil(var_138_14) then
					arg_135_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_15 + var_138_16 and arg_135_1.time_ < var_138_15 + var_138_16 + arg_138_0 and not isNil(var_138_14) and arg_135_1.var_.characterEffect10083ui_story then
				arg_135_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_138_18 = 0

			if var_138_18 < arg_135_1.time_ and arg_135_1.time_ <= var_138_18 + arg_138_0 then
				arg_135_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action1_1")
			end

			local var_138_19 = 0

			if var_138_19 < arg_135_1.time_ and arg_135_1.time_ <= var_138_19 + arg_138_0 then
				arg_135_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_138_20 = arg_135_1.actors_["10078ui_story"].transform
			local var_138_21 = 0

			if var_138_21 < arg_135_1.time_ and arg_135_1.time_ <= var_138_21 + arg_138_0 then
				arg_135_1.var_.moveOldPos10078ui_story = var_138_20.localPosition
			end

			local var_138_22 = 0.001

			if var_138_21 <= arg_135_1.time_ and arg_135_1.time_ < var_138_21 + var_138_22 then
				local var_138_23 = (arg_135_1.time_ - var_138_21) / var_138_22
				local var_138_24 = Vector3.New(0, 100, 0)

				var_138_20.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10078ui_story, var_138_24, var_138_23)

				local var_138_25 = manager.ui.mainCamera.transform.position - var_138_20.position

				var_138_20.forward = Vector3.New(var_138_25.x, var_138_25.y, var_138_25.z)

				local var_138_26 = var_138_20.localEulerAngles

				var_138_26.z = 0
				var_138_26.x = 0
				var_138_20.localEulerAngles = var_138_26
			end

			if arg_135_1.time_ >= var_138_21 + var_138_22 and arg_135_1.time_ < var_138_21 + var_138_22 + arg_138_0 then
				var_138_20.localPosition = Vector3.New(0, 100, 0)

				local var_138_27 = manager.ui.mainCamera.transform.position - var_138_20.position

				var_138_20.forward = Vector3.New(var_138_27.x, var_138_27.y, var_138_27.z)

				local var_138_28 = var_138_20.localEulerAngles

				var_138_28.z = 0
				var_138_28.x = 0
				var_138_20.localEulerAngles = var_138_28
			end

			local var_138_29 = arg_135_1.actors_["10078ui_story"]
			local var_138_30 = 0

			if var_138_30 < arg_135_1.time_ and arg_135_1.time_ <= var_138_30 + arg_138_0 and not isNil(var_138_29) and arg_135_1.var_.characterEffect10078ui_story == nil then
				arg_135_1.var_.characterEffect10078ui_story = var_138_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_31 = 0.200000002980232

			if var_138_30 <= arg_135_1.time_ and arg_135_1.time_ < var_138_30 + var_138_31 and not isNil(var_138_29) then
				local var_138_32 = (arg_135_1.time_ - var_138_30) / var_138_31

				if arg_135_1.var_.characterEffect10078ui_story and not isNil(var_138_29) then
					local var_138_33 = Mathf.Lerp(0, 0.5, var_138_32)

					arg_135_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_135_1.var_.characterEffect10078ui_story.fillRatio = var_138_33
				end
			end

			if arg_135_1.time_ >= var_138_30 + var_138_31 and arg_135_1.time_ < var_138_30 + var_138_31 + arg_138_0 and not isNil(var_138_29) and arg_135_1.var_.characterEffect10078ui_story then
				local var_138_34 = 0.5

				arg_135_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_135_1.var_.characterEffect10078ui_story.fillRatio = var_138_34
			end

			local var_138_35 = 0
			local var_138_36 = 0.6

			if var_138_35 < arg_135_1.time_ and arg_135_1.time_ <= var_138_35 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_37 = arg_135_1:FormatText(StoryNameCfg[918].name)

				arg_135_1.leftNameTxt_.text = var_138_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_38 = arg_135_1:GetWordFromCfg(412131032)
				local var_138_39 = arg_135_1:FormatText(var_138_38.content)

				arg_135_1.text_.text = var_138_39

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_40 = 24
				local var_138_41 = utf8.len(var_138_39)
				local var_138_42 = var_138_40 <= 0 and var_138_36 or var_138_36 * (var_138_41 / var_138_40)

				if var_138_42 > 0 and var_138_36 < var_138_42 then
					arg_135_1.talkMaxDuration = var_138_42

					if var_138_42 + var_138_35 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_42 + var_138_35
					end
				end

				arg_135_1.text_.text = var_138_39
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131032", "story_v_out_412131.awb") ~= 0 then
					local var_138_43 = manager.audio:GetVoiceLength("story_v_out_412131", "412131032", "story_v_out_412131.awb") / 1000

					if var_138_43 + var_138_35 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_43 + var_138_35
					end

					if var_138_38.prefab_name ~= "" and arg_135_1.actors_[var_138_38.prefab_name] ~= nil then
						local var_138_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_38.prefab_name].transform, "story_v_out_412131", "412131032", "story_v_out_412131.awb")

						arg_135_1:RecordAudio("412131032", var_138_44)
						arg_135_1:RecordAudio("412131032", var_138_44)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_412131", "412131032", "story_v_out_412131.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_412131", "412131032", "story_v_out_412131.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_45 = math.max(var_138_36, arg_135_1.talkMaxDuration)

			if var_138_35 <= arg_135_1.time_ and arg_135_1.time_ < var_138_35 + var_138_45 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_35) / var_138_45

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_35 + var_138_45 and arg_135_1.time_ < var_138_35 + var_138_45 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412131033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 412131033
		arg_139_1.duration_ = 14.47

		local var_139_0 = {
			zh = 10.233,
			ja = 14.466
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play412131034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10078ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos10078ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(0, -0.5, -6.3)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10078ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = arg_139_1.actors_["10078ui_story"]
			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect10078ui_story == nil then
				arg_139_1.var_.characterEffect10078ui_story = var_142_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_11 = 0.200000002980232

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_11 and not isNil(var_142_9) then
				local var_142_12 = (arg_139_1.time_ - var_142_10) / var_142_11

				if arg_139_1.var_.characterEffect10078ui_story and not isNil(var_142_9) then
					arg_139_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_10 + var_142_11 and arg_139_1.time_ < var_142_10 + var_142_11 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect10078ui_story then
				arg_139_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_142_13 = 0

			if var_142_13 < arg_139_1.time_ and arg_139_1.time_ <= var_142_13 + arg_142_0 then
				arg_139_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_14 = arg_139_1.actors_["10083ui_story"].transform
			local var_142_15 = 0

			if var_142_15 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 then
				arg_139_1.var_.moveOldPos10083ui_story = var_142_14.localPosition
			end

			local var_142_16 = 0.001

			if var_142_15 <= arg_139_1.time_ and arg_139_1.time_ < var_142_15 + var_142_16 then
				local var_142_17 = (arg_139_1.time_ - var_142_15) / var_142_16
				local var_142_18 = Vector3.New(0, 100, 0)

				var_142_14.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10083ui_story, var_142_18, var_142_17)

				local var_142_19 = manager.ui.mainCamera.transform.position - var_142_14.position

				var_142_14.forward = Vector3.New(var_142_19.x, var_142_19.y, var_142_19.z)

				local var_142_20 = var_142_14.localEulerAngles

				var_142_20.z = 0
				var_142_20.x = 0
				var_142_14.localEulerAngles = var_142_20
			end

			if arg_139_1.time_ >= var_142_15 + var_142_16 and arg_139_1.time_ < var_142_15 + var_142_16 + arg_142_0 then
				var_142_14.localPosition = Vector3.New(0, 100, 0)

				local var_142_21 = manager.ui.mainCamera.transform.position - var_142_14.position

				var_142_14.forward = Vector3.New(var_142_21.x, var_142_21.y, var_142_21.z)

				local var_142_22 = var_142_14.localEulerAngles

				var_142_22.z = 0
				var_142_22.x = 0
				var_142_14.localEulerAngles = var_142_22
			end

			local var_142_23 = arg_139_1.actors_["10083ui_story"]
			local var_142_24 = 0

			if var_142_24 < arg_139_1.time_ and arg_139_1.time_ <= var_142_24 + arg_142_0 and not isNil(var_142_23) and arg_139_1.var_.characterEffect10083ui_story == nil then
				arg_139_1.var_.characterEffect10083ui_story = var_142_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_25 = 0.200000002980232

			if var_142_24 <= arg_139_1.time_ and arg_139_1.time_ < var_142_24 + var_142_25 and not isNil(var_142_23) then
				local var_142_26 = (arg_139_1.time_ - var_142_24) / var_142_25

				if arg_139_1.var_.characterEffect10083ui_story and not isNil(var_142_23) then
					local var_142_27 = Mathf.Lerp(0, 0.5, var_142_26)

					arg_139_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_139_1.var_.characterEffect10083ui_story.fillRatio = var_142_27
				end
			end

			if arg_139_1.time_ >= var_142_24 + var_142_25 and arg_139_1.time_ < var_142_24 + var_142_25 + arg_142_0 and not isNil(var_142_23) and arg_139_1.var_.characterEffect10083ui_story then
				local var_142_28 = 0.5

				arg_139_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_139_1.var_.characterEffect10083ui_story.fillRatio = var_142_28
			end

			local var_142_29 = 0

			if var_142_29 < arg_139_1.time_ and arg_139_1.time_ <= var_142_29 + arg_142_0 then
				arg_139_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_142_30 = 0
			local var_142_31 = 0.95

			if var_142_30 < arg_139_1.time_ and arg_139_1.time_ <= var_142_30 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_32 = arg_139_1:FormatText(StoryNameCfg[919].name)

				arg_139_1.leftNameTxt_.text = var_142_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_33 = arg_139_1:GetWordFromCfg(412131033)
				local var_142_34 = arg_139_1:FormatText(var_142_33.content)

				arg_139_1.text_.text = var_142_34

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_35 = 38
				local var_142_36 = utf8.len(var_142_34)
				local var_142_37 = var_142_35 <= 0 and var_142_31 or var_142_31 * (var_142_36 / var_142_35)

				if var_142_37 > 0 and var_142_31 < var_142_37 then
					arg_139_1.talkMaxDuration = var_142_37

					if var_142_37 + var_142_30 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_37 + var_142_30
					end
				end

				arg_139_1.text_.text = var_142_34
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131033", "story_v_out_412131.awb") ~= 0 then
					local var_142_38 = manager.audio:GetVoiceLength("story_v_out_412131", "412131033", "story_v_out_412131.awb") / 1000

					if var_142_38 + var_142_30 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_38 + var_142_30
					end

					if var_142_33.prefab_name ~= "" and arg_139_1.actors_[var_142_33.prefab_name] ~= nil then
						local var_142_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_33.prefab_name].transform, "story_v_out_412131", "412131033", "story_v_out_412131.awb")

						arg_139_1:RecordAudio("412131033", var_142_39)
						arg_139_1:RecordAudio("412131033", var_142_39)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_412131", "412131033", "story_v_out_412131.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_412131", "412131033", "story_v_out_412131.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_40 = math.max(var_142_31, arg_139_1.talkMaxDuration)

			if var_142_30 <= arg_139_1.time_ and arg_139_1.time_ < var_142_30 + var_142_40 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_30) / var_142_40

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_30 + var_142_40 and arg_139_1.time_ < var_142_30 + var_142_40 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
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
	Play412131034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 412131034
		arg_143_1.duration_ = 4.4

		local var_143_0 = {
			zh = 4.4,
			ja = 2
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play412131035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1197ui_story"].transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos1197ui_story = var_146_0.localPosition
			end

			local var_146_2 = 0.001

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2
				local var_146_4 = Vector3.New(0, -0.545, -6.3)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1197ui_story, var_146_4, var_146_3)

				local var_146_5 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_5.x, var_146_5.y, var_146_5.z)

				local var_146_6 = var_146_0.localEulerAngles

				var_146_6.z = 0
				var_146_6.x = 0
				var_146_0.localEulerAngles = var_146_6
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(0, -0.545, -6.3)

				local var_146_7 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_7.x, var_146_7.y, var_146_7.z)

				local var_146_8 = var_146_0.localEulerAngles

				var_146_8.z = 0
				var_146_8.x = 0
				var_146_0.localEulerAngles = var_146_8
			end

			local var_146_9 = arg_143_1.actors_["1197ui_story"]
			local var_146_10 = 0

			if var_146_10 < arg_143_1.time_ and arg_143_1.time_ <= var_146_10 + arg_146_0 and not isNil(var_146_9) and arg_143_1.var_.characterEffect1197ui_story == nil then
				arg_143_1.var_.characterEffect1197ui_story = var_146_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_11 = 0.200000002980232

			if var_146_10 <= arg_143_1.time_ and arg_143_1.time_ < var_146_10 + var_146_11 and not isNil(var_146_9) then
				local var_146_12 = (arg_143_1.time_ - var_146_10) / var_146_11

				if arg_143_1.var_.characterEffect1197ui_story and not isNil(var_146_9) then
					arg_143_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_10 + var_146_11 and arg_143_1.time_ < var_146_10 + var_146_11 + arg_146_0 and not isNil(var_146_9) and arg_143_1.var_.characterEffect1197ui_story then
				arg_143_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			local var_146_13 = 0

			if var_146_13 < arg_143_1.time_ and arg_143_1.time_ <= var_146_13 + arg_146_0 then
				arg_143_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_146_14 = arg_143_1.actors_["10078ui_story"].transform
			local var_146_15 = 0

			if var_146_15 < arg_143_1.time_ and arg_143_1.time_ <= var_146_15 + arg_146_0 then
				arg_143_1.var_.moveOldPos10078ui_story = var_146_14.localPosition
			end

			local var_146_16 = 0.001

			if var_146_15 <= arg_143_1.time_ and arg_143_1.time_ < var_146_15 + var_146_16 then
				local var_146_17 = (arg_143_1.time_ - var_146_15) / var_146_16
				local var_146_18 = Vector3.New(0, 100, 0)

				var_146_14.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10078ui_story, var_146_18, var_146_17)

				local var_146_19 = manager.ui.mainCamera.transform.position - var_146_14.position

				var_146_14.forward = Vector3.New(var_146_19.x, var_146_19.y, var_146_19.z)

				local var_146_20 = var_146_14.localEulerAngles

				var_146_20.z = 0
				var_146_20.x = 0
				var_146_14.localEulerAngles = var_146_20
			end

			if arg_143_1.time_ >= var_146_15 + var_146_16 and arg_143_1.time_ < var_146_15 + var_146_16 + arg_146_0 then
				var_146_14.localPosition = Vector3.New(0, 100, 0)

				local var_146_21 = manager.ui.mainCamera.transform.position - var_146_14.position

				var_146_14.forward = Vector3.New(var_146_21.x, var_146_21.y, var_146_21.z)

				local var_146_22 = var_146_14.localEulerAngles

				var_146_22.z = 0
				var_146_22.x = 0
				var_146_14.localEulerAngles = var_146_22
			end

			local var_146_23 = arg_143_1.actors_["10078ui_story"]
			local var_146_24 = 0

			if var_146_24 < arg_143_1.time_ and arg_143_1.time_ <= var_146_24 + arg_146_0 and not isNil(var_146_23) and arg_143_1.var_.characterEffect10078ui_story == nil then
				arg_143_1.var_.characterEffect10078ui_story = var_146_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_25 = 0.200000002980232

			if var_146_24 <= arg_143_1.time_ and arg_143_1.time_ < var_146_24 + var_146_25 and not isNil(var_146_23) then
				local var_146_26 = (arg_143_1.time_ - var_146_24) / var_146_25

				if arg_143_1.var_.characterEffect10078ui_story and not isNil(var_146_23) then
					local var_146_27 = Mathf.Lerp(0, 0.5, var_146_26)

					arg_143_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10078ui_story.fillRatio = var_146_27
				end
			end

			if arg_143_1.time_ >= var_146_24 + var_146_25 and arg_143_1.time_ < var_146_24 + var_146_25 + arg_146_0 and not isNil(var_146_23) and arg_143_1.var_.characterEffect10078ui_story then
				local var_146_28 = 0.5

				arg_143_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10078ui_story.fillRatio = var_146_28
			end

			local var_146_29 = 0
			local var_146_30 = 0.3

			if var_146_29 < arg_143_1.time_ and arg_143_1.time_ <= var_146_29 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_31 = arg_143_1:FormatText(StoryNameCfg[216].name)

				arg_143_1.leftNameTxt_.text = var_146_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_32 = arg_143_1:GetWordFromCfg(412131034)
				local var_146_33 = arg_143_1:FormatText(var_146_32.content)

				arg_143_1.text_.text = var_146_33

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_34 = 12
				local var_146_35 = utf8.len(var_146_33)
				local var_146_36 = var_146_34 <= 0 and var_146_30 or var_146_30 * (var_146_35 / var_146_34)

				if var_146_36 > 0 and var_146_30 < var_146_36 then
					arg_143_1.talkMaxDuration = var_146_36

					if var_146_36 + var_146_29 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_36 + var_146_29
					end
				end

				arg_143_1.text_.text = var_146_33
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131034", "story_v_out_412131.awb") ~= 0 then
					local var_146_37 = manager.audio:GetVoiceLength("story_v_out_412131", "412131034", "story_v_out_412131.awb") / 1000

					if var_146_37 + var_146_29 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_37 + var_146_29
					end

					if var_146_32.prefab_name ~= "" and arg_143_1.actors_[var_146_32.prefab_name] ~= nil then
						local var_146_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_32.prefab_name].transform, "story_v_out_412131", "412131034", "story_v_out_412131.awb")

						arg_143_1:RecordAudio("412131034", var_146_38)
						arg_143_1:RecordAudio("412131034", var_146_38)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_412131", "412131034", "story_v_out_412131.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_412131", "412131034", "story_v_out_412131.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_39 = math.max(var_146_30, arg_143_1.talkMaxDuration)

			if var_146_29 <= arg_143_1.time_ and arg_143_1.time_ < var_146_29 + var_146_39 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_29) / var_146_39

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_29 + var_146_39 and arg_143_1.time_ < var_146_29 + var_146_39 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412131035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 412131035
		arg_147_1.duration_ = 11.3

		local var_147_0 = {
			zh = 9.466,
			ja = 11.3
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play412131036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10078ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos10078ui_story = var_150_0.localPosition
			end

			local var_150_2 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2
				local var_150_4 = Vector3.New(0, -0.5, -6.3)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10078ui_story, var_150_4, var_150_3)

				local var_150_5 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_5.x, var_150_5.y, var_150_5.z)

				local var_150_6 = var_150_0.localEulerAngles

				var_150_6.z = 0
				var_150_6.x = 0
				var_150_0.localEulerAngles = var_150_6
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_150_7 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_7.x, var_150_7.y, var_150_7.z)

				local var_150_8 = var_150_0.localEulerAngles

				var_150_8.z = 0
				var_150_8.x = 0
				var_150_0.localEulerAngles = var_150_8
			end

			local var_150_9 = arg_147_1.actors_["10078ui_story"]
			local var_150_10 = 0

			if var_150_10 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect10078ui_story == nil then
				arg_147_1.var_.characterEffect10078ui_story = var_150_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_11 = 0.200000002980232

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_11 and not isNil(var_150_9) then
				local var_150_12 = (arg_147_1.time_ - var_150_10) / var_150_11

				if arg_147_1.var_.characterEffect10078ui_story and not isNil(var_150_9) then
					arg_147_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_10 + var_150_11 and arg_147_1.time_ < var_150_10 + var_150_11 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect10078ui_story then
				arg_147_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_150_13 = 0

			if var_150_13 < arg_147_1.time_ and arg_147_1.time_ <= var_150_13 + arg_150_0 then
				arg_147_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046actionlink/6046action442")
			end

			local var_150_14 = 0

			if var_150_14 < arg_147_1.time_ and arg_147_1.time_ <= var_150_14 + arg_150_0 then
				arg_147_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_150_15 = arg_147_1.actors_["1197ui_story"]
			local var_150_16 = 0

			if var_150_16 < arg_147_1.time_ and arg_147_1.time_ <= var_150_16 + arg_150_0 and not isNil(var_150_15) and arg_147_1.var_.characterEffect1197ui_story == nil then
				arg_147_1.var_.characterEffect1197ui_story = var_150_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_17 = 0.200000002980232

			if var_150_16 <= arg_147_1.time_ and arg_147_1.time_ < var_150_16 + var_150_17 and not isNil(var_150_15) then
				local var_150_18 = (arg_147_1.time_ - var_150_16) / var_150_17

				if arg_147_1.var_.characterEffect1197ui_story and not isNil(var_150_15) then
					local var_150_19 = Mathf.Lerp(0, 0.5, var_150_18)

					arg_147_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1197ui_story.fillRatio = var_150_19
				end
			end

			if arg_147_1.time_ >= var_150_16 + var_150_17 and arg_147_1.time_ < var_150_16 + var_150_17 + arg_150_0 and not isNil(var_150_15) and arg_147_1.var_.characterEffect1197ui_story then
				local var_150_20 = 0.5

				arg_147_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1197ui_story.fillRatio = var_150_20
			end

			local var_150_21 = arg_147_1.actors_["1197ui_story"].transform
			local var_150_22 = 0

			if var_150_22 < arg_147_1.time_ and arg_147_1.time_ <= var_150_22 + arg_150_0 then
				arg_147_1.var_.moveOldPos1197ui_story = var_150_21.localPosition
			end

			local var_150_23 = 0.001

			if var_150_22 <= arg_147_1.time_ and arg_147_1.time_ < var_150_22 + var_150_23 then
				local var_150_24 = (arg_147_1.time_ - var_150_22) / var_150_23
				local var_150_25 = Vector3.New(0, 100, 0)

				var_150_21.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1197ui_story, var_150_25, var_150_24)

				local var_150_26 = manager.ui.mainCamera.transform.position - var_150_21.position

				var_150_21.forward = Vector3.New(var_150_26.x, var_150_26.y, var_150_26.z)

				local var_150_27 = var_150_21.localEulerAngles

				var_150_27.z = 0
				var_150_27.x = 0
				var_150_21.localEulerAngles = var_150_27
			end

			if arg_147_1.time_ >= var_150_22 + var_150_23 and arg_147_1.time_ < var_150_22 + var_150_23 + arg_150_0 then
				var_150_21.localPosition = Vector3.New(0, 100, 0)

				local var_150_28 = manager.ui.mainCamera.transform.position - var_150_21.position

				var_150_21.forward = Vector3.New(var_150_28.x, var_150_28.y, var_150_28.z)

				local var_150_29 = var_150_21.localEulerAngles

				var_150_29.z = 0
				var_150_29.x = 0
				var_150_21.localEulerAngles = var_150_29
			end

			local var_150_30 = 0
			local var_150_31 = 0.7

			if var_150_30 < arg_147_1.time_ and arg_147_1.time_ <= var_150_30 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_32 = arg_147_1:FormatText(StoryNameCfg[919].name)

				arg_147_1.leftNameTxt_.text = var_150_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_33 = arg_147_1:GetWordFromCfg(412131035)
				local var_150_34 = arg_147_1:FormatText(var_150_33.content)

				arg_147_1.text_.text = var_150_34

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_35 = 28
				local var_150_36 = utf8.len(var_150_34)
				local var_150_37 = var_150_35 <= 0 and var_150_31 or var_150_31 * (var_150_36 / var_150_35)

				if var_150_37 > 0 and var_150_31 < var_150_37 then
					arg_147_1.talkMaxDuration = var_150_37

					if var_150_37 + var_150_30 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_37 + var_150_30
					end
				end

				arg_147_1.text_.text = var_150_34
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131035", "story_v_out_412131.awb") ~= 0 then
					local var_150_38 = manager.audio:GetVoiceLength("story_v_out_412131", "412131035", "story_v_out_412131.awb") / 1000

					if var_150_38 + var_150_30 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_38 + var_150_30
					end

					if var_150_33.prefab_name ~= "" and arg_147_1.actors_[var_150_33.prefab_name] ~= nil then
						local var_150_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_33.prefab_name].transform, "story_v_out_412131", "412131035", "story_v_out_412131.awb")

						arg_147_1:RecordAudio("412131035", var_150_39)
						arg_147_1:RecordAudio("412131035", var_150_39)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_412131", "412131035", "story_v_out_412131.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_412131", "412131035", "story_v_out_412131.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_40 = math.max(var_150_31, arg_147_1.talkMaxDuration)

			if var_150_30 <= arg_147_1.time_ and arg_147_1.time_ < var_150_30 + var_150_40 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_30) / var_150_40

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_30 + var_150_40 and arg_147_1.time_ < var_150_30 + var_150_40 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play412131036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 412131036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play412131037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10078ui_story"].transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.moveOldPos10078ui_story = var_154_0.localPosition
			end

			local var_154_2 = 0.001

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2
				local var_154_4 = Vector3.New(0, 100, 0)

				var_154_0.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10078ui_story, var_154_4, var_154_3)

				local var_154_5 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_5.x, var_154_5.y, var_154_5.z)

				local var_154_6 = var_154_0.localEulerAngles

				var_154_6.z = 0
				var_154_6.x = 0
				var_154_0.localEulerAngles = var_154_6
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 then
				var_154_0.localPosition = Vector3.New(0, 100, 0)

				local var_154_7 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_7.x, var_154_7.y, var_154_7.z)

				local var_154_8 = var_154_0.localEulerAngles

				var_154_8.z = 0
				var_154_8.x = 0
				var_154_0.localEulerAngles = var_154_8
			end

			local var_154_9 = arg_151_1.actors_["10078ui_story"]
			local var_154_10 = 0

			if var_154_10 < arg_151_1.time_ and arg_151_1.time_ <= var_154_10 + arg_154_0 and not isNil(var_154_9) and arg_151_1.var_.characterEffect10078ui_story == nil then
				arg_151_1.var_.characterEffect10078ui_story = var_154_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_11 = 0.200000002980232

			if var_154_10 <= arg_151_1.time_ and arg_151_1.time_ < var_154_10 + var_154_11 and not isNil(var_154_9) then
				local var_154_12 = (arg_151_1.time_ - var_154_10) / var_154_11

				if arg_151_1.var_.characterEffect10078ui_story and not isNil(var_154_9) then
					local var_154_13 = Mathf.Lerp(0, 0.5, var_154_12)

					arg_151_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10078ui_story.fillRatio = var_154_13
				end
			end

			if arg_151_1.time_ >= var_154_10 + var_154_11 and arg_151_1.time_ < var_154_10 + var_154_11 + arg_154_0 and not isNil(var_154_9) and arg_151_1.var_.characterEffect10078ui_story then
				local var_154_14 = 0.5

				arg_151_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10078ui_story.fillRatio = var_154_14
			end

			local var_154_15 = 0
			local var_154_16 = 0.7

			if var_154_15 < arg_151_1.time_ and arg_151_1.time_ <= var_154_15 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_17 = arg_151_1:GetWordFromCfg(412131036)
				local var_154_18 = arg_151_1:FormatText(var_154_17.content)

				arg_151_1.text_.text = var_154_18

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_19 = 28
				local var_154_20 = utf8.len(var_154_18)
				local var_154_21 = var_154_19 <= 0 and var_154_16 or var_154_16 * (var_154_20 / var_154_19)

				if var_154_21 > 0 and var_154_16 < var_154_21 then
					arg_151_1.talkMaxDuration = var_154_21

					if var_154_21 + var_154_15 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_21 + var_154_15
					end
				end

				arg_151_1.text_.text = var_154_18
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_22 = math.max(var_154_16, arg_151_1.talkMaxDuration)

			if var_154_15 <= arg_151_1.time_ and arg_151_1.time_ < var_154_15 + var_154_22 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_15) / var_154_22

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_15 + var_154_22 and arg_151_1.time_ < var_154_15 + var_154_22 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play412131037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 412131037
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play412131038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 1.2

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

				local var_158_2 = arg_155_1:GetWordFromCfg(412131037)
				local var_158_3 = arg_155_1:FormatText(var_158_2.content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 48
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
	Play412131038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 412131038
		arg_159_1.duration_ = 7.27

		local var_159_0 = {
			zh = 6.466,
			ja = 7.266
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play412131039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1197ui_story"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos1197ui_story = var_162_0.localPosition
			end

			local var_162_2 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2
				local var_162_4 = Vector3.New(0, -0.545, -6.3)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1197ui_story, var_162_4, var_162_3)

				local var_162_5 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_5.x, var_162_5.y, var_162_5.z)

				local var_162_6 = var_162_0.localEulerAngles

				var_162_6.z = 0
				var_162_6.x = 0
				var_162_0.localEulerAngles = var_162_6
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(0, -0.545, -6.3)

				local var_162_7 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_7.x, var_162_7.y, var_162_7.z)

				local var_162_8 = var_162_0.localEulerAngles

				var_162_8.z = 0
				var_162_8.x = 0
				var_162_0.localEulerAngles = var_162_8
			end

			local var_162_9 = arg_159_1.actors_["1197ui_story"]
			local var_162_10 = 0

			if var_162_10 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 and not isNil(var_162_9) and arg_159_1.var_.characterEffect1197ui_story == nil then
				arg_159_1.var_.characterEffect1197ui_story = var_162_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_11 = 0.200000002980232

			if var_162_10 <= arg_159_1.time_ and arg_159_1.time_ < var_162_10 + var_162_11 and not isNil(var_162_9) then
				local var_162_12 = (arg_159_1.time_ - var_162_10) / var_162_11

				if arg_159_1.var_.characterEffect1197ui_story and not isNil(var_162_9) then
					arg_159_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_10 + var_162_11 and arg_159_1.time_ < var_162_10 + var_162_11 + arg_162_0 and not isNil(var_162_9) and arg_159_1.var_.characterEffect1197ui_story then
				arg_159_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			local var_162_13 = 0

			if var_162_13 < arg_159_1.time_ and arg_159_1.time_ <= var_162_13 + arg_162_0 then
				arg_159_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action7_1")
			end

			local var_162_14 = 0

			if var_162_14 < arg_159_1.time_ and arg_159_1.time_ <= var_162_14 + arg_162_0 then
				arg_159_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_162_15 = 0
			local var_162_16 = 0.525

			if var_162_15 < arg_159_1.time_ and arg_159_1.time_ <= var_162_15 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_17 = arg_159_1:FormatText(StoryNameCfg[216].name)

				arg_159_1.leftNameTxt_.text = var_162_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_18 = arg_159_1:GetWordFromCfg(412131038)
				local var_162_19 = arg_159_1:FormatText(var_162_18.content)

				arg_159_1.text_.text = var_162_19

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_20 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131038", "story_v_out_412131.awb") ~= 0 then
					local var_162_23 = manager.audio:GetVoiceLength("story_v_out_412131", "412131038", "story_v_out_412131.awb") / 1000

					if var_162_23 + var_162_15 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_23 + var_162_15
					end

					if var_162_18.prefab_name ~= "" and arg_159_1.actors_[var_162_18.prefab_name] ~= nil then
						local var_162_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_18.prefab_name].transform, "story_v_out_412131", "412131038", "story_v_out_412131.awb")

						arg_159_1:RecordAudio("412131038", var_162_24)
						arg_159_1:RecordAudio("412131038", var_162_24)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_412131", "412131038", "story_v_out_412131.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_412131", "412131038", "story_v_out_412131.awb")
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
				actorName = "1197ui_story",
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
	Play412131039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 412131039
		arg_163_1.duration_ = 5.03

		local var_163_0 = {
			zh = 1.999999999999,
			ja = 5.033
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play412131040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10083ui_story"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos10083ui_story = var_166_0.localPosition
			end

			local var_166_2 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2
				local var_166_4 = Vector3.New(0, -2.6, -2.8)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10083ui_story, var_166_4, var_166_3)

				local var_166_5 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_5.x, var_166_5.y, var_166_5.z)

				local var_166_6 = var_166_0.localEulerAngles

				var_166_6.z = 0
				var_166_6.x = 0
				var_166_0.localEulerAngles = var_166_6
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0, -2.6, -2.8)

				local var_166_7 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_7.x, var_166_7.y, var_166_7.z)

				local var_166_8 = var_166_0.localEulerAngles

				var_166_8.z = 0
				var_166_8.x = 0
				var_166_0.localEulerAngles = var_166_8
			end

			local var_166_9 = arg_163_1.actors_["10083ui_story"]
			local var_166_10 = 0

			if var_166_10 < arg_163_1.time_ and arg_163_1.time_ <= var_166_10 + arg_166_0 and not isNil(var_166_9) and arg_163_1.var_.characterEffect10083ui_story == nil then
				arg_163_1.var_.characterEffect10083ui_story = var_166_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_11 = 0.200000002980232

			if var_166_10 <= arg_163_1.time_ and arg_163_1.time_ < var_166_10 + var_166_11 and not isNil(var_166_9) then
				local var_166_12 = (arg_163_1.time_ - var_166_10) / var_166_11

				if arg_163_1.var_.characterEffect10083ui_story and not isNil(var_166_9) then
					arg_163_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_10 + var_166_11 and arg_163_1.time_ < var_166_10 + var_166_11 + arg_166_0 and not isNil(var_166_9) and arg_163_1.var_.characterEffect10083ui_story then
				arg_163_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_166_13 = 0

			if var_166_13 < arg_163_1.time_ and arg_163_1.time_ <= var_166_13 + arg_166_0 then
				arg_163_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action2_1")
			end

			local var_166_14 = 0

			if var_166_14 < arg_163_1.time_ and arg_163_1.time_ <= var_166_14 + arg_166_0 then
				arg_163_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_166_15 = arg_163_1.actors_["1197ui_story"].transform
			local var_166_16 = 0

			if var_166_16 < arg_163_1.time_ and arg_163_1.time_ <= var_166_16 + arg_166_0 then
				arg_163_1.var_.moveOldPos1197ui_story = var_166_15.localPosition
			end

			local var_166_17 = 0.001

			if var_166_16 <= arg_163_1.time_ and arg_163_1.time_ < var_166_16 + var_166_17 then
				local var_166_18 = (arg_163_1.time_ - var_166_16) / var_166_17
				local var_166_19 = Vector3.New(0, 100, 0)

				var_166_15.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1197ui_story, var_166_19, var_166_18)

				local var_166_20 = manager.ui.mainCamera.transform.position - var_166_15.position

				var_166_15.forward = Vector3.New(var_166_20.x, var_166_20.y, var_166_20.z)

				local var_166_21 = var_166_15.localEulerAngles

				var_166_21.z = 0
				var_166_21.x = 0
				var_166_15.localEulerAngles = var_166_21
			end

			if arg_163_1.time_ >= var_166_16 + var_166_17 and arg_163_1.time_ < var_166_16 + var_166_17 + arg_166_0 then
				var_166_15.localPosition = Vector3.New(0, 100, 0)

				local var_166_22 = manager.ui.mainCamera.transform.position - var_166_15.position

				var_166_15.forward = Vector3.New(var_166_22.x, var_166_22.y, var_166_22.z)

				local var_166_23 = var_166_15.localEulerAngles

				var_166_23.z = 0
				var_166_23.x = 0
				var_166_15.localEulerAngles = var_166_23
			end

			local var_166_24 = arg_163_1.actors_["1197ui_story"]
			local var_166_25 = 0

			if var_166_25 < arg_163_1.time_ and arg_163_1.time_ <= var_166_25 + arg_166_0 and not isNil(var_166_24) and arg_163_1.var_.characterEffect1197ui_story == nil then
				arg_163_1.var_.characterEffect1197ui_story = var_166_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_26 = 0.200000002980232

			if var_166_25 <= arg_163_1.time_ and arg_163_1.time_ < var_166_25 + var_166_26 and not isNil(var_166_24) then
				local var_166_27 = (arg_163_1.time_ - var_166_25) / var_166_26

				if arg_163_1.var_.characterEffect1197ui_story and not isNil(var_166_24) then
					local var_166_28 = Mathf.Lerp(0, 0.5, var_166_27)

					arg_163_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1197ui_story.fillRatio = var_166_28
				end
			end

			if arg_163_1.time_ >= var_166_25 + var_166_26 and arg_163_1.time_ < var_166_25 + var_166_26 + arg_166_0 and not isNil(var_166_24) and arg_163_1.var_.characterEffect1197ui_story then
				local var_166_29 = 0.5

				arg_163_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1197ui_story.fillRatio = var_166_29
			end

			local var_166_30 = 0
			local var_166_31 = 0.2

			if var_166_30 < arg_163_1.time_ and arg_163_1.time_ <= var_166_30 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_32 = arg_163_1:FormatText(StoryNameCfg[918].name)

				arg_163_1.leftNameTxt_.text = var_166_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_33 = arg_163_1:GetWordFromCfg(412131039)
				local var_166_34 = arg_163_1:FormatText(var_166_33.content)

				arg_163_1.text_.text = var_166_34

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_35 = 8
				local var_166_36 = utf8.len(var_166_34)
				local var_166_37 = var_166_35 <= 0 and var_166_31 or var_166_31 * (var_166_36 / var_166_35)

				if var_166_37 > 0 and var_166_31 < var_166_37 then
					arg_163_1.talkMaxDuration = var_166_37

					if var_166_37 + var_166_30 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_37 + var_166_30
					end
				end

				arg_163_1.text_.text = var_166_34
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131039", "story_v_out_412131.awb") ~= 0 then
					local var_166_38 = manager.audio:GetVoiceLength("story_v_out_412131", "412131039", "story_v_out_412131.awb") / 1000

					if var_166_38 + var_166_30 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_38 + var_166_30
					end

					if var_166_33.prefab_name ~= "" and arg_163_1.actors_[var_166_33.prefab_name] ~= nil then
						local var_166_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_33.prefab_name].transform, "story_v_out_412131", "412131039", "story_v_out_412131.awb")

						arg_163_1:RecordAudio("412131039", var_166_39)
						arg_163_1:RecordAudio("412131039", var_166_39)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_412131", "412131039", "story_v_out_412131.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_412131", "412131039", "story_v_out_412131.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_40 = math.max(var_166_31, arg_163_1.talkMaxDuration)

			if var_166_30 <= arg_163_1.time_ and arg_163_1.time_ < var_166_30 + var_166_40 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_30) / var_166_40

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_30 + var_166_40 and arg_163_1.time_ < var_166_30 + var_166_40 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play412131040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 412131040
		arg_167_1.duration_ = 6.5

		local var_167_0 = {
			zh = 2.766,
			ja = 6.5
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
				arg_167_0:Play412131041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10076ui_story"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos10076ui_story = var_170_0.localPosition
			end

			local var_170_2 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2
				local var_170_4 = Vector3.New(0, -0.35, -4)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10076ui_story, var_170_4, var_170_3)

				local var_170_5 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_5.x, var_170_5.y, var_170_5.z)

				local var_170_6 = var_170_0.localEulerAngles

				var_170_6.z = 0
				var_170_6.x = 0
				var_170_0.localEulerAngles = var_170_6
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(0, -0.35, -4)

				local var_170_7 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_7.x, var_170_7.y, var_170_7.z)

				local var_170_8 = var_170_0.localEulerAngles

				var_170_8.z = 0
				var_170_8.x = 0
				var_170_0.localEulerAngles = var_170_8
			end

			local var_170_9 = arg_167_1.actors_["10076ui_story"]
			local var_170_10 = 0

			if var_170_10 < arg_167_1.time_ and arg_167_1.time_ <= var_170_10 + arg_170_0 and not isNil(var_170_9) and arg_167_1.var_.characterEffect10076ui_story == nil then
				arg_167_1.var_.characterEffect10076ui_story = var_170_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_11 = 0.200000002980232

			if var_170_10 <= arg_167_1.time_ and arg_167_1.time_ < var_170_10 + var_170_11 and not isNil(var_170_9) then
				local var_170_12 = (arg_167_1.time_ - var_170_10) / var_170_11

				if arg_167_1.var_.characterEffect10076ui_story and not isNil(var_170_9) then
					arg_167_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_10 + var_170_11 and arg_167_1.time_ < var_170_10 + var_170_11 + arg_170_0 and not isNil(var_170_9) and arg_167_1.var_.characterEffect10076ui_story then
				arg_167_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			local var_170_13 = 0

			if var_170_13 < arg_167_1.time_ and arg_167_1.time_ <= var_170_13 + arg_170_0 then
				arg_167_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action1_1")
			end

			local var_170_14 = 0

			if var_170_14 < arg_167_1.time_ and arg_167_1.time_ <= var_170_14 + arg_170_0 then
				arg_167_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_170_15 = arg_167_1.actors_["10083ui_story"].transform
			local var_170_16 = 0

			if var_170_16 < arg_167_1.time_ and arg_167_1.time_ <= var_170_16 + arg_170_0 then
				arg_167_1.var_.moveOldPos10083ui_story = var_170_15.localPosition
			end

			local var_170_17 = 0.001

			if var_170_16 <= arg_167_1.time_ and arg_167_1.time_ < var_170_16 + var_170_17 then
				local var_170_18 = (arg_167_1.time_ - var_170_16) / var_170_17
				local var_170_19 = Vector3.New(0, 100, 0)

				var_170_15.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10083ui_story, var_170_19, var_170_18)

				local var_170_20 = manager.ui.mainCamera.transform.position - var_170_15.position

				var_170_15.forward = Vector3.New(var_170_20.x, var_170_20.y, var_170_20.z)

				local var_170_21 = var_170_15.localEulerAngles

				var_170_21.z = 0
				var_170_21.x = 0
				var_170_15.localEulerAngles = var_170_21
			end

			if arg_167_1.time_ >= var_170_16 + var_170_17 and arg_167_1.time_ < var_170_16 + var_170_17 + arg_170_0 then
				var_170_15.localPosition = Vector3.New(0, 100, 0)

				local var_170_22 = manager.ui.mainCamera.transform.position - var_170_15.position

				var_170_15.forward = Vector3.New(var_170_22.x, var_170_22.y, var_170_22.z)

				local var_170_23 = var_170_15.localEulerAngles

				var_170_23.z = 0
				var_170_23.x = 0
				var_170_15.localEulerAngles = var_170_23
			end

			local var_170_24 = arg_167_1.actors_["10083ui_story"]
			local var_170_25 = 0

			if var_170_25 < arg_167_1.time_ and arg_167_1.time_ <= var_170_25 + arg_170_0 and not isNil(var_170_24) and arg_167_1.var_.characterEffect10083ui_story == nil then
				arg_167_1.var_.characterEffect10083ui_story = var_170_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_26 = 0.200000002980232

			if var_170_25 <= arg_167_1.time_ and arg_167_1.time_ < var_170_25 + var_170_26 and not isNil(var_170_24) then
				local var_170_27 = (arg_167_1.time_ - var_170_25) / var_170_26

				if arg_167_1.var_.characterEffect10083ui_story and not isNil(var_170_24) then
					local var_170_28 = Mathf.Lerp(0, 0.5, var_170_27)

					arg_167_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_167_1.var_.characterEffect10083ui_story.fillRatio = var_170_28
				end
			end

			if arg_167_1.time_ >= var_170_25 + var_170_26 and arg_167_1.time_ < var_170_25 + var_170_26 + arg_170_0 and not isNil(var_170_24) and arg_167_1.var_.characterEffect10083ui_story then
				local var_170_29 = 0.5

				arg_167_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_167_1.var_.characterEffect10083ui_story.fillRatio = var_170_29
			end

			local var_170_30 = 0
			local var_170_31 = 0.3

			if var_170_30 < arg_167_1.time_ and arg_167_1.time_ <= var_170_30 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_32 = arg_167_1:FormatText(StoryNameCfg[917].name)

				arg_167_1.leftNameTxt_.text = var_170_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_33 = arg_167_1:GetWordFromCfg(412131040)
				local var_170_34 = arg_167_1:FormatText(var_170_33.content)

				arg_167_1.text_.text = var_170_34

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_35 = 12
				local var_170_36 = utf8.len(var_170_34)
				local var_170_37 = var_170_35 <= 0 and var_170_31 or var_170_31 * (var_170_36 / var_170_35)

				if var_170_37 > 0 and var_170_31 < var_170_37 then
					arg_167_1.talkMaxDuration = var_170_37

					if var_170_37 + var_170_30 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_37 + var_170_30
					end
				end

				arg_167_1.text_.text = var_170_34
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131040", "story_v_out_412131.awb") ~= 0 then
					local var_170_38 = manager.audio:GetVoiceLength("story_v_out_412131", "412131040", "story_v_out_412131.awb") / 1000

					if var_170_38 + var_170_30 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_38 + var_170_30
					end

					if var_170_33.prefab_name ~= "" and arg_167_1.actors_[var_170_33.prefab_name] ~= nil then
						local var_170_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_33.prefab_name].transform, "story_v_out_412131", "412131040", "story_v_out_412131.awb")

						arg_167_1:RecordAudio("412131040", var_170_39)
						arg_167_1:RecordAudio("412131040", var_170_39)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_412131", "412131040", "story_v_out_412131.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_412131", "412131040", "story_v_out_412131.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_40 = math.max(var_170_31, arg_167_1.talkMaxDuration)

			if var_170_30 <= arg_167_1.time_ and arg_167_1.time_ < var_170_30 + var_170_40 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_30) / var_170_40

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_30 + var_170_40 and arg_167_1.time_ < var_170_30 + var_170_40 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play412131041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 412131041
		arg_171_1.duration_ = 5.47

		local var_171_0 = {
			zh = 5.466,
			ja = 4.4
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
				arg_171_0:Play412131042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10077ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos10077ui_story = var_174_0.localPosition
			end

			local var_174_2 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2
				local var_174_4 = Vector3.New(0, 0, -5)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10077ui_story, var_174_4, var_174_3)

				local var_174_5 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_5.x, var_174_5.y, var_174_5.z)

				local var_174_6 = var_174_0.localEulerAngles

				var_174_6.z = 0
				var_174_6.x = 0
				var_174_0.localEulerAngles = var_174_6
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0, 0, -5)

				local var_174_7 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_7.x, var_174_7.y, var_174_7.z)

				local var_174_8 = var_174_0.localEulerAngles

				var_174_8.z = 0
				var_174_8.x = 0
				var_174_0.localEulerAngles = var_174_8
			end

			local var_174_9 = arg_171_1.actors_["10077ui_story"]
			local var_174_10 = 0

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect10077ui_story == nil then
				arg_171_1.var_.characterEffect10077ui_story = var_174_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_11 = 0.200000002980232

			if var_174_10 <= arg_171_1.time_ and arg_171_1.time_ < var_174_10 + var_174_11 and not isNil(var_174_9) then
				local var_174_12 = (arg_171_1.time_ - var_174_10) / var_174_11

				if arg_171_1.var_.characterEffect10077ui_story and not isNil(var_174_9) then
					arg_171_1.var_.characterEffect10077ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_10 + var_174_11 and arg_171_1.time_ < var_174_10 + var_174_11 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect10077ui_story then
				arg_171_1.var_.characterEffect10077ui_story.fillFlat = false
			end

			local var_174_13 = 0

			if var_174_13 < arg_171_1.time_ and arg_171_1.time_ <= var_174_13 + arg_174_0 then
				arg_171_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/story10077/story10077action/10077action4_1")
			end

			local var_174_14 = 0

			if var_174_14 < arg_171_1.time_ and arg_171_1.time_ <= var_174_14 + arg_174_0 then
				arg_171_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_174_15 = arg_171_1.actors_["10076ui_story"].transform
			local var_174_16 = 0

			if var_174_16 < arg_171_1.time_ and arg_171_1.time_ <= var_174_16 + arg_174_0 then
				arg_171_1.var_.moveOldPos10076ui_story = var_174_15.localPosition
			end

			local var_174_17 = 0.001

			if var_174_16 <= arg_171_1.time_ and arg_171_1.time_ < var_174_16 + var_174_17 then
				local var_174_18 = (arg_171_1.time_ - var_174_16) / var_174_17
				local var_174_19 = Vector3.New(0, 100, 0)

				var_174_15.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10076ui_story, var_174_19, var_174_18)

				local var_174_20 = manager.ui.mainCamera.transform.position - var_174_15.position

				var_174_15.forward = Vector3.New(var_174_20.x, var_174_20.y, var_174_20.z)

				local var_174_21 = var_174_15.localEulerAngles

				var_174_21.z = 0
				var_174_21.x = 0
				var_174_15.localEulerAngles = var_174_21
			end

			if arg_171_1.time_ >= var_174_16 + var_174_17 and arg_171_1.time_ < var_174_16 + var_174_17 + arg_174_0 then
				var_174_15.localPosition = Vector3.New(0, 100, 0)

				local var_174_22 = manager.ui.mainCamera.transform.position - var_174_15.position

				var_174_15.forward = Vector3.New(var_174_22.x, var_174_22.y, var_174_22.z)

				local var_174_23 = var_174_15.localEulerAngles

				var_174_23.z = 0
				var_174_23.x = 0
				var_174_15.localEulerAngles = var_174_23
			end

			local var_174_24 = arg_171_1.actors_["10076ui_story"]
			local var_174_25 = 0

			if var_174_25 < arg_171_1.time_ and arg_171_1.time_ <= var_174_25 + arg_174_0 and not isNil(var_174_24) and arg_171_1.var_.characterEffect10076ui_story == nil then
				arg_171_1.var_.characterEffect10076ui_story = var_174_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_26 = 0.200000002980232

			if var_174_25 <= arg_171_1.time_ and arg_171_1.time_ < var_174_25 + var_174_26 and not isNil(var_174_24) then
				local var_174_27 = (arg_171_1.time_ - var_174_25) / var_174_26

				if arg_171_1.var_.characterEffect10076ui_story and not isNil(var_174_24) then
					local var_174_28 = Mathf.Lerp(0, 0.5, var_174_27)

					arg_171_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_171_1.var_.characterEffect10076ui_story.fillRatio = var_174_28
				end
			end

			if arg_171_1.time_ >= var_174_25 + var_174_26 and arg_171_1.time_ < var_174_25 + var_174_26 + arg_174_0 and not isNil(var_174_24) and arg_171_1.var_.characterEffect10076ui_story then
				local var_174_29 = 0.5

				arg_171_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_171_1.var_.characterEffect10076ui_story.fillRatio = var_174_29
			end

			local var_174_30 = 0
			local var_174_31 = 0.75

			if var_174_30 < arg_171_1.time_ and arg_171_1.time_ <= var_174_30 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_32 = arg_171_1:FormatText(StoryNameCfg[922].name)

				arg_171_1.leftNameTxt_.text = var_174_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_33 = arg_171_1:GetWordFromCfg(412131041)
				local var_174_34 = arg_171_1:FormatText(var_174_33.content)

				arg_171_1.text_.text = var_174_34

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_35 = 30
				local var_174_36 = utf8.len(var_174_34)
				local var_174_37 = var_174_35 <= 0 and var_174_31 or var_174_31 * (var_174_36 / var_174_35)

				if var_174_37 > 0 and var_174_31 < var_174_37 then
					arg_171_1.talkMaxDuration = var_174_37

					if var_174_37 + var_174_30 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_37 + var_174_30
					end
				end

				arg_171_1.text_.text = var_174_34
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131041", "story_v_out_412131.awb") ~= 0 then
					local var_174_38 = manager.audio:GetVoiceLength("story_v_out_412131", "412131041", "story_v_out_412131.awb") / 1000

					if var_174_38 + var_174_30 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_38 + var_174_30
					end

					if var_174_33.prefab_name ~= "" and arg_171_1.actors_[var_174_33.prefab_name] ~= nil then
						local var_174_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_33.prefab_name].transform, "story_v_out_412131", "412131041", "story_v_out_412131.awb")

						arg_171_1:RecordAudio("412131041", var_174_39)
						arg_171_1:RecordAudio("412131041", var_174_39)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_412131", "412131041", "story_v_out_412131.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_412131", "412131041", "story_v_out_412131.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_40 = math.max(var_174_31, arg_171_1.talkMaxDuration)

			if var_174_30 <= arg_171_1.time_ and arg_171_1.time_ < var_174_30 + var_174_40 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_30) / var_174_40

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_30 + var_174_40 and arg_171_1.time_ < var_174_30 + var_174_40 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play412131042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 412131042
		arg_175_1.duration_ = 4.3

		local var_175_0 = {
			zh = 2.633,
			ja = 4.3
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
				arg_175_0:Play412131043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["10076ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos10076ui_story = var_178_0.localPosition
			end

			local var_178_2 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2
				local var_178_4 = Vector3.New(0, -0.35, -4)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10076ui_story, var_178_4, var_178_3)

				local var_178_5 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_5.x, var_178_5.y, var_178_5.z)

				local var_178_6 = var_178_0.localEulerAngles

				var_178_6.z = 0
				var_178_6.x = 0
				var_178_0.localEulerAngles = var_178_6
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(0, -0.35, -4)

				local var_178_7 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_7.x, var_178_7.y, var_178_7.z)

				local var_178_8 = var_178_0.localEulerAngles

				var_178_8.z = 0
				var_178_8.x = 0
				var_178_0.localEulerAngles = var_178_8
			end

			local var_178_9 = arg_175_1.actors_["10076ui_story"]
			local var_178_10 = 0

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect10076ui_story == nil then
				arg_175_1.var_.characterEffect10076ui_story = var_178_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_11 = 0.200000002980232

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_11 and not isNil(var_178_9) then
				local var_178_12 = (arg_175_1.time_ - var_178_10) / var_178_11

				if arg_175_1.var_.characterEffect10076ui_story and not isNil(var_178_9) then
					arg_175_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_10 + var_178_11 and arg_175_1.time_ < var_178_10 + var_178_11 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect10076ui_story then
				arg_175_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			local var_178_13 = 0

			if var_178_13 < arg_175_1.time_ and arg_175_1.time_ <= var_178_13 + arg_178_0 then
				arg_175_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action3_1")
			end

			local var_178_14 = 0

			if var_178_14 < arg_175_1.time_ and arg_175_1.time_ <= var_178_14 + arg_178_0 then
				arg_175_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_178_15 = arg_175_1.actors_["10077ui_story"].transform
			local var_178_16 = 0

			if var_178_16 < arg_175_1.time_ and arg_175_1.time_ <= var_178_16 + arg_178_0 then
				arg_175_1.var_.moveOldPos10077ui_story = var_178_15.localPosition
			end

			local var_178_17 = 0.001

			if var_178_16 <= arg_175_1.time_ and arg_175_1.time_ < var_178_16 + var_178_17 then
				local var_178_18 = (arg_175_1.time_ - var_178_16) / var_178_17
				local var_178_19 = Vector3.New(0, 100, 0)

				var_178_15.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10077ui_story, var_178_19, var_178_18)

				local var_178_20 = manager.ui.mainCamera.transform.position - var_178_15.position

				var_178_15.forward = Vector3.New(var_178_20.x, var_178_20.y, var_178_20.z)

				local var_178_21 = var_178_15.localEulerAngles

				var_178_21.z = 0
				var_178_21.x = 0
				var_178_15.localEulerAngles = var_178_21
			end

			if arg_175_1.time_ >= var_178_16 + var_178_17 and arg_175_1.time_ < var_178_16 + var_178_17 + arg_178_0 then
				var_178_15.localPosition = Vector3.New(0, 100, 0)

				local var_178_22 = manager.ui.mainCamera.transform.position - var_178_15.position

				var_178_15.forward = Vector3.New(var_178_22.x, var_178_22.y, var_178_22.z)

				local var_178_23 = var_178_15.localEulerAngles

				var_178_23.z = 0
				var_178_23.x = 0
				var_178_15.localEulerAngles = var_178_23
			end

			local var_178_24 = arg_175_1.actors_["10077ui_story"]
			local var_178_25 = 0

			if var_178_25 < arg_175_1.time_ and arg_175_1.time_ <= var_178_25 + arg_178_0 and not isNil(var_178_24) and arg_175_1.var_.characterEffect10077ui_story == nil then
				arg_175_1.var_.characterEffect10077ui_story = var_178_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_26 = 0.200000002980232

			if var_178_25 <= arg_175_1.time_ and arg_175_1.time_ < var_178_25 + var_178_26 and not isNil(var_178_24) then
				local var_178_27 = (arg_175_1.time_ - var_178_25) / var_178_26

				if arg_175_1.var_.characterEffect10077ui_story and not isNil(var_178_24) then
					local var_178_28 = Mathf.Lerp(0, 0.5, var_178_27)

					arg_175_1.var_.characterEffect10077ui_story.fillFlat = true
					arg_175_1.var_.characterEffect10077ui_story.fillRatio = var_178_28
				end
			end

			if arg_175_1.time_ >= var_178_25 + var_178_26 and arg_175_1.time_ < var_178_25 + var_178_26 + arg_178_0 and not isNil(var_178_24) and arg_175_1.var_.characterEffect10077ui_story then
				local var_178_29 = 0.5

				arg_175_1.var_.characterEffect10077ui_story.fillFlat = true
				arg_175_1.var_.characterEffect10077ui_story.fillRatio = var_178_29
			end

			local var_178_30 = 0
			local var_178_31 = 0.325

			if var_178_30 < arg_175_1.time_ and arg_175_1.time_ <= var_178_30 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_32 = arg_175_1:FormatText(StoryNameCfg[917].name)

				arg_175_1.leftNameTxt_.text = var_178_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_33 = arg_175_1:GetWordFromCfg(412131042)
				local var_178_34 = arg_175_1:FormatText(var_178_33.content)

				arg_175_1.text_.text = var_178_34

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_35 = 13
				local var_178_36 = utf8.len(var_178_34)
				local var_178_37 = var_178_35 <= 0 and var_178_31 or var_178_31 * (var_178_36 / var_178_35)

				if var_178_37 > 0 and var_178_31 < var_178_37 then
					arg_175_1.talkMaxDuration = var_178_37

					if var_178_37 + var_178_30 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_37 + var_178_30
					end
				end

				arg_175_1.text_.text = var_178_34
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131042", "story_v_out_412131.awb") ~= 0 then
					local var_178_38 = manager.audio:GetVoiceLength("story_v_out_412131", "412131042", "story_v_out_412131.awb") / 1000

					if var_178_38 + var_178_30 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_38 + var_178_30
					end

					if var_178_33.prefab_name ~= "" and arg_175_1.actors_[var_178_33.prefab_name] ~= nil then
						local var_178_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_33.prefab_name].transform, "story_v_out_412131", "412131042", "story_v_out_412131.awb")

						arg_175_1:RecordAudio("412131042", var_178_39)
						arg_175_1:RecordAudio("412131042", var_178_39)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_412131", "412131042", "story_v_out_412131.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_412131", "412131042", "story_v_out_412131.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_40 = math.max(var_178_31, arg_175_1.talkMaxDuration)

			if var_178_30 <= arg_175_1.time_ and arg_175_1.time_ < var_178_30 + var_178_40 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_30) / var_178_40

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_30 + var_178_40 and arg_175_1.time_ < var_178_30 + var_178_40 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10077ui_story",
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
	Play412131043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 412131043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play412131044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["10076ui_story"].transform
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.var_.moveOldPos10076ui_story = var_182_0.localPosition
			end

			local var_182_2 = 0.001

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2
				local var_182_4 = Vector3.New(0, 100, 0)

				var_182_0.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10076ui_story, var_182_4, var_182_3)

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

			local var_182_9 = arg_179_1.actors_["10076ui_story"]
			local var_182_10 = 0

			if var_182_10 < arg_179_1.time_ and arg_179_1.time_ <= var_182_10 + arg_182_0 and not isNil(var_182_9) and arg_179_1.var_.characterEffect10076ui_story == nil then
				arg_179_1.var_.characterEffect10076ui_story = var_182_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_11 = 0.200000002980232

			if var_182_10 <= arg_179_1.time_ and arg_179_1.time_ < var_182_10 + var_182_11 and not isNil(var_182_9) then
				local var_182_12 = (arg_179_1.time_ - var_182_10) / var_182_11

				if arg_179_1.var_.characterEffect10076ui_story and not isNil(var_182_9) then
					local var_182_13 = Mathf.Lerp(0, 0.5, var_182_12)

					arg_179_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_179_1.var_.characterEffect10076ui_story.fillRatio = var_182_13
				end
			end

			if arg_179_1.time_ >= var_182_10 + var_182_11 and arg_179_1.time_ < var_182_10 + var_182_11 + arg_182_0 and not isNil(var_182_9) and arg_179_1.var_.characterEffect10076ui_story then
				local var_182_14 = 0.5

				arg_179_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_179_1.var_.characterEffect10076ui_story.fillRatio = var_182_14
			end

			local var_182_15 = 0
			local var_182_16 = 0.8

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

				local var_182_17 = arg_179_1:GetWordFromCfg(412131043)
				local var_182_18 = arg_179_1:FormatText(var_182_17.content)

				arg_179_1.text_.text = var_182_18

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_19 = 32
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
				actorName = "10076ui_story",
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
	Play412131044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 412131044
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play412131045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 1.425

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_2 = arg_183_1:GetWordFromCfg(412131044)
				local var_186_3 = arg_183_1:FormatText(var_186_2.content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 57
				local var_186_5 = utf8.len(var_186_3)
				local var_186_6 = var_186_4 <= 0 and var_186_1 or var_186_1 * (var_186_5 / var_186_4)

				if var_186_6 > 0 and var_186_1 < var_186_6 then
					arg_183_1.talkMaxDuration = var_186_6

					if var_186_6 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_6 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_7 and arg_183_1.time_ < var_186_0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play412131045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 412131045
		arg_187_1.duration_ = 7.37

		local var_187_0 = {
			zh = 4,
			ja = 7.366
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play412131046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1197ui_story"].transform
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.var_.moveOldPos1197ui_story = var_190_0.localPosition
			end

			local var_190_2 = 0.001

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2
				local var_190_4 = Vector3.New(0, -0.545, -6.3)

				var_190_0.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1197ui_story, var_190_4, var_190_3)

				local var_190_5 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_5.x, var_190_5.y, var_190_5.z)

				local var_190_6 = var_190_0.localEulerAngles

				var_190_6.z = 0
				var_190_6.x = 0
				var_190_0.localEulerAngles = var_190_6
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 then
				var_190_0.localPosition = Vector3.New(0, -0.545, -6.3)

				local var_190_7 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_7.x, var_190_7.y, var_190_7.z)

				local var_190_8 = var_190_0.localEulerAngles

				var_190_8.z = 0
				var_190_8.x = 0
				var_190_0.localEulerAngles = var_190_8
			end

			local var_190_9 = arg_187_1.actors_["1197ui_story"]
			local var_190_10 = 0

			if var_190_10 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 and not isNil(var_190_9) and arg_187_1.var_.characterEffect1197ui_story == nil then
				arg_187_1.var_.characterEffect1197ui_story = var_190_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_11 = 0.200000002980232

			if var_190_10 <= arg_187_1.time_ and arg_187_1.time_ < var_190_10 + var_190_11 and not isNil(var_190_9) then
				local var_190_12 = (arg_187_1.time_ - var_190_10) / var_190_11

				if arg_187_1.var_.characterEffect1197ui_story and not isNil(var_190_9) then
					arg_187_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_10 + var_190_11 and arg_187_1.time_ < var_190_10 + var_190_11 + arg_190_0 and not isNil(var_190_9) and arg_187_1.var_.characterEffect1197ui_story then
				arg_187_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			local var_190_13 = 0

			if var_190_13 < arg_187_1.time_ and arg_187_1.time_ <= var_190_13 + arg_190_0 then
				arg_187_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action7_2")
			end

			local var_190_14 = 0

			if var_190_14 < arg_187_1.time_ and arg_187_1.time_ <= var_190_14 + arg_190_0 then
				arg_187_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_190_15 = 0
			local var_190_16 = 0.425

			if var_190_15 < arg_187_1.time_ and arg_187_1.time_ <= var_190_15 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_17 = arg_187_1:FormatText(StoryNameCfg[216].name)

				arg_187_1.leftNameTxt_.text = var_190_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_18 = arg_187_1:GetWordFromCfg(412131045)
				local var_190_19 = arg_187_1:FormatText(var_190_18.content)

				arg_187_1.text_.text = var_190_19

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_20 = 17
				local var_190_21 = utf8.len(var_190_19)
				local var_190_22 = var_190_20 <= 0 and var_190_16 or var_190_16 * (var_190_21 / var_190_20)

				if var_190_22 > 0 and var_190_16 < var_190_22 then
					arg_187_1.talkMaxDuration = var_190_22

					if var_190_22 + var_190_15 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_22 + var_190_15
					end
				end

				arg_187_1.text_.text = var_190_19
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412131", "412131045", "story_v_out_412131.awb") ~= 0 then
					local var_190_23 = manager.audio:GetVoiceLength("story_v_out_412131", "412131045", "story_v_out_412131.awb") / 1000

					if var_190_23 + var_190_15 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_23 + var_190_15
					end

					if var_190_18.prefab_name ~= "" and arg_187_1.actors_[var_190_18.prefab_name] ~= nil then
						local var_190_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_18.prefab_name].transform, "story_v_out_412131", "412131045", "story_v_out_412131.awb")

						arg_187_1:RecordAudio("412131045", var_190_24)
						arg_187_1:RecordAudio("412131045", var_190_24)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_412131", "412131045", "story_v_out_412131.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_412131", "412131045", "story_v_out_412131.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_25 = math.max(var_190_16, arg_187_1.talkMaxDuration)

			if var_190_15 <= arg_187_1.time_ and arg_187_1.time_ < var_190_15 + var_190_25 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_15) / var_190_25

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_15 + var_190_25 and arg_187_1.time_ < var_190_15 + var_190_25 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play412131046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 412131046
		arg_191_1.duration_ = 7

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play412131047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = "STwhite"

			if arg_191_1.bgs_[var_194_0] == nil then
				local var_194_1 = Object.Instantiate(arg_191_1.paintGo_)

				var_194_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_194_0)
				var_194_1.name = var_194_0
				var_194_1.transform.parent = arg_191_1.stage_.transform
				var_194_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_191_1.bgs_[var_194_0] = var_194_1
			end

			local var_194_2 = 0

			if var_194_2 < arg_191_1.time_ and arg_191_1.time_ <= var_194_2 + arg_194_0 then
				local var_194_3 = manager.ui.mainCamera.transform.localPosition
				local var_194_4 = Vector3.New(0, 0, 10) + Vector3.New(var_194_3.x, var_194_3.y, 0)
				local var_194_5 = arg_191_1.bgs_.STwhite

				var_194_5.transform.localPosition = var_194_4
				var_194_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_194_6 = var_194_5:GetComponent("SpriteRenderer")

				if var_194_6 and var_194_6.sprite then
					local var_194_7 = (var_194_5.transform.localPosition - var_194_3).z
					local var_194_8 = manager.ui.mainCameraCom_
					local var_194_9 = 2 * var_194_7 * Mathf.Tan(var_194_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_194_10 = var_194_9 * var_194_8.aspect
					local var_194_11 = var_194_6.sprite.bounds.size.x
					local var_194_12 = var_194_6.sprite.bounds.size.y
					local var_194_13 = var_194_10 / var_194_11
					local var_194_14 = var_194_9 / var_194_12
					local var_194_15 = var_194_14 < var_194_13 and var_194_13 or var_194_14

					var_194_5.transform.localScale = Vector3.New(var_194_15, var_194_15, 0)
				end

				for iter_194_0, iter_194_1 in pairs(arg_191_1.bgs_) do
					if iter_194_0 ~= "STwhite" then
						iter_194_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_194_16 = 2

			if var_194_16 < arg_191_1.time_ and arg_191_1.time_ <= var_194_16 + arg_194_0 then
				arg_191_1.allBtn_.enabled = false
			end

			local var_194_17 = 0.3

			if arg_191_1.time_ >= var_194_16 + var_194_17 and arg_191_1.time_ < var_194_16 + var_194_17 + arg_194_0 then
				arg_191_1.allBtn_.enabled = true
			end

			local var_194_18 = 0

			if var_194_18 < arg_191_1.time_ and arg_191_1.time_ <= var_194_18 + arg_194_0 then
				arg_191_1.mask_.enabled = true
				arg_191_1.mask_.raycastTarget = true

				arg_191_1:SetGaussion(false)
			end

			local var_194_19 = 2

			if var_194_18 <= arg_191_1.time_ and arg_191_1.time_ < var_194_18 + var_194_19 then
				local var_194_20 = (arg_191_1.time_ - var_194_18) / var_194_19
				local var_194_21 = Color.New(1, 1, 1)

				var_194_21.a = Mathf.Lerp(1, 0, var_194_20)
				arg_191_1.mask_.color = var_194_21
			end

			if arg_191_1.time_ >= var_194_18 + var_194_19 and arg_191_1.time_ < var_194_18 + var_194_19 + arg_194_0 then
				local var_194_22 = Color.New(1, 1, 1)
				local var_194_23 = 0

				arg_191_1.mask_.enabled = false
				var_194_22.a = var_194_23
				arg_191_1.mask_.color = var_194_22
			end

			local var_194_24 = arg_191_1.actors_["1197ui_story"].transform
			local var_194_25 = 0

			if var_194_25 < arg_191_1.time_ and arg_191_1.time_ <= var_194_25 + arg_194_0 then
				arg_191_1.var_.moveOldPos1197ui_story = var_194_24.localPosition
			end

			local var_194_26 = 0.001

			if var_194_25 <= arg_191_1.time_ and arg_191_1.time_ < var_194_25 + var_194_26 then
				local var_194_27 = (arg_191_1.time_ - var_194_25) / var_194_26
				local var_194_28 = Vector3.New(0, 100, 0)

				var_194_24.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1197ui_story, var_194_28, var_194_27)

				local var_194_29 = manager.ui.mainCamera.transform.position - var_194_24.position

				var_194_24.forward = Vector3.New(var_194_29.x, var_194_29.y, var_194_29.z)

				local var_194_30 = var_194_24.localEulerAngles

				var_194_30.z = 0
				var_194_30.x = 0
				var_194_24.localEulerAngles = var_194_30
			end

			if arg_191_1.time_ >= var_194_25 + var_194_26 and arg_191_1.time_ < var_194_25 + var_194_26 + arg_194_0 then
				var_194_24.localPosition = Vector3.New(0, 100, 0)

				local var_194_31 = manager.ui.mainCamera.transform.position - var_194_24.position

				var_194_24.forward = Vector3.New(var_194_31.x, var_194_31.y, var_194_31.z)

				local var_194_32 = var_194_24.localEulerAngles

				var_194_32.z = 0
				var_194_32.x = 0
				var_194_24.localEulerAngles = var_194_32
			end

			local var_194_33 = arg_191_1.actors_["1197ui_story"]
			local var_194_34 = 0

			if var_194_34 < arg_191_1.time_ and arg_191_1.time_ <= var_194_34 + arg_194_0 and not isNil(var_194_33) and arg_191_1.var_.characterEffect1197ui_story == nil then
				arg_191_1.var_.characterEffect1197ui_story = var_194_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_35 = 0.034000001847744

			if var_194_34 <= arg_191_1.time_ and arg_191_1.time_ < var_194_34 + var_194_35 and not isNil(var_194_33) then
				local var_194_36 = (arg_191_1.time_ - var_194_34) / var_194_35

				if arg_191_1.var_.characterEffect1197ui_story and not isNil(var_194_33) then
					local var_194_37 = Mathf.Lerp(0, 0.5, var_194_36)

					arg_191_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1197ui_story.fillRatio = var_194_37
				end
			end

			if arg_191_1.time_ >= var_194_34 + var_194_35 and arg_191_1.time_ < var_194_34 + var_194_35 + arg_194_0 and not isNil(var_194_33) and arg_191_1.var_.characterEffect1197ui_story then
				local var_194_38 = 0.5

				arg_191_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1197ui_story.fillRatio = var_194_38
			end

			if arg_191_1.frameCnt_ <= 1 then
				arg_191_1.dialog_:SetActive(false)
			end

			local var_194_39 = 2
			local var_194_40 = 1.125

			if var_194_39 < arg_191_1.time_ and arg_191_1.time_ <= var_194_39 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0

				arg_191_1.dialog_:SetActive(true)

				arg_191_1.dialogCg_.alpha = 0

				local var_194_41 = LeanTween.value(arg_191_1.dialog_, 0, 1, 0.3)

				var_194_41:setOnUpdate(LuaHelper.FloatAction(function(arg_195_0)
					arg_191_1.dialogCg_.alpha = arg_195_0
				end))
				var_194_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_191_1.dialog_)
					var_194_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_191_1.duration_ = arg_191_1.duration_ + 0.3

				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_42 = arg_191_1:GetWordFromCfg(412131046)
				local var_194_43 = arg_191_1:FormatText(var_194_42.content)

				arg_191_1.text_.text = var_194_43

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_44 = 45
				local var_194_45 = utf8.len(var_194_43)
				local var_194_46 = var_194_44 <= 0 and var_194_40 or var_194_40 * (var_194_45 / var_194_44)

				if var_194_46 > 0 and var_194_40 < var_194_46 then
					arg_191_1.talkMaxDuration = var_194_46
					var_194_39 = var_194_39 + 0.3

					if var_194_46 + var_194_39 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_46 + var_194_39
					end
				end

				arg_191_1.text_.text = var_194_43
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_47 = var_194_39 + 0.3
			local var_194_48 = math.max(var_194_40, arg_191_1.talkMaxDuration)

			if var_194_47 <= arg_191_1.time_ and arg_191_1.time_ < var_194_47 + var_194_48 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_47) / var_194_48

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_47 + var_194_48 and arg_191_1.time_ < var_194_47 + var_194_48 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play412131047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 412131047
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play412131048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.525

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_2 = arg_197_1:GetWordFromCfg(412131047)
				local var_200_3 = arg_197_1:FormatText(var_200_2.content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 21
				local var_200_5 = utf8.len(var_200_3)
				local var_200_6 = var_200_4 <= 0 and var_200_1 or var_200_1 * (var_200_5 / var_200_4)

				if var_200_6 > 0 and var_200_1 < var_200_6 then
					arg_197_1.talkMaxDuration = var_200_6

					if var_200_6 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_6 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_3
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_7 and arg_197_1.time_ < var_200_0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play412131048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 412131048
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play412131049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 1.925

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_2 = arg_201_1:GetWordFromCfg(412131048)
				local var_204_3 = arg_201_1:FormatText(var_204_2.content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 76
				local var_204_5 = utf8.len(var_204_3)
				local var_204_6 = var_204_4 <= 0 and var_204_1 or var_204_1 * (var_204_5 / var_204_4)

				if var_204_6 > 0 and var_204_1 < var_204_6 then
					arg_201_1.talkMaxDuration = var_204_6

					if var_204_6 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_6 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_7 and arg_201_1.time_ < var_204_0 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play412131049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 412131049
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play412131050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.875

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_2 = arg_205_1:GetWordFromCfg(412131049)
				local var_208_3 = arg_205_1:FormatText(var_208_2.content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 35
				local var_208_5 = utf8.len(var_208_3)
				local var_208_6 = var_208_4 <= 0 and var_208_1 or var_208_1 * (var_208_5 / var_208_4)

				if var_208_6 > 0 and var_208_1 < var_208_6 then
					arg_205_1.talkMaxDuration = var_208_6

					if var_208_6 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_6 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_3
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_7 and arg_205_1.time_ < var_208_0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play412131050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 412131050
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play412131051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 0.65

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_2 = arg_209_1:GetWordFromCfg(412131050)
				local var_212_3 = arg_209_1:FormatText(var_212_2.content)

				arg_209_1.text_.text = var_212_3

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 26
				local var_212_5 = utf8.len(var_212_3)
				local var_212_6 = var_212_4 <= 0 and var_212_1 or var_212_1 * (var_212_5 / var_212_4)

				if var_212_6 > 0 and var_212_1 < var_212_6 then
					arg_209_1.talkMaxDuration = var_212_6

					if var_212_6 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_6 + var_212_0
					end
				end

				arg_209_1.text_.text = var_212_3
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_1, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_0) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_7 and arg_209_1.time_ < var_212_0 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play412131051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 412131051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play412131052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.325

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_2 = arg_213_1:GetWordFromCfg(412131051)
				local var_216_3 = arg_213_1:FormatText(var_216_2.content)

				arg_213_1.text_.text = var_216_3

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 13
				local var_216_5 = utf8.len(var_216_3)
				local var_216_6 = var_216_4 <= 0 and var_216_1 or var_216_1 * (var_216_5 / var_216_4)

				if var_216_6 > 0 and var_216_1 < var_216_6 then
					arg_213_1.talkMaxDuration = var_216_6

					if var_216_6 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_6 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_3
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_7 and arg_213_1.time_ < var_216_0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play412131052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 412131052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
			arg_217_1.auto_ = false
		end

		function arg_217_1.playNext_(arg_219_0)
			arg_217_1.onStoryFinished_()
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.25

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_2 = arg_217_1:GetWordFromCfg(412131052)
				local var_220_3 = arg_217_1:FormatText(var_220_2.content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 10
				local var_220_5 = utf8.len(var_220_3)
				local var_220_6 = var_220_4 <= 0 and var_220_1 or var_220_1 * (var_220_5 / var_220_4)

				if var_220_6 > 0 and var_220_1 < var_220_6 then
					arg_217_1.talkMaxDuration = var_220_6

					if var_220_6 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_6 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_7 and arg_217_1.time_ < var_220_0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST84a",
		"TextureConfig/Background/F01a",
		"TextureConfig/Background/F03_2",
		"TextureConfig/Background/I09f",
		"TextureConfig/Background/STwhite"
	},
	voices = {
		"story_v_out_412131.awb"
	}
}
