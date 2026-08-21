return {
	Play107031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 107031001
		arg_1_1.duration_ = 9.07

		local var_1_0 = {
			ja = 6.966,
			ko = 6.266,
			zh = 6.1,
			en = 9.066
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
				arg_1_0:Play107031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "1050ui_story"

			if arg_1_1.actors_[var_4_0] == nil then
				local var_4_1 = Asset.Load("Char/" .. "1050ui_story")

				if not isNil(var_4_1) then
					local var_4_2 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_1_1.stage_.transform)

					var_4_2.name = var_4_0
					var_4_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_0] = var_4_2

					local var_4_3 = var_4_2:GetComponentInChildren(typeof(CharacterEffect))

					var_4_3.enabled = true

					local var_4_4 = GameObjectTools.GetOrAddComponent(var_4_2, typeof(DynamicBoneHelper))

					if var_4_4 then
						var_4_4:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_3.transform, false)

					arg_1_1.var_[var_4_0 .. "Animator"] = var_4_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_0 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_0 .. "LipSync"] = var_4_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_5 = arg_1_1.actors_["1050ui_story"]
			local var_4_6 = 1.8

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 and not isNil(var_4_5) and arg_1_1.var_.characterEffect1050ui_story == nil then
				arg_1_1.var_.characterEffect1050ui_story = var_4_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_7 = 0.1

			if var_4_6 <= arg_1_1.time_ and arg_1_1.time_ < var_4_6 + var_4_7 and not isNil(var_4_5) then
				local var_4_8 = (arg_1_1.time_ - var_4_6) / var_4_7

				if arg_1_1.var_.characterEffect1050ui_story and not isNil(var_4_5) then
					arg_1_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_6 + var_4_7 and arg_1_1.time_ < var_4_6 + var_4_7 + arg_4_0 and not isNil(var_4_5) and arg_1_1.var_.characterEffect1050ui_story then
				arg_1_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_4_9 = "C04a"

			if arg_1_1.bgs_[var_4_9] == nil then
				local var_4_10 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_9)
				var_4_10.name = var_4_9
				var_4_10.transform.parent = arg_1_1.stage_.transform
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_9] = var_4_10
			end

			local var_4_11 = 0

			if var_4_11 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				local var_4_12 = manager.ui.mainCamera.transform.localPosition
				local var_4_13 = Vector3.New(0, 0, 10) + Vector3.New(var_4_12.x, var_4_12.y, 0)
				local var_4_14 = arg_1_1.bgs_.C04a

				var_4_14.transform.localPosition = var_4_13
				var_4_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_15 = var_4_14:GetComponent("SpriteRenderer")

				if var_4_15 and var_4_15.sprite then
					local var_4_16 = (var_4_14.transform.localPosition - var_4_12).z
					local var_4_17 = manager.ui.mainCameraCom_
					local var_4_18 = 2 * var_4_16 * Mathf.Tan(var_4_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_19 = var_4_18 * var_4_17.aspect
					local var_4_20 = var_4_15.sprite.bounds.size.x
					local var_4_21 = var_4_15.sprite.bounds.size.y
					local var_4_22 = var_4_19 / var_4_20
					local var_4_23 = var_4_18 / var_4_21
					local var_4_24 = var_4_23 < var_4_22 and var_4_22 or var_4_23

					var_4_14.transform.localScale = Vector3.New(var_4_24, var_4_24, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "C04a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_25 = arg_1_1.actors_["1050ui_story"].transform
			local var_4_26 = 1.8

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.var_.moveOldPos1050ui_story = var_4_25.localPosition
			end

			local var_4_27 = 0.001

			if var_4_26 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_27 then
				local var_4_28 = (arg_1_1.time_ - var_4_26) / var_4_27
				local var_4_29 = Vector3.New(0, -1, -6.1)

				var_4_25.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1050ui_story, var_4_29, var_4_28)

				local var_4_30 = manager.ui.mainCamera.transform.position - var_4_25.position

				var_4_25.forward = Vector3.New(var_4_30.x, var_4_30.y, var_4_30.z)

				local var_4_31 = var_4_25.localEulerAngles

				var_4_31.z = 0
				var_4_31.x = 0
				var_4_25.localEulerAngles = var_4_31
			end

			if arg_1_1.time_ >= var_4_26 + var_4_27 and arg_1_1.time_ < var_4_26 + var_4_27 + arg_4_0 then
				var_4_25.localPosition = Vector3.New(0, -1, -6.1)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_25.position

				var_4_25.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_25.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_25.localEulerAngles = var_4_33
			end

			local var_4_34 = 1.8

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action5_1")
			end

			local var_4_35 = arg_1_1.bgs_.C04a
			local var_4_36 = 0

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_37 = var_4_35:GetComponent("SpriteRenderer")

				if var_4_37 then
					arg_1_1.var_.alphaOldValueC04a = var_4_37.color.a
					arg_1_1.var_.alphaMatValueC04a = var_4_37
				end

				arg_1_1.var_.alphaOldValueC04a = 0
			end

			local var_4_38 = 1.5

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_38 then
				local var_4_39 = (arg_1_1.time_ - var_4_36) / var_4_38
				local var_4_40 = Mathf.Lerp(arg_1_1.var_.alphaOldValueC04a, 1, var_4_39)

				if arg_1_1.var_.alphaMatValueC04a then
					local var_4_41 = arg_1_1.var_.alphaMatValueC04a.color

					var_4_41.a = var_4_40
					arg_1_1.var_.alphaMatValueC04a.color = var_4_41
				end
			end

			if arg_1_1.time_ >= var_4_36 + var_4_38 and arg_1_1.time_ < var_4_36 + var_4_38 + arg_4_0 and arg_1_1.var_.alphaMatValueC04a then
				local var_4_42 = arg_1_1.var_.alphaMatValueC04a
				local var_4_43 = var_4_42.color

				var_4_43.a = 1
				var_4_42.color = var_4_43
			end

			local var_4_44 = 0
			local var_4_45 = 1

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_46 = "play"
				local var_4_47 = "music"

				arg_1_1:AudioAction(var_4_46, var_4_47, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_48 = ""
				local var_4_49 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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

			local var_4_50 = 0

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_51 = 2

			if arg_1_1.time_ >= var_4_50 + var_4_51 and arg_1_1.time_ < var_4_50 + var_4_51 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_52 = 0

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				arg_1_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_53 = 2
			local var_4_54 = 0.6

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_55 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_55:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_56 = arg_1_1:FormatText(StoryNameCfg[74].name)

				arg_1_1.leftNameTxt_.text = var_4_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_57 = arg_1_1:GetWordFromCfg(107031001)
				local var_4_58 = arg_1_1:FormatText(var_4_57.content)

				arg_1_1.text_.text = var_4_58

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_59 = 22
				local var_4_60 = utf8.len(var_4_58)
				local var_4_61 = var_4_59 <= 0 and var_4_54 or var_4_54 * (var_4_60 / var_4_59)

				if var_4_61 > 0 and var_4_54 < var_4_61 then
					arg_1_1.talkMaxDuration = var_4_61
					var_4_53 = var_4_53 + 0.3

					if var_4_61 + var_4_53 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_61 + var_4_53
					end
				end

				arg_1_1.text_.text = var_4_58
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031001", "story_v_out_107031.awb") ~= 0 then
					local var_4_62 = manager.audio:GetVoiceLength("story_v_out_107031", "107031001", "story_v_out_107031.awb") / 1000

					if var_4_62 + var_4_53 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_53
					end

					if var_4_57.prefab_name ~= "" and arg_1_1.actors_[var_4_57.prefab_name] ~= nil then
						local var_4_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_57.prefab_name].transform, "story_v_out_107031", "107031001", "story_v_out_107031.awb")

						arg_1_1:RecordAudio("107031001", var_4_63)
						arg_1_1:RecordAudio("107031001", var_4_63)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_107031", "107031001", "story_v_out_107031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_107031", "107031001", "story_v_out_107031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_64 = var_4_53 + 0.3
			local var_4_65 = math.max(var_4_54, arg_1_1.talkMaxDuration)

			if var_4_64 <= arg_1_1.time_ and arg_1_1.time_ < var_4_64 + var_4_65 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_64) / var_4_65

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_64 + var_4_65 and arg_1_1.time_ < var_4_64 + var_4_65 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play107031002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 107031002
		arg_8_1.duration_ = 5.8

		local var_8_0 = {
			ja = 5,
			ko = 5.333,
			zh = 4.1,
			en = 5.8
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
				arg_8_0:Play107031003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["1050ui_story"]
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect1050ui_story == nil then
				arg_8_1.var_.characterEffect1050ui_story = var_11_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_2 = 0.1

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 and not isNil(var_11_0) then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / var_11_2

				if arg_8_1.var_.characterEffect1050ui_story and not isNil(var_11_0) then
					local var_11_4 = Mathf.Lerp(0, 0.5, var_11_3)

					arg_8_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1050ui_story.fillRatio = var_11_4
				end
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect1050ui_story then
				local var_11_5 = 0.5

				arg_8_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1050ui_story.fillRatio = var_11_5
			end

			local var_11_6 = 0
			local var_11_7 = 0.6

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_8 = arg_8_1:FormatText(StoryNameCfg[76].name)

				arg_8_1.leftNameTxt_.text = var_11_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_9 = arg_8_1:GetWordFromCfg(107031002)
				local var_11_10 = arg_8_1:FormatText(var_11_9.content)

				arg_8_1.text_.text = var_11_10

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_11 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031002", "story_v_out_107031.awb") ~= 0 then
					local var_11_14 = manager.audio:GetVoiceLength("story_v_out_107031", "107031002", "story_v_out_107031.awb") / 1000

					if var_11_14 + var_11_6 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_6
					end

					if var_11_9.prefab_name ~= "" and arg_8_1.actors_[var_11_9.prefab_name] ~= nil then
						local var_11_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_9.prefab_name].transform, "story_v_out_107031", "107031002", "story_v_out_107031.awb")

						arg_8_1:RecordAudio("107031002", var_11_15)
						arg_8_1:RecordAudio("107031002", var_11_15)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_107031", "107031002", "story_v_out_107031.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_107031", "107031002", "story_v_out_107031.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_16 = math.max(var_11_7, arg_8_1.talkMaxDuration)

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_16 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_6) / var_11_16

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_6 + var_11_16 and arg_8_1.time_ < var_11_6 + var_11_16 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play107031003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 107031003
		arg_12_1.duration_ = 10.23

		local var_12_0 = {
			ja = 8.4,
			ko = 6.066,
			zh = 10.233,
			en = 9.4
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
				arg_12_0:Play107031004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1050ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1050ui_story == nil then
				arg_12_1.var_.characterEffect1050ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.1

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1050ui_story and not isNil(var_15_0) then
					arg_12_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1050ui_story then
				arg_12_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_15_4 = 0

			if var_15_4 < arg_12_1.time_ and arg_12_1.time_ <= var_15_4 + arg_15_0 then
				arg_12_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050actionlink/1050action454")
			end

			local var_15_5 = 0

			if var_15_5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 then
				arg_12_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_15_6 = 0
			local var_15_7 = 0.825

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_8 = arg_12_1:FormatText(StoryNameCfg[74].name)

				arg_12_1.leftNameTxt_.text = var_15_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_9 = arg_12_1:GetWordFromCfg(107031003)
				local var_15_10 = arg_12_1:FormatText(var_15_9.content)

				arg_12_1.text_.text = var_15_10

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031003", "story_v_out_107031.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_out_107031", "107031003", "story_v_out_107031.awb") / 1000

					if var_15_14 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_6
					end

					if var_15_9.prefab_name ~= "" and arg_12_1.actors_[var_15_9.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_9.prefab_name].transform, "story_v_out_107031", "107031003", "story_v_out_107031.awb")

						arg_12_1:RecordAudio("107031003", var_15_15)
						arg_12_1:RecordAudio("107031003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_107031", "107031003", "story_v_out_107031.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_107031", "107031003", "story_v_out_107031.awb")
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
	Play107031004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 107031004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play107031005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1050ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1050ui_story == nil then
				arg_16_1.var_.characterEffect1050ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.1

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect1050ui_story and not isNil(var_19_0) then
					local var_19_4 = Mathf.Lerp(0, 0.5, var_19_3)

					arg_16_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1050ui_story.fillRatio = var_19_4
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1050ui_story then
				local var_19_5 = 0.5

				arg_16_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1050ui_story.fillRatio = var_19_5
			end

			local var_19_6 = 0
			local var_19_7 = 0.8

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_8 = arg_16_1:GetWordFromCfg(107031004)
				local var_19_9 = arg_16_1:FormatText(var_19_8.content)

				arg_16_1.text_.text = var_19_9

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_10 = 32
				local var_19_11 = utf8.len(var_19_9)
				local var_19_12 = var_19_10 <= 0 and var_19_7 or var_19_7 * (var_19_11 / var_19_10)

				if var_19_12 > 0 and var_19_7 < var_19_12 then
					arg_16_1.talkMaxDuration = var_19_12

					if var_19_12 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_12 + var_19_6
					end
				end

				arg_16_1.text_.text = var_19_9
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_13 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_13 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_13

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_13 and arg_16_1.time_ < var_19_6 + var_19_13 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play107031005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 107031005
		arg_20_1.duration_ = 6.5

		local var_20_0 = {
			ja = 6.5,
			ko = 4.1,
			zh = 3.8,
			en = 4.633
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
				arg_20_0:Play107031006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1050ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1050ui_story == nil then
				arg_20_1.var_.characterEffect1050ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.1

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1050ui_story and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1050ui_story then
				arg_20_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_23_4 = 0

			if var_23_4 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050actionlink/1050action445")
			end

			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 then
				arg_20_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_23_6 = 0
			local var_23_7 = 0.35

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_8 = arg_20_1:FormatText(StoryNameCfg[74].name)

				arg_20_1.leftNameTxt_.text = var_23_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_9 = arg_20_1:GetWordFromCfg(107031005)
				local var_23_10 = arg_20_1:FormatText(var_23_9.content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 14
				local var_23_12 = utf8.len(var_23_10)
				local var_23_13 = var_23_11 <= 0 and var_23_7 or var_23_7 * (var_23_12 / var_23_11)

				if var_23_13 > 0 and var_23_7 < var_23_13 then
					arg_20_1.talkMaxDuration = var_23_13

					if var_23_13 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_10
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031005", "story_v_out_107031.awb") ~= 0 then
					local var_23_14 = manager.audio:GetVoiceLength("story_v_out_107031", "107031005", "story_v_out_107031.awb") / 1000

					if var_23_14 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_6
					end

					if var_23_9.prefab_name ~= "" and arg_20_1.actors_[var_23_9.prefab_name] ~= nil then
						local var_23_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_9.prefab_name].transform, "story_v_out_107031", "107031005", "story_v_out_107031.awb")

						arg_20_1:RecordAudio("107031005", var_23_15)
						arg_20_1:RecordAudio("107031005", var_23_15)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_107031", "107031005", "story_v_out_107031.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_107031", "107031005", "story_v_out_107031.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_16 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_16 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_16

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_16 and arg_20_1.time_ < var_23_6 + var_23_16 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play107031006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 107031006
		arg_24_1.duration_ = 11.73

		local var_24_0 = {
			ja = 9.666,
			ko = 7.966,
			zh = 8.633,
			en = 11.733
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
				arg_24_0:Play107031007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1050ui_story"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos1050ui_story = var_27_0.localPosition
			end

			local var_27_2 = 0.1

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2
				local var_27_4 = Vector3.New(0, 100, 0)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1050ui_story, var_27_4, var_27_3)

				local var_27_5 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_5.x, var_27_5.y, var_27_5.z)

				local var_27_6 = var_27_0.localEulerAngles

				var_27_6.z = 0
				var_27_6.x = 0
				var_27_0.localEulerAngles = var_27_6
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(0, 100, 0)

				local var_27_7 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_7.x, var_27_7.y, var_27_7.z)

				local var_27_8 = var_27_0.localEulerAngles

				var_27_8.z = 0
				var_27_8.x = 0
				var_27_0.localEulerAngles = var_27_8
			end

			local var_27_9 = 0

			if var_27_9 < arg_24_1.time_ and arg_24_1.time_ <= var_27_9 + arg_27_0 then
				arg_24_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_27_10 = 0
			local var_27_11 = 0.9

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_12 = arg_24_1:FormatText(StoryNameCfg[74].name)

				arg_24_1.leftNameTxt_.text = var_27_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_13 = arg_24_1:GetWordFromCfg(107031006)
				local var_27_14 = arg_24_1:FormatText(var_27_13.content)

				arg_24_1.text_.text = var_27_14

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_15 = 36
				local var_27_16 = utf8.len(var_27_14)
				local var_27_17 = var_27_15 <= 0 and var_27_11 or var_27_11 * (var_27_16 / var_27_15)

				if var_27_17 > 0 and var_27_11 < var_27_17 then
					arg_24_1.talkMaxDuration = var_27_17

					if var_27_17 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_17 + var_27_10
					end
				end

				arg_24_1.text_.text = var_27_14
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031006", "story_v_out_107031.awb") ~= 0 then
					local var_27_18 = manager.audio:GetVoiceLength("story_v_out_107031", "107031006", "story_v_out_107031.awb") / 1000

					if var_27_18 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_18 + var_27_10
					end

					if var_27_13.prefab_name ~= "" and arg_24_1.actors_[var_27_13.prefab_name] ~= nil then
						local var_27_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_13.prefab_name].transform, "story_v_out_107031", "107031006", "story_v_out_107031.awb")

						arg_24_1:RecordAudio("107031006", var_27_19)
						arg_24_1:RecordAudio("107031006", var_27_19)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_107031", "107031006", "story_v_out_107031.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_107031", "107031006", "story_v_out_107031.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_20 = math.max(var_27_11, arg_24_1.talkMaxDuration)

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_20 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_10) / var_27_20

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_10 + var_27_20 and arg_24_1.time_ < var_27_10 + var_27_20 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play107031007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 107031007
		arg_28_1.duration_ = 12.2

		local var_28_0 = {
			ja = 12.2,
			ko = 8.9,
			zh = 8.5,
			en = 10.8
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
				arg_28_0:Play107031008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_31_1 = 0
			local var_31_2 = 0.8

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_3 = arg_28_1:FormatText(StoryNameCfg[74].name)

				arg_28_1.leftNameTxt_.text = var_31_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_4 = arg_28_1:GetWordFromCfg(107031007)
				local var_31_5 = arg_28_1:FormatText(var_31_4.content)

				arg_28_1.text_.text = var_31_5

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_6 = 33
				local var_31_7 = utf8.len(var_31_5)
				local var_31_8 = var_31_6 <= 0 and var_31_2 or var_31_2 * (var_31_7 / var_31_6)

				if var_31_8 > 0 and var_31_2 < var_31_8 then
					arg_28_1.talkMaxDuration = var_31_8

					if var_31_8 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_1
					end
				end

				arg_28_1.text_.text = var_31_5
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031007", "story_v_out_107031.awb") ~= 0 then
					local var_31_9 = manager.audio:GetVoiceLength("story_v_out_107031", "107031007", "story_v_out_107031.awb") / 1000

					if var_31_9 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_1
					end

					if var_31_4.prefab_name ~= "" and arg_28_1.actors_[var_31_4.prefab_name] ~= nil then
						local var_31_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_4.prefab_name].transform, "story_v_out_107031", "107031007", "story_v_out_107031.awb")

						arg_28_1:RecordAudio("107031007", var_31_10)
						arg_28_1:RecordAudio("107031007", var_31_10)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_107031", "107031007", "story_v_out_107031.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_107031", "107031007", "story_v_out_107031.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_11 = math.max(var_31_2, arg_28_1.talkMaxDuration)

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_11 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_1) / var_31_11

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_1 + var_31_11 and arg_28_1.time_ < var_31_1 + var_31_11 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play107031008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 107031008
		arg_32_1.duration_ = 12.07

		local var_32_0 = {
			ja = 12.066,
			ko = 8.666,
			zh = 8.033,
			en = 8.333
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
				arg_32_0:Play107031009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_35_1 = 0
			local var_35_2 = 0.8

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_3 = arg_32_1:FormatText(StoryNameCfg[74].name)

				arg_32_1.leftNameTxt_.text = var_35_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_4 = arg_32_1:GetWordFromCfg(107031008)
				local var_35_5 = arg_32_1:FormatText(var_35_4.content)

				arg_32_1.text_.text = var_35_5

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_6 = 32
				local var_35_7 = utf8.len(var_35_5)
				local var_35_8 = var_35_6 <= 0 and var_35_2 or var_35_2 * (var_35_7 / var_35_6)

				if var_35_8 > 0 and var_35_2 < var_35_8 then
					arg_32_1.talkMaxDuration = var_35_8

					if var_35_8 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_1
					end
				end

				arg_32_1.text_.text = var_35_5
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031008", "story_v_out_107031.awb") ~= 0 then
					local var_35_9 = manager.audio:GetVoiceLength("story_v_out_107031", "107031008", "story_v_out_107031.awb") / 1000

					if var_35_9 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_1
					end

					if var_35_4.prefab_name ~= "" and arg_32_1.actors_[var_35_4.prefab_name] ~= nil then
						local var_35_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_4.prefab_name].transform, "story_v_out_107031", "107031008", "story_v_out_107031.awb")

						arg_32_1:RecordAudio("107031008", var_35_10)
						arg_32_1:RecordAudio("107031008", var_35_10)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_107031", "107031008", "story_v_out_107031.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_107031", "107031008", "story_v_out_107031.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_11 = math.max(var_35_2, arg_32_1.talkMaxDuration)

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_11 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_1) / var_35_11

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_1 + var_35_11 and arg_32_1.time_ < var_35_1 + var_35_11 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play107031009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 107031009
		arg_36_1.duration_ = 17.9

		local var_36_0 = {
			ja = 9.766,
			ko = 8.2,
			zh = 9.433,
			en = 17.9
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
				arg_36_0:Play107031010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_39_1 = 0
			local var_39_2 = 0.875

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_3 = arg_36_1:FormatText(StoryNameCfg[74].name)

				arg_36_1.leftNameTxt_.text = var_39_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_4 = arg_36_1:GetWordFromCfg(107031009)
				local var_39_5 = arg_36_1:FormatText(var_39_4.content)

				arg_36_1.text_.text = var_39_5

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_6 = 35
				local var_39_7 = utf8.len(var_39_5)
				local var_39_8 = var_39_6 <= 0 and var_39_2 or var_39_2 * (var_39_7 / var_39_6)

				if var_39_8 > 0 and var_39_2 < var_39_8 then
					arg_36_1.talkMaxDuration = var_39_8

					if var_39_8 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_1
					end
				end

				arg_36_1.text_.text = var_39_5
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031009", "story_v_out_107031.awb") ~= 0 then
					local var_39_9 = manager.audio:GetVoiceLength("story_v_out_107031", "107031009", "story_v_out_107031.awb") / 1000

					if var_39_9 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_1
					end

					if var_39_4.prefab_name ~= "" and arg_36_1.actors_[var_39_4.prefab_name] ~= nil then
						local var_39_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_4.prefab_name].transform, "story_v_out_107031", "107031009", "story_v_out_107031.awb")

						arg_36_1:RecordAudio("107031009", var_39_10)
						arg_36_1:RecordAudio("107031009", var_39_10)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_107031", "107031009", "story_v_out_107031.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_107031", "107031009", "story_v_out_107031.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_11 = math.max(var_39_2, arg_36_1.talkMaxDuration)

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_11 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_1) / var_39_11

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_1 + var_39_11 and arg_36_1.time_ < var_39_1 + var_39_11 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play107031010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 107031010
		arg_40_1.duration_ = 4.23

		local var_40_0 = {
			ja = 3.433,
			ko = 3.8,
			zh = 4.233,
			en = 3.233
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
				arg_40_0:Play107031011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_43_1 = 0
			local var_43_2 = 0.425

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_3 = arg_40_1:FormatText(StoryNameCfg[74].name)

				arg_40_1.leftNameTxt_.text = var_43_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_4 = arg_40_1:GetWordFromCfg(107031010)
				local var_43_5 = arg_40_1:FormatText(var_43_4.content)

				arg_40_1.text_.text = var_43_5

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_6 = 17
				local var_43_7 = utf8.len(var_43_5)
				local var_43_8 = var_43_6 <= 0 and var_43_2 or var_43_2 * (var_43_7 / var_43_6)

				if var_43_8 > 0 and var_43_2 < var_43_8 then
					arg_40_1.talkMaxDuration = var_43_8

					if var_43_8 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_1
					end
				end

				arg_40_1.text_.text = var_43_5
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031010", "story_v_out_107031.awb") ~= 0 then
					local var_43_9 = manager.audio:GetVoiceLength("story_v_out_107031", "107031010", "story_v_out_107031.awb") / 1000

					if var_43_9 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_1
					end

					if var_43_4.prefab_name ~= "" and arg_40_1.actors_[var_43_4.prefab_name] ~= nil then
						local var_43_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_4.prefab_name].transform, "story_v_out_107031", "107031010", "story_v_out_107031.awb")

						arg_40_1:RecordAudio("107031010", var_43_10)
						arg_40_1:RecordAudio("107031010", var_43_10)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_107031", "107031010", "story_v_out_107031.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_107031", "107031010", "story_v_out_107031.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_11 = math.max(var_43_2, arg_40_1.talkMaxDuration)

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_11 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_1) / var_43_11

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_1 + var_43_11 and arg_40_1.time_ < var_43_1 + var_43_11 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play107031011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 107031011
		arg_44_1.duration_ = 4.57

		local var_44_0 = {
			ja = 4.566,
			ko = 3.266,
			zh = 4.166,
			en = 3.9
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
				arg_44_0:Play107031012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1050ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos1050ui_story = var_47_0.localPosition
			end

			local var_47_2 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2
				local var_47_4 = Vector3.New(0, -1, -6.1)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1050ui_story, var_47_4, var_47_3)

				local var_47_5 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_5.x, var_47_5.y, var_47_5.z)

				local var_47_6 = var_47_0.localEulerAngles

				var_47_6.z = 0
				var_47_6.x = 0
				var_47_0.localEulerAngles = var_47_6
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0, -1, -6.1)

				local var_47_7 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_7.x, var_47_7.y, var_47_7.z)

				local var_47_8 = var_47_0.localEulerAngles

				var_47_8.z = 0
				var_47_8.x = 0
				var_47_0.localEulerAngles = var_47_8
			end

			local var_47_9 = arg_44_1.actors_["1050ui_story"]
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1050ui_story == nil then
				arg_44_1.var_.characterEffect1050ui_story = var_47_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.1

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 and not isNil(var_47_9) then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11

				if arg_44_1.var_.characterEffect1050ui_story and not isNil(var_47_9) then
					arg_44_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_10 + var_47_11 and arg_44_1.time_ < var_47_10 + var_47_11 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1050ui_story then
				arg_44_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_47_13 = 0

			if var_47_13 < arg_44_1.time_ and arg_44_1.time_ <= var_47_13 + arg_47_0 then
				arg_44_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			local var_47_14 = 0

			if var_47_14 < arg_44_1.time_ and arg_44_1.time_ <= var_47_14 + arg_47_0 then
				arg_44_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_47_15 = 0
			local var_47_16 = 0.4

			if var_47_15 < arg_44_1.time_ and arg_44_1.time_ <= var_47_15 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_17 = arg_44_1:FormatText(StoryNameCfg[74].name)

				arg_44_1.leftNameTxt_.text = var_47_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_18 = arg_44_1:GetWordFromCfg(107031011)
				local var_47_19 = arg_44_1:FormatText(var_47_18.content)

				arg_44_1.text_.text = var_47_19

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_20 = 16
				local var_47_21 = utf8.len(var_47_19)
				local var_47_22 = var_47_20 <= 0 and var_47_16 or var_47_16 * (var_47_21 / var_47_20)

				if var_47_22 > 0 and var_47_16 < var_47_22 then
					arg_44_1.talkMaxDuration = var_47_22

					if var_47_22 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_22 + var_47_15
					end
				end

				arg_44_1.text_.text = var_47_19
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031011", "story_v_out_107031.awb") ~= 0 then
					local var_47_23 = manager.audio:GetVoiceLength("story_v_out_107031", "107031011", "story_v_out_107031.awb") / 1000

					if var_47_23 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_23 + var_47_15
					end

					if var_47_18.prefab_name ~= "" and arg_44_1.actors_[var_47_18.prefab_name] ~= nil then
						local var_47_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_18.prefab_name].transform, "story_v_out_107031", "107031011", "story_v_out_107031.awb")

						arg_44_1:RecordAudio("107031011", var_47_24)
						arg_44_1:RecordAudio("107031011", var_47_24)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_107031", "107031011", "story_v_out_107031.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_107031", "107031011", "story_v_out_107031.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_25 = math.max(var_47_16, arg_44_1.talkMaxDuration)

			if var_47_15 <= arg_44_1.time_ and arg_44_1.time_ < var_47_15 + var_47_25 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_15) / var_47_25

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_15 + var_47_25 and arg_44_1.time_ < var_47_15 + var_47_25 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play107031012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 107031012
		arg_48_1.duration_ = 12

		local var_48_0 = {
			ja = 12,
			ko = 8.733,
			zh = 8.1,
			en = 7.9
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play107031013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_51_1 = 0
			local var_51_2 = 1.05

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_3 = arg_48_1:FormatText(StoryNameCfg[74].name)

				arg_48_1.leftNameTxt_.text = var_51_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_4 = arg_48_1:GetWordFromCfg(107031012)
				local var_51_5 = arg_48_1:FormatText(var_51_4.content)

				arg_48_1.text_.text = var_51_5

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_6 = 42
				local var_51_7 = utf8.len(var_51_5)
				local var_51_8 = var_51_6 <= 0 and var_51_2 or var_51_2 * (var_51_7 / var_51_6)

				if var_51_8 > 0 and var_51_2 < var_51_8 then
					arg_48_1.talkMaxDuration = var_51_8

					if var_51_8 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_1
					end
				end

				arg_48_1.text_.text = var_51_5
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031012", "story_v_out_107031.awb") ~= 0 then
					local var_51_9 = manager.audio:GetVoiceLength("story_v_out_107031", "107031012", "story_v_out_107031.awb") / 1000

					if var_51_9 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_1
					end

					if var_51_4.prefab_name ~= "" and arg_48_1.actors_[var_51_4.prefab_name] ~= nil then
						local var_51_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_4.prefab_name].transform, "story_v_out_107031", "107031012", "story_v_out_107031.awb")

						arg_48_1:RecordAudio("107031012", var_51_10)
						arg_48_1:RecordAudio("107031012", var_51_10)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_107031", "107031012", "story_v_out_107031.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_107031", "107031012", "story_v_out_107031.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_11 = math.max(var_51_2, arg_48_1.talkMaxDuration)

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_11 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_1) / var_51_11

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_1 + var_51_11 and arg_48_1.time_ < var_51_1 + var_51_11 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play107031013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 107031013
		arg_52_1.duration_ = 7.8

		local var_52_0 = {
			ja = 5.9,
			ko = 7.433,
			zh = 7.8,
			en = 7.433
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
				arg_52_0:Play107031014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1050ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1050ui_story == nil then
				arg_52_1.var_.characterEffect1050ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.2

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1050ui_story and not isNil(var_55_0) then
					local var_55_4 = Mathf.Lerp(0, 0.5, var_55_3)

					arg_52_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1050ui_story.fillRatio = var_55_4
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1050ui_story then
				local var_55_5 = 0.5

				arg_52_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1050ui_story.fillRatio = var_55_5
			end

			local var_55_6 = 0
			local var_55_7 = 0.65

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_8 = arg_52_1:FormatText(StoryNameCfg[95].name)

				arg_52_1.leftNameTxt_.text = var_55_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_9 = arg_52_1:GetWordFromCfg(107031013)
				local var_55_10 = arg_52_1:FormatText(var_55_9.content)

				arg_52_1.text_.text = var_55_10

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031013", "story_v_out_107031.awb") ~= 0 then
					local var_55_14 = manager.audio:GetVoiceLength("story_v_out_107031", "107031013", "story_v_out_107031.awb") / 1000

					if var_55_14 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_14 + var_55_6
					end

					if var_55_9.prefab_name ~= "" and arg_52_1.actors_[var_55_9.prefab_name] ~= nil then
						local var_55_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_9.prefab_name].transform, "story_v_out_107031", "107031013", "story_v_out_107031.awb")

						arg_52_1:RecordAudio("107031013", var_55_15)
						arg_52_1:RecordAudio("107031013", var_55_15)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_107031", "107031013", "story_v_out_107031.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_107031", "107031013", "story_v_out_107031.awb")
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
	Play107031014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 107031014
		arg_56_1.duration_ = 2

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play107031015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1050ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1050ui_story == nil then
				arg_56_1.var_.characterEffect1050ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.2

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1050ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1050ui_story then
				arg_56_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_59_4 = 0

			if var_59_4 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action6_1")
			end

			local var_59_5 = arg_56_1.actors_["1050ui_story"].transform
			local var_59_6 = 0

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.var_.moveOldPos1050ui_story = var_59_5.localPosition

				local var_59_7 = "1050ui_story"

				arg_56_1:ShowWeapon(arg_56_1.var_[var_59_7 .. "Animator"].transform, true)
			end

			local var_59_8 = 0.001

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_8 then
				local var_59_9 = (arg_56_1.time_ - var_59_6) / var_59_8
				local var_59_10 = Vector3.New(0, -1, -6.1)

				var_59_5.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1050ui_story, var_59_10, var_59_9)

				local var_59_11 = manager.ui.mainCamera.transform.position - var_59_5.position

				var_59_5.forward = Vector3.New(var_59_11.x, var_59_11.y, var_59_11.z)

				local var_59_12 = var_59_5.localEulerAngles

				var_59_12.z = 0
				var_59_12.x = 0
				var_59_5.localEulerAngles = var_59_12
			end

			if arg_56_1.time_ >= var_59_6 + var_59_8 and arg_56_1.time_ < var_59_6 + var_59_8 + arg_59_0 then
				var_59_5.localPosition = Vector3.New(0, -1, -6.1)

				local var_59_13 = manager.ui.mainCamera.transform.position - var_59_5.position

				var_59_5.forward = Vector3.New(var_59_13.x, var_59_13.y, var_59_13.z)

				local var_59_14 = var_59_5.localEulerAngles

				var_59_14.z = 0
				var_59_14.x = 0
				var_59_5.localEulerAngles = var_59_14
			end

			local var_59_15 = 0

			if var_59_15 < arg_56_1.time_ and arg_56_1.time_ <= var_59_15 + arg_59_0 then
				arg_56_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_59_16 = 0
			local var_59_17 = 0.075

			if var_59_16 < arg_56_1.time_ and arg_56_1.time_ <= var_59_16 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_18 = arg_56_1:FormatText(StoryNameCfg[74].name)

				arg_56_1.leftNameTxt_.text = var_59_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_19 = arg_56_1:GetWordFromCfg(107031014)
				local var_59_20 = arg_56_1:FormatText(var_59_19.content)

				arg_56_1.text_.text = var_59_20

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_21 = 3
				local var_59_22 = utf8.len(var_59_20)
				local var_59_23 = var_59_21 <= 0 and var_59_17 or var_59_17 * (var_59_22 / var_59_21)

				if var_59_23 > 0 and var_59_17 < var_59_23 then
					arg_56_1.talkMaxDuration = var_59_23

					if var_59_23 + var_59_16 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_23 + var_59_16
					end
				end

				arg_56_1.text_.text = var_59_20
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031014", "story_v_out_107031.awb") ~= 0 then
					local var_59_24 = manager.audio:GetVoiceLength("story_v_out_107031", "107031014", "story_v_out_107031.awb") / 1000

					if var_59_24 + var_59_16 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_24 + var_59_16
					end

					if var_59_19.prefab_name ~= "" and arg_56_1.actors_[var_59_19.prefab_name] ~= nil then
						local var_59_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_19.prefab_name].transform, "story_v_out_107031", "107031014", "story_v_out_107031.awb")

						arg_56_1:RecordAudio("107031014", var_59_25)
						arg_56_1:RecordAudio("107031014", var_59_25)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_107031", "107031014", "story_v_out_107031.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_107031", "107031014", "story_v_out_107031.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_26 = math.max(var_59_17, arg_56_1.talkMaxDuration)

			if var_59_16 <= arg_56_1.time_ and arg_56_1.time_ < var_59_16 + var_59_26 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_16) / var_59_26

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_16 + var_59_26 and arg_56_1.time_ < var_59_16 + var_59_26 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play107031015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 107031015
		arg_60_1.duration_ = 9.4

		local var_60_0 = {
			ja = 9.2,
			ko = 6.9,
			zh = 8.433,
			en = 9.4
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
				arg_60_0:Play107031016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = "S0703"

			if arg_60_1.bgs_[var_63_0] == nil then
				local var_63_1 = Object.Instantiate(arg_60_1.paintGo_)

				var_63_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_63_0)
				var_63_1.name = var_63_0
				var_63_1.transform.parent = arg_60_1.stage_.transform
				var_63_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.bgs_[var_63_0] = var_63_1
			end

			local var_63_2 = 1.5

			if var_63_2 < arg_60_1.time_ and arg_60_1.time_ <= var_63_2 + arg_63_0 then
				local var_63_3 = manager.ui.mainCamera.transform.localPosition
				local var_63_4 = Vector3.New(0, 0, 10) + Vector3.New(var_63_3.x, var_63_3.y, 0)
				local var_63_5 = arg_60_1.bgs_.S0703

				var_63_5.transform.localPosition = var_63_4
				var_63_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_63_6 = var_63_5:GetComponent("SpriteRenderer")

				if var_63_6 and var_63_6.sprite then
					local var_63_7 = (var_63_5.transform.localPosition - var_63_3).z
					local var_63_8 = manager.ui.mainCameraCom_
					local var_63_9 = 2 * var_63_7 * Mathf.Tan(var_63_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_63_10 = var_63_9 * var_63_8.aspect
					local var_63_11 = var_63_6.sprite.bounds.size.x
					local var_63_12 = var_63_6.sprite.bounds.size.y
					local var_63_13 = var_63_10 / var_63_11
					local var_63_14 = var_63_9 / var_63_12
					local var_63_15 = var_63_14 < var_63_13 and var_63_13 or var_63_14

					var_63_5.transform.localScale = Vector3.New(var_63_15, var_63_15, 0)
				end

				for iter_63_0, iter_63_1 in pairs(arg_60_1.bgs_) do
					if iter_63_0 ~= "S0703" then
						iter_63_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_63_16 = arg_60_1.bgs_.C04a
			local var_63_17 = 0

			if var_63_17 < arg_60_1.time_ and arg_60_1.time_ <= var_63_17 + arg_63_0 then
				local var_63_18 = var_63_16:GetComponent("SpriteRenderer")

				if var_63_18 then
					arg_60_1.var_.alphaOldValueC04a = var_63_18.color.a
					arg_60_1.var_.alphaMatValueC04a = var_63_18
				end

				arg_60_1.var_.alphaOldValueC04a = 1
			end

			local var_63_19 = 1.5

			if var_63_17 <= arg_60_1.time_ and arg_60_1.time_ < var_63_17 + var_63_19 then
				local var_63_20 = (arg_60_1.time_ - var_63_17) / var_63_19
				local var_63_21 = Mathf.Lerp(arg_60_1.var_.alphaOldValueC04a, 0, var_63_20)

				if arg_60_1.var_.alphaMatValueC04a then
					local var_63_22 = arg_60_1.var_.alphaMatValueC04a.color

					var_63_22.a = var_63_21
					arg_60_1.var_.alphaMatValueC04a.color = var_63_22
				end
			end

			if arg_60_1.time_ >= var_63_17 + var_63_19 and arg_60_1.time_ < var_63_17 + var_63_19 + arg_63_0 and arg_60_1.var_.alphaMatValueC04a then
				local var_63_23 = arg_60_1.var_.alphaMatValueC04a
				local var_63_24 = var_63_23.color

				var_63_24.a = 0
				var_63_23.color = var_63_24
			end

			local var_63_25 = arg_60_1.bgs_.S0703
			local var_63_26 = 1.5

			if var_63_26 < arg_60_1.time_ and arg_60_1.time_ <= var_63_26 + arg_63_0 then
				local var_63_27 = var_63_25:GetComponent("SpriteRenderer")

				if var_63_27 then
					arg_60_1.var_.alphaOldValueS0703 = var_63_27.color.a
					arg_60_1.var_.alphaMatValueS0703 = var_63_27
				end

				arg_60_1.var_.alphaOldValueS0703 = 0
			end

			local var_63_28 = 1.5

			if var_63_26 <= arg_60_1.time_ and arg_60_1.time_ < var_63_26 + var_63_28 then
				local var_63_29 = (arg_60_1.time_ - var_63_26) / var_63_28
				local var_63_30 = Mathf.Lerp(arg_60_1.var_.alphaOldValueS0703, 1, var_63_29)

				if arg_60_1.var_.alphaMatValueS0703 then
					local var_63_31 = arg_60_1.var_.alphaMatValueS0703.color

					var_63_31.a = var_63_30
					arg_60_1.var_.alphaMatValueS0703.color = var_63_31
				end
			end

			if arg_60_1.time_ >= var_63_26 + var_63_28 and arg_60_1.time_ < var_63_26 + var_63_28 + arg_63_0 and arg_60_1.var_.alphaMatValueS0703 then
				local var_63_32 = arg_60_1.var_.alphaMatValueS0703
				local var_63_33 = var_63_32.color

				var_63_33.a = 1
				var_63_32.color = var_63_33
			end

			local var_63_34 = arg_60_1.actors_["1050ui_story"].transform
			local var_63_35 = 0

			if var_63_35 < arg_60_1.time_ and arg_60_1.time_ <= var_63_35 + arg_63_0 then
				arg_60_1.var_.moveOldPos1050ui_story = var_63_34.localPosition
			end

			local var_63_36 = 0.001

			if var_63_35 <= arg_60_1.time_ and arg_60_1.time_ < var_63_35 + var_63_36 then
				local var_63_37 = (arg_60_1.time_ - var_63_35) / var_63_36
				local var_63_38 = Vector3.New(0, 100, 0)

				var_63_34.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1050ui_story, var_63_38, var_63_37)

				local var_63_39 = manager.ui.mainCamera.transform.position - var_63_34.position

				var_63_34.forward = Vector3.New(var_63_39.x, var_63_39.y, var_63_39.z)

				local var_63_40 = var_63_34.localEulerAngles

				var_63_40.z = 0
				var_63_40.x = 0
				var_63_34.localEulerAngles = var_63_40
			end

			if arg_60_1.time_ >= var_63_35 + var_63_36 and arg_60_1.time_ < var_63_35 + var_63_36 + arg_63_0 then
				var_63_34.localPosition = Vector3.New(0, 100, 0)

				local var_63_41 = manager.ui.mainCamera.transform.position - var_63_34.position

				var_63_34.forward = Vector3.New(var_63_41.x, var_63_41.y, var_63_41.z)

				local var_63_42 = var_63_34.localEulerAngles

				var_63_42.z = 0
				var_63_42.x = 0
				var_63_34.localEulerAngles = var_63_42
			end

			local var_63_43 = arg_60_1.bgs_.C04a.transform
			local var_63_44 = 1.5

			if var_63_44 < arg_60_1.time_ and arg_60_1.time_ <= var_63_44 + arg_63_0 then
				arg_60_1.var_.moveOldPosC04a = var_63_43.localPosition
			end

			local var_63_45 = 0.001

			if var_63_44 <= arg_60_1.time_ and arg_60_1.time_ < var_63_44 + var_63_45 then
				local var_63_46 = (arg_60_1.time_ - var_63_44) / var_63_45
				local var_63_47 = Vector3.New(0, 100, 0)

				var_63_43.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPosC04a, var_63_47, var_63_46)
			end

			if arg_60_1.time_ >= var_63_44 + var_63_45 and arg_60_1.time_ < var_63_44 + var_63_45 + arg_63_0 then
				var_63_43.localPosition = Vector3.New(0, 100, 0)
			end

			local var_63_48 = 0

			if var_63_48 < arg_60_1.time_ and arg_60_1.time_ <= var_63_48 + arg_63_0 then
				arg_60_1.allBtn_.enabled = false
			end

			local var_63_49 = 2

			if arg_60_1.time_ >= var_63_48 + var_63_49 and arg_60_1.time_ < var_63_48 + var_63_49 + arg_63_0 then
				arg_60_1.allBtn_.enabled = true
			end

			if arg_60_1.frameCnt_ <= 1 then
				arg_60_1.dialog_:SetActive(false)
			end

			local var_63_50 = 2
			local var_63_51 = 0.7

			if var_63_50 < arg_60_1.time_ and arg_60_1.time_ <= var_63_50 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_52 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_52:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_60_1.dialogCg_.alpha = arg_64_0
				end))
				var_63_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_53 = arg_60_1:FormatText(StoryNameCfg[95].name)

				arg_60_1.leftNameTxt_.text = var_63_53

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_54 = arg_60_1:GetWordFromCfg(107031015)
				local var_63_55 = arg_60_1:FormatText(var_63_54.content)

				arg_60_1.text_.text = var_63_55

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_56 = 28
				local var_63_57 = utf8.len(var_63_55)
				local var_63_58 = var_63_56 <= 0 and var_63_51 or var_63_51 * (var_63_57 / var_63_56)

				if var_63_58 > 0 and var_63_51 < var_63_58 then
					arg_60_1.talkMaxDuration = var_63_58
					var_63_50 = var_63_50 + 0.3

					if var_63_58 + var_63_50 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_58 + var_63_50
					end
				end

				arg_60_1.text_.text = var_63_55
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031015", "story_v_out_107031.awb") ~= 0 then
					local var_63_59 = manager.audio:GetVoiceLength("story_v_out_107031", "107031015", "story_v_out_107031.awb") / 1000

					if var_63_59 + var_63_50 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_59 + var_63_50
					end

					if var_63_54.prefab_name ~= "" and arg_60_1.actors_[var_63_54.prefab_name] ~= nil then
						local var_63_60 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_54.prefab_name].transform, "story_v_out_107031", "107031015", "story_v_out_107031.awb")

						arg_60_1:RecordAudio("107031015", var_63_60)
						arg_60_1:RecordAudio("107031015", var_63_60)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_107031", "107031015", "story_v_out_107031.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_107031", "107031015", "story_v_out_107031.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_61 = var_63_50 + 0.3
			local var_63_62 = math.max(var_63_51, arg_60_1.talkMaxDuration)

			if var_63_61 <= arg_60_1.time_ and arg_60_1.time_ < var_63_61 + var_63_62 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_61) / var_63_62

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_61 + var_63_62 and arg_60_1.time_ < var_63_61 + var_63_62 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "C04a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play107031016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 107031016
		arg_66_1.duration_ = 2.83

		local var_66_0 = {
			ja = 2.833,
			ko = 2,
			zh = 1.533,
			en = 1.066
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play107031017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 0.15

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_2 = arg_66_1:FormatText(StoryNameCfg[74].name)

				arg_66_1.leftNameTxt_.text = var_69_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_3 = arg_66_1:GetWordFromCfg(107031016)
				local var_69_4 = arg_66_1:FormatText(var_69_3.content)

				arg_66_1.text_.text = var_69_4

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 6
				local var_69_6 = utf8.len(var_69_4)
				local var_69_7 = var_69_5 <= 0 and var_69_1 or var_69_1 * (var_69_6 / var_69_5)

				if var_69_7 > 0 and var_69_1 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_0
					end
				end

				arg_66_1.text_.text = var_69_4
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031016", "story_v_out_107031.awb") ~= 0 then
					local var_69_8 = manager.audio:GetVoiceLength("story_v_out_107031", "107031016", "story_v_out_107031.awb") / 1000

					if var_69_8 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_0
					end

					if var_69_3.prefab_name ~= "" and arg_66_1.actors_[var_69_3.prefab_name] ~= nil then
						local var_69_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_3.prefab_name].transform, "story_v_out_107031", "107031016", "story_v_out_107031.awb")

						arg_66_1:RecordAudio("107031016", var_69_9)
						arg_66_1:RecordAudio("107031016", var_69_9)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_107031", "107031016", "story_v_out_107031.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_107031", "107031016", "story_v_out_107031.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_10 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_10 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_10

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_10 and arg_66_1.time_ < var_69_0 + var_69_10 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play107031017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 107031017
		arg_70_1.duration_ = 5.2

		local var_70_0 = {
			ja = 5.2,
			ko = 2.033,
			zh = 2.333,
			en = 2.566
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play107031018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 0.225

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_2 = arg_70_1:FormatText(StoryNameCfg[95].name)

				arg_70_1.leftNameTxt_.text = var_73_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_3 = arg_70_1:GetWordFromCfg(107031017)
				local var_73_4 = arg_70_1:FormatText(var_73_3.content)

				arg_70_1.text_.text = var_73_4

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 9
				local var_73_6 = utf8.len(var_73_4)
				local var_73_7 = var_73_5 <= 0 and var_73_1 or var_73_1 * (var_73_6 / var_73_5)

				if var_73_7 > 0 and var_73_1 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_4
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031017", "story_v_out_107031.awb") ~= 0 then
					local var_73_8 = manager.audio:GetVoiceLength("story_v_out_107031", "107031017", "story_v_out_107031.awb") / 1000

					if var_73_8 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_8 + var_73_0
					end

					if var_73_3.prefab_name ~= "" and arg_70_1.actors_[var_73_3.prefab_name] ~= nil then
						local var_73_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_3.prefab_name].transform, "story_v_out_107031", "107031017", "story_v_out_107031.awb")

						arg_70_1:RecordAudio("107031017", var_73_9)
						arg_70_1:RecordAudio("107031017", var_73_9)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_107031", "107031017", "story_v_out_107031.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_107031", "107031017", "story_v_out_107031.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_10 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_10 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_10

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_10 and arg_70_1.time_ < var_73_0 + var_73_10 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play107031018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 107031018
		arg_74_1.duration_ = 4.8

		local var_74_0 = {
			ja = 4.8,
			ko = 3.166,
			zh = 4.133,
			en = 1.8
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play107031019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.3

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[95].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_3 = arg_74_1:GetWordFromCfg(107031018)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 12
				local var_77_6 = utf8.len(var_77_4)
				local var_77_7 = var_77_5 <= 0 and var_77_1 or var_77_1 * (var_77_6 / var_77_5)

				if var_77_7 > 0 and var_77_1 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031018", "story_v_out_107031.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_107031", "107031018", "story_v_out_107031.awb") / 1000

					if var_77_8 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_0
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_out_107031", "107031018", "story_v_out_107031.awb")

						arg_74_1:RecordAudio("107031018", var_77_9)
						arg_74_1:RecordAudio("107031018", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_107031", "107031018", "story_v_out_107031.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_107031", "107031018", "story_v_out_107031.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_10 and arg_74_1.time_ < var_77_0 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play107031019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 107031019
		arg_78_1.duration_ = 18.33

		local var_78_0 = {
			ja = 18.333,
			ko = 10.8,
			zh = 8.333,
			en = 10
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play107031020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.975

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_2 = arg_78_1:FormatText(StoryNameCfg[95].name)

				arg_78_1.leftNameTxt_.text = var_81_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_3 = arg_78_1:GetWordFromCfg(107031019)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 38
				local var_81_6 = utf8.len(var_81_4)
				local var_81_7 = var_81_5 <= 0 and var_81_1 or var_81_1 * (var_81_6 / var_81_5)

				if var_81_7 > 0 and var_81_1 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_4
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031019", "story_v_out_107031.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_107031", "107031019", "story_v_out_107031.awb") / 1000

					if var_81_8 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_0
					end

					if var_81_3.prefab_name ~= "" and arg_78_1.actors_[var_81_3.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_3.prefab_name].transform, "story_v_out_107031", "107031019", "story_v_out_107031.awb")

						arg_78_1:RecordAudio("107031019", var_81_9)
						arg_78_1:RecordAudio("107031019", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_107031", "107031019", "story_v_out_107031.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_107031", "107031019", "story_v_out_107031.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_10 and arg_78_1.time_ < var_81_0 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play107031020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 107031020
		arg_82_1.duration_ = 3.27

		local var_82_0 = {
			ja = 2,
			ko = 1.766,
			zh = 3.266,
			en = 1.4
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play107031021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.15

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[74].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_3 = arg_82_1:GetWordFromCfg(107031020)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 6
				local var_85_6 = utf8.len(var_85_4)
				local var_85_7 = var_85_5 <= 0 and var_85_1 or var_85_1 * (var_85_6 / var_85_5)

				if var_85_7 > 0 and var_85_1 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031020", "story_v_out_107031.awb") ~= 0 then
					local var_85_8 = manager.audio:GetVoiceLength("story_v_out_107031", "107031020", "story_v_out_107031.awb") / 1000

					if var_85_8 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_0
					end

					if var_85_3.prefab_name ~= "" and arg_82_1.actors_[var_85_3.prefab_name] ~= nil then
						local var_85_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_3.prefab_name].transform, "story_v_out_107031", "107031020", "story_v_out_107031.awb")

						arg_82_1:RecordAudio("107031020", var_85_9)
						arg_82_1:RecordAudio("107031020", var_85_9)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_107031", "107031020", "story_v_out_107031.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_107031", "107031020", "story_v_out_107031.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_10 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_10 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_10

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_10 and arg_82_1.time_ < var_85_0 + var_85_10 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play107031021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 107031021
		arg_86_1.duration_ = 11.47

		local var_86_0 = {
			ja = 11.466,
			ko = 10.4,
			zh = 9.666,
			en = 8.566
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play107031022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0
			local var_89_1 = 0.975

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_2 = arg_86_1:FormatText(StoryNameCfg[95].name)

				arg_86_1.leftNameTxt_.text = var_89_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_3 = arg_86_1:GetWordFromCfg(107031021)
				local var_89_4 = arg_86_1:FormatText(var_89_3.content)

				arg_86_1.text_.text = var_89_4

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 39
				local var_89_6 = utf8.len(var_89_4)
				local var_89_7 = var_89_5 <= 0 and var_89_1 or var_89_1 * (var_89_6 / var_89_5)

				if var_89_7 > 0 and var_89_1 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_0
					end
				end

				arg_86_1.text_.text = var_89_4
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031021", "story_v_out_107031.awb") ~= 0 then
					local var_89_8 = manager.audio:GetVoiceLength("story_v_out_107031", "107031021", "story_v_out_107031.awb") / 1000

					if var_89_8 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_8 + var_89_0
					end

					if var_89_3.prefab_name ~= "" and arg_86_1.actors_[var_89_3.prefab_name] ~= nil then
						local var_89_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_3.prefab_name].transform, "story_v_out_107031", "107031021", "story_v_out_107031.awb")

						arg_86_1:RecordAudio("107031021", var_89_9)
						arg_86_1:RecordAudio("107031021", var_89_9)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_107031", "107031021", "story_v_out_107031.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_107031", "107031021", "story_v_out_107031.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_10 = math.max(var_89_1, arg_86_1.talkMaxDuration)

			if var_89_0 <= arg_86_1.time_ and arg_86_1.time_ < var_89_0 + var_89_10 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_0) / var_89_10

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_0 + var_89_10 and arg_86_1.time_ < var_89_0 + var_89_10 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play107031022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 107031022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play107031023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = manager.ui.mainCamera.transform
			local var_93_1 = 0.45

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.var_.shakeOldPos = var_93_0.localPosition
			end

			local var_93_2 = 0.2

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / 0.099
				local var_93_4, var_93_5 = math.modf(var_93_3)

				var_93_0.localPosition = Vector3.New(var_93_5 * 0.13, var_93_5 * 0.13, var_93_5 * 0.13) + arg_90_1.var_.shakeOldPos
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 then
				var_93_0.localPosition = arg_90_1.var_.shakeOldPos
			end

			local var_93_6 = 0.45

			if var_93_6 < arg_90_1.time_ and arg_90_1.time_ <= var_93_6 + arg_93_0 then
				arg_90_1.mask_.enabled = true
				arg_90_1.mask_.raycastTarget = true

				arg_90_1:SetGaussion(false)
			end

			local var_93_7 = 0.5

			if var_93_6 <= arg_90_1.time_ and arg_90_1.time_ < var_93_6 + var_93_7 then
				local var_93_8 = (arg_90_1.time_ - var_93_6) / var_93_7
				local var_93_9 = Color.New(1, 1, 1)

				var_93_9.a = Mathf.Lerp(1, 0, var_93_8)
				arg_90_1.mask_.color = var_93_9
			end

			if arg_90_1.time_ >= var_93_6 + var_93_7 and arg_90_1.time_ < var_93_6 + var_93_7 + arg_93_0 then
				local var_93_10 = Color.New(1, 1, 1)
				local var_93_11 = 0

				arg_90_1.mask_.enabled = false
				var_93_10.a = var_93_11
				arg_90_1.mask_.color = var_93_10
			end

			local var_93_12 = 0
			local var_93_13 = 0.725

			if var_93_12 < arg_90_1.time_ and arg_90_1.time_ <= var_93_12 + arg_93_0 then
				local var_93_14 = "play"
				local var_93_15 = "effect"

				arg_90_1:AudioAction(var_93_14, var_93_15, "se_story_7", "se_story_7_chopped", "")
			end

			local var_93_16 = 0
			local var_93_17 = 0.725

			if var_93_16 < arg_90_1.time_ and arg_90_1.time_ <= var_93_16 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_18 = arg_90_1:GetWordFromCfg(107031022)
				local var_93_19 = arg_90_1:FormatText(var_93_18.content)

				arg_90_1.text_.text = var_93_19

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_20 = 29
				local var_93_21 = utf8.len(var_93_19)
				local var_93_22 = var_93_20 <= 0 and var_93_17 or var_93_17 * (var_93_21 / var_93_20)

				if var_93_22 > 0 and var_93_17 < var_93_22 then
					arg_90_1.talkMaxDuration = var_93_22

					if var_93_22 + var_93_16 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_22 + var_93_16
					end
				end

				arg_90_1.text_.text = var_93_19
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_23 = math.max(var_93_17, arg_90_1.talkMaxDuration)

			if var_93_16 <= arg_90_1.time_ and arg_90_1.time_ < var_93_16 + var_93_23 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_16) / var_93_23

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_16 + var_93_23 and arg_90_1.time_ < var_93_16 + var_93_23 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play107031023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 107031023
		arg_94_1.duration_ = 4.47

		local var_94_0 = {
			ja = 3.666,
			ko = 4.3,
			zh = 3.366,
			en = 4.466
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play107031024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.425

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[76].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_3 = arg_94_1:GetWordFromCfg(107031023)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 17
				local var_97_6 = utf8.len(var_97_4)
				local var_97_7 = var_97_5 <= 0 and var_97_1 or var_97_1 * (var_97_6 / var_97_5)

				if var_97_7 > 0 and var_97_1 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_4
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031023", "story_v_out_107031.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_107031", "107031023", "story_v_out_107031.awb") / 1000

					if var_97_8 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_0
					end

					if var_97_3.prefab_name ~= "" and arg_94_1.actors_[var_97_3.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_3.prefab_name].transform, "story_v_out_107031", "107031023", "story_v_out_107031.awb")

						arg_94_1:RecordAudio("107031023", var_97_9)
						arg_94_1:RecordAudio("107031023", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_107031", "107031023", "story_v_out_107031.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_107031", "107031023", "story_v_out_107031.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_10 and arg_94_1.time_ < var_97_0 + var_97_10 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play107031024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 107031024
		arg_98_1.duration_ = 4.8

		local var_98_0 = {
			ja = 3.966,
			ko = 4.8,
			zh = 3.7,
			en = 2.9
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play107031025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 0.4

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_2 = arg_98_1:FormatText(StoryNameCfg[95].name)

				arg_98_1.leftNameTxt_.text = var_101_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_3 = arg_98_1:GetWordFromCfg(107031024)
				local var_101_4 = arg_98_1:FormatText(var_101_3.content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 16
				local var_101_6 = utf8.len(var_101_4)
				local var_101_7 = var_101_5 <= 0 and var_101_1 or var_101_1 * (var_101_6 / var_101_5)

				if var_101_7 > 0 and var_101_1 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_4
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031024", "story_v_out_107031.awb") ~= 0 then
					local var_101_8 = manager.audio:GetVoiceLength("story_v_out_107031", "107031024", "story_v_out_107031.awb") / 1000

					if var_101_8 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_8 + var_101_0
					end

					if var_101_3.prefab_name ~= "" and arg_98_1.actors_[var_101_3.prefab_name] ~= nil then
						local var_101_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_3.prefab_name].transform, "story_v_out_107031", "107031024", "story_v_out_107031.awb")

						arg_98_1:RecordAudio("107031024", var_101_9)
						arg_98_1:RecordAudio("107031024", var_101_9)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_107031", "107031024", "story_v_out_107031.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_107031", "107031024", "story_v_out_107031.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_10 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_10 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_10

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_10 and arg_98_1.time_ < var_101_0 + var_101_10 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play107031025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 107031025
		arg_102_1.duration_ = 12.97

		local var_102_0 = {
			ja = 12.966,
			ko = 8.166,
			zh = 8.9,
			en = 9.666
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play107031026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 0.875

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_2 = arg_102_1:FormatText(StoryNameCfg[95].name)

				arg_102_1.leftNameTxt_.text = var_105_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_3 = arg_102_1:GetWordFromCfg(107031025)
				local var_105_4 = arg_102_1:FormatText(var_105_3.content)

				arg_102_1.text_.text = var_105_4

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 35
				local var_105_6 = utf8.len(var_105_4)
				local var_105_7 = var_105_5 <= 0 and var_105_1 or var_105_1 * (var_105_6 / var_105_5)

				if var_105_7 > 0 and var_105_1 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_4
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031025", "story_v_out_107031.awb") ~= 0 then
					local var_105_8 = manager.audio:GetVoiceLength("story_v_out_107031", "107031025", "story_v_out_107031.awb") / 1000

					if var_105_8 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_0
					end

					if var_105_3.prefab_name ~= "" and arg_102_1.actors_[var_105_3.prefab_name] ~= nil then
						local var_105_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_3.prefab_name].transform, "story_v_out_107031", "107031025", "story_v_out_107031.awb")

						arg_102_1:RecordAudio("107031025", var_105_9)
						arg_102_1:RecordAudio("107031025", var_105_9)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_107031", "107031025", "story_v_out_107031.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_107031", "107031025", "story_v_out_107031.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_10 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_10 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_10

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_10 and arg_102_1.time_ < var_105_0 + var_105_10 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play107031026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 107031026
		arg_106_1.duration_ = 11.5

		local var_106_0 = {
			ja = 7.733,
			ko = 9.2,
			zh = 11.5,
			en = 7.266
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play107031027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 0.95

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_2 = arg_106_1:FormatText(StoryNameCfg[95].name)

				arg_106_1.leftNameTxt_.text = var_109_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_3 = arg_106_1:GetWordFromCfg(107031026)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 39
				local var_109_6 = utf8.len(var_109_4)
				local var_109_7 = var_109_5 <= 0 and var_109_1 or var_109_1 * (var_109_6 / var_109_5)

				if var_109_7 > 0 and var_109_1 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_4
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031026", "story_v_out_107031.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_107031", "107031026", "story_v_out_107031.awb") / 1000

					if var_109_8 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_0
					end

					if var_109_3.prefab_name ~= "" and arg_106_1.actors_[var_109_3.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_3.prefab_name].transform, "story_v_out_107031", "107031026", "story_v_out_107031.awb")

						arg_106_1:RecordAudio("107031026", var_109_9)
						arg_106_1:RecordAudio("107031026", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_107031", "107031026", "story_v_out_107031.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_107031", "107031026", "story_v_out_107031.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_10 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_10 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_10

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_10 and arg_106_1.time_ < var_109_0 + var_109_10 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play107031027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 107031027
		arg_110_1.duration_ = 2.23

		local var_110_0 = {
			ja = 1.266,
			ko = 1.233,
			zh = 2.233,
			en = 1.5
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play107031028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.075

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[74].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_3 = arg_110_1:GetWordFromCfg(107031027)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 3
				local var_113_6 = utf8.len(var_113_4)
				local var_113_7 = var_113_5 <= 0 and var_113_1 or var_113_1 * (var_113_6 / var_113_5)

				if var_113_7 > 0 and var_113_1 < var_113_7 then
					arg_110_1.talkMaxDuration = var_113_7

					if var_113_7 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_4
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031027", "story_v_out_107031.awb") ~= 0 then
					local var_113_8 = manager.audio:GetVoiceLength("story_v_out_107031", "107031027", "story_v_out_107031.awb") / 1000

					if var_113_8 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_0
					end

					if var_113_3.prefab_name ~= "" and arg_110_1.actors_[var_113_3.prefab_name] ~= nil then
						local var_113_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_3.prefab_name].transform, "story_v_out_107031", "107031027", "story_v_out_107031.awb")

						arg_110_1:RecordAudio("107031027", var_113_9)
						arg_110_1:RecordAudio("107031027", var_113_9)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_107031", "107031027", "story_v_out_107031.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_107031", "107031027", "story_v_out_107031.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_10 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_10 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_10

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_10 and arg_110_1.time_ < var_113_0 + var_113_10 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play107031028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 107031028
		arg_114_1.duration_ = 5.1

		local var_114_0 = {
			ja = 5.1,
			ko = 4.833,
			zh = 4,
			en = 5.033
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play107031029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 0.3

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_2 = arg_114_1:FormatText(StoryNameCfg[95].name)

				arg_114_1.leftNameTxt_.text = var_117_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_3 = arg_114_1:GetWordFromCfg(107031028)
				local var_117_4 = arg_114_1:FormatText(var_117_3.content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 12
				local var_117_6 = utf8.len(var_117_4)
				local var_117_7 = var_117_5 <= 0 and var_117_1 or var_117_1 * (var_117_6 / var_117_5)

				if var_117_7 > 0 and var_117_1 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_4
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031028", "story_v_out_107031.awb") ~= 0 then
					local var_117_8 = manager.audio:GetVoiceLength("story_v_out_107031", "107031028", "story_v_out_107031.awb") / 1000

					if var_117_8 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_0
					end

					if var_117_3.prefab_name ~= "" and arg_114_1.actors_[var_117_3.prefab_name] ~= nil then
						local var_117_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_3.prefab_name].transform, "story_v_out_107031", "107031028", "story_v_out_107031.awb")

						arg_114_1:RecordAudio("107031028", var_117_9)
						arg_114_1:RecordAudio("107031028", var_117_9)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_107031", "107031028", "story_v_out_107031.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_107031", "107031028", "story_v_out_107031.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_10 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_10 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_10

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_10 and arg_114_1.time_ < var_117_0 + var_117_10 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play107031029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 107031029
		arg_118_1.duration_ = 10.37

		local var_118_0 = {
			ja = 10.166,
			ko = 8.8,
			zh = 10.366,
			en = 8.666
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
				arg_118_0:Play107031030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 0.875

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_2 = arg_118_1:FormatText(StoryNameCfg[95].name)

				arg_118_1.leftNameTxt_.text = var_121_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_3 = arg_118_1:GetWordFromCfg(107031029)
				local var_121_4 = arg_118_1:FormatText(var_121_3.content)

				arg_118_1.text_.text = var_121_4

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 35
				local var_121_6 = utf8.len(var_121_4)
				local var_121_7 = var_121_5 <= 0 and var_121_1 or var_121_1 * (var_121_6 / var_121_5)

				if var_121_7 > 0 and var_121_1 < var_121_7 then
					arg_118_1.talkMaxDuration = var_121_7

					if var_121_7 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_7 + var_121_0
					end
				end

				arg_118_1.text_.text = var_121_4
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031029", "story_v_out_107031.awb") ~= 0 then
					local var_121_8 = manager.audio:GetVoiceLength("story_v_out_107031", "107031029", "story_v_out_107031.awb") / 1000

					if var_121_8 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_8 + var_121_0
					end

					if var_121_3.prefab_name ~= "" and arg_118_1.actors_[var_121_3.prefab_name] ~= nil then
						local var_121_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_3.prefab_name].transform, "story_v_out_107031", "107031029", "story_v_out_107031.awb")

						arg_118_1:RecordAudio("107031029", var_121_9)
						arg_118_1:RecordAudio("107031029", var_121_9)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_107031", "107031029", "story_v_out_107031.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_107031", "107031029", "story_v_out_107031.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_10 = math.max(var_121_1, arg_118_1.talkMaxDuration)

			if var_121_0 <= arg_118_1.time_ and arg_118_1.time_ < var_121_0 + var_121_10 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_0) / var_121_10

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_0 + var_121_10 and arg_118_1.time_ < var_121_0 + var_121_10 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play107031030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 107031030
		arg_122_1.duration_ = 3.2

		local var_122_0 = {
			ja = 1.2,
			ko = 1.2,
			zh = 3.2,
			en = 1.5
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
				arg_122_0:Play107031031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 0.075

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_2 = arg_122_1:FormatText(StoryNameCfg[74].name)

				arg_122_1.leftNameTxt_.text = var_125_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_3 = arg_122_1:GetWordFromCfg(107031030)
				local var_125_4 = arg_122_1:FormatText(var_125_3.content)

				arg_122_1.text_.text = var_125_4

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 2
				local var_125_6 = utf8.len(var_125_4)
				local var_125_7 = var_125_5 <= 0 and var_125_1 or var_125_1 * (var_125_6 / var_125_5)

				if var_125_7 > 0 and var_125_1 < var_125_7 then
					arg_122_1.talkMaxDuration = var_125_7

					if var_125_7 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_4
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031030", "story_v_out_107031.awb") ~= 0 then
					local var_125_8 = manager.audio:GetVoiceLength("story_v_out_107031", "107031030", "story_v_out_107031.awb") / 1000

					if var_125_8 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_8 + var_125_0
					end

					if var_125_3.prefab_name ~= "" and arg_122_1.actors_[var_125_3.prefab_name] ~= nil then
						local var_125_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_3.prefab_name].transform, "story_v_out_107031", "107031030", "story_v_out_107031.awb")

						arg_122_1:RecordAudio("107031030", var_125_9)
						arg_122_1:RecordAudio("107031030", var_125_9)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_107031", "107031030", "story_v_out_107031.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_107031", "107031030", "story_v_out_107031.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_10 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_0 <= arg_122_1.time_ and arg_122_1.time_ < var_125_0 + var_125_10 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_0) / var_125_10

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_0 + var_125_10 and arg_122_1.time_ < var_125_0 + var_125_10 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play107031031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 107031031
		arg_126_1.duration_ = 7

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play107031032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = "B13"

			if arg_126_1.bgs_[var_129_0] == nil then
				local var_129_1 = Object.Instantiate(arg_126_1.paintGo_)

				var_129_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_129_0)
				var_129_1.name = var_129_0
				var_129_1.transform.parent = arg_126_1.stage_.transform
				var_129_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_126_1.bgs_[var_129_0] = var_129_1
			end

			local var_129_2 = 1.5

			if var_129_2 < arg_126_1.time_ and arg_126_1.time_ <= var_129_2 + arg_129_0 then
				local var_129_3 = manager.ui.mainCamera.transform.localPosition
				local var_129_4 = Vector3.New(0, 0, 10) + Vector3.New(var_129_3.x, var_129_3.y, 0)
				local var_129_5 = arg_126_1.bgs_.B13

				var_129_5.transform.localPosition = var_129_4
				var_129_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_129_6 = var_129_5:GetComponent("SpriteRenderer")

				if var_129_6 and var_129_6.sprite then
					local var_129_7 = (var_129_5.transform.localPosition - var_129_3).z
					local var_129_8 = manager.ui.mainCameraCom_
					local var_129_9 = 2 * var_129_7 * Mathf.Tan(var_129_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_129_10 = var_129_9 * var_129_8.aspect
					local var_129_11 = var_129_6.sprite.bounds.size.x
					local var_129_12 = var_129_6.sprite.bounds.size.y
					local var_129_13 = var_129_10 / var_129_11
					local var_129_14 = var_129_9 / var_129_12
					local var_129_15 = var_129_14 < var_129_13 and var_129_13 or var_129_14

					var_129_5.transform.localScale = Vector3.New(var_129_15, var_129_15, 0)
				end

				for iter_129_0, iter_129_1 in pairs(arg_126_1.bgs_) do
					if iter_129_0 ~= "B13" then
						iter_129_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_129_16 = arg_126_1.bgs_.S0703
			local var_129_17 = 0

			if var_129_17 < arg_126_1.time_ and arg_126_1.time_ <= var_129_17 + arg_129_0 then
				local var_129_18 = var_129_16:GetComponent("SpriteRenderer")

				if var_129_18 then
					arg_126_1.var_.alphaOldValueS0703 = var_129_18.color.a
					arg_126_1.var_.alphaMatValueS0703 = var_129_18
				end

				arg_126_1.var_.alphaOldValueS0703 = 1
			end

			local var_129_19 = 1.5

			if var_129_17 <= arg_126_1.time_ and arg_126_1.time_ < var_129_17 + var_129_19 then
				local var_129_20 = (arg_126_1.time_ - var_129_17) / var_129_19
				local var_129_21 = Mathf.Lerp(arg_126_1.var_.alphaOldValueS0703, 0, var_129_20)

				if arg_126_1.var_.alphaMatValueS0703 then
					local var_129_22 = arg_126_1.var_.alphaMatValueS0703.color

					var_129_22.a = var_129_21
					arg_126_1.var_.alphaMatValueS0703.color = var_129_22
				end
			end

			if arg_126_1.time_ >= var_129_17 + var_129_19 and arg_126_1.time_ < var_129_17 + var_129_19 + arg_129_0 and arg_126_1.var_.alphaMatValueS0703 then
				local var_129_23 = arg_126_1.var_.alphaMatValueS0703
				local var_129_24 = var_129_23.color

				var_129_24.a = 0
				var_129_23.color = var_129_24
			end

			local var_129_25 = arg_126_1.bgs_.B13
			local var_129_26 = 1.5

			if var_129_26 < arg_126_1.time_ and arg_126_1.time_ <= var_129_26 + arg_129_0 then
				local var_129_27 = var_129_25:GetComponent("SpriteRenderer")

				if var_129_27 then
					arg_126_1.var_.alphaOldValueB13 = var_129_27.color.a
					arg_126_1.var_.alphaMatValueB13 = var_129_27
				end

				arg_126_1.var_.alphaOldValueB13 = 0
			end

			local var_129_28 = 1.5

			if var_129_26 <= arg_126_1.time_ and arg_126_1.time_ < var_129_26 + var_129_28 then
				local var_129_29 = (arg_126_1.time_ - var_129_26) / var_129_28
				local var_129_30 = Mathf.Lerp(arg_126_1.var_.alphaOldValueB13, 1, var_129_29)

				if arg_126_1.var_.alphaMatValueB13 then
					local var_129_31 = arg_126_1.var_.alphaMatValueB13.color

					var_129_31.a = var_129_30
					arg_126_1.var_.alphaMatValueB13.color = var_129_31
				end
			end

			if arg_126_1.time_ >= var_129_26 + var_129_28 and arg_126_1.time_ < var_129_26 + var_129_28 + arg_129_0 and arg_126_1.var_.alphaMatValueB13 then
				local var_129_32 = arg_126_1.var_.alphaMatValueB13
				local var_129_33 = var_129_32.color

				var_129_33.a = 1
				var_129_32.color = var_129_33
			end

			local var_129_34 = arg_126_1.bgs_.S0703.transform
			local var_129_35 = 1.5

			if var_129_35 < arg_126_1.time_ and arg_126_1.time_ <= var_129_35 + arg_129_0 then
				arg_126_1.var_.moveOldPosS0703 = var_129_34.localPosition
			end

			local var_129_36 = 0.001

			if var_129_35 <= arg_126_1.time_ and arg_126_1.time_ < var_129_35 + var_129_36 then
				local var_129_37 = (arg_126_1.time_ - var_129_35) / var_129_36
				local var_129_38 = Vector3.New(0, 100, 0)

				var_129_34.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPosS0703, var_129_38, var_129_37)
			end

			if arg_126_1.time_ >= var_129_35 + var_129_36 and arg_126_1.time_ < var_129_35 + var_129_36 + arg_129_0 then
				var_129_34.localPosition = Vector3.New(0, 100, 0)
			end

			local var_129_39 = 1.5

			arg_126_1.isInRecall_ = false

			if var_129_39 < arg_126_1.time_ and arg_126_1.time_ <= var_129_39 + arg_129_0 then
				arg_126_1.screenFilterGo_:SetActive(true)

				arg_126_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_129_2, iter_129_3 in pairs(arg_126_1.actors_) do
					local var_129_40 = iter_129_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_129_4, iter_129_5 in ipairs(var_129_40) do
						if iter_129_5.color.r > 0.51 then
							iter_129_5.color = Color.New(1, 1, 1)
						else
							iter_129_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_129_41 = 1.5

			if var_129_39 <= arg_126_1.time_ and arg_126_1.time_ < var_129_39 + var_129_41 then
				local var_129_42 = (arg_126_1.time_ - var_129_39) / var_129_41

				arg_126_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_129_42)
			end

			if arg_126_1.time_ >= var_129_39 + var_129_41 and arg_126_1.time_ < var_129_39 + var_129_41 + arg_129_0 then
				arg_126_1.screenFilterEffect_.weight = 1
			end

			local var_129_43 = 0

			if var_129_43 < arg_126_1.time_ and arg_126_1.time_ <= var_129_43 + arg_129_0 then
				arg_126_1.allBtn_.enabled = false
			end

			local var_129_44 = 2

			if arg_126_1.time_ >= var_129_43 + var_129_44 and arg_126_1.time_ < var_129_43 + var_129_44 + arg_129_0 then
				arg_126_1.allBtn_.enabled = true
			end

			if arg_126_1.frameCnt_ <= 1 then
				arg_126_1.dialog_:SetActive(false)
			end

			local var_129_45 = 2
			local var_129_46 = 0.25

			if var_129_45 < arg_126_1.time_ and arg_126_1.time_ <= var_129_45 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0

				arg_126_1.dialog_:SetActive(true)

				arg_126_1.dialogCg_.alpha = 0

				local var_129_47 = LeanTween.value(arg_126_1.dialog_, 0, 1, 0.3)

				var_129_47:setOnUpdate(LuaHelper.FloatAction(function(arg_130_0)
					arg_126_1.dialogCg_.alpha = arg_130_0
				end))
				var_129_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_126_1.dialog_)
					var_129_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_126_1.duration_ = arg_126_1.duration_ + 0.3

				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_48 = arg_126_1:GetWordFromCfg(107031031)
				local var_129_49 = arg_126_1:FormatText(var_129_48.content)

				arg_126_1.text_.text = var_129_49

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_50 = 10
				local var_129_51 = utf8.len(var_129_49)
				local var_129_52 = var_129_50 <= 0 and var_129_46 or var_129_46 * (var_129_51 / var_129_50)

				if var_129_52 > 0 and var_129_46 < var_129_52 then
					arg_126_1.talkMaxDuration = var_129_52
					var_129_45 = var_129_45 + 0.3

					if var_129_52 + var_129_45 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_52 + var_129_45
					end
				end

				arg_126_1.text_.text = var_129_49
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_53 = var_129_45 + 0.3
			local var_129_54 = math.max(var_129_46, arg_126_1.talkMaxDuration)

			if var_129_53 <= arg_126_1.time_ and arg_126_1.time_ < var_129_53 + var_129_54 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_53) / var_129_54

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_53 + var_129_54 and arg_126_1.time_ < var_129_53 + var_129_54 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0703",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play107031032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 107031032
		arg_132_1.duration_ = 3.6

		local var_132_0 = {
			ja = 3.6,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play107031033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = "1019ui_story"

			if arg_132_1.actors_[var_135_0] == nil then
				local var_135_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_135_1) then
					local var_135_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_132_1.stage_.transform)

					var_135_2.name = var_135_0
					var_135_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_132_1.actors_[var_135_0] = var_135_2

					local var_135_3 = var_135_2:GetComponentInChildren(typeof(CharacterEffect))

					var_135_3.enabled = true

					local var_135_4 = GameObjectTools.GetOrAddComponent(var_135_2, typeof(DynamicBoneHelper))

					if var_135_4 then
						var_135_4:EnableDynamicBone(false)
					end

					arg_132_1:ShowWeapon(var_135_3.transform, false)

					arg_132_1.var_[var_135_0 .. "Animator"] = var_135_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_132_1.var_[var_135_0 .. "Animator"].applyRootMotion = true
					arg_132_1.var_[var_135_0 .. "LipSync"] = var_135_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_135_5 = arg_132_1.actors_["1019ui_story"]
			local var_135_6 = 0

			if var_135_6 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 and not isNil(var_135_5) and arg_132_1.var_.characterEffect1019ui_story == nil then
				arg_132_1.var_.characterEffect1019ui_story = var_135_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_7 = 0.1

			if var_135_6 <= arg_132_1.time_ and arg_132_1.time_ < var_135_6 + var_135_7 and not isNil(var_135_5) then
				local var_135_8 = (arg_132_1.time_ - var_135_6) / var_135_7

				if arg_132_1.var_.characterEffect1019ui_story and not isNil(var_135_5) then
					arg_132_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_6 + var_135_7 and arg_132_1.time_ < var_135_6 + var_135_7 + arg_135_0 and not isNil(var_135_5) and arg_132_1.var_.characterEffect1019ui_story then
				arg_132_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_135_9 = arg_132_1.actors_["1019ui_story"].transform
			local var_135_10 = 0

			if var_135_10 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 then
				arg_132_1.var_.moveOldPos1019ui_story = var_135_9.localPosition
			end

			local var_135_11 = 0.001

			if var_135_10 <= arg_132_1.time_ and arg_132_1.time_ < var_135_10 + var_135_11 then
				local var_135_12 = (arg_132_1.time_ - var_135_10) / var_135_11
				local var_135_13 = Vector3.New(-0.7, -1.08, -5.9)

				var_135_9.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1019ui_story, var_135_13, var_135_12)

				local var_135_14 = manager.ui.mainCamera.transform.position - var_135_9.position

				var_135_9.forward = Vector3.New(var_135_14.x, var_135_14.y, var_135_14.z)

				local var_135_15 = var_135_9.localEulerAngles

				var_135_15.z = 0
				var_135_15.x = 0
				var_135_9.localEulerAngles = var_135_15
			end

			if arg_132_1.time_ >= var_135_10 + var_135_11 and arg_132_1.time_ < var_135_10 + var_135_11 + arg_135_0 then
				var_135_9.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_135_16 = manager.ui.mainCamera.transform.position - var_135_9.position

				var_135_9.forward = Vector3.New(var_135_16.x, var_135_16.y, var_135_16.z)

				local var_135_17 = var_135_9.localEulerAngles

				var_135_17.z = 0
				var_135_17.x = 0
				var_135_9.localEulerAngles = var_135_17
			end

			local var_135_18 = 0

			if var_135_18 < arg_132_1.time_ and arg_132_1.time_ <= var_135_18 + arg_135_0 then
				arg_132_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_135_19 = 0

			if var_135_19 < arg_132_1.time_ and arg_132_1.time_ <= var_135_19 + arg_135_0 then
				arg_132_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_135_20 = 0
			local var_135_21 = 0.175

			if var_135_20 < arg_132_1.time_ and arg_132_1.time_ <= var_135_20 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_22 = arg_132_1:FormatText(StoryNameCfg[13].name)

				arg_132_1.leftNameTxt_.text = var_135_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_23 = arg_132_1:GetWordFromCfg(107031032)
				local var_135_24 = arg_132_1:FormatText(var_135_23.content)

				arg_132_1.text_.text = var_135_24

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_25 = 7
				local var_135_26 = utf8.len(var_135_24)
				local var_135_27 = var_135_25 <= 0 and var_135_21 or var_135_21 * (var_135_26 / var_135_25)

				if var_135_27 > 0 and var_135_21 < var_135_27 then
					arg_132_1.talkMaxDuration = var_135_27

					if var_135_27 + var_135_20 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_27 + var_135_20
					end
				end

				arg_132_1.text_.text = var_135_24
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031032", "story_v_out_107031.awb") ~= 0 then
					local var_135_28 = manager.audio:GetVoiceLength("story_v_out_107031", "107031032", "story_v_out_107031.awb") / 1000

					if var_135_28 + var_135_20 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_28 + var_135_20
					end

					if var_135_23.prefab_name ~= "" and arg_132_1.actors_[var_135_23.prefab_name] ~= nil then
						local var_135_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_23.prefab_name].transform, "story_v_out_107031", "107031032", "story_v_out_107031.awb")

						arg_132_1:RecordAudio("107031032", var_135_29)
						arg_132_1:RecordAudio("107031032", var_135_29)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_107031", "107031032", "story_v_out_107031.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_107031", "107031032", "story_v_out_107031.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_30 = math.max(var_135_21, arg_132_1.talkMaxDuration)

			if var_135_20 <= arg_132_1.time_ and arg_132_1.time_ < var_135_20 + var_135_30 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_20) / var_135_30

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_20 + var_135_30 and arg_132_1.time_ < var_135_20 + var_135_30 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play107031033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 107031033
		arg_136_1.duration_ = 5.1

		local var_136_0 = {
			ja = 1.999999999999,
			ko = 5.1,
			zh = 4.533,
			en = 4.866
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play107031034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = "1099ui_story"

			if arg_136_1.actors_[var_139_0] == nil then
				local var_139_1 = Asset.Load("Char/" .. "1099ui_story")

				if not isNil(var_139_1) then
					local var_139_2 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_136_1.stage_.transform)

					var_139_2.name = var_139_0
					var_139_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_136_1.actors_[var_139_0] = var_139_2

					local var_139_3 = var_139_2:GetComponentInChildren(typeof(CharacterEffect))

					var_139_3.enabled = true

					local var_139_4 = GameObjectTools.GetOrAddComponent(var_139_2, typeof(DynamicBoneHelper))

					if var_139_4 then
						var_139_4:EnableDynamicBone(false)
					end

					arg_136_1:ShowWeapon(var_139_3.transform, false)

					arg_136_1.var_[var_139_0 .. "Animator"] = var_139_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_136_1.var_[var_139_0 .. "Animator"].applyRootMotion = true
					arg_136_1.var_[var_139_0 .. "LipSync"] = var_139_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_139_5 = arg_136_1.actors_["1099ui_story"]
			local var_139_6 = 0

			if var_139_6 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 and not isNil(var_139_5) and arg_136_1.var_.characterEffect1099ui_story == nil then
				arg_136_1.var_.characterEffect1099ui_story = var_139_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_7 = 0.1

			if var_139_6 <= arg_136_1.time_ and arg_136_1.time_ < var_139_6 + var_139_7 and not isNil(var_139_5) then
				local var_139_8 = (arg_136_1.time_ - var_139_6) / var_139_7

				if arg_136_1.var_.characterEffect1099ui_story and not isNil(var_139_5) then
					arg_136_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_6 + var_139_7 and arg_136_1.time_ < var_139_6 + var_139_7 + arg_139_0 and not isNil(var_139_5) and arg_136_1.var_.characterEffect1099ui_story then
				arg_136_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_139_9 = arg_136_1.actors_["1019ui_story"]
			local var_139_10 = 0

			if var_139_10 < arg_136_1.time_ and arg_136_1.time_ <= var_139_10 + arg_139_0 and not isNil(var_139_9) and arg_136_1.var_.characterEffect1019ui_story == nil then
				arg_136_1.var_.characterEffect1019ui_story = var_139_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_11 = 0.1

			if var_139_10 <= arg_136_1.time_ and arg_136_1.time_ < var_139_10 + var_139_11 and not isNil(var_139_9) then
				local var_139_12 = (arg_136_1.time_ - var_139_10) / var_139_11

				if arg_136_1.var_.characterEffect1019ui_story and not isNil(var_139_9) then
					local var_139_13 = Mathf.Lerp(0, 0.5, var_139_12)

					arg_136_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1019ui_story.fillRatio = var_139_13
				end
			end

			if arg_136_1.time_ >= var_139_10 + var_139_11 and arg_136_1.time_ < var_139_10 + var_139_11 + arg_139_0 and not isNil(var_139_9) and arg_136_1.var_.characterEffect1019ui_story then
				local var_139_14 = 0.5

				arg_136_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1019ui_story.fillRatio = var_139_14
			end

			local var_139_15 = arg_136_1.actors_["1099ui_story"].transform
			local var_139_16 = 0

			if var_139_16 < arg_136_1.time_ and arg_136_1.time_ <= var_139_16 + arg_139_0 then
				arg_136_1.var_.moveOldPos1099ui_story = var_139_15.localPosition
			end

			local var_139_17 = 0.001

			if var_139_16 <= arg_136_1.time_ and arg_136_1.time_ < var_139_16 + var_139_17 then
				local var_139_18 = (arg_136_1.time_ - var_139_16) / var_139_17
				local var_139_19 = Vector3.New(0.7, -1.08, -5.9)

				var_139_15.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1099ui_story, var_139_19, var_139_18)

				local var_139_20 = manager.ui.mainCamera.transform.position - var_139_15.position

				var_139_15.forward = Vector3.New(var_139_20.x, var_139_20.y, var_139_20.z)

				local var_139_21 = var_139_15.localEulerAngles

				var_139_21.z = 0
				var_139_21.x = 0
				var_139_15.localEulerAngles = var_139_21
			end

			if arg_136_1.time_ >= var_139_16 + var_139_17 and arg_136_1.time_ < var_139_16 + var_139_17 + arg_139_0 then
				var_139_15.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_139_22 = manager.ui.mainCamera.transform.position - var_139_15.position

				var_139_15.forward = Vector3.New(var_139_22.x, var_139_22.y, var_139_22.z)

				local var_139_23 = var_139_15.localEulerAngles

				var_139_23.z = 0
				var_139_23.x = 0
				var_139_15.localEulerAngles = var_139_23
			end

			local var_139_24 = 0

			if var_139_24 < arg_136_1.time_ and arg_136_1.time_ <= var_139_24 + arg_139_0 then
				arg_136_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action6_1")
			end

			local var_139_25 = 0

			if var_139_25 < arg_136_1.time_ and arg_136_1.time_ <= var_139_25 + arg_139_0 then
				arg_136_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_139_26 = 0
			local var_139_27 = 0.475

			if var_139_26 < arg_136_1.time_ and arg_136_1.time_ <= var_139_26 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_28 = arg_136_1:FormatText(StoryNameCfg[84].name)

				arg_136_1.leftNameTxt_.text = var_139_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_29 = arg_136_1:GetWordFromCfg(107031033)
				local var_139_30 = arg_136_1:FormatText(var_139_29.content)

				arg_136_1.text_.text = var_139_30

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_31 = 19
				local var_139_32 = utf8.len(var_139_30)
				local var_139_33 = var_139_31 <= 0 and var_139_27 or var_139_27 * (var_139_32 / var_139_31)

				if var_139_33 > 0 and var_139_27 < var_139_33 then
					arg_136_1.talkMaxDuration = var_139_33

					if var_139_33 + var_139_26 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_33 + var_139_26
					end
				end

				arg_136_1.text_.text = var_139_30
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031033", "story_v_out_107031.awb") ~= 0 then
					local var_139_34 = manager.audio:GetVoiceLength("story_v_out_107031", "107031033", "story_v_out_107031.awb") / 1000

					if var_139_34 + var_139_26 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_34 + var_139_26
					end

					if var_139_29.prefab_name ~= "" and arg_136_1.actors_[var_139_29.prefab_name] ~= nil then
						local var_139_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_29.prefab_name].transform, "story_v_out_107031", "107031033", "story_v_out_107031.awb")

						arg_136_1:RecordAudio("107031033", var_139_35)
						arg_136_1:RecordAudio("107031033", var_139_35)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_107031", "107031033", "story_v_out_107031.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_107031", "107031033", "story_v_out_107031.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_36 = math.max(var_139_27, arg_136_1.talkMaxDuration)

			if var_139_26 <= arg_136_1.time_ and arg_136_1.time_ < var_139_26 + var_139_36 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_26) / var_139_36

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_26 + var_139_36 and arg_136_1.time_ < var_139_26 + var_139_36 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play107031034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 107031034
		arg_140_1.duration_ = 11.2

		local var_140_0 = {
			ja = 11.2,
			ko = 6.566,
			zh = 7.3,
			en = 9.733
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play107031035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1019ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1019ui_story == nil then
				arg_140_1.var_.characterEffect1019ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.1

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect1019ui_story and not isNil(var_143_0) then
					arg_140_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1019ui_story then
				arg_140_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_143_4 = arg_140_1.actors_["1099ui_story"]
			local var_143_5 = 0

			if var_143_5 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 and not isNil(var_143_4) and arg_140_1.var_.characterEffect1099ui_story == nil then
				arg_140_1.var_.characterEffect1099ui_story = var_143_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_6 = 0.1

			if var_143_5 <= arg_140_1.time_ and arg_140_1.time_ < var_143_5 + var_143_6 and not isNil(var_143_4) then
				local var_143_7 = (arg_140_1.time_ - var_143_5) / var_143_6

				if arg_140_1.var_.characterEffect1099ui_story and not isNil(var_143_4) then
					local var_143_8 = Mathf.Lerp(0, 0.5, var_143_7)

					arg_140_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1099ui_story.fillRatio = var_143_8
				end
			end

			if arg_140_1.time_ >= var_143_5 + var_143_6 and arg_140_1.time_ < var_143_5 + var_143_6 + arg_143_0 and not isNil(var_143_4) and arg_140_1.var_.characterEffect1099ui_story then
				local var_143_9 = 0.5

				arg_140_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1099ui_story.fillRatio = var_143_9
			end

			local var_143_10 = 0

			if var_143_10 < arg_140_1.time_ and arg_140_1.time_ <= var_143_10 + arg_143_0 then
				arg_140_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_143_11 = 0
			local var_143_12 = 0.8

			if var_143_11 < arg_140_1.time_ and arg_140_1.time_ <= var_143_11 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_13 = arg_140_1:FormatText(StoryNameCfg[13].name)

				arg_140_1.leftNameTxt_.text = var_143_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_14 = arg_140_1:GetWordFromCfg(107031034)
				local var_143_15 = arg_140_1:FormatText(var_143_14.content)

				arg_140_1.text_.text = var_143_15

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_16 = 32
				local var_143_17 = utf8.len(var_143_15)
				local var_143_18 = var_143_16 <= 0 and var_143_12 or var_143_12 * (var_143_17 / var_143_16)

				if var_143_18 > 0 and var_143_12 < var_143_18 then
					arg_140_1.talkMaxDuration = var_143_18

					if var_143_18 + var_143_11 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_18 + var_143_11
					end
				end

				arg_140_1.text_.text = var_143_15
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031034", "story_v_out_107031.awb") ~= 0 then
					local var_143_19 = manager.audio:GetVoiceLength("story_v_out_107031", "107031034", "story_v_out_107031.awb") / 1000

					if var_143_19 + var_143_11 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_19 + var_143_11
					end

					if var_143_14.prefab_name ~= "" and arg_140_1.actors_[var_143_14.prefab_name] ~= nil then
						local var_143_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_14.prefab_name].transform, "story_v_out_107031", "107031034", "story_v_out_107031.awb")

						arg_140_1:RecordAudio("107031034", var_143_20)
						arg_140_1:RecordAudio("107031034", var_143_20)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_107031", "107031034", "story_v_out_107031.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_107031", "107031034", "story_v_out_107031.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_21 = math.max(var_143_12, arg_140_1.talkMaxDuration)

			if var_143_11 <= arg_140_1.time_ and arg_140_1.time_ < var_143_11 + var_143_21 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_11) / var_143_21

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_11 + var_143_21 and arg_140_1.time_ < var_143_11 + var_143_21 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play107031035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 107031035
		arg_144_1.duration_ = 2.83

		local var_144_0 = {
			ja = 1.2,
			ko = 1.1,
			zh = 2.833,
			en = 1.033
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play107031036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1099ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1099ui_story == nil then
				arg_144_1.var_.characterEffect1099ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.1

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect1099ui_story and not isNil(var_147_0) then
					arg_144_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1099ui_story then
				arg_144_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_147_4 = arg_144_1.actors_["1019ui_story"]
			local var_147_5 = 0

			if var_147_5 < arg_144_1.time_ and arg_144_1.time_ <= var_147_5 + arg_147_0 and not isNil(var_147_4) and arg_144_1.var_.characterEffect1019ui_story == nil then
				arg_144_1.var_.characterEffect1019ui_story = var_147_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_6 = 0.1

			if var_147_5 <= arg_144_1.time_ and arg_144_1.time_ < var_147_5 + var_147_6 and not isNil(var_147_4) then
				local var_147_7 = (arg_144_1.time_ - var_147_5) / var_147_6

				if arg_144_1.var_.characterEffect1019ui_story and not isNil(var_147_4) then
					local var_147_8 = Mathf.Lerp(0, 0.5, var_147_7)

					arg_144_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1019ui_story.fillRatio = var_147_8
				end
			end

			if arg_144_1.time_ >= var_147_5 + var_147_6 and arg_144_1.time_ < var_147_5 + var_147_6 + arg_147_0 and not isNil(var_147_4) and arg_144_1.var_.characterEffect1019ui_story then
				local var_147_9 = 0.5

				arg_144_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1019ui_story.fillRatio = var_147_9
			end

			local var_147_10 = 0

			if var_147_10 < arg_144_1.time_ and arg_144_1.time_ <= var_147_10 + arg_147_0 then
				arg_144_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_147_11 = 0
			local var_147_12 = 0.05

			if var_147_11 < arg_144_1.time_ and arg_144_1.time_ <= var_147_11 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_13 = arg_144_1:FormatText(StoryNameCfg[84].name)

				arg_144_1.leftNameTxt_.text = var_147_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_14 = arg_144_1:GetWordFromCfg(107031035)
				local var_147_15 = arg_144_1:FormatText(var_147_14.content)

				arg_144_1.text_.text = var_147_15

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_16 = 2
				local var_147_17 = utf8.len(var_147_15)
				local var_147_18 = var_147_16 <= 0 and var_147_12 or var_147_12 * (var_147_17 / var_147_16)

				if var_147_18 > 0 and var_147_12 < var_147_18 then
					arg_144_1.talkMaxDuration = var_147_18

					if var_147_18 + var_147_11 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_18 + var_147_11
					end
				end

				arg_144_1.text_.text = var_147_15
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031035", "story_v_out_107031.awb") ~= 0 then
					local var_147_19 = manager.audio:GetVoiceLength("story_v_out_107031", "107031035", "story_v_out_107031.awb") / 1000

					if var_147_19 + var_147_11 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_19 + var_147_11
					end

					if var_147_14.prefab_name ~= "" and arg_144_1.actors_[var_147_14.prefab_name] ~= nil then
						local var_147_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_14.prefab_name].transform, "story_v_out_107031", "107031035", "story_v_out_107031.awb")

						arg_144_1:RecordAudio("107031035", var_147_20)
						arg_144_1:RecordAudio("107031035", var_147_20)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_107031", "107031035", "story_v_out_107031.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_107031", "107031035", "story_v_out_107031.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_21 = math.max(var_147_12, arg_144_1.talkMaxDuration)

			if var_147_11 <= arg_144_1.time_ and arg_144_1.time_ < var_147_11 + var_147_21 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_11) / var_147_21

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_11 + var_147_21 and arg_144_1.time_ < var_147_11 + var_147_21 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play107031036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 107031036
		arg_148_1.duration_ = 4.17

		local var_148_0 = {
			ja = 1.366,
			ko = 3.166,
			zh = 4.166,
			en = 3.833
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play107031037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_151_1 = 0
			local var_151_2 = 0.35

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_3 = arg_148_1:FormatText(StoryNameCfg[84].name)

				arg_148_1.leftNameTxt_.text = var_151_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_4 = arg_148_1:GetWordFromCfg(107031036)
				local var_151_5 = arg_148_1:FormatText(var_151_4.content)

				arg_148_1.text_.text = var_151_5

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_6 = 14
				local var_151_7 = utf8.len(var_151_5)
				local var_151_8 = var_151_6 <= 0 and var_151_2 or var_151_2 * (var_151_7 / var_151_6)

				if var_151_8 > 0 and var_151_2 < var_151_8 then
					arg_148_1.talkMaxDuration = var_151_8

					if var_151_8 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_8 + var_151_1
					end
				end

				arg_148_1.text_.text = var_151_5
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031036", "story_v_out_107031.awb") ~= 0 then
					local var_151_9 = manager.audio:GetVoiceLength("story_v_out_107031", "107031036", "story_v_out_107031.awb") / 1000

					if var_151_9 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_9 + var_151_1
					end

					if var_151_4.prefab_name ~= "" and arg_148_1.actors_[var_151_4.prefab_name] ~= nil then
						local var_151_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_4.prefab_name].transform, "story_v_out_107031", "107031036", "story_v_out_107031.awb")

						arg_148_1:RecordAudio("107031036", var_151_10)
						arg_148_1:RecordAudio("107031036", var_151_10)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_107031", "107031036", "story_v_out_107031.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_107031", "107031036", "story_v_out_107031.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_11 = math.max(var_151_2, arg_148_1.talkMaxDuration)

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_11 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_1) / var_151_11

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_1 + var_151_11 and arg_148_1.time_ < var_151_1 + var_151_11 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play107031037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 107031037
		arg_152_1.duration_ = 3.97

		local var_152_0 = {
			ja = 3.4,
			ko = 2.266,
			zh = 3.966,
			en = 3.066
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play107031038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1019ui_story"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1019ui_story == nil then
				arg_152_1.var_.characterEffect1019ui_story = var_155_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.1

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.characterEffect1019ui_story and not isNil(var_155_0) then
					arg_152_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1019ui_story then
				arg_152_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_155_4 = arg_152_1.actors_["1099ui_story"]
			local var_155_5 = 0

			if var_155_5 < arg_152_1.time_ and arg_152_1.time_ <= var_155_5 + arg_155_0 and not isNil(var_155_4) and arg_152_1.var_.characterEffect1099ui_story == nil then
				arg_152_1.var_.characterEffect1099ui_story = var_155_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_6 = 0.1

			if var_155_5 <= arg_152_1.time_ and arg_152_1.time_ < var_155_5 + var_155_6 and not isNil(var_155_4) then
				local var_155_7 = (arg_152_1.time_ - var_155_5) / var_155_6

				if arg_152_1.var_.characterEffect1099ui_story and not isNil(var_155_4) then
					local var_155_8 = Mathf.Lerp(0, 0.5, var_155_7)

					arg_152_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_152_1.var_.characterEffect1099ui_story.fillRatio = var_155_8
				end
			end

			if arg_152_1.time_ >= var_155_5 + var_155_6 and arg_152_1.time_ < var_155_5 + var_155_6 + arg_155_0 and not isNil(var_155_4) and arg_152_1.var_.characterEffect1099ui_story then
				local var_155_9 = 0.5

				arg_152_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_152_1.var_.characterEffect1099ui_story.fillRatio = var_155_9
			end

			local var_155_10 = 0

			if var_155_10 < arg_152_1.time_ and arg_152_1.time_ <= var_155_10 + arg_155_0 then
				arg_152_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_155_11 = 0
			local var_155_12 = 0.375

			if var_155_11 < arg_152_1.time_ and arg_152_1.time_ <= var_155_11 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_13 = arg_152_1:FormatText(StoryNameCfg[13].name)

				arg_152_1.leftNameTxt_.text = var_155_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_14 = arg_152_1:GetWordFromCfg(107031037)
				local var_155_15 = arg_152_1:FormatText(var_155_14.content)

				arg_152_1.text_.text = var_155_15

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_16 = 15
				local var_155_17 = utf8.len(var_155_15)
				local var_155_18 = var_155_16 <= 0 and var_155_12 or var_155_12 * (var_155_17 / var_155_16)

				if var_155_18 > 0 and var_155_12 < var_155_18 then
					arg_152_1.talkMaxDuration = var_155_18

					if var_155_18 + var_155_11 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_18 + var_155_11
					end
				end

				arg_152_1.text_.text = var_155_15
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031037", "story_v_out_107031.awb") ~= 0 then
					local var_155_19 = manager.audio:GetVoiceLength("story_v_out_107031", "107031037", "story_v_out_107031.awb") / 1000

					if var_155_19 + var_155_11 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_19 + var_155_11
					end

					if var_155_14.prefab_name ~= "" and arg_152_1.actors_[var_155_14.prefab_name] ~= nil then
						local var_155_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_14.prefab_name].transform, "story_v_out_107031", "107031037", "story_v_out_107031.awb")

						arg_152_1:RecordAudio("107031037", var_155_20)
						arg_152_1:RecordAudio("107031037", var_155_20)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_107031", "107031037", "story_v_out_107031.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_107031", "107031037", "story_v_out_107031.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_21 = math.max(var_155_12, arg_152_1.talkMaxDuration)

			if var_155_11 <= arg_152_1.time_ and arg_152_1.time_ < var_155_11 + var_155_21 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_11) / var_155_21

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_11 + var_155_21 and arg_152_1.time_ < var_155_11 + var_155_21 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play107031038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 107031038
		arg_156_1.duration_ = 5.77

		local var_156_0 = {
			ja = 5.766,
			ko = 4.066,
			zh = 4.566,
			en = 5
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play107031039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1099ui_story"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1099ui_story == nil then
				arg_156_1.var_.characterEffect1099ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.1

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect1099ui_story and not isNil(var_159_0) then
					arg_156_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1099ui_story then
				arg_156_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_159_4 = arg_156_1.actors_["1019ui_story"]
			local var_159_5 = 0

			if var_159_5 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.characterEffect1019ui_story == nil then
				arg_156_1.var_.characterEffect1019ui_story = var_159_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_6 = 0.1

			if var_159_5 <= arg_156_1.time_ and arg_156_1.time_ < var_159_5 + var_159_6 and not isNil(var_159_4) then
				local var_159_7 = (arg_156_1.time_ - var_159_5) / var_159_6

				if arg_156_1.var_.characterEffect1019ui_story and not isNil(var_159_4) then
					local var_159_8 = Mathf.Lerp(0, 0.5, var_159_7)

					arg_156_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1019ui_story.fillRatio = var_159_8
				end
			end

			if arg_156_1.time_ >= var_159_5 + var_159_6 and arg_156_1.time_ < var_159_5 + var_159_6 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.characterEffect1019ui_story then
				local var_159_9 = 0.5

				arg_156_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1019ui_story.fillRatio = var_159_9
			end

			local var_159_10 = 0

			if var_159_10 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 then
				arg_156_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_159_11 = 0
			local var_159_12 = 0.475

			if var_159_11 < arg_156_1.time_ and arg_156_1.time_ <= var_159_11 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_13 = arg_156_1:FormatText(StoryNameCfg[84].name)

				arg_156_1.leftNameTxt_.text = var_159_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_14 = arg_156_1:GetWordFromCfg(107031038)
				local var_159_15 = arg_156_1:FormatText(var_159_14.content)

				arg_156_1.text_.text = var_159_15

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_16 = 19
				local var_159_17 = utf8.len(var_159_15)
				local var_159_18 = var_159_16 <= 0 and var_159_12 or var_159_12 * (var_159_17 / var_159_16)

				if var_159_18 > 0 and var_159_12 < var_159_18 then
					arg_156_1.talkMaxDuration = var_159_18

					if var_159_18 + var_159_11 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_18 + var_159_11
					end
				end

				arg_156_1.text_.text = var_159_15
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031038", "story_v_out_107031.awb") ~= 0 then
					local var_159_19 = manager.audio:GetVoiceLength("story_v_out_107031", "107031038", "story_v_out_107031.awb") / 1000

					if var_159_19 + var_159_11 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_19 + var_159_11
					end

					if var_159_14.prefab_name ~= "" and arg_156_1.actors_[var_159_14.prefab_name] ~= nil then
						local var_159_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_14.prefab_name].transform, "story_v_out_107031", "107031038", "story_v_out_107031.awb")

						arg_156_1:RecordAudio("107031038", var_159_20)
						arg_156_1:RecordAudio("107031038", var_159_20)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_107031", "107031038", "story_v_out_107031.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_107031", "107031038", "story_v_out_107031.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_21 = math.max(var_159_12, arg_156_1.talkMaxDuration)

			if var_159_11 <= arg_156_1.time_ and arg_156_1.time_ < var_159_11 + var_159_21 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_11) / var_159_21

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_11 + var_159_21 and arg_156_1.time_ < var_159_11 + var_159_21 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play107031039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 107031039
		arg_160_1.duration_ = 2.1

		local var_160_0 = {
			ja = 1.766,
			ko = 1.566,
			zh = 2.1,
			en = 1.2
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play107031040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1099ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1099ui_story == nil then
				arg_160_1.var_.characterEffect1099ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.1

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect1099ui_story and not isNil(var_163_0) then
					local var_163_4 = Mathf.Lerp(0, 0.5, var_163_3)

					arg_160_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1099ui_story.fillRatio = var_163_4
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1099ui_story then
				local var_163_5 = 0.5

				arg_160_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1099ui_story.fillRatio = var_163_5
			end

			local var_163_6 = 0
			local var_163_7 = 0.1

			if var_163_6 < arg_160_1.time_ and arg_160_1.time_ <= var_163_6 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_8 = arg_160_1:FormatText(StoryNameCfg[74].name)

				arg_160_1.leftNameTxt_.text = var_163_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_9 = arg_160_1:GetWordFromCfg(107031039)
				local var_163_10 = arg_160_1:FormatText(var_163_9.content)

				arg_160_1.text_.text = var_163_10

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_11 = 4
				local var_163_12 = utf8.len(var_163_10)
				local var_163_13 = var_163_11 <= 0 and var_163_7 or var_163_7 * (var_163_12 / var_163_11)

				if var_163_13 > 0 and var_163_7 < var_163_13 then
					arg_160_1.talkMaxDuration = var_163_13

					if var_163_13 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_13 + var_163_6
					end
				end

				arg_160_1.text_.text = var_163_10
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031039", "story_v_out_107031.awb") ~= 0 then
					local var_163_14 = manager.audio:GetVoiceLength("story_v_out_107031", "107031039", "story_v_out_107031.awb") / 1000

					if var_163_14 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_14 + var_163_6
					end

					if var_163_9.prefab_name ~= "" and arg_160_1.actors_[var_163_9.prefab_name] ~= nil then
						local var_163_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_9.prefab_name].transform, "story_v_out_107031", "107031039", "story_v_out_107031.awb")

						arg_160_1:RecordAudio("107031039", var_163_15)
						arg_160_1:RecordAudio("107031039", var_163_15)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_107031", "107031039", "story_v_out_107031.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_107031", "107031039", "story_v_out_107031.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_16 = math.max(var_163_7, arg_160_1.talkMaxDuration)

			if var_163_6 <= arg_160_1.time_ and arg_160_1.time_ < var_163_6 + var_163_16 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_6) / var_163_16

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_6 + var_163_16 and arg_160_1.time_ < var_163_6 + var_163_16 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play107031040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 107031040
		arg_164_1.duration_ = 10.27

		local var_164_0 = {
			ja = 8.466,
			ko = 6.5,
			zh = 6.966,
			en = 10.266
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
				arg_164_0:Play107031041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1019ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1019ui_story == nil then
				arg_164_1.var_.characterEffect1019ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.1

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect1019ui_story and not isNil(var_167_0) then
					arg_164_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1019ui_story then
				arg_164_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_167_4 = 0

			if var_167_4 < arg_164_1.time_ and arg_164_1.time_ <= var_167_4 + arg_167_0 then
				arg_164_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			local var_167_5 = 0

			if var_167_5 < arg_164_1.time_ and arg_164_1.time_ <= var_167_5 + arg_167_0 then
				arg_164_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_167_6 = 0
			local var_167_7 = 0.8

			if var_167_6 < arg_164_1.time_ and arg_164_1.time_ <= var_167_6 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_8 = arg_164_1:FormatText(StoryNameCfg[13].name)

				arg_164_1.leftNameTxt_.text = var_167_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_9 = arg_164_1:GetWordFromCfg(107031040)
				local var_167_10 = arg_164_1:FormatText(var_167_9.content)

				arg_164_1.text_.text = var_167_10

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_11 = 32
				local var_167_12 = utf8.len(var_167_10)
				local var_167_13 = var_167_11 <= 0 and var_167_7 or var_167_7 * (var_167_12 / var_167_11)

				if var_167_13 > 0 and var_167_7 < var_167_13 then
					arg_164_1.talkMaxDuration = var_167_13

					if var_167_13 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_13 + var_167_6
					end
				end

				arg_164_1.text_.text = var_167_10
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031040", "story_v_out_107031.awb") ~= 0 then
					local var_167_14 = manager.audio:GetVoiceLength("story_v_out_107031", "107031040", "story_v_out_107031.awb") / 1000

					if var_167_14 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_14 + var_167_6
					end

					if var_167_9.prefab_name ~= "" and arg_164_1.actors_[var_167_9.prefab_name] ~= nil then
						local var_167_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_9.prefab_name].transform, "story_v_out_107031", "107031040", "story_v_out_107031.awb")

						arg_164_1:RecordAudio("107031040", var_167_15)
						arg_164_1:RecordAudio("107031040", var_167_15)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_107031", "107031040", "story_v_out_107031.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_107031", "107031040", "story_v_out_107031.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_16 = math.max(var_167_7, arg_164_1.talkMaxDuration)

			if var_167_6 <= arg_164_1.time_ and arg_164_1.time_ < var_167_6 + var_167_16 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_6) / var_167_16

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_6 + var_167_16 and arg_164_1.time_ < var_167_6 + var_167_16 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play107031041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 107031041
		arg_168_1.duration_ = 5.9

		local var_168_0 = {
			ja = 1.8,
			ko = 3.666,
			zh = 5.9,
			en = 4.6
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play107031042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1019ui_story"].transform
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.var_.moveOldPos1019ui_story = var_171_0.localPosition
			end

			local var_171_2 = 0.001

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2
				local var_171_4 = Vector3.New(0, 100, 0)

				var_171_0.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1019ui_story, var_171_4, var_171_3)

				local var_171_5 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_5.x, var_171_5.y, var_171_5.z)

				local var_171_6 = var_171_0.localEulerAngles

				var_171_6.z = 0
				var_171_6.x = 0
				var_171_0.localEulerAngles = var_171_6
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 then
				var_171_0.localPosition = Vector3.New(0, 100, 0)

				local var_171_7 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_7.x, var_171_7.y, var_171_7.z)

				local var_171_8 = var_171_0.localEulerAngles

				var_171_8.z = 0
				var_171_8.x = 0
				var_171_0.localEulerAngles = var_171_8
			end

			local var_171_9 = arg_168_1.actors_["1099ui_story"].transform
			local var_171_10 = 0

			if var_171_10 < arg_168_1.time_ and arg_168_1.time_ <= var_171_10 + arg_171_0 then
				arg_168_1.var_.moveOldPos1099ui_story = var_171_9.localPosition
			end

			local var_171_11 = 0.001

			if var_171_10 <= arg_168_1.time_ and arg_168_1.time_ < var_171_10 + var_171_11 then
				local var_171_12 = (arg_168_1.time_ - var_171_10) / var_171_11
				local var_171_13 = Vector3.New(0, 100, 0)

				var_171_9.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1099ui_story, var_171_13, var_171_12)

				local var_171_14 = manager.ui.mainCamera.transform.position - var_171_9.position

				var_171_9.forward = Vector3.New(var_171_14.x, var_171_14.y, var_171_14.z)

				local var_171_15 = var_171_9.localEulerAngles

				var_171_15.z = 0
				var_171_15.x = 0
				var_171_9.localEulerAngles = var_171_15
			end

			if arg_168_1.time_ >= var_171_10 + var_171_11 and arg_168_1.time_ < var_171_10 + var_171_11 + arg_171_0 then
				var_171_9.localPosition = Vector3.New(0, 100, 0)

				local var_171_16 = manager.ui.mainCamera.transform.position - var_171_9.position

				var_171_9.forward = Vector3.New(var_171_16.x, var_171_16.y, var_171_16.z)

				local var_171_17 = var_171_9.localEulerAngles

				var_171_17.z = 0
				var_171_17.x = 0
				var_171_9.localEulerAngles = var_171_17
			end

			local var_171_18 = 0

			if var_171_18 < arg_168_1.time_ and arg_168_1.time_ <= var_171_18 + arg_171_0 then
				arg_168_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_171_19 = 0
			local var_171_20 = 0.325

			if var_171_19 < arg_168_1.time_ and arg_168_1.time_ <= var_171_19 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_21 = arg_168_1:FormatText(StoryNameCfg[74].name)

				arg_168_1.leftNameTxt_.text = var_171_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_22 = arg_168_1:GetWordFromCfg(107031041)
				local var_171_23 = arg_168_1:FormatText(var_171_22.content)

				arg_168_1.text_.text = var_171_23

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_24 = 13
				local var_171_25 = utf8.len(var_171_23)
				local var_171_26 = var_171_24 <= 0 and var_171_20 or var_171_20 * (var_171_25 / var_171_24)

				if var_171_26 > 0 and var_171_20 < var_171_26 then
					arg_168_1.talkMaxDuration = var_171_26

					if var_171_26 + var_171_19 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_26 + var_171_19
					end
				end

				arg_168_1.text_.text = var_171_23
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031041", "story_v_out_107031.awb") ~= 0 then
					local var_171_27 = manager.audio:GetVoiceLength("story_v_out_107031", "107031041", "story_v_out_107031.awb") / 1000

					if var_171_27 + var_171_19 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_27 + var_171_19
					end

					if var_171_22.prefab_name ~= "" and arg_168_1.actors_[var_171_22.prefab_name] ~= nil then
						local var_171_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_22.prefab_name].transform, "story_v_out_107031", "107031041", "story_v_out_107031.awb")

						arg_168_1:RecordAudio("107031041", var_171_28)
						arg_168_1:RecordAudio("107031041", var_171_28)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_107031", "107031041", "story_v_out_107031.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_107031", "107031041", "story_v_out_107031.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_29 = math.max(var_171_20, arg_168_1.talkMaxDuration)

			if var_171_19 <= arg_168_1.time_ and arg_168_1.time_ < var_171_19 + var_171_29 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_19) / var_171_29

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_19 + var_171_29 and arg_168_1.time_ < var_171_19 + var_171_29 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play107031042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 107031042
		arg_172_1.duration_ = 5.23

		local var_172_0 = {
			ja = 5.233,
			ko = 2.433,
			zh = 4.2,
			en = 3.566
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play107031043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_175_1 = 0
			local var_175_2 = 0.3

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_3 = arg_172_1:FormatText(StoryNameCfg[74].name)

				arg_172_1.leftNameTxt_.text = var_175_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_4 = arg_172_1:GetWordFromCfg(107031042)
				local var_175_5 = arg_172_1:FormatText(var_175_4.content)

				arg_172_1.text_.text = var_175_5

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_6 = 12
				local var_175_7 = utf8.len(var_175_5)
				local var_175_8 = var_175_6 <= 0 and var_175_2 or var_175_2 * (var_175_7 / var_175_6)

				if var_175_8 > 0 and var_175_2 < var_175_8 then
					arg_172_1.talkMaxDuration = var_175_8

					if var_175_8 + var_175_1 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_8 + var_175_1
					end
				end

				arg_172_1.text_.text = var_175_5
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031042", "story_v_out_107031.awb") ~= 0 then
					local var_175_9 = manager.audio:GetVoiceLength("story_v_out_107031", "107031042", "story_v_out_107031.awb") / 1000

					if var_175_9 + var_175_1 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_9 + var_175_1
					end

					if var_175_4.prefab_name ~= "" and arg_172_1.actors_[var_175_4.prefab_name] ~= nil then
						local var_175_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_4.prefab_name].transform, "story_v_out_107031", "107031042", "story_v_out_107031.awb")

						arg_172_1:RecordAudio("107031042", var_175_10)
						arg_172_1:RecordAudio("107031042", var_175_10)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_107031", "107031042", "story_v_out_107031.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_107031", "107031042", "story_v_out_107031.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_11 = math.max(var_175_2, arg_172_1.talkMaxDuration)

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_11 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_1) / var_175_11

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_1 + var_175_11 and arg_172_1.time_ < var_175_1 + var_175_11 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play107031043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 107031043
		arg_176_1.duration_ = 13.3

		local var_176_0 = {
			ja = 13.2993333333333,
			ko = 10.6663333333333,
			zh = 10.6663333333333,
			en = 10.2993333333333
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play107031044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 1.5

			if var_179_0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				local var_179_1 = manager.ui.mainCamera.transform.localPosition
				local var_179_2 = Vector3.New(0, 0, 10) + Vector3.New(var_179_1.x, var_179_1.y, 0)
				local var_179_3 = arg_176_1.bgs_.S0703

				var_179_3.transform.localPosition = var_179_2
				var_179_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_179_4 = var_179_3:GetComponent("SpriteRenderer")

				if var_179_4 and var_179_4.sprite then
					local var_179_5 = (var_179_3.transform.localPosition - var_179_1).z
					local var_179_6 = manager.ui.mainCameraCom_
					local var_179_7 = 2 * var_179_5 * Mathf.Tan(var_179_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_179_8 = var_179_7 * var_179_6.aspect
					local var_179_9 = var_179_4.sprite.bounds.size.x
					local var_179_10 = var_179_4.sprite.bounds.size.y
					local var_179_11 = var_179_8 / var_179_9
					local var_179_12 = var_179_7 / var_179_10
					local var_179_13 = var_179_12 < var_179_11 and var_179_11 or var_179_12

					var_179_3.transform.localScale = Vector3.New(var_179_13, var_179_13, 0)
				end

				for iter_179_0, iter_179_1 in pairs(arg_176_1.bgs_) do
					if iter_179_0 ~= "S0703" then
						iter_179_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_179_14 = arg_176_1.bgs_.B13
			local var_179_15 = 0

			if var_179_15 < arg_176_1.time_ and arg_176_1.time_ <= var_179_15 + arg_179_0 then
				local var_179_16 = var_179_14:GetComponent("SpriteRenderer")

				if var_179_16 then
					arg_176_1.var_.alphaOldValueB13 = var_179_16.color.a
					arg_176_1.var_.alphaMatValueB13 = var_179_16
				end

				arg_176_1.var_.alphaOldValueB13 = 1
			end

			local var_179_17 = 1.5

			if var_179_15 <= arg_176_1.time_ and arg_176_1.time_ < var_179_15 + var_179_17 then
				local var_179_18 = (arg_176_1.time_ - var_179_15) / var_179_17
				local var_179_19 = Mathf.Lerp(arg_176_1.var_.alphaOldValueB13, 0, var_179_18)

				if arg_176_1.var_.alphaMatValueB13 then
					local var_179_20 = arg_176_1.var_.alphaMatValueB13.color

					var_179_20.a = var_179_19
					arg_176_1.var_.alphaMatValueB13.color = var_179_20
				end
			end

			if arg_176_1.time_ >= var_179_15 + var_179_17 and arg_176_1.time_ < var_179_15 + var_179_17 + arg_179_0 and arg_176_1.var_.alphaMatValueB13 then
				local var_179_21 = arg_176_1.var_.alphaMatValueB13
				local var_179_22 = var_179_21.color

				var_179_22.a = 0
				var_179_21.color = var_179_22
			end

			local var_179_23 = arg_176_1.bgs_.S0703
			local var_179_24 = 1.5

			if var_179_24 < arg_176_1.time_ and arg_176_1.time_ <= var_179_24 + arg_179_0 then
				local var_179_25 = var_179_23:GetComponent("SpriteRenderer")

				if var_179_25 then
					arg_176_1.var_.alphaOldValueS0703 = var_179_25.color.a
					arg_176_1.var_.alphaMatValueS0703 = var_179_25
				end

				arg_176_1.var_.alphaOldValueS0703 = 0
			end

			local var_179_26 = 1.5

			if var_179_24 <= arg_176_1.time_ and arg_176_1.time_ < var_179_24 + var_179_26 then
				local var_179_27 = (arg_176_1.time_ - var_179_24) / var_179_26
				local var_179_28 = Mathf.Lerp(arg_176_1.var_.alphaOldValueS0703, 1, var_179_27)

				if arg_176_1.var_.alphaMatValueS0703 then
					local var_179_29 = arg_176_1.var_.alphaMatValueS0703.color

					var_179_29.a = var_179_28
					arg_176_1.var_.alphaMatValueS0703.color = var_179_29
				end
			end

			if arg_176_1.time_ >= var_179_24 + var_179_26 and arg_176_1.time_ < var_179_24 + var_179_26 + arg_179_0 and arg_176_1.var_.alphaMatValueS0703 then
				local var_179_30 = arg_176_1.var_.alphaMatValueS0703
				local var_179_31 = var_179_30.color

				var_179_31.a = 1
				var_179_30.color = var_179_31
			end

			local var_179_32 = 1.5

			arg_176_1.isInRecall_ = false

			if var_179_32 < arg_176_1.time_ and arg_176_1.time_ <= var_179_32 + arg_179_0 then
				arg_176_1.screenFilterGo_:SetActive(false)

				for iter_179_2, iter_179_3 in pairs(arg_176_1.actors_) do
					local var_179_33 = iter_179_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_179_4, iter_179_5 in ipairs(var_179_33) do
						if iter_179_5.color.r > 0.51 then
							iter_179_5.color = Color.New(1, 1, 1)
						else
							iter_179_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_179_34 = 0.0333333333333333

			if var_179_32 <= arg_176_1.time_ and arg_176_1.time_ < var_179_32 + var_179_34 then
				local var_179_35 = (arg_176_1.time_ - var_179_32) / var_179_34

				arg_176_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_179_35)
			end

			if arg_176_1.time_ >= var_179_32 + var_179_34 and arg_176_1.time_ < var_179_32 + var_179_34 + arg_179_0 then
				arg_176_1.screenFilterEffect_.weight = 0
			end

			local var_179_36 = 0

			if var_179_36 < arg_176_1.time_ and arg_176_1.time_ <= var_179_36 + arg_179_0 then
				arg_176_1.allBtn_.enabled = false
			end

			local var_179_37 = 2.53333333333333

			if arg_176_1.time_ >= var_179_36 + var_179_37 and arg_176_1.time_ < var_179_36 + var_179_37 + arg_179_0 then
				arg_176_1.allBtn_.enabled = true
			end

			local var_179_38 = 2.53333333333333
			local var_179_39 = 0.975

			if var_179_38 < arg_176_1.time_ and arg_176_1.time_ <= var_179_38 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_40 = arg_176_1:FormatText(StoryNameCfg[95].name)

				arg_176_1.leftNameTxt_.text = var_179_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_41 = arg_176_1:GetWordFromCfg(107031043)
				local var_179_42 = arg_176_1:FormatText(var_179_41.content)

				arg_176_1.text_.text = var_179_42

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_43 = 39
				local var_179_44 = utf8.len(var_179_42)
				local var_179_45 = var_179_43 <= 0 and var_179_39 or var_179_39 * (var_179_44 / var_179_43)

				if var_179_45 > 0 and var_179_39 < var_179_45 then
					arg_176_1.talkMaxDuration = var_179_45

					if var_179_45 + var_179_38 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_45 + var_179_38
					end
				end

				arg_176_1.text_.text = var_179_42
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031043", "story_v_out_107031.awb") ~= 0 then
					local var_179_46 = manager.audio:GetVoiceLength("story_v_out_107031", "107031043", "story_v_out_107031.awb") / 1000

					if var_179_46 + var_179_38 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_46 + var_179_38
					end

					if var_179_41.prefab_name ~= "" and arg_176_1.actors_[var_179_41.prefab_name] ~= nil then
						local var_179_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_41.prefab_name].transform, "story_v_out_107031", "107031043", "story_v_out_107031.awb")

						arg_176_1:RecordAudio("107031043", var_179_47)
						arg_176_1:RecordAudio("107031043", var_179_47)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_107031", "107031043", "story_v_out_107031.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_107031", "107031043", "story_v_out_107031.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_48 = math.max(var_179_39, arg_176_1.talkMaxDuration)

			if var_179_38 <= arg_176_1.time_ and arg_176_1.time_ < var_179_38 + var_179_48 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_38) / var_179_48

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_38 + var_179_48 and arg_176_1.time_ < var_179_38 + var_179_48 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play107031044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 107031044
		arg_180_1.duration_ = 4.07

		local var_180_0 = {
			ja = 3.8,
			ko = 3.966,
			zh = 4.066,
			en = 3.133
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play107031045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0

			if var_183_0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_183_1 = 0
			local var_183_2 = 0.275

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_3 = arg_180_1:FormatText(StoryNameCfg[74].name)

				arg_180_1.leftNameTxt_.text = var_183_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_4 = arg_180_1:GetWordFromCfg(107031044)
				local var_183_5 = arg_180_1:FormatText(var_183_4.content)

				arg_180_1.text_.text = var_183_5

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_6 = 11
				local var_183_7 = utf8.len(var_183_5)
				local var_183_8 = var_183_6 <= 0 and var_183_2 or var_183_2 * (var_183_7 / var_183_6)

				if var_183_8 > 0 and var_183_2 < var_183_8 then
					arg_180_1.talkMaxDuration = var_183_8

					if var_183_8 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_8 + var_183_1
					end
				end

				arg_180_1.text_.text = var_183_5
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031044", "story_v_out_107031.awb") ~= 0 then
					local var_183_9 = manager.audio:GetVoiceLength("story_v_out_107031", "107031044", "story_v_out_107031.awb") / 1000

					if var_183_9 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_9 + var_183_1
					end

					if var_183_4.prefab_name ~= "" and arg_180_1.actors_[var_183_4.prefab_name] ~= nil then
						local var_183_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_4.prefab_name].transform, "story_v_out_107031", "107031044", "story_v_out_107031.awb")

						arg_180_1:RecordAudio("107031044", var_183_10)
						arg_180_1:RecordAudio("107031044", var_183_10)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_107031", "107031044", "story_v_out_107031.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_107031", "107031044", "story_v_out_107031.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_11 = math.max(var_183_2, arg_180_1.talkMaxDuration)

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_11 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_1) / var_183_11

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_1 + var_183_11 and arg_180_1.time_ < var_183_1 + var_183_11 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play107031045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 107031045
		arg_184_1.duration_ = 6.87

		local var_184_0 = {
			ja = 6.2,
			ko = 4.166,
			zh = 6.866,
			en = 4.8
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play107031046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0
			local var_187_1 = 0.5

			if var_187_0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_2 = arg_184_1:FormatText(StoryNameCfg[95].name)

				arg_184_1.leftNameTxt_.text = var_187_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_3 = arg_184_1:GetWordFromCfg(107031045)
				local var_187_4 = arg_184_1:FormatText(var_187_3.content)

				arg_184_1.text_.text = var_187_4

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_5 = 20
				local var_187_6 = utf8.len(var_187_4)
				local var_187_7 = var_187_5 <= 0 and var_187_1 or var_187_1 * (var_187_6 / var_187_5)

				if var_187_7 > 0 and var_187_1 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_0
					end
				end

				arg_184_1.text_.text = var_187_4
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031045", "story_v_out_107031.awb") ~= 0 then
					local var_187_8 = manager.audio:GetVoiceLength("story_v_out_107031", "107031045", "story_v_out_107031.awb") / 1000

					if var_187_8 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_0
					end

					if var_187_3.prefab_name ~= "" and arg_184_1.actors_[var_187_3.prefab_name] ~= nil then
						local var_187_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_3.prefab_name].transform, "story_v_out_107031", "107031045", "story_v_out_107031.awb")

						arg_184_1:RecordAudio("107031045", var_187_9)
						arg_184_1:RecordAudio("107031045", var_187_9)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_107031", "107031045", "story_v_out_107031.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_107031", "107031045", "story_v_out_107031.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_10 = math.max(var_187_1, arg_184_1.talkMaxDuration)

			if var_187_0 <= arg_184_1.time_ and arg_184_1.time_ < var_187_0 + var_187_10 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_0) / var_187_10

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_0 + var_187_10 and arg_184_1.time_ < var_187_0 + var_187_10 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play107031046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 107031046
		arg_188_1.duration_ = 4.73

		local var_188_0 = {
			ja = 2.533,
			ko = 1.566,
			zh = 4.733,
			en = 1.533
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
			arg_188_1.auto_ = false
		end

		function arg_188_1.playNext_(arg_190_0)
			arg_188_1.onStoryFinished_()
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_191_1 = 0
			local var_191_2 = 0.175

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_3 = arg_188_1:FormatText(StoryNameCfg[74].name)

				arg_188_1.leftNameTxt_.text = var_191_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_4 = arg_188_1:GetWordFromCfg(107031046)
				local var_191_5 = arg_188_1:FormatText(var_191_4.content)

				arg_188_1.text_.text = var_191_5

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_6 = 7
				local var_191_7 = utf8.len(var_191_5)
				local var_191_8 = var_191_6 <= 0 and var_191_2 or var_191_2 * (var_191_7 / var_191_6)

				if var_191_8 > 0 and var_191_2 < var_191_8 then
					arg_188_1.talkMaxDuration = var_191_8

					if var_191_8 + var_191_1 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_8 + var_191_1
					end
				end

				arg_188_1.text_.text = var_191_5
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107031", "107031046", "story_v_out_107031.awb") ~= 0 then
					local var_191_9 = manager.audio:GetVoiceLength("story_v_out_107031", "107031046", "story_v_out_107031.awb") / 1000

					if var_191_9 + var_191_1 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_9 + var_191_1
					end

					if var_191_4.prefab_name ~= "" and arg_188_1.actors_[var_191_4.prefab_name] ~= nil then
						local var_191_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_4.prefab_name].transform, "story_v_out_107031", "107031046", "story_v_out_107031.awb")

						arg_188_1:RecordAudio("107031046", var_191_10)
						arg_188_1:RecordAudio("107031046", var_191_10)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_107031", "107031046", "story_v_out_107031.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_107031", "107031046", "story_v_out_107031.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_11 = math.max(var_191_2, arg_188_1.talkMaxDuration)

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_11 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_1) / var_191_11

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_1 + var_191_11 and arg_188_1.time_ < var_191_1 + var_191_11 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C04a",
		"TextureConfig/Background/S0703",
		"TextureConfig/Background/B13"
	},
	voices = {
		"story_v_out_107031.awb"
	}
}
