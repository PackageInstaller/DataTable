return {
	Play120141001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 120141001
		arg_1_1.duration_ = 9.47

		local var_1_0 = {
			zh = 9.033,
			ja = 9.466
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
				arg_1_0:Play120141002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J04f"

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
				local var_4_5 = arg_1_1.bgs_.J04f

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
					if iter_4_0 ~= "J04f" then
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

			local var_4_22 = "1071ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "1071ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_1_1.stage_.transform)

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

			local var_4_27 = arg_1_1.actors_["1071ui_story"].transform
			local var_4_28 = 2

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos1071ui_story = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(0, -1.05, -6.2)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1071ui_story, var_4_31, var_4_30)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_27.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_27.localEulerAngles = var_4_33
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_27.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_27.localEulerAngles = var_4_35
			end

			local var_4_36 = arg_1_1.actors_["1071ui_story"]
			local var_4_37 = 2

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1071ui_story == nil then
				arg_1_1.var_.characterEffect1071ui_story = var_4_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_38 = 0.2

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 and not isNil(var_4_36) then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38

				if arg_1_1.var_.characterEffect1071ui_story and not isNil(var_4_36) then
					arg_1_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1071ui_story then
				arg_1_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_4_40 = 2

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_4_41 = 0

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_4_42 = 0
			local var_4_43 = 0.2

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

			local var_4_48 = 0.566666666666667
			local var_4_49 = 1

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "music"

				arg_1_1:AudioAction(var_4_50, var_4_51, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_52 = ""
				local var_4_53 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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
			local var_4_55 = 0.625

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

				local var_4_57 = arg_1_1:FormatText(StoryNameCfg[384].name)

				arg_1_1.leftNameTxt_.text = var_4_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_58 = arg_1_1:GetWordFromCfg(120141001)
				local var_4_59 = arg_1_1:FormatText(var_4_58.content)

				arg_1_1.text_.text = var_4_59

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_60 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141001", "story_v_out_120141.awb") ~= 0 then
					local var_4_63 = manager.audio:GetVoiceLength("story_v_out_120141", "120141001", "story_v_out_120141.awb") / 1000

					if var_4_63 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_63 + var_4_54
					end

					if var_4_58.prefab_name ~= "" and arg_1_1.actors_[var_4_58.prefab_name] ~= nil then
						local var_4_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_58.prefab_name].transform, "story_v_out_120141", "120141001", "story_v_out_120141.awb")

						arg_1_1:RecordAudio("120141001", var_4_64)
						arg_1_1:RecordAudio("120141001", var_4_64)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_120141", "120141001", "story_v_out_120141.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_120141", "120141001", "story_v_out_120141.awb")
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
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play120141002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 120141002
		arg_9_1.duration_ = 5.6

		local var_9_0 = {
			zh = 5.233,
			ja = 5.6
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
				arg_9_0:Play120141003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_12_1 = 0
			local var_12_2 = 0.575

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_3 = arg_9_1:FormatText(StoryNameCfg[384].name)

				arg_9_1.leftNameTxt_.text = var_12_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_4 = arg_9_1:GetWordFromCfg(120141002)
				local var_12_5 = arg_9_1:FormatText(var_12_4.content)

				arg_9_1.text_.text = var_12_5

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_6 = 23
				local var_12_7 = utf8.len(var_12_5)
				local var_12_8 = var_12_6 <= 0 and var_12_2 or var_12_2 * (var_12_7 / var_12_6)

				if var_12_8 > 0 and var_12_2 < var_12_8 then
					arg_9_1.talkMaxDuration = var_12_8

					if var_12_8 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_5
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141002", "story_v_out_120141.awb") ~= 0 then
					local var_12_9 = manager.audio:GetVoiceLength("story_v_out_120141", "120141002", "story_v_out_120141.awb") / 1000

					if var_12_9 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_9 + var_12_1
					end

					if var_12_4.prefab_name ~= "" and arg_9_1.actors_[var_12_4.prefab_name] ~= nil then
						local var_12_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_4.prefab_name].transform, "story_v_out_120141", "120141002", "story_v_out_120141.awb")

						arg_9_1:RecordAudio("120141002", var_12_10)
						arg_9_1:RecordAudio("120141002", var_12_10)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_120141", "120141002", "story_v_out_120141.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_120141", "120141002", "story_v_out_120141.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_11 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_11 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_11

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_11 and arg_9_1.time_ < var_12_1 + var_12_11 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play120141003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 120141003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play120141004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1071ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1071ui_story == nil then
				arg_13_1.var_.characterEffect1071ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1071ui_story and not isNil(var_16_0) then
					local var_16_4 = Mathf.Lerp(0, 0.5, var_16_3)

					arg_13_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1071ui_story.fillRatio = var_16_4
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1071ui_story then
				local var_16_5 = 0.5

				arg_13_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1071ui_story.fillRatio = var_16_5
			end

			local var_16_6 = 0
			local var_16_7 = 0.825

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_8 = arg_13_1:GetWordFromCfg(120141003)
				local var_16_9 = arg_13_1:FormatText(var_16_8.content)

				arg_13_1.text_.text = var_16_9

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 33
				local var_16_11 = utf8.len(var_16_9)
				local var_16_12 = var_16_10 <= 0 and var_16_7 or var_16_7 * (var_16_11 / var_16_10)

				if var_16_12 > 0 and var_16_7 < var_16_12 then
					arg_13_1.talkMaxDuration = var_16_12

					if var_16_12 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_12 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_9
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_13 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_13 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_13

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_13 and arg_13_1.time_ < var_16_6 + var_16_13 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play120141004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 120141004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play120141005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1071ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1071ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, 100, 0)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1071ui_story, var_20_4, var_20_3)

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
			local var_20_10 = 0.55

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

				local var_20_11 = arg_17_1:GetWordFromCfg(120141004)
				local var_20_12 = arg_17_1:FormatText(var_20_11.content)

				arg_17_1.text_.text = var_20_12

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 22
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
				actorName = "1071ui_story",
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
	Play120141005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 120141005
		arg_21_1.duration_ = 6.23

		local var_21_0 = {
			zh = 6.233,
			ja = 4.533
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
				arg_21_0:Play120141006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "1075ui_story"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Char/" .. "1075ui_story")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_21_1.stage_.transform)

					var_24_2.name = var_24_0
					var_24_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_0] = var_24_2

					local var_24_3 = var_24_2:GetComponentInChildren(typeof(CharacterEffect))

					var_24_3.enabled = true

					local var_24_4 = GameObjectTools.GetOrAddComponent(var_24_2, typeof(DynamicBoneHelper))

					if var_24_4 then
						var_24_4:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_3.transform, false)

					arg_21_1.var_[var_24_0 .. "Animator"] = var_24_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_0 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_0 .. "LipSync"] = var_24_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_5 = arg_21_1.actors_["1075ui_story"]
			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1075ui_story == nil then
				arg_21_1.var_.characterEffect1075ui_story = var_24_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_7 = 0.2

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_7 and not isNil(var_24_5) then
				local var_24_8 = (arg_21_1.time_ - var_24_6) / var_24_7

				if arg_21_1.var_.characterEffect1075ui_story and not isNil(var_24_5) then
					arg_21_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_6 + var_24_7 and arg_21_1.time_ < var_24_6 + var_24_7 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1075ui_story then
				arg_21_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				arg_21_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_24_11 = arg_21_1.actors_["1075ui_story"].transform
			local var_24_12 = 0

			if var_24_12 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 then
				arg_21_1.var_.moveOldPos1075ui_story = var_24_11.localPosition
			end

			local var_24_13 = 0.001

			if var_24_12 <= arg_21_1.time_ and arg_21_1.time_ < var_24_12 + var_24_13 then
				local var_24_14 = (arg_21_1.time_ - var_24_12) / var_24_13
				local var_24_15 = Vector3.New(0, -1.055, -6.16)

				var_24_11.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1075ui_story, var_24_15, var_24_14)

				local var_24_16 = manager.ui.mainCamera.transform.position - var_24_11.position

				var_24_11.forward = Vector3.New(var_24_16.x, var_24_16.y, var_24_16.z)

				local var_24_17 = var_24_11.localEulerAngles

				var_24_17.z = 0
				var_24_17.x = 0
				var_24_11.localEulerAngles = var_24_17
			end

			if arg_21_1.time_ >= var_24_12 + var_24_13 and arg_21_1.time_ < var_24_12 + var_24_13 + arg_24_0 then
				var_24_11.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_24_18 = manager.ui.mainCamera.transform.position - var_24_11.position

				var_24_11.forward = Vector3.New(var_24_18.x, var_24_18.y, var_24_18.z)

				local var_24_19 = var_24_11.localEulerAngles

				var_24_19.z = 0
				var_24_19.x = 0
				var_24_11.localEulerAngles = var_24_19
			end

			local var_24_20 = 0
			local var_24_21 = 0.775

			if var_24_20 < arg_21_1.time_ and arg_21_1.time_ <= var_24_20 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_22 = arg_21_1:FormatText(StoryNameCfg[381].name)

				arg_21_1.leftNameTxt_.text = var_24_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_23 = arg_21_1:GetWordFromCfg(120141005)
				local var_24_24 = arg_21_1:FormatText(var_24_23.content)

				arg_21_1.text_.text = var_24_24

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_25 = 31
				local var_24_26 = utf8.len(var_24_24)
				local var_24_27 = var_24_25 <= 0 and var_24_21 or var_24_21 * (var_24_26 / var_24_25)

				if var_24_27 > 0 and var_24_21 < var_24_27 then
					arg_21_1.talkMaxDuration = var_24_27

					if var_24_27 + var_24_20 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_27 + var_24_20
					end
				end

				arg_21_1.text_.text = var_24_24
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141005", "story_v_out_120141.awb") ~= 0 then
					local var_24_28 = manager.audio:GetVoiceLength("story_v_out_120141", "120141005", "story_v_out_120141.awb") / 1000

					if var_24_28 + var_24_20 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_28 + var_24_20
					end

					if var_24_23.prefab_name ~= "" and arg_21_1.actors_[var_24_23.prefab_name] ~= nil then
						local var_24_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_23.prefab_name].transform, "story_v_out_120141", "120141005", "story_v_out_120141.awb")

						arg_21_1:RecordAudio("120141005", var_24_29)
						arg_21_1:RecordAudio("120141005", var_24_29)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_120141", "120141005", "story_v_out_120141.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_120141", "120141005", "story_v_out_120141.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_30 = math.max(var_24_21, arg_21_1.talkMaxDuration)

			if var_24_20 <= arg_21_1.time_ and arg_21_1.time_ < var_24_20 + var_24_30 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_20) / var_24_30

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_20 + var_24_30 and arg_21_1.time_ < var_24_20 + var_24_30 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play120141006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 120141006
		arg_25_1.duration_ = 11.03

		local var_25_0 = {
			zh = 4.833,
			ja = 11.033
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
				arg_25_0:Play120141007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "10044ui_story"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Char/" .. "10044ui_story")

				if not isNil(var_28_1) then
					local var_28_2 = Object.Instantiate(Asset.Load("Char/" .. "10044ui_story"), arg_25_1.stage_.transform)

					var_28_2.name = var_28_0
					var_28_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_25_1.actors_[var_28_0] = var_28_2

					local var_28_3 = var_28_2:GetComponentInChildren(typeof(CharacterEffect))

					var_28_3.enabled = true

					local var_28_4 = GameObjectTools.GetOrAddComponent(var_28_2, typeof(DynamicBoneHelper))

					if var_28_4 then
						var_28_4:EnableDynamicBone(false)
					end

					arg_25_1:ShowWeapon(var_28_3.transform, false)

					arg_25_1.var_[var_28_0 .. "Animator"] = var_28_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_25_1.var_[var_28_0 .. "Animator"].applyRootMotion = true
					arg_25_1.var_[var_28_0 .. "LipSync"] = var_28_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_28_5 = arg_25_1.actors_["10044ui_story"]
			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect10044ui_story == nil then
				arg_25_1.var_.characterEffect10044ui_story = var_28_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_7 = 0.2

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_7 and not isNil(var_28_5) then
				local var_28_8 = (arg_25_1.time_ - var_28_6) / var_28_7

				if arg_25_1.var_.characterEffect10044ui_story and not isNil(var_28_5) then
					arg_25_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_6 + var_28_7 and arg_25_1.time_ < var_28_6 + var_28_7 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect10044ui_story then
				arg_25_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_28_9 = 0

			if var_28_9 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 then
				arg_25_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_28_10 = arg_25_1.actors_["10044ui_story"].transform
			local var_28_11 = 0

			if var_28_11 < arg_25_1.time_ and arg_25_1.time_ <= var_28_11 + arg_28_0 then
				arg_25_1.var_.moveOldPos10044ui_story = var_28_10.localPosition
			end

			local var_28_12 = 0.001

			if var_28_11 <= arg_25_1.time_ and arg_25_1.time_ < var_28_11 + var_28_12 then
				local var_28_13 = (arg_25_1.time_ - var_28_11) / var_28_12
				local var_28_14 = Vector3.New(0, -0.72, -6.3)

				var_28_10.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10044ui_story, var_28_14, var_28_13)

				local var_28_15 = manager.ui.mainCamera.transform.position - var_28_10.position

				var_28_10.forward = Vector3.New(var_28_15.x, var_28_15.y, var_28_15.z)

				local var_28_16 = var_28_10.localEulerAngles

				var_28_16.z = 0
				var_28_16.x = 0
				var_28_10.localEulerAngles = var_28_16
			end

			if arg_25_1.time_ >= var_28_11 + var_28_12 and arg_25_1.time_ < var_28_11 + var_28_12 + arg_28_0 then
				var_28_10.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_28_17 = manager.ui.mainCamera.transform.position - var_28_10.position

				var_28_10.forward = Vector3.New(var_28_17.x, var_28_17.y, var_28_17.z)

				local var_28_18 = var_28_10.localEulerAngles

				var_28_18.z = 0
				var_28_18.x = 0
				var_28_10.localEulerAngles = var_28_18
			end

			local var_28_19 = arg_25_1.actors_["1075ui_story"].transform
			local var_28_20 = 0

			if var_28_20 < arg_25_1.time_ and arg_25_1.time_ <= var_28_20 + arg_28_0 then
				arg_25_1.var_.moveOldPos1075ui_story = var_28_19.localPosition
			end

			local var_28_21 = 0.001

			if var_28_20 <= arg_25_1.time_ and arg_25_1.time_ < var_28_20 + var_28_21 then
				local var_28_22 = (arg_25_1.time_ - var_28_20) / var_28_21
				local var_28_23 = Vector3.New(0, 100, 0)

				var_28_19.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1075ui_story, var_28_23, var_28_22)

				local var_28_24 = manager.ui.mainCamera.transform.position - var_28_19.position

				var_28_19.forward = Vector3.New(var_28_24.x, var_28_24.y, var_28_24.z)

				local var_28_25 = var_28_19.localEulerAngles

				var_28_25.z = 0
				var_28_25.x = 0
				var_28_19.localEulerAngles = var_28_25
			end

			if arg_25_1.time_ >= var_28_20 + var_28_21 and arg_25_1.time_ < var_28_20 + var_28_21 + arg_28_0 then
				var_28_19.localPosition = Vector3.New(0, 100, 0)

				local var_28_26 = manager.ui.mainCamera.transform.position - var_28_19.position

				var_28_19.forward = Vector3.New(var_28_26.x, var_28_26.y, var_28_26.z)

				local var_28_27 = var_28_19.localEulerAngles

				var_28_27.z = 0
				var_28_27.x = 0
				var_28_19.localEulerAngles = var_28_27
			end

			local var_28_28 = 0

			if var_28_28 < arg_25_1.time_ and arg_25_1.time_ <= var_28_28 + arg_28_0 then
				arg_25_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_28_29 = 0
			local var_28_30 = 0.325

			if var_28_29 < arg_25_1.time_ and arg_25_1.time_ <= var_28_29 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_31 = arg_25_1:FormatText(StoryNameCfg[387].name)

				arg_25_1.leftNameTxt_.text = var_28_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_32 = arg_25_1:GetWordFromCfg(120141006)
				local var_28_33 = arg_25_1:FormatText(var_28_32.content)

				arg_25_1.text_.text = var_28_33

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_34 = 13
				local var_28_35 = utf8.len(var_28_33)
				local var_28_36 = var_28_34 <= 0 and var_28_30 or var_28_30 * (var_28_35 / var_28_34)

				if var_28_36 > 0 and var_28_30 < var_28_36 then
					arg_25_1.talkMaxDuration = var_28_36

					if var_28_36 + var_28_29 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_36 + var_28_29
					end
				end

				arg_25_1.text_.text = var_28_33
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141006", "story_v_out_120141.awb") ~= 0 then
					local var_28_37 = manager.audio:GetVoiceLength("story_v_out_120141", "120141006", "story_v_out_120141.awb") / 1000

					if var_28_37 + var_28_29 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_37 + var_28_29
					end

					if var_28_32.prefab_name ~= "" and arg_25_1.actors_[var_28_32.prefab_name] ~= nil then
						local var_28_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_32.prefab_name].transform, "story_v_out_120141", "120141006", "story_v_out_120141.awb")

						arg_25_1:RecordAudio("120141006", var_28_38)
						arg_25_1:RecordAudio("120141006", var_28_38)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_120141", "120141006", "story_v_out_120141.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_120141", "120141006", "story_v_out_120141.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_39 = math.max(var_28_30, arg_25_1.talkMaxDuration)

			if var_28_29 <= arg_25_1.time_ and arg_25_1.time_ < var_28_29 + var_28_39 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_29) / var_28_39

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_29 + var_28_39 and arg_25_1.time_ < var_28_29 + var_28_39 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
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
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play120141007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 120141007
		arg_29_1.duration_ = 6.2

		local var_29_0 = {
			zh = 4.933,
			ja = 6.2
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
				arg_29_0:Play120141008(arg_29_1)
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
				local var_32_4 = Vector3.New(0, 100, 0)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10044ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, 100, 0)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = 0
			local var_32_10 = 0.5

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_11 = arg_29_1:FormatText(StoryNameCfg[384].name)

				arg_29_1.leftNameTxt_.text = var_32_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_12 = arg_29_1:GetWordFromCfg(120141007)
				local var_32_13 = arg_29_1:FormatText(var_32_12.content)

				arg_29_1.text_.text = var_32_13

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_14 = 20
				local var_32_15 = utf8.len(var_32_13)
				local var_32_16 = var_32_14 <= 0 and var_32_10 or var_32_10 * (var_32_15 / var_32_14)

				if var_32_16 > 0 and var_32_10 < var_32_16 then
					arg_29_1.talkMaxDuration = var_32_16

					if var_32_16 + var_32_9 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_16 + var_32_9
					end
				end

				arg_29_1.text_.text = var_32_13
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141007", "story_v_out_120141.awb") ~= 0 then
					local var_32_17 = manager.audio:GetVoiceLength("story_v_out_120141", "120141007", "story_v_out_120141.awb") / 1000

					if var_32_17 + var_32_9 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_17 + var_32_9
					end

					if var_32_12.prefab_name ~= "" and arg_29_1.actors_[var_32_12.prefab_name] ~= nil then
						local var_32_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_12.prefab_name].transform, "story_v_out_120141", "120141007", "story_v_out_120141.awb")

						arg_29_1:RecordAudio("120141007", var_32_18)
						arg_29_1:RecordAudio("120141007", var_32_18)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_120141", "120141007", "story_v_out_120141.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_120141", "120141007", "story_v_out_120141.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_19 = math.max(var_32_10, arg_29_1.talkMaxDuration)

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_19 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_9) / var_32_19

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_9 + var_32_19 and arg_29_1.time_ < var_32_9 + var_32_19 + arg_32_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play120141008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 120141008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play120141009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.925

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

				local var_36_2 = arg_33_1:GetWordFromCfg(120141008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 37
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
	Play120141009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 120141009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play120141010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_1 = 2

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_1 then
				local var_40_2 = (arg_37_1.time_ - var_40_0) / var_40_1
				local var_40_3 = Color.New(0.9245283, 0.4055395, 0.1700783)

				var_40_3.a = Mathf.Lerp(1, 0, var_40_2)
				arg_37_1.mask_.color = var_40_3
			end

			if arg_37_1.time_ >= var_40_0 + var_40_1 and arg_37_1.time_ < var_40_0 + var_40_1 + arg_40_0 then
				local var_40_4 = Color.New(0.9245283, 0.4055395, 0.1700783)
				local var_40_5 = 0

				arg_37_1.mask_.enabled = false
				var_40_4.a = var_40_5
				arg_37_1.mask_.color = var_40_4
			end

			local var_40_6 = 0
			local var_40_7 = 1

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				local var_40_8 = "play"
				local var_40_9 = "effect"

				arg_37_1:AudioAction(var_40_8, var_40_9, "se_story_120_00", "se_story_120_00_lingguang03", "")
			end

			local var_40_10 = manager.ui.mainCamera.transform
			local var_40_11 = 0

			if var_40_11 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1.var_.shakeOldPos = var_40_10.localPosition
			end

			local var_40_12 = 1

			if var_40_11 <= arg_37_1.time_ and arg_37_1.time_ < var_40_11 + var_40_12 then
				local var_40_13 = (arg_37_1.time_ - var_40_11) / 0.066
				local var_40_14, var_40_15 = math.modf(var_40_13)

				var_40_10.localPosition = Vector3.New(var_40_15 * 0.13, var_40_15 * 0.13, var_40_15 * 0.13) + arg_37_1.var_.shakeOldPos
			end

			if arg_37_1.time_ >= var_40_11 + var_40_12 and arg_37_1.time_ < var_40_11 + var_40_12 + arg_40_0 then
				var_40_10.localPosition = arg_37_1.var_.shakeOldPos
			end

			local var_40_16 = 0
			local var_40_17 = 0.775

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_18 = arg_37_1:GetWordFromCfg(120141009)
				local var_40_19 = arg_37_1:FormatText(var_40_18.content)

				arg_37_1.text_.text = var_40_19

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 31
				local var_40_21 = utf8.len(var_40_19)
				local var_40_22 = var_40_20 <= 0 and var_40_17 or var_40_17 * (var_40_21 / var_40_20)

				if var_40_22 > 0 and var_40_17 < var_40_22 then
					arg_37_1.talkMaxDuration = var_40_22

					if var_40_22 + var_40_16 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_22 + var_40_16
					end
				end

				arg_37_1.text_.text = var_40_19
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_23 = math.max(var_40_17, arg_37_1.talkMaxDuration)

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_23 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_16) / var_40_23

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_16 + var_40_23 and arg_37_1.time_ < var_40_16 + var_40_23 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play120141010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 120141010
		arg_41_1.duration_ = 1.1

		local var_41_0 = {
			zh = 1.066,
			ja = 1.1
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
				arg_41_0:Play120141011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = manager.ui.mainCamera.transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.shakeOldPos = var_44_0.localPosition
			end

			local var_44_2 = 0.6

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / 0.066
				local var_44_4, var_44_5 = math.modf(var_44_3)

				var_44_0.localPosition = Vector3.New(var_44_5 * 0.13, var_44_5 * 0.13, var_44_5 * 0.13) + arg_41_1.var_.shakeOldPos
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = arg_41_1.var_.shakeOldPos
			end

			local var_44_6 = 0

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.allBtn_.enabled = false
			end

			local var_44_7 = 0.6

			if arg_41_1.time_ >= var_44_6 + var_44_7 and arg_41_1.time_ < var_44_6 + var_44_7 + arg_44_0 then
				arg_41_1.allBtn_.enabled = true
			end

			local var_44_8 = 0
			local var_44_9 = 0.075

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_10 = arg_41_1:FormatText(StoryNameCfg[387].name)

				arg_41_1.leftNameTxt_.text = var_44_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10044")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_11 = arg_41_1:GetWordFromCfg(120141010)
				local var_44_12 = arg_41_1:FormatText(var_44_11.content)

				arg_41_1.text_.text = var_44_12

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 3
				local var_44_14 = utf8.len(var_44_12)
				local var_44_15 = var_44_13 <= 0 and var_44_9 or var_44_9 * (var_44_14 / var_44_13)

				if var_44_15 > 0 and var_44_9 < var_44_15 then
					arg_41_1.talkMaxDuration = var_44_15

					if var_44_15 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_15 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_12
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141010", "story_v_out_120141.awb") ~= 0 then
					local var_44_16 = manager.audio:GetVoiceLength("story_v_out_120141", "120141010", "story_v_out_120141.awb") / 1000

					if var_44_16 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_16 + var_44_8
					end

					if var_44_11.prefab_name ~= "" and arg_41_1.actors_[var_44_11.prefab_name] ~= nil then
						local var_44_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_11.prefab_name].transform, "story_v_out_120141", "120141010", "story_v_out_120141.awb")

						arg_41_1:RecordAudio("120141010", var_44_17)
						arg_41_1:RecordAudio("120141010", var_44_17)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_120141", "120141010", "story_v_out_120141.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_120141", "120141010", "story_v_out_120141.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_18 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_18 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_18

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_18 and arg_41_1.time_ < var_44_8 + var_44_18 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play120141011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 120141011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play120141012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10044ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos10044ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0, 100, 0)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10044ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0, 100, 0)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = 0
			local var_48_10 = 0.95

			if var_48_9 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_11 = arg_45_1:GetWordFromCfg(120141011)
				local var_48_12 = arg_45_1:FormatText(var_48_11.content)

				arg_45_1.text_.text = var_48_12

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_13 = 38
				local var_48_14 = utf8.len(var_48_12)
				local var_48_15 = var_48_13 <= 0 and var_48_10 or var_48_10 * (var_48_14 / var_48_13)

				if var_48_15 > 0 and var_48_10 < var_48_15 then
					arg_45_1.talkMaxDuration = var_48_15

					if var_48_15 + var_48_9 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_15 + var_48_9
					end
				end

				arg_45_1.text_.text = var_48_12
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_10, arg_45_1.talkMaxDuration)

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_9) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_9 + var_48_16 and arg_45_1.time_ < var_48_9 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play120141012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 120141012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play120141013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = manager.ui.mainCamera.transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.shakeOldPos = var_52_0.localPosition
			end

			local var_52_2 = 0.75

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / 0.066
				local var_52_4, var_52_5 = math.modf(var_52_3)

				var_52_0.localPosition = Vector3.New(var_52_5 * 0.13, var_52_5 * 0.13, var_52_5 * 0.13) + arg_49_1.var_.shakeOldPos
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = arg_49_1.var_.shakeOldPos
			end

			local var_52_6 = 0
			local var_52_7 = 1

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				local var_52_8 = "play"
				local var_52_9 = "effect"

				arg_49_1:AudioAction(var_52_8, var_52_9, "se_story_120_00", "se_story_120_00_sword03", "")
			end

			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1.allBtn_.enabled = false
			end

			local var_52_11 = 0.75

			if arg_49_1.time_ >= var_52_10 + var_52_11 and arg_49_1.time_ < var_52_10 + var_52_11 + arg_52_0 then
				arg_49_1.allBtn_.enabled = true
			end

			local var_52_12 = 0
			local var_52_13 = 0.075

			if var_52_12 < arg_49_1.time_ and arg_49_1.time_ <= var_52_12 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_14 = arg_49_1:GetWordFromCfg(120141012)
				local var_52_15 = arg_49_1:FormatText(var_52_14.content)

				arg_49_1.text_.text = var_52_15

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_16 = 3
				local var_52_17 = utf8.len(var_52_15)
				local var_52_18 = var_52_16 <= 0 and var_52_13 or var_52_13 * (var_52_17 / var_52_16)

				if var_52_18 > 0 and var_52_13 < var_52_18 then
					arg_49_1.talkMaxDuration = var_52_18

					if var_52_18 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_18 + var_52_12
					end
				end

				arg_49_1.text_.text = var_52_15
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_19 = math.max(var_52_13, arg_49_1.talkMaxDuration)

			if var_52_12 <= arg_49_1.time_ and arg_49_1.time_ < var_52_12 + var_52_19 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_12) / var_52_19

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_12 + var_52_19 and arg_49_1.time_ < var_52_12 + var_52_19 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play120141013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 120141013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play120141014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.275

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_2 = arg_53_1:GetWordFromCfg(120141013)
				local var_56_3 = arg_53_1:FormatText(var_56_2.content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 51
				local var_56_5 = utf8.len(var_56_3)
				local var_56_6 = var_56_4 <= 0 and var_56_1 or var_56_1 * (var_56_5 / var_56_4)

				if var_56_6 > 0 and var_56_1 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_7 and arg_53_1.time_ < var_56_0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play120141014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 120141014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play120141015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				local var_60_2 = "play"
				local var_60_3 = "effect"

				arg_57_1:AudioAction(var_60_2, var_60_3, "se_story_120_00", "se_story_120_00_lingguang04", "")
			end

			local var_60_4 = 0
			local var_60_5 = 0.8

			if var_60_4 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(120141014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_8 = 32
				local var_60_9 = utf8.len(var_60_7)
				local var_60_10 = var_60_8 <= 0 and var_60_5 or var_60_5 * (var_60_9 / var_60_8)

				if var_60_10 > 0 and var_60_5 < var_60_10 then
					arg_57_1.talkMaxDuration = var_60_10

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_11 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_11 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_11

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_11 and arg_57_1.time_ < var_60_4 + var_60_11 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play120141015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 120141015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play120141016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.8

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_2 = arg_61_1:GetWordFromCfg(120141015)
				local var_64_3 = arg_61_1:FormatText(var_64_2.content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 32
				local var_64_5 = utf8.len(var_64_3)
				local var_64_6 = var_64_4 <= 0 and var_64_1 or var_64_1 * (var_64_5 / var_64_4)

				if var_64_6 > 0 and var_64_1 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_7 and arg_61_1.time_ < var_64_0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play120141016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 120141016
		arg_65_1.duration_ = 4.23

		local var_65_0 = {
			zh = 2.933,
			ja = 4.233
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
				arg_65_0:Play120141017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10044ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos10044ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(0, -0.72, -6.3)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10044ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = arg_65_1.actors_["10044ui_story"]
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect10044ui_story == nil then
				arg_65_1.var_.characterEffect10044ui_story = var_68_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_11 = 0.2

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 and not isNil(var_68_9) then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11

				if arg_65_1.var_.characterEffect10044ui_story and not isNil(var_68_9) then
					arg_65_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect10044ui_story then
				arg_65_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_68_13 = 0
			local var_68_14 = 0.3

			if var_68_13 < arg_65_1.time_ and arg_65_1.time_ <= var_68_13 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_15 = arg_65_1:FormatText(StoryNameCfg[387].name)

				arg_65_1.leftNameTxt_.text = var_68_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_16 = arg_65_1:GetWordFromCfg(120141016)
				local var_68_17 = arg_65_1:FormatText(var_68_16.content)

				arg_65_1.text_.text = var_68_17

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_18 = 12
				local var_68_19 = utf8.len(var_68_17)
				local var_68_20 = var_68_18 <= 0 and var_68_14 or var_68_14 * (var_68_19 / var_68_18)

				if var_68_20 > 0 and var_68_14 < var_68_20 then
					arg_65_1.talkMaxDuration = var_68_20

					if var_68_20 + var_68_13 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_20 + var_68_13
					end
				end

				arg_65_1.text_.text = var_68_17
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141016", "story_v_out_120141.awb") ~= 0 then
					local var_68_21 = manager.audio:GetVoiceLength("story_v_out_120141", "120141016", "story_v_out_120141.awb") / 1000

					if var_68_21 + var_68_13 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_21 + var_68_13
					end

					if var_68_16.prefab_name ~= "" and arg_65_1.actors_[var_68_16.prefab_name] ~= nil then
						local var_68_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_16.prefab_name].transform, "story_v_out_120141", "120141016", "story_v_out_120141.awb")

						arg_65_1:RecordAudio("120141016", var_68_22)
						arg_65_1:RecordAudio("120141016", var_68_22)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_120141", "120141016", "story_v_out_120141.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_120141", "120141016", "story_v_out_120141.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_23 = math.max(var_68_14, arg_65_1.talkMaxDuration)

			if var_68_13 <= arg_65_1.time_ and arg_65_1.time_ < var_68_13 + var_68_23 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_13) / var_68_23

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_13 + var_68_23 and arg_65_1.time_ < var_68_13 + var_68_23 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
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

		arg_65_1:InitPlayNodeList()
	end,
	Play120141017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 120141017
		arg_69_1.duration_ = 4.48

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play120141018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = "STblack"

			if arg_69_1.bgs_[var_72_0] == nil then
				local var_72_1 = Object.Instantiate(arg_69_1.paintGo_)

				var_72_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_72_0)
				var_72_1.name = var_72_0
				var_72_1.transform.parent = arg_69_1.stage_.transform
				var_72_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_[var_72_0] = var_72_1
			end

			local var_72_2 = 2

			if var_72_2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				local var_72_3 = manager.ui.mainCamera.transform.localPosition
				local var_72_4 = Vector3.New(0, 0, 10) + Vector3.New(var_72_3.x, var_72_3.y, 0)
				local var_72_5 = arg_69_1.bgs_.STblack

				var_72_5.transform.localPosition = var_72_4
				var_72_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_6 = var_72_5:GetComponent("SpriteRenderer")

				if var_72_6 and var_72_6.sprite then
					local var_72_7 = (var_72_5.transform.localPosition - var_72_3).z
					local var_72_8 = manager.ui.mainCameraCom_
					local var_72_9 = 2 * var_72_7 * Mathf.Tan(var_72_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_72_10 = var_72_9 * var_72_8.aspect
					local var_72_11 = var_72_6.sprite.bounds.size.x
					local var_72_12 = var_72_6.sprite.bounds.size.y
					local var_72_13 = var_72_10 / var_72_11
					local var_72_14 = var_72_9 / var_72_12
					local var_72_15 = var_72_14 < var_72_13 and var_72_13 or var_72_14

					var_72_5.transform.localScale = Vector3.New(var_72_15, var_72_15, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "STblack" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_16 = arg_69_1.actors_["10044ui_story"].transform
			local var_72_17 = 1.966

			if var_72_17 < arg_69_1.time_ and arg_69_1.time_ <= var_72_17 + arg_72_0 then
				arg_69_1.var_.moveOldPos10044ui_story = var_72_16.localPosition
			end

			local var_72_18 = 0.001

			if var_72_17 <= arg_69_1.time_ and arg_69_1.time_ < var_72_17 + var_72_18 then
				local var_72_19 = (arg_69_1.time_ - var_72_17) / var_72_18
				local var_72_20 = Vector3.New(0, 100, 0)

				var_72_16.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10044ui_story, var_72_20, var_72_19)

				local var_72_21 = manager.ui.mainCamera.transform.position - var_72_16.position

				var_72_16.forward = Vector3.New(var_72_21.x, var_72_21.y, var_72_21.z)

				local var_72_22 = var_72_16.localEulerAngles

				var_72_22.z = 0
				var_72_22.x = 0
				var_72_16.localEulerAngles = var_72_22
			end

			if arg_69_1.time_ >= var_72_17 + var_72_18 and arg_69_1.time_ < var_72_17 + var_72_18 + arg_72_0 then
				var_72_16.localPosition = Vector3.New(0, 100, 0)

				local var_72_23 = manager.ui.mainCamera.transform.position - var_72_16.position

				var_72_16.forward = Vector3.New(var_72_23.x, var_72_23.y, var_72_23.z)

				local var_72_24 = var_72_16.localEulerAngles

				var_72_24.z = 0
				var_72_24.x = 0
				var_72_16.localEulerAngles = var_72_24
			end

			local var_72_25 = 0

			if var_72_25 < arg_69_1.time_ and arg_69_1.time_ <= var_72_25 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_26 = 2

			if var_72_25 <= arg_69_1.time_ and arg_69_1.time_ < var_72_25 + var_72_26 then
				local var_72_27 = (arg_69_1.time_ - var_72_25) / var_72_26
				local var_72_28 = Color.New(0, 0, 0)

				var_72_28.a = Mathf.Lerp(0, 1, var_72_27)
				arg_69_1.mask_.color = var_72_28
			end

			if arg_69_1.time_ >= var_72_25 + var_72_26 and arg_69_1.time_ < var_72_25 + var_72_26 + arg_72_0 then
				local var_72_29 = Color.New(0, 0, 0)

				var_72_29.a = 1
				arg_69_1.mask_.color = var_72_29
			end

			local var_72_30 = 2

			if var_72_30 < arg_69_1.time_ and arg_69_1.time_ <= var_72_30 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_31 = 0.5

			if var_72_30 <= arg_69_1.time_ and arg_69_1.time_ < var_72_30 + var_72_31 then
				local var_72_32 = (arg_69_1.time_ - var_72_30) / var_72_31
				local var_72_33 = Color.New(0, 0, 0)

				var_72_33.a = Mathf.Lerp(1, 0, var_72_32)
				arg_69_1.mask_.color = var_72_33
			end

			if arg_69_1.time_ >= var_72_30 + var_72_31 and arg_69_1.time_ < var_72_30 + var_72_31 + arg_72_0 then
				local var_72_34 = Color.New(0, 0, 0)
				local var_72_35 = 0

				arg_69_1.mask_.enabled = false
				var_72_34.a = var_72_35
				arg_69_1.mask_.color = var_72_34
			end

			local var_72_36 = 0

			if var_72_36 < arg_69_1.time_ and arg_69_1.time_ <= var_72_36 + arg_72_0 then
				arg_69_1.fswbg_:SetActive(true)
				arg_69_1.dialog_:SetActive(false)

				arg_69_1.fswtw_.percent = 0

				local var_72_37 = arg_69_1:GetWordFromCfg(120141017)
				local var_72_38 = arg_69_1:FormatText(var_72_37.content)

				arg_69_1.fswt_.text = var_72_38

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.fswt_)

				arg_69_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_69_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_69_1.fswtw_:SetDirty()

				arg_69_1.typewritterCharCountI18N = 0

				SetActive(arg_69_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_69_1:ShowNextGo(false)
			end

			local var_72_39 = 2

			if var_72_39 < arg_69_1.time_ and arg_69_1.time_ <= var_72_39 + arg_72_0 then
				arg_69_1.var_.oldValueTypewriter = arg_69_1.fswtw_.percent

				SetActive(arg_69_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_69_1:ShowNextGo(false)
			end

			local var_72_40 = 37
			local var_72_41 = 2.46666666666667
			local var_72_42 = arg_69_1:GetWordFromCfg(120141017)
			local var_72_43 = arg_69_1:FormatText(var_72_42.content)
			local var_72_44, var_72_45 = arg_69_1:GetPercentByPara(var_72_43, 1)

			if var_72_39 < arg_69_1.time_ and arg_69_1.time_ <= var_72_39 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				local var_72_46 = var_72_40 <= 0 and var_72_41 or var_72_41 * ((var_72_45 - arg_69_1.typewritterCharCountI18N) / var_72_40)

				if var_72_46 > 0 and var_72_41 < var_72_46 then
					arg_69_1.talkMaxDuration = var_72_46

					if var_72_46 + var_72_39 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_46 + var_72_39
					end
				end
			end

			local var_72_47 = 2.46666666666667
			local var_72_48 = math.max(var_72_47, arg_69_1.talkMaxDuration)

			if var_72_39 <= arg_69_1.time_ and arg_69_1.time_ < var_72_39 + var_72_48 then
				local var_72_49 = (arg_69_1.time_ - var_72_39) / var_72_48

				arg_69_1.fswtw_.percent = Mathf.Lerp(arg_69_1.var_.oldValueTypewriter, var_72_44, var_72_49)
				arg_69_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_69_1.fswtw_:SetDirty()
			end

			if arg_69_1.time_ >= var_72_39 + var_72_48 and arg_69_1.time_ < var_72_39 + var_72_48 + arg_72_0 then
				arg_69_1.fswtw_.percent = var_72_44

				arg_69_1.fswtw_:SetDirty()
				arg_69_1:ShowNextGo(true)

				arg_69_1.typewritterCharCountI18N = var_72_45
			end

			local var_72_50 = 2

			if var_72_50 < arg_69_1.time_ and arg_69_1.time_ <= var_72_50 + arg_72_0 then
				local var_72_51 = arg_69_1.fswbg_.transform:Find("textbox/adapt/content") or arg_69_1.fswbg_.transform:Find("textbox/content")
				local var_72_52 = arg_69_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_72_53 = var_72_51:GetComponent("Text")
				local var_72_54 = var_72_51:GetComponent("RectTransform")

				var_72_53.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_72_54.offsetMin = Vector2.New(0, 0)
				var_72_54.offsetMax = Vector2.New(0, 0)
			end

			local var_72_55 = 2

			if var_72_55 < arg_69_1.time_ and arg_69_1.time_ <= var_72_55 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			local var_72_56 = 2.46666666666667

			if arg_69_1.time_ >= var_72_55 + var_72_56 and arg_69_1.time_ < var_72_55 + var_72_56 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play120141018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 120141018
		arg_73_1.duration_ = 1

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play120141019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.fswbg_:SetActive(true)
				arg_73_1.dialog_:SetActive(false)

				arg_73_1.fswtw_.percent = 0

				local var_76_1 = arg_73_1:GetWordFromCfg(120141018)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.fswt_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.fswt_)

				arg_73_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_73_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_73_1.fswtw_:SetDirty()

				arg_73_1.typewritterCharCountI18N = 0

				SetActive(arg_73_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_73_1:ShowNextGo(false)
			end

			local var_76_3 = 0.0166666666666667

			if var_76_3 < arg_73_1.time_ and arg_73_1.time_ <= var_76_3 + arg_76_0 then
				arg_73_1.var_.oldValueTypewriter = arg_73_1.fswtw_.percent

				SetActive(arg_73_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_73_1:ShowNextGo(false)
			end

			local var_76_4 = 2
			local var_76_5 = 0.133333333333333
			local var_76_6 = arg_73_1:GetWordFromCfg(120141018)
			local var_76_7 = arg_73_1:FormatText(var_76_6.content)
			local var_76_8, var_76_9 = arg_73_1:GetPercentByPara(var_76_7, 1)

			if var_76_3 < arg_73_1.time_ and arg_73_1.time_ <= var_76_3 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				local var_76_10 = var_76_4 <= 0 and var_76_5 or var_76_5 * ((var_76_9 - arg_73_1.typewritterCharCountI18N) / var_76_4)

				if var_76_10 > 0 and var_76_5 < var_76_10 then
					arg_73_1.talkMaxDuration = var_76_10

					if var_76_10 + var_76_3 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_3
					end
				end
			end

			local var_76_11 = 0.133333333333333
			local var_76_12 = math.max(var_76_11, arg_73_1.talkMaxDuration)

			if var_76_3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_3 + var_76_12 then
				local var_76_13 = (arg_73_1.time_ - var_76_3) / var_76_12

				arg_73_1.fswtw_.percent = Mathf.Lerp(arg_73_1.var_.oldValueTypewriter, var_76_8, var_76_13)
				arg_73_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_73_1.fswtw_:SetDirty()
			end

			if arg_73_1.time_ >= var_76_3 + var_76_12 and arg_73_1.time_ < var_76_3 + var_76_12 + arg_76_0 then
				arg_73_1.fswtw_.percent = var_76_8

				arg_73_1.fswtw_:SetDirty()
				arg_73_1:ShowNextGo(true)

				arg_73_1.typewritterCharCountI18N = var_76_9
			end

			local var_76_14 = 0
			local var_76_15 = 1

			if var_76_14 < arg_73_1.time_ and arg_73_1.time_ <= var_76_14 + arg_76_0 then
				local var_76_16 = "play"
				local var_76_17 = "effect"

				arg_73_1:AudioAction(var_76_16, var_76_17, "se_story_16", "se_story_16_droplet_loop02", "")
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play120141019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 120141019
		arg_77_1.duration_ = 7

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play120141020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				local var_80_1 = manager.ui.mainCamera.transform.localPosition
				local var_80_2 = Vector3.New(0, 0, 10) + Vector3.New(var_80_1.x, var_80_1.y, 0)
				local var_80_3 = arg_77_1.bgs_.J04f

				var_80_3.transform.localPosition = var_80_2
				var_80_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_80_4 = var_80_3:GetComponent("SpriteRenderer")

				if var_80_4 and var_80_4.sprite then
					local var_80_5 = (var_80_3.transform.localPosition - var_80_1).z
					local var_80_6 = manager.ui.mainCameraCom_
					local var_80_7 = 2 * var_80_5 * Mathf.Tan(var_80_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_80_8 = var_80_7 * var_80_6.aspect
					local var_80_9 = var_80_4.sprite.bounds.size.x
					local var_80_10 = var_80_4.sprite.bounds.size.y
					local var_80_11 = var_80_8 / var_80_9
					local var_80_12 = var_80_7 / var_80_10
					local var_80_13 = var_80_12 < var_80_11 and var_80_11 or var_80_12

					var_80_3.transform.localScale = Vector3.New(var_80_13, var_80_13, 0)
				end

				for iter_80_0, iter_80_1 in pairs(arg_77_1.bgs_) do
					if iter_80_0 ~= "J04f" then
						iter_80_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_80_14 = 0

			if var_80_14 < arg_77_1.time_ and arg_77_1.time_ <= var_80_14 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_15 = 2

			if var_80_14 <= arg_77_1.time_ and arg_77_1.time_ < var_80_14 + var_80_15 then
				local var_80_16 = (arg_77_1.time_ - var_80_14) / var_80_15
				local var_80_17 = Color.New(0, 0, 0)

				var_80_17.a = Mathf.Lerp(1, 0, var_80_16)
				arg_77_1.mask_.color = var_80_17
			end

			if arg_77_1.time_ >= var_80_14 + var_80_15 and arg_77_1.time_ < var_80_14 + var_80_15 + arg_80_0 then
				local var_80_18 = Color.New(0, 0, 0)
				local var_80_19 = 0

				arg_77_1.mask_.enabled = false
				var_80_18.a = var_80_19
				arg_77_1.mask_.color = var_80_18
			end

			local var_80_20 = 0

			if var_80_20 < arg_77_1.time_ and arg_77_1.time_ <= var_80_20 + arg_80_0 then
				arg_77_1.fswbg_:SetActive(false)
				arg_77_1.dialog_:SetActive(false)
				SetActive(arg_77_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_77_1:ShowNextGo(false)
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_21 = 2
			local var_80_22 = 0.725

			if var_80_21 < arg_77_1.time_ and arg_77_1.time_ <= var_80_21 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_23 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_23:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_24 = arg_77_1:GetWordFromCfg(120141019)
				local var_80_25 = arg_77_1:FormatText(var_80_24.content)

				arg_77_1.text_.text = var_80_25

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_26 = 29
				local var_80_27 = utf8.len(var_80_25)
				local var_80_28 = var_80_26 <= 0 and var_80_22 or var_80_22 * (var_80_27 / var_80_26)

				if var_80_28 > 0 and var_80_22 < var_80_28 then
					arg_77_1.talkMaxDuration = var_80_28
					var_80_21 = var_80_21 + 0.3

					if var_80_28 + var_80_21 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_28 + var_80_21
					end
				end

				arg_77_1.text_.text = var_80_25
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_29 = var_80_21 + 0.3
			local var_80_30 = math.max(var_80_22, arg_77_1.talkMaxDuration)

			if var_80_29 <= arg_77_1.time_ and arg_77_1.time_ < var_80_29 + var_80_30 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_29) / var_80_30

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_29 + var_80_30 and arg_77_1.time_ < var_80_29 + var_80_30 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play120141020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 120141020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play120141021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 1.275

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_2 = arg_83_1:GetWordFromCfg(120141020)
				local var_86_3 = arg_83_1:FormatText(var_86_2.content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 51
				local var_86_5 = utf8.len(var_86_3)
				local var_86_6 = var_86_4 <= 0 and var_86_1 or var_86_1 * (var_86_5 / var_86_4)

				if var_86_6 > 0 and var_86_1 < var_86_6 then
					arg_83_1.talkMaxDuration = var_86_6

					if var_86_6 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_7 and arg_83_1.time_ < var_86_0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play120141021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 120141021
		arg_87_1.duration_ = 2

		local var_87_0 = {
			zh = 1.999999999999,
			ja = 2
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
				arg_87_0:Play120141022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1071ui_story"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos1071ui_story = var_90_0.localPosition
			end

			local var_90_2 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2
				local var_90_4 = Vector3.New(0, -1.05, -6.2)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1071ui_story, var_90_4, var_90_3)

				local var_90_5 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_5.x, var_90_5.y, var_90_5.z)

				local var_90_6 = var_90_0.localEulerAngles

				var_90_6.z = 0
				var_90_6.x = 0
				var_90_0.localEulerAngles = var_90_6
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_90_7 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_7.x, var_90_7.y, var_90_7.z)

				local var_90_8 = var_90_0.localEulerAngles

				var_90_8.z = 0
				var_90_8.x = 0
				var_90_0.localEulerAngles = var_90_8
			end

			local var_90_9 = 0
			local var_90_10 = 1

			if var_90_9 < arg_87_1.time_ and arg_87_1.time_ <= var_90_9 + arg_90_0 then
				local var_90_11 = "stop"
				local var_90_12 = "effect"

				arg_87_1:AudioAction(var_90_11, var_90_12, "se_story_16", "se_story_16_droplet_loop02", "")
			end

			local var_90_13 = arg_87_1.actors_["1071ui_story"]
			local var_90_14 = 0

			if var_90_14 < arg_87_1.time_ and arg_87_1.time_ <= var_90_14 + arg_90_0 and not isNil(var_90_13) and arg_87_1.var_.characterEffect1071ui_story == nil then
				arg_87_1.var_.characterEffect1071ui_story = var_90_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_15 = 0.2

			if var_90_14 <= arg_87_1.time_ and arg_87_1.time_ < var_90_14 + var_90_15 and not isNil(var_90_13) then
				local var_90_16 = (arg_87_1.time_ - var_90_14) / var_90_15

				if arg_87_1.var_.characterEffect1071ui_story and not isNil(var_90_13) then
					arg_87_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_14 + var_90_15 and arg_87_1.time_ < var_90_14 + var_90_15 + arg_90_0 and not isNil(var_90_13) and arg_87_1.var_.characterEffect1071ui_story then
				arg_87_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_90_17 = 0

			if var_90_17 < arg_87_1.time_ and arg_87_1.time_ <= var_90_17 + arg_90_0 then
				arg_87_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_90_18 = 0

			if var_90_18 < arg_87_1.time_ and arg_87_1.time_ <= var_90_18 + arg_90_0 then
				arg_87_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_90_19 = 0
			local var_90_20 = 0.1

			if var_90_19 < arg_87_1.time_ and arg_87_1.time_ <= var_90_19 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_21 = arg_87_1:FormatText(StoryNameCfg[384].name)

				arg_87_1.leftNameTxt_.text = var_90_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_22 = arg_87_1:GetWordFromCfg(120141021)
				local var_90_23 = arg_87_1:FormatText(var_90_22.content)

				arg_87_1.text_.text = var_90_23

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_24 = 4
				local var_90_25 = utf8.len(var_90_23)
				local var_90_26 = var_90_24 <= 0 and var_90_20 or var_90_20 * (var_90_25 / var_90_24)

				if var_90_26 > 0 and var_90_20 < var_90_26 then
					arg_87_1.talkMaxDuration = var_90_26

					if var_90_26 + var_90_19 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_26 + var_90_19
					end
				end

				arg_87_1.text_.text = var_90_23
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141021", "story_v_out_120141.awb") ~= 0 then
					local var_90_27 = manager.audio:GetVoiceLength("story_v_out_120141", "120141021", "story_v_out_120141.awb") / 1000

					if var_90_27 + var_90_19 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_27 + var_90_19
					end

					if var_90_22.prefab_name ~= "" and arg_87_1.actors_[var_90_22.prefab_name] ~= nil then
						local var_90_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_22.prefab_name].transform, "story_v_out_120141", "120141021", "story_v_out_120141.awb")

						arg_87_1:RecordAudio("120141021", var_90_28)
						arg_87_1:RecordAudio("120141021", var_90_28)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_120141", "120141021", "story_v_out_120141.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_120141", "120141021", "story_v_out_120141.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_29 = math.max(var_90_20, arg_87_1.talkMaxDuration)

			if var_90_19 <= arg_87_1.time_ and arg_87_1.time_ < var_90_19 + var_90_29 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_19) / var_90_29

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_19 + var_90_29 and arg_87_1.time_ < var_90_19 + var_90_29 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play120141022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 120141022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play120141023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1071ui_story"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos1071ui_story = var_94_0.localPosition
			end

			local var_94_2 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2
				local var_94_4 = Vector3.New(0, 100, 0)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1071ui_story, var_94_4, var_94_3)

				local var_94_5 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_5.x, var_94_5.y, var_94_5.z)

				local var_94_6 = var_94_0.localEulerAngles

				var_94_6.z = 0
				var_94_6.x = 0
				var_94_0.localEulerAngles = var_94_6
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(0, 100, 0)

				local var_94_7 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_7.x, var_94_7.y, var_94_7.z)

				local var_94_8 = var_94_0.localEulerAngles

				var_94_8.z = 0
				var_94_8.x = 0
				var_94_0.localEulerAngles = var_94_8
			end

			local var_94_9 = 0
			local var_94_10 = 0.8

			if var_94_9 < arg_91_1.time_ and arg_91_1.time_ <= var_94_9 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_11 = arg_91_1:GetWordFromCfg(120141022)
				local var_94_12 = arg_91_1:FormatText(var_94_11.content)

				arg_91_1.text_.text = var_94_12

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_13 = 32
				local var_94_14 = utf8.len(var_94_12)
				local var_94_15 = var_94_13 <= 0 and var_94_10 or var_94_10 * (var_94_14 / var_94_13)

				if var_94_15 > 0 and var_94_10 < var_94_15 then
					arg_91_1.talkMaxDuration = var_94_15

					if var_94_15 + var_94_9 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_15 + var_94_9
					end
				end

				arg_91_1.text_.text = var_94_12
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_16 = math.max(var_94_10, arg_91_1.talkMaxDuration)

			if var_94_9 <= arg_91_1.time_ and arg_91_1.time_ < var_94_9 + var_94_16 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_9) / var_94_16

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_9 + var_94_16 and arg_91_1.time_ < var_94_9 + var_94_16 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play120141023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 120141023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play120141024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 1

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_2 = arg_95_1:GetWordFromCfg(120141023)
				local var_98_3 = arg_95_1:FormatText(var_98_2.content)

				arg_95_1.text_.text = var_98_3

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 40
				local var_98_5 = utf8.len(var_98_3)
				local var_98_6 = var_98_4 <= 0 and var_98_1 or var_98_1 * (var_98_5 / var_98_4)

				if var_98_6 > 0 and var_98_1 < var_98_6 then
					arg_95_1.talkMaxDuration = var_98_6

					if var_98_6 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_6 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_3
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_7 and arg_95_1.time_ < var_98_0 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play120141024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 120141024
		arg_99_1.duration_ = 4

		local var_99_0 = {
			zh = 4,
			ja = 1.999999999999
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
				arg_99_0:Play120141025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["10044ui_story"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos10044ui_story = var_102_0.localPosition
			end

			local var_102_2 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2
				local var_102_4 = Vector3.New(0, -0.72, -6.3)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10044ui_story, var_102_4, var_102_3)

				local var_102_5 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_5.x, var_102_5.y, var_102_5.z)

				local var_102_6 = var_102_0.localEulerAngles

				var_102_6.z = 0
				var_102_6.x = 0
				var_102_0.localEulerAngles = var_102_6
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_102_7 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_7.x, var_102_7.y, var_102_7.z)

				local var_102_8 = var_102_0.localEulerAngles

				var_102_8.z = 0
				var_102_8.x = 0
				var_102_0.localEulerAngles = var_102_8
			end

			local var_102_9 = arg_99_1.actors_["10044ui_story"]
			local var_102_10 = 0

			if var_102_10 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 and not isNil(var_102_9) and arg_99_1.var_.characterEffect10044ui_story == nil then
				arg_99_1.var_.characterEffect10044ui_story = var_102_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_11 = 0.2

			if var_102_10 <= arg_99_1.time_ and arg_99_1.time_ < var_102_10 + var_102_11 and not isNil(var_102_9) then
				local var_102_12 = (arg_99_1.time_ - var_102_10) / var_102_11

				if arg_99_1.var_.characterEffect10044ui_story and not isNil(var_102_9) then
					arg_99_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_10 + var_102_11 and arg_99_1.time_ < var_102_10 + var_102_11 + arg_102_0 and not isNil(var_102_9) and arg_99_1.var_.characterEffect10044ui_story then
				arg_99_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_102_13 = 0

			if var_102_13 < arg_99_1.time_ and arg_99_1.time_ <= var_102_13 + arg_102_0 then
				arg_99_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action6_1")
			end

			local var_102_14 = 0

			if var_102_14 < arg_99_1.time_ and arg_99_1.time_ <= var_102_14 + arg_102_0 then
				arg_99_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_102_15 = 0
			local var_102_16 = 0.35

			if var_102_15 < arg_99_1.time_ and arg_99_1.time_ <= var_102_15 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_17 = arg_99_1:FormatText(StoryNameCfg[387].name)

				arg_99_1.leftNameTxt_.text = var_102_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_18 = arg_99_1:GetWordFromCfg(120141024)
				local var_102_19 = arg_99_1:FormatText(var_102_18.content)

				arg_99_1.text_.text = var_102_19

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_20 = 14
				local var_102_21 = utf8.len(var_102_19)
				local var_102_22 = var_102_20 <= 0 and var_102_16 or var_102_16 * (var_102_21 / var_102_20)

				if var_102_22 > 0 and var_102_16 < var_102_22 then
					arg_99_1.talkMaxDuration = var_102_22

					if var_102_22 + var_102_15 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_22 + var_102_15
					end
				end

				arg_99_1.text_.text = var_102_19
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141024", "story_v_out_120141.awb") ~= 0 then
					local var_102_23 = manager.audio:GetVoiceLength("story_v_out_120141", "120141024", "story_v_out_120141.awb") / 1000

					if var_102_23 + var_102_15 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_23 + var_102_15
					end

					if var_102_18.prefab_name ~= "" and arg_99_1.actors_[var_102_18.prefab_name] ~= nil then
						local var_102_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_18.prefab_name].transform, "story_v_out_120141", "120141024", "story_v_out_120141.awb")

						arg_99_1:RecordAudio("120141024", var_102_24)
						arg_99_1:RecordAudio("120141024", var_102_24)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_120141", "120141024", "story_v_out_120141.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_120141", "120141024", "story_v_out_120141.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_25 = math.max(var_102_16, arg_99_1.talkMaxDuration)

			if var_102_15 <= arg_99_1.time_ and arg_99_1.time_ < var_102_15 + var_102_25 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_15) / var_102_25

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_15 + var_102_25 and arg_99_1.time_ < var_102_15 + var_102_25 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
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

		arg_99_1:InitPlayNodeList()
	end,
	Play120141025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 120141025
		arg_103_1.duration_ = 9.27

		local var_103_0 = {
			zh = 9.266,
			ja = 8.9
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
				arg_103_0:Play120141026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_106_1 = 0
			local var_106_2 = 0.825

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_3 = arg_103_1:FormatText(StoryNameCfg[387].name)

				arg_103_1.leftNameTxt_.text = var_106_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_4 = arg_103_1:GetWordFromCfg(120141025)
				local var_106_5 = arg_103_1:FormatText(var_106_4.content)

				arg_103_1.text_.text = var_106_5

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_6 = 33
				local var_106_7 = utf8.len(var_106_5)
				local var_106_8 = var_106_6 <= 0 and var_106_2 or var_106_2 * (var_106_7 / var_106_6)

				if var_106_8 > 0 and var_106_2 < var_106_8 then
					arg_103_1.talkMaxDuration = var_106_8

					if var_106_8 + var_106_1 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_1
					end
				end

				arg_103_1.text_.text = var_106_5
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141025", "story_v_out_120141.awb") ~= 0 then
					local var_106_9 = manager.audio:GetVoiceLength("story_v_out_120141", "120141025", "story_v_out_120141.awb") / 1000

					if var_106_9 + var_106_1 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_1
					end

					if var_106_4.prefab_name ~= "" and arg_103_1.actors_[var_106_4.prefab_name] ~= nil then
						local var_106_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_4.prefab_name].transform, "story_v_out_120141", "120141025", "story_v_out_120141.awb")

						arg_103_1:RecordAudio("120141025", var_106_10)
						arg_103_1:RecordAudio("120141025", var_106_10)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_120141", "120141025", "story_v_out_120141.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_120141", "120141025", "story_v_out_120141.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_11 = math.max(var_106_2, arg_103_1.talkMaxDuration)

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_11 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_1) / var_106_11

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_1 + var_106_11 and arg_103_1.time_ < var_106_1 + var_106_11 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play120141026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 120141026
		arg_107_1.duration_ = 2.63

		local var_107_0 = {
			zh = 2.633,
			ja = 2.466
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
				arg_107_0:Play120141027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_110_1 = 0
			local var_110_2 = 0.275

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_3 = arg_107_1:FormatText(StoryNameCfg[387].name)

				arg_107_1.leftNameTxt_.text = var_110_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_4 = arg_107_1:GetWordFromCfg(120141026)
				local var_110_5 = arg_107_1:FormatText(var_110_4.content)

				arg_107_1.text_.text = var_110_5

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_6 = 11
				local var_110_7 = utf8.len(var_110_5)
				local var_110_8 = var_110_6 <= 0 and var_110_2 or var_110_2 * (var_110_7 / var_110_6)

				if var_110_8 > 0 and var_110_2 < var_110_8 then
					arg_107_1.talkMaxDuration = var_110_8

					if var_110_8 + var_110_1 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_1
					end
				end

				arg_107_1.text_.text = var_110_5
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141026", "story_v_out_120141.awb") ~= 0 then
					local var_110_9 = manager.audio:GetVoiceLength("story_v_out_120141", "120141026", "story_v_out_120141.awb") / 1000

					if var_110_9 + var_110_1 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_9 + var_110_1
					end

					if var_110_4.prefab_name ~= "" and arg_107_1.actors_[var_110_4.prefab_name] ~= nil then
						local var_110_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_4.prefab_name].transform, "story_v_out_120141", "120141026", "story_v_out_120141.awb")

						arg_107_1:RecordAudio("120141026", var_110_10)
						arg_107_1:RecordAudio("120141026", var_110_10)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_120141", "120141026", "story_v_out_120141.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_120141", "120141026", "story_v_out_120141.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_11 = math.max(var_110_2, arg_107_1.talkMaxDuration)

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_11 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_1) / var_110_11

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_1 + var_110_11 and arg_107_1.time_ < var_110_1 + var_110_11 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play120141027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 120141027
		arg_111_1.duration_ = 5.17

		local var_111_0 = {
			zh = 4.633,
			ja = 5.166
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
				arg_111_0:Play120141028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1075ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1075ui_story == nil then
				arg_111_1.var_.characterEffect1075ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.2

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect1075ui_story and not isNil(var_114_0) then
					arg_111_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1075ui_story then
				arg_111_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_114_4 = arg_111_1.actors_["10044ui_story"]
			local var_114_5 = 0

			if var_114_5 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 and not isNil(var_114_4) and arg_111_1.var_.characterEffect10044ui_story == nil then
				arg_111_1.var_.characterEffect10044ui_story = var_114_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_6 = 0.2

			if var_114_5 <= arg_111_1.time_ and arg_111_1.time_ < var_114_5 + var_114_6 and not isNil(var_114_4) then
				local var_114_7 = (arg_111_1.time_ - var_114_5) / var_114_6

				if arg_111_1.var_.characterEffect10044ui_story and not isNil(var_114_4) then
					local var_114_8 = Mathf.Lerp(0, 0.5, var_114_7)

					arg_111_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_111_1.var_.characterEffect10044ui_story.fillRatio = var_114_8
				end
			end

			if arg_111_1.time_ >= var_114_5 + var_114_6 and arg_111_1.time_ < var_114_5 + var_114_6 + arg_114_0 and not isNil(var_114_4) and arg_111_1.var_.characterEffect10044ui_story then
				local var_114_9 = 0.5

				arg_111_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_111_1.var_.characterEffect10044ui_story.fillRatio = var_114_9
			end

			local var_114_10 = 0

			if var_114_10 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 then
				arg_111_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action7_1")
			end

			local var_114_11 = arg_111_1.actors_["10044ui_story"].transform
			local var_114_12 = 0

			if var_114_12 < arg_111_1.time_ and arg_111_1.time_ <= var_114_12 + arg_114_0 then
				arg_111_1.var_.moveOldPos10044ui_story = var_114_11.localPosition
			end

			local var_114_13 = 0.001

			if var_114_12 <= arg_111_1.time_ and arg_111_1.time_ < var_114_12 + var_114_13 then
				local var_114_14 = (arg_111_1.time_ - var_114_12) / var_114_13
				local var_114_15 = Vector3.New(0, 100, 0)

				var_114_11.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10044ui_story, var_114_15, var_114_14)

				local var_114_16 = manager.ui.mainCamera.transform.position - var_114_11.position

				var_114_11.forward = Vector3.New(var_114_16.x, var_114_16.y, var_114_16.z)

				local var_114_17 = var_114_11.localEulerAngles

				var_114_17.z = 0
				var_114_17.x = 0
				var_114_11.localEulerAngles = var_114_17
			end

			if arg_111_1.time_ >= var_114_12 + var_114_13 and arg_111_1.time_ < var_114_12 + var_114_13 + arg_114_0 then
				var_114_11.localPosition = Vector3.New(0, 100, 0)

				local var_114_18 = manager.ui.mainCamera.transform.position - var_114_11.position

				var_114_11.forward = Vector3.New(var_114_18.x, var_114_18.y, var_114_18.z)

				local var_114_19 = var_114_11.localEulerAngles

				var_114_19.z = 0
				var_114_19.x = 0
				var_114_11.localEulerAngles = var_114_19
			end

			local var_114_20 = arg_111_1.actors_["1075ui_story"].transform
			local var_114_21 = 0

			if var_114_21 < arg_111_1.time_ and arg_111_1.time_ <= var_114_21 + arg_114_0 then
				arg_111_1.var_.moveOldPos1075ui_story = var_114_20.localPosition
			end

			local var_114_22 = 0.001

			if var_114_21 <= arg_111_1.time_ and arg_111_1.time_ < var_114_21 + var_114_22 then
				local var_114_23 = (arg_111_1.time_ - var_114_21) / var_114_22
				local var_114_24 = Vector3.New(0, -1.055, -6.16)

				var_114_20.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1075ui_story, var_114_24, var_114_23)

				local var_114_25 = manager.ui.mainCamera.transform.position - var_114_20.position

				var_114_20.forward = Vector3.New(var_114_25.x, var_114_25.y, var_114_25.z)

				local var_114_26 = var_114_20.localEulerAngles

				var_114_26.z = 0
				var_114_26.x = 0
				var_114_20.localEulerAngles = var_114_26
			end

			if arg_111_1.time_ >= var_114_21 + var_114_22 and arg_111_1.time_ < var_114_21 + var_114_22 + arg_114_0 then
				var_114_20.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_114_27 = manager.ui.mainCamera.transform.position - var_114_20.position

				var_114_20.forward = Vector3.New(var_114_27.x, var_114_27.y, var_114_27.z)

				local var_114_28 = var_114_20.localEulerAngles

				var_114_28.z = 0
				var_114_28.x = 0
				var_114_20.localEulerAngles = var_114_28
			end

			local var_114_29 = 0

			if var_114_29 < arg_111_1.time_ and arg_111_1.time_ <= var_114_29 + arg_114_0 then
				arg_111_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_114_30 = 0
			local var_114_31 = 0.175

			if var_114_30 < arg_111_1.time_ and arg_111_1.time_ <= var_114_30 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_32 = arg_111_1:FormatText(StoryNameCfg[381].name)

				arg_111_1.leftNameTxt_.text = var_114_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_33 = arg_111_1:GetWordFromCfg(120141027)
				local var_114_34 = arg_111_1:FormatText(var_114_33.content)

				arg_111_1.text_.text = var_114_34

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_35 = 7
				local var_114_36 = utf8.len(var_114_34)
				local var_114_37 = var_114_35 <= 0 and var_114_31 or var_114_31 * (var_114_36 / var_114_35)

				if var_114_37 > 0 and var_114_31 < var_114_37 then
					arg_111_1.talkMaxDuration = var_114_37

					if var_114_37 + var_114_30 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_37 + var_114_30
					end
				end

				arg_111_1.text_.text = var_114_34
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141027", "story_v_out_120141.awb") ~= 0 then
					local var_114_38 = manager.audio:GetVoiceLength("story_v_out_120141", "120141027", "story_v_out_120141.awb") / 1000

					if var_114_38 + var_114_30 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_38 + var_114_30
					end

					if var_114_33.prefab_name ~= "" and arg_111_1.actors_[var_114_33.prefab_name] ~= nil then
						local var_114_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_33.prefab_name].transform, "story_v_out_120141", "120141027", "story_v_out_120141.awb")

						arg_111_1:RecordAudio("120141027", var_114_39)
						arg_111_1:RecordAudio("120141027", var_114_39)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_120141", "120141027", "story_v_out_120141.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_120141", "120141027", "story_v_out_120141.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_40 = math.max(var_114_31, arg_111_1.talkMaxDuration)

			if var_114_30 <= arg_111_1.time_ and arg_111_1.time_ < var_114_30 + var_114_40 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_30) / var_114_40

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_30 + var_114_40 and arg_111_1.time_ < var_114_30 + var_114_40 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
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
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play120141028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 120141028
		arg_115_1.duration_ = 4

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play120141029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 2

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				local var_118_1 = manager.ui.mainCamera.transform.localPosition
				local var_118_2 = Vector3.New(0, 0, 10) + Vector3.New(var_118_1.x, var_118_1.y, 0)
				local var_118_3 = arg_115_1.bgs_.STblack

				var_118_3.transform.localPosition = var_118_2
				var_118_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_118_4 = var_118_3:GetComponent("SpriteRenderer")

				if var_118_4 and var_118_4.sprite then
					local var_118_5 = (var_118_3.transform.localPosition - var_118_1).z
					local var_118_6 = manager.ui.mainCameraCom_
					local var_118_7 = 2 * var_118_5 * Mathf.Tan(var_118_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_118_8 = var_118_7 * var_118_6.aspect
					local var_118_9 = var_118_4.sprite.bounds.size.x
					local var_118_10 = var_118_4.sprite.bounds.size.y
					local var_118_11 = var_118_8 / var_118_9
					local var_118_12 = var_118_7 / var_118_10
					local var_118_13 = var_118_12 < var_118_11 and var_118_11 or var_118_12

					var_118_3.transform.localScale = Vector3.New(var_118_13, var_118_13, 0)
				end

				for iter_118_0, iter_118_1 in pairs(arg_115_1.bgs_) do
					if iter_118_0 ~= "STblack" then
						iter_118_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_118_14 = arg_115_1.actors_["1075ui_story"].transform
			local var_118_15 = 2

			if var_118_15 < arg_115_1.time_ and arg_115_1.time_ <= var_118_15 + arg_118_0 then
				arg_115_1.var_.moveOldPos1075ui_story = var_118_14.localPosition
			end

			local var_118_16 = 0.001

			if var_118_15 <= arg_115_1.time_ and arg_115_1.time_ < var_118_15 + var_118_16 then
				local var_118_17 = (arg_115_1.time_ - var_118_15) / var_118_16
				local var_118_18 = Vector3.New(0, 100, 0)

				var_118_14.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1075ui_story, var_118_18, var_118_17)

				local var_118_19 = manager.ui.mainCamera.transform.position - var_118_14.position

				var_118_14.forward = Vector3.New(var_118_19.x, var_118_19.y, var_118_19.z)

				local var_118_20 = var_118_14.localEulerAngles

				var_118_20.z = 0
				var_118_20.x = 0
				var_118_14.localEulerAngles = var_118_20
			end

			if arg_115_1.time_ >= var_118_15 + var_118_16 and arg_115_1.time_ < var_118_15 + var_118_16 + arg_118_0 then
				var_118_14.localPosition = Vector3.New(0, 100, 0)

				local var_118_21 = manager.ui.mainCamera.transform.position - var_118_14.position

				var_118_14.forward = Vector3.New(var_118_21.x, var_118_21.y, var_118_21.z)

				local var_118_22 = var_118_14.localEulerAngles

				var_118_22.z = 0
				var_118_22.x = 0
				var_118_14.localEulerAngles = var_118_22
			end

			local var_118_23 = arg_115_1.actors_["10044ui_story"].transform
			local var_118_24 = 2

			if var_118_24 < arg_115_1.time_ and arg_115_1.time_ <= var_118_24 + arg_118_0 then
				arg_115_1.var_.moveOldPos10044ui_story = var_118_23.localPosition
			end

			local var_118_25 = 0.001

			if var_118_24 <= arg_115_1.time_ and arg_115_1.time_ < var_118_24 + var_118_25 then
				local var_118_26 = (arg_115_1.time_ - var_118_24) / var_118_25
				local var_118_27 = Vector3.New(0, 100, 0)

				var_118_23.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10044ui_story, var_118_27, var_118_26)

				local var_118_28 = manager.ui.mainCamera.transform.position - var_118_23.position

				var_118_23.forward = Vector3.New(var_118_28.x, var_118_28.y, var_118_28.z)

				local var_118_29 = var_118_23.localEulerAngles

				var_118_29.z = 0
				var_118_29.x = 0
				var_118_23.localEulerAngles = var_118_29
			end

			if arg_115_1.time_ >= var_118_24 + var_118_25 and arg_115_1.time_ < var_118_24 + var_118_25 + arg_118_0 then
				var_118_23.localPosition = Vector3.New(0, 100, 0)

				local var_118_30 = manager.ui.mainCamera.transform.position - var_118_23.position

				var_118_23.forward = Vector3.New(var_118_30.x, var_118_30.y, var_118_30.z)

				local var_118_31 = var_118_23.localEulerAngles

				var_118_31.z = 0
				var_118_31.x = 0
				var_118_23.localEulerAngles = var_118_31
			end

			local var_118_32 = 1

			if var_118_32 < arg_115_1.time_ and arg_115_1.time_ <= var_118_32 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_33 = 1

			if var_118_32 <= arg_115_1.time_ and arg_115_1.time_ < var_118_32 + var_118_33 then
				local var_118_34 = (arg_115_1.time_ - var_118_32) / var_118_33
				local var_118_35 = Color.New(1, 1, 1)

				var_118_35.a = Mathf.Lerp(0, 1, var_118_34)
				arg_115_1.mask_.color = var_118_35
			end

			if arg_115_1.time_ >= var_118_32 + var_118_33 and arg_115_1.time_ < var_118_32 + var_118_33 + arg_118_0 then
				local var_118_36 = Color.New(1, 1, 1)

				var_118_36.a = 1
				arg_115_1.mask_.color = var_118_36
			end

			local var_118_37 = 2

			if var_118_37 < arg_115_1.time_ and arg_115_1.time_ <= var_118_37 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_38 = 2

			if var_118_37 <= arg_115_1.time_ and arg_115_1.time_ < var_118_37 + var_118_38 then
				local var_118_39 = (arg_115_1.time_ - var_118_37) / var_118_38
				local var_118_40 = Color.New(1, 1, 1)

				var_118_40.a = Mathf.Lerp(1, 0, var_118_39)
				arg_115_1.mask_.color = var_118_40
			end

			if arg_115_1.time_ >= var_118_37 + var_118_38 and arg_115_1.time_ < var_118_37 + var_118_38 + arg_118_0 then
				local var_118_41 = Color.New(1, 1, 1)
				local var_118_42 = 0

				arg_115_1.mask_.enabled = false
				var_118_41.a = var_118_42
				arg_115_1.mask_.color = var_118_41
			end

			local var_118_43 = 2

			if var_118_43 < arg_115_1.time_ and arg_115_1.time_ <= var_118_43 + arg_118_0 then
				arg_115_1.fswbg_:SetActive(true)
				arg_115_1.dialog_:SetActive(false)

				arg_115_1.fswtw_.percent = 0

				local var_118_44 = arg_115_1:GetWordFromCfg(120141028)
				local var_118_45 = arg_115_1:FormatText(var_118_44.content)

				arg_115_1.fswt_.text = var_118_45

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.fswt_)

				arg_115_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_115_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_115_1.fswtw_:SetDirty()

				arg_115_1.typewritterCharCountI18N = 0

				SetActive(arg_115_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_115_1:ShowNextGo(false)
			end

			local var_118_46 = 2.01666666666667

			if var_118_46 < arg_115_1.time_ and arg_115_1.time_ <= var_118_46 + arg_118_0 then
				arg_115_1.var_.oldValueTypewriter = arg_115_1.fswtw_.percent

				SetActive(arg_115_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_115_1:ShowNextGo(false)
			end

			local var_118_47 = 2
			local var_118_48 = 0.133333333333333
			local var_118_49 = arg_115_1:GetWordFromCfg(120141028)
			local var_118_50 = arg_115_1:FormatText(var_118_49.content)
			local var_118_51, var_118_52 = arg_115_1:GetPercentByPara(var_118_50, 1)

			if var_118_46 < arg_115_1.time_ and arg_115_1.time_ <= var_118_46 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				local var_118_53 = var_118_47 <= 0 and var_118_48 or var_118_48 * ((var_118_52 - arg_115_1.typewritterCharCountI18N) / var_118_47)

				if var_118_53 > 0 and var_118_48 < var_118_53 then
					arg_115_1.talkMaxDuration = var_118_53

					if var_118_53 + var_118_46 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_53 + var_118_46
					end
				end
			end

			local var_118_54 = 0.133333333333333
			local var_118_55 = math.max(var_118_54, arg_115_1.talkMaxDuration)

			if var_118_46 <= arg_115_1.time_ and arg_115_1.time_ < var_118_46 + var_118_55 then
				local var_118_56 = (arg_115_1.time_ - var_118_46) / var_118_55

				arg_115_1.fswtw_.percent = Mathf.Lerp(arg_115_1.var_.oldValueTypewriter, var_118_51, var_118_56)
				arg_115_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_115_1.fswtw_:SetDirty()
			end

			if arg_115_1.time_ >= var_118_46 + var_118_55 and arg_115_1.time_ < var_118_46 + var_118_55 + arg_118_0 then
				arg_115_1.fswtw_.percent = var_118_51

				arg_115_1.fswtw_:SetDirty()
				arg_115_1:ShowNextGo(true)

				arg_115_1.typewritterCharCountI18N = var_118_52
			end

			local var_118_57 = 2

			if var_118_57 < arg_115_1.time_ and arg_115_1.time_ <= var_118_57 + arg_118_0 then
				local var_118_58 = arg_115_1.fswbg_.transform:Find("textbox/adapt/content") or arg_115_1.fswbg_.transform:Find("textbox/content")
				local var_118_59 = arg_115_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_118_60 = var_118_58:GetComponent("Text")
				local var_118_61 = var_118_58:GetComponent("RectTransform")

				var_118_60.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_118_61.offsetMin = Vector2.New(0, 0)
				var_118_61.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play120141029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 120141029
		arg_119_1.duration_ = 1.15

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play120141030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.fswbg_:SetActive(true)
				arg_119_1.dialog_:SetActive(false)

				arg_119_1.fswtw_.percent = 0

				local var_122_1 = arg_119_1:GetWordFromCfg(120141029)
				local var_122_2 = arg_119_1:FormatText(var_122_1.content)

				arg_119_1.fswt_.text = var_122_2

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.fswt_)

				arg_119_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_119_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_119_1.fswtw_:SetDirty()

				arg_119_1.typewritterCharCountI18N = 0

				SetActive(arg_119_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_119_1:ShowNextGo(false)
			end

			local var_122_3 = 0.0166666666666667

			if var_122_3 < arg_119_1.time_ and arg_119_1.time_ <= var_122_3 + arg_122_0 then
				arg_119_1.var_.oldValueTypewriter = arg_119_1.fswtw_.percent

				SetActive(arg_119_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_119_1:ShowNextGo(false)
			end

			local var_122_4 = 17
			local var_122_5 = 1.13333333333333
			local var_122_6 = arg_119_1:GetWordFromCfg(120141029)
			local var_122_7 = arg_119_1:FormatText(var_122_6.content)
			local var_122_8, var_122_9 = arg_119_1:GetPercentByPara(var_122_7, 1)

			if var_122_3 < arg_119_1.time_ and arg_119_1.time_ <= var_122_3 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0

				local var_122_10 = var_122_4 <= 0 and var_122_5 or var_122_5 * ((var_122_9 - arg_119_1.typewritterCharCountI18N) / var_122_4)

				if var_122_10 > 0 and var_122_5 < var_122_10 then
					arg_119_1.talkMaxDuration = var_122_10

					if var_122_10 + var_122_3 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_3
					end
				end
			end

			local var_122_11 = 1.13333333333333
			local var_122_12 = math.max(var_122_11, arg_119_1.talkMaxDuration)

			if var_122_3 <= arg_119_1.time_ and arg_119_1.time_ < var_122_3 + var_122_12 then
				local var_122_13 = (arg_119_1.time_ - var_122_3) / var_122_12

				arg_119_1.fswtw_.percent = Mathf.Lerp(arg_119_1.var_.oldValueTypewriter, var_122_8, var_122_13)
				arg_119_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_119_1.fswtw_:SetDirty()
			end

			if arg_119_1.time_ >= var_122_3 + var_122_12 and arg_119_1.time_ < var_122_3 + var_122_12 + arg_122_0 then
				arg_119_1.fswtw_.percent = var_122_8

				arg_119_1.fswtw_:SetDirty()
				arg_119_1:ShowNextGo(true)

				arg_119_1.typewritterCharCountI18N = var_122_9
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play120141030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 120141030
		arg_123_1.duration_ = 1.75

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play120141031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.fswbg_:SetActive(true)
				arg_123_1.dialog_:SetActive(false)

				arg_123_1.fswtw_.percent = 0

				local var_126_1 = arg_123_1:GetWordFromCfg(120141030)
				local var_126_2 = arg_123_1:FormatText(var_126_1.content)

				arg_123_1.fswt_.text = var_126_2

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.fswt_)

				arg_123_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_123_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_123_1.fswtw_:SetDirty()

				arg_123_1.typewritterCharCountI18N = 0

				SetActive(arg_123_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_123_1:ShowNextGo(false)
			end

			local var_126_3 = 0.0166666666666667

			if var_126_3 < arg_123_1.time_ and arg_123_1.time_ <= var_126_3 + arg_126_0 then
				arg_123_1.var_.oldValueTypewriter = arg_123_1.fswtw_.percent

				SetActive(arg_123_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_123_1:ShowNextGo(false)
			end

			local var_126_4 = 26
			local var_126_5 = 1.73333333333333
			local var_126_6 = arg_123_1:GetWordFromCfg(120141030)
			local var_126_7 = arg_123_1:FormatText(var_126_6.content)
			local var_126_8, var_126_9 = arg_123_1:GetPercentByPara(var_126_7, 1)

			if var_126_3 < arg_123_1.time_ and arg_123_1.time_ <= var_126_3 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				local var_126_10 = var_126_4 <= 0 and var_126_5 or var_126_5 * ((var_126_9 - arg_123_1.typewritterCharCountI18N) / var_126_4)

				if var_126_10 > 0 and var_126_5 < var_126_10 then
					arg_123_1.talkMaxDuration = var_126_10

					if var_126_10 + var_126_3 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_10 + var_126_3
					end
				end
			end

			local var_126_11 = 1.73333333333333
			local var_126_12 = math.max(var_126_11, arg_123_1.talkMaxDuration)

			if var_126_3 <= arg_123_1.time_ and arg_123_1.time_ < var_126_3 + var_126_12 then
				local var_126_13 = (arg_123_1.time_ - var_126_3) / var_126_12

				arg_123_1.fswtw_.percent = Mathf.Lerp(arg_123_1.var_.oldValueTypewriter, var_126_8, var_126_13)
				arg_123_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_123_1.fswtw_:SetDirty()
			end

			if arg_123_1.time_ >= var_126_3 + var_126_12 and arg_123_1.time_ < var_126_3 + var_126_12 + arg_126_0 then
				arg_123_1.fswtw_.percent = var_126_8

				arg_123_1.fswtw_:SetDirty()
				arg_123_1:ShowNextGo(true)

				arg_123_1.typewritterCharCountI18N = var_126_9
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play120141031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 120141031
		arg_127_1.duration_ = 1

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play120141032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.fswbg_:SetActive(true)
				arg_127_1.dialog_:SetActive(false)

				arg_127_1.fswtw_.percent = 0

				local var_130_1 = arg_127_1:GetWordFromCfg(120141031)
				local var_130_2 = arg_127_1:FormatText(var_130_1.content)

				arg_127_1.fswt_.text = var_130_2

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.fswt_)

				arg_127_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_127_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_127_1.fswtw_:SetDirty()

				arg_127_1.typewritterCharCountI18N = 0

				SetActive(arg_127_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_127_1:ShowNextGo(false)
			end

			local var_130_3 = 0.0166666666666667

			if var_130_3 < arg_127_1.time_ and arg_127_1.time_ <= var_130_3 + arg_130_0 then
				arg_127_1.var_.oldValueTypewriter = arg_127_1.fswtw_.percent

				SetActive(arg_127_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_127_1:ShowNextGo(false)
			end

			local var_130_4 = 4
			local var_130_5 = 0.266666666666667
			local var_130_6 = arg_127_1:GetWordFromCfg(120141031)
			local var_130_7 = arg_127_1:FormatText(var_130_6.content)
			local var_130_8, var_130_9 = arg_127_1:GetPercentByPara(var_130_7, 1)

			if var_130_3 < arg_127_1.time_ and arg_127_1.time_ <= var_130_3 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				local var_130_10 = var_130_4 <= 0 and var_130_5 or var_130_5 * ((var_130_9 - arg_127_1.typewritterCharCountI18N) / var_130_4)

				if var_130_10 > 0 and var_130_5 < var_130_10 then
					arg_127_1.talkMaxDuration = var_130_10

					if var_130_10 + var_130_3 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_3
					end
				end
			end

			local var_130_11 = 0.266666666666667
			local var_130_12 = math.max(var_130_11, arg_127_1.talkMaxDuration)

			if var_130_3 <= arg_127_1.time_ and arg_127_1.time_ < var_130_3 + var_130_12 then
				local var_130_13 = (arg_127_1.time_ - var_130_3) / var_130_12

				arg_127_1.fswtw_.percent = Mathf.Lerp(arg_127_1.var_.oldValueTypewriter, var_130_8, var_130_13)
				arg_127_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_127_1.fswtw_:SetDirty()
			end

			if arg_127_1.time_ >= var_130_3 + var_130_12 and arg_127_1.time_ < var_130_3 + var_130_12 + arg_130_0 then
				arg_127_1.fswtw_.percent = var_130_8

				arg_127_1.fswtw_:SetDirty()
				arg_127_1:ShowNextGo(true)

				arg_127_1.typewritterCharCountI18N = var_130_9
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play120141032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 120141032
		arg_131_1.duration_ = 1.28

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play120141033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.fswbg_:SetActive(true)
				arg_131_1.dialog_:SetActive(false)

				arg_131_1.fswtw_.percent = 0

				local var_134_1 = arg_131_1:GetWordFromCfg(120141032)
				local var_134_2 = arg_131_1:FormatText(var_134_1.content)

				arg_131_1.fswt_.text = var_134_2

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.fswt_)

				arg_131_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_131_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_131_1.fswtw_:SetDirty()

				arg_131_1.typewritterCharCountI18N = 0

				SetActive(arg_131_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_131_1:ShowNextGo(false)
			end

			local var_134_3 = 0.0166666666666667

			if var_134_3 < arg_131_1.time_ and arg_131_1.time_ <= var_134_3 + arg_134_0 then
				arg_131_1.var_.oldValueTypewriter = arg_131_1.fswtw_.percent

				SetActive(arg_131_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_131_1:ShowNextGo(false)
			end

			local var_134_4 = 19
			local var_134_5 = 1.26666666666667
			local var_134_6 = arg_131_1:GetWordFromCfg(120141032)
			local var_134_7 = arg_131_1:FormatText(var_134_6.content)
			local var_134_8, var_134_9 = arg_131_1:GetPercentByPara(var_134_7, 1)

			if var_134_3 < arg_131_1.time_ and arg_131_1.time_ <= var_134_3 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0

				local var_134_10 = var_134_4 <= 0 and var_134_5 or var_134_5 * ((var_134_9 - arg_131_1.typewritterCharCountI18N) / var_134_4)

				if var_134_10 > 0 and var_134_5 < var_134_10 then
					arg_131_1.talkMaxDuration = var_134_10

					if var_134_10 + var_134_3 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_3
					end
				end
			end

			local var_134_11 = 1.26666666666667
			local var_134_12 = math.max(var_134_11, arg_131_1.talkMaxDuration)

			if var_134_3 <= arg_131_1.time_ and arg_131_1.time_ < var_134_3 + var_134_12 then
				local var_134_13 = (arg_131_1.time_ - var_134_3) / var_134_12

				arg_131_1.fswtw_.percent = Mathf.Lerp(arg_131_1.var_.oldValueTypewriter, var_134_8, var_134_13)
				arg_131_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_131_1.fswtw_:SetDirty()
			end

			if arg_131_1.time_ >= var_134_3 + var_134_12 and arg_131_1.time_ < var_134_3 + var_134_12 + arg_134_0 then
				arg_131_1.fswtw_.percent = var_134_8

				arg_131_1.fswtw_:SetDirty()
				arg_131_1:ShowNextGo(true)

				arg_131_1.typewritterCharCountI18N = var_134_9
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play120141033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 120141033
		arg_135_1.duration_ = 7.17

		local var_135_0 = {
			zh = 6.7,
			ja = 7.166
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
				arg_135_0:Play120141034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 2

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				local var_138_1 = manager.ui.mainCamera.transform.localPosition
				local var_138_2 = Vector3.New(0, 0, 10) + Vector3.New(var_138_1.x, var_138_1.y, 0)
				local var_138_3 = arg_135_1.bgs_.J04f

				var_138_3.transform.localPosition = var_138_2
				var_138_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_138_4 = var_138_3:GetComponent("SpriteRenderer")

				if var_138_4 and var_138_4.sprite then
					local var_138_5 = (var_138_3.transform.localPosition - var_138_1).z
					local var_138_6 = manager.ui.mainCameraCom_
					local var_138_7 = 2 * var_138_5 * Mathf.Tan(var_138_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_138_8 = var_138_7 * var_138_6.aspect
					local var_138_9 = var_138_4.sprite.bounds.size.x
					local var_138_10 = var_138_4.sprite.bounds.size.y
					local var_138_11 = var_138_8 / var_138_9
					local var_138_12 = var_138_7 / var_138_10
					local var_138_13 = var_138_12 < var_138_11 and var_138_11 or var_138_12

					var_138_3.transform.localScale = Vector3.New(var_138_13, var_138_13, 0)
				end

				for iter_138_0, iter_138_1 in pairs(arg_135_1.bgs_) do
					if iter_138_0 ~= "J04f" then
						iter_138_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_138_14 = 0

			if var_138_14 < arg_135_1.time_ and arg_135_1.time_ <= var_138_14 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_15 = 2

			if var_138_14 <= arg_135_1.time_ and arg_135_1.time_ < var_138_14 + var_138_15 then
				local var_138_16 = (arg_135_1.time_ - var_138_14) / var_138_15
				local var_138_17 = Color.New(1, 1, 1)

				var_138_17.a = Mathf.Lerp(0, 1, var_138_16)
				arg_135_1.mask_.color = var_138_17
			end

			if arg_135_1.time_ >= var_138_14 + var_138_15 and arg_135_1.time_ < var_138_14 + var_138_15 + arg_138_0 then
				local var_138_18 = Color.New(1, 1, 1)

				var_138_18.a = 1
				arg_135_1.mask_.color = var_138_18
			end

			local var_138_19 = 2

			if var_138_19 < arg_135_1.time_ and arg_135_1.time_ <= var_138_19 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_20 = 2

			if var_138_19 <= arg_135_1.time_ and arg_135_1.time_ < var_138_19 + var_138_20 then
				local var_138_21 = (arg_135_1.time_ - var_138_19) / var_138_20
				local var_138_22 = Color.New(1, 1, 1)

				var_138_22.a = Mathf.Lerp(1, 0, var_138_21)
				arg_135_1.mask_.color = var_138_22
			end

			if arg_135_1.time_ >= var_138_19 + var_138_20 and arg_135_1.time_ < var_138_19 + var_138_20 + arg_138_0 then
				local var_138_23 = Color.New(1, 1, 1)
				local var_138_24 = 0

				arg_135_1.mask_.enabled = false
				var_138_23.a = var_138_24
				arg_135_1.mask_.color = var_138_23
			end

			local var_138_25 = arg_135_1.actors_["1075ui_story"].transform
			local var_138_26 = 2

			if var_138_26 < arg_135_1.time_ and arg_135_1.time_ <= var_138_26 + arg_138_0 then
				arg_135_1.var_.moveOldPos1075ui_story = var_138_25.localPosition
			end

			local var_138_27 = 0.001

			if var_138_26 <= arg_135_1.time_ and arg_135_1.time_ < var_138_26 + var_138_27 then
				local var_138_28 = (arg_135_1.time_ - var_138_26) / var_138_27
				local var_138_29 = Vector3.New(0, -1.055, -6.16)

				var_138_25.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1075ui_story, var_138_29, var_138_28)

				local var_138_30 = manager.ui.mainCamera.transform.position - var_138_25.position

				var_138_25.forward = Vector3.New(var_138_30.x, var_138_30.y, var_138_30.z)

				local var_138_31 = var_138_25.localEulerAngles

				var_138_31.z = 0
				var_138_31.x = 0
				var_138_25.localEulerAngles = var_138_31
			end

			if arg_135_1.time_ >= var_138_26 + var_138_27 and arg_135_1.time_ < var_138_26 + var_138_27 + arg_138_0 then
				var_138_25.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_138_32 = manager.ui.mainCamera.transform.position - var_138_25.position

				var_138_25.forward = Vector3.New(var_138_32.x, var_138_32.y, var_138_32.z)

				local var_138_33 = var_138_25.localEulerAngles

				var_138_33.z = 0
				var_138_33.x = 0
				var_138_25.localEulerAngles = var_138_33
			end

			local var_138_34 = arg_135_1.actors_["1075ui_story"]
			local var_138_35 = 2

			if var_138_35 < arg_135_1.time_ and arg_135_1.time_ <= var_138_35 + arg_138_0 and not isNil(var_138_34) and arg_135_1.var_.characterEffect1075ui_story == nil then
				arg_135_1.var_.characterEffect1075ui_story = var_138_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_36 = 0.2

			if var_138_35 <= arg_135_1.time_ and arg_135_1.time_ < var_138_35 + var_138_36 and not isNil(var_138_34) then
				local var_138_37 = (arg_135_1.time_ - var_138_35) / var_138_36

				if arg_135_1.var_.characterEffect1075ui_story and not isNil(var_138_34) then
					arg_135_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_35 + var_138_36 and arg_135_1.time_ < var_138_35 + var_138_36 + arg_138_0 and not isNil(var_138_34) and arg_135_1.var_.characterEffect1075ui_story then
				arg_135_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_138_38 = 2

			if var_138_38 < arg_135_1.time_ and arg_135_1.time_ <= var_138_38 + arg_138_0 then
				arg_135_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action7_2")
			end

			local var_138_39 = 2

			if var_138_39 < arg_135_1.time_ and arg_135_1.time_ <= var_138_39 + arg_138_0 then
				arg_135_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_138_40 = 0

			if var_138_40 < arg_135_1.time_ and arg_135_1.time_ <= var_138_40 + arg_138_0 then
				arg_135_1.fswbg_:SetActive(false)
				arg_135_1.dialog_:SetActive(false)
				SetActive(arg_135_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_135_1:ShowNextGo(false)
			end

			if arg_135_1.frameCnt_ <= 1 then
				arg_135_1.dialog_:SetActive(false)
			end

			local var_138_41 = 4
			local var_138_42 = 0.4

			if var_138_41 < arg_135_1.time_ and arg_135_1.time_ <= var_138_41 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				arg_135_1.dialog_:SetActive(true)

				arg_135_1.dialogCg_.alpha = 0

				local var_138_43 = LeanTween.value(arg_135_1.dialog_, 0, 1, 0.3)

				var_138_43:setOnUpdate(LuaHelper.FloatAction(function(arg_139_0)
					arg_135_1.dialogCg_.alpha = arg_139_0
				end))
				var_138_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_135_1.dialog_)
					var_138_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_135_1.duration_ = arg_135_1.duration_ + 0.3

				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_44 = arg_135_1:FormatText(StoryNameCfg[381].name)

				arg_135_1.leftNameTxt_.text = var_138_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_45 = arg_135_1:GetWordFromCfg(120141033)
				local var_138_46 = arg_135_1:FormatText(var_138_45.content)

				arg_135_1.text_.text = var_138_46

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_47 = 16
				local var_138_48 = utf8.len(var_138_46)
				local var_138_49 = var_138_47 <= 0 and var_138_42 or var_138_42 * (var_138_48 / var_138_47)

				if var_138_49 > 0 and var_138_42 < var_138_49 then
					arg_135_1.talkMaxDuration = var_138_49
					var_138_41 = var_138_41 + 0.3

					if var_138_49 + var_138_41 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_49 + var_138_41
					end
				end

				arg_135_1.text_.text = var_138_46
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141033", "story_v_out_120141.awb") ~= 0 then
					local var_138_50 = manager.audio:GetVoiceLength("story_v_out_120141", "120141033", "story_v_out_120141.awb") / 1000

					if var_138_50 + var_138_41 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_50 + var_138_41
					end

					if var_138_45.prefab_name ~= "" and arg_135_1.actors_[var_138_45.prefab_name] ~= nil then
						local var_138_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_45.prefab_name].transform, "story_v_out_120141", "120141033", "story_v_out_120141.awb")

						arg_135_1:RecordAudio("120141033", var_138_51)
						arg_135_1:RecordAudio("120141033", var_138_51)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_120141", "120141033", "story_v_out_120141.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_120141", "120141033", "story_v_out_120141.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_52 = var_138_41 + 0.3
			local var_138_53 = math.max(var_138_42, arg_135_1.talkMaxDuration)

			if var_138_52 <= arg_135_1.time_ and arg_135_1.time_ < var_138_52 + var_138_53 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_52) / var_138_53

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_52 + var_138_53 and arg_135_1.time_ < var_138_52 + var_138_53 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play120141034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 120141034
		arg_141_1.duration_ = 5.13

		local var_141_0 = {
			zh = 5.133,
			ja = 4.5
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
				arg_141_0:Play120141035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_144_1 = 0
			local var_144_2 = 0.525

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_3 = arg_141_1:FormatText(StoryNameCfg[381].name)

				arg_141_1.leftNameTxt_.text = var_144_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_4 = arg_141_1:GetWordFromCfg(120141034)
				local var_144_5 = arg_141_1:FormatText(var_144_4.content)

				arg_141_1.text_.text = var_144_5

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_6 = 21
				local var_144_7 = utf8.len(var_144_5)
				local var_144_8 = var_144_6 <= 0 and var_144_2 or var_144_2 * (var_144_7 / var_144_6)

				if var_144_8 > 0 and var_144_2 < var_144_8 then
					arg_141_1.talkMaxDuration = var_144_8

					if var_144_8 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_1
					end
				end

				arg_141_1.text_.text = var_144_5
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141034", "story_v_out_120141.awb") ~= 0 then
					local var_144_9 = manager.audio:GetVoiceLength("story_v_out_120141", "120141034", "story_v_out_120141.awb") / 1000

					if var_144_9 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_1
					end

					if var_144_4.prefab_name ~= "" and arg_141_1.actors_[var_144_4.prefab_name] ~= nil then
						local var_144_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_4.prefab_name].transform, "story_v_out_120141", "120141034", "story_v_out_120141.awb")

						arg_141_1:RecordAudio("120141034", var_144_10)
						arg_141_1:RecordAudio("120141034", var_144_10)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_120141", "120141034", "story_v_out_120141.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_120141", "120141034", "story_v_out_120141.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_11 = math.max(var_144_2, arg_141_1.talkMaxDuration)

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_11 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_1) / var_144_11

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_1 + var_144_11 and arg_141_1.time_ < var_144_1 + var_144_11 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play120141035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 120141035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play120141036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1075ui_story"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1075ui_story == nil then
				arg_145_1.var_.characterEffect1075ui_story = var_148_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.2

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.characterEffect1075ui_story and not isNil(var_148_0) then
					local var_148_4 = Mathf.Lerp(0, 0.5, var_148_3)

					arg_145_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1075ui_story.fillRatio = var_148_4
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1075ui_story then
				local var_148_5 = 0.5

				arg_145_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1075ui_story.fillRatio = var_148_5
			end

			local var_148_6 = arg_145_1.actors_["1075ui_story"].transform
			local var_148_7 = 0

			if var_148_7 < arg_145_1.time_ and arg_145_1.time_ <= var_148_7 + arg_148_0 then
				arg_145_1.var_.moveOldPos1075ui_story = var_148_6.localPosition
			end

			local var_148_8 = 0.001

			if var_148_7 <= arg_145_1.time_ and arg_145_1.time_ < var_148_7 + var_148_8 then
				local var_148_9 = (arg_145_1.time_ - var_148_7) / var_148_8
				local var_148_10 = Vector3.New(0, 100, 0)

				var_148_6.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1075ui_story, var_148_10, var_148_9)

				local var_148_11 = manager.ui.mainCamera.transform.position - var_148_6.position

				var_148_6.forward = Vector3.New(var_148_11.x, var_148_11.y, var_148_11.z)

				local var_148_12 = var_148_6.localEulerAngles

				var_148_12.z = 0
				var_148_12.x = 0
				var_148_6.localEulerAngles = var_148_12
			end

			if arg_145_1.time_ >= var_148_7 + var_148_8 and arg_145_1.time_ < var_148_7 + var_148_8 + arg_148_0 then
				var_148_6.localPosition = Vector3.New(0, 100, 0)

				local var_148_13 = manager.ui.mainCamera.transform.position - var_148_6.position

				var_148_6.forward = Vector3.New(var_148_13.x, var_148_13.y, var_148_13.z)

				local var_148_14 = var_148_6.localEulerAngles

				var_148_14.z = 0
				var_148_14.x = 0
				var_148_6.localEulerAngles = var_148_14
			end

			local var_148_15 = 0
			local var_148_16 = 0.6

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_17 = arg_145_1:GetWordFromCfg(120141035)
				local var_148_18 = arg_145_1:FormatText(var_148_17.content)

				arg_145_1.text_.text = var_148_18

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_19 = 24
				local var_148_20 = utf8.len(var_148_18)
				local var_148_21 = var_148_19 <= 0 and var_148_16 or var_148_16 * (var_148_20 / var_148_19)

				if var_148_21 > 0 and var_148_16 < var_148_21 then
					arg_145_1.talkMaxDuration = var_148_21

					if var_148_21 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_21 + var_148_15
					end
				end

				arg_145_1.text_.text = var_148_18
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_22 = math.max(var_148_16, arg_145_1.talkMaxDuration)

			if var_148_15 <= arg_145_1.time_ and arg_145_1.time_ < var_148_15 + var_148_22 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_15) / var_148_22

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_15 + var_148_22 and arg_145_1.time_ < var_148_15 + var_148_22 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
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

		arg_145_1:InitPlayNodeList()
	end,
	Play120141036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 120141036
		arg_149_1.duration_ = 1.13

		local var_149_0 = {
			zh = 1.066,
			ja = 1.133
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
				arg_149_0:Play120141037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.05

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[387].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10044")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_3 = arg_149_1:GetWordFromCfg(120141036)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 2
				local var_152_6 = utf8.len(var_152_4)
				local var_152_7 = var_152_5 <= 0 and var_152_1 or var_152_1 * (var_152_6 / var_152_5)

				if var_152_7 > 0 and var_152_1 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141036", "story_v_out_120141.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_120141", "120141036", "story_v_out_120141.awb") / 1000

					if var_152_8 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_0
					end

					if var_152_3.prefab_name ~= "" and arg_149_1.actors_[var_152_3.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_3.prefab_name].transform, "story_v_out_120141", "120141036", "story_v_out_120141.awb")

						arg_149_1:RecordAudio("120141036", var_152_9)
						arg_149_1:RecordAudio("120141036", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_120141", "120141036", "story_v_out_120141.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_120141", "120141036", "story_v_out_120141.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_10 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_10

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_10 and arg_149_1.time_ < var_152_0 + var_152_10 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play120141037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 120141037
		arg_153_1.duration_ = 7

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play120141038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = "XH0107"

			if arg_153_1.bgs_[var_156_0] == nil then
				local var_156_1 = Object.Instantiate(arg_153_1.paintGo_)

				var_156_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_156_0)
				var_156_1.name = var_156_0
				var_156_1.transform.parent = arg_153_1.stage_.transform
				var_156_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_153_1.bgs_[var_156_0] = var_156_1
			end

			local var_156_2 = 0

			if var_156_2 < arg_153_1.time_ and arg_153_1.time_ <= var_156_2 + arg_156_0 then
				local var_156_3 = manager.ui.mainCamera.transform.localPosition
				local var_156_4 = Vector3.New(0, 0, 10) + Vector3.New(var_156_3.x, var_156_3.y, 0)
				local var_156_5 = arg_153_1.bgs_.XH0107

				var_156_5.transform.localPosition = var_156_4
				var_156_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_156_6 = var_156_5:GetComponent("SpriteRenderer")

				if var_156_6 and var_156_6.sprite then
					local var_156_7 = (var_156_5.transform.localPosition - var_156_3).z
					local var_156_8 = manager.ui.mainCameraCom_
					local var_156_9 = 2 * var_156_7 * Mathf.Tan(var_156_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_156_10 = var_156_9 * var_156_8.aspect
					local var_156_11 = var_156_6.sprite.bounds.size.x
					local var_156_12 = var_156_6.sprite.bounds.size.y
					local var_156_13 = var_156_10 / var_156_11
					local var_156_14 = var_156_9 / var_156_12
					local var_156_15 = var_156_14 < var_156_13 and var_156_13 or var_156_14

					var_156_5.transform.localScale = Vector3.New(var_156_15, var_156_15, 0)
				end

				for iter_156_0, iter_156_1 in pairs(arg_153_1.bgs_) do
					if iter_156_0 ~= "XH0107" then
						iter_156_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_156_16 = arg_153_1.actors_["10044ui_story"].transform
			local var_156_17 = 0

			if var_156_17 < arg_153_1.time_ and arg_153_1.time_ <= var_156_17 + arg_156_0 then
				arg_153_1.var_.moveOldPos10044ui_story = var_156_16.localPosition
			end

			local var_156_18 = 0.001

			if var_156_17 <= arg_153_1.time_ and arg_153_1.time_ < var_156_17 + var_156_18 then
				local var_156_19 = (arg_153_1.time_ - var_156_17) / var_156_18
				local var_156_20 = Vector3.New(0, 100, 0)

				var_156_16.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10044ui_story, var_156_20, var_156_19)

				local var_156_21 = manager.ui.mainCamera.transform.position - var_156_16.position

				var_156_16.forward = Vector3.New(var_156_21.x, var_156_21.y, var_156_21.z)

				local var_156_22 = var_156_16.localEulerAngles

				var_156_22.z = 0
				var_156_22.x = 0
				var_156_16.localEulerAngles = var_156_22
			end

			if arg_153_1.time_ >= var_156_17 + var_156_18 and arg_153_1.time_ < var_156_17 + var_156_18 + arg_156_0 then
				var_156_16.localPosition = Vector3.New(0, 100, 0)

				local var_156_23 = manager.ui.mainCamera.transform.position - var_156_16.position

				var_156_16.forward = Vector3.New(var_156_23.x, var_156_23.y, var_156_23.z)

				local var_156_24 = var_156_16.localEulerAngles

				var_156_24.z = 0
				var_156_24.x = 0
				var_156_16.localEulerAngles = var_156_24
			end

			local var_156_25 = 0

			if var_156_25 < arg_153_1.time_ and arg_153_1.time_ <= var_156_25 + arg_156_0 then
				arg_153_1.mask_.enabled = true
				arg_153_1.mask_.raycastTarget = true

				arg_153_1:SetGaussion(false)
			end

			local var_156_26 = 2

			if var_156_25 <= arg_153_1.time_ and arg_153_1.time_ < var_156_25 + var_156_26 then
				local var_156_27 = (arg_153_1.time_ - var_156_25) / var_156_26
				local var_156_28 = Color.New(1, 1, 1)

				var_156_28.a = Mathf.Lerp(1, 0, var_156_27)
				arg_153_1.mask_.color = var_156_28
			end

			if arg_153_1.time_ >= var_156_25 + var_156_26 and arg_153_1.time_ < var_156_25 + var_156_26 + arg_156_0 then
				local var_156_29 = Color.New(1, 1, 1)
				local var_156_30 = 0

				arg_153_1.mask_.enabled = false
				var_156_29.a = var_156_30
				arg_153_1.mask_.color = var_156_29
			end

			local var_156_31 = 1.99933333333333
			local var_156_32 = 1

			if var_156_31 < arg_153_1.time_ and arg_153_1.time_ <= var_156_31 + arg_156_0 then
				local var_156_33 = "play"
				local var_156_34 = "effect"

				arg_153_1:AudioAction(var_156_33, var_156_34, "se_story_120_00", "se_story_120_00_lingguang05", "")
			end

			local var_156_35 = arg_153_1.bgs_.XH0107.transform
			local var_156_36 = 0

			if var_156_36 < arg_153_1.time_ and arg_153_1.time_ <= var_156_36 + arg_156_0 then
				arg_153_1.var_.moveOldPosXH0107 = var_156_35.localPosition
			end

			local var_156_37 = 0.001

			if var_156_36 <= arg_153_1.time_ and arg_153_1.time_ < var_156_36 + var_156_37 then
				local var_156_38 = (arg_153_1.time_ - var_156_36) / var_156_37
				local var_156_39 = Vector3.New(0, 1, 9.5)

				var_156_35.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPosXH0107, var_156_39, var_156_38)
			end

			if arg_153_1.time_ >= var_156_36 + var_156_37 and arg_153_1.time_ < var_156_36 + var_156_37 + arg_156_0 then
				var_156_35.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_156_40 = arg_153_1.bgs_.XH0107.transform
			local var_156_41 = 0.0339999999999998

			if var_156_41 < arg_153_1.time_ and arg_153_1.time_ <= var_156_41 + arg_156_0 then
				arg_153_1.var_.moveOldPosXH0107 = var_156_40.localPosition
			end

			local var_156_42 = 4.5

			if var_156_41 <= arg_153_1.time_ and arg_153_1.time_ < var_156_41 + var_156_42 then
				local var_156_43 = (arg_153_1.time_ - var_156_41) / var_156_42
				local var_156_44 = Vector3.New(0, 1, 10)

				var_156_40.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPosXH0107, var_156_44, var_156_43)
			end

			if arg_153_1.time_ >= var_156_41 + var_156_42 and arg_153_1.time_ < var_156_41 + var_156_42 + arg_156_0 then
				var_156_40.localPosition = Vector3.New(0, 1, 10)
			end

			local var_156_45 = 2.99933333333333

			if var_156_45 < arg_153_1.time_ and arg_153_1.time_ <= var_156_45 + arg_156_0 then
				arg_153_1.allBtn_.enabled = false
			end

			local var_156_46 = 1.53466666666667

			if arg_153_1.time_ >= var_156_45 + var_156_46 and arg_153_1.time_ < var_156_45 + var_156_46 + arg_156_0 then
				arg_153_1.allBtn_.enabled = true
			end

			if arg_153_1.frameCnt_ <= 1 then
				arg_153_1.dialog_:SetActive(false)
			end

			local var_156_47 = 1.99933333333333
			local var_156_48 = 1.4

			if var_156_47 < arg_153_1.time_ and arg_153_1.time_ <= var_156_47 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				arg_153_1.dialog_:SetActive(true)

				arg_153_1.dialogCg_.alpha = 0

				local var_156_49 = LeanTween.value(arg_153_1.dialog_, 0, 1, 0.3)

				var_156_49:setOnUpdate(LuaHelper.FloatAction(function(arg_157_0)
					arg_153_1.dialogCg_.alpha = arg_157_0
				end))
				var_156_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_153_1.dialog_)
					var_156_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_153_1.duration_ = arg_153_1.duration_ + 0.3

				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_50 = arg_153_1:GetWordFromCfg(120141037)
				local var_156_51 = arg_153_1:FormatText(var_156_50.content)

				arg_153_1.text_.text = var_156_51

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_52 = 56
				local var_156_53 = utf8.len(var_156_51)
				local var_156_54 = var_156_52 <= 0 and var_156_48 or var_156_48 * (var_156_53 / var_156_52)

				if var_156_54 > 0 and var_156_48 < var_156_54 then
					arg_153_1.talkMaxDuration = var_156_54
					var_156_47 = var_156_47 + 0.3

					if var_156_54 + var_156_47 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_54 + var_156_47
					end
				end

				arg_153_1.text_.text = var_156_51
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_55 = var_156_47 + 0.3
			local var_156_56 = math.max(var_156_48, arg_153_1.talkMaxDuration)

			if var_156_55 <= arg_153_1.time_ and arg_153_1.time_ < var_156_55 + var_156_56 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_55) / var_156_56

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_55 + var_156_56 and arg_153_1.time_ < var_156_55 + var_156_56 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "XH0107",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0107",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 0.0339999999999998,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play120141038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 120141038
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play120141039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 1.025

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

				local var_162_2 = arg_159_1:GetWordFromCfg(120141038)
				local var_162_3 = arg_159_1:FormatText(var_162_2.content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 41
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
	Play120141039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 120141039
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play120141040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 1.475

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

				local var_166_2 = arg_163_1:GetWordFromCfg(120141039)
				local var_166_3 = arg_163_1:FormatText(var_166_2.content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 59
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
	Play120141040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 120141040
		arg_167_1.duration_ = 2.7

		local var_167_0 = {
			zh = 2.333,
			ja = 2.7
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
				arg_167_0:Play120141041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.15

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[387].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10044")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:GetWordFromCfg(120141040)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 6
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_1 or var_170_1 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_1 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141040", "story_v_out_120141.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_120141", "120141040", "story_v_out_120141.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_120141", "120141040", "story_v_out_120141.awb")

						arg_167_1:RecordAudio("120141040", var_170_9)
						arg_167_1:RecordAudio("120141040", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_120141", "120141040", "story_v_out_120141.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_120141", "120141040", "story_v_out_120141.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_10 and arg_167_1.time_ < var_170_0 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play120141041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 120141041
		arg_171_1.duration_ = 5.8

		local var_171_0 = {
			zh = 5.633,
			ja = 5.8
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
				arg_171_0:Play120141042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.6

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[381].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_3 = arg_171_1:GetWordFromCfg(120141041)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 24
				local var_174_6 = utf8.len(var_174_4)
				local var_174_7 = var_174_5 <= 0 and var_174_1 or var_174_1 * (var_174_6 / var_174_5)

				if var_174_7 > 0 and var_174_1 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_4
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141041", "story_v_out_120141.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_120141", "120141041", "story_v_out_120141.awb") / 1000

					if var_174_8 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_0
					end

					if var_174_3.prefab_name ~= "" and arg_171_1.actors_[var_174_3.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_3.prefab_name].transform, "story_v_out_120141", "120141041", "story_v_out_120141.awb")

						arg_171_1:RecordAudio("120141041", var_174_9)
						arg_171_1:RecordAudio("120141041", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_120141", "120141041", "story_v_out_120141.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_120141", "120141041", "story_v_out_120141.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_10 and arg_171_1.time_ < var_174_0 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play120141042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 120141042
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play120141043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 1.075

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_2 = arg_175_1:GetWordFromCfg(120141042)
				local var_178_3 = arg_175_1:FormatText(var_178_2.content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 43
				local var_178_5 = utf8.len(var_178_3)
				local var_178_6 = var_178_4 <= 0 and var_178_1 or var_178_1 * (var_178_5 / var_178_4)

				if var_178_6 > 0 and var_178_1 < var_178_6 then
					arg_175_1.talkMaxDuration = var_178_6

					if var_178_6 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_6 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_3
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_7 and arg_175_1.time_ < var_178_0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play120141043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 120141043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play120141044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.875

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_2 = arg_179_1:GetWordFromCfg(120141043)
				local var_182_3 = arg_179_1:FormatText(var_182_2.content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 35
				local var_182_5 = utf8.len(var_182_3)
				local var_182_6 = var_182_4 <= 0 and var_182_1 or var_182_1 * (var_182_5 / var_182_4)

				if var_182_6 > 0 and var_182_1 < var_182_6 then
					arg_179_1.talkMaxDuration = var_182_6

					if var_182_6 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_6 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_7 and arg_179_1.time_ < var_182_0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play120141044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 120141044
		arg_183_1.duration_ = 1.7

		local var_183_0 = {
			zh = 1.7,
			ja = 1.1
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
				arg_183_0:Play120141045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.075

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[387].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10044")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:GetWordFromCfg(120141044)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 3
				local var_186_6 = utf8.len(var_186_4)
				local var_186_7 = var_186_5 <= 0 and var_186_1 or var_186_1 * (var_186_6 / var_186_5)

				if var_186_7 > 0 and var_186_1 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141044", "story_v_out_120141.awb") ~= 0 then
					local var_186_8 = manager.audio:GetVoiceLength("story_v_out_120141", "120141044", "story_v_out_120141.awb") / 1000

					if var_186_8 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_0
					end

					if var_186_3.prefab_name ~= "" and arg_183_1.actors_[var_186_3.prefab_name] ~= nil then
						local var_186_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_3.prefab_name].transform, "story_v_out_120141", "120141044", "story_v_out_120141.awb")

						arg_183_1:RecordAudio("120141044", var_186_9)
						arg_183_1:RecordAudio("120141044", var_186_9)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_120141", "120141044", "story_v_out_120141.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_120141", "120141044", "story_v_out_120141.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_10 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_10 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_10

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_10 and arg_183_1.time_ < var_186_0 + var_186_10 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play120141045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 120141045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play120141046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 1

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				local var_190_2 = "stop"
				local var_190_3 = "effect"

				arg_187_1:AudioAction(var_190_2, var_190_3, "se_story_120_00", "se_story_120_00_sizzle", "")
			end

			local var_190_4 = 0
			local var_190_5 = 0.675

			if var_190_4 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_6 = arg_187_1:GetWordFromCfg(120141045)
				local var_190_7 = arg_187_1:FormatText(var_190_6.content)

				arg_187_1.text_.text = var_190_7

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_8 = 27
				local var_190_9 = utf8.len(var_190_7)
				local var_190_10 = var_190_8 <= 0 and var_190_5 or var_190_5 * (var_190_9 / var_190_8)

				if var_190_10 > 0 and var_190_5 < var_190_10 then
					arg_187_1.talkMaxDuration = var_190_10

					if var_190_10 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_7
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_11 = math.max(var_190_5, arg_187_1.talkMaxDuration)

			if var_190_4 <= arg_187_1.time_ and arg_187_1.time_ < var_190_4 + var_190_11 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_4) / var_190_11

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_4 + var_190_11 and arg_187_1.time_ < var_190_4 + var_190_11 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play120141046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 120141046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play120141047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 0.9

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_2 = arg_191_1:GetWordFromCfg(120141046)
				local var_194_3 = arg_191_1:FormatText(var_194_2.content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 36
				local var_194_5 = utf8.len(var_194_3)
				local var_194_6 = var_194_4 <= 0 and var_194_1 or var_194_1 * (var_194_5 / var_194_4)

				if var_194_6 > 0 and var_194_1 < var_194_6 then
					arg_191_1.talkMaxDuration = var_194_6

					if var_194_6 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_6 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_7 and arg_191_1.time_ < var_194_0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play120141047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 120141047
		arg_195_1.duration_ = 5.27

		local var_195_0 = {
			zh = 5.266,
			ja = 2.733
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
				arg_195_0:Play120141048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 0.325

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[380].name)

				arg_195_1.leftNameTxt_.text = var_198_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10044")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:GetWordFromCfg(120141047)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 13
				local var_198_6 = utf8.len(var_198_4)
				local var_198_7 = var_198_5 <= 0 and var_198_1 or var_198_1 * (var_198_6 / var_198_5)

				if var_198_7 > 0 and var_198_1 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_4
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141047", "story_v_out_120141.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_out_120141", "120141047", "story_v_out_120141.awb") / 1000

					if var_198_8 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_0
					end

					if var_198_3.prefab_name ~= "" and arg_195_1.actors_[var_198_3.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_3.prefab_name].transform, "story_v_out_120141", "120141047", "story_v_out_120141.awb")

						arg_195_1:RecordAudio("120141047", var_198_9)
						arg_195_1:RecordAudio("120141047", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_120141", "120141047", "story_v_out_120141.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_120141", "120141047", "story_v_out_120141.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_10 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_10 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_10

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_10 and arg_195_1.time_ < var_198_0 + var_198_10 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play120141048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 120141048
		arg_199_1.duration_ = 2

		local var_199_0 = {
			zh = 2,
			ja = 1.433
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
				arg_199_0:Play120141049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 0.1

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_2 = arg_199_1:FormatText(StoryNameCfg[381].name)

				arg_199_1.leftNameTxt_.text = var_202_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_3 = arg_199_1:GetWordFromCfg(120141048)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 4
				local var_202_6 = utf8.len(var_202_4)
				local var_202_7 = var_202_5 <= 0 and var_202_1 or var_202_1 * (var_202_6 / var_202_5)

				if var_202_7 > 0 and var_202_1 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141048", "story_v_out_120141.awb") ~= 0 then
					local var_202_8 = manager.audio:GetVoiceLength("story_v_out_120141", "120141048", "story_v_out_120141.awb") / 1000

					if var_202_8 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_0
					end

					if var_202_3.prefab_name ~= "" and arg_199_1.actors_[var_202_3.prefab_name] ~= nil then
						local var_202_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_3.prefab_name].transform, "story_v_out_120141", "120141048", "story_v_out_120141.awb")

						arg_199_1:RecordAudio("120141048", var_202_9)
						arg_199_1:RecordAudio("120141048", var_202_9)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_120141", "120141048", "story_v_out_120141.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_120141", "120141048", "story_v_out_120141.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_10 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_10 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_10

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_10 and arg_199_1.time_ < var_202_0 + var_202_10 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play120141049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 120141049
		arg_203_1.duration_ = 4

		local var_203_0 = {
			zh = 4,
			ja = 3.566
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play120141050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 0.25

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_2 = arg_203_1:FormatText(StoryNameCfg[380].name)

				arg_203_1.leftNameTxt_.text = var_206_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10044")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_3 = arg_203_1:GetWordFromCfg(120141049)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 10
				local var_206_6 = utf8.len(var_206_4)
				local var_206_7 = var_206_5 <= 0 and var_206_1 or var_206_1 * (var_206_6 / var_206_5)

				if var_206_7 > 0 and var_206_1 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_4
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141049", "story_v_out_120141.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_out_120141", "120141049", "story_v_out_120141.awb") / 1000

					if var_206_8 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_0
					end

					if var_206_3.prefab_name ~= "" and arg_203_1.actors_[var_206_3.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_3.prefab_name].transform, "story_v_out_120141", "120141049", "story_v_out_120141.awb")

						arg_203_1:RecordAudio("120141049", var_206_9)
						arg_203_1:RecordAudio("120141049", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_120141", "120141049", "story_v_out_120141.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_120141", "120141049", "story_v_out_120141.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_10 and arg_203_1.time_ < var_206_0 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play120141050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 120141050
		arg_207_1.duration_ = 3.07

		local var_207_0 = {
			zh = 2.2,
			ja = 3.066
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play120141051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.2

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_2 = arg_207_1:FormatText(StoryNameCfg[387].name)

				arg_207_1.leftNameTxt_.text = var_210_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10044")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_3 = arg_207_1:GetWordFromCfg(120141050)
				local var_210_4 = arg_207_1:FormatText(var_210_3.content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 8
				local var_210_6 = utf8.len(var_210_4)
				local var_210_7 = var_210_5 <= 0 and var_210_1 or var_210_1 * (var_210_6 / var_210_5)

				if var_210_7 > 0 and var_210_1 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_4
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141050", "story_v_out_120141.awb") ~= 0 then
					local var_210_8 = manager.audio:GetVoiceLength("story_v_out_120141", "120141050", "story_v_out_120141.awb") / 1000

					if var_210_8 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_0
					end

					if var_210_3.prefab_name ~= "" and arg_207_1.actors_[var_210_3.prefab_name] ~= nil then
						local var_210_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_3.prefab_name].transform, "story_v_out_120141", "120141050", "story_v_out_120141.awb")

						arg_207_1:RecordAudio("120141050", var_210_9)
						arg_207_1:RecordAudio("120141050", var_210_9)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_120141", "120141050", "story_v_out_120141.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_120141", "120141050", "story_v_out_120141.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_10 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_10 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_10

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_10 and arg_207_1.time_ < var_210_0 + var_210_10 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play120141051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 120141051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play120141052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 0.725

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_2 = arg_211_1:GetWordFromCfg(120141051)
				local var_214_3 = arg_211_1:FormatText(var_214_2.content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 29
				local var_214_5 = utf8.len(var_214_3)
				local var_214_6 = var_214_4 <= 0 and var_214_1 or var_214_1 * (var_214_5 / var_214_4)

				if var_214_6 > 0 and var_214_1 < var_214_6 then
					arg_211_1.talkMaxDuration = var_214_6

					if var_214_6 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_6 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_7 and arg_211_1.time_ < var_214_0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play120141052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 120141052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play120141053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = manager.ui.mainCamera.transform
			local var_218_1 = 0.5

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.shakeOldPos = var_218_0.localPosition
			end

			local var_218_2 = 0.6

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / 0.066
				local var_218_4, var_218_5 = math.modf(var_218_3)

				var_218_0.localPosition = Vector3.New(var_218_5 * 0.13, var_218_5 * 0.13, var_218_5 * 0.13) + arg_215_1.var_.shakeOldPos
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 then
				var_218_0.localPosition = arg_215_1.var_.shakeOldPos
			end

			local var_218_6 = 0
			local var_218_7 = 1

			if var_218_6 < arg_215_1.time_ and arg_215_1.time_ <= var_218_6 + arg_218_0 then
				local var_218_8 = "play"
				local var_218_9 = "effect"

				arg_215_1:AudioAction(var_218_8, var_218_9, "se_story_120_00", "se_story_120_00_lingguang06", "")
			end

			local var_218_10 = 0

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 then
				arg_215_1.allBtn_.enabled = false
			end

			local var_218_11 = 1.1

			if arg_215_1.time_ >= var_218_10 + var_218_11 and arg_215_1.time_ < var_218_10 + var_218_11 + arg_218_0 then
				arg_215_1.allBtn_.enabled = true
			end

			local var_218_12 = 0
			local var_218_13 = 1

			if var_218_12 < arg_215_1.time_ and arg_215_1.time_ <= var_218_12 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_14 = arg_215_1:GetWordFromCfg(120141052)
				local var_218_15 = arg_215_1:FormatText(var_218_14.content)

				arg_215_1.text_.text = var_218_15

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_16 = 40
				local var_218_17 = utf8.len(var_218_15)
				local var_218_18 = var_218_16 <= 0 and var_218_13 or var_218_13 * (var_218_17 / var_218_16)

				if var_218_18 > 0 and var_218_13 < var_218_18 then
					arg_215_1.talkMaxDuration = var_218_18

					if var_218_18 + var_218_12 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_18 + var_218_12
					end
				end

				arg_215_1.text_.text = var_218_15
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_19 = math.max(var_218_13, arg_215_1.talkMaxDuration)

			if var_218_12 <= arg_215_1.time_ and arg_215_1.time_ < var_218_12 + var_218_19 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_12) / var_218_19

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_12 + var_218_19 and arg_215_1.time_ < var_218_12 + var_218_19 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play120141053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 120141053
		arg_219_1.duration_ = 9

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play120141054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 2

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				local var_222_1 = manager.ui.mainCamera.transform.localPosition
				local var_222_2 = Vector3.New(0, 0, 10) + Vector3.New(var_222_1.x, var_222_1.y, 0)
				local var_222_3 = arg_219_1.bgs_.J04f

				var_222_3.transform.localPosition = var_222_2
				var_222_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_222_4 = var_222_3:GetComponent("SpriteRenderer")

				if var_222_4 and var_222_4.sprite then
					local var_222_5 = (var_222_3.transform.localPosition - var_222_1).z
					local var_222_6 = manager.ui.mainCameraCom_
					local var_222_7 = 2 * var_222_5 * Mathf.Tan(var_222_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_222_8 = var_222_7 * var_222_6.aspect
					local var_222_9 = var_222_4.sprite.bounds.size.x
					local var_222_10 = var_222_4.sprite.bounds.size.y
					local var_222_11 = var_222_8 / var_222_9
					local var_222_12 = var_222_7 / var_222_10
					local var_222_13 = var_222_12 < var_222_11 and var_222_11 or var_222_12

					var_222_3.transform.localScale = Vector3.New(var_222_13, var_222_13, 0)
				end

				for iter_222_0, iter_222_1 in pairs(arg_219_1.bgs_) do
					if iter_222_0 ~= "J04f" then
						iter_222_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_222_14 = 0

			if var_222_14 < arg_219_1.time_ and arg_219_1.time_ <= var_222_14 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_15 = 2

			if var_222_14 <= arg_219_1.time_ and arg_219_1.time_ < var_222_14 + var_222_15 then
				local var_222_16 = (arg_219_1.time_ - var_222_14) / var_222_15
				local var_222_17 = Color.New(0, 0, 0)

				var_222_17.a = Mathf.Lerp(0, 1, var_222_16)
				arg_219_1.mask_.color = var_222_17
			end

			if arg_219_1.time_ >= var_222_14 + var_222_15 and arg_219_1.time_ < var_222_14 + var_222_15 + arg_222_0 then
				local var_222_18 = Color.New(0, 0, 0)

				var_222_18.a = 1
				arg_219_1.mask_.color = var_222_18
			end

			local var_222_19 = 2

			if var_222_19 < arg_219_1.time_ and arg_219_1.time_ <= var_222_19 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_20 = 2

			if var_222_19 <= arg_219_1.time_ and arg_219_1.time_ < var_222_19 + var_222_20 then
				local var_222_21 = (arg_219_1.time_ - var_222_19) / var_222_20
				local var_222_22 = Color.New(0, 0, 0)

				var_222_22.a = Mathf.Lerp(1, 0, var_222_21)
				arg_219_1.mask_.color = var_222_22
			end

			if arg_219_1.time_ >= var_222_19 + var_222_20 and arg_219_1.time_ < var_222_19 + var_222_20 + arg_222_0 then
				local var_222_23 = Color.New(0, 0, 0)
				local var_222_24 = 0

				arg_219_1.mask_.enabled = false
				var_222_23.a = var_222_24
				arg_219_1.mask_.color = var_222_23
			end

			if arg_219_1.frameCnt_ <= 1 then
				arg_219_1.dialog_:SetActive(false)
			end

			local var_222_25 = 4
			local var_222_26 = 1

			if var_222_25 < arg_219_1.time_ and arg_219_1.time_ <= var_222_25 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				arg_219_1.dialog_:SetActive(true)

				arg_219_1.dialogCg_.alpha = 0

				local var_222_27 = LeanTween.value(arg_219_1.dialog_, 0, 1, 0.3)

				var_222_27:setOnUpdate(LuaHelper.FloatAction(function(arg_223_0)
					arg_219_1.dialogCg_.alpha = arg_223_0
				end))
				var_222_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_219_1.dialog_)
					var_222_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_219_1.duration_ = arg_219_1.duration_ + 0.3

				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_28 = arg_219_1:GetWordFromCfg(120141053)
				local var_222_29 = arg_219_1:FormatText(var_222_28.content)

				arg_219_1.text_.text = var_222_29

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_30 = 40
				local var_222_31 = utf8.len(var_222_29)
				local var_222_32 = var_222_30 <= 0 and var_222_26 or var_222_26 * (var_222_31 / var_222_30)

				if var_222_32 > 0 and var_222_26 < var_222_32 then
					arg_219_1.talkMaxDuration = var_222_32
					var_222_25 = var_222_25 + 0.3

					if var_222_32 + var_222_25 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_32 + var_222_25
					end
				end

				arg_219_1.text_.text = var_222_29
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_33 = var_222_25 + 0.3
			local var_222_34 = math.max(var_222_26, arg_219_1.talkMaxDuration)

			if var_222_33 <= arg_219_1.time_ and arg_219_1.time_ < var_222_33 + var_222_34 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_33) / var_222_34

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_33 + var_222_34 and arg_219_1.time_ < var_222_33 + var_222_34 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play120141054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 120141054
		arg_225_1.duration_ = 6.87

		local var_225_0 = {
			zh = 2,
			ja = 6.866
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play120141055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = "1184ui_story"

			if arg_225_1.actors_[var_228_0] == nil then
				local var_228_1 = Asset.Load("Char/" .. "1184ui_story")

				if not isNil(var_228_1) then
					local var_228_2 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_225_1.stage_.transform)

					var_228_2.name = var_228_0
					var_228_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_225_1.actors_[var_228_0] = var_228_2

					local var_228_3 = var_228_2:GetComponentInChildren(typeof(CharacterEffect))

					var_228_3.enabled = true

					local var_228_4 = GameObjectTools.GetOrAddComponent(var_228_2, typeof(DynamicBoneHelper))

					if var_228_4 then
						var_228_4:EnableDynamicBone(false)
					end

					arg_225_1:ShowWeapon(var_228_3.transform, false)

					arg_225_1.var_[var_228_0 .. "Animator"] = var_228_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_225_1.var_[var_228_0 .. "Animator"].applyRootMotion = true
					arg_225_1.var_[var_228_0 .. "LipSync"] = var_228_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_228_5 = arg_225_1.actors_["1184ui_story"].transform
			local var_228_6 = 0

			if var_228_6 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.var_.moveOldPos1184ui_story = var_228_5.localPosition

				local var_228_7 = "1184ui_story"

				arg_225_1:ShowWeapon(arg_225_1.var_[var_228_7 .. "Animator"].transform, true)
			end

			local var_228_8 = 0.001

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_8 then
				local var_228_9 = (arg_225_1.time_ - var_228_6) / var_228_8
				local var_228_10 = Vector3.New(0, -0.97, -6)

				var_228_5.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1184ui_story, var_228_10, var_228_9)

				local var_228_11 = manager.ui.mainCamera.transform.position - var_228_5.position

				var_228_5.forward = Vector3.New(var_228_11.x, var_228_11.y, var_228_11.z)

				local var_228_12 = var_228_5.localEulerAngles

				var_228_12.z = 0
				var_228_12.x = 0
				var_228_5.localEulerAngles = var_228_12
			end

			if arg_225_1.time_ >= var_228_6 + var_228_8 and arg_225_1.time_ < var_228_6 + var_228_8 + arg_228_0 then
				var_228_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_228_13 = manager.ui.mainCamera.transform.position - var_228_5.position

				var_228_5.forward = Vector3.New(var_228_13.x, var_228_13.y, var_228_13.z)

				local var_228_14 = var_228_5.localEulerAngles

				var_228_14.z = 0
				var_228_14.x = 0
				var_228_5.localEulerAngles = var_228_14
			end

			local var_228_15 = arg_225_1.actors_["1184ui_story"]
			local var_228_16 = 0

			if var_228_16 < arg_225_1.time_ and arg_225_1.time_ <= var_228_16 + arg_228_0 and not isNil(var_228_15) and arg_225_1.var_.characterEffect1184ui_story == nil then
				arg_225_1.var_.characterEffect1184ui_story = var_228_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_17 = 0.2

			if var_228_16 <= arg_225_1.time_ and arg_225_1.time_ < var_228_16 + var_228_17 and not isNil(var_228_15) then
				local var_228_18 = (arg_225_1.time_ - var_228_16) / var_228_17

				if arg_225_1.var_.characterEffect1184ui_story and not isNil(var_228_15) then
					arg_225_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_16 + var_228_17 and arg_225_1.time_ < var_228_16 + var_228_17 + arg_228_0 and not isNil(var_228_15) and arg_225_1.var_.characterEffect1184ui_story then
				arg_225_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_228_19 = 0

			if var_228_19 < arg_225_1.time_ and arg_225_1.time_ <= var_228_19 + arg_228_0 then
				arg_225_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_228_20 = 0

			if var_228_20 < arg_225_1.time_ and arg_225_1.time_ <= var_228_20 + arg_228_0 then
				arg_225_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_228_21 = 0
			local var_228_22 = 0.2

			if var_228_21 < arg_225_1.time_ and arg_225_1.time_ <= var_228_21 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_23 = arg_225_1:FormatText(StoryNameCfg[6].name)

				arg_225_1.leftNameTxt_.text = var_228_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_24 = arg_225_1:GetWordFromCfg(120141054)
				local var_228_25 = arg_225_1:FormatText(var_228_24.content)

				arg_225_1.text_.text = var_228_25

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_26 = 8
				local var_228_27 = utf8.len(var_228_25)
				local var_228_28 = var_228_26 <= 0 and var_228_22 or var_228_22 * (var_228_27 / var_228_26)

				if var_228_28 > 0 and var_228_22 < var_228_28 then
					arg_225_1.talkMaxDuration = var_228_28

					if var_228_28 + var_228_21 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_28 + var_228_21
					end
				end

				arg_225_1.text_.text = var_228_25
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141054", "story_v_out_120141.awb") ~= 0 then
					local var_228_29 = manager.audio:GetVoiceLength("story_v_out_120141", "120141054", "story_v_out_120141.awb") / 1000

					if var_228_29 + var_228_21 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_29 + var_228_21
					end

					if var_228_24.prefab_name ~= "" and arg_225_1.actors_[var_228_24.prefab_name] ~= nil then
						local var_228_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_24.prefab_name].transform, "story_v_out_120141", "120141054", "story_v_out_120141.awb")

						arg_225_1:RecordAudio("120141054", var_228_30)
						arg_225_1:RecordAudio("120141054", var_228_30)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_120141", "120141054", "story_v_out_120141.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_120141", "120141054", "story_v_out_120141.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_31 = math.max(var_228_22, arg_225_1.talkMaxDuration)

			if var_228_21 <= arg_225_1.time_ and arg_225_1.time_ < var_228_21 + var_228_31 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_21) / var_228_31

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_21 + var_228_31 and arg_225_1.time_ < var_228_21 + var_228_31 + arg_228_0 then
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
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play120141055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 120141055
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play120141056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1184ui_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1184ui_story == nil then
				arg_229_1.var_.characterEffect1184ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.2

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect1184ui_story and not isNil(var_232_0) then
					local var_232_4 = Mathf.Lerp(0, 0.5, var_232_3)

					arg_229_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1184ui_story.fillRatio = var_232_4
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1184ui_story then
				local var_232_5 = 0.5

				arg_229_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1184ui_story.fillRatio = var_232_5
			end

			local var_232_6 = 0
			local var_232_7 = 0.425

			if var_232_6 < arg_229_1.time_ and arg_229_1.time_ <= var_232_6 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_8 = arg_229_1:FormatText(StoryNameCfg[7].name)

				arg_229_1.leftNameTxt_.text = var_232_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_9 = arg_229_1:GetWordFromCfg(120141055)
				local var_232_10 = arg_229_1:FormatText(var_232_9.content)

				arg_229_1.text_.text = var_232_10

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_11 = 17
				local var_232_12 = utf8.len(var_232_10)
				local var_232_13 = var_232_11 <= 0 and var_232_7 or var_232_7 * (var_232_12 / var_232_11)

				if var_232_13 > 0 and var_232_7 < var_232_13 then
					arg_229_1.talkMaxDuration = var_232_13

					if var_232_13 + var_232_6 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_13 + var_232_6
					end
				end

				arg_229_1.text_.text = var_232_10
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_14 = math.max(var_232_7, arg_229_1.talkMaxDuration)

			if var_232_6 <= arg_229_1.time_ and arg_229_1.time_ < var_232_6 + var_232_14 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_6) / var_232_14

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_6 + var_232_14 and arg_229_1.time_ < var_232_6 + var_232_14 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play120141056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 120141056
		arg_233_1.duration_ = 5.27

		local var_233_0 = {
			zh = 5.266,
			ja = 5.2
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play120141057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = "10037ui_story"

			if arg_233_1.actors_[var_236_0] == nil then
				local var_236_1 = Asset.Load("Char/" .. "10037ui_story")

				if not isNil(var_236_1) then
					local var_236_2 = Object.Instantiate(Asset.Load("Char/" .. "10037ui_story"), arg_233_1.stage_.transform)

					var_236_2.name = var_236_0
					var_236_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_233_1.actors_[var_236_0] = var_236_2

					local var_236_3 = var_236_2:GetComponentInChildren(typeof(CharacterEffect))

					var_236_3.enabled = true

					local var_236_4 = GameObjectTools.GetOrAddComponent(var_236_2, typeof(DynamicBoneHelper))

					if var_236_4 then
						var_236_4:EnableDynamicBone(false)
					end

					arg_233_1:ShowWeapon(var_236_3.transform, false)

					arg_233_1.var_[var_236_0 .. "Animator"] = var_236_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_233_1.var_[var_236_0 .. "Animator"].applyRootMotion = true
					arg_233_1.var_[var_236_0 .. "LipSync"] = var_236_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_236_5 = arg_233_1.actors_["10037ui_story"].transform
			local var_236_6 = 0

			if var_236_6 < arg_233_1.time_ and arg_233_1.time_ <= var_236_6 + arg_236_0 then
				arg_233_1.var_.moveOldPos10037ui_story = var_236_5.localPosition
			end

			local var_236_7 = 0.001

			if var_236_6 <= arg_233_1.time_ and arg_233_1.time_ < var_236_6 + var_236_7 then
				local var_236_8 = (arg_233_1.time_ - var_236_6) / var_236_7
				local var_236_9 = Vector3.New(0, -1.13, -6.2)

				var_236_5.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10037ui_story, var_236_9, var_236_8)

				local var_236_10 = manager.ui.mainCamera.transform.position - var_236_5.position

				var_236_5.forward = Vector3.New(var_236_10.x, var_236_10.y, var_236_10.z)

				local var_236_11 = var_236_5.localEulerAngles

				var_236_11.z = 0
				var_236_11.x = 0
				var_236_5.localEulerAngles = var_236_11
			end

			if arg_233_1.time_ >= var_236_6 + var_236_7 and arg_233_1.time_ < var_236_6 + var_236_7 + arg_236_0 then
				var_236_5.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_236_12 = manager.ui.mainCamera.transform.position - var_236_5.position

				var_236_5.forward = Vector3.New(var_236_12.x, var_236_12.y, var_236_12.z)

				local var_236_13 = var_236_5.localEulerAngles

				var_236_13.z = 0
				var_236_13.x = 0
				var_236_5.localEulerAngles = var_236_13
			end

			local var_236_14 = arg_233_1.actors_["10037ui_story"]
			local var_236_15 = 0

			if var_236_15 < arg_233_1.time_ and arg_233_1.time_ <= var_236_15 + arg_236_0 and not isNil(var_236_14) and arg_233_1.var_.characterEffect10037ui_story == nil then
				arg_233_1.var_.characterEffect10037ui_story = var_236_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_16 = 0.2

			if var_236_15 <= arg_233_1.time_ and arg_233_1.time_ < var_236_15 + var_236_16 and not isNil(var_236_14) then
				local var_236_17 = (arg_233_1.time_ - var_236_15) / var_236_16

				if arg_233_1.var_.characterEffect10037ui_story and not isNil(var_236_14) then
					arg_233_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_15 + var_236_16 and arg_233_1.time_ < var_236_15 + var_236_16 + arg_236_0 and not isNil(var_236_14) and arg_233_1.var_.characterEffect10037ui_story then
				arg_233_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_236_18 = arg_233_1.actors_["1184ui_story"].transform
			local var_236_19 = 0

			if var_236_19 < arg_233_1.time_ and arg_233_1.time_ <= var_236_19 + arg_236_0 then
				arg_233_1.var_.moveOldPos1184ui_story = var_236_18.localPosition
			end

			local var_236_20 = 0.001

			if var_236_19 <= arg_233_1.time_ and arg_233_1.time_ < var_236_19 + var_236_20 then
				local var_236_21 = (arg_233_1.time_ - var_236_19) / var_236_20
				local var_236_22 = Vector3.New(0, 100, 0)

				var_236_18.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1184ui_story, var_236_22, var_236_21)

				local var_236_23 = manager.ui.mainCamera.transform.position - var_236_18.position

				var_236_18.forward = Vector3.New(var_236_23.x, var_236_23.y, var_236_23.z)

				local var_236_24 = var_236_18.localEulerAngles

				var_236_24.z = 0
				var_236_24.x = 0
				var_236_18.localEulerAngles = var_236_24
			end

			if arg_233_1.time_ >= var_236_19 + var_236_20 and arg_233_1.time_ < var_236_19 + var_236_20 + arg_236_0 then
				var_236_18.localPosition = Vector3.New(0, 100, 0)

				local var_236_25 = manager.ui.mainCamera.transform.position - var_236_18.position

				var_236_18.forward = Vector3.New(var_236_25.x, var_236_25.y, var_236_25.z)

				local var_236_26 = var_236_18.localEulerAngles

				var_236_26.z = 0
				var_236_26.x = 0
				var_236_18.localEulerAngles = var_236_26
			end

			local var_236_27 = 0

			if var_236_27 < arg_233_1.time_ and arg_233_1.time_ <= var_236_27 + arg_236_0 then
				arg_233_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action2_1")
			end

			local var_236_28 = 0
			local var_236_29 = 0.325

			if var_236_28 < arg_233_1.time_ and arg_233_1.time_ <= var_236_28 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_30 = arg_233_1:FormatText(StoryNameCfg[383].name)

				arg_233_1.leftNameTxt_.text = var_236_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_31 = arg_233_1:GetWordFromCfg(120141056)
				local var_236_32 = arg_233_1:FormatText(var_236_31.content)

				arg_233_1.text_.text = var_236_32

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_33 = 13
				local var_236_34 = utf8.len(var_236_32)
				local var_236_35 = var_236_33 <= 0 and var_236_29 or var_236_29 * (var_236_34 / var_236_33)

				if var_236_35 > 0 and var_236_29 < var_236_35 then
					arg_233_1.talkMaxDuration = var_236_35

					if var_236_35 + var_236_28 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_35 + var_236_28
					end
				end

				arg_233_1.text_.text = var_236_32
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141056", "story_v_out_120141.awb") ~= 0 then
					local var_236_36 = manager.audio:GetVoiceLength("story_v_out_120141", "120141056", "story_v_out_120141.awb") / 1000

					if var_236_36 + var_236_28 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_36 + var_236_28
					end

					if var_236_31.prefab_name ~= "" and arg_233_1.actors_[var_236_31.prefab_name] ~= nil then
						local var_236_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_31.prefab_name].transform, "story_v_out_120141", "120141056", "story_v_out_120141.awb")

						arg_233_1:RecordAudio("120141056", var_236_37)
						arg_233_1:RecordAudio("120141056", var_236_37)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_120141", "120141056", "story_v_out_120141.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_120141", "120141056", "story_v_out_120141.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_38 = math.max(var_236_29, arg_233_1.talkMaxDuration)

			if var_236_28 <= arg_233_1.time_ and arg_233_1.time_ < var_236_28 + var_236_38 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_28) / var_236_38

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_28 + var_236_38 and arg_233_1.time_ < var_236_28 + var_236_38 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
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

		arg_233_1:InitPlayNodeList()
	end,
	Play120141057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 120141057
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play120141058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["10037ui_story"]
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect10037ui_story == nil then
				arg_237_1.var_.characterEffect10037ui_story = var_240_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.2

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 and not isNil(var_240_0) then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2

				if arg_237_1.var_.characterEffect10037ui_story and not isNil(var_240_0) then
					local var_240_4 = Mathf.Lerp(0, 0.5, var_240_3)

					arg_237_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_237_1.var_.characterEffect10037ui_story.fillRatio = var_240_4
				end
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect10037ui_story then
				local var_240_5 = 0.5

				arg_237_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_237_1.var_.characterEffect10037ui_story.fillRatio = var_240_5
			end

			local var_240_6 = 0
			local var_240_7 = 1.35

			if var_240_6 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_8 = arg_237_1:GetWordFromCfg(120141057)
				local var_240_9 = arg_237_1:FormatText(var_240_8.content)

				arg_237_1.text_.text = var_240_9

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_10 = 54
				local var_240_11 = utf8.len(var_240_9)
				local var_240_12 = var_240_10 <= 0 and var_240_7 or var_240_7 * (var_240_11 / var_240_10)

				if var_240_12 > 0 and var_240_7 < var_240_12 then
					arg_237_1.talkMaxDuration = var_240_12

					if var_240_12 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_12 + var_240_6
					end
				end

				arg_237_1.text_.text = var_240_9
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_13 = math.max(var_240_7, arg_237_1.talkMaxDuration)

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_13 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_6) / var_240_13

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_6 + var_240_13 and arg_237_1.time_ < var_240_6 + var_240_13 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play120141058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 120141058
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play120141059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["10037ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos10037ui_story = var_244_0.localPosition
			end

			local var_244_2 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2
				local var_244_4 = Vector3.New(0, 100, 0)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10037ui_story, var_244_4, var_244_3)

				local var_244_5 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_5.x, var_244_5.y, var_244_5.z)

				local var_244_6 = var_244_0.localEulerAngles

				var_244_6.z = 0
				var_244_6.x = 0
				var_244_0.localEulerAngles = var_244_6
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(0, 100, 0)

				local var_244_7 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_7.x, var_244_7.y, var_244_7.z)

				local var_244_8 = var_244_0.localEulerAngles

				var_244_8.z = 0
				var_244_8.x = 0
				var_244_0.localEulerAngles = var_244_8
			end

			local var_244_9 = 0

			if var_244_9 < arg_241_1.time_ and arg_241_1.time_ <= var_244_9 + arg_244_0 then
				arg_241_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_244_10 = 0
			local var_244_11 = 0.7

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_12 = arg_241_1:GetWordFromCfg(120141058)
				local var_244_13 = arg_241_1:FormatText(var_244_12.content)

				arg_241_1.text_.text = var_244_13

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_14 = 28
				local var_244_15 = utf8.len(var_244_13)
				local var_244_16 = var_244_14 <= 0 and var_244_11 or var_244_11 * (var_244_15 / var_244_14)

				if var_244_16 > 0 and var_244_11 < var_244_16 then
					arg_241_1.talkMaxDuration = var_244_16

					if var_244_16 + var_244_10 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_16 + var_244_10
					end
				end

				arg_241_1.text_.text = var_244_13
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_17 = math.max(var_244_11, arg_241_1.talkMaxDuration)

			if var_244_10 <= arg_241_1.time_ and arg_241_1.time_ < var_244_10 + var_244_17 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_10) / var_244_17

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_10 + var_244_17 and arg_241_1.time_ < var_244_10 + var_244_17 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play120141059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 120141059
		arg_245_1.duration_ = 3.7

		local var_245_0 = {
			zh = 1.999999999999,
			ja = 3.7
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play120141060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_248_2 = arg_245_1.actors_["1075ui_story"].transform
			local var_248_3 = 0

			if var_248_3 < arg_245_1.time_ and arg_245_1.time_ <= var_248_3 + arg_248_0 then
				arg_245_1.var_.moveOldPos1075ui_story = var_248_2.localPosition
			end

			local var_248_4 = 0.001

			if var_248_3 <= arg_245_1.time_ and arg_245_1.time_ < var_248_3 + var_248_4 then
				local var_248_5 = (arg_245_1.time_ - var_248_3) / var_248_4
				local var_248_6 = Vector3.New(-0.7, -1.055, -6.16)

				var_248_2.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1075ui_story, var_248_6, var_248_5)

				local var_248_7 = manager.ui.mainCamera.transform.position - var_248_2.position

				var_248_2.forward = Vector3.New(var_248_7.x, var_248_7.y, var_248_7.z)

				local var_248_8 = var_248_2.localEulerAngles

				var_248_8.z = 0
				var_248_8.x = 0
				var_248_2.localEulerAngles = var_248_8
			end

			if arg_245_1.time_ >= var_248_3 + var_248_4 and arg_245_1.time_ < var_248_3 + var_248_4 + arg_248_0 then
				var_248_2.localPosition = Vector3.New(-0.7, -1.055, -6.16)

				local var_248_9 = manager.ui.mainCamera.transform.position - var_248_2.position

				var_248_2.forward = Vector3.New(var_248_9.x, var_248_9.y, var_248_9.z)

				local var_248_10 = var_248_2.localEulerAngles

				var_248_10.z = 0
				var_248_10.x = 0
				var_248_2.localEulerAngles = var_248_10
			end

			local var_248_11 = arg_245_1.actors_["1071ui_story"].transform
			local var_248_12 = 0

			if var_248_12 < arg_245_1.time_ and arg_245_1.time_ <= var_248_12 + arg_248_0 then
				arg_245_1.var_.moveOldPos1071ui_story = var_248_11.localPosition
			end

			local var_248_13 = 0.001

			if var_248_12 <= arg_245_1.time_ and arg_245_1.time_ < var_248_12 + var_248_13 then
				local var_248_14 = (arg_245_1.time_ - var_248_12) / var_248_13
				local var_248_15 = Vector3.New(0.7, -1.05, -6.2)

				var_248_11.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1071ui_story, var_248_15, var_248_14)

				local var_248_16 = manager.ui.mainCamera.transform.position - var_248_11.position

				var_248_11.forward = Vector3.New(var_248_16.x, var_248_16.y, var_248_16.z)

				local var_248_17 = var_248_11.localEulerAngles

				var_248_17.z = 0
				var_248_17.x = 0
				var_248_11.localEulerAngles = var_248_17
			end

			if arg_245_1.time_ >= var_248_12 + var_248_13 and arg_245_1.time_ < var_248_12 + var_248_13 + arg_248_0 then
				var_248_11.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_248_18 = manager.ui.mainCamera.transform.position - var_248_11.position

				var_248_11.forward = Vector3.New(var_248_18.x, var_248_18.y, var_248_18.z)

				local var_248_19 = var_248_11.localEulerAngles

				var_248_19.z = 0
				var_248_19.x = 0
				var_248_11.localEulerAngles = var_248_19
			end

			local var_248_20 = arg_245_1.actors_["1075ui_story"]
			local var_248_21 = 0

			if var_248_21 < arg_245_1.time_ and arg_245_1.time_ <= var_248_21 + arg_248_0 and not isNil(var_248_20) and arg_245_1.var_.characterEffect1075ui_story == nil then
				arg_245_1.var_.characterEffect1075ui_story = var_248_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_22 = 0.2

			if var_248_21 <= arg_245_1.time_ and arg_245_1.time_ < var_248_21 + var_248_22 and not isNil(var_248_20) then
				local var_248_23 = (arg_245_1.time_ - var_248_21) / var_248_22

				if arg_245_1.var_.characterEffect1075ui_story and not isNil(var_248_20) then
					arg_245_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= var_248_21 + var_248_22 and arg_245_1.time_ < var_248_21 + var_248_22 + arg_248_0 and not isNil(var_248_20) and arg_245_1.var_.characterEffect1075ui_story then
				arg_245_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_248_24 = arg_245_1.actors_["1071ui_story"]
			local var_248_25 = 0

			if var_248_25 < arg_245_1.time_ and arg_245_1.time_ <= var_248_25 + arg_248_0 and not isNil(var_248_24) and arg_245_1.var_.characterEffect1071ui_story == nil then
				arg_245_1.var_.characterEffect1071ui_story = var_248_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_26 = 0.0166666666666667

			if var_248_25 <= arg_245_1.time_ and arg_245_1.time_ < var_248_25 + var_248_26 and not isNil(var_248_24) then
				local var_248_27 = (arg_245_1.time_ - var_248_25) / var_248_26

				if arg_245_1.var_.characterEffect1071ui_story and not isNil(var_248_24) then
					local var_248_28 = Mathf.Lerp(0, 0.5, var_248_27)

					arg_245_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1071ui_story.fillRatio = var_248_28
				end
			end

			if arg_245_1.time_ >= var_248_25 + var_248_26 and arg_245_1.time_ < var_248_25 + var_248_26 + arg_248_0 and not isNil(var_248_24) and arg_245_1.var_.characterEffect1071ui_story then
				local var_248_29 = 0.5

				arg_245_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1071ui_story.fillRatio = var_248_29
			end

			local var_248_30 = arg_245_1.actors_["1071ui_story"]
			local var_248_31 = 0

			if var_248_31 < arg_245_1.time_ and arg_245_1.time_ <= var_248_31 + arg_248_0 and not isNil(var_248_30) and arg_245_1.var_.characterEffect1071ui_story == nil then
				arg_245_1.var_.characterEffect1071ui_story = var_248_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_32 = 0.2

			if var_248_31 <= arg_245_1.time_ and arg_245_1.time_ < var_248_31 + var_248_32 and not isNil(var_248_30) then
				local var_248_33 = (arg_245_1.time_ - var_248_31) / var_248_32

				if arg_245_1.var_.characterEffect1071ui_story and not isNil(var_248_30) then
					local var_248_34 = Mathf.Lerp(0, 0.5, var_248_33)

					arg_245_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1071ui_story.fillRatio = var_248_34
				end
			end

			if arg_245_1.time_ >= var_248_31 + var_248_32 and arg_245_1.time_ < var_248_31 + var_248_32 + arg_248_0 and not isNil(var_248_30) and arg_245_1.var_.characterEffect1071ui_story then
				local var_248_35 = 0.5

				arg_245_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1071ui_story.fillRatio = var_248_35
			end

			local var_248_36 = 0
			local var_248_37 = 0.125

			if var_248_36 < arg_245_1.time_ and arg_245_1.time_ <= var_248_36 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_38 = arg_245_1:FormatText(StoryNameCfg[381].name)

				arg_245_1.leftNameTxt_.text = var_248_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_39 = arg_245_1:GetWordFromCfg(120141059)
				local var_248_40 = arg_245_1:FormatText(var_248_39.content)

				arg_245_1.text_.text = var_248_40

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_41 = 5
				local var_248_42 = utf8.len(var_248_40)
				local var_248_43 = var_248_41 <= 0 and var_248_37 or var_248_37 * (var_248_42 / var_248_41)

				if var_248_43 > 0 and var_248_37 < var_248_43 then
					arg_245_1.talkMaxDuration = var_248_43

					if var_248_43 + var_248_36 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_43 + var_248_36
					end
				end

				arg_245_1.text_.text = var_248_40
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141059", "story_v_out_120141.awb") ~= 0 then
					local var_248_44 = manager.audio:GetVoiceLength("story_v_out_120141", "120141059", "story_v_out_120141.awb") / 1000

					if var_248_44 + var_248_36 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_44 + var_248_36
					end

					if var_248_39.prefab_name ~= "" and arg_245_1.actors_[var_248_39.prefab_name] ~= nil then
						local var_248_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_39.prefab_name].transform, "story_v_out_120141", "120141059", "story_v_out_120141.awb")

						arg_245_1:RecordAudio("120141059", var_248_45)
						arg_245_1:RecordAudio("120141059", var_248_45)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_120141", "120141059", "story_v_out_120141.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_120141", "120141059", "story_v_out_120141.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_46 = math.max(var_248_37, arg_245_1.talkMaxDuration)

			if var_248_36 <= arg_245_1.time_ and arg_245_1.time_ < var_248_36 + var_248_46 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_36) / var_248_46

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_36 + var_248_46 and arg_245_1.time_ < var_248_36 + var_248_46 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
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
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play120141060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 120141060
		arg_249_1.duration_ = 11.5

		local var_249_0 = {
			zh = 7.833,
			ja = 11.5
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play120141061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1075ui_story"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1075ui_story == nil then
				arg_249_1.var_.characterEffect1075ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.2

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.characterEffect1075ui_story and not isNil(var_252_0) then
					local var_252_4 = Mathf.Lerp(0, 0.5, var_252_3)

					arg_249_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1075ui_story.fillRatio = var_252_4
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1075ui_story then
				local var_252_5 = 0.5

				arg_249_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1075ui_story.fillRatio = var_252_5
			end

			local var_252_6 = arg_249_1.actors_["1071ui_story"]
			local var_252_7 = 0

			if var_252_7 < arg_249_1.time_ and arg_249_1.time_ <= var_252_7 + arg_252_0 and not isNil(var_252_6) and arg_249_1.var_.characterEffect1071ui_story == nil then
				arg_249_1.var_.characterEffect1071ui_story = var_252_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_8 = 0.2

			if var_252_7 <= arg_249_1.time_ and arg_249_1.time_ < var_252_7 + var_252_8 and not isNil(var_252_6) then
				local var_252_9 = (arg_249_1.time_ - var_252_7) / var_252_8

				if arg_249_1.var_.characterEffect1071ui_story and not isNil(var_252_6) then
					arg_249_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_7 + var_252_8 and arg_249_1.time_ < var_252_7 + var_252_8 + arg_252_0 and not isNil(var_252_6) and arg_249_1.var_.characterEffect1071ui_story then
				arg_249_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_252_10 = 0

			if var_252_10 < arg_249_1.time_ and arg_249_1.time_ <= var_252_10 + arg_252_0 then
				arg_249_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_252_11 = 0
			local var_252_12 = 0.825

			if var_252_11 < arg_249_1.time_ and arg_249_1.time_ <= var_252_11 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_13 = arg_249_1:FormatText(StoryNameCfg[384].name)

				arg_249_1.leftNameTxt_.text = var_252_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_14 = arg_249_1:GetWordFromCfg(120141060)
				local var_252_15 = arg_249_1:FormatText(var_252_14.content)

				arg_249_1.text_.text = var_252_15

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_16 = 33
				local var_252_17 = utf8.len(var_252_15)
				local var_252_18 = var_252_16 <= 0 and var_252_12 or var_252_12 * (var_252_17 / var_252_16)

				if var_252_18 > 0 and var_252_12 < var_252_18 then
					arg_249_1.talkMaxDuration = var_252_18

					if var_252_18 + var_252_11 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_18 + var_252_11
					end
				end

				arg_249_1.text_.text = var_252_15
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141060", "story_v_out_120141.awb") ~= 0 then
					local var_252_19 = manager.audio:GetVoiceLength("story_v_out_120141", "120141060", "story_v_out_120141.awb") / 1000

					if var_252_19 + var_252_11 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_19 + var_252_11
					end

					if var_252_14.prefab_name ~= "" and arg_249_1.actors_[var_252_14.prefab_name] ~= nil then
						local var_252_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_14.prefab_name].transform, "story_v_out_120141", "120141060", "story_v_out_120141.awb")

						arg_249_1:RecordAudio("120141060", var_252_20)
						arg_249_1:RecordAudio("120141060", var_252_20)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_120141", "120141060", "story_v_out_120141.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_120141", "120141060", "story_v_out_120141.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_21 = math.max(var_252_12, arg_249_1.talkMaxDuration)

			if var_252_11 <= arg_249_1.time_ and arg_249_1.time_ < var_252_11 + var_252_21 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_11) / var_252_21

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_11 + var_252_21 and arg_249_1.time_ < var_252_11 + var_252_21 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play120141061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 120141061
		arg_253_1.duration_ = 3.43

		local var_253_0 = {
			zh = 1.999999999999,
			ja = 3.433
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play120141062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1071ui_story"].transform
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.var_.moveOldPos1071ui_story = var_256_0.localPosition
			end

			local var_256_2 = 0.001

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2
				local var_256_4 = Vector3.New(0, 100, 0)

				var_256_0.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1071ui_story, var_256_4, var_256_3)

				local var_256_5 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_5.x, var_256_5.y, var_256_5.z)

				local var_256_6 = var_256_0.localEulerAngles

				var_256_6.z = 0
				var_256_6.x = 0
				var_256_0.localEulerAngles = var_256_6
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 then
				var_256_0.localPosition = Vector3.New(0, 100, 0)

				local var_256_7 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_7.x, var_256_7.y, var_256_7.z)

				local var_256_8 = var_256_0.localEulerAngles

				var_256_8.z = 0
				var_256_8.x = 0
				var_256_0.localEulerAngles = var_256_8
			end

			local var_256_9 = arg_253_1.actors_["1075ui_story"].transform
			local var_256_10 = 0

			if var_256_10 < arg_253_1.time_ and arg_253_1.time_ <= var_256_10 + arg_256_0 then
				arg_253_1.var_.moveOldPos1075ui_story = var_256_9.localPosition
			end

			local var_256_11 = 0.001

			if var_256_10 <= arg_253_1.time_ and arg_253_1.time_ < var_256_10 + var_256_11 then
				local var_256_12 = (arg_253_1.time_ - var_256_10) / var_256_11
				local var_256_13 = Vector3.New(0, 100, 0)

				var_256_9.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1075ui_story, var_256_13, var_256_12)

				local var_256_14 = manager.ui.mainCamera.transform.position - var_256_9.position

				var_256_9.forward = Vector3.New(var_256_14.x, var_256_14.y, var_256_14.z)

				local var_256_15 = var_256_9.localEulerAngles

				var_256_15.z = 0
				var_256_15.x = 0
				var_256_9.localEulerAngles = var_256_15
			end

			if arg_253_1.time_ >= var_256_10 + var_256_11 and arg_253_1.time_ < var_256_10 + var_256_11 + arg_256_0 then
				var_256_9.localPosition = Vector3.New(0, 100, 0)

				local var_256_16 = manager.ui.mainCamera.transform.position - var_256_9.position

				var_256_9.forward = Vector3.New(var_256_16.x, var_256_16.y, var_256_16.z)

				local var_256_17 = var_256_9.localEulerAngles

				var_256_17.z = 0
				var_256_17.x = 0
				var_256_9.localEulerAngles = var_256_17
			end

			local var_256_18 = arg_253_1.actors_["10037ui_story"].transform
			local var_256_19 = 0

			if var_256_19 < arg_253_1.time_ and arg_253_1.time_ <= var_256_19 + arg_256_0 then
				arg_253_1.var_.moveOldPos10037ui_story = var_256_18.localPosition
			end

			local var_256_20 = 0.001

			if var_256_19 <= arg_253_1.time_ and arg_253_1.time_ < var_256_19 + var_256_20 then
				local var_256_21 = (arg_253_1.time_ - var_256_19) / var_256_20
				local var_256_22 = Vector3.New(0, -1.13, -6.2)

				var_256_18.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10037ui_story, var_256_22, var_256_21)

				local var_256_23 = manager.ui.mainCamera.transform.position - var_256_18.position

				var_256_18.forward = Vector3.New(var_256_23.x, var_256_23.y, var_256_23.z)

				local var_256_24 = var_256_18.localEulerAngles

				var_256_24.z = 0
				var_256_24.x = 0
				var_256_18.localEulerAngles = var_256_24
			end

			if arg_253_1.time_ >= var_256_19 + var_256_20 and arg_253_1.time_ < var_256_19 + var_256_20 + arg_256_0 then
				var_256_18.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_256_25 = manager.ui.mainCamera.transform.position - var_256_18.position

				var_256_18.forward = Vector3.New(var_256_25.x, var_256_25.y, var_256_25.z)

				local var_256_26 = var_256_18.localEulerAngles

				var_256_26.z = 0
				var_256_26.x = 0
				var_256_18.localEulerAngles = var_256_26
			end

			local var_256_27 = arg_253_1.actors_["10037ui_story"]
			local var_256_28 = 0

			if var_256_28 < arg_253_1.time_ and arg_253_1.time_ <= var_256_28 + arg_256_0 and not isNil(var_256_27) and arg_253_1.var_.characterEffect10037ui_story == nil then
				arg_253_1.var_.characterEffect10037ui_story = var_256_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_29 = 0.2

			if var_256_28 <= arg_253_1.time_ and arg_253_1.time_ < var_256_28 + var_256_29 and not isNil(var_256_27) then
				local var_256_30 = (arg_253_1.time_ - var_256_28) / var_256_29

				if arg_253_1.var_.characterEffect10037ui_story and not isNil(var_256_27) then
					arg_253_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= var_256_28 + var_256_29 and arg_253_1.time_ < var_256_28 + var_256_29 + arg_256_0 and not isNil(var_256_27) and arg_253_1.var_.characterEffect10037ui_story then
				arg_253_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_256_31 = 0

			if var_256_31 < arg_253_1.time_ and arg_253_1.time_ <= var_256_31 + arg_256_0 then
				arg_253_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_256_32 = 0
			local var_256_33 = 0.075

			if var_256_32 < arg_253_1.time_ and arg_253_1.time_ <= var_256_32 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_34 = arg_253_1:FormatText(StoryNameCfg[383].name)

				arg_253_1.leftNameTxt_.text = var_256_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_35 = arg_253_1:GetWordFromCfg(120141061)
				local var_256_36 = arg_253_1:FormatText(var_256_35.content)

				arg_253_1.text_.text = var_256_36

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_37 = 3
				local var_256_38 = utf8.len(var_256_36)
				local var_256_39 = var_256_37 <= 0 and var_256_33 or var_256_33 * (var_256_38 / var_256_37)

				if var_256_39 > 0 and var_256_33 < var_256_39 then
					arg_253_1.talkMaxDuration = var_256_39

					if var_256_39 + var_256_32 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_39 + var_256_32
					end
				end

				arg_253_1.text_.text = var_256_36
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141061", "story_v_out_120141.awb") ~= 0 then
					local var_256_40 = manager.audio:GetVoiceLength("story_v_out_120141", "120141061", "story_v_out_120141.awb") / 1000

					if var_256_40 + var_256_32 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_40 + var_256_32
					end

					if var_256_35.prefab_name ~= "" and arg_253_1.actors_[var_256_35.prefab_name] ~= nil then
						local var_256_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_35.prefab_name].transform, "story_v_out_120141", "120141061", "story_v_out_120141.awb")

						arg_253_1:RecordAudio("120141061", var_256_41)
						arg_253_1:RecordAudio("120141061", var_256_41)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_120141", "120141061", "story_v_out_120141.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_120141", "120141061", "story_v_out_120141.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_42 = math.max(var_256_33, arg_253_1.talkMaxDuration)

			if var_256_32 <= arg_253_1.time_ and arg_253_1.time_ < var_256_32 + var_256_42 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_32) / var_256_42

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_32 + var_256_42 and arg_253_1.time_ < var_256_32 + var_256_42 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play120141062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 120141062
		arg_257_1.duration_ = 6.33

		local var_257_0 = {
			zh = 5.266,
			ja = 6.333
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play120141063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_260_1 = 0
			local var_260_2 = 0.6

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_3 = arg_257_1:FormatText(StoryNameCfg[383].name)

				arg_257_1.leftNameTxt_.text = var_260_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_4 = arg_257_1:GetWordFromCfg(120141062)
				local var_260_5 = arg_257_1:FormatText(var_260_4.content)

				arg_257_1.text_.text = var_260_5

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_6 = 24
				local var_260_7 = utf8.len(var_260_5)
				local var_260_8 = var_260_6 <= 0 and var_260_2 or var_260_2 * (var_260_7 / var_260_6)

				if var_260_8 > 0 and var_260_2 < var_260_8 then
					arg_257_1.talkMaxDuration = var_260_8

					if var_260_8 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_1
					end
				end

				arg_257_1.text_.text = var_260_5
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141062", "story_v_out_120141.awb") ~= 0 then
					local var_260_9 = manager.audio:GetVoiceLength("story_v_out_120141", "120141062", "story_v_out_120141.awb") / 1000

					if var_260_9 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_9 + var_260_1
					end

					if var_260_4.prefab_name ~= "" and arg_257_1.actors_[var_260_4.prefab_name] ~= nil then
						local var_260_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_4.prefab_name].transform, "story_v_out_120141", "120141062", "story_v_out_120141.awb")

						arg_257_1:RecordAudio("120141062", var_260_10)
						arg_257_1:RecordAudio("120141062", var_260_10)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_120141", "120141062", "story_v_out_120141.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_120141", "120141062", "story_v_out_120141.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_11 = math.max(var_260_2, arg_257_1.talkMaxDuration)

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_11 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_1) / var_260_11

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_1 + var_260_11 and arg_257_1.time_ < var_260_1 + var_260_11 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play120141063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 120141063
		arg_261_1.duration_ = 14.73

		local var_261_0 = {
			zh = 13.966,
			ja = 14.733
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play120141064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037actionlink/10037action423")
			end

			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_264_2 = 0
			local var_264_3 = 1.2

			if var_264_2 < arg_261_1.time_ and arg_261_1.time_ <= var_264_2 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_4 = arg_261_1:FormatText(StoryNameCfg[383].name)

				arg_261_1.leftNameTxt_.text = var_264_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_5 = arg_261_1:GetWordFromCfg(120141063)
				local var_264_6 = arg_261_1:FormatText(var_264_5.content)

				arg_261_1.text_.text = var_264_6

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_7 = 48
				local var_264_8 = utf8.len(var_264_6)
				local var_264_9 = var_264_7 <= 0 and var_264_3 or var_264_3 * (var_264_8 / var_264_7)

				if var_264_9 > 0 and var_264_3 < var_264_9 then
					arg_261_1.talkMaxDuration = var_264_9

					if var_264_9 + var_264_2 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_9 + var_264_2
					end
				end

				arg_261_1.text_.text = var_264_6
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141063", "story_v_out_120141.awb") ~= 0 then
					local var_264_10 = manager.audio:GetVoiceLength("story_v_out_120141", "120141063", "story_v_out_120141.awb") / 1000

					if var_264_10 + var_264_2 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_2
					end

					if var_264_5.prefab_name ~= "" and arg_261_1.actors_[var_264_5.prefab_name] ~= nil then
						local var_264_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_5.prefab_name].transform, "story_v_out_120141", "120141063", "story_v_out_120141.awb")

						arg_261_1:RecordAudio("120141063", var_264_11)
						arg_261_1:RecordAudio("120141063", var_264_11)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_120141", "120141063", "story_v_out_120141.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_120141", "120141063", "story_v_out_120141.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_12 = math.max(var_264_3, arg_261_1.talkMaxDuration)

			if var_264_2 <= arg_261_1.time_ and arg_261_1.time_ < var_264_2 + var_264_12 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_2) / var_264_12

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_2 + var_264_12 and arg_261_1.time_ < var_264_2 + var_264_12 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play120141064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 120141064
		arg_265_1.duration_ = 23.53

		local var_265_0 = {
			zh = 5.066,
			ja = 23.533
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play120141065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.525

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[383].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_3 = arg_265_1:GetWordFromCfg(120141064)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 21
				local var_268_6 = utf8.len(var_268_4)
				local var_268_7 = var_268_5 <= 0 and var_268_1 or var_268_1 * (var_268_6 / var_268_5)

				if var_268_7 > 0 and var_268_1 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_0
					end
				end

				arg_265_1.text_.text = var_268_4
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141064", "story_v_out_120141.awb") ~= 0 then
					local var_268_8 = manager.audio:GetVoiceLength("story_v_out_120141", "120141064", "story_v_out_120141.awb") / 1000

					if var_268_8 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_0
					end

					if var_268_3.prefab_name ~= "" and arg_265_1.actors_[var_268_3.prefab_name] ~= nil then
						local var_268_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_3.prefab_name].transform, "story_v_out_120141", "120141064", "story_v_out_120141.awb")

						arg_265_1:RecordAudio("120141064", var_268_9)
						arg_265_1:RecordAudio("120141064", var_268_9)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_120141", "120141064", "story_v_out_120141.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_120141", "120141064", "story_v_out_120141.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_10 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_10 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_10

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_10 and arg_265_1.time_ < var_268_0 + var_268_10 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play120141065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 120141065
		arg_269_1.duration_ = 4.5

		local var_269_0 = {
			zh = 2.466,
			ja = 4.5
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play120141066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["10037ui_story"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos10037ui_story = var_272_0.localPosition
			end

			local var_272_2 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2
				local var_272_4 = Vector3.New(0, 100, 0)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10037ui_story, var_272_4, var_272_3)

				local var_272_5 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_5.x, var_272_5.y, var_272_5.z)

				local var_272_6 = var_272_0.localEulerAngles

				var_272_6.z = 0
				var_272_6.x = 0
				var_272_0.localEulerAngles = var_272_6
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(0, 100, 0)

				local var_272_7 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_7.x, var_272_7.y, var_272_7.z)

				local var_272_8 = var_272_0.localEulerAngles

				var_272_8.z = 0
				var_272_8.x = 0
				var_272_0.localEulerAngles = var_272_8
			end

			local var_272_9 = arg_269_1.actors_["1071ui_story"].transform
			local var_272_10 = 0

			if var_272_10 < arg_269_1.time_ and arg_269_1.time_ <= var_272_10 + arg_272_0 then
				arg_269_1.var_.moveOldPos1071ui_story = var_272_9.localPosition
			end

			local var_272_11 = 0.001

			if var_272_10 <= arg_269_1.time_ and arg_269_1.time_ < var_272_10 + var_272_11 then
				local var_272_12 = (arg_269_1.time_ - var_272_10) / var_272_11
				local var_272_13 = Vector3.New(0, -1.05, -6.2)

				var_272_9.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1071ui_story, var_272_13, var_272_12)

				local var_272_14 = manager.ui.mainCamera.transform.position - var_272_9.position

				var_272_9.forward = Vector3.New(var_272_14.x, var_272_14.y, var_272_14.z)

				local var_272_15 = var_272_9.localEulerAngles

				var_272_15.z = 0
				var_272_15.x = 0
				var_272_9.localEulerAngles = var_272_15
			end

			if arg_269_1.time_ >= var_272_10 + var_272_11 and arg_269_1.time_ < var_272_10 + var_272_11 + arg_272_0 then
				var_272_9.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_272_16 = manager.ui.mainCamera.transform.position - var_272_9.position

				var_272_9.forward = Vector3.New(var_272_16.x, var_272_16.y, var_272_16.z)

				local var_272_17 = var_272_9.localEulerAngles

				var_272_17.z = 0
				var_272_17.x = 0
				var_272_9.localEulerAngles = var_272_17
			end

			local var_272_18 = 0

			if var_272_18 < arg_269_1.time_ and arg_269_1.time_ <= var_272_18 + arg_272_0 then
				arg_269_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_272_19 = 0
			local var_272_20 = 0.3

			if var_272_19 < arg_269_1.time_ and arg_269_1.time_ <= var_272_19 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_21 = arg_269_1:FormatText(StoryNameCfg[384].name)

				arg_269_1.leftNameTxt_.text = var_272_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_22 = arg_269_1:GetWordFromCfg(120141065)
				local var_272_23 = arg_269_1:FormatText(var_272_22.content)

				arg_269_1.text_.text = var_272_23

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_24 = 12
				local var_272_25 = utf8.len(var_272_23)
				local var_272_26 = var_272_24 <= 0 and var_272_20 or var_272_20 * (var_272_25 / var_272_24)

				if var_272_26 > 0 and var_272_20 < var_272_26 then
					arg_269_1.talkMaxDuration = var_272_26

					if var_272_26 + var_272_19 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_26 + var_272_19
					end
				end

				arg_269_1.text_.text = var_272_23
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141065", "story_v_out_120141.awb") ~= 0 then
					local var_272_27 = manager.audio:GetVoiceLength("story_v_out_120141", "120141065", "story_v_out_120141.awb") / 1000

					if var_272_27 + var_272_19 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_27 + var_272_19
					end

					if var_272_22.prefab_name ~= "" and arg_269_1.actors_[var_272_22.prefab_name] ~= nil then
						local var_272_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_22.prefab_name].transform, "story_v_out_120141", "120141065", "story_v_out_120141.awb")

						arg_269_1:RecordAudio("120141065", var_272_28)
						arg_269_1:RecordAudio("120141065", var_272_28)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_120141", "120141065", "story_v_out_120141.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_120141", "120141065", "story_v_out_120141.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_29 = math.max(var_272_20, arg_269_1.talkMaxDuration)

			if var_272_19 <= arg_269_1.time_ and arg_269_1.time_ < var_272_19 + var_272_29 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_19) / var_272_29

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_19 + var_272_29 and arg_269_1.time_ < var_272_19 + var_272_29 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play120141066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 120141066
		arg_273_1.duration_ = 2

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play120141067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["10037ui_story"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect10037ui_story == nil then
				arg_273_1.var_.characterEffect10037ui_story = var_276_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.2

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.characterEffect10037ui_story and not isNil(var_276_0) then
					arg_273_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect10037ui_story then
				arg_273_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_276_4 = arg_273_1.actors_["10037ui_story"].transform
			local var_276_5 = 0

			if var_276_5 < arg_273_1.time_ and arg_273_1.time_ <= var_276_5 + arg_276_0 then
				arg_273_1.var_.moveOldPos10037ui_story = var_276_4.localPosition
			end

			local var_276_6 = 0.001

			if var_276_5 <= arg_273_1.time_ and arg_273_1.time_ < var_276_5 + var_276_6 then
				local var_276_7 = (arg_273_1.time_ - var_276_5) / var_276_6
				local var_276_8 = Vector3.New(0, -1.13, -6.2)

				var_276_4.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10037ui_story, var_276_8, var_276_7)

				local var_276_9 = manager.ui.mainCamera.transform.position - var_276_4.position

				var_276_4.forward = Vector3.New(var_276_9.x, var_276_9.y, var_276_9.z)

				local var_276_10 = var_276_4.localEulerAngles

				var_276_10.z = 0
				var_276_10.x = 0
				var_276_4.localEulerAngles = var_276_10
			end

			if arg_273_1.time_ >= var_276_5 + var_276_6 and arg_273_1.time_ < var_276_5 + var_276_6 + arg_276_0 then
				var_276_4.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_276_11 = manager.ui.mainCamera.transform.position - var_276_4.position

				var_276_4.forward = Vector3.New(var_276_11.x, var_276_11.y, var_276_11.z)

				local var_276_12 = var_276_4.localEulerAngles

				var_276_12.z = 0
				var_276_12.x = 0
				var_276_4.localEulerAngles = var_276_12
			end

			local var_276_13 = arg_273_1.actors_["1071ui_story"].transform
			local var_276_14 = 0

			if var_276_14 < arg_273_1.time_ and arg_273_1.time_ <= var_276_14 + arg_276_0 then
				arg_273_1.var_.moveOldPos1071ui_story = var_276_13.localPosition
			end

			local var_276_15 = 0.001

			if var_276_14 <= arg_273_1.time_ and arg_273_1.time_ < var_276_14 + var_276_15 then
				local var_276_16 = (arg_273_1.time_ - var_276_14) / var_276_15
				local var_276_17 = Vector3.New(0, 100, 0)

				var_276_13.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1071ui_story, var_276_17, var_276_16)

				local var_276_18 = manager.ui.mainCamera.transform.position - var_276_13.position

				var_276_13.forward = Vector3.New(var_276_18.x, var_276_18.y, var_276_18.z)

				local var_276_19 = var_276_13.localEulerAngles

				var_276_19.z = 0
				var_276_19.x = 0
				var_276_13.localEulerAngles = var_276_19
			end

			if arg_273_1.time_ >= var_276_14 + var_276_15 and arg_273_1.time_ < var_276_14 + var_276_15 + arg_276_0 then
				var_276_13.localPosition = Vector3.New(0, 100, 0)

				local var_276_20 = manager.ui.mainCamera.transform.position - var_276_13.position

				var_276_13.forward = Vector3.New(var_276_20.x, var_276_20.y, var_276_20.z)

				local var_276_21 = var_276_13.localEulerAngles

				var_276_21.z = 0
				var_276_21.x = 0
				var_276_13.localEulerAngles = var_276_21
			end

			local var_276_22 = 0

			if var_276_22 < arg_273_1.time_ and arg_273_1.time_ <= var_276_22 + arg_276_0 then
				arg_273_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action3_1")
			end

			local var_276_23 = 0

			if var_276_23 < arg_273_1.time_ and arg_273_1.time_ <= var_276_23 + arg_276_0 then
				arg_273_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_276_24 = 0
			local var_276_25 = 0.1

			if var_276_24 < arg_273_1.time_ and arg_273_1.time_ <= var_276_24 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_26 = arg_273_1:FormatText(StoryNameCfg[383].name)

				arg_273_1.leftNameTxt_.text = var_276_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_27 = arg_273_1:GetWordFromCfg(120141066)
				local var_276_28 = arg_273_1:FormatText(var_276_27.content)

				arg_273_1.text_.text = var_276_28

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_29 = 4
				local var_276_30 = utf8.len(var_276_28)
				local var_276_31 = var_276_29 <= 0 and var_276_25 or var_276_25 * (var_276_30 / var_276_29)

				if var_276_31 > 0 and var_276_25 < var_276_31 then
					arg_273_1.talkMaxDuration = var_276_31

					if var_276_31 + var_276_24 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_31 + var_276_24
					end
				end

				arg_273_1.text_.text = var_276_28
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141066", "story_v_out_120141.awb") ~= 0 then
					local var_276_32 = manager.audio:GetVoiceLength("story_v_out_120141", "120141066", "story_v_out_120141.awb") / 1000

					if var_276_32 + var_276_24 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_32 + var_276_24
					end

					if var_276_27.prefab_name ~= "" and arg_273_1.actors_[var_276_27.prefab_name] ~= nil then
						local var_276_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_27.prefab_name].transform, "story_v_out_120141", "120141066", "story_v_out_120141.awb")

						arg_273_1:RecordAudio("120141066", var_276_33)
						arg_273_1:RecordAudio("120141066", var_276_33)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_120141", "120141066", "story_v_out_120141.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_120141", "120141066", "story_v_out_120141.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_34 = math.max(var_276_25, arg_273_1.talkMaxDuration)

			if var_276_24 <= arg_273_1.time_ and arg_273_1.time_ < var_276_24 + var_276_34 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_24) / var_276_34

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_24 + var_276_34 and arg_273_1.time_ < var_276_24 + var_276_34 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play120141067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 120141067
		arg_277_1.duration_ = 7.1

		local var_277_0 = {
			zh = 5.733,
			ja = 7.1
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play120141068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_280_1 = 0
			local var_280_2 = 0.525

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_3 = arg_277_1:FormatText(StoryNameCfg[383].name)

				arg_277_1.leftNameTxt_.text = var_280_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_4 = arg_277_1:GetWordFromCfg(120141067)
				local var_280_5 = arg_277_1:FormatText(var_280_4.content)

				arg_277_1.text_.text = var_280_5

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_6 = 21
				local var_280_7 = utf8.len(var_280_5)
				local var_280_8 = var_280_6 <= 0 and var_280_2 or var_280_2 * (var_280_7 / var_280_6)

				if var_280_8 > 0 and var_280_2 < var_280_8 then
					arg_277_1.talkMaxDuration = var_280_8

					if var_280_8 + var_280_1 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_8 + var_280_1
					end
				end

				arg_277_1.text_.text = var_280_5
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141067", "story_v_out_120141.awb") ~= 0 then
					local var_280_9 = manager.audio:GetVoiceLength("story_v_out_120141", "120141067", "story_v_out_120141.awb") / 1000

					if var_280_9 + var_280_1 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_1
					end

					if var_280_4.prefab_name ~= "" and arg_277_1.actors_[var_280_4.prefab_name] ~= nil then
						local var_280_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_4.prefab_name].transform, "story_v_out_120141", "120141067", "story_v_out_120141.awb")

						arg_277_1:RecordAudio("120141067", var_280_10)
						arg_277_1:RecordAudio("120141067", var_280_10)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_120141", "120141067", "story_v_out_120141.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_120141", "120141067", "story_v_out_120141.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_11 = math.max(var_280_2, arg_277_1.talkMaxDuration)

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_11 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_1) / var_280_11

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_1 + var_280_11 and arg_277_1.time_ < var_280_1 + var_280_11 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play120141068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 120141068
		arg_281_1.duration_ = 3.9

		local var_281_0 = {
			zh = 3.9,
			ja = 3.733
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play120141069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["10037ui_story"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos10037ui_story = var_284_0.localPosition
			end

			local var_284_2 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2
				local var_284_4 = Vector3.New(0, 100, 0)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10037ui_story, var_284_4, var_284_3)

				local var_284_5 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_5.x, var_284_5.y, var_284_5.z)

				local var_284_6 = var_284_0.localEulerAngles

				var_284_6.z = 0
				var_284_6.x = 0
				var_284_0.localEulerAngles = var_284_6
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(0, 100, 0)

				local var_284_7 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_7.x, var_284_7.y, var_284_7.z)

				local var_284_8 = var_284_0.localEulerAngles

				var_284_8.z = 0
				var_284_8.x = 0
				var_284_0.localEulerAngles = var_284_8
			end

			local var_284_9 = arg_281_1.actors_["1071ui_story"].transform
			local var_284_10 = 0

			if var_284_10 < arg_281_1.time_ and arg_281_1.time_ <= var_284_10 + arg_284_0 then
				arg_281_1.var_.moveOldPos1071ui_story = var_284_9.localPosition
			end

			local var_284_11 = 0.001

			if var_284_10 <= arg_281_1.time_ and arg_281_1.time_ < var_284_10 + var_284_11 then
				local var_284_12 = (arg_281_1.time_ - var_284_10) / var_284_11
				local var_284_13 = Vector3.New(0, -1.05, -6.2)

				var_284_9.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1071ui_story, var_284_13, var_284_12)

				local var_284_14 = manager.ui.mainCamera.transform.position - var_284_9.position

				var_284_9.forward = Vector3.New(var_284_14.x, var_284_14.y, var_284_14.z)

				local var_284_15 = var_284_9.localEulerAngles

				var_284_15.z = 0
				var_284_15.x = 0
				var_284_9.localEulerAngles = var_284_15
			end

			if arg_281_1.time_ >= var_284_10 + var_284_11 and arg_281_1.time_ < var_284_10 + var_284_11 + arg_284_0 then
				var_284_9.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_284_16 = manager.ui.mainCamera.transform.position - var_284_9.position

				var_284_9.forward = Vector3.New(var_284_16.x, var_284_16.y, var_284_16.z)

				local var_284_17 = var_284_9.localEulerAngles

				var_284_17.z = 0
				var_284_17.x = 0
				var_284_9.localEulerAngles = var_284_17
			end

			local var_284_18 = 0

			if var_284_18 < arg_281_1.time_ and arg_281_1.time_ <= var_284_18 + arg_284_0 then
				arg_281_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_284_19 = 0

			if var_284_19 < arg_281_1.time_ and arg_281_1.time_ <= var_284_19 + arg_284_0 then
				arg_281_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_284_20 = arg_281_1.actors_["1071ui_story"]
			local var_284_21 = 0

			if var_284_21 < arg_281_1.time_ and arg_281_1.time_ <= var_284_21 + arg_284_0 and not isNil(var_284_20) and arg_281_1.var_.characterEffect1071ui_story == nil then
				arg_281_1.var_.characterEffect1071ui_story = var_284_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_22 = 0.2

			if var_284_21 <= arg_281_1.time_ and arg_281_1.time_ < var_284_21 + var_284_22 and not isNil(var_284_20) then
				local var_284_23 = (arg_281_1.time_ - var_284_21) / var_284_22

				if arg_281_1.var_.characterEffect1071ui_story and not isNil(var_284_20) then
					arg_281_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= var_284_21 + var_284_22 and arg_281_1.time_ < var_284_21 + var_284_22 + arg_284_0 and not isNil(var_284_20) and arg_281_1.var_.characterEffect1071ui_story then
				arg_281_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_284_24 = 0
			local var_284_25 = 0.3

			if var_284_24 < arg_281_1.time_ and arg_281_1.time_ <= var_284_24 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_26 = arg_281_1:FormatText(StoryNameCfg[384].name)

				arg_281_1.leftNameTxt_.text = var_284_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_27 = arg_281_1:GetWordFromCfg(120141068)
				local var_284_28 = arg_281_1:FormatText(var_284_27.content)

				arg_281_1.text_.text = var_284_28

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_29 = 12
				local var_284_30 = utf8.len(var_284_28)
				local var_284_31 = var_284_29 <= 0 and var_284_25 or var_284_25 * (var_284_30 / var_284_29)

				if var_284_31 > 0 and var_284_25 < var_284_31 then
					arg_281_1.talkMaxDuration = var_284_31

					if var_284_31 + var_284_24 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_31 + var_284_24
					end
				end

				arg_281_1.text_.text = var_284_28
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141068", "story_v_out_120141.awb") ~= 0 then
					local var_284_32 = manager.audio:GetVoiceLength("story_v_out_120141", "120141068", "story_v_out_120141.awb") / 1000

					if var_284_32 + var_284_24 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_32 + var_284_24
					end

					if var_284_27.prefab_name ~= "" and arg_281_1.actors_[var_284_27.prefab_name] ~= nil then
						local var_284_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_27.prefab_name].transform, "story_v_out_120141", "120141068", "story_v_out_120141.awb")

						arg_281_1:RecordAudio("120141068", var_284_33)
						arg_281_1:RecordAudio("120141068", var_284_33)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_120141", "120141068", "story_v_out_120141.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_120141", "120141068", "story_v_out_120141.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_34 = math.max(var_284_25, arg_281_1.talkMaxDuration)

			if var_284_24 <= arg_281_1.time_ and arg_281_1.time_ < var_284_24 + var_284_34 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_24) / var_284_34

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_24 + var_284_34 and arg_281_1.time_ < var_284_24 + var_284_34 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play120141069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 120141069
		arg_285_1.duration_ = 13.77

		local var_285_0 = {
			zh = 8.166,
			ja = 13.766
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play120141070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["10037ui_story"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect10037ui_story == nil then
				arg_285_1.var_.characterEffect10037ui_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.2

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.characterEffect10037ui_story and not isNil(var_288_0) then
					arg_285_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect10037ui_story then
				arg_285_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_288_4 = arg_285_1.actors_["10037ui_story"].transform
			local var_288_5 = 0

			if var_288_5 < arg_285_1.time_ and arg_285_1.time_ <= var_288_5 + arg_288_0 then
				arg_285_1.var_.moveOldPos10037ui_story = var_288_4.localPosition
			end

			local var_288_6 = 0.001

			if var_288_5 <= arg_285_1.time_ and arg_285_1.time_ < var_288_5 + var_288_6 then
				local var_288_7 = (arg_285_1.time_ - var_288_5) / var_288_6
				local var_288_8 = Vector3.New(0, -1.13, -6.2)

				var_288_4.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10037ui_story, var_288_8, var_288_7)

				local var_288_9 = manager.ui.mainCamera.transform.position - var_288_4.position

				var_288_4.forward = Vector3.New(var_288_9.x, var_288_9.y, var_288_9.z)

				local var_288_10 = var_288_4.localEulerAngles

				var_288_10.z = 0
				var_288_10.x = 0
				var_288_4.localEulerAngles = var_288_10
			end

			if arg_285_1.time_ >= var_288_5 + var_288_6 and arg_285_1.time_ < var_288_5 + var_288_6 + arg_288_0 then
				var_288_4.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_288_11 = manager.ui.mainCamera.transform.position - var_288_4.position

				var_288_4.forward = Vector3.New(var_288_11.x, var_288_11.y, var_288_11.z)

				local var_288_12 = var_288_4.localEulerAngles

				var_288_12.z = 0
				var_288_12.x = 0
				var_288_4.localEulerAngles = var_288_12
			end

			local var_288_13 = arg_285_1.actors_["1071ui_story"].transform
			local var_288_14 = 0

			if var_288_14 < arg_285_1.time_ and arg_285_1.time_ <= var_288_14 + arg_288_0 then
				arg_285_1.var_.moveOldPos1071ui_story = var_288_13.localPosition
			end

			local var_288_15 = 0.001

			if var_288_14 <= arg_285_1.time_ and arg_285_1.time_ < var_288_14 + var_288_15 then
				local var_288_16 = (arg_285_1.time_ - var_288_14) / var_288_15
				local var_288_17 = Vector3.New(0, 100, 0)

				var_288_13.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1071ui_story, var_288_17, var_288_16)

				local var_288_18 = manager.ui.mainCamera.transform.position - var_288_13.position

				var_288_13.forward = Vector3.New(var_288_18.x, var_288_18.y, var_288_18.z)

				local var_288_19 = var_288_13.localEulerAngles

				var_288_19.z = 0
				var_288_19.x = 0
				var_288_13.localEulerAngles = var_288_19
			end

			if arg_285_1.time_ >= var_288_14 + var_288_15 and arg_285_1.time_ < var_288_14 + var_288_15 + arg_288_0 then
				var_288_13.localPosition = Vector3.New(0, 100, 0)

				local var_288_20 = manager.ui.mainCamera.transform.position - var_288_13.position

				var_288_13.forward = Vector3.New(var_288_20.x, var_288_20.y, var_288_20.z)

				local var_288_21 = var_288_13.localEulerAngles

				var_288_21.z = 0
				var_288_21.x = 0
				var_288_13.localEulerAngles = var_288_21
			end

			local var_288_22 = 0

			if var_288_22 < arg_285_1.time_ and arg_285_1.time_ <= var_288_22 + arg_288_0 then
				arg_285_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			local var_288_23 = 0

			if var_288_23 < arg_285_1.time_ and arg_285_1.time_ <= var_288_23 + arg_288_0 then
				arg_285_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_288_24 = 0
			local var_288_25 = 0.85

			if var_288_24 < arg_285_1.time_ and arg_285_1.time_ <= var_288_24 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_26 = arg_285_1:FormatText(StoryNameCfg[383].name)

				arg_285_1.leftNameTxt_.text = var_288_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_27 = arg_285_1:GetWordFromCfg(120141069)
				local var_288_28 = arg_285_1:FormatText(var_288_27.content)

				arg_285_1.text_.text = var_288_28

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_29 = 34
				local var_288_30 = utf8.len(var_288_28)
				local var_288_31 = var_288_29 <= 0 and var_288_25 or var_288_25 * (var_288_30 / var_288_29)

				if var_288_31 > 0 and var_288_25 < var_288_31 then
					arg_285_1.talkMaxDuration = var_288_31

					if var_288_31 + var_288_24 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_31 + var_288_24
					end
				end

				arg_285_1.text_.text = var_288_28
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141069", "story_v_out_120141.awb") ~= 0 then
					local var_288_32 = manager.audio:GetVoiceLength("story_v_out_120141", "120141069", "story_v_out_120141.awb") / 1000

					if var_288_32 + var_288_24 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_32 + var_288_24
					end

					if var_288_27.prefab_name ~= "" and arg_285_1.actors_[var_288_27.prefab_name] ~= nil then
						local var_288_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_27.prefab_name].transform, "story_v_out_120141", "120141069", "story_v_out_120141.awb")

						arg_285_1:RecordAudio("120141069", var_288_33)
						arg_285_1:RecordAudio("120141069", var_288_33)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_120141", "120141069", "story_v_out_120141.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_120141", "120141069", "story_v_out_120141.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_34 = math.max(var_288_25, arg_285_1.talkMaxDuration)

			if var_288_24 <= arg_285_1.time_ and arg_285_1.time_ < var_288_24 + var_288_34 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_24) / var_288_34

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_24 + var_288_34 and arg_285_1.time_ < var_288_24 + var_288_34 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play120141070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 120141070
		arg_289_1.duration_ = 11.87

		local var_289_0 = {
			zh = 9.9,
			ja = 11.866
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play120141071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action3_1")
			end

			local var_292_2 = 0
			local var_292_3 = 0.7

			if var_292_2 < arg_289_1.time_ and arg_289_1.time_ <= var_292_2 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_4 = arg_289_1:FormatText(StoryNameCfg[383].name)

				arg_289_1.leftNameTxt_.text = var_292_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_5 = arg_289_1:GetWordFromCfg(120141070)
				local var_292_6 = arg_289_1:FormatText(var_292_5.content)

				arg_289_1.text_.text = var_292_6

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_7 = 28
				local var_292_8 = utf8.len(var_292_6)
				local var_292_9 = var_292_7 <= 0 and var_292_3 or var_292_3 * (var_292_8 / var_292_7)

				if var_292_9 > 0 and var_292_3 < var_292_9 then
					arg_289_1.talkMaxDuration = var_292_9

					if var_292_9 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_9 + var_292_2
					end
				end

				arg_289_1.text_.text = var_292_6
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141070", "story_v_out_120141.awb") ~= 0 then
					local var_292_10 = manager.audio:GetVoiceLength("story_v_out_120141", "120141070", "story_v_out_120141.awb") / 1000

					if var_292_10 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_2
					end

					if var_292_5.prefab_name ~= "" and arg_289_1.actors_[var_292_5.prefab_name] ~= nil then
						local var_292_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_5.prefab_name].transform, "story_v_out_120141", "120141070", "story_v_out_120141.awb")

						arg_289_1:RecordAudio("120141070", var_292_11)
						arg_289_1:RecordAudio("120141070", var_292_11)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_120141", "120141070", "story_v_out_120141.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_120141", "120141070", "story_v_out_120141.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_12 = math.max(var_292_3, arg_289_1.talkMaxDuration)

			if var_292_2 <= arg_289_1.time_ and arg_289_1.time_ < var_292_2 + var_292_12 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_2) / var_292_12

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_2 + var_292_12 and arg_289_1.time_ < var_292_2 + var_292_12 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play120141071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 120141071
		arg_293_1.duration_ = 7

		local var_293_0 = {
			zh = 7,
			ja = 5.133
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play120141072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_296_1 = 0
			local var_296_2 = 0.625

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_3 = arg_293_1:FormatText(StoryNameCfg[383].name)

				arg_293_1.leftNameTxt_.text = var_296_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_4 = arg_293_1:GetWordFromCfg(120141071)
				local var_296_5 = arg_293_1:FormatText(var_296_4.content)

				arg_293_1.text_.text = var_296_5

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_6 = 25
				local var_296_7 = utf8.len(var_296_5)
				local var_296_8 = var_296_6 <= 0 and var_296_2 or var_296_2 * (var_296_7 / var_296_6)

				if var_296_8 > 0 and var_296_2 < var_296_8 then
					arg_293_1.talkMaxDuration = var_296_8

					if var_296_8 + var_296_1 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_8 + var_296_1
					end
				end

				arg_293_1.text_.text = var_296_5
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141071", "story_v_out_120141.awb") ~= 0 then
					local var_296_9 = manager.audio:GetVoiceLength("story_v_out_120141", "120141071", "story_v_out_120141.awb") / 1000

					if var_296_9 + var_296_1 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_9 + var_296_1
					end

					if var_296_4.prefab_name ~= "" and arg_293_1.actors_[var_296_4.prefab_name] ~= nil then
						local var_296_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_4.prefab_name].transform, "story_v_out_120141", "120141071", "story_v_out_120141.awb")

						arg_293_1:RecordAudio("120141071", var_296_10)
						arg_293_1:RecordAudio("120141071", var_296_10)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_120141", "120141071", "story_v_out_120141.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_120141", "120141071", "story_v_out_120141.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_11 = math.max(var_296_2, arg_293_1.talkMaxDuration)

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_11 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_1) / var_296_11

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_1 + var_296_11 and arg_293_1.time_ < var_296_1 + var_296_11 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play120141072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 120141072
		arg_297_1.duration_ = 2.6

		local var_297_0 = {
			zh = 2.6,
			ja = 2.566
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play120141073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1075ui_story"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1075ui_story == nil then
				arg_297_1.var_.characterEffect1075ui_story = var_300_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.2

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.characterEffect1075ui_story and not isNil(var_300_0) then
					arg_297_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1075ui_story then
				arg_297_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_300_4 = arg_297_1.actors_["10037ui_story"].transform
			local var_300_5 = 0

			if var_300_5 < arg_297_1.time_ and arg_297_1.time_ <= var_300_5 + arg_300_0 then
				arg_297_1.var_.moveOldPos10037ui_story = var_300_4.localPosition
			end

			local var_300_6 = 0.001

			if var_300_5 <= arg_297_1.time_ and arg_297_1.time_ < var_300_5 + var_300_6 then
				local var_300_7 = (arg_297_1.time_ - var_300_5) / var_300_6
				local var_300_8 = Vector3.New(0, 100, 0)

				var_300_4.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos10037ui_story, var_300_8, var_300_7)

				local var_300_9 = manager.ui.mainCamera.transform.position - var_300_4.position

				var_300_4.forward = Vector3.New(var_300_9.x, var_300_9.y, var_300_9.z)

				local var_300_10 = var_300_4.localEulerAngles

				var_300_10.z = 0
				var_300_10.x = 0
				var_300_4.localEulerAngles = var_300_10
			end

			if arg_297_1.time_ >= var_300_5 + var_300_6 and arg_297_1.time_ < var_300_5 + var_300_6 + arg_300_0 then
				var_300_4.localPosition = Vector3.New(0, 100, 0)

				local var_300_11 = manager.ui.mainCamera.transform.position - var_300_4.position

				var_300_4.forward = Vector3.New(var_300_11.x, var_300_11.y, var_300_11.z)

				local var_300_12 = var_300_4.localEulerAngles

				var_300_12.z = 0
				var_300_12.x = 0
				var_300_4.localEulerAngles = var_300_12
			end

			local var_300_13 = arg_297_1.actors_["1075ui_story"].transform
			local var_300_14 = 0

			if var_300_14 < arg_297_1.time_ and arg_297_1.time_ <= var_300_14 + arg_300_0 then
				arg_297_1.var_.moveOldPos1075ui_story = var_300_13.localPosition
			end

			local var_300_15 = 0.001

			if var_300_14 <= arg_297_1.time_ and arg_297_1.time_ < var_300_14 + var_300_15 then
				local var_300_16 = (arg_297_1.time_ - var_300_14) / var_300_15
				local var_300_17 = Vector3.New(0, -1.055, -6.16)

				var_300_13.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1075ui_story, var_300_17, var_300_16)

				local var_300_18 = manager.ui.mainCamera.transform.position - var_300_13.position

				var_300_13.forward = Vector3.New(var_300_18.x, var_300_18.y, var_300_18.z)

				local var_300_19 = var_300_13.localEulerAngles

				var_300_19.z = 0
				var_300_19.x = 0
				var_300_13.localEulerAngles = var_300_19
			end

			if arg_297_1.time_ >= var_300_14 + var_300_15 and arg_297_1.time_ < var_300_14 + var_300_15 + arg_300_0 then
				var_300_13.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_300_20 = manager.ui.mainCamera.transform.position - var_300_13.position

				var_300_13.forward = Vector3.New(var_300_20.x, var_300_20.y, var_300_20.z)

				local var_300_21 = var_300_13.localEulerAngles

				var_300_21.z = 0
				var_300_21.x = 0
				var_300_13.localEulerAngles = var_300_21
			end

			local var_300_22 = 0

			if var_300_22 < arg_297_1.time_ and arg_297_1.time_ <= var_300_22 + arg_300_0 then
				arg_297_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_300_23 = 0

			if var_300_23 < arg_297_1.time_ and arg_297_1.time_ <= var_300_23 + arg_300_0 then
				arg_297_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_300_24 = 0
			local var_300_25 = 0.3

			if var_300_24 < arg_297_1.time_ and arg_297_1.time_ <= var_300_24 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_26 = arg_297_1:FormatText(StoryNameCfg[381].name)

				arg_297_1.leftNameTxt_.text = var_300_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_27 = arg_297_1:GetWordFromCfg(120141072)
				local var_300_28 = arg_297_1:FormatText(var_300_27.content)

				arg_297_1.text_.text = var_300_28

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_29 = 12
				local var_300_30 = utf8.len(var_300_28)
				local var_300_31 = var_300_29 <= 0 and var_300_25 or var_300_25 * (var_300_30 / var_300_29)

				if var_300_31 > 0 and var_300_25 < var_300_31 then
					arg_297_1.talkMaxDuration = var_300_31

					if var_300_31 + var_300_24 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_31 + var_300_24
					end
				end

				arg_297_1.text_.text = var_300_28
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141072", "story_v_out_120141.awb") ~= 0 then
					local var_300_32 = manager.audio:GetVoiceLength("story_v_out_120141", "120141072", "story_v_out_120141.awb") / 1000

					if var_300_32 + var_300_24 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_32 + var_300_24
					end

					if var_300_27.prefab_name ~= "" and arg_297_1.actors_[var_300_27.prefab_name] ~= nil then
						local var_300_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_27.prefab_name].transform, "story_v_out_120141", "120141072", "story_v_out_120141.awb")

						arg_297_1:RecordAudio("120141072", var_300_33)
						arg_297_1:RecordAudio("120141072", var_300_33)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_120141", "120141072", "story_v_out_120141.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_120141", "120141072", "story_v_out_120141.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_34 = math.max(var_300_25, arg_297_1.talkMaxDuration)

			if var_300_24 <= arg_297_1.time_ and arg_297_1.time_ < var_300_24 + var_300_34 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_24) / var_300_34

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_24 + var_300_34 and arg_297_1.time_ < var_300_24 + var_300_34 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
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
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play120141073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 120141073
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play120141074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1075ui_story"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos1075ui_story = var_304_0.localPosition
			end

			local var_304_2 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2
				local var_304_4 = Vector3.New(0, 100, 0)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1075ui_story, var_304_4, var_304_3)

				local var_304_5 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_5.x, var_304_5.y, var_304_5.z)

				local var_304_6 = var_304_0.localEulerAngles

				var_304_6.z = 0
				var_304_6.x = 0
				var_304_0.localEulerAngles = var_304_6
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 then
				var_304_0.localPosition = Vector3.New(0, 100, 0)

				local var_304_7 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_7.x, var_304_7.y, var_304_7.z)

				local var_304_8 = var_304_0.localEulerAngles

				var_304_8.z = 0
				var_304_8.x = 0
				var_304_0.localEulerAngles = var_304_8
			end

			local var_304_9 = 0
			local var_304_10 = 0.775

			if var_304_9 < arg_301_1.time_ and arg_301_1.time_ <= var_304_9 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_11 = arg_301_1:GetWordFromCfg(120141073)
				local var_304_12 = arg_301_1:FormatText(var_304_11.content)

				arg_301_1.text_.text = var_304_12

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_13 = 31
				local var_304_14 = utf8.len(var_304_12)
				local var_304_15 = var_304_13 <= 0 and var_304_10 or var_304_10 * (var_304_14 / var_304_13)

				if var_304_15 > 0 and var_304_10 < var_304_15 then
					arg_301_1.talkMaxDuration = var_304_15

					if var_304_15 + var_304_9 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_15 + var_304_9
					end
				end

				arg_301_1.text_.text = var_304_12
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_16 = math.max(var_304_10, arg_301_1.talkMaxDuration)

			if var_304_9 <= arg_301_1.time_ and arg_301_1.time_ < var_304_9 + var_304_16 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_9) / var_304_16

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_9 + var_304_16 and arg_301_1.time_ < var_304_9 + var_304_16 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
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

		arg_301_1:InitPlayNodeList()
	end,
	Play120141074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 120141074
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play120141075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.65

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_2 = arg_305_1:GetWordFromCfg(120141074)
				local var_308_3 = arg_305_1:FormatText(var_308_2.content)

				arg_305_1.text_.text = var_308_3

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 26
				local var_308_5 = utf8.len(var_308_3)
				local var_308_6 = var_308_4 <= 0 and var_308_1 or var_308_1 * (var_308_5 / var_308_4)

				if var_308_6 > 0 and var_308_1 < var_308_6 then
					arg_305_1.talkMaxDuration = var_308_6

					if var_308_6 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_6 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_3
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_7 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_7 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_7

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_7 and arg_305_1.time_ < var_308_0 + var_308_7 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play120141075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 120141075
		arg_309_1.duration_ = 1

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"

			SetActive(arg_309_1.choicesGo_, true)

			for iter_310_0, iter_310_1 in ipairs(arg_309_1.choices_) do
				local var_310_0 = iter_310_0 <= 2

				SetActive(iter_310_1.go, var_310_0)
			end

			arg_309_1.choices_[1].txt.text = arg_309_1:FormatText(StoryChoiceCfg[374].name)
			arg_309_1.choices_[2].txt.text = arg_309_1:FormatText(StoryChoiceCfg[375].name)
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play120141076(arg_309_1)
			end

			if arg_311_0 == 2 then
				arg_309_0:Play120141076(arg_309_1)
			end

			arg_309_1:RecordChoiceLog(120141075, 374, 375)
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.allBtn_.enabled = false
			end

			local var_312_1 = 1

			if arg_309_1.time_ >= var_312_0 + var_312_1 and arg_309_1.time_ < var_312_0 + var_312_1 + arg_312_0 then
				arg_309_1.allBtn_.enabled = true
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play120141076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 120141076
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play120141077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["10037ui_story"].transform
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.var_.moveOldPos10037ui_story = var_316_0.localPosition
			end

			local var_316_2 = 0.001

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2
				local var_316_4 = Vector3.New(0, 100, 0)

				var_316_0.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos10037ui_story, var_316_4, var_316_3)

				local var_316_5 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_5.x, var_316_5.y, var_316_5.z)

				local var_316_6 = var_316_0.localEulerAngles

				var_316_6.z = 0
				var_316_6.x = 0
				var_316_0.localEulerAngles = var_316_6
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 then
				var_316_0.localPosition = Vector3.New(0, 100, 0)

				local var_316_7 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_7.x, var_316_7.y, var_316_7.z)

				local var_316_8 = var_316_0.localEulerAngles

				var_316_8.z = 0
				var_316_8.x = 0
				var_316_0.localEulerAngles = var_316_8
			end

			local var_316_9 = manager.ui.mainCamera.transform
			local var_316_10 = 0

			if var_316_10 < arg_313_1.time_ and arg_313_1.time_ <= var_316_10 + arg_316_0 then
				arg_313_1.var_.shakeOldPos = var_316_9.localPosition
			end

			local var_316_11 = 1

			if var_316_10 <= arg_313_1.time_ and arg_313_1.time_ < var_316_10 + var_316_11 then
				local var_316_12 = (arg_313_1.time_ - var_316_10) / 0.066
				local var_316_13, var_316_14 = math.modf(var_316_12)

				var_316_9.localPosition = Vector3.New(var_316_14 * 0.13, var_316_14 * 0.13, var_316_14 * 0.13) + arg_313_1.var_.shakeOldPos
			end

			if arg_313_1.time_ >= var_316_10 + var_316_11 and arg_313_1.time_ < var_316_10 + var_316_11 + arg_316_0 then
				var_316_9.localPosition = arg_313_1.var_.shakeOldPos
			end

			local var_316_15 = 0
			local var_316_16 = 1

			if var_316_15 < arg_313_1.time_ and arg_313_1.time_ <= var_316_15 + arg_316_0 then
				local var_316_17 = "play"
				local var_316_18 = "effect"

				arg_313_1:AudioAction(var_316_17, var_316_18, "se_story_120_00", "se_story_120_00_door_break02", "")
			end

			local var_316_19 = 0
			local var_316_20 = 0.075

			if var_316_19 < arg_313_1.time_ and arg_313_1.time_ <= var_316_19 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_21 = arg_313_1:GetWordFromCfg(120141076)
				local var_316_22 = arg_313_1:FormatText(var_316_21.content)

				arg_313_1.text_.text = var_316_22

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_23 = 3
				local var_316_24 = utf8.len(var_316_22)
				local var_316_25 = var_316_23 <= 0 and var_316_20 or var_316_20 * (var_316_24 / var_316_23)

				if var_316_25 > 0 and var_316_20 < var_316_25 then
					arg_313_1.talkMaxDuration = var_316_25

					if var_316_25 + var_316_19 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_25 + var_316_19
					end
				end

				arg_313_1.text_.text = var_316_22
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_26 = math.max(var_316_20, arg_313_1.talkMaxDuration)

			if var_316_19 <= arg_313_1.time_ and arg_313_1.time_ < var_316_19 + var_316_26 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_19) / var_316_26

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_19 + var_316_26 and arg_313_1.time_ < var_316_19 + var_316_26 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play120141077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 120141077
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play120141078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 1

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_2 = arg_317_1:GetWordFromCfg(120141077)
				local var_320_3 = arg_317_1:FormatText(var_320_2.content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 40
				local var_320_5 = utf8.len(var_320_3)
				local var_320_6 = var_320_4 <= 0 and var_320_1 or var_320_1 * (var_320_5 / var_320_4)

				if var_320_6 > 0 and var_320_1 < var_320_6 then
					arg_317_1.talkMaxDuration = var_320_6

					if var_320_6 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_6 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_7 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_7 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_7

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_7 and arg_317_1.time_ < var_320_0 + var_320_7 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play120141078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 120141078
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play120141079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0
			local var_324_1 = 0.05

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_2 = arg_321_1:FormatText(StoryNameCfg[385].name)

				arg_321_1.leftNameTxt_.text = var_324_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3041")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_3 = arg_321_1:GetWordFromCfg(120141078)
				local var_324_4 = arg_321_1:FormatText(var_324_3.content)

				arg_321_1.text_.text = var_324_4

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 2
				local var_324_6 = utf8.len(var_324_4)
				local var_324_7 = var_324_5 <= 0 and var_324_1 or var_324_1 * (var_324_6 / var_324_5)

				if var_324_7 > 0 and var_324_1 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_0
					end
				end

				arg_321_1.text_.text = var_324_4
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_8 = math.max(var_324_1, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_8 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_0) / var_324_8

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_8 and arg_321_1.time_ < var_324_0 + var_324_8 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play120141079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 120141079
		arg_325_1.duration_ = 4.63

		local var_325_0 = {
			zh = 3.9,
			ja = 4.633
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play120141080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1184ui_story"].transform
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.var_.moveOldPos1184ui_story = var_328_0.localPosition
			end

			local var_328_2 = 0.001

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2
				local var_328_4 = Vector3.New(0, -0.97, -6)

				var_328_0.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1184ui_story, var_328_4, var_328_3)

				local var_328_5 = manager.ui.mainCamera.transform.position - var_328_0.position

				var_328_0.forward = Vector3.New(var_328_5.x, var_328_5.y, var_328_5.z)

				local var_328_6 = var_328_0.localEulerAngles

				var_328_6.z = 0
				var_328_6.x = 0
				var_328_0.localEulerAngles = var_328_6
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 then
				var_328_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_328_7 = manager.ui.mainCamera.transform.position - var_328_0.position

				var_328_0.forward = Vector3.New(var_328_7.x, var_328_7.y, var_328_7.z)

				local var_328_8 = var_328_0.localEulerAngles

				var_328_8.z = 0
				var_328_8.x = 0
				var_328_0.localEulerAngles = var_328_8
			end

			local var_328_9 = arg_325_1.actors_["1184ui_story"]
			local var_328_10 = 0

			if var_328_10 < arg_325_1.time_ and arg_325_1.time_ <= var_328_10 + arg_328_0 and not isNil(var_328_9) and arg_325_1.var_.characterEffect1184ui_story == nil then
				arg_325_1.var_.characterEffect1184ui_story = var_328_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_11 = 0.2

			if var_328_10 <= arg_325_1.time_ and arg_325_1.time_ < var_328_10 + var_328_11 and not isNil(var_328_9) then
				local var_328_12 = (arg_325_1.time_ - var_328_10) / var_328_11

				if arg_325_1.var_.characterEffect1184ui_story and not isNil(var_328_9) then
					arg_325_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_10 + var_328_11 and arg_325_1.time_ < var_328_10 + var_328_11 + arg_328_0 and not isNil(var_328_9) and arg_325_1.var_.characterEffect1184ui_story then
				arg_325_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_328_13 = 0

			if var_328_13 < arg_325_1.time_ and arg_325_1.time_ <= var_328_13 + arg_328_0 then
				arg_325_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_328_14 = 0

			if var_328_14 < arg_325_1.time_ and arg_325_1.time_ <= var_328_14 + arg_328_0 then
				arg_325_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_328_15 = 0
			local var_328_16 = 0.35

			if var_328_15 < arg_325_1.time_ and arg_325_1.time_ <= var_328_15 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_17 = arg_325_1:FormatText(StoryNameCfg[6].name)

				arg_325_1.leftNameTxt_.text = var_328_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_18 = arg_325_1:GetWordFromCfg(120141079)
				local var_328_19 = arg_325_1:FormatText(var_328_18.content)

				arg_325_1.text_.text = var_328_19

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_20 = 14
				local var_328_21 = utf8.len(var_328_19)
				local var_328_22 = var_328_20 <= 0 and var_328_16 or var_328_16 * (var_328_21 / var_328_20)

				if var_328_22 > 0 and var_328_16 < var_328_22 then
					arg_325_1.talkMaxDuration = var_328_22

					if var_328_22 + var_328_15 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_22 + var_328_15
					end
				end

				arg_325_1.text_.text = var_328_19
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141079", "story_v_out_120141.awb") ~= 0 then
					local var_328_23 = manager.audio:GetVoiceLength("story_v_out_120141", "120141079", "story_v_out_120141.awb") / 1000

					if var_328_23 + var_328_15 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_23 + var_328_15
					end

					if var_328_18.prefab_name ~= "" and arg_325_1.actors_[var_328_18.prefab_name] ~= nil then
						local var_328_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_18.prefab_name].transform, "story_v_out_120141", "120141079", "story_v_out_120141.awb")

						arg_325_1:RecordAudio("120141079", var_328_24)
						arg_325_1:RecordAudio("120141079", var_328_24)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_120141", "120141079", "story_v_out_120141.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_120141", "120141079", "story_v_out_120141.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_25 = math.max(var_328_16, arg_325_1.talkMaxDuration)

			if var_328_15 <= arg_325_1.time_ and arg_325_1.time_ < var_328_15 + var_328_25 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_15) / var_328_25

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_15 + var_328_25 and arg_325_1.time_ < var_328_15 + var_328_25 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
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

		arg_325_1:InitPlayNodeList()
	end,
	Play120141080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 120141080
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play120141081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = "J04f_blur"

			if arg_329_1.bgs_[var_332_0] == nil then
				local var_332_1 = Object.Instantiate(arg_329_1.blurPaintGo_)
				local var_332_2 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_332_0)

				var_332_1:GetComponent("SpriteRenderer").sprite = var_332_2
				var_332_1.name = var_332_0
				var_332_1.transform.parent = arg_329_1.stage_.transform
				var_332_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_329_1.bgs_[var_332_0] = var_332_1
			end

			local var_332_3 = 0
			local var_332_4 = arg_329_1.bgs_[var_332_0]

			if var_332_3 < arg_329_1.time_ and arg_329_1.time_ <= var_332_3 + arg_332_0 then
				local var_332_5 = manager.ui.mainCamera.transform.localPosition
				local var_332_6 = Vector3.New(0, 0, 10) + Vector3.New(var_332_5.x, var_332_5.y, 0)

				var_332_4.transform.localPosition = var_332_6
				var_332_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_332_7 = var_332_4:GetComponent("SpriteRenderer")

				if var_332_7 and var_332_7.sprite then
					local var_332_8 = (var_332_4.transform.localPosition - var_332_5).z
					local var_332_9 = manager.ui.mainCameraCom_
					local var_332_10 = 2 * var_332_8 * Mathf.Tan(var_332_9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_332_11 = var_332_10 * var_332_9.aspect
					local var_332_12 = var_332_7.sprite.bounds.size.x
					local var_332_13 = var_332_7.sprite.bounds.size.y
					local var_332_14 = var_332_11 / var_332_12
					local var_332_15 = var_332_10 / var_332_13
					local var_332_16 = var_332_15 < var_332_14 and var_332_14 or var_332_15

					var_332_4.transform.localScale = Vector3.New(var_332_16, var_332_16, 0)
				end
			end

			local var_332_17 = 2.5

			if var_332_3 <= arg_329_1.time_ and arg_329_1.time_ < var_332_3 + var_332_17 then
				local var_332_18 = (arg_329_1.time_ - var_332_3) / var_332_17
				local var_332_19 = Color.New(1, 1, 1)

				var_332_19.a = Mathf.Lerp(0, 1, var_332_18)

				var_332_4:GetComponent("SpriteRenderer").material:SetColor("_Color", var_332_19)
			end

			local var_332_20 = arg_329_1.actors_["1184ui_story"].transform
			local var_332_21 = 0

			if var_332_21 < arg_329_1.time_ and arg_329_1.time_ <= var_332_21 + arg_332_0 then
				arg_329_1.var_.moveOldPos1184ui_story = var_332_20.localPosition
			end

			local var_332_22 = 0.001

			if var_332_21 <= arg_329_1.time_ and arg_329_1.time_ < var_332_21 + var_332_22 then
				local var_332_23 = (arg_329_1.time_ - var_332_21) / var_332_22
				local var_332_24 = Vector3.New(0, 100, 0)

				var_332_20.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1184ui_story, var_332_24, var_332_23)

				local var_332_25 = manager.ui.mainCamera.transform.position - var_332_20.position

				var_332_20.forward = Vector3.New(var_332_25.x, var_332_25.y, var_332_25.z)

				local var_332_26 = var_332_20.localEulerAngles

				var_332_26.z = 0
				var_332_26.x = 0
				var_332_20.localEulerAngles = var_332_26
			end

			if arg_329_1.time_ >= var_332_21 + var_332_22 and arg_329_1.time_ < var_332_21 + var_332_22 + arg_332_0 then
				var_332_20.localPosition = Vector3.New(0, 100, 0)

				local var_332_27 = manager.ui.mainCamera.transform.position - var_332_20.position

				var_332_20.forward = Vector3.New(var_332_27.x, var_332_27.y, var_332_27.z)

				local var_332_28 = var_332_20.localEulerAngles

				var_332_28.z = 0
				var_332_28.x = 0
				var_332_20.localEulerAngles = var_332_28
			end

			local var_332_29 = 0

			if var_332_29 < arg_329_1.time_ and arg_329_1.time_ <= var_332_29 + arg_332_0 then
				arg_329_1.allBtn_.enabled = false
			end

			local var_332_30 = 2.5

			if arg_329_1.time_ >= var_332_29 + var_332_30 and arg_329_1.time_ < var_332_29 + var_332_30 + arg_332_0 then
				arg_329_1.allBtn_.enabled = true
			end

			local var_332_31 = 0
			local var_332_32 = 1.425

			if var_332_31 < arg_329_1.time_ and arg_329_1.time_ <= var_332_31 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_33 = arg_329_1:GetWordFromCfg(120141080)
				local var_332_34 = arg_329_1:FormatText(var_332_33.content)

				arg_329_1.text_.text = var_332_34

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_35 = 57
				local var_332_36 = utf8.len(var_332_34)
				local var_332_37 = var_332_35 <= 0 and var_332_32 or var_332_32 * (var_332_36 / var_332_35)

				if var_332_37 > 0 and var_332_32 < var_332_37 then
					arg_329_1.talkMaxDuration = var_332_37

					if var_332_37 + var_332_31 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_37 + var_332_31
					end
				end

				arg_329_1.text_.text = var_332_34
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_38 = math.max(var_332_32, arg_329_1.talkMaxDuration)

			if var_332_31 <= arg_329_1.time_ and arg_329_1.time_ < var_332_31 + var_332_38 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_31) / var_332_38

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_31 + var_332_38 and arg_329_1.time_ < var_332_31 + var_332_38 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
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

		arg_329_1:InitPlayNodeList()
	end,
	Play120141081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 120141081
		arg_333_1.duration_ = 5.3

		local var_333_0 = {
			zh = 3.333,
			ja = 5.3
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play120141082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = manager.ui.mainCamera.transform
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.var_.shakeOldPos = var_336_0.localPosition
			end

			local var_336_2 = 0.6

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / 0.066
				local var_336_4, var_336_5 = math.modf(var_336_3)

				var_336_0.localPosition = Vector3.New(var_336_5 * 0.13, var_336_5 * 0.13, var_336_5 * 0.13) + arg_333_1.var_.shakeOldPos
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 then
				var_336_0.localPosition = arg_333_1.var_.shakeOldPos
			end

			local var_336_6 = 0

			if var_336_6 < arg_333_1.time_ and arg_333_1.time_ <= var_336_6 + arg_336_0 then
				arg_333_1.allBtn_.enabled = false
			end

			local var_336_7 = 0.6

			if arg_333_1.time_ >= var_336_6 + var_336_7 and arg_333_1.time_ < var_336_6 + var_336_7 + arg_336_0 then
				arg_333_1.allBtn_.enabled = true
			end

			local var_336_8 = 0
			local var_336_9 = 0.375

			if var_336_8 < arg_333_1.time_ and arg_333_1.time_ <= var_336_8 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_10 = arg_333_1:FormatText(StoryNameCfg[384].name)

				arg_333_1.leftNameTxt_.text = var_336_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_11 = arg_333_1:GetWordFromCfg(120141081)
				local var_336_12 = arg_333_1:FormatText(var_336_11.content)

				arg_333_1.text_.text = var_336_12

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_13 = 15
				local var_336_14 = utf8.len(var_336_12)
				local var_336_15 = var_336_13 <= 0 and var_336_9 or var_336_9 * (var_336_14 / var_336_13)

				if var_336_15 > 0 and var_336_9 < var_336_15 then
					arg_333_1.talkMaxDuration = var_336_15

					if var_336_15 + var_336_8 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_15 + var_336_8
					end
				end

				arg_333_1.text_.text = var_336_12
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141081", "story_v_out_120141.awb") ~= 0 then
					local var_336_16 = manager.audio:GetVoiceLength("story_v_out_120141", "120141081", "story_v_out_120141.awb") / 1000

					if var_336_16 + var_336_8 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_16 + var_336_8
					end

					if var_336_11.prefab_name ~= "" and arg_333_1.actors_[var_336_11.prefab_name] ~= nil then
						local var_336_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_11.prefab_name].transform, "story_v_out_120141", "120141081", "story_v_out_120141.awb")

						arg_333_1:RecordAudio("120141081", var_336_17)
						arg_333_1:RecordAudio("120141081", var_336_17)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_120141", "120141081", "story_v_out_120141.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_120141", "120141081", "story_v_out_120141.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_18 = math.max(var_336_9, arg_333_1.talkMaxDuration)

			if var_336_8 <= arg_333_1.time_ and arg_333_1.time_ < var_336_8 + var_336_18 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_8) / var_336_18

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_8 + var_336_18 and arg_333_1.time_ < var_336_8 + var_336_18 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play120141082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 120141082
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play120141083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1071ui_story"].transform
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.var_.moveOldPos1071ui_story = var_340_0.localPosition
			end

			local var_340_2 = 0.001

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2
				local var_340_4 = Vector3.New(0, 100, 0)

				var_340_0.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1071ui_story, var_340_4, var_340_3)

				local var_340_5 = manager.ui.mainCamera.transform.position - var_340_0.position

				var_340_0.forward = Vector3.New(var_340_5.x, var_340_5.y, var_340_5.z)

				local var_340_6 = var_340_0.localEulerAngles

				var_340_6.z = 0
				var_340_6.x = 0
				var_340_0.localEulerAngles = var_340_6
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 then
				var_340_0.localPosition = Vector3.New(0, 100, 0)

				local var_340_7 = manager.ui.mainCamera.transform.position - var_340_0.position

				var_340_0.forward = Vector3.New(var_340_7.x, var_340_7.y, var_340_7.z)

				local var_340_8 = var_340_0.localEulerAngles

				var_340_8.z = 0
				var_340_8.x = 0
				var_340_0.localEulerAngles = var_340_8
			end

			local var_340_9 = 0
			local var_340_10 = 0.975

			if var_340_9 < arg_337_1.time_ and arg_337_1.time_ <= var_340_9 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_11 = arg_337_1:GetWordFromCfg(120141082)
				local var_340_12 = arg_337_1:FormatText(var_340_11.content)

				arg_337_1.text_.text = var_340_12

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_13 = 39
				local var_340_14 = utf8.len(var_340_12)
				local var_340_15 = var_340_13 <= 0 and var_340_10 or var_340_10 * (var_340_14 / var_340_13)

				if var_340_15 > 0 and var_340_10 < var_340_15 then
					arg_337_1.talkMaxDuration = var_340_15

					if var_340_15 + var_340_9 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_15 + var_340_9
					end
				end

				arg_337_1.text_.text = var_340_12
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_16 = math.max(var_340_10, arg_337_1.talkMaxDuration)

			if var_340_9 <= arg_337_1.time_ and arg_337_1.time_ < var_340_9 + var_340_16 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_9) / var_340_16

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_9 + var_340_16 and arg_337_1.time_ < var_340_9 + var_340_16 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play120141083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 120141083
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play120141084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0
			local var_344_1 = 0.85

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_2 = arg_341_1:GetWordFromCfg(120141083)
				local var_344_3 = arg_341_1:FormatText(var_344_2.content)

				arg_341_1.text_.text = var_344_3

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_4 = 34
				local var_344_5 = utf8.len(var_344_3)
				local var_344_6 = var_344_4 <= 0 and var_344_1 or var_344_1 * (var_344_5 / var_344_4)

				if var_344_6 > 0 and var_344_1 < var_344_6 then
					arg_341_1.talkMaxDuration = var_344_6

					if var_344_6 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_6 + var_344_0
					end
				end

				arg_341_1.text_.text = var_344_3
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_7 = math.max(var_344_1, arg_341_1.talkMaxDuration)

			if var_344_0 <= arg_341_1.time_ and arg_341_1.time_ < var_344_0 + var_344_7 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_0) / var_344_7

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_0 + var_344_7 and arg_341_1.time_ < var_344_0 + var_344_7 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play120141084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 120141084
		arg_345_1.duration_ = 5.47

		local var_345_0 = {
			zh = 4.933,
			ja = 5.466
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play120141085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["10037ui_story"].transform
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1.var_.moveOldPos10037ui_story = var_348_0.localPosition
			end

			local var_348_2 = 0.001

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2
				local var_348_4 = Vector3.New(0, -1.13, -6.2)

				var_348_0.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos10037ui_story, var_348_4, var_348_3)

				local var_348_5 = manager.ui.mainCamera.transform.position - var_348_0.position

				var_348_0.forward = Vector3.New(var_348_5.x, var_348_5.y, var_348_5.z)

				local var_348_6 = var_348_0.localEulerAngles

				var_348_6.z = 0
				var_348_6.x = 0
				var_348_0.localEulerAngles = var_348_6
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 then
				var_348_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_348_7 = manager.ui.mainCamera.transform.position - var_348_0.position

				var_348_0.forward = Vector3.New(var_348_7.x, var_348_7.y, var_348_7.z)

				local var_348_8 = var_348_0.localEulerAngles

				var_348_8.z = 0
				var_348_8.x = 0
				var_348_0.localEulerAngles = var_348_8
			end

			local var_348_9 = arg_345_1.actors_["10037ui_story"]
			local var_348_10 = 0

			if var_348_10 < arg_345_1.time_ and arg_345_1.time_ <= var_348_10 + arg_348_0 and not isNil(var_348_9) and arg_345_1.var_.characterEffect10037ui_story == nil then
				arg_345_1.var_.characterEffect10037ui_story = var_348_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_11 = 0.2

			if var_348_10 <= arg_345_1.time_ and arg_345_1.time_ < var_348_10 + var_348_11 and not isNil(var_348_9) then
				local var_348_12 = (arg_345_1.time_ - var_348_10) / var_348_11

				if arg_345_1.var_.characterEffect10037ui_story and not isNil(var_348_9) then
					arg_345_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= var_348_10 + var_348_11 and arg_345_1.time_ < var_348_10 + var_348_11 + arg_348_0 and not isNil(var_348_9) and arg_345_1.var_.characterEffect10037ui_story then
				arg_345_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_348_13 = 0

			if var_348_13 < arg_345_1.time_ and arg_345_1.time_ <= var_348_13 + arg_348_0 then
				arg_345_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			local var_348_14 = 0

			if var_348_14 < arg_345_1.time_ and arg_345_1.time_ <= var_348_14 + arg_348_0 then
				arg_345_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_348_15 = 0
			local var_348_16 = 0.425

			if var_348_15 < arg_345_1.time_ and arg_345_1.time_ <= var_348_15 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_17 = arg_345_1:FormatText(StoryNameCfg[383].name)

				arg_345_1.leftNameTxt_.text = var_348_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_18 = arg_345_1:GetWordFromCfg(120141084)
				local var_348_19 = arg_345_1:FormatText(var_348_18.content)

				arg_345_1.text_.text = var_348_19

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_20 = 17
				local var_348_21 = utf8.len(var_348_19)
				local var_348_22 = var_348_20 <= 0 and var_348_16 or var_348_16 * (var_348_21 / var_348_20)

				if var_348_22 > 0 and var_348_16 < var_348_22 then
					arg_345_1.talkMaxDuration = var_348_22

					if var_348_22 + var_348_15 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_22 + var_348_15
					end
				end

				arg_345_1.text_.text = var_348_19
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141084", "story_v_out_120141.awb") ~= 0 then
					local var_348_23 = manager.audio:GetVoiceLength("story_v_out_120141", "120141084", "story_v_out_120141.awb") / 1000

					if var_348_23 + var_348_15 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_23 + var_348_15
					end

					if var_348_18.prefab_name ~= "" and arg_345_1.actors_[var_348_18.prefab_name] ~= nil then
						local var_348_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_18.prefab_name].transform, "story_v_out_120141", "120141084", "story_v_out_120141.awb")

						arg_345_1:RecordAudio("120141084", var_348_24)
						arg_345_1:RecordAudio("120141084", var_348_24)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_120141", "120141084", "story_v_out_120141.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_120141", "120141084", "story_v_out_120141.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_25 = math.max(var_348_16, arg_345_1.talkMaxDuration)

			if var_348_15 <= arg_345_1.time_ and arg_345_1.time_ < var_348_15 + var_348_25 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_15) / var_348_25

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_15 + var_348_25 and arg_345_1.time_ < var_348_15 + var_348_25 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play120141085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 120141085
		arg_349_1.duration_ = 7.4

		local var_349_0 = {
			zh = 3.533,
			ja = 7.4
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play120141086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0

			if var_352_0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				arg_349_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action4_1")
			end

			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_352_2 = 0
			local var_352_3 = 0.2

			if var_352_2 < arg_349_1.time_ and arg_349_1.time_ <= var_352_2 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_4 = arg_349_1:FormatText(StoryNameCfg[383].name)

				arg_349_1.leftNameTxt_.text = var_352_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_5 = arg_349_1:GetWordFromCfg(120141085)
				local var_352_6 = arg_349_1:FormatText(var_352_5.content)

				arg_349_1.text_.text = var_352_6

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_7 = 8
				local var_352_8 = utf8.len(var_352_6)
				local var_352_9 = var_352_7 <= 0 and var_352_3 or var_352_3 * (var_352_8 / var_352_7)

				if var_352_9 > 0 and var_352_3 < var_352_9 then
					arg_349_1.talkMaxDuration = var_352_9

					if var_352_9 + var_352_2 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_9 + var_352_2
					end
				end

				arg_349_1.text_.text = var_352_6
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141085", "story_v_out_120141.awb") ~= 0 then
					local var_352_10 = manager.audio:GetVoiceLength("story_v_out_120141", "120141085", "story_v_out_120141.awb") / 1000

					if var_352_10 + var_352_2 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_10 + var_352_2
					end

					if var_352_5.prefab_name ~= "" and arg_349_1.actors_[var_352_5.prefab_name] ~= nil then
						local var_352_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_5.prefab_name].transform, "story_v_out_120141", "120141085", "story_v_out_120141.awb")

						arg_349_1:RecordAudio("120141085", var_352_11)
						arg_349_1:RecordAudio("120141085", var_352_11)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_120141", "120141085", "story_v_out_120141.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_120141", "120141085", "story_v_out_120141.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_12 = math.max(var_352_3, arg_349_1.talkMaxDuration)

			if var_352_2 <= arg_349_1.time_ and arg_349_1.time_ < var_352_2 + var_352_12 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_2) / var_352_12

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_2 + var_352_12 and arg_349_1.time_ < var_352_2 + var_352_12 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play120141086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 120141086
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play120141087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["10037ui_story"].transform
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1.var_.moveOldPos10037ui_story = var_356_0.localPosition
			end

			local var_356_2 = 0.001

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2
				local var_356_4 = Vector3.New(0, 100, 0)

				var_356_0.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos10037ui_story, var_356_4, var_356_3)

				local var_356_5 = manager.ui.mainCamera.transform.position - var_356_0.position

				var_356_0.forward = Vector3.New(var_356_5.x, var_356_5.y, var_356_5.z)

				local var_356_6 = var_356_0.localEulerAngles

				var_356_6.z = 0
				var_356_6.x = 0
				var_356_0.localEulerAngles = var_356_6
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 then
				var_356_0.localPosition = Vector3.New(0, 100, 0)

				local var_356_7 = manager.ui.mainCamera.transform.position - var_356_0.position

				var_356_0.forward = Vector3.New(var_356_7.x, var_356_7.y, var_356_7.z)

				local var_356_8 = var_356_0.localEulerAngles

				var_356_8.z = 0
				var_356_8.x = 0
				var_356_0.localEulerAngles = var_356_8
			end

			local var_356_9 = 0
			local var_356_10 = 1.225

			if var_356_9 < arg_353_1.time_ and arg_353_1.time_ <= var_356_9 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_11 = arg_353_1:GetWordFromCfg(120141086)
				local var_356_12 = arg_353_1:FormatText(var_356_11.content)

				arg_353_1.text_.text = var_356_12

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_13 = 49
				local var_356_14 = utf8.len(var_356_12)
				local var_356_15 = var_356_13 <= 0 and var_356_10 or var_356_10 * (var_356_14 / var_356_13)

				if var_356_15 > 0 and var_356_10 < var_356_15 then
					arg_353_1.talkMaxDuration = var_356_15

					if var_356_15 + var_356_9 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_15 + var_356_9
					end
				end

				arg_353_1.text_.text = var_356_12
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_16 = math.max(var_356_10, arg_353_1.talkMaxDuration)

			if var_356_9 <= arg_353_1.time_ and arg_353_1.time_ < var_356_9 + var_356_16 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_9) / var_356_16

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_9 + var_356_16 and arg_353_1.time_ < var_356_9 + var_356_16 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play120141087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 120141087
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play120141088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0
			local var_360_1 = 0.475

			if var_360_0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_2 = arg_357_1:FormatText(StoryNameCfg[7].name)

				arg_357_1.leftNameTxt_.text = var_360_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, true)
				arg_357_1.iconController_:SetSelectedState("hero")

				arg_357_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_357_1.callingController_:SetSelectedState("normal")

				arg_357_1.keyicon_.color = Color.New(1, 1, 1)
				arg_357_1.icon_.color = Color.New(1, 1, 1)

				local var_360_3 = arg_357_1:GetWordFromCfg(120141087)
				local var_360_4 = arg_357_1:FormatText(var_360_3.content)

				arg_357_1.text_.text = var_360_4

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_5 = 19
				local var_360_6 = utf8.len(var_360_4)
				local var_360_7 = var_360_5 <= 0 and var_360_1 or var_360_1 * (var_360_6 / var_360_5)

				if var_360_7 > 0 and var_360_1 < var_360_7 then
					arg_357_1.talkMaxDuration = var_360_7

					if var_360_7 + var_360_0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_7 + var_360_0
					end
				end

				arg_357_1.text_.text = var_360_4
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_8 = math.max(var_360_1, arg_357_1.talkMaxDuration)

			if var_360_0 <= arg_357_1.time_ and arg_357_1.time_ < var_360_0 + var_360_8 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_0) / var_360_8

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_0 + var_360_8 and arg_357_1.time_ < var_360_0 + var_360_8 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play120141088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 120141088
		arg_361_1.duration_ = 6.27

		local var_361_0 = {
			zh = 4.166,
			ja = 6.266
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play120141089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["1075ui_story"].transform
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.var_.moveOldPos1075ui_story = var_364_0.localPosition
			end

			local var_364_2 = 0.001

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_2 then
				local var_364_3 = (arg_361_1.time_ - var_364_1) / var_364_2
				local var_364_4 = Vector3.New(0, -1.055, -6.16)

				var_364_0.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1075ui_story, var_364_4, var_364_3)

				local var_364_5 = manager.ui.mainCamera.transform.position - var_364_0.position

				var_364_0.forward = Vector3.New(var_364_5.x, var_364_5.y, var_364_5.z)

				local var_364_6 = var_364_0.localEulerAngles

				var_364_6.z = 0
				var_364_6.x = 0
				var_364_0.localEulerAngles = var_364_6
			end

			if arg_361_1.time_ >= var_364_1 + var_364_2 and arg_361_1.time_ < var_364_1 + var_364_2 + arg_364_0 then
				var_364_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_364_7 = manager.ui.mainCamera.transform.position - var_364_0.position

				var_364_0.forward = Vector3.New(var_364_7.x, var_364_7.y, var_364_7.z)

				local var_364_8 = var_364_0.localEulerAngles

				var_364_8.z = 0
				var_364_8.x = 0
				var_364_0.localEulerAngles = var_364_8
			end

			local var_364_9 = arg_361_1.actors_["1075ui_story"]
			local var_364_10 = 0

			if var_364_10 < arg_361_1.time_ and arg_361_1.time_ <= var_364_10 + arg_364_0 and not isNil(var_364_9) and arg_361_1.var_.characterEffect1075ui_story == nil then
				arg_361_1.var_.characterEffect1075ui_story = var_364_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_11 = 0.2

			if var_364_10 <= arg_361_1.time_ and arg_361_1.time_ < var_364_10 + var_364_11 and not isNil(var_364_9) then
				local var_364_12 = (arg_361_1.time_ - var_364_10) / var_364_11

				if arg_361_1.var_.characterEffect1075ui_story and not isNil(var_364_9) then
					arg_361_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_361_1.time_ >= var_364_10 + var_364_11 and arg_361_1.time_ < var_364_10 + var_364_11 + arg_364_0 and not isNil(var_364_9) and arg_361_1.var_.characterEffect1075ui_story then
				arg_361_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_364_13 = 0

			if var_364_13 < arg_361_1.time_ and arg_361_1.time_ <= var_364_13 + arg_364_0 then
				arg_361_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_364_14 = 0

			if var_364_14 < arg_361_1.time_ and arg_361_1.time_ <= var_364_14 + arg_364_0 then
				arg_361_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_364_15 = 0
			local var_364_16 = 0.5

			if var_364_15 < arg_361_1.time_ and arg_361_1.time_ <= var_364_15 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_17 = arg_361_1:FormatText(StoryNameCfg[381].name)

				arg_361_1.leftNameTxt_.text = var_364_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_18 = arg_361_1:GetWordFromCfg(120141088)
				local var_364_19 = arg_361_1:FormatText(var_364_18.content)

				arg_361_1.text_.text = var_364_19

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_20 = 20
				local var_364_21 = utf8.len(var_364_19)
				local var_364_22 = var_364_20 <= 0 and var_364_16 or var_364_16 * (var_364_21 / var_364_20)

				if var_364_22 > 0 and var_364_16 < var_364_22 then
					arg_361_1.talkMaxDuration = var_364_22

					if var_364_22 + var_364_15 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_22 + var_364_15
					end
				end

				arg_361_1.text_.text = var_364_19
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141088", "story_v_out_120141.awb") ~= 0 then
					local var_364_23 = manager.audio:GetVoiceLength("story_v_out_120141", "120141088", "story_v_out_120141.awb") / 1000

					if var_364_23 + var_364_15 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_23 + var_364_15
					end

					if var_364_18.prefab_name ~= "" and arg_361_1.actors_[var_364_18.prefab_name] ~= nil then
						local var_364_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_18.prefab_name].transform, "story_v_out_120141", "120141088", "story_v_out_120141.awb")

						arg_361_1:RecordAudio("120141088", var_364_24)
						arg_361_1:RecordAudio("120141088", var_364_24)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_120141", "120141088", "story_v_out_120141.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_120141", "120141088", "story_v_out_120141.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_25 = math.max(var_364_16, arg_361_1.talkMaxDuration)

			if var_364_15 <= arg_361_1.time_ and arg_361_1.time_ < var_364_15 + var_364_25 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_15) / var_364_25

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_15 + var_364_25 and arg_361_1.time_ < var_364_15 + var_364_25 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
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

		arg_361_1:InitPlayNodeList()
	end,
	Play120141089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 120141089
		arg_365_1.duration_ = 2.73

		local var_365_0 = {
			zh = 2.733,
			ja = 2.066
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play120141090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_368_1 = 0
			local var_368_2 = 0.375

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_3 = arg_365_1:FormatText(StoryNameCfg[381].name)

				arg_365_1.leftNameTxt_.text = var_368_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_4 = arg_365_1:GetWordFromCfg(120141089)
				local var_368_5 = arg_365_1:FormatText(var_368_4.content)

				arg_365_1.text_.text = var_368_5

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_6 = 15
				local var_368_7 = utf8.len(var_368_5)
				local var_368_8 = var_368_6 <= 0 and var_368_2 or var_368_2 * (var_368_7 / var_368_6)

				if var_368_8 > 0 and var_368_2 < var_368_8 then
					arg_365_1.talkMaxDuration = var_368_8

					if var_368_8 + var_368_1 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_8 + var_368_1
					end
				end

				arg_365_1.text_.text = var_368_5
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141089", "story_v_out_120141.awb") ~= 0 then
					local var_368_9 = manager.audio:GetVoiceLength("story_v_out_120141", "120141089", "story_v_out_120141.awb") / 1000

					if var_368_9 + var_368_1 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_9 + var_368_1
					end

					if var_368_4.prefab_name ~= "" and arg_365_1.actors_[var_368_4.prefab_name] ~= nil then
						local var_368_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_4.prefab_name].transform, "story_v_out_120141", "120141089", "story_v_out_120141.awb")

						arg_365_1:RecordAudio("120141089", var_368_10)
						arg_365_1:RecordAudio("120141089", var_368_10)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_120141", "120141089", "story_v_out_120141.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_120141", "120141089", "story_v_out_120141.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_11 = math.max(var_368_2, arg_365_1.talkMaxDuration)

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_11 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_1) / var_368_11

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_1 + var_368_11 and arg_365_1.time_ < var_368_1 + var_368_11 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play120141090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 120141090
		arg_369_1.duration_ = 9.77

		local var_369_0 = {
			zh = 5.7,
			ja = 9.766
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play120141091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0

			if var_372_0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_0 + arg_372_0 then
				arg_369_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_372_1 = 0
			local var_372_2 = 0.825

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_3 = arg_369_1:FormatText(StoryNameCfg[381].name)

				arg_369_1.leftNameTxt_.text = var_372_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_4 = arg_369_1:GetWordFromCfg(120141090)
				local var_372_5 = arg_369_1:FormatText(var_372_4.content)

				arg_369_1.text_.text = var_372_5

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_6 = 33
				local var_372_7 = utf8.len(var_372_5)
				local var_372_8 = var_372_6 <= 0 and var_372_2 or var_372_2 * (var_372_7 / var_372_6)

				if var_372_8 > 0 and var_372_2 < var_372_8 then
					arg_369_1.talkMaxDuration = var_372_8

					if var_372_8 + var_372_1 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_8 + var_372_1
					end
				end

				arg_369_1.text_.text = var_372_5
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141090", "story_v_out_120141.awb") ~= 0 then
					local var_372_9 = manager.audio:GetVoiceLength("story_v_out_120141", "120141090", "story_v_out_120141.awb") / 1000

					if var_372_9 + var_372_1 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_9 + var_372_1
					end

					if var_372_4.prefab_name ~= "" and arg_369_1.actors_[var_372_4.prefab_name] ~= nil then
						local var_372_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_4.prefab_name].transform, "story_v_out_120141", "120141090", "story_v_out_120141.awb")

						arg_369_1:RecordAudio("120141090", var_372_10)
						arg_369_1:RecordAudio("120141090", var_372_10)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_120141", "120141090", "story_v_out_120141.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_120141", "120141090", "story_v_out_120141.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_11 = math.max(var_372_2, arg_369_1.talkMaxDuration)

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_11 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_1) / var_372_11

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_1 + var_372_11 and arg_369_1.time_ < var_372_1 + var_372_11 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play120141091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 120141091
		arg_373_1.duration_ = 6.13

		local var_373_0 = {
			zh = 6.133,
			ja = 4.7
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play120141092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["1075ui_story"].transform
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.var_.moveOldPos1075ui_story = var_376_0.localPosition
			end

			local var_376_2 = 0.001

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 then
				local var_376_3 = (arg_373_1.time_ - var_376_1) / var_376_2
				local var_376_4 = Vector3.New(0, 100, 0)

				var_376_0.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1075ui_story, var_376_4, var_376_3)

				local var_376_5 = manager.ui.mainCamera.transform.position - var_376_0.position

				var_376_0.forward = Vector3.New(var_376_5.x, var_376_5.y, var_376_5.z)

				local var_376_6 = var_376_0.localEulerAngles

				var_376_6.z = 0
				var_376_6.x = 0
				var_376_0.localEulerAngles = var_376_6
			end

			if arg_373_1.time_ >= var_376_1 + var_376_2 and arg_373_1.time_ < var_376_1 + var_376_2 + arg_376_0 then
				var_376_0.localPosition = Vector3.New(0, 100, 0)

				local var_376_7 = manager.ui.mainCamera.transform.position - var_376_0.position

				var_376_0.forward = Vector3.New(var_376_7.x, var_376_7.y, var_376_7.z)

				local var_376_8 = var_376_0.localEulerAngles

				var_376_8.z = 0
				var_376_8.x = 0
				var_376_0.localEulerAngles = var_376_8
			end

			local var_376_9 = arg_373_1.actors_["1071ui_story"].transform
			local var_376_10 = 0

			if var_376_10 < arg_373_1.time_ and arg_373_1.time_ <= var_376_10 + arg_376_0 then
				arg_373_1.var_.moveOldPos1071ui_story = var_376_9.localPosition
			end

			local var_376_11 = 0.001

			if var_376_10 <= arg_373_1.time_ and arg_373_1.time_ < var_376_10 + var_376_11 then
				local var_376_12 = (arg_373_1.time_ - var_376_10) / var_376_11
				local var_376_13 = Vector3.New(0, -1.05, -6.2)

				var_376_9.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1071ui_story, var_376_13, var_376_12)

				local var_376_14 = manager.ui.mainCamera.transform.position - var_376_9.position

				var_376_9.forward = Vector3.New(var_376_14.x, var_376_14.y, var_376_14.z)

				local var_376_15 = var_376_9.localEulerAngles

				var_376_15.z = 0
				var_376_15.x = 0
				var_376_9.localEulerAngles = var_376_15
			end

			if arg_373_1.time_ >= var_376_10 + var_376_11 and arg_373_1.time_ < var_376_10 + var_376_11 + arg_376_0 then
				var_376_9.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_376_16 = manager.ui.mainCamera.transform.position - var_376_9.position

				var_376_9.forward = Vector3.New(var_376_16.x, var_376_16.y, var_376_16.z)

				local var_376_17 = var_376_9.localEulerAngles

				var_376_17.z = 0
				var_376_17.x = 0
				var_376_9.localEulerAngles = var_376_17
			end

			local var_376_18 = arg_373_1.actors_["1071ui_story"]
			local var_376_19 = 0

			if var_376_19 < arg_373_1.time_ and arg_373_1.time_ <= var_376_19 + arg_376_0 and not isNil(var_376_18) and arg_373_1.var_.characterEffect1071ui_story == nil then
				arg_373_1.var_.characterEffect1071ui_story = var_376_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_20 = 0.2

			if var_376_19 <= arg_373_1.time_ and arg_373_1.time_ < var_376_19 + var_376_20 and not isNil(var_376_18) then
				local var_376_21 = (arg_373_1.time_ - var_376_19) / var_376_20

				if arg_373_1.var_.characterEffect1071ui_story and not isNil(var_376_18) then
					arg_373_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= var_376_19 + var_376_20 and arg_373_1.time_ < var_376_19 + var_376_20 + arg_376_0 and not isNil(var_376_18) and arg_373_1.var_.characterEffect1071ui_story then
				arg_373_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_376_22 = 0

			if var_376_22 < arg_373_1.time_ and arg_373_1.time_ <= var_376_22 + arg_376_0 then
				arg_373_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_376_23 = 0
			local var_376_24 = 0.6

			if var_376_23 < arg_373_1.time_ and arg_373_1.time_ <= var_376_23 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_25 = arg_373_1:FormatText(StoryNameCfg[384].name)

				arg_373_1.leftNameTxt_.text = var_376_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_26 = arg_373_1:GetWordFromCfg(120141091)
				local var_376_27 = arg_373_1:FormatText(var_376_26.content)

				arg_373_1.text_.text = var_376_27

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_28 = 24
				local var_376_29 = utf8.len(var_376_27)
				local var_376_30 = var_376_28 <= 0 and var_376_24 or var_376_24 * (var_376_29 / var_376_28)

				if var_376_30 > 0 and var_376_24 < var_376_30 then
					arg_373_1.talkMaxDuration = var_376_30

					if var_376_30 + var_376_23 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_30 + var_376_23
					end
				end

				arg_373_1.text_.text = var_376_27
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141091", "story_v_out_120141.awb") ~= 0 then
					local var_376_31 = manager.audio:GetVoiceLength("story_v_out_120141", "120141091", "story_v_out_120141.awb") / 1000

					if var_376_31 + var_376_23 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_31 + var_376_23
					end

					if var_376_26.prefab_name ~= "" and arg_373_1.actors_[var_376_26.prefab_name] ~= nil then
						local var_376_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_26.prefab_name].transform, "story_v_out_120141", "120141091", "story_v_out_120141.awb")

						arg_373_1:RecordAudio("120141091", var_376_32)
						arg_373_1:RecordAudio("120141091", var_376_32)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_120141", "120141091", "story_v_out_120141.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_120141", "120141091", "story_v_out_120141.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_33 = math.max(var_376_24, arg_373_1.talkMaxDuration)

			if var_376_23 <= arg_373_1.time_ and arg_373_1.time_ < var_376_23 + var_376_33 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_23) / var_376_33

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_23 + var_376_33 and arg_373_1.time_ < var_376_23 + var_376_33 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
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
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play120141092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 120141092
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play120141093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["1071ui_story"].transform
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.var_.moveOldPos1071ui_story = var_380_0.localPosition
			end

			local var_380_2 = 0.001

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_2 then
				local var_380_3 = (arg_377_1.time_ - var_380_1) / var_380_2
				local var_380_4 = Vector3.New(0, 100, 0)

				var_380_0.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1071ui_story, var_380_4, var_380_3)

				local var_380_5 = manager.ui.mainCamera.transform.position - var_380_0.position

				var_380_0.forward = Vector3.New(var_380_5.x, var_380_5.y, var_380_5.z)

				local var_380_6 = var_380_0.localEulerAngles

				var_380_6.z = 0
				var_380_6.x = 0
				var_380_0.localEulerAngles = var_380_6
			end

			if arg_377_1.time_ >= var_380_1 + var_380_2 and arg_377_1.time_ < var_380_1 + var_380_2 + arg_380_0 then
				var_380_0.localPosition = Vector3.New(0, 100, 0)

				local var_380_7 = manager.ui.mainCamera.transform.position - var_380_0.position

				var_380_0.forward = Vector3.New(var_380_7.x, var_380_7.y, var_380_7.z)

				local var_380_8 = var_380_0.localEulerAngles

				var_380_8.z = 0
				var_380_8.x = 0
				var_380_0.localEulerAngles = var_380_8
			end

			local var_380_9 = 0
			local var_380_10 = 0.975

			if var_380_9 < arg_377_1.time_ and arg_377_1.time_ <= var_380_9 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_11 = arg_377_1:GetWordFromCfg(120141092)
				local var_380_12 = arg_377_1:FormatText(var_380_11.content)

				arg_377_1.text_.text = var_380_12

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_13 = 39
				local var_380_14 = utf8.len(var_380_12)
				local var_380_15 = var_380_13 <= 0 and var_380_10 or var_380_10 * (var_380_14 / var_380_13)

				if var_380_15 > 0 and var_380_10 < var_380_15 then
					arg_377_1.talkMaxDuration = var_380_15

					if var_380_15 + var_380_9 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_15 + var_380_9
					end
				end

				arg_377_1.text_.text = var_380_12
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_16 = math.max(var_380_10, arg_377_1.talkMaxDuration)

			if var_380_9 <= arg_377_1.time_ and arg_377_1.time_ < var_380_9 + var_380_16 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_9) / var_380_16

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_9 + var_380_16 and arg_377_1.time_ < var_380_9 + var_380_16 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play120141093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 120141093
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play120141094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0
			local var_384_1 = 0.7

			if var_384_0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_2 = arg_381_1:GetWordFromCfg(120141093)
				local var_384_3 = arg_381_1:FormatText(var_384_2.content)

				arg_381_1.text_.text = var_384_3

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_4 = 28
				local var_384_5 = utf8.len(var_384_3)
				local var_384_6 = var_384_4 <= 0 and var_384_1 or var_384_1 * (var_384_5 / var_384_4)

				if var_384_6 > 0 and var_384_1 < var_384_6 then
					arg_381_1.talkMaxDuration = var_384_6

					if var_384_6 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_6 + var_384_0
					end
				end

				arg_381_1.text_.text = var_384_3
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_7 = math.max(var_384_1, arg_381_1.talkMaxDuration)

			if var_384_0 <= arg_381_1.time_ and arg_381_1.time_ < var_384_0 + var_384_7 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_0) / var_384_7

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_0 + var_384_7 and arg_381_1.time_ < var_384_0 + var_384_7 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play120141094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 120141094
		arg_385_1.duration_ = 5.67

		local var_385_0 = {
			zh = 2.3,
			ja = 5.666
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
			arg_385_1.auto_ = false
		end

		function arg_385_1.playNext_(arg_387_0)
			arg_385_1.onStoryFinished_()
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["1075ui_story"].transform
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 then
				arg_385_1.var_.moveOldPos1075ui_story = var_388_0.localPosition
			end

			local var_388_2 = 0.001

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2
				local var_388_4 = Vector3.New(0, -1.055, -6.16)

				var_388_0.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1075ui_story, var_388_4, var_388_3)

				local var_388_5 = manager.ui.mainCamera.transform.position - var_388_0.position

				var_388_0.forward = Vector3.New(var_388_5.x, var_388_5.y, var_388_5.z)

				local var_388_6 = var_388_0.localEulerAngles

				var_388_6.z = 0
				var_388_6.x = 0
				var_388_0.localEulerAngles = var_388_6
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 then
				var_388_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_388_7 = manager.ui.mainCamera.transform.position - var_388_0.position

				var_388_0.forward = Vector3.New(var_388_7.x, var_388_7.y, var_388_7.z)

				local var_388_8 = var_388_0.localEulerAngles

				var_388_8.z = 0
				var_388_8.x = 0
				var_388_0.localEulerAngles = var_388_8
			end

			local var_388_9 = arg_385_1.actors_["1075ui_story"]
			local var_388_10 = 0

			if var_388_10 < arg_385_1.time_ and arg_385_1.time_ <= var_388_10 + arg_388_0 and not isNil(var_388_9) and arg_385_1.var_.characterEffect1075ui_story == nil then
				arg_385_1.var_.characterEffect1075ui_story = var_388_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_11 = 0.2

			if var_388_10 <= arg_385_1.time_ and arg_385_1.time_ < var_388_10 + var_388_11 and not isNil(var_388_9) then
				local var_388_12 = (arg_385_1.time_ - var_388_10) / var_388_11

				if arg_385_1.var_.characterEffect1075ui_story and not isNil(var_388_9) then
					arg_385_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= var_388_10 + var_388_11 and arg_385_1.time_ < var_388_10 + var_388_11 + arg_388_0 and not isNil(var_388_9) and arg_385_1.var_.characterEffect1075ui_story then
				arg_385_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_388_13 = 0

			if var_388_13 < arg_385_1.time_ and arg_385_1.time_ <= var_388_13 + arg_388_0 then
				arg_385_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_388_14 = 0

			if var_388_14 < arg_385_1.time_ and arg_385_1.time_ <= var_388_14 + arg_388_0 then
				arg_385_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_388_15 = 0
			local var_388_16 = 0.325

			if var_388_15 < arg_385_1.time_ and arg_385_1.time_ <= var_388_15 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_17 = arg_385_1:FormatText(StoryNameCfg[381].name)

				arg_385_1.leftNameTxt_.text = var_388_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_18 = arg_385_1:GetWordFromCfg(120141094)
				local var_388_19 = arg_385_1:FormatText(var_388_18.content)

				arg_385_1.text_.text = var_388_19

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_20 = 13
				local var_388_21 = utf8.len(var_388_19)
				local var_388_22 = var_388_20 <= 0 and var_388_16 or var_388_16 * (var_388_21 / var_388_20)

				if var_388_22 > 0 and var_388_16 < var_388_22 then
					arg_385_1.talkMaxDuration = var_388_22

					if var_388_22 + var_388_15 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_22 + var_388_15
					end
				end

				arg_385_1.text_.text = var_388_19
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120141", "120141094", "story_v_out_120141.awb") ~= 0 then
					local var_388_23 = manager.audio:GetVoiceLength("story_v_out_120141", "120141094", "story_v_out_120141.awb") / 1000

					if var_388_23 + var_388_15 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_23 + var_388_15
					end

					if var_388_18.prefab_name ~= "" and arg_385_1.actors_[var_388_18.prefab_name] ~= nil then
						local var_388_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_18.prefab_name].transform, "story_v_out_120141", "120141094", "story_v_out_120141.awb")

						arg_385_1:RecordAudio("120141094", var_388_24)
						arg_385_1:RecordAudio("120141094", var_388_24)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_120141", "120141094", "story_v_out_120141.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_120141", "120141094", "story_v_out_120141.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_25 = math.max(var_388_16, arg_385_1.talkMaxDuration)

			if var_388_15 <= arg_385_1.time_ and arg_385_1.time_ < var_388_15 + var_388_25 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_15) / var_388_25

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_15 + var_388_25 and arg_385_1.time_ < var_388_15 + var_388_25 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
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

		arg_385_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J04f",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/XH0107"
	},
	voices = {
		"story_v_out_120141.awb"
	}
}
