return {
	Play120021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 120021001
		arg_1_1.duration_ = 4.37

		local var_1_0 = {
			zh = 4.299999999999,
			ja = 4.366
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
				arg_1_0:Play120021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST29"

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
				local var_4_5 = arg_1_1.bgs_.ST29

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
					if iter_4_0 ~= "ST29" then
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
			local var_4_28 = 2

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos1072ui_story = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(0, -0.71, -6)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1072ui_story, var_4_31, var_4_30)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_27.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_27.localEulerAngles = var_4_33
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, -0.71, -6)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_27.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_27.localEulerAngles = var_4_35
			end

			local var_4_36 = arg_1_1.actors_["1072ui_story"]
			local var_4_37 = 2

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1072ui_story == nil then
				arg_1_1.var_.characterEffect1072ui_story = var_4_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_38 = 0.2

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 and not isNil(var_4_36) then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38

				if arg_1_1.var_.characterEffect1072ui_story and not isNil(var_4_36) then
					arg_1_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1072ui_story then
				arg_1_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_4_40 = 2

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_4_41 = 2

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_4_42 = 0
			local var_4_43 = 0.166666666666667

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

			local var_4_48 = 0.4
			local var_4_49 = 1

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "music"

				arg_1_1:AudioAction(var_4_50, var_4_51, "bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu.awb")

				local var_4_52 = ""
				local var_4_53 = manager.audio:GetAudioName("bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu")

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
			local var_4_55 = 0.2

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

				local var_4_57 = arg_1_1:FormatText(StoryNameCfg[379].name)

				arg_1_1.leftNameTxt_.text = var_4_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_58 = arg_1_1:GetWordFromCfg(120021001)
				local var_4_59 = arg_1_1:FormatText(var_4_58.content)

				arg_1_1.text_.text = var_4_59

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_60 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021001", "story_v_out_120021.awb") ~= 0 then
					local var_4_63 = manager.audio:GetVoiceLength("story_v_out_120021", "120021001", "story_v_out_120021.awb") / 1000

					if var_4_63 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_63 + var_4_54
					end

					if var_4_58.prefab_name ~= "" and arg_1_1.actors_[var_4_58.prefab_name] ~= nil then
						local var_4_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_58.prefab_name].transform, "story_v_out_120021", "120021001", "story_v_out_120021.awb")

						arg_1_1:RecordAudio("120021001", var_4_64)
						arg_1_1:RecordAudio("120021001", var_4_64)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_120021", "120021001", "story_v_out_120021.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_120021", "120021001", "story_v_out_120021.awb")
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
				actorName = "1072ui_story",
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
	Play120021002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 120021002
		arg_9_1.duration_ = 13.83

		local var_9_0 = {
			zh = 13.2,
			ja = 13.833
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
				arg_9_0:Play120021003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_12_1 = 0
			local var_12_2 = 1.575

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_3 = arg_9_1:FormatText(StoryNameCfg[379].name)

				arg_9_1.leftNameTxt_.text = var_12_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_4 = arg_9_1:GetWordFromCfg(120021002)
				local var_12_5 = arg_9_1:FormatText(var_12_4.content)

				arg_9_1.text_.text = var_12_5

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_6 = 63
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

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021002", "story_v_out_120021.awb") ~= 0 then
					local var_12_9 = manager.audio:GetVoiceLength("story_v_out_120021", "120021002", "story_v_out_120021.awb") / 1000

					if var_12_9 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_9 + var_12_1
					end

					if var_12_4.prefab_name ~= "" and arg_9_1.actors_[var_12_4.prefab_name] ~= nil then
						local var_12_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_4.prefab_name].transform, "story_v_out_120021", "120021002", "story_v_out_120021.awb")

						arg_9_1:RecordAudio("120021002", var_12_10)
						arg_9_1:RecordAudio("120021002", var_12_10)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_120021", "120021002", "story_v_out_120021.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_120021", "120021002", "story_v_out_120021.awb")
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
	Play120021003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 120021003
		arg_13_1.duration_ = 12.1

		local var_13_0 = {
			zh = 10.033,
			ja = 12.1
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
				arg_13_0:Play120021004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_1")
			end

			local var_16_2 = 0
			local var_16_3 = 1.35

			if var_16_2 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_4 = arg_13_1:FormatText(StoryNameCfg[379].name)

				arg_13_1.leftNameTxt_.text = var_16_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_5 = arg_13_1:GetWordFromCfg(120021003)
				local var_16_6 = arg_13_1:FormatText(var_16_5.content)

				arg_13_1.text_.text = var_16_6

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_7 = 53
				local var_16_8 = utf8.len(var_16_6)
				local var_16_9 = var_16_7 <= 0 and var_16_3 or var_16_3 * (var_16_8 / var_16_7)

				if var_16_9 > 0 and var_16_3 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_2
					end
				end

				arg_13_1.text_.text = var_16_6
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021003", "story_v_out_120021.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_out_120021", "120021003", "story_v_out_120021.awb") / 1000

					if var_16_10 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_2
					end

					if var_16_5.prefab_name ~= "" and arg_13_1.actors_[var_16_5.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_5.prefab_name].transform, "story_v_out_120021", "120021003", "story_v_out_120021.awb")

						arg_13_1:RecordAudio("120021003", var_16_11)
						arg_13_1:RecordAudio("120021003", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_120021", "120021003", "story_v_out_120021.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_120021", "120021003", "story_v_out_120021.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_12 = math.max(var_16_3, arg_13_1.talkMaxDuration)

			if var_16_2 <= arg_13_1.time_ and arg_13_1.time_ < var_16_2 + var_16_12 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_2) / var_16_12

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_2 + var_16_12 and arg_13_1.time_ < var_16_2 + var_16_12 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play120021004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 120021004
		arg_17_1.duration_ = 14.2

		local var_17_0 = {
			zh = 12.166,
			ja = 14.2
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
				arg_17_0:Play120021005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_2")
			end

			local var_20_2 = 0
			local var_20_3 = 1.3

			if var_20_2 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_4 = arg_17_1:FormatText(StoryNameCfg[379].name)

				arg_17_1.leftNameTxt_.text = var_20_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_5 = arg_17_1:GetWordFromCfg(120021004)
				local var_20_6 = arg_17_1:FormatText(var_20_5.content)

				arg_17_1.text_.text = var_20_6

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 51
				local var_20_8 = utf8.len(var_20_6)
				local var_20_9 = var_20_7 <= 0 and var_20_3 or var_20_3 * (var_20_8 / var_20_7)

				if var_20_9 > 0 and var_20_3 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_6
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021004", "story_v_out_120021.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_120021", "120021004", "story_v_out_120021.awb") / 1000

					if var_20_10 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_2
					end

					if var_20_5.prefab_name ~= "" and arg_17_1.actors_[var_20_5.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_5.prefab_name].transform, "story_v_out_120021", "120021004", "story_v_out_120021.awb")

						arg_17_1:RecordAudio("120021004", var_20_11)
						arg_17_1:RecordAudio("120021004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_120021", "120021004", "story_v_out_120021.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_120021", "120021004", "story_v_out_120021.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_12 = math.max(var_20_3, arg_17_1.talkMaxDuration)

			if var_20_2 <= arg_17_1.time_ and arg_17_1.time_ < var_20_2 + var_20_12 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_2) / var_20_12

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_2 + var_20_12 and arg_17_1.time_ < var_20_2 + var_20_12 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play120021005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 120021005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play120021006(arg_21_1)
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
				local var_24_4 = Vector3.New(0, 100, 0)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1072ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, 100, 0)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = 0
			local var_24_10 = 1.075

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_11 = arg_21_1:GetWordFromCfg(120021005)
				local var_24_12 = arg_21_1:FormatText(var_24_11.content)

				arg_21_1.text_.text = var_24_12

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 43
				local var_24_14 = utf8.len(var_24_12)
				local var_24_15 = var_24_13 <= 0 and var_24_10 or var_24_10 * (var_24_14 / var_24_13)

				if var_24_15 > 0 and var_24_10 < var_24_15 then
					arg_21_1.talkMaxDuration = var_24_15

					if var_24_15 + var_24_9 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_15 + var_24_9
					end
				end

				arg_21_1.text_.text = var_24_12
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_10, arg_21_1.talkMaxDuration)

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_9) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_9 + var_24_16 and arg_21_1.time_ < var_24_9 + var_24_16 + arg_24_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play120021006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 120021006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play120021007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.875

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_2 = arg_25_1:GetWordFromCfg(120021006)
				local var_28_3 = arg_25_1:FormatText(var_28_2.content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 35
				local var_28_5 = utf8.len(var_28_3)
				local var_28_6 = var_28_4 <= 0 and var_28_1 or var_28_1 * (var_28_5 / var_28_4)

				if var_28_6 > 0 and var_28_1 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_7 and arg_25_1.time_ < var_28_0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play120021007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 120021007
		arg_29_1.duration_ = 5.77

		local var_29_0 = {
			zh = 3.966,
			ja = 5.766
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
				arg_29_0:Play120021008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "1069ui_story"

			if arg_29_1.actors_[var_32_0] == nil then
				local var_32_1 = Asset.Load("Char/" .. "1069ui_story")

				if not isNil(var_32_1) then
					local var_32_2 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_29_1.stage_.transform)

					var_32_2.name = var_32_0
					var_32_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_29_1.actors_[var_32_0] = var_32_2

					local var_32_3 = var_32_2:GetComponentInChildren(typeof(CharacterEffect))

					var_32_3.enabled = true

					local var_32_4 = GameObjectTools.GetOrAddComponent(var_32_2, typeof(DynamicBoneHelper))

					if var_32_4 then
						var_32_4:EnableDynamicBone(false)
					end

					arg_29_1:ShowWeapon(var_32_3.transform, false)

					arg_29_1.var_[var_32_0 .. "Animator"] = var_32_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_29_1.var_[var_32_0 .. "Animator"].applyRootMotion = true
					arg_29_1.var_[var_32_0 .. "LipSync"] = var_32_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_32_5 = arg_29_1.actors_["1069ui_story"].transform
			local var_32_6 = 0

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.var_.moveOldPos1069ui_story = var_32_5.localPosition
			end

			local var_32_7 = 0.001

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_7 then
				local var_32_8 = (arg_29_1.time_ - var_32_6) / var_32_7
				local var_32_9 = Vector3.New(-0.7, -1, -6)

				var_32_5.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1069ui_story, var_32_9, var_32_8)

				local var_32_10 = manager.ui.mainCamera.transform.position - var_32_5.position

				var_32_5.forward = Vector3.New(var_32_10.x, var_32_10.y, var_32_10.z)

				local var_32_11 = var_32_5.localEulerAngles

				var_32_11.z = 0
				var_32_11.x = 0
				var_32_5.localEulerAngles = var_32_11
			end

			if arg_29_1.time_ >= var_32_6 + var_32_7 and arg_29_1.time_ < var_32_6 + var_32_7 + arg_32_0 then
				var_32_5.localPosition = Vector3.New(-0.7, -1, -6)

				local var_32_12 = manager.ui.mainCamera.transform.position - var_32_5.position

				var_32_5.forward = Vector3.New(var_32_12.x, var_32_12.y, var_32_12.z)

				local var_32_13 = var_32_5.localEulerAngles

				var_32_13.z = 0
				var_32_13.x = 0
				var_32_5.localEulerAngles = var_32_13
			end

			local var_32_14 = arg_29_1.actors_["1069ui_story"]
			local var_32_15 = 0

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.characterEffect1069ui_story == nil then
				arg_29_1.var_.characterEffect1069ui_story = var_32_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_16 = 0.2

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_16 and not isNil(var_32_14) then
				local var_32_17 = (arg_29_1.time_ - var_32_15) / var_32_16

				if arg_29_1.var_.characterEffect1069ui_story and not isNil(var_32_14) then
					arg_29_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_15 + var_32_16 and arg_29_1.time_ < var_32_15 + var_32_16 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.characterEffect1069ui_story then
				arg_29_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_32_18 = 0

			if var_32_18 < arg_29_1.time_ and arg_29_1.time_ <= var_32_18 + arg_32_0 then
				arg_29_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_32_19 = 0

			if var_32_19 < arg_29_1.time_ and arg_29_1.time_ <= var_32_19 + arg_32_0 then
				arg_29_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			local var_32_20 = arg_29_1.actors_["1072ui_story"].transform
			local var_32_21 = 0

			if var_32_21 < arg_29_1.time_ and arg_29_1.time_ <= var_32_21 + arg_32_0 then
				arg_29_1.var_.moveOldPos1072ui_story = var_32_20.localPosition
			end

			local var_32_22 = 0.001

			if var_32_21 <= arg_29_1.time_ and arg_29_1.time_ < var_32_21 + var_32_22 then
				local var_32_23 = (arg_29_1.time_ - var_32_21) / var_32_22
				local var_32_24 = Vector3.New(0.7, -0.71, -6)

				var_32_20.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1072ui_story, var_32_24, var_32_23)

				local var_32_25 = manager.ui.mainCamera.transform.position - var_32_20.position

				var_32_20.forward = Vector3.New(var_32_25.x, var_32_25.y, var_32_25.z)

				local var_32_26 = var_32_20.localEulerAngles

				var_32_26.z = 0
				var_32_26.x = 0
				var_32_20.localEulerAngles = var_32_26
			end

			if arg_29_1.time_ >= var_32_21 + var_32_22 and arg_29_1.time_ < var_32_21 + var_32_22 + arg_32_0 then
				var_32_20.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_32_27 = manager.ui.mainCamera.transform.position - var_32_20.position

				var_32_20.forward = Vector3.New(var_32_27.x, var_32_27.y, var_32_27.z)

				local var_32_28 = var_32_20.localEulerAngles

				var_32_28.z = 0
				var_32_28.x = 0
				var_32_20.localEulerAngles = var_32_28
			end

			local var_32_29 = arg_29_1.actors_["1072ui_story"]
			local var_32_30 = 0

			if var_32_30 < arg_29_1.time_ and arg_29_1.time_ <= var_32_30 + arg_32_0 and not isNil(var_32_29) and arg_29_1.var_.characterEffect1072ui_story == nil then
				arg_29_1.var_.characterEffect1072ui_story = var_32_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_31 = 0.0166666666666667

			if var_32_30 <= arg_29_1.time_ and arg_29_1.time_ < var_32_30 + var_32_31 and not isNil(var_32_29) then
				local var_32_32 = (arg_29_1.time_ - var_32_30) / var_32_31

				if arg_29_1.var_.characterEffect1072ui_story and not isNil(var_32_29) then
					local var_32_33 = Mathf.Lerp(0, 0.5, var_32_32)

					arg_29_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1072ui_story.fillRatio = var_32_33
				end
			end

			if arg_29_1.time_ >= var_32_30 + var_32_31 and arg_29_1.time_ < var_32_30 + var_32_31 + arg_32_0 and not isNil(var_32_29) and arg_29_1.var_.characterEffect1072ui_story then
				local var_32_34 = 0.5

				arg_29_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1072ui_story.fillRatio = var_32_34
			end

			local var_32_35 = 0
			local var_32_36 = 0.425

			if var_32_35 < arg_29_1.time_ and arg_29_1.time_ <= var_32_35 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_37 = arg_29_1:FormatText(StoryNameCfg[378].name)

				arg_29_1.leftNameTxt_.text = var_32_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_38 = arg_29_1:GetWordFromCfg(120021007)
				local var_32_39 = arg_29_1:FormatText(var_32_38.content)

				arg_29_1.text_.text = var_32_39

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_40 = 17
				local var_32_41 = utf8.len(var_32_39)
				local var_32_42 = var_32_40 <= 0 and var_32_36 or var_32_36 * (var_32_41 / var_32_40)

				if var_32_42 > 0 and var_32_36 < var_32_42 then
					arg_29_1.talkMaxDuration = var_32_42

					if var_32_42 + var_32_35 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_42 + var_32_35
					end
				end

				arg_29_1.text_.text = var_32_39
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021007", "story_v_out_120021.awb") ~= 0 then
					local var_32_43 = manager.audio:GetVoiceLength("story_v_out_120021", "120021007", "story_v_out_120021.awb") / 1000

					if var_32_43 + var_32_35 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_43 + var_32_35
					end

					if var_32_38.prefab_name ~= "" and arg_29_1.actors_[var_32_38.prefab_name] ~= nil then
						local var_32_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_38.prefab_name].transform, "story_v_out_120021", "120021007", "story_v_out_120021.awb")

						arg_29_1:RecordAudio("120021007", var_32_44)
						arg_29_1:RecordAudio("120021007", var_32_44)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_120021", "120021007", "story_v_out_120021.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_120021", "120021007", "story_v_out_120021.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_45 = math.max(var_32_36, arg_29_1.talkMaxDuration)

			if var_32_35 <= arg_29_1.time_ and arg_29_1.time_ < var_32_35 + var_32_45 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_35) / var_32_45

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_35 + var_32_45 and arg_29_1.time_ < var_32_35 + var_32_45 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play120021008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 120021008
		arg_33_1.duration_ = 4.73

		local var_33_0 = {
			zh = 4.733,
			ja = 2.566
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
				arg_33_0:Play120021009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1072ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1072ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(0.7, -0.71, -6)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1072ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["1072ui_story"]
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1072ui_story == nil then
				arg_33_1.var_.characterEffect1072ui_story = var_36_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.2

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 and not isNil(var_36_9) then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11

				if arg_33_1.var_.characterEffect1072ui_story and not isNil(var_36_9) then
					arg_33_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1072ui_story then
				arg_33_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_36_13 = 0

			if var_36_13 < arg_33_1.time_ and arg_33_1.time_ <= var_36_13 + arg_36_0 then
				arg_33_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_14 = 0

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_1")
			end

			local var_36_15 = arg_33_1.actors_["1069ui_story"]
			local var_36_16 = 0

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.characterEffect1069ui_story == nil then
				arg_33_1.var_.characterEffect1069ui_story = var_36_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_17 = 0.2

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_17 and not isNil(var_36_15) then
				local var_36_18 = (arg_33_1.time_ - var_36_16) / var_36_17

				if arg_33_1.var_.characterEffect1069ui_story and not isNil(var_36_15) then
					local var_36_19 = Mathf.Lerp(0, 0.5, var_36_18)

					arg_33_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1069ui_story.fillRatio = var_36_19
				end
			end

			if arg_33_1.time_ >= var_36_16 + var_36_17 and arg_33_1.time_ < var_36_16 + var_36_17 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.characterEffect1069ui_story then
				local var_36_20 = 0.5

				arg_33_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1069ui_story.fillRatio = var_36_20
			end

			local var_36_21 = 0
			local var_36_22 = 0.425

			if var_36_21 < arg_33_1.time_ and arg_33_1.time_ <= var_36_21 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_23 = arg_33_1:FormatText(StoryNameCfg[379].name)

				arg_33_1.leftNameTxt_.text = var_36_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_24 = arg_33_1:GetWordFromCfg(120021008)
				local var_36_25 = arg_33_1:FormatText(var_36_24.content)

				arg_33_1.text_.text = var_36_25

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_26 = 17
				local var_36_27 = utf8.len(var_36_25)
				local var_36_28 = var_36_26 <= 0 and var_36_22 or var_36_22 * (var_36_27 / var_36_26)

				if var_36_28 > 0 and var_36_22 < var_36_28 then
					arg_33_1.talkMaxDuration = var_36_28

					if var_36_28 + var_36_21 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_28 + var_36_21
					end
				end

				arg_33_1.text_.text = var_36_25
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021008", "story_v_out_120021.awb") ~= 0 then
					local var_36_29 = manager.audio:GetVoiceLength("story_v_out_120021", "120021008", "story_v_out_120021.awb") / 1000

					if var_36_29 + var_36_21 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_29 + var_36_21
					end

					if var_36_24.prefab_name ~= "" and arg_33_1.actors_[var_36_24.prefab_name] ~= nil then
						local var_36_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_24.prefab_name].transform, "story_v_out_120021", "120021008", "story_v_out_120021.awb")

						arg_33_1:RecordAudio("120021008", var_36_30)
						arg_33_1:RecordAudio("120021008", var_36_30)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_120021", "120021008", "story_v_out_120021.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_120021", "120021008", "story_v_out_120021.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_31 = math.max(var_36_22, arg_33_1.talkMaxDuration)

			if var_36_21 <= arg_33_1.time_ and arg_33_1.time_ < var_36_21 + var_36_31 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_21) / var_36_31

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_21 + var_36_31 and arg_33_1.time_ < var_36_21 + var_36_31 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play120021009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 120021009
		arg_37_1.duration_ = 14.2

		local var_37_0 = {
			zh = 10.833,
			ja = 14.2
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
				arg_37_0:Play120021010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_40_1 = 0
			local var_40_2 = 1.05

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_3 = arg_37_1:FormatText(StoryNameCfg[379].name)

				arg_37_1.leftNameTxt_.text = var_40_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:GetWordFromCfg(120021009)
				local var_40_5 = arg_37_1:FormatText(var_40_4.content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 42
				local var_40_7 = utf8.len(var_40_5)
				local var_40_8 = var_40_6 <= 0 and var_40_2 or var_40_2 * (var_40_7 / var_40_6)

				if var_40_8 > 0 and var_40_2 < var_40_8 then
					arg_37_1.talkMaxDuration = var_40_8

					if var_40_8 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021009", "story_v_out_120021.awb") ~= 0 then
					local var_40_9 = manager.audio:GetVoiceLength("story_v_out_120021", "120021009", "story_v_out_120021.awb") / 1000

					if var_40_9 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_1
					end

					if var_40_4.prefab_name ~= "" and arg_37_1.actors_[var_40_4.prefab_name] ~= nil then
						local var_40_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_4.prefab_name].transform, "story_v_out_120021", "120021009", "story_v_out_120021.awb")

						arg_37_1:RecordAudio("120021009", var_40_10)
						arg_37_1:RecordAudio("120021009", var_40_10)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_120021", "120021009", "story_v_out_120021.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_120021", "120021009", "story_v_out_120021.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_11 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_11 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_11

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_11 and arg_37_1.time_ < var_40_1 + var_40_11 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play120021010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 120021010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play120021011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1072ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1072ui_story == nil then
				arg_41_1.var_.characterEffect1072ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1072ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1072ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1072ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1072ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_2")
			end

			local var_44_7 = 0

			if var_44_7 < arg_41_1.time_ and arg_41_1.time_ <= var_44_7 + arg_44_0 then
				arg_41_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_44_8 = 0
			local var_44_9 = 0.3

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_10 = arg_41_1:FormatText(StoryNameCfg[7].name)

				arg_41_1.leftNameTxt_.text = var_44_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_11 = arg_41_1:GetWordFromCfg(120021010)
				local var_44_12 = arg_41_1:FormatText(var_44_11.content)

				arg_41_1.text_.text = var_44_12

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 12
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
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_16 and arg_41_1.time_ < var_44_8 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play120021011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 120021011
		arg_45_1.duration_ = 10.77

		local var_45_0 = {
			zh = 9.2,
			ja = 10.766
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
				arg_45_0:Play120021012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1072ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1072ui_story == nil then
				arg_45_1.var_.characterEffect1072ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.2

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
			local var_48_5 = 0.7

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_6 = arg_45_1:FormatText(StoryNameCfg[379].name)

				arg_45_1.leftNameTxt_.text = var_48_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_7 = arg_45_1:GetWordFromCfg(120021011)
				local var_48_8 = arg_45_1:FormatText(var_48_7.content)

				arg_45_1.text_.text = var_48_8

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 28
				local var_48_10 = utf8.len(var_48_8)
				local var_48_11 = var_48_9 <= 0 and var_48_5 or var_48_5 * (var_48_10 / var_48_9)

				if var_48_11 > 0 and var_48_5 < var_48_11 then
					arg_45_1.talkMaxDuration = var_48_11

					if var_48_11 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_8
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021011", "story_v_out_120021.awb") ~= 0 then
					local var_48_12 = manager.audio:GetVoiceLength("story_v_out_120021", "120021011", "story_v_out_120021.awb") / 1000

					if var_48_12 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_12 + var_48_4
					end

					if var_48_7.prefab_name ~= "" and arg_45_1.actors_[var_48_7.prefab_name] ~= nil then
						local var_48_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_7.prefab_name].transform, "story_v_out_120021", "120021011", "story_v_out_120021.awb")

						arg_45_1:RecordAudio("120021011", var_48_13)
						arg_45_1:RecordAudio("120021011", var_48_13)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_120021", "120021011", "story_v_out_120021.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_120021", "120021011", "story_v_out_120021.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_14 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_14 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_14

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_14 and arg_45_1.time_ < var_48_4 + var_48_14 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play120021012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 120021012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play120021013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1072ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1072ui_story == nil then
				arg_49_1.var_.characterEffect1072ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1072ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1072ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1072ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1072ui_story.fillRatio = var_52_5
			end

			local var_52_6 = 0
			local var_52_7 = 0.2

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_8 = arg_49_1:FormatText(StoryNameCfg[7].name)

				arg_49_1.leftNameTxt_.text = var_52_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_9 = arg_49_1:GetWordFromCfg(120021012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 8
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
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_14 and arg_49_1.time_ < var_52_6 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play120021013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 120021013
		arg_53_1.duration_ = 5.8

		local var_53_0 = {
			zh = 5.5,
			ja = 5.8
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
				arg_53_0:Play120021014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1072ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1072ui_story == nil then
				arg_53_1.var_.characterEffect1072ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.2

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
			local var_56_5 = 0.7

			if var_56_4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_6 = arg_53_1:FormatText(StoryNameCfg[379].name)

				arg_53_1.leftNameTxt_.text = var_56_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_7 = arg_53_1:GetWordFromCfg(120021013)
				local var_56_8 = arg_53_1:FormatText(var_56_7.content)

				arg_53_1.text_.text = var_56_8

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 26
				local var_56_10 = utf8.len(var_56_8)
				local var_56_11 = var_56_9 <= 0 and var_56_5 or var_56_5 * (var_56_10 / var_56_9)

				if var_56_11 > 0 and var_56_5 < var_56_11 then
					arg_53_1.talkMaxDuration = var_56_11

					if var_56_11 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_8
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021013", "story_v_out_120021.awb") ~= 0 then
					local var_56_12 = manager.audio:GetVoiceLength("story_v_out_120021", "120021013", "story_v_out_120021.awb") / 1000

					if var_56_12 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_12 + var_56_4
					end

					if var_56_7.prefab_name ~= "" and arg_53_1.actors_[var_56_7.prefab_name] ~= nil then
						local var_56_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_7.prefab_name].transform, "story_v_out_120021", "120021013", "story_v_out_120021.awb")

						arg_53_1:RecordAudio("120021013", var_56_13)
						arg_53_1:RecordAudio("120021013", var_56_13)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_120021", "120021013", "story_v_out_120021.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_120021", "120021013", "story_v_out_120021.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_14 and arg_53_1.time_ < var_56_4 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play120021014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 120021014
		arg_57_1.duration_ = 13.77

		local var_57_0 = {
			zh = 13,
			ja = 13.766
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
				arg_57_0:Play120021015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1.55

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[379].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(120021014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 62
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

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021014", "story_v_out_120021.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021014", "story_v_out_120021.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_120021", "120021014", "story_v_out_120021.awb")

						arg_57_1:RecordAudio("120021014", var_60_9)
						arg_57_1:RecordAudio("120021014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_120021", "120021014", "story_v_out_120021.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_120021", "120021014", "story_v_out_120021.awb")
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
	Play120021015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 120021015
		arg_61_1.duration_ = 6.63

		local var_61_0 = {
			zh = 6.133,
			ja = 6.633
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
				arg_61_0:Play120021016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.65

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[379].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(120021015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021015", "story_v_out_120021.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021015", "story_v_out_120021.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_120021", "120021015", "story_v_out_120021.awb")

						arg_61_1:RecordAudio("120021015", var_64_9)
						arg_61_1:RecordAudio("120021015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_120021", "120021015", "story_v_out_120021.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_120021", "120021015", "story_v_out_120021.awb")
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
	Play120021016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 120021016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play120021017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1072ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1072ui_story == nil then
				arg_65_1.var_.characterEffect1072ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1072ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1072ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1072ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1072ui_story.fillRatio = var_68_5
			end

			local var_68_6 = 0
			local var_68_7 = 0.2

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_8 = arg_65_1:FormatText(StoryNameCfg[7].name)

				arg_65_1.leftNameTxt_.text = var_68_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_9 = arg_65_1:GetWordFromCfg(120021016)
				local var_68_10 = arg_65_1:FormatText(var_68_9.content)

				arg_65_1.text_.text = var_68_10

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 8
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
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_14 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_14 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_14

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_14 and arg_65_1.time_ < var_68_6 + var_68_14 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play120021017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 120021017
		arg_69_1.duration_ = 9.9

		local var_69_0 = {
			zh = 5.2,
			ja = 9.9
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
				arg_69_0:Play120021018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1072ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1072ui_story == nil then
				arg_69_1.var_.characterEffect1072ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1072ui_story and not isNil(var_72_0) then
					arg_69_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1072ui_story then
				arg_69_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_72_4 = 0

			if var_72_4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_72_5 = 0

			if var_72_5 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_1")
			end

			local var_72_6 = 0
			local var_72_7 = 0.525

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_8 = arg_69_1:FormatText(StoryNameCfg[379].name)

				arg_69_1.leftNameTxt_.text = var_72_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_9 = arg_69_1:GetWordFromCfg(120021017)
				local var_72_10 = arg_69_1:FormatText(var_72_9.content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021017", "story_v_out_120021.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_out_120021", "120021017", "story_v_out_120021.awb") / 1000

					if var_72_14 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_6
					end

					if var_72_9.prefab_name ~= "" and arg_69_1.actors_[var_72_9.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_9.prefab_name].transform, "story_v_out_120021", "120021017", "story_v_out_120021.awb")

						arg_69_1:RecordAudio("120021017", var_72_15)
						arg_69_1:RecordAudio("120021017", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_120021", "120021017", "story_v_out_120021.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_120021", "120021017", "story_v_out_120021.awb")
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
	Play120021018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 120021018
		arg_73_1.duration_ = 11.2

		local var_73_0 = {
			zh = 9.866,
			ja = 11.2
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
				arg_73_0:Play120021019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_2")
			end

			local var_76_1 = 0
			local var_76_2 = 1.05

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_3 = arg_73_1:FormatText(StoryNameCfg[379].name)

				arg_73_1.leftNameTxt_.text = var_76_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(120021018)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 42
				local var_76_7 = utf8.len(var_76_5)
				local var_76_8 = var_76_6 <= 0 and var_76_2 or var_76_2 * (var_76_7 / var_76_6)

				if var_76_8 > 0 and var_76_2 < var_76_8 then
					arg_73_1.talkMaxDuration = var_76_8

					if var_76_8 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021018", "story_v_out_120021.awb") ~= 0 then
					local var_76_9 = manager.audio:GetVoiceLength("story_v_out_120021", "120021018", "story_v_out_120021.awb") / 1000

					if var_76_9 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_1
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_out_120021", "120021018", "story_v_out_120021.awb")

						arg_73_1:RecordAudio("120021018", var_76_10)
						arg_73_1:RecordAudio("120021018", var_76_10)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_120021", "120021018", "story_v_out_120021.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_120021", "120021018", "story_v_out_120021.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_11 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_11 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_11

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_11 and arg_73_1.time_ < var_76_1 + var_76_11 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play120021019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 120021019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play120021020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1072ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos1072ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(0, 100, 0)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1072ui_story, var_80_4, var_80_3)

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

			local var_80_9 = arg_77_1.actors_["1069ui_story"].transform
			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1.var_.moveOldPos1069ui_story = var_80_9.localPosition
			end

			local var_80_11 = 0.001

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_11 then
				local var_80_12 = (arg_77_1.time_ - var_80_10) / var_80_11
				local var_80_13 = Vector3.New(0, 100, 0)

				var_80_9.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1069ui_story, var_80_13, var_80_12)

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

			local var_80_18 = 0
			local var_80_19 = 1.1

			if var_80_18 < arg_77_1.time_ and arg_77_1.time_ <= var_80_18 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_20 = arg_77_1:GetWordFromCfg(120021019)
				local var_80_21 = arg_77_1:FormatText(var_80_20.content)

				arg_77_1.text_.text = var_80_21

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_22 = 44
				local var_80_23 = utf8.len(var_80_21)
				local var_80_24 = var_80_22 <= 0 and var_80_19 or var_80_19 * (var_80_23 / var_80_22)

				if var_80_24 > 0 and var_80_19 < var_80_24 then
					arg_77_1.talkMaxDuration = var_80_24

					if var_80_24 + var_80_18 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_24 + var_80_18
					end
				end

				arg_77_1.text_.text = var_80_21
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_25 = math.max(var_80_19, arg_77_1.talkMaxDuration)

			if var_80_18 <= arg_77_1.time_ and arg_77_1.time_ < var_80_18 + var_80_25 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_18) / var_80_25

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_18 + var_80_25 and arg_77_1.time_ < var_80_18 + var_80_25 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
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
				actorName = "1069ui_story",
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
	Play120021020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 120021020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play120021021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.1

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[7].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:GetWordFromCfg(120021020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 4
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
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_8 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_8 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_8

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_8 and arg_81_1.time_ < var_84_0 + var_84_8 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play120021021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 120021021
		arg_85_1.duration_ = 11.57

		local var_85_0 = {
			zh = 9.5,
			ja = 11.566
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
				arg_85_0:Play120021022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1072ui_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1072ui_story = var_88_0.localPosition
			end

			local var_88_2 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2
				local var_88_4 = Vector3.New(0, -0.71, -6)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1072ui_story, var_88_4, var_88_3)

				local var_88_5 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_5.x, var_88_5.y, var_88_5.z)

				local var_88_6 = var_88_0.localEulerAngles

				var_88_6.z = 0
				var_88_6.x = 0
				var_88_0.localEulerAngles = var_88_6
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_88_7 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_7.x, var_88_7.y, var_88_7.z)

				local var_88_8 = var_88_0.localEulerAngles

				var_88_8.z = 0
				var_88_8.x = 0
				var_88_0.localEulerAngles = var_88_8
			end

			local var_88_9 = arg_85_1.actors_["1072ui_story"]
			local var_88_10 = 0

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect1072ui_story == nil then
				arg_85_1.var_.characterEffect1072ui_story = var_88_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_11 = 0.2

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_11 and not isNil(var_88_9) then
				local var_88_12 = (arg_85_1.time_ - var_88_10) / var_88_11

				if arg_85_1.var_.characterEffect1072ui_story and not isNil(var_88_9) then
					arg_85_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_10 + var_88_11 and arg_85_1.time_ < var_88_10 + var_88_11 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect1072ui_story then
				arg_85_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_88_13 = 0

			if var_88_13 < arg_85_1.time_ and arg_85_1.time_ <= var_88_13 + arg_88_0 then
				arg_85_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_88_14 = 0

			if var_88_14 < arg_85_1.time_ and arg_85_1.time_ <= var_88_14 + arg_88_0 then
				arg_85_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_88_15 = 0
			local var_88_16 = 1.175

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_17 = arg_85_1:FormatText(StoryNameCfg[379].name)

				arg_85_1.leftNameTxt_.text = var_88_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_18 = arg_85_1:GetWordFromCfg(120021021)
				local var_88_19 = arg_85_1:FormatText(var_88_18.content)

				arg_85_1.text_.text = var_88_19

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_20 = 47
				local var_88_21 = utf8.len(var_88_19)
				local var_88_22 = var_88_20 <= 0 and var_88_16 or var_88_16 * (var_88_21 / var_88_20)

				if var_88_22 > 0 and var_88_16 < var_88_22 then
					arg_85_1.talkMaxDuration = var_88_22

					if var_88_22 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_22 + var_88_15
					end
				end

				arg_85_1.text_.text = var_88_19
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021021", "story_v_out_120021.awb") ~= 0 then
					local var_88_23 = manager.audio:GetVoiceLength("story_v_out_120021", "120021021", "story_v_out_120021.awb") / 1000

					if var_88_23 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_15
					end

					if var_88_18.prefab_name ~= "" and arg_85_1.actors_[var_88_18.prefab_name] ~= nil then
						local var_88_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_18.prefab_name].transform, "story_v_out_120021", "120021021", "story_v_out_120021.awb")

						arg_85_1:RecordAudio("120021021", var_88_24)
						arg_85_1:RecordAudio("120021021", var_88_24)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_120021", "120021021", "story_v_out_120021.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_120021", "120021021", "story_v_out_120021.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_25 = math.max(var_88_16, arg_85_1.talkMaxDuration)

			if var_88_15 <= arg_85_1.time_ and arg_85_1.time_ < var_88_15 + var_88_25 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_15) / var_88_25

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_15 + var_88_25 and arg_85_1.time_ < var_88_15 + var_88_25 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play120021022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 120021022
		arg_89_1.duration_ = 8.97

		local var_89_0 = {
			zh = 8.966,
			ja = 5
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
				arg_89_0:Play120021023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 1.05

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[379].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:GetWordFromCfg(120021022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021022", "story_v_out_120021.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021022", "story_v_out_120021.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_120021", "120021022", "story_v_out_120021.awb")

						arg_89_1:RecordAudio("120021022", var_92_9)
						arg_89_1:RecordAudio("120021022", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_120021", "120021022", "story_v_out_120021.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_120021", "120021022", "story_v_out_120021.awb")
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
	Play120021023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 120021023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play120021024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1072ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1072ui_story == nil then
				arg_93_1.var_.characterEffect1072ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect1072ui_story and not isNil(var_96_0) then
					local var_96_4 = Mathf.Lerp(0, 0.5, var_96_3)

					arg_93_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1072ui_story.fillRatio = var_96_4
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1072ui_story then
				local var_96_5 = 0.5

				arg_93_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1072ui_story.fillRatio = var_96_5
			end

			local var_96_6 = 0
			local var_96_7 = 1.25

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_8 = arg_93_1:GetWordFromCfg(120021023)
				local var_96_9 = arg_93_1:FormatText(var_96_8.content)

				arg_93_1.text_.text = var_96_9

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_10 = 50
				local var_96_11 = utf8.len(var_96_9)
				local var_96_12 = var_96_10 <= 0 and var_96_7 or var_96_7 * (var_96_11 / var_96_10)

				if var_96_12 > 0 and var_96_7 < var_96_12 then
					arg_93_1.talkMaxDuration = var_96_12

					if var_96_12 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_12 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_9
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_13 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_13 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_13

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_13 and arg_93_1.time_ < var_96_6 + var_96_13 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play120021024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 120021024
		arg_97_1.duration_ = 4.5

		local var_97_0 = {
			zh = 2.5,
			ja = 4.5
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
				arg_97_0:Play120021025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1072ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1072ui_story == nil then
				arg_97_1.var_.characterEffect1072ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.2

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1072ui_story and not isNil(var_100_0) then
					arg_97_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1072ui_story then
				arg_97_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_100_4 = 0
			local var_100_5 = 0.275

			if var_100_4 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_6 = arg_97_1:FormatText(StoryNameCfg[379].name)

				arg_97_1.leftNameTxt_.text = var_100_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_7 = arg_97_1:GetWordFromCfg(120021024)
				local var_100_8 = arg_97_1:FormatText(var_100_7.content)

				arg_97_1.text_.text = var_100_8

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 11
				local var_100_10 = utf8.len(var_100_8)
				local var_100_11 = var_100_9 <= 0 and var_100_5 or var_100_5 * (var_100_10 / var_100_9)

				if var_100_11 > 0 and var_100_5 < var_100_11 then
					arg_97_1.talkMaxDuration = var_100_11

					if var_100_11 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_11 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_8
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021024", "story_v_out_120021.awb") ~= 0 then
					local var_100_12 = manager.audio:GetVoiceLength("story_v_out_120021", "120021024", "story_v_out_120021.awb") / 1000

					if var_100_12 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_12 + var_100_4
					end

					if var_100_7.prefab_name ~= "" and arg_97_1.actors_[var_100_7.prefab_name] ~= nil then
						local var_100_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_7.prefab_name].transform, "story_v_out_120021", "120021024", "story_v_out_120021.awb")

						arg_97_1:RecordAudio("120021024", var_100_13)
						arg_97_1:RecordAudio("120021024", var_100_13)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_120021", "120021024", "story_v_out_120021.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_120021", "120021024", "story_v_out_120021.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_14 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_14 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_14

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_14 and arg_97_1.time_ < var_100_4 + var_100_14 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play120021025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 120021025
		arg_101_1.duration_ = 6.23

		local var_101_0 = {
			zh = 6.233,
			ja = 6.133
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
				arg_101_0:Play120021026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = "XH0103"

			if arg_101_1.bgs_[var_104_0] == nil then
				local var_104_1 = Object.Instantiate(arg_101_1.paintGo_)

				var_104_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_104_0)
				var_104_1.name = var_104_0
				var_104_1.transform.parent = arg_101_1.stage_.transform
				var_104_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.bgs_[var_104_0] = var_104_1
			end

			local var_104_2 = 2

			if var_104_2 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
				local var_104_3 = manager.ui.mainCamera.transform.localPosition
				local var_104_4 = Vector3.New(0, 0, 10) + Vector3.New(var_104_3.x, var_104_3.y, 0)
				local var_104_5 = arg_101_1.bgs_.XH0103

				var_104_5.transform.localPosition = var_104_4
				var_104_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_104_6 = var_104_5:GetComponent("SpriteRenderer")

				if var_104_6 and var_104_6.sprite then
					local var_104_7 = (var_104_5.transform.localPosition - var_104_3).z
					local var_104_8 = manager.ui.mainCameraCom_
					local var_104_9 = 2 * var_104_7 * Mathf.Tan(var_104_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_104_10 = var_104_9 * var_104_8.aspect
					local var_104_11 = var_104_6.sprite.bounds.size.x
					local var_104_12 = var_104_6.sprite.bounds.size.y
					local var_104_13 = var_104_10 / var_104_11
					local var_104_14 = var_104_9 / var_104_12
					local var_104_15 = var_104_14 < var_104_13 and var_104_13 or var_104_14

					var_104_5.transform.localScale = Vector3.New(var_104_15, var_104_15, 0)
				end

				for iter_104_0, iter_104_1 in pairs(arg_101_1.bgs_) do
					if iter_104_0 ~= "XH0103" then
						iter_104_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_104_16 = arg_101_1.actors_["1072ui_story"].transform
			local var_104_17 = 2

			if var_104_17 < arg_101_1.time_ and arg_101_1.time_ <= var_104_17 + arg_104_0 then
				arg_101_1.var_.moveOldPos1072ui_story = var_104_16.localPosition
			end

			local var_104_18 = 0.001

			if var_104_17 <= arg_101_1.time_ and arg_101_1.time_ < var_104_17 + var_104_18 then
				local var_104_19 = (arg_101_1.time_ - var_104_17) / var_104_18
				local var_104_20 = Vector3.New(0, 100, 0)

				var_104_16.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1072ui_story, var_104_20, var_104_19)

				local var_104_21 = manager.ui.mainCamera.transform.position - var_104_16.position

				var_104_16.forward = Vector3.New(var_104_21.x, var_104_21.y, var_104_21.z)

				local var_104_22 = var_104_16.localEulerAngles

				var_104_22.z = 0
				var_104_22.x = 0
				var_104_16.localEulerAngles = var_104_22
			end

			if arg_101_1.time_ >= var_104_17 + var_104_18 and arg_101_1.time_ < var_104_17 + var_104_18 + arg_104_0 then
				var_104_16.localPosition = Vector3.New(0, 100, 0)

				local var_104_23 = manager.ui.mainCamera.transform.position - var_104_16.position

				var_104_16.forward = Vector3.New(var_104_23.x, var_104_23.y, var_104_23.z)

				local var_104_24 = var_104_16.localEulerAngles

				var_104_24.z = 0
				var_104_24.x = 0
				var_104_16.localEulerAngles = var_104_24
			end

			local var_104_25 = 0

			if var_104_25 < arg_101_1.time_ and arg_101_1.time_ <= var_104_25 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_26 = 2

			if var_104_25 <= arg_101_1.time_ and arg_101_1.time_ < var_104_25 + var_104_26 then
				local var_104_27 = (arg_101_1.time_ - var_104_25) / var_104_26
				local var_104_28 = Color.New(0, 0, 0)

				var_104_28.a = Mathf.Lerp(0, 1, var_104_27)
				arg_101_1.mask_.color = var_104_28
			end

			if arg_101_1.time_ >= var_104_25 + var_104_26 and arg_101_1.time_ < var_104_25 + var_104_26 + arg_104_0 then
				local var_104_29 = Color.New(0, 0, 0)

				var_104_29.a = 1
				arg_101_1.mask_.color = var_104_29
			end

			local var_104_30 = 2

			if var_104_30 < arg_101_1.time_ and arg_101_1.time_ <= var_104_30 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_31 = 2

			if var_104_30 <= arg_101_1.time_ and arg_101_1.time_ < var_104_30 + var_104_31 then
				local var_104_32 = (arg_101_1.time_ - var_104_30) / var_104_31
				local var_104_33 = Color.New(0, 0, 0)

				var_104_33.a = Mathf.Lerp(1, 0, var_104_32)
				arg_101_1.mask_.color = var_104_33
			end

			if arg_101_1.time_ >= var_104_30 + var_104_31 and arg_101_1.time_ < var_104_30 + var_104_31 + arg_104_0 then
				local var_104_34 = Color.New(0, 0, 0)
				local var_104_35 = 0

				arg_101_1.mask_.enabled = false
				var_104_34.a = var_104_35
				arg_101_1.mask_.color = var_104_34
			end

			local var_104_36 = arg_101_1.bgs_.XH0103.transform
			local var_104_37 = 2

			if var_104_37 < arg_101_1.time_ and arg_101_1.time_ <= var_104_37 + arg_104_0 then
				arg_101_1.var_.moveOldPosXH0103 = var_104_36.localPosition
			end

			local var_104_38 = 0.001

			if var_104_37 <= arg_101_1.time_ and arg_101_1.time_ < var_104_37 + var_104_38 then
				local var_104_39 = (arg_101_1.time_ - var_104_37) / var_104_38
				local var_104_40 = Vector3.New(4.54, -1.3, -0.66)

				var_104_36.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPosXH0103, var_104_40, var_104_39)
			end

			if arg_101_1.time_ >= var_104_37 + var_104_38 and arg_101_1.time_ < var_104_37 + var_104_38 + arg_104_0 then
				var_104_36.localPosition = Vector3.New(4.54, -1.3, -0.66)
			end

			local var_104_41 = arg_101_1.bgs_.XH0103.transform
			local var_104_42 = 2.01666666666667

			if var_104_42 < arg_101_1.time_ and arg_101_1.time_ <= var_104_42 + arg_104_0 then
				arg_101_1.var_.moveOldPosXH0103 = var_104_41.localPosition
			end

			local var_104_43 = 3.5

			if var_104_42 <= arg_101_1.time_ and arg_101_1.time_ < var_104_42 + var_104_43 then
				local var_104_44 = (arg_101_1.time_ - var_104_42) / var_104_43
				local var_104_45 = Vector3.New(5.02, -1.3, -0.66)

				var_104_41.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPosXH0103, var_104_45, var_104_44)
			end

			if arg_101_1.time_ >= var_104_42 + var_104_43 and arg_101_1.time_ < var_104_42 + var_104_43 + arg_104_0 then
				var_104_41.localPosition = Vector3.New(5.02, -1.3, -0.66)
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_46 = 4
			local var_104_47 = 0.175

			if var_104_46 < arg_101_1.time_ and arg_101_1.time_ <= var_104_46 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_48 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_48:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_49 = arg_101_1:FormatText(StoryNameCfg[380].name)

				arg_101_1.leftNameTxt_.text = var_104_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_50 = arg_101_1:GetWordFromCfg(120021025)
				local var_104_51 = arg_101_1:FormatText(var_104_50.content)

				arg_101_1.text_.text = var_104_51

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_52 = 7
				local var_104_53 = utf8.len(var_104_51)
				local var_104_54 = var_104_52 <= 0 and var_104_47 or var_104_47 * (var_104_53 / var_104_52)

				if var_104_54 > 0 and var_104_47 < var_104_54 then
					arg_101_1.talkMaxDuration = var_104_54
					var_104_46 = var_104_46 + 0.3

					if var_104_54 + var_104_46 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_54 + var_104_46
					end
				end

				arg_101_1.text_.text = var_104_51
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021025", "story_v_out_120021.awb") ~= 0 then
					local var_104_55 = manager.audio:GetVoiceLength("story_v_out_120021", "120021025", "story_v_out_120021.awb") / 1000

					if var_104_55 + var_104_46 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_55 + var_104_46
					end

					if var_104_50.prefab_name ~= "" and arg_101_1.actors_[var_104_50.prefab_name] ~= nil then
						local var_104_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_50.prefab_name].transform, "story_v_out_120021", "120021025", "story_v_out_120021.awb")

						arg_101_1:RecordAudio("120021025", var_104_56)
						arg_101_1:RecordAudio("120021025", var_104_56)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_120021", "120021025", "story_v_out_120021.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_120021", "120021025", "story_v_out_120021.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_57 = var_104_46 + 0.3
			local var_104_58 = math.max(var_104_47, arg_101_1.talkMaxDuration)

			if var_104_57 <= arg_101_1.time_ and arg_101_1.time_ < var_104_57 + var_104_58 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_57) / var_104_58

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_57 + var_104_58 and arg_101_1.time_ < var_104_57 + var_104_58 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "XH0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play120021026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 120021026
		arg_107_1.duration_ = 9.73

		local var_107_0 = {
			zh = 8.533,
			ja = 9.733
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
				arg_107_0:Play120021027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.bgs_.XH0103.transform
			local var_110_1 = 2

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPosXH0103 = var_110_0.localPosition
			end

			local var_110_2 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2
				local var_110_4 = Vector3.New(-1.7, -1.3, -0.66)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPosXH0103, var_110_4, var_110_3)
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(-1.7, -1.3, -0.66)
			end

			local var_110_5 = arg_107_1.bgs_.XH0103.transform
			local var_110_6 = 2.01666666666667

			if var_110_6 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
				arg_107_1.var_.moveOldPosXH0103 = var_110_5.localPosition
			end

			local var_110_7 = 3.5

			if var_110_6 <= arg_107_1.time_ and arg_107_1.time_ < var_110_6 + var_110_7 then
				local var_110_8 = (arg_107_1.time_ - var_110_6) / var_110_7
				local var_110_9 = Vector3.New(-2.3, -1.3, -0.66)

				var_110_5.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPosXH0103, var_110_9, var_110_8)
			end

			if arg_107_1.time_ >= var_110_6 + var_110_7 and arg_107_1.time_ < var_110_6 + var_110_7 + arg_110_0 then
				var_110_5.localPosition = Vector3.New(-2.3, -1.3, -0.66)
			end

			local var_110_10 = 0

			if var_110_10 < arg_107_1.time_ and arg_107_1.time_ <= var_110_10 + arg_110_0 then
				arg_107_1.mask_.enabled = true
				arg_107_1.mask_.raycastTarget = true

				arg_107_1:SetGaussion(false)
			end

			local var_110_11 = 2

			if var_110_10 <= arg_107_1.time_ and arg_107_1.time_ < var_110_10 + var_110_11 then
				local var_110_12 = (arg_107_1.time_ - var_110_10) / var_110_11
				local var_110_13 = Color.New(0, 0, 0)

				var_110_13.a = Mathf.Lerp(0, 1, var_110_12)
				arg_107_1.mask_.color = var_110_13
			end

			if arg_107_1.time_ >= var_110_10 + var_110_11 and arg_107_1.time_ < var_110_10 + var_110_11 + arg_110_0 then
				local var_110_14 = Color.New(0, 0, 0)

				var_110_14.a = 1
				arg_107_1.mask_.color = var_110_14
			end

			local var_110_15 = 2

			if var_110_15 < arg_107_1.time_ and arg_107_1.time_ <= var_110_15 + arg_110_0 then
				arg_107_1.mask_.enabled = true
				arg_107_1.mask_.raycastTarget = true

				arg_107_1:SetGaussion(false)
			end

			local var_110_16 = 2

			if var_110_15 <= arg_107_1.time_ and arg_107_1.time_ < var_110_15 + var_110_16 then
				local var_110_17 = (arg_107_1.time_ - var_110_15) / var_110_16
				local var_110_18 = Color.New(0, 0, 0)

				var_110_18.a = Mathf.Lerp(1, 0, var_110_17)
				arg_107_1.mask_.color = var_110_18
			end

			if arg_107_1.time_ >= var_110_15 + var_110_16 and arg_107_1.time_ < var_110_15 + var_110_16 + arg_110_0 then
				local var_110_19 = Color.New(0, 0, 0)
				local var_110_20 = 0

				arg_107_1.mask_.enabled = false
				var_110_19.a = var_110_20
				arg_107_1.mask_.color = var_110_19
			end

			if arg_107_1.frameCnt_ <= 1 then
				arg_107_1.dialog_:SetActive(false)
			end

			local var_110_21 = 4.5
			local var_110_22 = 0.25

			if var_110_21 < arg_107_1.time_ and arg_107_1.time_ <= var_110_21 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0

				arg_107_1.dialog_:SetActive(true)

				arg_107_1.dialogCg_.alpha = 0

				local var_110_23 = LeanTween.value(arg_107_1.dialog_, 0, 1, 0.3)

				var_110_23:setOnUpdate(LuaHelper.FloatAction(function(arg_111_0)
					arg_107_1.dialogCg_.alpha = arg_111_0
				end))
				var_110_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_107_1.dialog_)
					var_110_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_107_1.duration_ = arg_107_1.duration_ + 0.3

				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_24 = arg_107_1:FormatText(StoryNameCfg[381].name)

				arg_107_1.leftNameTxt_.text = var_110_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_25 = arg_107_1:GetWordFromCfg(120021026)
				local var_110_26 = arg_107_1:FormatText(var_110_25.content)

				arg_107_1.text_.text = var_110_26

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_27 = 9
				local var_110_28 = utf8.len(var_110_26)
				local var_110_29 = var_110_27 <= 0 and var_110_22 or var_110_22 * (var_110_28 / var_110_27)

				if var_110_29 > 0 and var_110_22 < var_110_29 then
					arg_107_1.talkMaxDuration = var_110_29
					var_110_21 = var_110_21 + 0.3

					if var_110_29 + var_110_21 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_29 + var_110_21
					end
				end

				arg_107_1.text_.text = var_110_26
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021026", "story_v_out_120021.awb") ~= 0 then
					local var_110_30 = manager.audio:GetVoiceLength("story_v_out_120021", "120021026", "story_v_out_120021.awb") / 1000

					if var_110_30 + var_110_21 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_30 + var_110_21
					end

					if var_110_25.prefab_name ~= "" and arg_107_1.actors_[var_110_25.prefab_name] ~= nil then
						local var_110_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_25.prefab_name].transform, "story_v_out_120021", "120021026", "story_v_out_120021.awb")

						arg_107_1:RecordAudio("120021026", var_110_31)
						arg_107_1:RecordAudio("120021026", var_110_31)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_120021", "120021026", "story_v_out_120021.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_120021", "120021026", "story_v_out_120021.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_32 = var_110_21 + 0.3
			local var_110_33 = math.max(var_110_22, arg_107_1.talkMaxDuration)

			if var_110_32 <= arg_107_1.time_ and arg_107_1.time_ < var_110_32 + var_110_33 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_32) / var_110_33

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_32 + var_110_33 and arg_107_1.time_ < var_110_32 + var_110_33 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play120021027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 120021027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play120021028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 0.875

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

				local var_116_2 = arg_113_1:GetWordFromCfg(120021027)
				local var_116_3 = arg_113_1:FormatText(var_116_2.content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 35
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
	Play120021028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 120021028
		arg_117_1.duration_ = 13.33

		local var_117_0 = {
			zh = 9.933,
			ja = 13.333
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
				arg_117_0:Play120021029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				local var_120_1 = manager.ui.mainCamera.transform.localPosition
				local var_120_2 = Vector3.New(0, 0, 10) + Vector3.New(var_120_1.x, var_120_1.y, 0)
				local var_120_3 = arg_117_1.bgs_.XH0103

				var_120_3.transform.localPosition = var_120_2
				var_120_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_120_4 = var_120_3:GetComponent("SpriteRenderer")

				if var_120_4 and var_120_4.sprite then
					local var_120_5 = (var_120_3.transform.localPosition - var_120_1).z
					local var_120_6 = manager.ui.mainCameraCom_
					local var_120_7 = 2 * var_120_5 * Mathf.Tan(var_120_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_120_8 = var_120_7 * var_120_6.aspect
					local var_120_9 = var_120_4.sprite.bounds.size.x
					local var_120_10 = var_120_4.sprite.bounds.size.y
					local var_120_11 = var_120_8 / var_120_9
					local var_120_12 = var_120_7 / var_120_10
					local var_120_13 = var_120_12 < var_120_11 and var_120_11 or var_120_12

					var_120_3.transform.localScale = Vector3.New(var_120_13, var_120_13, 0)
				end

				for iter_120_0, iter_120_1 in pairs(arg_117_1.bgs_) do
					if iter_120_0 ~= "XH0103" then
						iter_120_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_120_14 = 0

			if var_120_14 < arg_117_1.time_ and arg_117_1.time_ <= var_120_14 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_15 = 3.5

			if var_120_14 <= arg_117_1.time_ and arg_117_1.time_ < var_120_14 + var_120_15 then
				local var_120_16 = (arg_117_1.time_ - var_120_14) / var_120_15
				local var_120_17 = Color.New(1, 1, 1)

				var_120_17.a = Mathf.Lerp(1, 0, var_120_16)
				arg_117_1.mask_.color = var_120_17
			end

			if arg_117_1.time_ >= var_120_14 + var_120_15 and arg_117_1.time_ < var_120_14 + var_120_15 + arg_120_0 then
				local var_120_18 = Color.New(1, 1, 1)
				local var_120_19 = 0

				arg_117_1.mask_.enabled = false
				var_120_18.a = var_120_19
				arg_117_1.mask_.color = var_120_18
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_20 = 3.5
			local var_120_21 = 0.6

			if var_120_20 < arg_117_1.time_ and arg_117_1.time_ <= var_120_20 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_22 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_22:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_23 = arg_117_1:FormatText(StoryNameCfg[381].name)

				arg_117_1.leftNameTxt_.text = var_120_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_24 = arg_117_1:GetWordFromCfg(120021028)
				local var_120_25 = arg_117_1:FormatText(var_120_24.content)

				arg_117_1.text_.text = var_120_25

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_26 = 24
				local var_120_27 = utf8.len(var_120_25)
				local var_120_28 = var_120_26 <= 0 and var_120_21 or var_120_21 * (var_120_27 / var_120_26)

				if var_120_28 > 0 and var_120_21 < var_120_28 then
					arg_117_1.talkMaxDuration = var_120_28
					var_120_20 = var_120_20 + 0.3

					if var_120_28 + var_120_20 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_28 + var_120_20
					end
				end

				arg_117_1.text_.text = var_120_25
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021028", "story_v_out_120021.awb") ~= 0 then
					local var_120_29 = manager.audio:GetVoiceLength("story_v_out_120021", "120021028", "story_v_out_120021.awb") / 1000

					if var_120_29 + var_120_20 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_29 + var_120_20
					end

					if var_120_24.prefab_name ~= "" and arg_117_1.actors_[var_120_24.prefab_name] ~= nil then
						local var_120_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_24.prefab_name].transform, "story_v_out_120021", "120021028", "story_v_out_120021.awb")

						arg_117_1:RecordAudio("120021028", var_120_30)
						arg_117_1:RecordAudio("120021028", var_120_30)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_120021", "120021028", "story_v_out_120021.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_120021", "120021028", "story_v_out_120021.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_31 = var_120_20 + 0.3
			local var_120_32 = math.max(var_120_21, arg_117_1.talkMaxDuration)

			if var_120_31 <= arg_117_1.time_ and arg_117_1.time_ < var_120_31 + var_120_32 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_31) / var_120_32

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_31 + var_120_32 and arg_117_1.time_ < var_120_31 + var_120_32 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play120021029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 120021029
		arg_123_1.duration_ = 1.4

		local var_123_0 = {
			zh = 1.3,
			ja = 1.4
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
				arg_123_0:Play120021030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.075

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_2 = arg_123_1:FormatText(StoryNameCfg[380].name)

				arg_123_1.leftNameTxt_.text = var_126_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10044")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_3 = arg_123_1:GetWordFromCfg(120021029)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021029", "story_v_out_120021.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021029", "story_v_out_120021.awb") / 1000

					if var_126_8 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_0
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_120021", "120021029", "story_v_out_120021.awb")

						arg_123_1:RecordAudio("120021029", var_126_9)
						arg_123_1:RecordAudio("120021029", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_120021", "120021029", "story_v_out_120021.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_120021", "120021029", "story_v_out_120021.awb")
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
	Play120021030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 120021030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play120021031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.25

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[7].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:GetWordFromCfg(120021030)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 10
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
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_8 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_8 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_8

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_8 and arg_127_1.time_ < var_130_0 + var_130_8 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play120021031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 120021031
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play120021032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 1.325

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_2 = arg_131_1:GetWordFromCfg(120021031)
				local var_134_3 = arg_131_1:FormatText(var_134_2.content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 53
				local var_134_5 = utf8.len(var_134_3)
				local var_134_6 = var_134_4 <= 0 and var_134_1 or var_134_1 * (var_134_5 / var_134_4)

				if var_134_6 > 0 and var_134_1 < var_134_6 then
					arg_131_1.talkMaxDuration = var_134_6

					if var_134_6 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_6 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_7 and arg_131_1.time_ < var_134_0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play120021032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 120021032
		arg_135_1.duration_ = 5.17

		local var_135_0 = {
			zh = 5.166,
			ja = 4.5
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
				arg_135_0:Play120021033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.475

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[380].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10044")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:GetWordFromCfg(120021032)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 21
				local var_138_6 = utf8.len(var_138_4)
				local var_138_7 = var_138_5 <= 0 and var_138_1 or var_138_1 * (var_138_6 / var_138_5)

				if var_138_7 > 0 and var_138_1 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021032", "story_v_out_120021.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021032", "story_v_out_120021.awb") / 1000

					if var_138_8 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_0
					end

					if var_138_3.prefab_name ~= "" and arg_135_1.actors_[var_138_3.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_3.prefab_name].transform, "story_v_out_120021", "120021032", "story_v_out_120021.awb")

						arg_135_1:RecordAudio("120021032", var_138_9)
						arg_135_1:RecordAudio("120021032", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_120021", "120021032", "story_v_out_120021.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_120021", "120021032", "story_v_out_120021.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_10 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_10 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_10

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_10 and arg_135_1.time_ < var_138_0 + var_138_10 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play120021033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 120021033
		arg_139_1.duration_ = 9.4

		local var_139_0 = {
			zh = 9.4,
			ja = 7.733
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
				arg_139_0:Play120021034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 1.05

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[381].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:GetWordFromCfg(120021033)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 42
				local var_142_6 = utf8.len(var_142_4)
				local var_142_7 = var_142_5 <= 0 and var_142_1 or var_142_1 * (var_142_6 / var_142_5)

				if var_142_7 > 0 and var_142_1 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021033", "story_v_out_120021.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021033", "story_v_out_120021.awb") / 1000

					if var_142_8 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_0
					end

					if var_142_3.prefab_name ~= "" and arg_139_1.actors_[var_142_3.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_3.prefab_name].transform, "story_v_out_120021", "120021033", "story_v_out_120021.awb")

						arg_139_1:RecordAudio("120021033", var_142_9)
						arg_139_1:RecordAudio("120021033", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_120021", "120021033", "story_v_out_120021.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_120021", "120021033", "story_v_out_120021.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_10 and arg_139_1.time_ < var_142_0 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play120021034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 120021034
		arg_143_1.duration_ = 5.2

		local var_143_0 = {
			zh = 5.2,
			ja = 4.666
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
				arg_143_0:Play120021035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.525

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[382].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:GetWordFromCfg(120021034)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021034", "story_v_out_120021.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021034", "story_v_out_120021.awb") / 1000

					if var_146_8 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_0
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_120021", "120021034", "story_v_out_120021.awb")

						arg_143_1:RecordAudio("120021034", var_146_9)
						arg_143_1:RecordAudio("120021034", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_120021", "120021034", "story_v_out_120021.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_120021", "120021034", "story_v_out_120021.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_10 and arg_143_1.time_ < var_146_0 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play120021035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 120021035
		arg_147_1.duration_ = 5.07

		local var_147_0 = {
			zh = 5.066,
			ja = 2.633
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
				arg_147_0:Play120021036(arg_147_1)
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

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[381].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_3 = arg_147_1:GetWordFromCfg(120021035)
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

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021035", "story_v_out_120021.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021035", "story_v_out_120021.awb") / 1000

					if var_150_8 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_0
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_120021", "120021035", "story_v_out_120021.awb")

						arg_147_1:RecordAudio("120021035", var_150_9)
						arg_147_1:RecordAudio("120021035", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_120021", "120021035", "story_v_out_120021.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_120021", "120021035", "story_v_out_120021.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_10 and arg_147_1.time_ < var_150_0 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play120021036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 120021036
		arg_151_1.duration_ = 11.23

		local var_151_0 = {
			zh = 9.8,
			ja = 11.233
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
				arg_151_0:Play120021037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 1.1

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_2 = arg_151_1:FormatText(StoryNameCfg[381].name)

				arg_151_1.leftNameTxt_.text = var_154_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_3 = arg_151_1:GetWordFromCfg(120021036)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021036", "story_v_out_120021.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021036", "story_v_out_120021.awb") / 1000

					if var_154_8 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_0
					end

					if var_154_3.prefab_name ~= "" and arg_151_1.actors_[var_154_3.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_3.prefab_name].transform, "story_v_out_120021", "120021036", "story_v_out_120021.awb")

						arg_151_1:RecordAudio("120021036", var_154_9)
						arg_151_1:RecordAudio("120021036", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_120021", "120021036", "story_v_out_120021.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_120021", "120021036", "story_v_out_120021.awb")
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
	Play120021037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 120021037
		arg_155_1.duration_ = 9.1

		local var_155_0 = {
			zh = 6.9,
			ja = 9.1
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play120021038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.75

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[382].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_3 = arg_155_1:GetWordFromCfg(120021037)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 30
				local var_158_6 = utf8.len(var_158_4)
				local var_158_7 = var_158_5 <= 0 and var_158_1 or var_158_1 * (var_158_6 / var_158_5)

				if var_158_7 > 0 and var_158_1 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_4
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021037", "story_v_out_120021.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021037", "story_v_out_120021.awb") / 1000

					if var_158_8 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_0
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_120021", "120021037", "story_v_out_120021.awb")

						arg_155_1:RecordAudio("120021037", var_158_9)
						arg_155_1:RecordAudio("120021037", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_120021", "120021037", "story_v_out_120021.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_120021", "120021037", "story_v_out_120021.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_10 and arg_155_1.time_ < var_158_0 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play120021038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 120021038
		arg_159_1.duration_ = 5.63

		local var_159_0 = {
			zh = 4.566,
			ja = 5.633
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
				arg_159_0:Play120021039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.475

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[381].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_3 = arg_159_1:GetWordFromCfg(120021038)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 19
				local var_162_6 = utf8.len(var_162_4)
				local var_162_7 = var_162_5 <= 0 and var_162_1 or var_162_1 * (var_162_6 / var_162_5)

				if var_162_7 > 0 and var_162_1 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021038", "story_v_out_120021.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021038", "story_v_out_120021.awb") / 1000

					if var_162_8 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_0
					end

					if var_162_3.prefab_name ~= "" and arg_159_1.actors_[var_162_3.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_3.prefab_name].transform, "story_v_out_120021", "120021038", "story_v_out_120021.awb")

						arg_159_1:RecordAudio("120021038", var_162_9)
						arg_159_1:RecordAudio("120021038", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_120021", "120021038", "story_v_out_120021.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_120021", "120021038", "story_v_out_120021.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_10 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_10 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_10

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_10 and arg_159_1.time_ < var_162_0 + var_162_10 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play120021039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 120021039
		arg_163_1.duration_ = 3.73

		local var_163_0 = {
			zh = 3.633,
			ja = 3.733
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
				arg_163_0:Play120021040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.4

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_2 = arg_163_1:FormatText(StoryNameCfg[381].name)

				arg_163_1.leftNameTxt_.text = var_166_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_3 = arg_163_1:GetWordFromCfg(120021039)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 16
				local var_166_6 = utf8.len(var_166_4)
				local var_166_7 = var_166_5 <= 0 and var_166_1 or var_166_1 * (var_166_6 / var_166_5)

				if var_166_7 > 0 and var_166_1 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_4
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021039", "story_v_out_120021.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021039", "story_v_out_120021.awb") / 1000

					if var_166_8 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_0
					end

					if var_166_3.prefab_name ~= "" and arg_163_1.actors_[var_166_3.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_3.prefab_name].transform, "story_v_out_120021", "120021039", "story_v_out_120021.awb")

						arg_163_1:RecordAudio("120021039", var_166_9)
						arg_163_1:RecordAudio("120021039", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_120021", "120021039", "story_v_out_120021.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_120021", "120021039", "story_v_out_120021.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_10 and arg_163_1.time_ < var_166_0 + var_166_10 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play120021040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 120021040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play120021041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 1.475

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_2 = arg_167_1:GetWordFromCfg(120021040)
				local var_170_3 = arg_167_1:FormatText(var_170_2.content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 59
				local var_170_5 = utf8.len(var_170_3)
				local var_170_6 = var_170_4 <= 0 and var_170_1 or var_170_1 * (var_170_5 / var_170_4)

				if var_170_6 > 0 and var_170_1 < var_170_6 then
					arg_167_1.talkMaxDuration = var_170_6

					if var_170_6 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_6 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_3
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_7 and arg_167_1.time_ < var_170_0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play120021041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 120021041
		arg_171_1.duration_ = 9

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play120021042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 2

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				local var_174_1 = manager.ui.mainCamera.transform.localPosition
				local var_174_2 = Vector3.New(0, 0, 10) + Vector3.New(var_174_1.x, var_174_1.y, 0)
				local var_174_3 = arg_171_1.bgs_.ST29

				var_174_3.transform.localPosition = var_174_2
				var_174_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_174_4 = var_174_3:GetComponent("SpriteRenderer")

				if var_174_4 and var_174_4.sprite then
					local var_174_5 = (var_174_3.transform.localPosition - var_174_1).z
					local var_174_6 = manager.ui.mainCameraCom_
					local var_174_7 = 2 * var_174_5 * Mathf.Tan(var_174_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_174_8 = var_174_7 * var_174_6.aspect
					local var_174_9 = var_174_4.sprite.bounds.size.x
					local var_174_10 = var_174_4.sprite.bounds.size.y
					local var_174_11 = var_174_8 / var_174_9
					local var_174_12 = var_174_7 / var_174_10
					local var_174_13 = var_174_12 < var_174_11 and var_174_11 or var_174_12

					var_174_3.transform.localScale = Vector3.New(var_174_13, var_174_13, 0)
				end

				for iter_174_0, iter_174_1 in pairs(arg_171_1.bgs_) do
					if iter_174_0 ~= "ST29" then
						iter_174_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_174_14 = 0

			if var_174_14 < arg_171_1.time_ and arg_171_1.time_ <= var_174_14 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_15 = 2

			if var_174_14 <= arg_171_1.time_ and arg_171_1.time_ < var_174_14 + var_174_15 then
				local var_174_16 = (arg_171_1.time_ - var_174_14) / var_174_15
				local var_174_17 = Color.New(0, 0, 0)

				var_174_17.a = Mathf.Lerp(0, 1, var_174_16)
				arg_171_1.mask_.color = var_174_17
			end

			if arg_171_1.time_ >= var_174_14 + var_174_15 and arg_171_1.time_ < var_174_14 + var_174_15 + arg_174_0 then
				local var_174_18 = Color.New(0, 0, 0)

				var_174_18.a = 1
				arg_171_1.mask_.color = var_174_18
			end

			local var_174_19 = 2

			if var_174_19 < arg_171_1.time_ and arg_171_1.time_ <= var_174_19 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_20 = 2

			if var_174_19 <= arg_171_1.time_ and arg_171_1.time_ < var_174_19 + var_174_20 then
				local var_174_21 = (arg_171_1.time_ - var_174_19) / var_174_20
				local var_174_22 = Color.New(0, 0, 0)

				var_174_22.a = Mathf.Lerp(1, 0, var_174_21)
				arg_171_1.mask_.color = var_174_22
			end

			if arg_171_1.time_ >= var_174_19 + var_174_20 and arg_171_1.time_ < var_174_19 + var_174_20 + arg_174_0 then
				local var_174_23 = Color.New(0, 0, 0)
				local var_174_24 = 0

				arg_171_1.mask_.enabled = false
				var_174_23.a = var_174_24
				arg_171_1.mask_.color = var_174_23
			end

			if arg_171_1.frameCnt_ <= 1 then
				arg_171_1.dialog_:SetActive(false)
			end

			local var_174_25 = 4
			local var_174_26 = 1.15

			if var_174_25 < arg_171_1.time_ and arg_171_1.time_ <= var_174_25 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0

				arg_171_1.dialog_:SetActive(true)

				arg_171_1.dialogCg_.alpha = 0

				local var_174_27 = LeanTween.value(arg_171_1.dialog_, 0, 1, 0.3)

				var_174_27:setOnUpdate(LuaHelper.FloatAction(function(arg_175_0)
					arg_171_1.dialogCg_.alpha = arg_175_0
				end))
				var_174_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_171_1.dialog_)
					var_174_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_171_1.duration_ = arg_171_1.duration_ + 0.3

				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_28 = arg_171_1:GetWordFromCfg(120021041)
				local var_174_29 = arg_171_1:FormatText(var_174_28.content)

				arg_171_1.text_.text = var_174_29

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_30 = 46
				local var_174_31 = utf8.len(var_174_29)
				local var_174_32 = var_174_30 <= 0 and var_174_26 or var_174_26 * (var_174_31 / var_174_30)

				if var_174_32 > 0 and var_174_26 < var_174_32 then
					arg_171_1.talkMaxDuration = var_174_32
					var_174_25 = var_174_25 + 0.3

					if var_174_32 + var_174_25 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_32 + var_174_25
					end
				end

				arg_171_1.text_.text = var_174_29
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_33 = var_174_25 + 0.3
			local var_174_34 = math.max(var_174_26, arg_171_1.talkMaxDuration)

			if var_174_33 <= arg_171_1.time_ and arg_171_1.time_ < var_174_33 + var_174_34 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_33) / var_174_34

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_33 + var_174_34 and arg_171_1.time_ < var_174_33 + var_174_34 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play120021042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 120021042
		arg_177_1.duration_ = 12.07

		local var_177_0 = {
			zh = 4.3,
			ja = 12.066
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
				arg_177_0:Play120021043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = "1075ui_story"

			if arg_177_1.actors_[var_180_0] == nil then
				local var_180_1 = Asset.Load("Char/" .. "1075ui_story")

				if not isNil(var_180_1) then
					local var_180_2 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_177_1.stage_.transform)

					var_180_2.name = var_180_0
					var_180_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_177_1.actors_[var_180_0] = var_180_2

					local var_180_3 = var_180_2:GetComponentInChildren(typeof(CharacterEffect))

					var_180_3.enabled = true

					local var_180_4 = GameObjectTools.GetOrAddComponent(var_180_2, typeof(DynamicBoneHelper))

					if var_180_4 then
						var_180_4:EnableDynamicBone(false)
					end

					arg_177_1:ShowWeapon(var_180_3.transform, false)

					arg_177_1.var_[var_180_0 .. "Animator"] = var_180_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_177_1.var_[var_180_0 .. "Animator"].applyRootMotion = true
					arg_177_1.var_[var_180_0 .. "LipSync"] = var_180_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_180_5 = arg_177_1.actors_["1075ui_story"].transform
			local var_180_6 = 0

			if var_180_6 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.var_.moveOldPos1075ui_story = var_180_5.localPosition
			end

			local var_180_7 = 0.001

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_7 then
				local var_180_8 = (arg_177_1.time_ - var_180_6) / var_180_7
				local var_180_9 = Vector3.New(-0.7, -1.055, -6.16)

				var_180_5.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1075ui_story, var_180_9, var_180_8)

				local var_180_10 = manager.ui.mainCamera.transform.position - var_180_5.position

				var_180_5.forward = Vector3.New(var_180_10.x, var_180_10.y, var_180_10.z)

				local var_180_11 = var_180_5.localEulerAngles

				var_180_11.z = 0
				var_180_11.x = 0
				var_180_5.localEulerAngles = var_180_11
			end

			if arg_177_1.time_ >= var_180_6 + var_180_7 and arg_177_1.time_ < var_180_6 + var_180_7 + arg_180_0 then
				var_180_5.localPosition = Vector3.New(-0.7, -1.055, -6.16)

				local var_180_12 = manager.ui.mainCamera.transform.position - var_180_5.position

				var_180_5.forward = Vector3.New(var_180_12.x, var_180_12.y, var_180_12.z)

				local var_180_13 = var_180_5.localEulerAngles

				var_180_13.z = 0
				var_180_13.x = 0
				var_180_5.localEulerAngles = var_180_13
			end

			local var_180_14 = arg_177_1.actors_["1075ui_story"]
			local var_180_15 = 0

			if var_180_15 < arg_177_1.time_ and arg_177_1.time_ <= var_180_15 + arg_180_0 and not isNil(var_180_14) and arg_177_1.var_.characterEffect1075ui_story == nil then
				arg_177_1.var_.characterEffect1075ui_story = var_180_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_16 = 0.2

			if var_180_15 <= arg_177_1.time_ and arg_177_1.time_ < var_180_15 + var_180_16 and not isNil(var_180_14) then
				local var_180_17 = (arg_177_1.time_ - var_180_15) / var_180_16

				if arg_177_1.var_.characterEffect1075ui_story and not isNil(var_180_14) then
					arg_177_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_15 + var_180_16 and arg_177_1.time_ < var_180_15 + var_180_16 + arg_180_0 and not isNil(var_180_14) and arg_177_1.var_.characterEffect1075ui_story then
				arg_177_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_180_18 = 0

			if var_180_18 < arg_177_1.time_ and arg_177_1.time_ <= var_180_18 + arg_180_0 then
				arg_177_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			local var_180_19 = 0

			if var_180_19 < arg_177_1.time_ and arg_177_1.time_ <= var_180_19 + arg_180_0 then
				arg_177_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_180_20 = "10044ui_story"

			if arg_177_1.actors_[var_180_20] == nil then
				local var_180_21 = Asset.Load("Char/" .. "10044ui_story")

				if not isNil(var_180_21) then
					local var_180_22 = Object.Instantiate(Asset.Load("Char/" .. "10044ui_story"), arg_177_1.stage_.transform)

					var_180_22.name = var_180_20
					var_180_22.transform.localPosition = Vector3.New(0, 100, 0)
					arg_177_1.actors_[var_180_20] = var_180_22

					local var_180_23 = var_180_22:GetComponentInChildren(typeof(CharacterEffect))

					var_180_23.enabled = true

					local var_180_24 = GameObjectTools.GetOrAddComponent(var_180_22, typeof(DynamicBoneHelper))

					if var_180_24 then
						var_180_24:EnableDynamicBone(false)
					end

					arg_177_1:ShowWeapon(var_180_23.transform, false)

					arg_177_1.var_[var_180_20 .. "Animator"] = var_180_23.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_177_1.var_[var_180_20 .. "Animator"].applyRootMotion = true
					arg_177_1.var_[var_180_20 .. "LipSync"] = var_180_23.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_180_25 = arg_177_1.actors_["10044ui_story"].transform
			local var_180_26 = 0

			if var_180_26 < arg_177_1.time_ and arg_177_1.time_ <= var_180_26 + arg_180_0 then
				arg_177_1.var_.moveOldPos10044ui_story = var_180_25.localPosition
			end

			local var_180_27 = 0.001

			if var_180_26 <= arg_177_1.time_ and arg_177_1.time_ < var_180_26 + var_180_27 then
				local var_180_28 = (arg_177_1.time_ - var_180_26) / var_180_27
				local var_180_29 = Vector3.New(0.7, -0.72, -6.3)

				var_180_25.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10044ui_story, var_180_29, var_180_28)

				local var_180_30 = manager.ui.mainCamera.transform.position - var_180_25.position

				var_180_25.forward = Vector3.New(var_180_30.x, var_180_30.y, var_180_30.z)

				local var_180_31 = var_180_25.localEulerAngles

				var_180_31.z = 0
				var_180_31.x = 0
				var_180_25.localEulerAngles = var_180_31
			end

			if arg_177_1.time_ >= var_180_26 + var_180_27 and arg_177_1.time_ < var_180_26 + var_180_27 + arg_180_0 then
				var_180_25.localPosition = Vector3.New(0.7, -0.72, -6.3)

				local var_180_32 = manager.ui.mainCamera.transform.position - var_180_25.position

				var_180_25.forward = Vector3.New(var_180_32.x, var_180_32.y, var_180_32.z)

				local var_180_33 = var_180_25.localEulerAngles

				var_180_33.z = 0
				var_180_33.x = 0
				var_180_25.localEulerAngles = var_180_33
			end

			local var_180_34 = arg_177_1.actors_["10044ui_story"]
			local var_180_35 = 0

			if var_180_35 < arg_177_1.time_ and arg_177_1.time_ <= var_180_35 + arg_180_0 and not isNil(var_180_34) and arg_177_1.var_.characterEffect10044ui_story == nil then
				arg_177_1.var_.characterEffect10044ui_story = var_180_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_36 = 0.0166666666666667

			if var_180_35 <= arg_177_1.time_ and arg_177_1.time_ < var_180_35 + var_180_36 and not isNil(var_180_34) then
				local var_180_37 = (arg_177_1.time_ - var_180_35) / var_180_36

				if arg_177_1.var_.characterEffect10044ui_story and not isNil(var_180_34) then
					local var_180_38 = Mathf.Lerp(0, 0.5, var_180_37)

					arg_177_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_177_1.var_.characterEffect10044ui_story.fillRatio = var_180_38
				end
			end

			if arg_177_1.time_ >= var_180_35 + var_180_36 and arg_177_1.time_ < var_180_35 + var_180_36 + arg_180_0 and not isNil(var_180_34) and arg_177_1.var_.characterEffect10044ui_story then
				local var_180_39 = 0.5

				arg_177_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_177_1.var_.characterEffect10044ui_story.fillRatio = var_180_39
			end

			local var_180_40 = 0

			if var_180_40 < arg_177_1.time_ and arg_177_1.time_ <= var_180_40 + arg_180_0 then
				arg_177_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_180_41 = 0
			local var_180_42 = 0.525

			if var_180_41 < arg_177_1.time_ and arg_177_1.time_ <= var_180_41 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_43 = arg_177_1:FormatText(StoryNameCfg[381].name)

				arg_177_1.leftNameTxt_.text = var_180_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_44 = arg_177_1:GetWordFromCfg(120021042)
				local var_180_45 = arg_177_1:FormatText(var_180_44.content)

				arg_177_1.text_.text = var_180_45

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_46 = 21
				local var_180_47 = utf8.len(var_180_45)
				local var_180_48 = var_180_46 <= 0 and var_180_42 or var_180_42 * (var_180_47 / var_180_46)

				if var_180_48 > 0 and var_180_42 < var_180_48 then
					arg_177_1.talkMaxDuration = var_180_48

					if var_180_48 + var_180_41 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_48 + var_180_41
					end
				end

				arg_177_1.text_.text = var_180_45
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021042", "story_v_out_120021.awb") ~= 0 then
					local var_180_49 = manager.audio:GetVoiceLength("story_v_out_120021", "120021042", "story_v_out_120021.awb") / 1000

					if var_180_49 + var_180_41 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_49 + var_180_41
					end

					if var_180_44.prefab_name ~= "" and arg_177_1.actors_[var_180_44.prefab_name] ~= nil then
						local var_180_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_44.prefab_name].transform, "story_v_out_120021", "120021042", "story_v_out_120021.awb")

						arg_177_1:RecordAudio("120021042", var_180_50)
						arg_177_1:RecordAudio("120021042", var_180_50)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_120021", "120021042", "story_v_out_120021.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_120021", "120021042", "story_v_out_120021.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_51 = math.max(var_180_42, arg_177_1.talkMaxDuration)

			if var_180_41 <= arg_177_1.time_ and arg_177_1.time_ < var_180_41 + var_180_51 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_41) / var_180_51

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_41 + var_180_51 and arg_177_1.time_ < var_180_41 + var_180_51 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
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
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play120021043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 120021043
		arg_181_1.duration_ = 6.8

		local var_181_0 = {
			zh = 6.6,
			ja = 6.8
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play120021044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 0.725

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[381].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_3 = arg_181_1:GetWordFromCfg(120021043)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 29
				local var_184_6 = utf8.len(var_184_4)
				local var_184_7 = var_184_5 <= 0 and var_184_1 or var_184_1 * (var_184_6 / var_184_5)

				if var_184_7 > 0 and var_184_1 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_4
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021043", "story_v_out_120021.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021043", "story_v_out_120021.awb") / 1000

					if var_184_8 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_0
					end

					if var_184_3.prefab_name ~= "" and arg_181_1.actors_[var_184_3.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_3.prefab_name].transform, "story_v_out_120021", "120021043", "story_v_out_120021.awb")

						arg_181_1:RecordAudio("120021043", var_184_9)
						arg_181_1:RecordAudio("120021043", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_120021", "120021043", "story_v_out_120021.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_120021", "120021043", "story_v_out_120021.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_10 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_10 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_10

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_10 and arg_181_1.time_ < var_184_0 + var_184_10 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play120021044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 120021044
		arg_185_1.duration_ = 7.6

		local var_185_0 = {
			zh = 6.1,
			ja = 7.6
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
				arg_185_0:Play120021045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1075ui_story"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1075ui_story == nil then
				arg_185_1.var_.characterEffect1075ui_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.2

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.characterEffect1075ui_story and not isNil(var_188_0) then
					local var_188_4 = Mathf.Lerp(0, 0.5, var_188_3)

					arg_185_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1075ui_story.fillRatio = var_188_4
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1075ui_story then
				local var_188_5 = 0.5

				arg_185_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1075ui_story.fillRatio = var_188_5
			end

			local var_188_6 = arg_185_1.actors_["10044ui_story"]
			local var_188_7 = 0

			if var_188_7 < arg_185_1.time_ and arg_185_1.time_ <= var_188_7 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect10044ui_story == nil then
				arg_185_1.var_.characterEffect10044ui_story = var_188_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_8 = 0.2

			if var_188_7 <= arg_185_1.time_ and arg_185_1.time_ < var_188_7 + var_188_8 and not isNil(var_188_6) then
				local var_188_9 = (arg_185_1.time_ - var_188_7) / var_188_8

				if arg_185_1.var_.characterEffect10044ui_story and not isNil(var_188_6) then
					arg_185_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_7 + var_188_8 and arg_185_1.time_ < var_188_7 + var_188_8 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect10044ui_story then
				arg_185_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_188_10 = 0

			if var_188_10 < arg_185_1.time_ and arg_185_1.time_ <= var_188_10 + arg_188_0 then
				arg_185_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_188_11 = 0

			if var_188_11 < arg_185_1.time_ and arg_185_1.time_ <= var_188_11 + arg_188_0 then
				arg_185_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_188_12 = 0
			local var_188_13 = 0.625

			if var_188_12 < arg_185_1.time_ and arg_185_1.time_ <= var_188_12 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_14 = arg_185_1:FormatText(StoryNameCfg[380].name)

				arg_185_1.leftNameTxt_.text = var_188_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_15 = arg_185_1:GetWordFromCfg(120021044)
				local var_188_16 = arg_185_1:FormatText(var_188_15.content)

				arg_185_1.text_.text = var_188_16

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_17 = 25
				local var_188_18 = utf8.len(var_188_16)
				local var_188_19 = var_188_17 <= 0 and var_188_13 or var_188_13 * (var_188_18 / var_188_17)

				if var_188_19 > 0 and var_188_13 < var_188_19 then
					arg_185_1.talkMaxDuration = var_188_19

					if var_188_19 + var_188_12 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_19 + var_188_12
					end
				end

				arg_185_1.text_.text = var_188_16
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021044", "story_v_out_120021.awb") ~= 0 then
					local var_188_20 = manager.audio:GetVoiceLength("story_v_out_120021", "120021044", "story_v_out_120021.awb") / 1000

					if var_188_20 + var_188_12 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_20 + var_188_12
					end

					if var_188_15.prefab_name ~= "" and arg_185_1.actors_[var_188_15.prefab_name] ~= nil then
						local var_188_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_15.prefab_name].transform, "story_v_out_120021", "120021044", "story_v_out_120021.awb")

						arg_185_1:RecordAudio("120021044", var_188_21)
						arg_185_1:RecordAudio("120021044", var_188_21)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_120021", "120021044", "story_v_out_120021.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_120021", "120021044", "story_v_out_120021.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_22 = math.max(var_188_13, arg_185_1.talkMaxDuration)

			if var_188_12 <= arg_185_1.time_ and arg_185_1.time_ < var_188_12 + var_188_22 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_12) / var_188_22

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_12 + var_188_22 and arg_185_1.time_ < var_188_12 + var_188_22 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play120021045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 120021045
		arg_189_1.duration_ = 5.77

		local var_189_0 = {
			zh = 5.766,
			ja = 5.6
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
				arg_189_0:Play120021046(arg_189_1)
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

			local var_192_4 = arg_189_1.actors_["10044ui_story"]
			local var_192_5 = 0

			if var_192_5 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 and not isNil(var_192_4) and arg_189_1.var_.characterEffect10044ui_story == nil then
				arg_189_1.var_.characterEffect10044ui_story = var_192_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_6 = 0.2

			if var_192_5 <= arg_189_1.time_ and arg_189_1.time_ < var_192_5 + var_192_6 and not isNil(var_192_4) then
				local var_192_7 = (arg_189_1.time_ - var_192_5) / var_192_6

				if arg_189_1.var_.characterEffect10044ui_story and not isNil(var_192_4) then
					local var_192_8 = Mathf.Lerp(0, 0.5, var_192_7)

					arg_189_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_189_1.var_.characterEffect10044ui_story.fillRatio = var_192_8
				end
			end

			if arg_189_1.time_ >= var_192_5 + var_192_6 and arg_189_1.time_ < var_192_5 + var_192_6 + arg_192_0 and not isNil(var_192_4) and arg_189_1.var_.characterEffect10044ui_story then
				local var_192_9 = 0.5

				arg_189_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_189_1.var_.characterEffect10044ui_story.fillRatio = var_192_9
			end

			local var_192_10 = 0

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 then
				arg_189_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action2_2")
			end

			local var_192_11 = 0

			if var_192_11 < arg_189_1.time_ and arg_189_1.time_ <= var_192_11 + arg_192_0 then
				arg_189_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_192_12 = 0
			local var_192_13 = 0.5

			if var_192_12 < arg_189_1.time_ and arg_189_1.time_ <= var_192_12 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_14 = arg_189_1:FormatText(StoryNameCfg[381].name)

				arg_189_1.leftNameTxt_.text = var_192_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_15 = arg_189_1:GetWordFromCfg(120021045)
				local var_192_16 = arg_189_1:FormatText(var_192_15.content)

				arg_189_1.text_.text = var_192_16

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_17 = 20
				local var_192_18 = utf8.len(var_192_16)
				local var_192_19 = var_192_17 <= 0 and var_192_13 or var_192_13 * (var_192_18 / var_192_17)

				if var_192_19 > 0 and var_192_13 < var_192_19 then
					arg_189_1.talkMaxDuration = var_192_19

					if var_192_19 + var_192_12 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_19 + var_192_12
					end
				end

				arg_189_1.text_.text = var_192_16
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021045", "story_v_out_120021.awb") ~= 0 then
					local var_192_20 = manager.audio:GetVoiceLength("story_v_out_120021", "120021045", "story_v_out_120021.awb") / 1000

					if var_192_20 + var_192_12 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_20 + var_192_12
					end

					if var_192_15.prefab_name ~= "" and arg_189_1.actors_[var_192_15.prefab_name] ~= nil then
						local var_192_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_15.prefab_name].transform, "story_v_out_120021", "120021045", "story_v_out_120021.awb")

						arg_189_1:RecordAudio("120021045", var_192_21)
						arg_189_1:RecordAudio("120021045", var_192_21)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_120021", "120021045", "story_v_out_120021.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_120021", "120021045", "story_v_out_120021.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_22 = math.max(var_192_13, arg_189_1.talkMaxDuration)

			if var_192_12 <= arg_189_1.time_ and arg_189_1.time_ < var_192_12 + var_192_22 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_12) / var_192_22

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_12 + var_192_22 and arg_189_1.time_ < var_192_12 + var_192_22 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play120021046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 120021046
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play120021047(arg_193_1)
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

			local var_196_6 = 0
			local var_196_7 = 0.275

			if var_196_6 < arg_193_1.time_ and arg_193_1.time_ <= var_196_6 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_8 = arg_193_1:FormatText(StoryNameCfg[7].name)

				arg_193_1.leftNameTxt_.text = var_196_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_9 = arg_193_1:GetWordFromCfg(120021046)
				local var_196_10 = arg_193_1:FormatText(var_196_9.content)

				arg_193_1.text_.text = var_196_10

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_11 = 11
				local var_196_12 = utf8.len(var_196_10)
				local var_196_13 = var_196_11 <= 0 and var_196_7 or var_196_7 * (var_196_12 / var_196_11)

				if var_196_13 > 0 and var_196_7 < var_196_13 then
					arg_193_1.talkMaxDuration = var_196_13

					if var_196_13 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_13 + var_196_6
					end
				end

				arg_193_1.text_.text = var_196_10
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_14 = math.max(var_196_7, arg_193_1.talkMaxDuration)

			if var_196_6 <= arg_193_1.time_ and arg_193_1.time_ < var_196_6 + var_196_14 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_6) / var_196_14

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_6 + var_196_14 and arg_193_1.time_ < var_196_6 + var_196_14 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play120021047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 120021047
		arg_197_1.duration_ = 6.43

		local var_197_0 = {
			zh = 5.233,
			ja = 6.433
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
				arg_197_0:Play120021048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1075ui_story"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1075ui_story == nil then
				arg_197_1.var_.characterEffect1075ui_story = var_200_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.2

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.characterEffect1075ui_story and not isNil(var_200_0) then
					arg_197_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1075ui_story then
				arg_197_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_200_4 = 0

			if var_200_4 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_200_5 = 0

			if var_200_5 < arg_197_1.time_ and arg_197_1.time_ <= var_200_5 + arg_200_0 then
				arg_197_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action6_1")
			end

			local var_200_6 = 0
			local var_200_7 = 0.55

			if var_200_6 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_8 = arg_197_1:FormatText(StoryNameCfg[381].name)

				arg_197_1.leftNameTxt_.text = var_200_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_9 = arg_197_1:GetWordFromCfg(120021047)
				local var_200_10 = arg_197_1:FormatText(var_200_9.content)

				arg_197_1.text_.text = var_200_10

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_11 = 22
				local var_200_12 = utf8.len(var_200_10)
				local var_200_13 = var_200_11 <= 0 and var_200_7 or var_200_7 * (var_200_12 / var_200_11)

				if var_200_13 > 0 and var_200_7 < var_200_13 then
					arg_197_1.talkMaxDuration = var_200_13

					if var_200_13 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_13 + var_200_6
					end
				end

				arg_197_1.text_.text = var_200_10
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021047", "story_v_out_120021.awb") ~= 0 then
					local var_200_14 = manager.audio:GetVoiceLength("story_v_out_120021", "120021047", "story_v_out_120021.awb") / 1000

					if var_200_14 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_14 + var_200_6
					end

					if var_200_9.prefab_name ~= "" and arg_197_1.actors_[var_200_9.prefab_name] ~= nil then
						local var_200_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_9.prefab_name].transform, "story_v_out_120021", "120021047", "story_v_out_120021.awb")

						arg_197_1:RecordAudio("120021047", var_200_15)
						arg_197_1:RecordAudio("120021047", var_200_15)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_120021", "120021047", "story_v_out_120021.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_120021", "120021047", "story_v_out_120021.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_16 = math.max(var_200_7, arg_197_1.talkMaxDuration)

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_16 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_6) / var_200_16

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_6 + var_200_16 and arg_197_1.time_ < var_200_6 + var_200_16 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play120021048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 120021048
		arg_201_1.duration_ = 2.07

		local var_201_0 = {
			zh = 2.066,
			ja = 1.999999999999
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
				arg_201_0:Play120021049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["10044ui_story"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos10044ui_story = var_204_0.localPosition
			end

			local var_204_2 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2
				local var_204_4 = Vector3.New(0, 100, 0)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10044ui_story, var_204_4, var_204_3)

				local var_204_5 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_5.x, var_204_5.y, var_204_5.z)

				local var_204_6 = var_204_0.localEulerAngles

				var_204_6.z = 0
				var_204_6.x = 0
				var_204_0.localEulerAngles = var_204_6
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(0, 100, 0)

				local var_204_7 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_7.x, var_204_7.y, var_204_7.z)

				local var_204_8 = var_204_0.localEulerAngles

				var_204_8.z = 0
				var_204_8.x = 0
				var_204_0.localEulerAngles = var_204_8
			end

			local var_204_9 = arg_201_1.actors_["1069ui_story"].transform
			local var_204_10 = 0

			if var_204_10 < arg_201_1.time_ and arg_201_1.time_ <= var_204_10 + arg_204_0 then
				arg_201_1.var_.moveOldPos1069ui_story = var_204_9.localPosition
			end

			local var_204_11 = 0.001

			if var_204_10 <= arg_201_1.time_ and arg_201_1.time_ < var_204_10 + var_204_11 then
				local var_204_12 = (arg_201_1.time_ - var_204_10) / var_204_11
				local var_204_13 = Vector3.New(0.7, -1, -6)

				var_204_9.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1069ui_story, var_204_13, var_204_12)

				local var_204_14 = manager.ui.mainCamera.transform.position - var_204_9.position

				var_204_9.forward = Vector3.New(var_204_14.x, var_204_14.y, var_204_14.z)

				local var_204_15 = var_204_9.localEulerAngles

				var_204_15.z = 0
				var_204_15.x = 0
				var_204_9.localEulerAngles = var_204_15
			end

			if arg_201_1.time_ >= var_204_10 + var_204_11 and arg_201_1.time_ < var_204_10 + var_204_11 + arg_204_0 then
				var_204_9.localPosition = Vector3.New(0.7, -1, -6)

				local var_204_16 = manager.ui.mainCamera.transform.position - var_204_9.position

				var_204_9.forward = Vector3.New(var_204_16.x, var_204_16.y, var_204_16.z)

				local var_204_17 = var_204_9.localEulerAngles

				var_204_17.z = 0
				var_204_17.x = 0
				var_204_9.localEulerAngles = var_204_17
			end

			local var_204_18 = arg_201_1.actors_["1069ui_story"]
			local var_204_19 = 0

			if var_204_19 < arg_201_1.time_ and arg_201_1.time_ <= var_204_19 + arg_204_0 and not isNil(var_204_18) and arg_201_1.var_.characterEffect1069ui_story == nil then
				arg_201_1.var_.characterEffect1069ui_story = var_204_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_20 = 0.2

			if var_204_19 <= arg_201_1.time_ and arg_201_1.time_ < var_204_19 + var_204_20 and not isNil(var_204_18) then
				local var_204_21 = (arg_201_1.time_ - var_204_19) / var_204_20

				if arg_201_1.var_.characterEffect1069ui_story and not isNil(var_204_18) then
					arg_201_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_19 + var_204_20 and arg_201_1.time_ < var_204_19 + var_204_20 + arg_204_0 and not isNil(var_204_18) and arg_201_1.var_.characterEffect1069ui_story then
				arg_201_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_204_22 = arg_201_1.actors_["1075ui_story"]
			local var_204_23 = 0

			if var_204_23 < arg_201_1.time_ and arg_201_1.time_ <= var_204_23 + arg_204_0 and not isNil(var_204_22) and arg_201_1.var_.characterEffect1075ui_story == nil then
				arg_201_1.var_.characterEffect1075ui_story = var_204_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_24 = 0.2

			if var_204_23 <= arg_201_1.time_ and arg_201_1.time_ < var_204_23 + var_204_24 and not isNil(var_204_22) then
				local var_204_25 = (arg_201_1.time_ - var_204_23) / var_204_24

				if arg_201_1.var_.characterEffect1075ui_story and not isNil(var_204_22) then
					local var_204_26 = Mathf.Lerp(0, 0.5, var_204_25)

					arg_201_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1075ui_story.fillRatio = var_204_26
				end
			end

			if arg_201_1.time_ >= var_204_23 + var_204_24 and arg_201_1.time_ < var_204_23 + var_204_24 + arg_204_0 and not isNil(var_204_22) and arg_201_1.var_.characterEffect1075ui_story then
				local var_204_27 = 0.5

				arg_201_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1075ui_story.fillRatio = var_204_27
			end

			local var_204_28 = 0

			if var_204_28 < arg_201_1.time_ and arg_201_1.time_ <= var_204_28 + arg_204_0 then
				arg_201_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action4_1")
			end

			local var_204_29 = 0

			if var_204_29 < arg_201_1.time_ and arg_201_1.time_ <= var_204_29 + arg_204_0 then
				arg_201_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_204_30 = 0
			local var_204_31 = 0.15

			if var_204_30 < arg_201_1.time_ and arg_201_1.time_ <= var_204_30 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_32 = arg_201_1:FormatText(StoryNameCfg[378].name)

				arg_201_1.leftNameTxt_.text = var_204_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_33 = arg_201_1:GetWordFromCfg(120021048)
				local var_204_34 = arg_201_1:FormatText(var_204_33.content)

				arg_201_1.text_.text = var_204_34

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_35 = 6
				local var_204_36 = utf8.len(var_204_34)
				local var_204_37 = var_204_35 <= 0 and var_204_31 or var_204_31 * (var_204_36 / var_204_35)

				if var_204_37 > 0 and var_204_31 < var_204_37 then
					arg_201_1.talkMaxDuration = var_204_37

					if var_204_37 + var_204_30 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_37 + var_204_30
					end
				end

				arg_201_1.text_.text = var_204_34
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021048", "story_v_out_120021.awb") ~= 0 then
					local var_204_38 = manager.audio:GetVoiceLength("story_v_out_120021", "120021048", "story_v_out_120021.awb") / 1000

					if var_204_38 + var_204_30 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_38 + var_204_30
					end

					if var_204_33.prefab_name ~= "" and arg_201_1.actors_[var_204_33.prefab_name] ~= nil then
						local var_204_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_33.prefab_name].transform, "story_v_out_120021", "120021048", "story_v_out_120021.awb")

						arg_201_1:RecordAudio("120021048", var_204_39)
						arg_201_1:RecordAudio("120021048", var_204_39)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_120021", "120021048", "story_v_out_120021.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_120021", "120021048", "story_v_out_120021.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_40 = math.max(var_204_31, arg_201_1.talkMaxDuration)

			if var_204_30 <= arg_201_1.time_ and arg_201_1.time_ < var_204_30 + var_204_40 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_30) / var_204_40

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_30 + var_204_40 and arg_201_1.time_ < var_204_30 + var_204_40 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
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
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play120021049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 120021049
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play120021050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1075ui_story"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos1075ui_story = var_208_0.localPosition
			end

			local var_208_2 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2
				local var_208_4 = Vector3.New(0, 100, 0)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1075ui_story, var_208_4, var_208_3)

				local var_208_5 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_5.x, var_208_5.y, var_208_5.z)

				local var_208_6 = var_208_0.localEulerAngles

				var_208_6.z = 0
				var_208_6.x = 0
				var_208_0.localEulerAngles = var_208_6
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(0, 100, 0)

				local var_208_7 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_7.x, var_208_7.y, var_208_7.z)

				local var_208_8 = var_208_0.localEulerAngles

				var_208_8.z = 0
				var_208_8.x = 0
				var_208_0.localEulerAngles = var_208_8
			end

			local var_208_9 = arg_205_1.actors_["1069ui_story"].transform
			local var_208_10 = 0

			if var_208_10 < arg_205_1.time_ and arg_205_1.time_ <= var_208_10 + arg_208_0 then
				arg_205_1.var_.moveOldPos1069ui_story = var_208_9.localPosition
			end

			local var_208_11 = 0.001

			if var_208_10 <= arg_205_1.time_ and arg_205_1.time_ < var_208_10 + var_208_11 then
				local var_208_12 = (arg_205_1.time_ - var_208_10) / var_208_11
				local var_208_13 = Vector3.New(0, 100, 0)

				var_208_9.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1069ui_story, var_208_13, var_208_12)

				local var_208_14 = manager.ui.mainCamera.transform.position - var_208_9.position

				var_208_9.forward = Vector3.New(var_208_14.x, var_208_14.y, var_208_14.z)

				local var_208_15 = var_208_9.localEulerAngles

				var_208_15.z = 0
				var_208_15.x = 0
				var_208_9.localEulerAngles = var_208_15
			end

			if arg_205_1.time_ >= var_208_10 + var_208_11 and arg_205_1.time_ < var_208_10 + var_208_11 + arg_208_0 then
				var_208_9.localPosition = Vector3.New(0, 100, 0)

				local var_208_16 = manager.ui.mainCamera.transform.position - var_208_9.position

				var_208_9.forward = Vector3.New(var_208_16.x, var_208_16.y, var_208_16.z)

				local var_208_17 = var_208_9.localEulerAngles

				var_208_17.z = 0
				var_208_17.x = 0
				var_208_9.localEulerAngles = var_208_17
			end

			local var_208_18 = 0
			local var_208_19 = 0.7

			if var_208_18 < arg_205_1.time_ and arg_205_1.time_ <= var_208_18 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_20 = arg_205_1:GetWordFromCfg(120021049)
				local var_208_21 = arg_205_1:FormatText(var_208_20.content)

				arg_205_1.text_.text = var_208_21

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_22 = 28
				local var_208_23 = utf8.len(var_208_21)
				local var_208_24 = var_208_22 <= 0 and var_208_19 or var_208_19 * (var_208_23 / var_208_22)

				if var_208_24 > 0 and var_208_19 < var_208_24 then
					arg_205_1.talkMaxDuration = var_208_24

					if var_208_24 + var_208_18 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_24 + var_208_18
					end
				end

				arg_205_1.text_.text = var_208_21
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_25 = math.max(var_208_19, arg_205_1.talkMaxDuration)

			if var_208_18 <= arg_205_1.time_ and arg_205_1.time_ < var_208_18 + var_208_25 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_18) / var_208_25

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_18 + var_208_25 and arg_205_1.time_ < var_208_18 + var_208_25 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
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

		arg_205_1:InitPlayNodeList()
	end,
	Play120021050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 120021050
		arg_209_1.duration_ = 5.47

		local var_209_0 = {
			zh = 5.466,
			ja = 3.666
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play120021051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 0.625

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_2 = arg_209_1:FormatText(StoryNameCfg[378].name)

				arg_209_1.leftNameTxt_.text = var_212_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1069")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_3 = arg_209_1:GetWordFromCfg(120021050)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 25
				local var_212_6 = utf8.len(var_212_4)
				local var_212_7 = var_212_5 <= 0 and var_212_1 or var_212_1 * (var_212_6 / var_212_5)

				if var_212_7 > 0 and var_212_1 < var_212_7 then
					arg_209_1.talkMaxDuration = var_212_7

					if var_212_7 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_0
					end
				end

				arg_209_1.text_.text = var_212_4
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021050", "story_v_out_120021.awb") ~= 0 then
					local var_212_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021050", "story_v_out_120021.awb") / 1000

					if var_212_8 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_0
					end

					if var_212_3.prefab_name ~= "" and arg_209_1.actors_[var_212_3.prefab_name] ~= nil then
						local var_212_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_3.prefab_name].transform, "story_v_out_120021", "120021050", "story_v_out_120021.awb")

						arg_209_1:RecordAudio("120021050", var_212_9)
						arg_209_1:RecordAudio("120021050", var_212_9)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_120021", "120021050", "story_v_out_120021.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_120021", "120021050", "story_v_out_120021.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_10 = math.max(var_212_1, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_10 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_0) / var_212_10

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_10 and arg_209_1.time_ < var_212_0 + var_212_10 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play120021051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 120021051
		arg_213_1.duration_ = 2.87

		local var_213_0 = {
			zh = 1.933,
			ja = 2.866
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play120021052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.25

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[378].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1069")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:GetWordFromCfg(120021051)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 10
				local var_216_6 = utf8.len(var_216_4)
				local var_216_7 = var_216_5 <= 0 and var_216_1 or var_216_1 * (var_216_6 / var_216_5)

				if var_216_7 > 0 and var_216_1 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021051", "story_v_out_120021.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021051", "story_v_out_120021.awb") / 1000

					if var_216_8 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_0
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_out_120021", "120021051", "story_v_out_120021.awb")

						arg_213_1:RecordAudio("120021051", var_216_9)
						arg_213_1:RecordAudio("120021051", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_120021", "120021051", "story_v_out_120021.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_120021", "120021051", "story_v_out_120021.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_10 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_10 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_10

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_10 and arg_213_1.time_ < var_216_0 + var_216_10 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play120021052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 120021052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play120021053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.425

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

				local var_220_2 = arg_217_1:GetWordFromCfg(120021052)
				local var_220_3 = arg_217_1:FormatText(var_220_2.content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 17
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
	Play120021053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 120021053
		arg_221_1.duration_ = 7.27

		local var_221_0 = {
			zh = 5.066,
			ja = 7.266
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
				arg_221_0:Play120021054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_224_2 = arg_221_1.actors_["1075ui_story"]
			local var_224_3 = 0

			if var_224_3 < arg_221_1.time_ and arg_221_1.time_ <= var_224_3 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.characterEffect1075ui_story == nil then
				arg_221_1.var_.characterEffect1075ui_story = var_224_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_4 = 0.2

			if var_224_3 <= arg_221_1.time_ and arg_221_1.time_ < var_224_3 + var_224_4 and not isNil(var_224_2) then
				local var_224_5 = (arg_221_1.time_ - var_224_3) / var_224_4

				if arg_221_1.var_.characterEffect1075ui_story and not isNil(var_224_2) then
					arg_221_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_3 + var_224_4 and arg_221_1.time_ < var_224_3 + var_224_4 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.characterEffect1075ui_story then
				arg_221_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_224_6 = arg_221_1.actors_["1075ui_story"].transform
			local var_224_7 = 0

			if var_224_7 < arg_221_1.time_ and arg_221_1.time_ <= var_224_7 + arg_224_0 then
				arg_221_1.var_.moveOldPos1075ui_story = var_224_6.localPosition
			end

			local var_224_8 = 0.001

			if var_224_7 <= arg_221_1.time_ and arg_221_1.time_ < var_224_7 + var_224_8 then
				local var_224_9 = (arg_221_1.time_ - var_224_7) / var_224_8
				local var_224_10 = Vector3.New(0, -1.055, -6.16)

				var_224_6.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1075ui_story, var_224_10, var_224_9)

				local var_224_11 = manager.ui.mainCamera.transform.position - var_224_6.position

				var_224_6.forward = Vector3.New(var_224_11.x, var_224_11.y, var_224_11.z)

				local var_224_12 = var_224_6.localEulerAngles

				var_224_12.z = 0
				var_224_12.x = 0
				var_224_6.localEulerAngles = var_224_12
			end

			if arg_221_1.time_ >= var_224_7 + var_224_8 and arg_221_1.time_ < var_224_7 + var_224_8 + arg_224_0 then
				var_224_6.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_224_13 = manager.ui.mainCamera.transform.position - var_224_6.position

				var_224_6.forward = Vector3.New(var_224_13.x, var_224_13.y, var_224_13.z)

				local var_224_14 = var_224_6.localEulerAngles

				var_224_14.z = 0
				var_224_14.x = 0
				var_224_6.localEulerAngles = var_224_14
			end

			local var_224_15 = 0
			local var_224_16 = 0.5

			if var_224_15 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_17 = arg_221_1:FormatText(StoryNameCfg[381].name)

				arg_221_1.leftNameTxt_.text = var_224_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_18 = arg_221_1:GetWordFromCfg(120021053)
				local var_224_19 = arg_221_1:FormatText(var_224_18.content)

				arg_221_1.text_.text = var_224_19

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_20 = 20
				local var_224_21 = utf8.len(var_224_19)
				local var_224_22 = var_224_20 <= 0 and var_224_16 or var_224_16 * (var_224_21 / var_224_20)

				if var_224_22 > 0 and var_224_16 < var_224_22 then
					arg_221_1.talkMaxDuration = var_224_22

					if var_224_22 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_22 + var_224_15
					end
				end

				arg_221_1.text_.text = var_224_19
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021053", "story_v_out_120021.awb") ~= 0 then
					local var_224_23 = manager.audio:GetVoiceLength("story_v_out_120021", "120021053", "story_v_out_120021.awb") / 1000

					if var_224_23 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_23 + var_224_15
					end

					if var_224_18.prefab_name ~= "" and arg_221_1.actors_[var_224_18.prefab_name] ~= nil then
						local var_224_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_18.prefab_name].transform, "story_v_out_120021", "120021053", "story_v_out_120021.awb")

						arg_221_1:RecordAudio("120021053", var_224_24)
						arg_221_1:RecordAudio("120021053", var_224_24)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_120021", "120021053", "story_v_out_120021.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_120021", "120021053", "story_v_out_120021.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_25 = math.max(var_224_16, arg_221_1.talkMaxDuration)

			if var_224_15 <= arg_221_1.time_ and arg_221_1.time_ < var_224_15 + var_224_25 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_15) / var_224_25

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_15 + var_224_25 and arg_221_1.time_ < var_224_15 + var_224_25 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
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

		arg_221_1:InitPlayNodeList()
	end,
	Play120021054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 120021054
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play120021055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1075ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1075ui_story == nil then
				arg_225_1.var_.characterEffect1075ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.2

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect1075ui_story and not isNil(var_228_0) then
					local var_228_4 = Mathf.Lerp(0, 0.5, var_228_3)

					arg_225_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1075ui_story.fillRatio = var_228_4
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1075ui_story then
				local var_228_5 = 0.5

				arg_225_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1075ui_story.fillRatio = var_228_5
			end

			local var_228_6 = 0
			local var_228_7 = 0.15

			if var_228_6 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_8 = arg_225_1:FormatText(StoryNameCfg[7].name)

				arg_225_1.leftNameTxt_.text = var_228_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_9 = arg_225_1:GetWordFromCfg(120021054)
				local var_228_10 = arg_225_1:FormatText(var_228_9.content)

				arg_225_1.text_.text = var_228_10

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_11 = 6
				local var_228_12 = utf8.len(var_228_10)
				local var_228_13 = var_228_11 <= 0 and var_228_7 or var_228_7 * (var_228_12 / var_228_11)

				if var_228_13 > 0 and var_228_7 < var_228_13 then
					arg_225_1.talkMaxDuration = var_228_13

					if var_228_13 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_13 + var_228_6
					end
				end

				arg_225_1.text_.text = var_228_10
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_14 = math.max(var_228_7, arg_225_1.talkMaxDuration)

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_14 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_6) / var_228_14

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_6 + var_228_14 and arg_225_1.time_ < var_228_6 + var_228_14 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play120021055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 120021055
		arg_229_1.duration_ = 4.13

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play120021056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1075ui_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1075ui_story == nil then
				arg_229_1.var_.characterEffect1075ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.2

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect1075ui_story and not isNil(var_232_0) then
					arg_229_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1075ui_story then
				arg_229_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_232_4 = 0

			if var_232_4 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_232_5 = 0

			if var_232_5 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 then
				arg_229_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_232_6 = "XH0108"

			if arg_229_1.bgs_[var_232_6] == nil then
				local var_232_7 = Object.Instantiate(arg_229_1.paintGo_)

				var_232_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_232_6)
				var_232_7.name = var_232_6
				var_232_7.transform.parent = arg_229_1.stage_.transform
				var_232_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_229_1.bgs_[var_232_6] = var_232_7
			end

			local var_232_8 = 0

			if var_232_8 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 then
				local var_232_9 = manager.ui.mainCamera.transform.localPosition
				local var_232_10 = Vector3.New(0, 0, 10) + Vector3.New(var_232_9.x, var_232_9.y, 0)
				local var_232_11 = arg_229_1.bgs_.XH0108

				var_232_11.transform.localPosition = var_232_10
				var_232_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_232_12 = var_232_11:GetComponent("SpriteRenderer")

				if var_232_12 and var_232_12.sprite then
					local var_232_13 = (var_232_11.transform.localPosition - var_232_9).z
					local var_232_14 = manager.ui.mainCameraCom_
					local var_232_15 = 2 * var_232_13 * Mathf.Tan(var_232_14.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_232_16 = var_232_15 * var_232_14.aspect
					local var_232_17 = var_232_12.sprite.bounds.size.x
					local var_232_18 = var_232_12.sprite.bounds.size.y
					local var_232_19 = var_232_16 / var_232_17
					local var_232_20 = var_232_15 / var_232_18
					local var_232_21 = var_232_20 < var_232_19 and var_232_19 or var_232_20

					var_232_11.transform.localScale = Vector3.New(var_232_21, var_232_21, 0)
				end

				for iter_232_0, iter_232_1 in pairs(arg_229_1.bgs_) do
					if iter_232_0 ~= "XH0108" then
						iter_232_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_232_22 = 0

			if var_232_22 < arg_229_1.time_ and arg_229_1.time_ <= var_232_22 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_23 = 2

			if var_232_22 <= arg_229_1.time_ and arg_229_1.time_ < var_232_22 + var_232_23 then
				local var_232_24 = (arg_229_1.time_ - var_232_22) / var_232_23
				local var_232_25 = Color.New(1, 1, 1)

				var_232_25.a = Mathf.Lerp(1, 0, var_232_24)
				arg_229_1.mask_.color = var_232_25
			end

			if arg_229_1.time_ >= var_232_22 + var_232_23 and arg_229_1.time_ < var_232_22 + var_232_23 + arg_232_0 then
				local var_232_26 = Color.New(1, 1, 1)
				local var_232_27 = 0

				arg_229_1.mask_.enabled = false
				var_232_26.a = var_232_27
				arg_229_1.mask_.color = var_232_26
			end

			local var_232_28 = arg_229_1.actors_["1075ui_story"].transform
			local var_232_29 = 0

			if var_232_29 < arg_229_1.time_ and arg_229_1.time_ <= var_232_29 + arg_232_0 then
				arg_229_1.var_.moveOldPos1075ui_story = var_232_28.localPosition
			end

			local var_232_30 = 0.001

			if var_232_29 <= arg_229_1.time_ and arg_229_1.time_ < var_232_29 + var_232_30 then
				local var_232_31 = (arg_229_1.time_ - var_232_29) / var_232_30
				local var_232_32 = Vector3.New(0, 100, 0)

				var_232_28.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1075ui_story, var_232_32, var_232_31)

				local var_232_33 = manager.ui.mainCamera.transform.position - var_232_28.position

				var_232_28.forward = Vector3.New(var_232_33.x, var_232_33.y, var_232_33.z)

				local var_232_34 = var_232_28.localEulerAngles

				var_232_34.z = 0
				var_232_34.x = 0
				var_232_28.localEulerAngles = var_232_34
			end

			if arg_229_1.time_ >= var_232_29 + var_232_30 and arg_229_1.time_ < var_232_29 + var_232_30 + arg_232_0 then
				var_232_28.localPosition = Vector3.New(0, 100, 0)

				local var_232_35 = manager.ui.mainCamera.transform.position - var_232_28.position

				var_232_28.forward = Vector3.New(var_232_35.x, var_232_35.y, var_232_35.z)

				local var_232_36 = var_232_28.localEulerAngles

				var_232_36.z = 0
				var_232_36.x = 0
				var_232_28.localEulerAngles = var_232_36
			end

			local var_232_37 = arg_229_1.bgs_.XH0108.transform
			local var_232_38 = 0

			if var_232_38 < arg_229_1.time_ and arg_229_1.time_ <= var_232_38 + arg_232_0 then
				arg_229_1.var_.moveOldPosXH0108 = var_232_37.localPosition
			end

			local var_232_39 = 0.001

			if var_232_38 <= arg_229_1.time_ and arg_229_1.time_ < var_232_38 + var_232_39 then
				local var_232_40 = (arg_229_1.time_ - var_232_38) / var_232_39
				local var_232_41 = Vector3.New(0, 1, 0)

				var_232_37.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPosXH0108, var_232_41, var_232_40)
			end

			if arg_229_1.time_ >= var_232_38 + var_232_39 and arg_229_1.time_ < var_232_38 + var_232_39 + arg_232_0 then
				var_232_37.localPosition = Vector3.New(0, 1, 0)
			end

			local var_232_42 = arg_229_1.bgs_.XH0108.transform
			local var_232_43 = 0.0166666666666666

			if var_232_43 < arg_229_1.time_ and arg_229_1.time_ <= var_232_43 + arg_232_0 then
				arg_229_1.var_.moveOldPosXH0108 = var_232_42.localPosition
			end

			local var_232_44 = 3.5

			if var_232_43 <= arg_229_1.time_ and arg_229_1.time_ < var_232_43 + var_232_44 then
				local var_232_45 = (arg_229_1.time_ - var_232_43) / var_232_44
				local var_232_46 = Vector3.New(0, 0.5, 0)

				var_232_42.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPosXH0108, var_232_46, var_232_45)
			end

			if arg_229_1.time_ >= var_232_43 + var_232_44 and arg_229_1.time_ < var_232_43 + var_232_44 + arg_232_0 then
				var_232_42.localPosition = Vector3.New(0, 0.5, 0)
			end

			local var_232_47 = 2

			if var_232_47 < arg_229_1.time_ and arg_229_1.time_ <= var_232_47 + arg_232_0 then
				arg_229_1.allBtn_.enabled = false
			end

			local var_232_48 = 1.51666666666667

			if arg_229_1.time_ >= var_232_47 + var_232_48 and arg_229_1.time_ < var_232_47 + var_232_48 + arg_232_0 then
				arg_229_1.allBtn_.enabled = true
			end

			if arg_229_1.frameCnt_ <= 1 then
				arg_229_1.dialog_:SetActive(false)
			end

			local var_232_49 = 2
			local var_232_50 = 0.1

			if var_232_49 < arg_229_1.time_ and arg_229_1.time_ <= var_232_49 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				arg_229_1.dialog_:SetActive(true)

				arg_229_1.dialogCg_.alpha = 0

				local var_232_51 = LeanTween.value(arg_229_1.dialog_, 0, 1, 0.3)

				var_232_51:setOnUpdate(LuaHelper.FloatAction(function(arg_233_0)
					arg_229_1.dialogCg_.alpha = arg_233_0
				end))
				var_232_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_229_1.dialog_)
					var_232_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_229_1.duration_ = arg_229_1.duration_ + 0.3

				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_52 = arg_229_1:FormatText(StoryNameCfg[381].name)

				arg_229_1.leftNameTxt_.text = var_232_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_53 = arg_229_1:GetWordFromCfg(120021055)
				local var_232_54 = arg_229_1:FormatText(var_232_53.content)

				arg_229_1.text_.text = var_232_54

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_55 = 4
				local var_232_56 = utf8.len(var_232_54)
				local var_232_57 = var_232_55 <= 0 and var_232_50 or var_232_50 * (var_232_56 / var_232_55)

				if var_232_57 > 0 and var_232_50 < var_232_57 then
					arg_229_1.talkMaxDuration = var_232_57
					var_232_49 = var_232_49 + 0.3

					if var_232_57 + var_232_49 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_57 + var_232_49
					end
				end

				arg_229_1.text_.text = var_232_54
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021055", "story_v_out_120021.awb") ~= 0 then
					local var_232_58 = manager.audio:GetVoiceLength("story_v_out_120021", "120021055", "story_v_out_120021.awb") / 1000

					if var_232_58 + var_232_49 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_58 + var_232_49
					end

					if var_232_53.prefab_name ~= "" and arg_229_1.actors_[var_232_53.prefab_name] ~= nil then
						local var_232_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_53.prefab_name].transform, "story_v_out_120021", "120021055", "story_v_out_120021.awb")

						arg_229_1:RecordAudio("120021055", var_232_59)
						arg_229_1:RecordAudio("120021055", var_232_59)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_120021", "120021055", "story_v_out_120021.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_120021", "120021055", "story_v_out_120021.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_60 = var_232_49 + 0.3
			local var_232_61 = math.max(var_232_50, arg_229_1.talkMaxDuration)

			if var_232_60 <= arg_229_1.time_ and arg_229_1.time_ < var_232_60 + var_232_61 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_60) / var_232_61

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_60 + var_232_61 and arg_229_1.time_ < var_232_60 + var_232_61 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
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
				actorName = "XH0108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 0.0166666666666666,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play120021056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 120021056
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play120021057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0
			local var_238_1 = 1.6

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_2 = arg_235_1:GetWordFromCfg(120021056)
				local var_238_3 = arg_235_1:FormatText(var_238_2.content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 64
				local var_238_5 = utf8.len(var_238_3)
				local var_238_6 = var_238_4 <= 0 and var_238_1 or var_238_1 * (var_238_5 / var_238_4)

				if var_238_6 > 0 and var_238_1 < var_238_6 then
					arg_235_1.talkMaxDuration = var_238_6

					if var_238_6 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_6 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_7 and arg_235_1.time_ < var_238_0 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play120021057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 120021057
		arg_239_1.duration_ = 1.57

		local var_239_0 = {
			zh = 0.999999999999,
			ja = 1.566
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play120021058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 0.075

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_2 = arg_239_1:FormatText(StoryNameCfg[381].name)

				arg_239_1.leftNameTxt_.text = var_242_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_3 = arg_239_1:GetWordFromCfg(120021057)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 3
				local var_242_6 = utf8.len(var_242_4)
				local var_242_7 = var_242_5 <= 0 and var_242_1 or var_242_1 * (var_242_6 / var_242_5)

				if var_242_7 > 0 and var_242_1 < var_242_7 then
					arg_239_1.talkMaxDuration = var_242_7

					if var_242_7 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_4
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021057", "story_v_out_120021.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021057", "story_v_out_120021.awb") / 1000

					if var_242_8 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_0
					end

					if var_242_3.prefab_name ~= "" and arg_239_1.actors_[var_242_3.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_3.prefab_name].transform, "story_v_out_120021", "120021057", "story_v_out_120021.awb")

						arg_239_1:RecordAudio("120021057", var_242_9)
						arg_239_1:RecordAudio("120021057", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_120021", "120021057", "story_v_out_120021.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_120021", "120021057", "story_v_out_120021.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_10 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_10 and arg_239_1.time_ < var_242_0 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play120021058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 120021058
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play120021059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 0.975

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_2 = arg_243_1:GetWordFromCfg(120021058)
				local var_246_3 = arg_243_1:FormatText(var_246_2.content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 39
				local var_246_5 = utf8.len(var_246_3)
				local var_246_6 = var_246_4 <= 0 and var_246_1 or var_246_1 * (var_246_5 / var_246_4)

				if var_246_6 > 0 and var_246_1 < var_246_6 then
					arg_243_1.talkMaxDuration = var_246_6

					if var_246_6 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_6 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_7 and arg_243_1.time_ < var_246_0 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play120021059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 120021059
		arg_247_1.duration_ = 14.33

		local var_247_0 = {
			zh = 12.6,
			ja = 14.333
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play120021060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 2

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				local var_250_1 = manager.ui.mainCamera.transform.localPosition
				local var_250_2 = Vector3.New(0, 0, 10) + Vector3.New(var_250_1.x, var_250_1.y, 0)
				local var_250_3 = arg_247_1.bgs_.XH0108

				var_250_3.transform.localPosition = var_250_2
				var_250_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_250_4 = var_250_3:GetComponent("SpriteRenderer")

				if var_250_4 and var_250_4.sprite then
					local var_250_5 = (var_250_3.transform.localPosition - var_250_1).z
					local var_250_6 = manager.ui.mainCameraCom_
					local var_250_7 = 2 * var_250_5 * Mathf.Tan(var_250_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_250_8 = var_250_7 * var_250_6.aspect
					local var_250_9 = var_250_4.sprite.bounds.size.x
					local var_250_10 = var_250_4.sprite.bounds.size.y
					local var_250_11 = var_250_8 / var_250_9
					local var_250_12 = var_250_7 / var_250_10
					local var_250_13 = var_250_12 < var_250_11 and var_250_11 or var_250_12

					var_250_3.transform.localScale = Vector3.New(var_250_13, var_250_13, 0)
				end

				for iter_250_0, iter_250_1 in pairs(arg_247_1.bgs_) do
					if iter_250_0 ~= "XH0108" then
						iter_250_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_250_14 = 0

			if var_250_14 < arg_247_1.time_ and arg_247_1.time_ <= var_250_14 + arg_250_0 then
				arg_247_1.mask_.enabled = true
				arg_247_1.mask_.raycastTarget = true

				arg_247_1:SetGaussion(false)
			end

			local var_250_15 = 2

			if var_250_14 <= arg_247_1.time_ and arg_247_1.time_ < var_250_14 + var_250_15 then
				local var_250_16 = (arg_247_1.time_ - var_250_14) / var_250_15
				local var_250_17 = Color.New(0, 0, 0)

				var_250_17.a = Mathf.Lerp(0, 1, var_250_16)
				arg_247_1.mask_.color = var_250_17
			end

			if arg_247_1.time_ >= var_250_14 + var_250_15 and arg_247_1.time_ < var_250_14 + var_250_15 + arg_250_0 then
				local var_250_18 = Color.New(0, 0, 0)

				var_250_18.a = 1
				arg_247_1.mask_.color = var_250_18
			end

			local var_250_19 = 2

			if var_250_19 < arg_247_1.time_ and arg_247_1.time_ <= var_250_19 + arg_250_0 then
				arg_247_1.mask_.enabled = true
				arg_247_1.mask_.raycastTarget = true

				arg_247_1:SetGaussion(false)
			end

			local var_250_20 = 2

			if var_250_19 <= arg_247_1.time_ and arg_247_1.time_ < var_250_19 + var_250_20 then
				local var_250_21 = (arg_247_1.time_ - var_250_19) / var_250_20
				local var_250_22 = Color.New(0, 0, 0)

				var_250_22.a = Mathf.Lerp(1, 0, var_250_21)
				arg_247_1.mask_.color = var_250_22
			end

			if arg_247_1.time_ >= var_250_19 + var_250_20 and arg_247_1.time_ < var_250_19 + var_250_20 + arg_250_0 then
				local var_250_23 = Color.New(0, 0, 0)
				local var_250_24 = 0

				arg_247_1.mask_.enabled = false
				var_250_23.a = var_250_24
				arg_247_1.mask_.color = var_250_23
			end

			if arg_247_1.frameCnt_ <= 1 then
				arg_247_1.dialog_:SetActive(false)
			end

			local var_250_25 = 4
			local var_250_26 = 1

			if var_250_25 < arg_247_1.time_ and arg_247_1.time_ <= var_250_25 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0

				arg_247_1.dialog_:SetActive(true)

				arg_247_1.dialogCg_.alpha = 0

				local var_250_27 = LeanTween.value(arg_247_1.dialog_, 0, 1, 0.3)

				var_250_27:setOnUpdate(LuaHelper.FloatAction(function(arg_251_0)
					arg_247_1.dialogCg_.alpha = arg_251_0
				end))
				var_250_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_247_1.dialog_)
					var_250_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_247_1.duration_ = arg_247_1.duration_ + 0.3

				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_28 = arg_247_1:FormatText(StoryNameCfg[381].name)

				arg_247_1.leftNameTxt_.text = var_250_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_29 = arg_247_1:GetWordFromCfg(120021059)
				local var_250_30 = arg_247_1:FormatText(var_250_29.content)

				arg_247_1.text_.text = var_250_30

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_31 = 40
				local var_250_32 = utf8.len(var_250_30)
				local var_250_33 = var_250_31 <= 0 and var_250_26 or var_250_26 * (var_250_32 / var_250_31)

				if var_250_33 > 0 and var_250_26 < var_250_33 then
					arg_247_1.talkMaxDuration = var_250_33
					var_250_25 = var_250_25 + 0.3

					if var_250_33 + var_250_25 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_33 + var_250_25
					end
				end

				arg_247_1.text_.text = var_250_30
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021059", "story_v_out_120021.awb") ~= 0 then
					local var_250_34 = manager.audio:GetVoiceLength("story_v_out_120021", "120021059", "story_v_out_120021.awb") / 1000

					if var_250_34 + var_250_25 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_34 + var_250_25
					end

					if var_250_29.prefab_name ~= "" and arg_247_1.actors_[var_250_29.prefab_name] ~= nil then
						local var_250_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_29.prefab_name].transform, "story_v_out_120021", "120021059", "story_v_out_120021.awb")

						arg_247_1:RecordAudio("120021059", var_250_35)
						arg_247_1:RecordAudio("120021059", var_250_35)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_120021", "120021059", "story_v_out_120021.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_120021", "120021059", "story_v_out_120021.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_36 = var_250_25 + 0.3
			local var_250_37 = math.max(var_250_26, arg_247_1.talkMaxDuration)

			if var_250_36 <= arg_247_1.time_ and arg_247_1.time_ < var_250_36 + var_250_37 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_36) / var_250_37

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_36 + var_250_37 and arg_247_1.time_ < var_250_36 + var_250_37 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play120021060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 120021060
		arg_253_1.duration_ = 3.07

		local var_253_0 = {
			zh = 2.133,
			ja = 3.066
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
				arg_253_0:Play120021061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 0.25

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_2 = arg_253_1:FormatText(StoryNameCfg[6].name)

				arg_253_1.leftNameTxt_.text = var_256_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_3 = arg_253_1:GetWordFromCfg(120021060)
				local var_256_4 = arg_253_1:FormatText(var_256_3.content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 10
				local var_256_6 = utf8.len(var_256_4)
				local var_256_7 = var_256_5 <= 0 and var_256_1 or var_256_1 * (var_256_6 / var_256_5)

				if var_256_7 > 0 and var_256_1 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_4
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021060", "story_v_out_120021.awb") ~= 0 then
					local var_256_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021060", "story_v_out_120021.awb") / 1000

					if var_256_8 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_8 + var_256_0
					end

					if var_256_3.prefab_name ~= "" and arg_253_1.actors_[var_256_3.prefab_name] ~= nil then
						local var_256_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_3.prefab_name].transform, "story_v_out_120021", "120021060", "story_v_out_120021.awb")

						arg_253_1:RecordAudio("120021060", var_256_9)
						arg_253_1:RecordAudio("120021060", var_256_9)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_120021", "120021060", "story_v_out_120021.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_120021", "120021060", "story_v_out_120021.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_10 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_10 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_10

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_10 and arg_253_1.time_ < var_256_0 + var_256_10 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play120021061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 120021061
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play120021062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.1

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[7].name)

				arg_257_1.leftNameTxt_.text = var_260_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_3 = arg_257_1:GetWordFromCfg(120021061)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 4
				local var_260_6 = utf8.len(var_260_4)
				local var_260_7 = var_260_5 <= 0 and var_260_1 or var_260_1 * (var_260_6 / var_260_5)

				if var_260_7 > 0 and var_260_1 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_8 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_8 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_8

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_8 and arg_257_1.time_ < var_260_0 + var_260_8 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play120021062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 120021062
		arg_261_1.duration_ = 5.37

		local var_261_0 = {
			zh = 4.366,
			ja = 5.366
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
				arg_261_0:Play120021063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.325

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_2 = arg_261_1:FormatText(StoryNameCfg[381].name)

				arg_261_1.leftNameTxt_.text = var_264_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_3 = arg_261_1:GetWordFromCfg(120021062)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 13
				local var_264_6 = utf8.len(var_264_4)
				local var_264_7 = var_264_5 <= 0 and var_264_1 or var_264_1 * (var_264_6 / var_264_5)

				if var_264_7 > 0 and var_264_1 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_4
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021062", "story_v_out_120021.awb") ~= 0 then
					local var_264_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021062", "story_v_out_120021.awb") / 1000

					if var_264_8 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_8 + var_264_0
					end

					if var_264_3.prefab_name ~= "" and arg_261_1.actors_[var_264_3.prefab_name] ~= nil then
						local var_264_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_3.prefab_name].transform, "story_v_out_120021", "120021062", "story_v_out_120021.awb")

						arg_261_1:RecordAudio("120021062", var_264_9)
						arg_261_1:RecordAudio("120021062", var_264_9)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_120021", "120021062", "story_v_out_120021.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_120021", "120021062", "story_v_out_120021.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_10 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_10 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_10

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_10 and arg_261_1.time_ < var_264_0 + var_264_10 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play120021063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 120021063
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play120021064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.625

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[7].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_3 = arg_265_1:GetWordFromCfg(120021063)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 25
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
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_8 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_8 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_8

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_8 and arg_265_1.time_ < var_268_0 + var_268_8 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play120021064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 120021064
		arg_269_1.duration_ = 4.07

		local var_269_0 = {
			zh = 4.066,
			ja = 2.833
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
				arg_269_0:Play120021065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0
			local var_272_1 = 0.325

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_2 = arg_269_1:FormatText(StoryNameCfg[381].name)

				arg_269_1.leftNameTxt_.text = var_272_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_3 = arg_269_1:GetWordFromCfg(120021064)
				local var_272_4 = arg_269_1:FormatText(var_272_3.content)

				arg_269_1.text_.text = var_272_4

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 13
				local var_272_6 = utf8.len(var_272_4)
				local var_272_7 = var_272_5 <= 0 and var_272_1 or var_272_1 * (var_272_6 / var_272_5)

				if var_272_7 > 0 and var_272_1 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_4
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021064", "story_v_out_120021.awb") ~= 0 then
					local var_272_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021064", "story_v_out_120021.awb") / 1000

					if var_272_8 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_0
					end

					if var_272_3.prefab_name ~= "" and arg_269_1.actors_[var_272_3.prefab_name] ~= nil then
						local var_272_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_3.prefab_name].transform, "story_v_out_120021", "120021064", "story_v_out_120021.awb")

						arg_269_1:RecordAudio("120021064", var_272_9)
						arg_269_1:RecordAudio("120021064", var_272_9)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_120021", "120021064", "story_v_out_120021.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_120021", "120021064", "story_v_out_120021.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_10 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_10 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_10

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_10 and arg_269_1.time_ < var_272_0 + var_272_10 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play120021065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 120021065
		arg_273_1.duration_ = 9

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play120021066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 2

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				local var_276_1 = manager.ui.mainCamera.transform.localPosition
				local var_276_2 = Vector3.New(0, 0, 10) + Vector3.New(var_276_1.x, var_276_1.y, 0)
				local var_276_3 = arg_273_1.bgs_.ST29

				var_276_3.transform.localPosition = var_276_2
				var_276_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_276_4 = var_276_3:GetComponent("SpriteRenderer")

				if var_276_4 and var_276_4.sprite then
					local var_276_5 = (var_276_3.transform.localPosition - var_276_1).z
					local var_276_6 = manager.ui.mainCameraCom_
					local var_276_7 = 2 * var_276_5 * Mathf.Tan(var_276_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_276_8 = var_276_7 * var_276_6.aspect
					local var_276_9 = var_276_4.sprite.bounds.size.x
					local var_276_10 = var_276_4.sprite.bounds.size.y
					local var_276_11 = var_276_8 / var_276_9
					local var_276_12 = var_276_7 / var_276_10
					local var_276_13 = var_276_12 < var_276_11 and var_276_11 or var_276_12

					var_276_3.transform.localScale = Vector3.New(var_276_13, var_276_13, 0)
				end

				for iter_276_0, iter_276_1 in pairs(arg_273_1.bgs_) do
					if iter_276_0 ~= "ST29" then
						iter_276_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_276_14 = 0

			if var_276_14 < arg_273_1.time_ and arg_273_1.time_ <= var_276_14 + arg_276_0 then
				arg_273_1.mask_.enabled = true
				arg_273_1.mask_.raycastTarget = true

				arg_273_1:SetGaussion(false)
			end

			local var_276_15 = 2

			if var_276_14 <= arg_273_1.time_ and arg_273_1.time_ < var_276_14 + var_276_15 then
				local var_276_16 = (arg_273_1.time_ - var_276_14) / var_276_15
				local var_276_17 = Color.New(1, 1, 1)

				var_276_17.a = Mathf.Lerp(0, 1, var_276_16)
				arg_273_1.mask_.color = var_276_17
			end

			if arg_273_1.time_ >= var_276_14 + var_276_15 and arg_273_1.time_ < var_276_14 + var_276_15 + arg_276_0 then
				local var_276_18 = Color.New(1, 1, 1)

				var_276_18.a = 1
				arg_273_1.mask_.color = var_276_18
			end

			local var_276_19 = 2

			if var_276_19 < arg_273_1.time_ and arg_273_1.time_ <= var_276_19 + arg_276_0 then
				arg_273_1.mask_.enabled = true
				arg_273_1.mask_.raycastTarget = true

				arg_273_1:SetGaussion(false)
			end

			local var_276_20 = 2

			if var_276_19 <= arg_273_1.time_ and arg_273_1.time_ < var_276_19 + var_276_20 then
				local var_276_21 = (arg_273_1.time_ - var_276_19) / var_276_20
				local var_276_22 = Color.New(1, 1, 1)

				var_276_22.a = Mathf.Lerp(1, 0, var_276_21)
				arg_273_1.mask_.color = var_276_22
			end

			if arg_273_1.time_ >= var_276_19 + var_276_20 and arg_273_1.time_ < var_276_19 + var_276_20 + arg_276_0 then
				local var_276_23 = Color.New(1, 1, 1)
				local var_276_24 = 0

				arg_273_1.mask_.enabled = false
				var_276_23.a = var_276_24
				arg_273_1.mask_.color = var_276_23
			end

			if arg_273_1.frameCnt_ <= 1 then
				arg_273_1.dialog_:SetActive(false)
			end

			local var_276_25 = 4
			local var_276_26 = 0.85

			if var_276_25 < arg_273_1.time_ and arg_273_1.time_ <= var_276_25 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0

				arg_273_1.dialog_:SetActive(true)

				arg_273_1.dialogCg_.alpha = 0

				local var_276_27 = LeanTween.value(arg_273_1.dialog_, 0, 1, 0.3)

				var_276_27:setOnUpdate(LuaHelper.FloatAction(function(arg_277_0)
					arg_273_1.dialogCg_.alpha = arg_277_0
				end))
				var_276_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_273_1.dialog_)
					var_276_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_273_1.duration_ = arg_273_1.duration_ + 0.3

				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_28 = arg_273_1:GetWordFromCfg(120021065)
				local var_276_29 = arg_273_1:FormatText(var_276_28.content)

				arg_273_1.text_.text = var_276_29

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_30 = 34
				local var_276_31 = utf8.len(var_276_29)
				local var_276_32 = var_276_30 <= 0 and var_276_26 or var_276_26 * (var_276_31 / var_276_30)

				if var_276_32 > 0 and var_276_26 < var_276_32 then
					arg_273_1.talkMaxDuration = var_276_32
					var_276_25 = var_276_25 + 0.3

					if var_276_32 + var_276_25 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_32 + var_276_25
					end
				end

				arg_273_1.text_.text = var_276_29
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_33 = var_276_25 + 0.3
			local var_276_34 = math.max(var_276_26, arg_273_1.talkMaxDuration)

			if var_276_33 <= arg_273_1.time_ and arg_273_1.time_ < var_276_33 + var_276_34 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_33) / var_276_34

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_33 + var_276_34 and arg_273_1.time_ < var_276_33 + var_276_34 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play120021066 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 120021066
		arg_279_1.duration_ = 6.57

		local var_279_0 = {
			zh = 4.866,
			ja = 6.566
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play120021067(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1072ui_story"].transform
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.var_.moveOldPos1072ui_story = var_282_0.localPosition
			end

			local var_282_2 = 0.001

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2
				local var_282_4 = Vector3.New(0, -0.71, -6)

				var_282_0.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1072ui_story, var_282_4, var_282_3)

				local var_282_5 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_5.x, var_282_5.y, var_282_5.z)

				local var_282_6 = var_282_0.localEulerAngles

				var_282_6.z = 0
				var_282_6.x = 0
				var_282_0.localEulerAngles = var_282_6
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 then
				var_282_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_282_7 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_7.x, var_282_7.y, var_282_7.z)

				local var_282_8 = var_282_0.localEulerAngles

				var_282_8.z = 0
				var_282_8.x = 0
				var_282_0.localEulerAngles = var_282_8
			end

			local var_282_9 = arg_279_1.actors_["1072ui_story"]
			local var_282_10 = 0

			if var_282_10 < arg_279_1.time_ and arg_279_1.time_ <= var_282_10 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect1072ui_story == nil then
				arg_279_1.var_.characterEffect1072ui_story = var_282_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_11 = 0.2

			if var_282_10 <= arg_279_1.time_ and arg_279_1.time_ < var_282_10 + var_282_11 and not isNil(var_282_9) then
				local var_282_12 = (arg_279_1.time_ - var_282_10) / var_282_11

				if arg_279_1.var_.characterEffect1072ui_story and not isNil(var_282_9) then
					arg_279_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= var_282_10 + var_282_11 and arg_279_1.time_ < var_282_10 + var_282_11 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect1072ui_story then
				arg_279_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_282_13 = 0

			if var_282_13 < arg_279_1.time_ and arg_279_1.time_ <= var_282_13 + arg_282_0 then
				arg_279_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_282_14 = 0

			if var_282_14 < arg_279_1.time_ and arg_279_1.time_ <= var_282_14 + arg_282_0 then
				arg_279_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_1")
			end

			local var_282_15 = 0
			local var_282_16 = 0.65

			if var_282_15 < arg_279_1.time_ and arg_279_1.time_ <= var_282_15 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_17 = arg_279_1:FormatText(StoryNameCfg[379].name)

				arg_279_1.leftNameTxt_.text = var_282_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_18 = arg_279_1:GetWordFromCfg(120021066)
				local var_282_19 = arg_279_1:FormatText(var_282_18.content)

				arg_279_1.text_.text = var_282_19

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_20 = 26
				local var_282_21 = utf8.len(var_282_19)
				local var_282_22 = var_282_20 <= 0 and var_282_16 or var_282_16 * (var_282_21 / var_282_20)

				if var_282_22 > 0 and var_282_16 < var_282_22 then
					arg_279_1.talkMaxDuration = var_282_22

					if var_282_22 + var_282_15 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_22 + var_282_15
					end
				end

				arg_279_1.text_.text = var_282_19
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021066", "story_v_out_120021.awb") ~= 0 then
					local var_282_23 = manager.audio:GetVoiceLength("story_v_out_120021", "120021066", "story_v_out_120021.awb") / 1000

					if var_282_23 + var_282_15 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_23 + var_282_15
					end

					if var_282_18.prefab_name ~= "" and arg_279_1.actors_[var_282_18.prefab_name] ~= nil then
						local var_282_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_18.prefab_name].transform, "story_v_out_120021", "120021066", "story_v_out_120021.awb")

						arg_279_1:RecordAudio("120021066", var_282_24)
						arg_279_1:RecordAudio("120021066", var_282_24)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_120021", "120021066", "story_v_out_120021.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_120021", "120021066", "story_v_out_120021.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_25 = math.max(var_282_16, arg_279_1.talkMaxDuration)

			if var_282_15 <= arg_279_1.time_ and arg_279_1.time_ < var_282_15 + var_282_25 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_15) / var_282_25

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_15 + var_282_25 and arg_279_1.time_ < var_282_15 + var_282_25 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play120021067 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 120021067
		arg_283_1.duration_ = 8.8

		local var_283_0 = {
			zh = 5.166,
			ja = 8.8
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play120021068(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0

			if var_286_0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_0 + arg_286_0 then
				arg_283_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_2")
			end

			local var_286_1 = 0
			local var_286_2 = 0.65

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_3 = arg_283_1:FormatText(StoryNameCfg[379].name)

				arg_283_1.leftNameTxt_.text = var_286_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_4 = arg_283_1:GetWordFromCfg(120021067)
				local var_286_5 = arg_283_1:FormatText(var_286_4.content)

				arg_283_1.text_.text = var_286_5

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_6 = 26
				local var_286_7 = utf8.len(var_286_5)
				local var_286_8 = var_286_6 <= 0 and var_286_2 or var_286_2 * (var_286_7 / var_286_6)

				if var_286_8 > 0 and var_286_2 < var_286_8 then
					arg_283_1.talkMaxDuration = var_286_8

					if var_286_8 + var_286_1 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_8 + var_286_1
					end
				end

				arg_283_1.text_.text = var_286_5
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021067", "story_v_out_120021.awb") ~= 0 then
					local var_286_9 = manager.audio:GetVoiceLength("story_v_out_120021", "120021067", "story_v_out_120021.awb") / 1000

					if var_286_9 + var_286_1 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_9 + var_286_1
					end

					if var_286_4.prefab_name ~= "" and arg_283_1.actors_[var_286_4.prefab_name] ~= nil then
						local var_286_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_4.prefab_name].transform, "story_v_out_120021", "120021067", "story_v_out_120021.awb")

						arg_283_1:RecordAudio("120021067", var_286_10)
						arg_283_1:RecordAudio("120021067", var_286_10)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_120021", "120021067", "story_v_out_120021.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_120021", "120021067", "story_v_out_120021.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_11 = math.max(var_286_2, arg_283_1.talkMaxDuration)

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_11 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_1) / var_286_11

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_1 + var_286_11 and arg_283_1.time_ < var_286_1 + var_286_11 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play120021068 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 120021068
		arg_287_1.duration_ = 1.13

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play120021069(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1072ui_story"].transform
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.var_.moveOldPos1072ui_story = var_290_0.localPosition
			end

			local var_290_2 = 0.001

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2
				local var_290_4 = Vector3.New(0, 100, 0)

				var_290_0.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1072ui_story, var_290_4, var_290_3)

				local var_290_5 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_5.x, var_290_5.y, var_290_5.z)

				local var_290_6 = var_290_0.localEulerAngles

				var_290_6.z = 0
				var_290_6.x = 0
				var_290_0.localEulerAngles = var_290_6
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 then
				var_290_0.localPosition = Vector3.New(0, 100, 0)

				local var_290_7 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_7.x, var_290_7.y, var_290_7.z)

				local var_290_8 = var_290_0.localEulerAngles

				var_290_8.z = 0
				var_290_8.x = 0
				var_290_0.localEulerAngles = var_290_8
			end

			local var_290_9 = 0
			local var_290_10 = 0.075

			if var_290_9 < arg_287_1.time_ and arg_287_1.time_ <= var_290_9 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_11 = arg_287_1:FormatText(StoryNameCfg[380].name)

				arg_287_1.leftNameTxt_.text = var_290_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10044")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_12 = arg_287_1:GetWordFromCfg(120021068)
				local var_290_13 = arg_287_1:FormatText(var_290_12.content)

				arg_287_1.text_.text = var_290_13

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_14 = 3
				local var_290_15 = utf8.len(var_290_13)
				local var_290_16 = var_290_14 <= 0 and var_290_10 or var_290_10 * (var_290_15 / var_290_14)

				if var_290_16 > 0 and var_290_10 < var_290_16 then
					arg_287_1.talkMaxDuration = var_290_16

					if var_290_16 + var_290_9 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_16 + var_290_9
					end
				end

				arg_287_1.text_.text = var_290_13
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021068", "story_v_out_120021.awb") ~= 0 then
					local var_290_17 = manager.audio:GetVoiceLength("story_v_out_120021", "120021068", "story_v_out_120021.awb") / 1000

					if var_290_17 + var_290_9 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_17 + var_290_9
					end

					if var_290_12.prefab_name ~= "" and arg_287_1.actors_[var_290_12.prefab_name] ~= nil then
						local var_290_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_12.prefab_name].transform, "story_v_out_120021", "120021068", "story_v_out_120021.awb")

						arg_287_1:RecordAudio("120021068", var_290_18)
						arg_287_1:RecordAudio("120021068", var_290_18)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_120021", "120021068", "story_v_out_120021.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_120021", "120021068", "story_v_out_120021.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_19 = math.max(var_290_10, arg_287_1.talkMaxDuration)

			if var_290_9 <= arg_287_1.time_ and arg_287_1.time_ < var_290_9 + var_290_19 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_9) / var_290_19

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_9 + var_290_19 and arg_287_1.time_ < var_290_9 + var_290_19 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play120021069 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 120021069
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play120021070(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0
			local var_294_1 = 1.225

			if var_294_0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_2 = arg_291_1:GetWordFromCfg(120021069)
				local var_294_3 = arg_291_1:FormatText(var_294_2.content)

				arg_291_1.text_.text = var_294_3

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_4 = 49
				local var_294_5 = utf8.len(var_294_3)
				local var_294_6 = var_294_4 <= 0 and var_294_1 or var_294_1 * (var_294_5 / var_294_4)

				if var_294_6 > 0 and var_294_1 < var_294_6 then
					arg_291_1.talkMaxDuration = var_294_6

					if var_294_6 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_6 + var_294_0
					end
				end

				arg_291_1.text_.text = var_294_3
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_7 = math.max(var_294_1, arg_291_1.talkMaxDuration)

			if var_294_0 <= arg_291_1.time_ and arg_291_1.time_ < var_294_0 + var_294_7 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_0) / var_294_7

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_0 + var_294_7 and arg_291_1.time_ < var_294_0 + var_294_7 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play120021070 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 120021070
		arg_295_1.duration_ = 2.67

		local var_295_0 = {
			zh = 2.433333333332,
			ja = 2.666
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play120021071(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = "10037ui_story"

			if arg_295_1.actors_[var_298_0] == nil then
				local var_298_1 = Asset.Load("Char/" .. "10037ui_story")

				if not isNil(var_298_1) then
					local var_298_2 = Object.Instantiate(Asset.Load("Char/" .. "10037ui_story"), arg_295_1.stage_.transform)

					var_298_2.name = var_298_0
					var_298_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_295_1.actors_[var_298_0] = var_298_2

					local var_298_3 = var_298_2:GetComponentInChildren(typeof(CharacterEffect))

					var_298_3.enabled = true

					local var_298_4 = GameObjectTools.GetOrAddComponent(var_298_2, typeof(DynamicBoneHelper))

					if var_298_4 then
						var_298_4:EnableDynamicBone(false)
					end

					arg_295_1:ShowWeapon(var_298_3.transform, false)

					arg_295_1.var_[var_298_0 .. "Animator"] = var_298_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_295_1.var_[var_298_0 .. "Animator"].applyRootMotion = true
					arg_295_1.var_[var_298_0 .. "LipSync"] = var_298_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_298_5 = arg_295_1.actors_["10037ui_story"]
			local var_298_6 = 0

			if var_298_6 < arg_295_1.time_ and arg_295_1.time_ <= var_298_6 + arg_298_0 and not isNil(var_298_5) and arg_295_1.var_.characterEffect10037ui_story == nil then
				arg_295_1.var_.characterEffect10037ui_story = var_298_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_7 = 0.2

			if var_298_6 <= arg_295_1.time_ and arg_295_1.time_ < var_298_6 + var_298_7 and not isNil(var_298_5) then
				local var_298_8 = (arg_295_1.time_ - var_298_6) / var_298_7

				if arg_295_1.var_.characterEffect10037ui_story and not isNil(var_298_5) then
					arg_295_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= var_298_6 + var_298_7 and arg_295_1.time_ < var_298_6 + var_298_7 + arg_298_0 and not isNil(var_298_5) and arg_295_1.var_.characterEffect10037ui_story then
				arg_295_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_298_9 = 0

			if var_298_9 < arg_295_1.time_ and arg_295_1.time_ <= var_298_9 + arg_298_0 then
				arg_295_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			local var_298_10 = 0

			if var_298_10 < arg_295_1.time_ and arg_295_1.time_ <= var_298_10 + arg_298_0 then
				arg_295_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_298_11 = arg_295_1.actors_["10037ui_story"].transform
			local var_298_12 = 0

			if var_298_12 < arg_295_1.time_ and arg_295_1.time_ <= var_298_12 + arg_298_0 then
				arg_295_1.var_.moveOldPos10037ui_story = var_298_11.localPosition
			end

			local var_298_13 = 0.001

			if var_298_12 <= arg_295_1.time_ and arg_295_1.time_ < var_298_12 + var_298_13 then
				local var_298_14 = (arg_295_1.time_ - var_298_12) / var_298_13
				local var_298_15 = Vector3.New(0.7, -1.13, -6.2)

				var_298_11.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10037ui_story, var_298_15, var_298_14)

				local var_298_16 = manager.ui.mainCamera.transform.position - var_298_11.position

				var_298_11.forward = Vector3.New(var_298_16.x, var_298_16.y, var_298_16.z)

				local var_298_17 = var_298_11.localEulerAngles

				var_298_17.z = 0
				var_298_17.x = 0
				var_298_11.localEulerAngles = var_298_17
			end

			if arg_295_1.time_ >= var_298_12 + var_298_13 and arg_295_1.time_ < var_298_12 + var_298_13 + arg_298_0 then
				var_298_11.localPosition = Vector3.New(0.7, -1.13, -6.2)

				local var_298_18 = manager.ui.mainCamera.transform.position - var_298_11.position

				var_298_11.forward = Vector3.New(var_298_18.x, var_298_18.y, var_298_18.z)

				local var_298_19 = var_298_11.localEulerAngles

				var_298_19.z = 0
				var_298_19.x = 0
				var_298_11.localEulerAngles = var_298_19
			end

			local var_298_20 = arg_295_1.actors_["10044ui_story"].transform
			local var_298_21 = 0

			if var_298_21 < arg_295_1.time_ and arg_295_1.time_ <= var_298_21 + arg_298_0 then
				arg_295_1.var_.moveOldPos10044ui_story = var_298_20.localPosition
			end

			local var_298_22 = 0.001

			if var_298_21 <= arg_295_1.time_ and arg_295_1.time_ < var_298_21 + var_298_22 then
				local var_298_23 = (arg_295_1.time_ - var_298_21) / var_298_22
				local var_298_24 = Vector3.New(-0.7, -0.72, -6.3)

				var_298_20.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10044ui_story, var_298_24, var_298_23)

				local var_298_25 = manager.ui.mainCamera.transform.position - var_298_20.position

				var_298_20.forward = Vector3.New(var_298_25.x, var_298_25.y, var_298_25.z)

				local var_298_26 = var_298_20.localEulerAngles

				var_298_26.z = 0
				var_298_26.x = 0
				var_298_20.localEulerAngles = var_298_26
			end

			if arg_295_1.time_ >= var_298_21 + var_298_22 and arg_295_1.time_ < var_298_21 + var_298_22 + arg_298_0 then
				var_298_20.localPosition = Vector3.New(-0.7, -0.72, -6.3)

				local var_298_27 = manager.ui.mainCamera.transform.position - var_298_20.position

				var_298_20.forward = Vector3.New(var_298_27.x, var_298_27.y, var_298_27.z)

				local var_298_28 = var_298_20.localEulerAngles

				var_298_28.z = 0
				var_298_28.x = 0
				var_298_20.localEulerAngles = var_298_28
			end

			local var_298_29 = 0

			if var_298_29 < arg_295_1.time_ and arg_295_1.time_ <= var_298_29 + arg_298_0 then
				arg_295_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_298_30 = arg_295_1.actors_["10044ui_story"]
			local var_298_31 = 0

			if var_298_31 < arg_295_1.time_ and arg_295_1.time_ <= var_298_31 + arg_298_0 and not isNil(var_298_30) and arg_295_1.var_.characterEffect10044ui_story == nil then
				arg_295_1.var_.characterEffect10044ui_story = var_298_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_32 = 0.0166666666666667

			if var_298_31 <= arg_295_1.time_ and arg_295_1.time_ < var_298_31 + var_298_32 and not isNil(var_298_30) then
				local var_298_33 = (arg_295_1.time_ - var_298_31) / var_298_32

				if arg_295_1.var_.characterEffect10044ui_story and not isNil(var_298_30) then
					local var_298_34 = Mathf.Lerp(0, 0.5, var_298_33)

					arg_295_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_295_1.var_.characterEffect10044ui_story.fillRatio = var_298_34
				end
			end

			if arg_295_1.time_ >= var_298_31 + var_298_32 and arg_295_1.time_ < var_298_31 + var_298_32 + arg_298_0 and not isNil(var_298_30) and arg_295_1.var_.characterEffect10044ui_story then
				local var_298_35 = 0.5

				arg_295_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_295_1.var_.characterEffect10044ui_story.fillRatio = var_298_35
			end

			local var_298_36 = 0
			local var_298_37 = 0.25

			if var_298_36 < arg_295_1.time_ and arg_295_1.time_ <= var_298_36 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_38 = arg_295_1:FormatText(StoryNameCfg[36].name)

				arg_295_1.leftNameTxt_.text = var_298_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_39 = arg_295_1:GetWordFromCfg(120021070)
				local var_298_40 = arg_295_1:FormatText(var_298_39.content)

				arg_295_1.text_.text = var_298_40

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_41 = 10
				local var_298_42 = utf8.len(var_298_40)
				local var_298_43 = var_298_41 <= 0 and var_298_37 or var_298_37 * (var_298_42 / var_298_41)

				if var_298_43 > 0 and var_298_37 < var_298_43 then
					arg_295_1.talkMaxDuration = var_298_43

					if var_298_43 + var_298_36 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_43 + var_298_36
					end
				end

				arg_295_1.text_.text = var_298_40
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021070", "story_v_out_120021.awb") ~= 0 then
					local var_298_44 = manager.audio:GetVoiceLength("story_v_out_120021", "120021070", "story_v_out_120021.awb") / 1000

					if var_298_44 + var_298_36 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_44 + var_298_36
					end

					if var_298_39.prefab_name ~= "" and arg_295_1.actors_[var_298_39.prefab_name] ~= nil then
						local var_298_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_39.prefab_name].transform, "story_v_out_120021", "120021070", "story_v_out_120021.awb")

						arg_295_1:RecordAudio("120021070", var_298_45)
						arg_295_1:RecordAudio("120021070", var_298_45)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_120021", "120021070", "story_v_out_120021.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_120021", "120021070", "story_v_out_120021.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_46 = math.max(var_298_37, arg_295_1.talkMaxDuration)

			if var_298_36 <= arg_295_1.time_ and arg_295_1.time_ < var_298_36 + var_298_46 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_36) / var_298_46

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_36 + var_298_46 and arg_295_1.time_ < var_298_36 + var_298_46 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
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
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play120021071 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 120021071
		arg_299_1.duration_ = 4.3

		local var_299_0 = {
			zh = 3.066,
			ja = 4.3
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play120021072(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0

			if var_302_0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_0 + arg_302_0 then
				arg_299_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action4_1")
			end

			local var_302_2 = 0
			local var_302_3 = 0.325

			if var_302_2 < arg_299_1.time_ and arg_299_1.time_ <= var_302_2 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_4 = arg_299_1:FormatText(StoryNameCfg[36].name)

				arg_299_1.leftNameTxt_.text = var_302_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_5 = arg_299_1:GetWordFromCfg(120021071)
				local var_302_6 = arg_299_1:FormatText(var_302_5.content)

				arg_299_1.text_.text = var_302_6

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_7 = 13
				local var_302_8 = utf8.len(var_302_6)
				local var_302_9 = var_302_7 <= 0 and var_302_3 or var_302_3 * (var_302_8 / var_302_7)

				if var_302_9 > 0 and var_302_3 < var_302_9 then
					arg_299_1.talkMaxDuration = var_302_9

					if var_302_9 + var_302_2 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_9 + var_302_2
					end
				end

				arg_299_1.text_.text = var_302_6
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021071", "story_v_out_120021.awb") ~= 0 then
					local var_302_10 = manager.audio:GetVoiceLength("story_v_out_120021", "120021071", "story_v_out_120021.awb") / 1000

					if var_302_10 + var_302_2 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_10 + var_302_2
					end

					if var_302_5.prefab_name ~= "" and arg_299_1.actors_[var_302_5.prefab_name] ~= nil then
						local var_302_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_5.prefab_name].transform, "story_v_out_120021", "120021071", "story_v_out_120021.awb")

						arg_299_1:RecordAudio("120021071", var_302_11)
						arg_299_1:RecordAudio("120021071", var_302_11)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_120021", "120021071", "story_v_out_120021.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_120021", "120021071", "story_v_out_120021.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_12 = math.max(var_302_3, arg_299_1.talkMaxDuration)

			if var_302_2 <= arg_299_1.time_ and arg_299_1.time_ < var_302_2 + var_302_12 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_2) / var_302_12

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_2 + var_302_12 and arg_299_1.time_ < var_302_2 + var_302_12 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play120021072 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 120021072
		arg_303_1.duration_ = 7.47

		local var_303_0 = {
			zh = 4.633,
			ja = 7.466
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play120021073(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["10044ui_story"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect10044ui_story == nil then
				arg_303_1.var_.characterEffect10044ui_story = var_306_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.2

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.characterEffect10044ui_story and not isNil(var_306_0) then
					arg_303_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect10044ui_story then
				arg_303_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_306_4 = arg_303_1.actors_["10037ui_story"]
			local var_306_5 = 0

			if var_306_5 < arg_303_1.time_ and arg_303_1.time_ <= var_306_5 + arg_306_0 and not isNil(var_306_4) and arg_303_1.var_.characterEffect10037ui_story == nil then
				arg_303_1.var_.characterEffect10037ui_story = var_306_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_6 = 0.2

			if var_306_5 <= arg_303_1.time_ and arg_303_1.time_ < var_306_5 + var_306_6 and not isNil(var_306_4) then
				local var_306_7 = (arg_303_1.time_ - var_306_5) / var_306_6

				if arg_303_1.var_.characterEffect10037ui_story and not isNil(var_306_4) then
					local var_306_8 = Mathf.Lerp(0, 0.5, var_306_7)

					arg_303_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_303_1.var_.characterEffect10037ui_story.fillRatio = var_306_8
				end
			end

			if arg_303_1.time_ >= var_306_5 + var_306_6 and arg_303_1.time_ < var_306_5 + var_306_6 + arg_306_0 and not isNil(var_306_4) and arg_303_1.var_.characterEffect10037ui_story then
				local var_306_9 = 0.5

				arg_303_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_303_1.var_.characterEffect10037ui_story.fillRatio = var_306_9
			end

			local var_306_10 = arg_303_1.actors_["10037ui_story"].transform
			local var_306_11 = 0

			if var_306_11 < arg_303_1.time_ and arg_303_1.time_ <= var_306_11 + arg_306_0 then
				arg_303_1.var_.moveOldPos10037ui_story = var_306_10.localPosition
			end

			local var_306_12 = 0.001

			if var_306_11 <= arg_303_1.time_ and arg_303_1.time_ < var_306_11 + var_306_12 then
				local var_306_13 = (arg_303_1.time_ - var_306_11) / var_306_12
				local var_306_14 = Vector3.New(0.7, -1.13, -6.2)

				var_306_10.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos10037ui_story, var_306_14, var_306_13)

				local var_306_15 = manager.ui.mainCamera.transform.position - var_306_10.position

				var_306_10.forward = Vector3.New(var_306_15.x, var_306_15.y, var_306_15.z)

				local var_306_16 = var_306_10.localEulerAngles

				var_306_16.z = 0
				var_306_16.x = 0
				var_306_10.localEulerAngles = var_306_16
			end

			if arg_303_1.time_ >= var_306_11 + var_306_12 and arg_303_1.time_ < var_306_11 + var_306_12 + arg_306_0 then
				var_306_10.localPosition = Vector3.New(0.7, -1.13, -6.2)

				local var_306_17 = manager.ui.mainCamera.transform.position - var_306_10.position

				var_306_10.forward = Vector3.New(var_306_17.x, var_306_17.y, var_306_17.z)

				local var_306_18 = var_306_10.localEulerAngles

				var_306_18.z = 0
				var_306_18.x = 0
				var_306_10.localEulerAngles = var_306_18
			end

			local var_306_19 = arg_303_1.actors_["10044ui_story"].transform
			local var_306_20 = 0

			if var_306_20 < arg_303_1.time_ and arg_303_1.time_ <= var_306_20 + arg_306_0 then
				arg_303_1.var_.moveOldPos10044ui_story = var_306_19.localPosition
			end

			local var_306_21 = 0.001

			if var_306_20 <= arg_303_1.time_ and arg_303_1.time_ < var_306_20 + var_306_21 then
				local var_306_22 = (arg_303_1.time_ - var_306_20) / var_306_21
				local var_306_23 = Vector3.New(-0.7, -0.72, -6.3)

				var_306_19.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos10044ui_story, var_306_23, var_306_22)

				local var_306_24 = manager.ui.mainCamera.transform.position - var_306_19.position

				var_306_19.forward = Vector3.New(var_306_24.x, var_306_24.y, var_306_24.z)

				local var_306_25 = var_306_19.localEulerAngles

				var_306_25.z = 0
				var_306_25.x = 0
				var_306_19.localEulerAngles = var_306_25
			end

			if arg_303_1.time_ >= var_306_20 + var_306_21 and arg_303_1.time_ < var_306_20 + var_306_21 + arg_306_0 then
				var_306_19.localPosition = Vector3.New(-0.7, -0.72, -6.3)

				local var_306_26 = manager.ui.mainCamera.transform.position - var_306_19.position

				var_306_19.forward = Vector3.New(var_306_26.x, var_306_26.y, var_306_26.z)

				local var_306_27 = var_306_19.localEulerAngles

				var_306_27.z = 0
				var_306_27.x = 0
				var_306_19.localEulerAngles = var_306_27
			end

			local var_306_28 = 0

			if var_306_28 < arg_303_1.time_ and arg_303_1.time_ <= var_306_28 + arg_306_0 then
				arg_303_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action4_1")
			end

			local var_306_29 = 0

			if var_306_29 < arg_303_1.time_ and arg_303_1.time_ <= var_306_29 + arg_306_0 then
				arg_303_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_306_30 = 0
			local var_306_31 = 0.375

			if var_306_30 < arg_303_1.time_ and arg_303_1.time_ <= var_306_30 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_32 = arg_303_1:FormatText(StoryNameCfg[380].name)

				arg_303_1.leftNameTxt_.text = var_306_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_33 = arg_303_1:GetWordFromCfg(120021072)
				local var_306_34 = arg_303_1:FormatText(var_306_33.content)

				arg_303_1.text_.text = var_306_34

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_35 = 15
				local var_306_36 = utf8.len(var_306_34)
				local var_306_37 = var_306_35 <= 0 and var_306_31 or var_306_31 * (var_306_36 / var_306_35)

				if var_306_37 > 0 and var_306_31 < var_306_37 then
					arg_303_1.talkMaxDuration = var_306_37

					if var_306_37 + var_306_30 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_37 + var_306_30
					end
				end

				arg_303_1.text_.text = var_306_34
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021072", "story_v_out_120021.awb") ~= 0 then
					local var_306_38 = manager.audio:GetVoiceLength("story_v_out_120021", "120021072", "story_v_out_120021.awb") / 1000

					if var_306_38 + var_306_30 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_38 + var_306_30
					end

					if var_306_33.prefab_name ~= "" and arg_303_1.actors_[var_306_33.prefab_name] ~= nil then
						local var_306_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_33.prefab_name].transform, "story_v_out_120021", "120021072", "story_v_out_120021.awb")

						arg_303_1:RecordAudio("120021072", var_306_39)
						arg_303_1:RecordAudio("120021072", var_306_39)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_120021", "120021072", "story_v_out_120021.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_120021", "120021072", "story_v_out_120021.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_40 = math.max(var_306_31, arg_303_1.talkMaxDuration)

			if var_306_30 <= arg_303_1.time_ and arg_303_1.time_ < var_306_30 + var_306_40 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_30) / var_306_40

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_30 + var_306_40 and arg_303_1.time_ < var_306_30 + var_306_40 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
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
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play120021073 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 120021073
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play120021074(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["10037ui_story"].transform
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.var_.moveOldPos10037ui_story = var_310_0.localPosition
			end

			local var_310_2 = 0.001

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2
				local var_310_4 = Vector3.New(0, 100, 0)

				var_310_0.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos10037ui_story, var_310_4, var_310_3)

				local var_310_5 = manager.ui.mainCamera.transform.position - var_310_0.position

				var_310_0.forward = Vector3.New(var_310_5.x, var_310_5.y, var_310_5.z)

				local var_310_6 = var_310_0.localEulerAngles

				var_310_6.z = 0
				var_310_6.x = 0
				var_310_0.localEulerAngles = var_310_6
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 then
				var_310_0.localPosition = Vector3.New(0, 100, 0)

				local var_310_7 = manager.ui.mainCamera.transform.position - var_310_0.position

				var_310_0.forward = Vector3.New(var_310_7.x, var_310_7.y, var_310_7.z)

				local var_310_8 = var_310_0.localEulerAngles

				var_310_8.z = 0
				var_310_8.x = 0
				var_310_0.localEulerAngles = var_310_8
			end

			local var_310_9 = arg_307_1.actors_["10044ui_story"].transform
			local var_310_10 = 0

			if var_310_10 < arg_307_1.time_ and arg_307_1.time_ <= var_310_10 + arg_310_0 then
				arg_307_1.var_.moveOldPos10044ui_story = var_310_9.localPosition
			end

			local var_310_11 = 0.001

			if var_310_10 <= arg_307_1.time_ and arg_307_1.time_ < var_310_10 + var_310_11 then
				local var_310_12 = (arg_307_1.time_ - var_310_10) / var_310_11
				local var_310_13 = Vector3.New(0, 100, 0)

				var_310_9.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos10044ui_story, var_310_13, var_310_12)

				local var_310_14 = manager.ui.mainCamera.transform.position - var_310_9.position

				var_310_9.forward = Vector3.New(var_310_14.x, var_310_14.y, var_310_14.z)

				local var_310_15 = var_310_9.localEulerAngles

				var_310_15.z = 0
				var_310_15.x = 0
				var_310_9.localEulerAngles = var_310_15
			end

			if arg_307_1.time_ >= var_310_10 + var_310_11 and arg_307_1.time_ < var_310_10 + var_310_11 + arg_310_0 then
				var_310_9.localPosition = Vector3.New(0, 100, 0)

				local var_310_16 = manager.ui.mainCamera.transform.position - var_310_9.position

				var_310_9.forward = Vector3.New(var_310_16.x, var_310_16.y, var_310_16.z)

				local var_310_17 = var_310_9.localEulerAngles

				var_310_17.z = 0
				var_310_17.x = 0
				var_310_9.localEulerAngles = var_310_17
			end

			local var_310_18 = 0
			local var_310_19 = 1.275

			if var_310_18 < arg_307_1.time_ and arg_307_1.time_ <= var_310_18 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_20 = arg_307_1:GetWordFromCfg(120021073)
				local var_310_21 = arg_307_1:FormatText(var_310_20.content)

				arg_307_1.text_.text = var_310_21

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_22 = 51
				local var_310_23 = utf8.len(var_310_21)
				local var_310_24 = var_310_22 <= 0 and var_310_19 or var_310_19 * (var_310_23 / var_310_22)

				if var_310_24 > 0 and var_310_19 < var_310_24 then
					arg_307_1.talkMaxDuration = var_310_24

					if var_310_24 + var_310_18 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_24 + var_310_18
					end
				end

				arg_307_1.text_.text = var_310_21
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_25 = math.max(var_310_19, arg_307_1.talkMaxDuration)

			if var_310_18 <= arg_307_1.time_ and arg_307_1.time_ < var_310_18 + var_310_25 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_18) / var_310_25

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_18 + var_310_25 and arg_307_1.time_ < var_310_18 + var_310_25 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
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
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play120021074 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 120021074
		arg_311_1.duration_ = 2.27

		local var_311_0 = {
			zh = 1.999999999999,
			ja = 2.266
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play120021075(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["10037ui_story"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect10037ui_story == nil then
				arg_311_1.var_.characterEffect10037ui_story = var_314_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.2

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.characterEffect10037ui_story and not isNil(var_314_0) then
					arg_311_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect10037ui_story then
				arg_311_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_314_4 = arg_311_1.actors_["10044ui_story"].transform
			local var_314_5 = 0

			if var_314_5 < arg_311_1.time_ and arg_311_1.time_ <= var_314_5 + arg_314_0 then
				arg_311_1.var_.moveOldPos10044ui_story = var_314_4.localPosition
			end

			local var_314_6 = 0.001

			if var_314_5 <= arg_311_1.time_ and arg_311_1.time_ < var_314_5 + var_314_6 then
				local var_314_7 = (arg_311_1.time_ - var_314_5) / var_314_6
				local var_314_8 = Vector3.New(-0.7, -0.72, -6.3)

				var_314_4.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos10044ui_story, var_314_8, var_314_7)

				local var_314_9 = manager.ui.mainCamera.transform.position - var_314_4.position

				var_314_4.forward = Vector3.New(var_314_9.x, var_314_9.y, var_314_9.z)

				local var_314_10 = var_314_4.localEulerAngles

				var_314_10.z = 0
				var_314_10.x = 0
				var_314_4.localEulerAngles = var_314_10
			end

			if arg_311_1.time_ >= var_314_5 + var_314_6 and arg_311_1.time_ < var_314_5 + var_314_6 + arg_314_0 then
				var_314_4.localPosition = Vector3.New(-0.7, -0.72, -6.3)

				local var_314_11 = manager.ui.mainCamera.transform.position - var_314_4.position

				var_314_4.forward = Vector3.New(var_314_11.x, var_314_11.y, var_314_11.z)

				local var_314_12 = var_314_4.localEulerAngles

				var_314_12.z = 0
				var_314_12.x = 0
				var_314_4.localEulerAngles = var_314_12
			end

			local var_314_13 = arg_311_1.actors_["10037ui_story"].transform
			local var_314_14 = 0

			if var_314_14 < arg_311_1.time_ and arg_311_1.time_ <= var_314_14 + arg_314_0 then
				arg_311_1.var_.moveOldPos10037ui_story = var_314_13.localPosition
			end

			local var_314_15 = 0.001

			if var_314_14 <= arg_311_1.time_ and arg_311_1.time_ < var_314_14 + var_314_15 then
				local var_314_16 = (arg_311_1.time_ - var_314_14) / var_314_15
				local var_314_17 = Vector3.New(0.7, -1.13, -6.2)

				var_314_13.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos10037ui_story, var_314_17, var_314_16)

				local var_314_18 = manager.ui.mainCamera.transform.position - var_314_13.position

				var_314_13.forward = Vector3.New(var_314_18.x, var_314_18.y, var_314_18.z)

				local var_314_19 = var_314_13.localEulerAngles

				var_314_19.z = 0
				var_314_19.x = 0
				var_314_13.localEulerAngles = var_314_19
			end

			if arg_311_1.time_ >= var_314_14 + var_314_15 and arg_311_1.time_ < var_314_14 + var_314_15 + arg_314_0 then
				var_314_13.localPosition = Vector3.New(0.7, -1.13, -6.2)

				local var_314_20 = manager.ui.mainCamera.transform.position - var_314_13.position

				var_314_13.forward = Vector3.New(var_314_20.x, var_314_20.y, var_314_20.z)

				local var_314_21 = var_314_13.localEulerAngles

				var_314_21.z = 0
				var_314_21.x = 0
				var_314_13.localEulerAngles = var_314_21
			end

			local var_314_22 = 0

			if var_314_22 < arg_311_1.time_ and arg_311_1.time_ <= var_314_22 + arg_314_0 then
				arg_311_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action5_1")
			end

			local var_314_23 = 0

			if var_314_23 < arg_311_1.time_ and arg_311_1.time_ <= var_314_23 + arg_314_0 then
				arg_311_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_314_24 = 0

			if var_314_24 < arg_311_1.time_ and arg_311_1.time_ <= var_314_24 + arg_314_0 then
				arg_311_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_314_25 = arg_311_1.actors_["10044ui_story"]
			local var_314_26 = 0

			if var_314_26 < arg_311_1.time_ and arg_311_1.time_ <= var_314_26 + arg_314_0 and not isNil(var_314_25) and arg_311_1.var_.characterEffect10044ui_story == nil then
				arg_311_1.var_.characterEffect10044ui_story = var_314_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_27 = 0.0166666666666667

			if var_314_26 <= arg_311_1.time_ and arg_311_1.time_ < var_314_26 + var_314_27 and not isNil(var_314_25) then
				local var_314_28 = (arg_311_1.time_ - var_314_26) / var_314_27

				if arg_311_1.var_.characterEffect10044ui_story and not isNil(var_314_25) then
					local var_314_29 = Mathf.Lerp(0, 0.5, var_314_28)

					arg_311_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_311_1.var_.characterEffect10044ui_story.fillRatio = var_314_29
				end
			end

			if arg_311_1.time_ >= var_314_26 + var_314_27 and arg_311_1.time_ < var_314_26 + var_314_27 + arg_314_0 and not isNil(var_314_25) and arg_311_1.var_.characterEffect10044ui_story then
				local var_314_30 = 0.5

				arg_311_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_311_1.var_.characterEffect10044ui_story.fillRatio = var_314_30
			end

			local var_314_31 = 0
			local var_314_32 = 0.225

			if var_314_31 < arg_311_1.time_ and arg_311_1.time_ <= var_314_31 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_33 = arg_311_1:FormatText(StoryNameCfg[36].name)

				arg_311_1.leftNameTxt_.text = var_314_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_34 = arg_311_1:GetWordFromCfg(120021074)
				local var_314_35 = arg_311_1:FormatText(var_314_34.content)

				arg_311_1.text_.text = var_314_35

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_36 = 9
				local var_314_37 = utf8.len(var_314_35)
				local var_314_38 = var_314_36 <= 0 and var_314_32 or var_314_32 * (var_314_37 / var_314_36)

				if var_314_38 > 0 and var_314_32 < var_314_38 then
					arg_311_1.talkMaxDuration = var_314_38

					if var_314_38 + var_314_31 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_38 + var_314_31
					end
				end

				arg_311_1.text_.text = var_314_35
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021074", "story_v_out_120021.awb") ~= 0 then
					local var_314_39 = manager.audio:GetVoiceLength("story_v_out_120021", "120021074", "story_v_out_120021.awb") / 1000

					if var_314_39 + var_314_31 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_39 + var_314_31
					end

					if var_314_34.prefab_name ~= "" and arg_311_1.actors_[var_314_34.prefab_name] ~= nil then
						local var_314_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_34.prefab_name].transform, "story_v_out_120021", "120021074", "story_v_out_120021.awb")

						arg_311_1:RecordAudio("120021074", var_314_40)
						arg_311_1:RecordAudio("120021074", var_314_40)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_120021", "120021074", "story_v_out_120021.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_120021", "120021074", "story_v_out_120021.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_41 = math.max(var_314_32, arg_311_1.talkMaxDuration)

			if var_314_31 <= arg_311_1.time_ and arg_311_1.time_ < var_314_31 + var_314_41 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_31) / var_314_41

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_31 + var_314_41 and arg_311_1.time_ < var_314_31 + var_314_41 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
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
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play120021075 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 120021075
		arg_315_1.duration_ = 3.47

		local var_315_0 = {
			zh = 2.5,
			ja = 3.466
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play120021076(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["10044ui_story"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect10044ui_story == nil then
				arg_315_1.var_.characterEffect10044ui_story = var_318_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_2 = 0.2

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.characterEffect10044ui_story and not isNil(var_318_0) then
					arg_315_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect10044ui_story then
				arg_315_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_318_4 = arg_315_1.actors_["10037ui_story"]
			local var_318_5 = 0

			if var_318_5 < arg_315_1.time_ and arg_315_1.time_ <= var_318_5 + arg_318_0 and not isNil(var_318_4) and arg_315_1.var_.characterEffect10037ui_story == nil then
				arg_315_1.var_.characterEffect10037ui_story = var_318_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_6 = 0.2

			if var_318_5 <= arg_315_1.time_ and arg_315_1.time_ < var_318_5 + var_318_6 and not isNil(var_318_4) then
				local var_318_7 = (arg_315_1.time_ - var_318_5) / var_318_6

				if arg_315_1.var_.characterEffect10037ui_story and not isNil(var_318_4) then
					local var_318_8 = Mathf.Lerp(0, 0.5, var_318_7)

					arg_315_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_315_1.var_.characterEffect10037ui_story.fillRatio = var_318_8
				end
			end

			if arg_315_1.time_ >= var_318_5 + var_318_6 and arg_315_1.time_ < var_318_5 + var_318_6 + arg_318_0 and not isNil(var_318_4) and arg_315_1.var_.characterEffect10037ui_story then
				local var_318_9 = 0.5

				arg_315_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_315_1.var_.characterEffect10037ui_story.fillRatio = var_318_9
			end

			local var_318_10 = 0

			if var_318_10 < arg_315_1.time_ and arg_315_1.time_ <= var_318_10 + arg_318_0 then
				arg_315_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_318_11 = 0

			if var_318_11 < arg_315_1.time_ and arg_315_1.time_ <= var_318_11 + arg_318_0 then
				arg_315_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_318_12 = 0
			local var_318_13 = 0.3

			if var_318_12 < arg_315_1.time_ and arg_315_1.time_ <= var_318_12 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_14 = arg_315_1:FormatText(StoryNameCfg[380].name)

				arg_315_1.leftNameTxt_.text = var_318_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_15 = arg_315_1:GetWordFromCfg(120021075)
				local var_318_16 = arg_315_1:FormatText(var_318_15.content)

				arg_315_1.text_.text = var_318_16

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_17 = 12
				local var_318_18 = utf8.len(var_318_16)
				local var_318_19 = var_318_17 <= 0 and var_318_13 or var_318_13 * (var_318_18 / var_318_17)

				if var_318_19 > 0 and var_318_13 < var_318_19 then
					arg_315_1.talkMaxDuration = var_318_19

					if var_318_19 + var_318_12 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_19 + var_318_12
					end
				end

				arg_315_1.text_.text = var_318_16
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021075", "story_v_out_120021.awb") ~= 0 then
					local var_318_20 = manager.audio:GetVoiceLength("story_v_out_120021", "120021075", "story_v_out_120021.awb") / 1000

					if var_318_20 + var_318_12 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_20 + var_318_12
					end

					if var_318_15.prefab_name ~= "" and arg_315_1.actors_[var_318_15.prefab_name] ~= nil then
						local var_318_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_15.prefab_name].transform, "story_v_out_120021", "120021075", "story_v_out_120021.awb")

						arg_315_1:RecordAudio("120021075", var_318_21)
						arg_315_1:RecordAudio("120021075", var_318_21)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_120021", "120021075", "story_v_out_120021.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_120021", "120021075", "story_v_out_120021.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_22 = math.max(var_318_13, arg_315_1.talkMaxDuration)

			if var_318_12 <= arg_315_1.time_ and arg_315_1.time_ < var_318_12 + var_318_22 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_12) / var_318_22

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_12 + var_318_22 and arg_315_1.time_ < var_318_12 + var_318_22 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play120021076 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 120021076
		arg_319_1.duration_ = 3.3

		local var_319_0 = {
			zh = 1.999999999999,
			ja = 3.3
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play120021077(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["10044ui_story"].transform
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.var_.moveOldPos10044ui_story = var_322_0.localPosition
			end

			local var_322_2 = 0.001

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2
				local var_322_4 = Vector3.New(0, 100, 0)

				var_322_0.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos10044ui_story, var_322_4, var_322_3)

				local var_322_5 = manager.ui.mainCamera.transform.position - var_322_0.position

				var_322_0.forward = Vector3.New(var_322_5.x, var_322_5.y, var_322_5.z)

				local var_322_6 = var_322_0.localEulerAngles

				var_322_6.z = 0
				var_322_6.x = 0
				var_322_0.localEulerAngles = var_322_6
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 then
				var_322_0.localPosition = Vector3.New(0, 100, 0)

				local var_322_7 = manager.ui.mainCamera.transform.position - var_322_0.position

				var_322_0.forward = Vector3.New(var_322_7.x, var_322_7.y, var_322_7.z)

				local var_322_8 = var_322_0.localEulerAngles

				var_322_8.z = 0
				var_322_8.x = 0
				var_322_0.localEulerAngles = var_322_8
			end

			local var_322_9 = arg_319_1.actors_["1072ui_story"].transform
			local var_322_10 = 0

			if var_322_10 < arg_319_1.time_ and arg_319_1.time_ <= var_322_10 + arg_322_0 then
				arg_319_1.var_.moveOldPos1072ui_story = var_322_9.localPosition
			end

			local var_322_11 = 0.001

			if var_322_10 <= arg_319_1.time_ and arg_319_1.time_ < var_322_10 + var_322_11 then
				local var_322_12 = (arg_319_1.time_ - var_322_10) / var_322_11
				local var_322_13 = Vector3.New(-0.7, -0.71, -6)

				var_322_9.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1072ui_story, var_322_13, var_322_12)

				local var_322_14 = manager.ui.mainCamera.transform.position - var_322_9.position

				var_322_9.forward = Vector3.New(var_322_14.x, var_322_14.y, var_322_14.z)

				local var_322_15 = var_322_9.localEulerAngles

				var_322_15.z = 0
				var_322_15.x = 0
				var_322_9.localEulerAngles = var_322_15
			end

			if arg_319_1.time_ >= var_322_10 + var_322_11 and arg_319_1.time_ < var_322_10 + var_322_11 + arg_322_0 then
				var_322_9.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_322_16 = manager.ui.mainCamera.transform.position - var_322_9.position

				var_322_9.forward = Vector3.New(var_322_16.x, var_322_16.y, var_322_16.z)

				local var_322_17 = var_322_9.localEulerAngles

				var_322_17.z = 0
				var_322_17.x = 0
				var_322_9.localEulerAngles = var_322_17
			end

			local var_322_18 = arg_319_1.actors_["1072ui_story"]
			local var_322_19 = 0

			if var_322_19 < arg_319_1.time_ and arg_319_1.time_ <= var_322_19 + arg_322_0 and not isNil(var_322_18) and arg_319_1.var_.characterEffect1072ui_story == nil then
				arg_319_1.var_.characterEffect1072ui_story = var_322_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_20 = 0.2

			if var_322_19 <= arg_319_1.time_ and arg_319_1.time_ < var_322_19 + var_322_20 and not isNil(var_322_18) then
				local var_322_21 = (arg_319_1.time_ - var_322_19) / var_322_20

				if arg_319_1.var_.characterEffect1072ui_story and not isNil(var_322_18) then
					arg_319_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= var_322_19 + var_322_20 and arg_319_1.time_ < var_322_19 + var_322_20 + arg_322_0 and not isNil(var_322_18) and arg_319_1.var_.characterEffect1072ui_story then
				arg_319_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_322_22 = 0

			if var_322_22 < arg_319_1.time_ and arg_319_1.time_ <= var_322_22 + arg_322_0 then
				arg_319_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_322_23 = 0

			if var_322_23 < arg_319_1.time_ and arg_319_1.time_ <= var_322_23 + arg_322_0 then
				arg_319_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_322_24 = 0
			local var_322_25 = 0.15

			if var_322_24 < arg_319_1.time_ and arg_319_1.time_ <= var_322_24 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_26 = arg_319_1:FormatText(StoryNameCfg[379].name)

				arg_319_1.leftNameTxt_.text = var_322_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_27 = arg_319_1:GetWordFromCfg(120021076)
				local var_322_28 = arg_319_1:FormatText(var_322_27.content)

				arg_319_1.text_.text = var_322_28

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_29 = 6
				local var_322_30 = utf8.len(var_322_28)
				local var_322_31 = var_322_29 <= 0 and var_322_25 or var_322_25 * (var_322_30 / var_322_29)

				if var_322_31 > 0 and var_322_25 < var_322_31 then
					arg_319_1.talkMaxDuration = var_322_31

					if var_322_31 + var_322_24 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_31 + var_322_24
					end
				end

				arg_319_1.text_.text = var_322_28
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021076", "story_v_out_120021.awb") ~= 0 then
					local var_322_32 = manager.audio:GetVoiceLength("story_v_out_120021", "120021076", "story_v_out_120021.awb") / 1000

					if var_322_32 + var_322_24 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_32 + var_322_24
					end

					if var_322_27.prefab_name ~= "" and arg_319_1.actors_[var_322_27.prefab_name] ~= nil then
						local var_322_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_27.prefab_name].transform, "story_v_out_120021", "120021076", "story_v_out_120021.awb")

						arg_319_1:RecordAudio("120021076", var_322_33)
						arg_319_1:RecordAudio("120021076", var_322_33)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_120021", "120021076", "story_v_out_120021.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_120021", "120021076", "story_v_out_120021.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_34 = math.max(var_322_25, arg_319_1.talkMaxDuration)

			if var_322_24 <= arg_319_1.time_ and arg_319_1.time_ < var_322_24 + var_322_34 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_24) / var_322_34

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_24 + var_322_34 and arg_319_1.time_ < var_322_24 + var_322_34 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
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
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play120021077 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 120021077
		arg_323_1.duration_ = 8.67

		local var_323_0 = {
			zh = 8.666,
			ja = 6.733
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play120021078(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["1072ui_story"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect1072ui_story == nil then
				arg_323_1.var_.characterEffect1072ui_story = var_326_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.2

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.characterEffect1072ui_story and not isNil(var_326_0) then
					local var_326_4 = Mathf.Lerp(0, 0.5, var_326_3)

					arg_323_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1072ui_story.fillRatio = var_326_4
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect1072ui_story then
				local var_326_5 = 0.5

				arg_323_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1072ui_story.fillRatio = var_326_5
			end

			local var_326_6 = arg_323_1.actors_["10037ui_story"]
			local var_326_7 = 0

			if var_326_7 < arg_323_1.time_ and arg_323_1.time_ <= var_326_7 + arg_326_0 and not isNil(var_326_6) and arg_323_1.var_.characterEffect10037ui_story == nil then
				arg_323_1.var_.characterEffect10037ui_story = var_326_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_8 = 0.2

			if var_326_7 <= arg_323_1.time_ and arg_323_1.time_ < var_326_7 + var_326_8 and not isNil(var_326_6) then
				local var_326_9 = (arg_323_1.time_ - var_326_7) / var_326_8

				if arg_323_1.var_.characterEffect10037ui_story and not isNil(var_326_6) then
					arg_323_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= var_326_7 + var_326_8 and arg_323_1.time_ < var_326_7 + var_326_8 + arg_326_0 and not isNil(var_326_6) and arg_323_1.var_.characterEffect10037ui_story then
				arg_323_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_326_10 = 0

			if var_326_10 < arg_323_1.time_ and arg_323_1.time_ <= var_326_10 + arg_326_0 then
				arg_323_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action5_2")
			end

			local var_326_11 = 0
			local var_326_12 = 0.875

			if var_326_11 < arg_323_1.time_ and arg_323_1.time_ <= var_326_11 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_13 = arg_323_1:FormatText(StoryNameCfg[383].name)

				arg_323_1.leftNameTxt_.text = var_326_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_14 = arg_323_1:GetWordFromCfg(120021077)
				local var_326_15 = arg_323_1:FormatText(var_326_14.content)

				arg_323_1.text_.text = var_326_15

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_16 = 35
				local var_326_17 = utf8.len(var_326_15)
				local var_326_18 = var_326_16 <= 0 and var_326_12 or var_326_12 * (var_326_17 / var_326_16)

				if var_326_18 > 0 and var_326_12 < var_326_18 then
					arg_323_1.talkMaxDuration = var_326_18

					if var_326_18 + var_326_11 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_18 + var_326_11
					end
				end

				arg_323_1.text_.text = var_326_15
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021077", "story_v_out_120021.awb") ~= 0 then
					local var_326_19 = manager.audio:GetVoiceLength("story_v_out_120021", "120021077", "story_v_out_120021.awb") / 1000

					if var_326_19 + var_326_11 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_19 + var_326_11
					end

					if var_326_14.prefab_name ~= "" and arg_323_1.actors_[var_326_14.prefab_name] ~= nil then
						local var_326_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_14.prefab_name].transform, "story_v_out_120021", "120021077", "story_v_out_120021.awb")

						arg_323_1:RecordAudio("120021077", var_326_20)
						arg_323_1:RecordAudio("120021077", var_326_20)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_120021", "120021077", "story_v_out_120021.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_120021", "120021077", "story_v_out_120021.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_21 = math.max(var_326_12, arg_323_1.talkMaxDuration)

			if var_326_11 <= arg_323_1.time_ and arg_323_1.time_ < var_326_11 + var_326_21 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_11) / var_326_21

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_11 + var_326_21 and arg_323_1.time_ < var_326_11 + var_326_21 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play120021078 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 120021078
		arg_327_1.duration_ = 5.8

		local var_327_0 = {
			zh = 3.2,
			ja = 5.8
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play120021079(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0
			local var_330_1 = 0.3

			if var_330_0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_2 = arg_327_1:FormatText(StoryNameCfg[383].name)

				arg_327_1.leftNameTxt_.text = var_330_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_3 = arg_327_1:GetWordFromCfg(120021078)
				local var_330_4 = arg_327_1:FormatText(var_330_3.content)

				arg_327_1.text_.text = var_330_4

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_5 = 12
				local var_330_6 = utf8.len(var_330_4)
				local var_330_7 = var_330_5 <= 0 and var_330_1 or var_330_1 * (var_330_6 / var_330_5)

				if var_330_7 > 0 and var_330_1 < var_330_7 then
					arg_327_1.talkMaxDuration = var_330_7

					if var_330_7 + var_330_0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_7 + var_330_0
					end
				end

				arg_327_1.text_.text = var_330_4
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021078", "story_v_out_120021.awb") ~= 0 then
					local var_330_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021078", "story_v_out_120021.awb") / 1000

					if var_330_8 + var_330_0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_8 + var_330_0
					end

					if var_330_3.prefab_name ~= "" and arg_327_1.actors_[var_330_3.prefab_name] ~= nil then
						local var_330_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_3.prefab_name].transform, "story_v_out_120021", "120021078", "story_v_out_120021.awb")

						arg_327_1:RecordAudio("120021078", var_330_9)
						arg_327_1:RecordAudio("120021078", var_330_9)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_120021", "120021078", "story_v_out_120021.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_120021", "120021078", "story_v_out_120021.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_10 = math.max(var_330_1, arg_327_1.talkMaxDuration)

			if var_330_0 <= arg_327_1.time_ and arg_327_1.time_ < var_330_0 + var_330_10 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_0) / var_330_10

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_0 + var_330_10 and arg_327_1.time_ < var_330_0 + var_330_10 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play120021079 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 120021079
		arg_331_1.duration_ = 10.2

		local var_331_0 = {
			zh = 7.233,
			ja = 10.2
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play120021080(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["1072ui_story"]
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.characterEffect1072ui_story == nil then
				arg_331_1.var_.characterEffect1072ui_story = var_334_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_2 = 0.2

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 and not isNil(var_334_0) then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2

				if arg_331_1.var_.characterEffect1072ui_story and not isNil(var_334_0) then
					arg_331_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.characterEffect1072ui_story then
				arg_331_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_334_4 = arg_331_1.actors_["10037ui_story"]
			local var_334_5 = 0

			if var_334_5 < arg_331_1.time_ and arg_331_1.time_ <= var_334_5 + arg_334_0 and not isNil(var_334_4) and arg_331_1.var_.characterEffect10037ui_story == nil then
				arg_331_1.var_.characterEffect10037ui_story = var_334_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_6 = 0.2

			if var_334_5 <= arg_331_1.time_ and arg_331_1.time_ < var_334_5 + var_334_6 and not isNil(var_334_4) then
				local var_334_7 = (arg_331_1.time_ - var_334_5) / var_334_6

				if arg_331_1.var_.characterEffect10037ui_story and not isNil(var_334_4) then
					local var_334_8 = Mathf.Lerp(0, 0.5, var_334_7)

					arg_331_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_331_1.var_.characterEffect10037ui_story.fillRatio = var_334_8
				end
			end

			if arg_331_1.time_ >= var_334_5 + var_334_6 and arg_331_1.time_ < var_334_5 + var_334_6 + arg_334_0 and not isNil(var_334_4) and arg_331_1.var_.characterEffect10037ui_story then
				local var_334_9 = 0.5

				arg_331_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_331_1.var_.characterEffect10037ui_story.fillRatio = var_334_9
			end

			local var_334_10 = 0
			local var_334_11 = 0.925

			if var_334_10 < arg_331_1.time_ and arg_331_1.time_ <= var_334_10 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_12 = arg_331_1:FormatText(StoryNameCfg[379].name)

				arg_331_1.leftNameTxt_.text = var_334_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_13 = arg_331_1:GetWordFromCfg(120021079)
				local var_334_14 = arg_331_1:FormatText(var_334_13.content)

				arg_331_1.text_.text = var_334_14

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_15 = 36
				local var_334_16 = utf8.len(var_334_14)
				local var_334_17 = var_334_15 <= 0 and var_334_11 or var_334_11 * (var_334_16 / var_334_15)

				if var_334_17 > 0 and var_334_11 < var_334_17 then
					arg_331_1.talkMaxDuration = var_334_17

					if var_334_17 + var_334_10 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_17 + var_334_10
					end
				end

				arg_331_1.text_.text = var_334_14
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021079", "story_v_out_120021.awb") ~= 0 then
					local var_334_18 = manager.audio:GetVoiceLength("story_v_out_120021", "120021079", "story_v_out_120021.awb") / 1000

					if var_334_18 + var_334_10 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_18 + var_334_10
					end

					if var_334_13.prefab_name ~= "" and arg_331_1.actors_[var_334_13.prefab_name] ~= nil then
						local var_334_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_13.prefab_name].transform, "story_v_out_120021", "120021079", "story_v_out_120021.awb")

						arg_331_1:RecordAudio("120021079", var_334_19)
						arg_331_1:RecordAudio("120021079", var_334_19)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_120021", "120021079", "story_v_out_120021.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_120021", "120021079", "story_v_out_120021.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_20 = math.max(var_334_11, arg_331_1.talkMaxDuration)

			if var_334_10 <= arg_331_1.time_ and arg_331_1.time_ < var_334_10 + var_334_20 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_10) / var_334_20

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_10 + var_334_20 and arg_331_1.time_ < var_334_10 + var_334_20 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play120021080 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 120021080
		arg_335_1.duration_ = 7.07

		local var_335_0 = {
			zh = 6.033,
			ja = 7.066
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play120021081(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["1072ui_story"]
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.characterEffect1072ui_story == nil then
				arg_335_1.var_.characterEffect1072ui_story = var_338_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_2 = 0.2

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 and not isNil(var_338_0) then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2

				if arg_335_1.var_.characterEffect1072ui_story and not isNil(var_338_0) then
					local var_338_4 = Mathf.Lerp(0, 0.5, var_338_3)

					arg_335_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1072ui_story.fillRatio = var_338_4
				end
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.characterEffect1072ui_story then
				local var_338_5 = 0.5

				arg_335_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1072ui_story.fillRatio = var_338_5
			end

			local var_338_6 = arg_335_1.actors_["10037ui_story"]
			local var_338_7 = 0

			if var_338_7 < arg_335_1.time_ and arg_335_1.time_ <= var_338_7 + arg_338_0 and not isNil(var_338_6) and arg_335_1.var_.characterEffect10037ui_story == nil then
				arg_335_1.var_.characterEffect10037ui_story = var_338_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_8 = 0.2

			if var_338_7 <= arg_335_1.time_ and arg_335_1.time_ < var_338_7 + var_338_8 and not isNil(var_338_6) then
				local var_338_9 = (arg_335_1.time_ - var_338_7) / var_338_8

				if arg_335_1.var_.characterEffect10037ui_story and not isNil(var_338_6) then
					arg_335_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= var_338_7 + var_338_8 and arg_335_1.time_ < var_338_7 + var_338_8 + arg_338_0 and not isNil(var_338_6) and arg_335_1.var_.characterEffect10037ui_story then
				arg_335_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_338_10 = 0
			local var_338_11 = 0.5

			if var_338_10 < arg_335_1.time_ and arg_335_1.time_ <= var_338_10 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_12 = arg_335_1:FormatText(StoryNameCfg[383].name)

				arg_335_1.leftNameTxt_.text = var_338_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_13 = arg_335_1:GetWordFromCfg(120021080)
				local var_338_14 = arg_335_1:FormatText(var_338_13.content)

				arg_335_1.text_.text = var_338_14

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_15 = 20
				local var_338_16 = utf8.len(var_338_14)
				local var_338_17 = var_338_15 <= 0 and var_338_11 or var_338_11 * (var_338_16 / var_338_15)

				if var_338_17 > 0 and var_338_11 < var_338_17 then
					arg_335_1.talkMaxDuration = var_338_17

					if var_338_17 + var_338_10 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_17 + var_338_10
					end
				end

				arg_335_1.text_.text = var_338_14
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021080", "story_v_out_120021.awb") ~= 0 then
					local var_338_18 = manager.audio:GetVoiceLength("story_v_out_120021", "120021080", "story_v_out_120021.awb") / 1000

					if var_338_18 + var_338_10 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_18 + var_338_10
					end

					if var_338_13.prefab_name ~= "" and arg_335_1.actors_[var_338_13.prefab_name] ~= nil then
						local var_338_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_13.prefab_name].transform, "story_v_out_120021", "120021080", "story_v_out_120021.awb")

						arg_335_1:RecordAudio("120021080", var_338_19)
						arg_335_1:RecordAudio("120021080", var_338_19)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_120021", "120021080", "story_v_out_120021.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_120021", "120021080", "story_v_out_120021.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_20 = math.max(var_338_11, arg_335_1.talkMaxDuration)

			if var_338_10 <= arg_335_1.time_ and arg_335_1.time_ < var_338_10 + var_338_20 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_10) / var_338_20

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_10 + var_338_20 and arg_335_1.time_ < var_338_10 + var_338_20 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play120021081 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 120021081
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play120021082(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["10037ui_story"]
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect10037ui_story == nil then
				arg_339_1.var_.characterEffect10037ui_story = var_342_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.2

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 and not isNil(var_342_0) then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2

				if arg_339_1.var_.characterEffect10037ui_story and not isNil(var_342_0) then
					local var_342_4 = Mathf.Lerp(0, 0.5, var_342_3)

					arg_339_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_339_1.var_.characterEffect10037ui_story.fillRatio = var_342_4
				end
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect10037ui_story then
				local var_342_5 = 0.5

				arg_339_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_339_1.var_.characterEffect10037ui_story.fillRatio = var_342_5
			end

			local var_342_6 = 0
			local var_342_7 = 1.25

			if var_342_6 < arg_339_1.time_ and arg_339_1.time_ <= var_342_6 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_8 = arg_339_1:GetWordFromCfg(120021081)
				local var_342_9 = arg_339_1:FormatText(var_342_8.content)

				arg_339_1.text_.text = var_342_9

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_10 = 50
				local var_342_11 = utf8.len(var_342_9)
				local var_342_12 = var_342_10 <= 0 and var_342_7 or var_342_7 * (var_342_11 / var_342_10)

				if var_342_12 > 0 and var_342_7 < var_342_12 then
					arg_339_1.talkMaxDuration = var_342_12

					if var_342_12 + var_342_6 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_12 + var_342_6
					end
				end

				arg_339_1.text_.text = var_342_9
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_13 = math.max(var_342_7, arg_339_1.talkMaxDuration)

			if var_342_6 <= arg_339_1.time_ and arg_339_1.time_ < var_342_6 + var_342_13 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_6) / var_342_13

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_6 + var_342_13 and arg_339_1.time_ < var_342_6 + var_342_13 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play120021082 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 120021082
		arg_343_1.duration_ = 4.43

		local var_343_0 = {
			zh = 3.033,
			ja = 4.433
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play120021083(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["10037ui_story"]
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.characterEffect10037ui_story == nil then
				arg_343_1.var_.characterEffect10037ui_story = var_346_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_2 = 0.2

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 and not isNil(var_346_0) then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2

				if arg_343_1.var_.characterEffect10037ui_story and not isNil(var_346_0) then
					arg_343_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.characterEffect10037ui_story then
				arg_343_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_346_4 = 0
			local var_346_5 = 0.35

			if var_346_4 < arg_343_1.time_ and arg_343_1.time_ <= var_346_4 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_6 = arg_343_1:FormatText(StoryNameCfg[383].name)

				arg_343_1.leftNameTxt_.text = var_346_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_7 = arg_343_1:GetWordFromCfg(120021082)
				local var_346_8 = arg_343_1:FormatText(var_346_7.content)

				arg_343_1.text_.text = var_346_8

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_9 = 14
				local var_346_10 = utf8.len(var_346_8)
				local var_346_11 = var_346_9 <= 0 and var_346_5 or var_346_5 * (var_346_10 / var_346_9)

				if var_346_11 > 0 and var_346_5 < var_346_11 then
					arg_343_1.talkMaxDuration = var_346_11

					if var_346_11 + var_346_4 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_11 + var_346_4
					end
				end

				arg_343_1.text_.text = var_346_8
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021082", "story_v_out_120021.awb") ~= 0 then
					local var_346_12 = manager.audio:GetVoiceLength("story_v_out_120021", "120021082", "story_v_out_120021.awb") / 1000

					if var_346_12 + var_346_4 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_12 + var_346_4
					end

					if var_346_7.prefab_name ~= "" and arg_343_1.actors_[var_346_7.prefab_name] ~= nil then
						local var_346_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_7.prefab_name].transform, "story_v_out_120021", "120021082", "story_v_out_120021.awb")

						arg_343_1:RecordAudio("120021082", var_346_13)
						arg_343_1:RecordAudio("120021082", var_346_13)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_120021", "120021082", "story_v_out_120021.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_120021", "120021082", "story_v_out_120021.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_14 = math.max(var_346_5, arg_343_1.talkMaxDuration)

			if var_346_4 <= arg_343_1.time_ and arg_343_1.time_ < var_346_4 + var_346_14 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_4) / var_346_14

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_4 + var_346_14 and arg_343_1.time_ < var_346_4 + var_346_14 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play120021083 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 120021083
		arg_347_1.duration_ = 4.37

		local var_347_0 = {
			zh = 1.999999999999,
			ja = 4.366
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play120021084(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["1072ui_story"].transform
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.var_.moveOldPos1072ui_story = var_350_0.localPosition
			end

			local var_350_2 = 0.001

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2
				local var_350_4 = Vector3.New(0, 100, 0)

				var_350_0.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos1072ui_story, var_350_4, var_350_3)

				local var_350_5 = manager.ui.mainCamera.transform.position - var_350_0.position

				var_350_0.forward = Vector3.New(var_350_5.x, var_350_5.y, var_350_5.z)

				local var_350_6 = var_350_0.localEulerAngles

				var_350_6.z = 0
				var_350_6.x = 0
				var_350_0.localEulerAngles = var_350_6
			end

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 then
				var_350_0.localPosition = Vector3.New(0, 100, 0)

				local var_350_7 = manager.ui.mainCamera.transform.position - var_350_0.position

				var_350_0.forward = Vector3.New(var_350_7.x, var_350_7.y, var_350_7.z)

				local var_350_8 = var_350_0.localEulerAngles

				var_350_8.z = 0
				var_350_8.x = 0
				var_350_0.localEulerAngles = var_350_8
			end

			local var_350_9 = arg_347_1.actors_["1075ui_story"].transform
			local var_350_10 = 0

			if var_350_10 < arg_347_1.time_ and arg_347_1.time_ <= var_350_10 + arg_350_0 then
				arg_347_1.var_.moveOldPos1075ui_story = var_350_9.localPosition
			end

			local var_350_11 = 0.001

			if var_350_10 <= arg_347_1.time_ and arg_347_1.time_ < var_350_10 + var_350_11 then
				local var_350_12 = (arg_347_1.time_ - var_350_10) / var_350_11
				local var_350_13 = Vector3.New(-0.7, -1.055, -6.16)

				var_350_9.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos1075ui_story, var_350_13, var_350_12)

				local var_350_14 = manager.ui.mainCamera.transform.position - var_350_9.position

				var_350_9.forward = Vector3.New(var_350_14.x, var_350_14.y, var_350_14.z)

				local var_350_15 = var_350_9.localEulerAngles

				var_350_15.z = 0
				var_350_15.x = 0
				var_350_9.localEulerAngles = var_350_15
			end

			if arg_347_1.time_ >= var_350_10 + var_350_11 and arg_347_1.time_ < var_350_10 + var_350_11 + arg_350_0 then
				var_350_9.localPosition = Vector3.New(-0.7, -1.055, -6.16)

				local var_350_16 = manager.ui.mainCamera.transform.position - var_350_9.position

				var_350_9.forward = Vector3.New(var_350_16.x, var_350_16.y, var_350_16.z)

				local var_350_17 = var_350_9.localEulerAngles

				var_350_17.z = 0
				var_350_17.x = 0
				var_350_9.localEulerAngles = var_350_17
			end

			local var_350_18 = arg_347_1.actors_["1075ui_story"]
			local var_350_19 = 0

			if var_350_19 < arg_347_1.time_ and arg_347_1.time_ <= var_350_19 + arg_350_0 and not isNil(var_350_18) and arg_347_1.var_.characterEffect1075ui_story == nil then
				arg_347_1.var_.characterEffect1075ui_story = var_350_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_20 = 0.2

			if var_350_19 <= arg_347_1.time_ and arg_347_1.time_ < var_350_19 + var_350_20 and not isNil(var_350_18) then
				local var_350_21 = (arg_347_1.time_ - var_350_19) / var_350_20

				if arg_347_1.var_.characterEffect1075ui_story and not isNil(var_350_18) then
					arg_347_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= var_350_19 + var_350_20 and arg_347_1.time_ < var_350_19 + var_350_20 + arg_350_0 and not isNil(var_350_18) and arg_347_1.var_.characterEffect1075ui_story then
				arg_347_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_350_22 = arg_347_1.actors_["10037ui_story"]
			local var_350_23 = 0

			if var_350_23 < arg_347_1.time_ and arg_347_1.time_ <= var_350_23 + arg_350_0 and not isNil(var_350_22) and arg_347_1.var_.characterEffect10037ui_story == nil then
				arg_347_1.var_.characterEffect10037ui_story = var_350_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_24 = 0.2

			if var_350_23 <= arg_347_1.time_ and arg_347_1.time_ < var_350_23 + var_350_24 and not isNil(var_350_22) then
				local var_350_25 = (arg_347_1.time_ - var_350_23) / var_350_24

				if arg_347_1.var_.characterEffect10037ui_story and not isNil(var_350_22) then
					local var_350_26 = Mathf.Lerp(0, 0.5, var_350_25)

					arg_347_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_347_1.var_.characterEffect10037ui_story.fillRatio = var_350_26
				end
			end

			if arg_347_1.time_ >= var_350_23 + var_350_24 and arg_347_1.time_ < var_350_23 + var_350_24 + arg_350_0 and not isNil(var_350_22) and arg_347_1.var_.characterEffect10037ui_story then
				local var_350_27 = 0.5

				arg_347_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_347_1.var_.characterEffect10037ui_story.fillRatio = var_350_27
			end

			local var_350_28 = 0

			if var_350_28 < arg_347_1.time_ and arg_347_1.time_ <= var_350_28 + arg_350_0 then
				arg_347_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_350_29 = 0

			if var_350_29 < arg_347_1.time_ and arg_347_1.time_ <= var_350_29 + arg_350_0 then
				arg_347_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_350_30 = 0
			local var_350_31 = 0.15

			if var_350_30 < arg_347_1.time_ and arg_347_1.time_ <= var_350_30 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_32 = arg_347_1:FormatText(StoryNameCfg[381].name)

				arg_347_1.leftNameTxt_.text = var_350_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_33 = arg_347_1:GetWordFromCfg(120021083)
				local var_350_34 = arg_347_1:FormatText(var_350_33.content)

				arg_347_1.text_.text = var_350_34

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_35 = 6
				local var_350_36 = utf8.len(var_350_34)
				local var_350_37 = var_350_35 <= 0 and var_350_31 or var_350_31 * (var_350_36 / var_350_35)

				if var_350_37 > 0 and var_350_31 < var_350_37 then
					arg_347_1.talkMaxDuration = var_350_37

					if var_350_37 + var_350_30 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_37 + var_350_30
					end
				end

				arg_347_1.text_.text = var_350_34
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021083", "story_v_out_120021.awb") ~= 0 then
					local var_350_38 = manager.audio:GetVoiceLength("story_v_out_120021", "120021083", "story_v_out_120021.awb") / 1000

					if var_350_38 + var_350_30 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_38 + var_350_30
					end

					if var_350_33.prefab_name ~= "" and arg_347_1.actors_[var_350_33.prefab_name] ~= nil then
						local var_350_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_33.prefab_name].transform, "story_v_out_120021", "120021083", "story_v_out_120021.awb")

						arg_347_1:RecordAudio("120021083", var_350_39)
						arg_347_1:RecordAudio("120021083", var_350_39)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_120021", "120021083", "story_v_out_120021.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_120021", "120021083", "story_v_out_120021.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_40 = math.max(var_350_31, arg_347_1.talkMaxDuration)

			if var_350_30 <= arg_347_1.time_ and arg_347_1.time_ < var_350_30 + var_350_40 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_30) / var_350_40

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_30 + var_350_40 and arg_347_1.time_ < var_350_30 + var_350_40 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
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
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play120021084 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 120021084
		arg_351_1.duration_ = 3.67

		local var_351_0 = {
			zh = 2.8,
			ja = 3.666
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play120021085(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["1075ui_story"]
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1075ui_story == nil then
				arg_351_1.var_.characterEffect1075ui_story = var_354_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.2

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 and not isNil(var_354_0) then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2

				if arg_351_1.var_.characterEffect1075ui_story and not isNil(var_354_0) then
					local var_354_4 = Mathf.Lerp(0, 0.5, var_354_3)

					arg_351_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_351_1.var_.characterEffect1075ui_story.fillRatio = var_354_4
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1075ui_story then
				local var_354_5 = 0.5

				arg_351_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_351_1.var_.characterEffect1075ui_story.fillRatio = var_354_5
			end

			local var_354_6 = arg_351_1.actors_["10037ui_story"]
			local var_354_7 = 0

			if var_354_7 < arg_351_1.time_ and arg_351_1.time_ <= var_354_7 + arg_354_0 and not isNil(var_354_6) and arg_351_1.var_.characterEffect10037ui_story == nil then
				arg_351_1.var_.characterEffect10037ui_story = var_354_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_8 = 0.2

			if var_354_7 <= arg_351_1.time_ and arg_351_1.time_ < var_354_7 + var_354_8 and not isNil(var_354_6) then
				local var_354_9 = (arg_351_1.time_ - var_354_7) / var_354_8

				if arg_351_1.var_.characterEffect10037ui_story and not isNil(var_354_6) then
					arg_351_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= var_354_7 + var_354_8 and arg_351_1.time_ < var_354_7 + var_354_8 + arg_354_0 and not isNil(var_354_6) and arg_351_1.var_.characterEffect10037ui_story then
				arg_351_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_354_10 = 0
			local var_354_11 = 0.275

			if var_354_10 < arg_351_1.time_ and arg_351_1.time_ <= var_354_10 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_12 = arg_351_1:FormatText(StoryNameCfg[383].name)

				arg_351_1.leftNameTxt_.text = var_354_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_13 = arg_351_1:GetWordFromCfg(120021084)
				local var_354_14 = arg_351_1:FormatText(var_354_13.content)

				arg_351_1.text_.text = var_354_14

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_15 = 11
				local var_354_16 = utf8.len(var_354_14)
				local var_354_17 = var_354_15 <= 0 and var_354_11 or var_354_11 * (var_354_16 / var_354_15)

				if var_354_17 > 0 and var_354_11 < var_354_17 then
					arg_351_1.talkMaxDuration = var_354_17

					if var_354_17 + var_354_10 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_17 + var_354_10
					end
				end

				arg_351_1.text_.text = var_354_14
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021084", "story_v_out_120021.awb") ~= 0 then
					local var_354_18 = manager.audio:GetVoiceLength("story_v_out_120021", "120021084", "story_v_out_120021.awb") / 1000

					if var_354_18 + var_354_10 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_18 + var_354_10
					end

					if var_354_13.prefab_name ~= "" and arg_351_1.actors_[var_354_13.prefab_name] ~= nil then
						local var_354_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_13.prefab_name].transform, "story_v_out_120021", "120021084", "story_v_out_120021.awb")

						arg_351_1:RecordAudio("120021084", var_354_19)
						arg_351_1:RecordAudio("120021084", var_354_19)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_120021", "120021084", "story_v_out_120021.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_120021", "120021084", "story_v_out_120021.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_20 = math.max(var_354_11, arg_351_1.talkMaxDuration)

			if var_354_10 <= arg_351_1.time_ and arg_351_1.time_ < var_354_10 + var_354_20 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_10) / var_354_20

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_10 + var_354_20 and arg_351_1.time_ < var_354_10 + var_354_20 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play120021085 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 120021085
		arg_355_1.duration_ = 6.9

		local var_355_0 = {
			zh = 4.433,
			ja = 6.9
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play120021086(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["1075ui_story"]
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1075ui_story == nil then
				arg_355_1.var_.characterEffect1075ui_story = var_358_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.2

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 and not isNil(var_358_0) then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2

				if arg_355_1.var_.characterEffect1075ui_story and not isNil(var_358_0) then
					arg_355_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1075ui_story then
				arg_355_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_358_4 = arg_355_1.actors_["10037ui_story"]
			local var_358_5 = 0

			if var_358_5 < arg_355_1.time_ and arg_355_1.time_ <= var_358_5 + arg_358_0 and not isNil(var_358_4) and arg_355_1.var_.characterEffect10037ui_story == nil then
				arg_355_1.var_.characterEffect10037ui_story = var_358_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_6 = 0.2

			if var_358_5 <= arg_355_1.time_ and arg_355_1.time_ < var_358_5 + var_358_6 and not isNil(var_358_4) then
				local var_358_7 = (arg_355_1.time_ - var_358_5) / var_358_6

				if arg_355_1.var_.characterEffect10037ui_story and not isNil(var_358_4) then
					local var_358_8 = Mathf.Lerp(0, 0.5, var_358_7)

					arg_355_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_355_1.var_.characterEffect10037ui_story.fillRatio = var_358_8
				end
			end

			if arg_355_1.time_ >= var_358_5 + var_358_6 and arg_355_1.time_ < var_358_5 + var_358_6 + arg_358_0 and not isNil(var_358_4) and arg_355_1.var_.characterEffect10037ui_story then
				local var_358_9 = 0.5

				arg_355_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_355_1.var_.characterEffect10037ui_story.fillRatio = var_358_9
			end

			local var_358_10 = 0
			local var_358_11 = 0.475

			if var_358_10 < arg_355_1.time_ and arg_355_1.time_ <= var_358_10 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_12 = arg_355_1:FormatText(StoryNameCfg[381].name)

				arg_355_1.leftNameTxt_.text = var_358_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_13 = arg_355_1:GetWordFromCfg(120021085)
				local var_358_14 = arg_355_1:FormatText(var_358_13.content)

				arg_355_1.text_.text = var_358_14

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_15 = 19
				local var_358_16 = utf8.len(var_358_14)
				local var_358_17 = var_358_15 <= 0 and var_358_11 or var_358_11 * (var_358_16 / var_358_15)

				if var_358_17 > 0 and var_358_11 < var_358_17 then
					arg_355_1.talkMaxDuration = var_358_17

					if var_358_17 + var_358_10 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_17 + var_358_10
					end
				end

				arg_355_1.text_.text = var_358_14
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021085", "story_v_out_120021.awb") ~= 0 then
					local var_358_18 = manager.audio:GetVoiceLength("story_v_out_120021", "120021085", "story_v_out_120021.awb") / 1000

					if var_358_18 + var_358_10 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_18 + var_358_10
					end

					if var_358_13.prefab_name ~= "" and arg_355_1.actors_[var_358_13.prefab_name] ~= nil then
						local var_358_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_13.prefab_name].transform, "story_v_out_120021", "120021085", "story_v_out_120021.awb")

						arg_355_1:RecordAudio("120021085", var_358_19)
						arg_355_1:RecordAudio("120021085", var_358_19)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_120021", "120021085", "story_v_out_120021.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_120021", "120021085", "story_v_out_120021.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_20 = math.max(var_358_11, arg_355_1.talkMaxDuration)

			if var_358_10 <= arg_355_1.time_ and arg_355_1.time_ < var_358_10 + var_358_20 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_10) / var_358_20

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_10 + var_358_20 and arg_355_1.time_ < var_358_10 + var_358_20 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play120021086 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 120021086
		arg_359_1.duration_ = 3.97

		local var_359_0 = {
			zh = 3.333,
			ja = 3.966
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play120021087(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["1075ui_story"]
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.characterEffect1075ui_story == nil then
				arg_359_1.var_.characterEffect1075ui_story = var_362_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_2 = 0.2

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 and not isNil(var_362_0) then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2

				if arg_359_1.var_.characterEffect1075ui_story and not isNil(var_362_0) then
					local var_362_4 = Mathf.Lerp(0, 0.5, var_362_3)

					arg_359_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_359_1.var_.characterEffect1075ui_story.fillRatio = var_362_4
				end
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.characterEffect1075ui_story then
				local var_362_5 = 0.5

				arg_359_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_359_1.var_.characterEffect1075ui_story.fillRatio = var_362_5
			end

			local var_362_6 = arg_359_1.actors_["10037ui_story"]
			local var_362_7 = 0

			if var_362_7 < arg_359_1.time_ and arg_359_1.time_ <= var_362_7 + arg_362_0 and not isNil(var_362_6) and arg_359_1.var_.characterEffect10037ui_story == nil then
				arg_359_1.var_.characterEffect10037ui_story = var_362_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_8 = 0.2

			if var_362_7 <= arg_359_1.time_ and arg_359_1.time_ < var_362_7 + var_362_8 and not isNil(var_362_6) then
				local var_362_9 = (arg_359_1.time_ - var_362_7) / var_362_8

				if arg_359_1.var_.characterEffect10037ui_story and not isNil(var_362_6) then
					arg_359_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= var_362_7 + var_362_8 and arg_359_1.time_ < var_362_7 + var_362_8 + arg_362_0 and not isNil(var_362_6) and arg_359_1.var_.characterEffect10037ui_story then
				arg_359_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_362_10 = 0
			local var_362_11 = 0.225

			if var_362_10 < arg_359_1.time_ and arg_359_1.time_ <= var_362_10 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_12 = arg_359_1:FormatText(StoryNameCfg[383].name)

				arg_359_1.leftNameTxt_.text = var_362_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_13 = arg_359_1:GetWordFromCfg(120021086)
				local var_362_14 = arg_359_1:FormatText(var_362_13.content)

				arg_359_1.text_.text = var_362_14

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_15 = 10
				local var_362_16 = utf8.len(var_362_14)
				local var_362_17 = var_362_15 <= 0 and var_362_11 or var_362_11 * (var_362_16 / var_362_15)

				if var_362_17 > 0 and var_362_11 < var_362_17 then
					arg_359_1.talkMaxDuration = var_362_17

					if var_362_17 + var_362_10 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_17 + var_362_10
					end
				end

				arg_359_1.text_.text = var_362_14
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021086", "story_v_out_120021.awb") ~= 0 then
					local var_362_18 = manager.audio:GetVoiceLength("story_v_out_120021", "120021086", "story_v_out_120021.awb") / 1000

					if var_362_18 + var_362_10 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_18 + var_362_10
					end

					if var_362_13.prefab_name ~= "" and arg_359_1.actors_[var_362_13.prefab_name] ~= nil then
						local var_362_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_13.prefab_name].transform, "story_v_out_120021", "120021086", "story_v_out_120021.awb")

						arg_359_1:RecordAudio("120021086", var_362_19)
						arg_359_1:RecordAudio("120021086", var_362_19)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_120021", "120021086", "story_v_out_120021.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_120021", "120021086", "story_v_out_120021.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_20 = math.max(var_362_11, arg_359_1.talkMaxDuration)

			if var_362_10 <= arg_359_1.time_ and arg_359_1.time_ < var_362_10 + var_362_20 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_10) / var_362_20

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_10 + var_362_20 and arg_359_1.time_ < var_362_10 + var_362_20 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play120021087 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 120021087
		arg_363_1.duration_ = 7.77

		local var_363_0 = {
			zh = 5.4,
			ja = 7.766
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play120021088(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["1075ui_story"].transform
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 then
				arg_363_1.var_.moveOldPos1075ui_story = var_366_0.localPosition
			end

			local var_366_2 = 0.001

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2
				local var_366_4 = Vector3.New(0, 100, 0)

				var_366_0.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1075ui_story, var_366_4, var_366_3)

				local var_366_5 = manager.ui.mainCamera.transform.position - var_366_0.position

				var_366_0.forward = Vector3.New(var_366_5.x, var_366_5.y, var_366_5.z)

				local var_366_6 = var_366_0.localEulerAngles

				var_366_6.z = 0
				var_366_6.x = 0
				var_366_0.localEulerAngles = var_366_6
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 then
				var_366_0.localPosition = Vector3.New(0, 100, 0)

				local var_366_7 = manager.ui.mainCamera.transform.position - var_366_0.position

				var_366_0.forward = Vector3.New(var_366_7.x, var_366_7.y, var_366_7.z)

				local var_366_8 = var_366_0.localEulerAngles

				var_366_8.z = 0
				var_366_8.x = 0
				var_366_0.localEulerAngles = var_366_8
			end

			local var_366_9 = arg_363_1.actors_["1072ui_story"].transform
			local var_366_10 = 0

			if var_366_10 < arg_363_1.time_ and arg_363_1.time_ <= var_366_10 + arg_366_0 then
				arg_363_1.var_.moveOldPos1072ui_story = var_366_9.localPosition
			end

			local var_366_11 = 0.001

			if var_366_10 <= arg_363_1.time_ and arg_363_1.time_ < var_366_10 + var_366_11 then
				local var_366_12 = (arg_363_1.time_ - var_366_10) / var_366_11
				local var_366_13 = Vector3.New(-0.7, -0.71, -6)

				var_366_9.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1072ui_story, var_366_13, var_366_12)

				local var_366_14 = manager.ui.mainCamera.transform.position - var_366_9.position

				var_366_9.forward = Vector3.New(var_366_14.x, var_366_14.y, var_366_14.z)

				local var_366_15 = var_366_9.localEulerAngles

				var_366_15.z = 0
				var_366_15.x = 0
				var_366_9.localEulerAngles = var_366_15
			end

			if arg_363_1.time_ >= var_366_10 + var_366_11 and arg_363_1.time_ < var_366_10 + var_366_11 + arg_366_0 then
				var_366_9.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_366_16 = manager.ui.mainCamera.transform.position - var_366_9.position

				var_366_9.forward = Vector3.New(var_366_16.x, var_366_16.y, var_366_16.z)

				local var_366_17 = var_366_9.localEulerAngles

				var_366_17.z = 0
				var_366_17.x = 0
				var_366_9.localEulerAngles = var_366_17
			end

			local var_366_18 = arg_363_1.actors_["1072ui_story"]
			local var_366_19 = 0

			if var_366_19 < arg_363_1.time_ and arg_363_1.time_ <= var_366_19 + arg_366_0 and not isNil(var_366_18) and arg_363_1.var_.characterEffect1072ui_story == nil then
				arg_363_1.var_.characterEffect1072ui_story = var_366_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_20 = 0.2

			if var_366_19 <= arg_363_1.time_ and arg_363_1.time_ < var_366_19 + var_366_20 and not isNil(var_366_18) then
				local var_366_21 = (arg_363_1.time_ - var_366_19) / var_366_20

				if arg_363_1.var_.characterEffect1072ui_story and not isNil(var_366_18) then
					arg_363_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= var_366_19 + var_366_20 and arg_363_1.time_ < var_366_19 + var_366_20 + arg_366_0 and not isNil(var_366_18) and arg_363_1.var_.characterEffect1072ui_story then
				arg_363_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_366_22 = arg_363_1.actors_["10037ui_story"]
			local var_366_23 = 0

			if var_366_23 < arg_363_1.time_ and arg_363_1.time_ <= var_366_23 + arg_366_0 and not isNil(var_366_22) and arg_363_1.var_.characterEffect10037ui_story == nil then
				arg_363_1.var_.characterEffect10037ui_story = var_366_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_24 = 0.2

			if var_366_23 <= arg_363_1.time_ and arg_363_1.time_ < var_366_23 + var_366_24 and not isNil(var_366_22) then
				local var_366_25 = (arg_363_1.time_ - var_366_23) / var_366_24

				if arg_363_1.var_.characterEffect10037ui_story and not isNil(var_366_22) then
					local var_366_26 = Mathf.Lerp(0, 0.5, var_366_25)

					arg_363_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_363_1.var_.characterEffect10037ui_story.fillRatio = var_366_26
				end
			end

			if arg_363_1.time_ >= var_366_23 + var_366_24 and arg_363_1.time_ < var_366_23 + var_366_24 + arg_366_0 and not isNil(var_366_22) and arg_363_1.var_.characterEffect10037ui_story then
				local var_366_27 = 0.5

				arg_363_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_363_1.var_.characterEffect10037ui_story.fillRatio = var_366_27
			end

			local var_366_28 = 0

			if var_366_28 < arg_363_1.time_ and arg_363_1.time_ <= var_366_28 + arg_366_0 then
				arg_363_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_366_29 = 0
			local var_366_30 = 0.8

			if var_366_29 < arg_363_1.time_ and arg_363_1.time_ <= var_366_29 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_31 = arg_363_1:FormatText(StoryNameCfg[379].name)

				arg_363_1.leftNameTxt_.text = var_366_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_32 = arg_363_1:GetWordFromCfg(120021087)
				local var_366_33 = arg_363_1:FormatText(var_366_32.content)

				arg_363_1.text_.text = var_366_33

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_34 = 32
				local var_366_35 = utf8.len(var_366_33)
				local var_366_36 = var_366_34 <= 0 and var_366_30 or var_366_30 * (var_366_35 / var_366_34)

				if var_366_36 > 0 and var_366_30 < var_366_36 then
					arg_363_1.talkMaxDuration = var_366_36

					if var_366_36 + var_366_29 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_36 + var_366_29
					end
				end

				arg_363_1.text_.text = var_366_33
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021087", "story_v_out_120021.awb") ~= 0 then
					local var_366_37 = manager.audio:GetVoiceLength("story_v_out_120021", "120021087", "story_v_out_120021.awb") / 1000

					if var_366_37 + var_366_29 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_37 + var_366_29
					end

					if var_366_32.prefab_name ~= "" and arg_363_1.actors_[var_366_32.prefab_name] ~= nil then
						local var_366_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_32.prefab_name].transform, "story_v_out_120021", "120021087", "story_v_out_120021.awb")

						arg_363_1:RecordAudio("120021087", var_366_38)
						arg_363_1:RecordAudio("120021087", var_366_38)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_120021", "120021087", "story_v_out_120021.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_120021", "120021087", "story_v_out_120021.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_39 = math.max(var_366_30, arg_363_1.talkMaxDuration)

			if var_366_29 <= arg_363_1.time_ and arg_363_1.time_ < var_366_29 + var_366_39 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_29) / var_366_39

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_29 + var_366_39 and arg_363_1.time_ < var_366_29 + var_366_39 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
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
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play120021088 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 120021088
		arg_367_1.duration_ = 7.53

		local var_367_0 = {
			zh = 5.2,
			ja = 7.533
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play120021089(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["10037ui_story"]
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.characterEffect10037ui_story == nil then
				arg_367_1.var_.characterEffect10037ui_story = var_370_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.2

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 and not isNil(var_370_0) then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2

				if arg_367_1.var_.characterEffect10037ui_story and not isNil(var_370_0) then
					arg_367_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.characterEffect10037ui_story then
				arg_367_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_370_4 = arg_367_1.actors_["1072ui_story"]
			local var_370_5 = 0

			if var_370_5 < arg_367_1.time_ and arg_367_1.time_ <= var_370_5 + arg_370_0 and not isNil(var_370_4) and arg_367_1.var_.characterEffect1072ui_story == nil then
				arg_367_1.var_.characterEffect1072ui_story = var_370_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_6 = 0.2

			if var_370_5 <= arg_367_1.time_ and arg_367_1.time_ < var_370_5 + var_370_6 and not isNil(var_370_4) then
				local var_370_7 = (arg_367_1.time_ - var_370_5) / var_370_6

				if arg_367_1.var_.characterEffect1072ui_story and not isNil(var_370_4) then
					local var_370_8 = Mathf.Lerp(0, 0.5, var_370_7)

					arg_367_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_367_1.var_.characterEffect1072ui_story.fillRatio = var_370_8
				end
			end

			if arg_367_1.time_ >= var_370_5 + var_370_6 and arg_367_1.time_ < var_370_5 + var_370_6 + arg_370_0 and not isNil(var_370_4) and arg_367_1.var_.characterEffect1072ui_story then
				local var_370_9 = 0.5

				arg_367_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_367_1.var_.characterEffect1072ui_story.fillRatio = var_370_9
			end

			local var_370_10 = 0
			local var_370_11 = 0.65

			if var_370_10 < arg_367_1.time_ and arg_367_1.time_ <= var_370_10 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_12 = arg_367_1:FormatText(StoryNameCfg[383].name)

				arg_367_1.leftNameTxt_.text = var_370_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_13 = arg_367_1:GetWordFromCfg(120021088)
				local var_370_14 = arg_367_1:FormatText(var_370_13.content)

				arg_367_1.text_.text = var_370_14

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_15 = 26
				local var_370_16 = utf8.len(var_370_14)
				local var_370_17 = var_370_15 <= 0 and var_370_11 or var_370_11 * (var_370_16 / var_370_15)

				if var_370_17 > 0 and var_370_11 < var_370_17 then
					arg_367_1.talkMaxDuration = var_370_17

					if var_370_17 + var_370_10 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_17 + var_370_10
					end
				end

				arg_367_1.text_.text = var_370_14
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021088", "story_v_out_120021.awb") ~= 0 then
					local var_370_18 = manager.audio:GetVoiceLength("story_v_out_120021", "120021088", "story_v_out_120021.awb") / 1000

					if var_370_18 + var_370_10 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_18 + var_370_10
					end

					if var_370_13.prefab_name ~= "" and arg_367_1.actors_[var_370_13.prefab_name] ~= nil then
						local var_370_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_13.prefab_name].transform, "story_v_out_120021", "120021088", "story_v_out_120021.awb")

						arg_367_1:RecordAudio("120021088", var_370_19)
						arg_367_1:RecordAudio("120021088", var_370_19)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_120021", "120021088", "story_v_out_120021.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_120021", "120021088", "story_v_out_120021.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_20 = math.max(var_370_11, arg_367_1.talkMaxDuration)

			if var_370_10 <= arg_367_1.time_ and arg_367_1.time_ < var_370_10 + var_370_20 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_10) / var_370_20

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_10 + var_370_20 and arg_367_1.time_ < var_370_10 + var_370_20 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play120021089 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 120021089
		arg_371_1.duration_ = 20.13

		local var_371_0 = {
			zh = 6.3,
			ja = 20.133
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play120021090(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0
			local var_374_1 = 0.75

			if var_374_0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_2 = arg_371_1:FormatText(StoryNameCfg[383].name)

				arg_371_1.leftNameTxt_.text = var_374_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_3 = arg_371_1:GetWordFromCfg(120021089)
				local var_374_4 = arg_371_1:FormatText(var_374_3.content)

				arg_371_1.text_.text = var_374_4

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_5 = 30
				local var_374_6 = utf8.len(var_374_4)
				local var_374_7 = var_374_5 <= 0 and var_374_1 or var_374_1 * (var_374_6 / var_374_5)

				if var_374_7 > 0 and var_374_1 < var_374_7 then
					arg_371_1.talkMaxDuration = var_374_7

					if var_374_7 + var_374_0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_7 + var_374_0
					end
				end

				arg_371_1.text_.text = var_374_4
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021089", "story_v_out_120021.awb") ~= 0 then
					local var_374_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021089", "story_v_out_120021.awb") / 1000

					if var_374_8 + var_374_0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_8 + var_374_0
					end

					if var_374_3.prefab_name ~= "" and arg_371_1.actors_[var_374_3.prefab_name] ~= nil then
						local var_374_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_3.prefab_name].transform, "story_v_out_120021", "120021089", "story_v_out_120021.awb")

						arg_371_1:RecordAudio("120021089", var_374_9)
						arg_371_1:RecordAudio("120021089", var_374_9)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_120021", "120021089", "story_v_out_120021.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_120021", "120021089", "story_v_out_120021.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_10 = math.max(var_374_1, arg_371_1.talkMaxDuration)

			if var_374_0 <= arg_371_1.time_ and arg_371_1.time_ < var_374_0 + var_374_10 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_0) / var_374_10

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_0 + var_374_10 and arg_371_1.time_ < var_374_0 + var_374_10 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play120021090 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 120021090
		arg_375_1.duration_ = 4.9

		local var_375_0 = {
			zh = 2.033,
			ja = 4.9
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play120021091(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["10037ui_story"]
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.characterEffect10037ui_story == nil then
				arg_375_1.var_.characterEffect10037ui_story = var_378_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_2 = 0.2

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 and not isNil(var_378_0) then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2

				if arg_375_1.var_.characterEffect10037ui_story and not isNil(var_378_0) then
					local var_378_4 = Mathf.Lerp(0, 0.5, var_378_3)

					arg_375_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_375_1.var_.characterEffect10037ui_story.fillRatio = var_378_4
				end
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.characterEffect10037ui_story then
				local var_378_5 = 0.5

				arg_375_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_375_1.var_.characterEffect10037ui_story.fillRatio = var_378_5
			end

			local var_378_6 = arg_375_1.actors_["1072ui_story"]
			local var_378_7 = 0

			if var_378_7 < arg_375_1.time_ and arg_375_1.time_ <= var_378_7 + arg_378_0 and not isNil(var_378_6) and arg_375_1.var_.characterEffect1072ui_story == nil then
				arg_375_1.var_.characterEffect1072ui_story = var_378_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_8 = 0.2

			if var_378_7 <= arg_375_1.time_ and arg_375_1.time_ < var_378_7 + var_378_8 and not isNil(var_378_6) then
				local var_378_9 = (arg_375_1.time_ - var_378_7) / var_378_8

				if arg_375_1.var_.characterEffect1072ui_story and not isNil(var_378_6) then
					arg_375_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= var_378_7 + var_378_8 and arg_375_1.time_ < var_378_7 + var_378_8 + arg_378_0 and not isNil(var_378_6) and arg_375_1.var_.characterEffect1072ui_story then
				arg_375_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_378_10 = 0
			local var_378_11 = 0.25

			if var_378_10 < arg_375_1.time_ and arg_375_1.time_ <= var_378_10 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_12 = arg_375_1:FormatText(StoryNameCfg[379].name)

				arg_375_1.leftNameTxt_.text = var_378_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_13 = arg_375_1:GetWordFromCfg(120021090)
				local var_378_14 = arg_375_1:FormatText(var_378_13.content)

				arg_375_1.text_.text = var_378_14

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_15 = 10
				local var_378_16 = utf8.len(var_378_14)
				local var_378_17 = var_378_15 <= 0 and var_378_11 or var_378_11 * (var_378_16 / var_378_15)

				if var_378_17 > 0 and var_378_11 < var_378_17 then
					arg_375_1.talkMaxDuration = var_378_17

					if var_378_17 + var_378_10 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_17 + var_378_10
					end
				end

				arg_375_1.text_.text = var_378_14
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021090", "story_v_out_120021.awb") ~= 0 then
					local var_378_18 = manager.audio:GetVoiceLength("story_v_out_120021", "120021090", "story_v_out_120021.awb") / 1000

					if var_378_18 + var_378_10 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_18 + var_378_10
					end

					if var_378_13.prefab_name ~= "" and arg_375_1.actors_[var_378_13.prefab_name] ~= nil then
						local var_378_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_13.prefab_name].transform, "story_v_out_120021", "120021090", "story_v_out_120021.awb")

						arg_375_1:RecordAudio("120021090", var_378_19)
						arg_375_1:RecordAudio("120021090", var_378_19)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_120021", "120021090", "story_v_out_120021.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_120021", "120021090", "story_v_out_120021.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_20 = math.max(var_378_11, arg_375_1.talkMaxDuration)

			if var_378_10 <= arg_375_1.time_ and arg_375_1.time_ < var_378_10 + var_378_20 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_10) / var_378_20

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_10 + var_378_20 and arg_375_1.time_ < var_378_10 + var_378_20 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play120021091 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 120021091
		arg_379_1.duration_ = 17.87

		local var_379_0 = {
			zh = 9.4,
			ja = 17.866
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play120021092(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["10037ui_story"]
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect10037ui_story == nil then
				arg_379_1.var_.characterEffect10037ui_story = var_382_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.2

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 and not isNil(var_382_0) then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2

				if arg_379_1.var_.characterEffect10037ui_story and not isNil(var_382_0) then
					arg_379_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect10037ui_story then
				arg_379_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_382_4 = arg_379_1.actors_["1072ui_story"]
			local var_382_5 = 0

			if var_382_5 < arg_379_1.time_ and arg_379_1.time_ <= var_382_5 + arg_382_0 and not isNil(var_382_4) and arg_379_1.var_.characterEffect1072ui_story == nil then
				arg_379_1.var_.characterEffect1072ui_story = var_382_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_6 = 0.2

			if var_382_5 <= arg_379_1.time_ and arg_379_1.time_ < var_382_5 + var_382_6 and not isNil(var_382_4) then
				local var_382_7 = (arg_379_1.time_ - var_382_5) / var_382_6

				if arg_379_1.var_.characterEffect1072ui_story and not isNil(var_382_4) then
					local var_382_8 = Mathf.Lerp(0, 0.5, var_382_7)

					arg_379_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1072ui_story.fillRatio = var_382_8
				end
			end

			if arg_379_1.time_ >= var_382_5 + var_382_6 and arg_379_1.time_ < var_382_5 + var_382_6 + arg_382_0 and not isNil(var_382_4) and arg_379_1.var_.characterEffect1072ui_story then
				local var_382_9 = 0.5

				arg_379_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1072ui_story.fillRatio = var_382_9
			end

			local var_382_10 = 0

			if var_382_10 < arg_379_1.time_ and arg_379_1.time_ <= var_382_10 + arg_382_0 then
				arg_379_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_382_11 = 0

			if var_382_11 < arg_379_1.time_ and arg_379_1.time_ <= var_382_11 + arg_382_0 then
				arg_379_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action4_1")
			end

			local var_382_12 = 0
			local var_382_13 = 1

			if var_382_12 < arg_379_1.time_ and arg_379_1.time_ <= var_382_12 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_14 = arg_379_1:FormatText(StoryNameCfg[383].name)

				arg_379_1.leftNameTxt_.text = var_382_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_15 = arg_379_1:GetWordFromCfg(120021091)
				local var_382_16 = arg_379_1:FormatText(var_382_15.content)

				arg_379_1.text_.text = var_382_16

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_17 = 40
				local var_382_18 = utf8.len(var_382_16)
				local var_382_19 = var_382_17 <= 0 and var_382_13 or var_382_13 * (var_382_18 / var_382_17)

				if var_382_19 > 0 and var_382_13 < var_382_19 then
					arg_379_1.talkMaxDuration = var_382_19

					if var_382_19 + var_382_12 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_19 + var_382_12
					end
				end

				arg_379_1.text_.text = var_382_16
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021091", "story_v_out_120021.awb") ~= 0 then
					local var_382_20 = manager.audio:GetVoiceLength("story_v_out_120021", "120021091", "story_v_out_120021.awb") / 1000

					if var_382_20 + var_382_12 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_20 + var_382_12
					end

					if var_382_15.prefab_name ~= "" and arg_379_1.actors_[var_382_15.prefab_name] ~= nil then
						local var_382_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_15.prefab_name].transform, "story_v_out_120021", "120021091", "story_v_out_120021.awb")

						arg_379_1:RecordAudio("120021091", var_382_21)
						arg_379_1:RecordAudio("120021091", var_382_21)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_120021", "120021091", "story_v_out_120021.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_120021", "120021091", "story_v_out_120021.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_22 = math.max(var_382_13, arg_379_1.talkMaxDuration)

			if var_382_12 <= arg_379_1.time_ and arg_379_1.time_ < var_382_12 + var_382_22 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_12) / var_382_22

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_12 + var_382_22 and arg_379_1.time_ < var_382_12 + var_382_22 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play120021092 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 120021092
		arg_383_1.duration_ = 12.43

		local var_383_0 = {
			zh = 6,
			ja = 12.433
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play120021093(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0
			local var_386_1 = 0.8

			if var_386_0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_2 = arg_383_1:FormatText(StoryNameCfg[383].name)

				arg_383_1.leftNameTxt_.text = var_386_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_3 = arg_383_1:GetWordFromCfg(120021092)
				local var_386_4 = arg_383_1:FormatText(var_386_3.content)

				arg_383_1.text_.text = var_386_4

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_5 = 32
				local var_386_6 = utf8.len(var_386_4)
				local var_386_7 = var_386_5 <= 0 and var_386_1 or var_386_1 * (var_386_6 / var_386_5)

				if var_386_7 > 0 and var_386_1 < var_386_7 then
					arg_383_1.talkMaxDuration = var_386_7

					if var_386_7 + var_386_0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_7 + var_386_0
					end
				end

				arg_383_1.text_.text = var_386_4
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021092", "story_v_out_120021.awb") ~= 0 then
					local var_386_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021092", "story_v_out_120021.awb") / 1000

					if var_386_8 + var_386_0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_8 + var_386_0
					end

					if var_386_3.prefab_name ~= "" and arg_383_1.actors_[var_386_3.prefab_name] ~= nil then
						local var_386_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_3.prefab_name].transform, "story_v_out_120021", "120021092", "story_v_out_120021.awb")

						arg_383_1:RecordAudio("120021092", var_386_9)
						arg_383_1:RecordAudio("120021092", var_386_9)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_120021", "120021092", "story_v_out_120021.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_120021", "120021092", "story_v_out_120021.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_10 = math.max(var_386_1, arg_383_1.talkMaxDuration)

			if var_386_0 <= arg_383_1.time_ and arg_383_1.time_ < var_386_0 + var_386_10 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_0) / var_386_10

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_0 + var_386_10 and arg_383_1.time_ < var_386_0 + var_386_10 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play120021093 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 120021093
		arg_387_1.duration_ = 16.17

		local var_387_0 = {
			zh = 11.166,
			ja = 16.166
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play120021094(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0
			local var_390_1 = 1.35

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_2 = arg_387_1:FormatText(StoryNameCfg[383].name)

				arg_387_1.leftNameTxt_.text = var_390_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_3 = arg_387_1:GetWordFromCfg(120021093)
				local var_390_4 = arg_387_1:FormatText(var_390_3.content)

				arg_387_1.text_.text = var_390_4

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_5 = 54
				local var_390_6 = utf8.len(var_390_4)
				local var_390_7 = var_390_5 <= 0 and var_390_1 or var_390_1 * (var_390_6 / var_390_5)

				if var_390_7 > 0 and var_390_1 < var_390_7 then
					arg_387_1.talkMaxDuration = var_390_7

					if var_390_7 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_7 + var_390_0
					end
				end

				arg_387_1.text_.text = var_390_4
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021093", "story_v_out_120021.awb") ~= 0 then
					local var_390_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021093", "story_v_out_120021.awb") / 1000

					if var_390_8 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_8 + var_390_0
					end

					if var_390_3.prefab_name ~= "" and arg_387_1.actors_[var_390_3.prefab_name] ~= nil then
						local var_390_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_3.prefab_name].transform, "story_v_out_120021", "120021093", "story_v_out_120021.awb")

						arg_387_1:RecordAudio("120021093", var_390_9)
						arg_387_1:RecordAudio("120021093", var_390_9)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_120021", "120021093", "story_v_out_120021.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_120021", "120021093", "story_v_out_120021.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_10 = math.max(var_390_1, arg_387_1.talkMaxDuration)

			if var_390_0 <= arg_387_1.time_ and arg_387_1.time_ < var_390_0 + var_390_10 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_0) / var_390_10

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_0 + var_390_10 and arg_387_1.time_ < var_390_0 + var_390_10 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play120021094 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 120021094
		arg_391_1.duration_ = 13.23

		local var_391_0 = {
			zh = 10.9,
			ja = 13.233
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play120021095(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0

			if var_394_0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_0 + arg_394_0 then
				arg_391_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_394_1 = 0
			local var_394_2 = 1.4

			if var_394_1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_3 = arg_391_1:FormatText(StoryNameCfg[383].name)

				arg_391_1.leftNameTxt_.text = var_394_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_4 = arg_391_1:GetWordFromCfg(120021094)
				local var_394_5 = arg_391_1:FormatText(var_394_4.content)

				arg_391_1.text_.text = var_394_5

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_6 = 56
				local var_394_7 = utf8.len(var_394_5)
				local var_394_8 = var_394_6 <= 0 and var_394_2 or var_394_2 * (var_394_7 / var_394_6)

				if var_394_8 > 0 and var_394_2 < var_394_8 then
					arg_391_1.talkMaxDuration = var_394_8

					if var_394_8 + var_394_1 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_8 + var_394_1
					end
				end

				arg_391_1.text_.text = var_394_5
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021094", "story_v_out_120021.awb") ~= 0 then
					local var_394_9 = manager.audio:GetVoiceLength("story_v_out_120021", "120021094", "story_v_out_120021.awb") / 1000

					if var_394_9 + var_394_1 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_9 + var_394_1
					end

					if var_394_4.prefab_name ~= "" and arg_391_1.actors_[var_394_4.prefab_name] ~= nil then
						local var_394_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_4.prefab_name].transform, "story_v_out_120021", "120021094", "story_v_out_120021.awb")

						arg_391_1:RecordAudio("120021094", var_394_10)
						arg_391_1:RecordAudio("120021094", var_394_10)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_120021", "120021094", "story_v_out_120021.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_120021", "120021094", "story_v_out_120021.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_11 = math.max(var_394_2, arg_391_1.talkMaxDuration)

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_11 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_1) / var_394_11

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_1 + var_394_11 and arg_391_1.time_ < var_394_1 + var_394_11 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play120021095 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 120021095
		arg_395_1.duration_ = 9.2

		local var_395_0 = {
			zh = 3.966,
			ja = 9.2
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play120021096(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0

			if var_398_0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_0 + arg_398_0 then
				arg_395_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037actionlink/10037action443")
			end

			local var_398_1 = 0

			if var_398_1 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 then
				arg_395_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_398_2 = 0
			local var_398_3 = 0.4

			if var_398_2 < arg_395_1.time_ and arg_395_1.time_ <= var_398_2 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_4 = arg_395_1:FormatText(StoryNameCfg[383].name)

				arg_395_1.leftNameTxt_.text = var_398_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_5 = arg_395_1:GetWordFromCfg(120021095)
				local var_398_6 = arg_395_1:FormatText(var_398_5.content)

				arg_395_1.text_.text = var_398_6

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_7 = 16
				local var_398_8 = utf8.len(var_398_6)
				local var_398_9 = var_398_7 <= 0 and var_398_3 or var_398_3 * (var_398_8 / var_398_7)

				if var_398_9 > 0 and var_398_3 < var_398_9 then
					arg_395_1.talkMaxDuration = var_398_9

					if var_398_9 + var_398_2 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_9 + var_398_2
					end
				end

				arg_395_1.text_.text = var_398_6
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021095", "story_v_out_120021.awb") ~= 0 then
					local var_398_10 = manager.audio:GetVoiceLength("story_v_out_120021", "120021095", "story_v_out_120021.awb") / 1000

					if var_398_10 + var_398_2 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_10 + var_398_2
					end

					if var_398_5.prefab_name ~= "" and arg_395_1.actors_[var_398_5.prefab_name] ~= nil then
						local var_398_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_5.prefab_name].transform, "story_v_out_120021", "120021095", "story_v_out_120021.awb")

						arg_395_1:RecordAudio("120021095", var_398_11)
						arg_395_1:RecordAudio("120021095", var_398_11)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_120021", "120021095", "story_v_out_120021.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_120021", "120021095", "story_v_out_120021.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_12 = math.max(var_398_3, arg_395_1.talkMaxDuration)

			if var_398_2 <= arg_395_1.time_ and arg_395_1.time_ < var_398_2 + var_398_12 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_2) / var_398_12

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_2 + var_398_12 and arg_395_1.time_ < var_398_2 + var_398_12 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play120021096 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 120021096
		arg_399_1.duration_ = 13.73

		local var_399_0 = {
			zh = 10.166,
			ja = 13.733
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play120021097(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = arg_399_1.actors_["1072ui_story"]
			local var_402_1 = 0

			if var_402_1 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect1072ui_story == nil then
				arg_399_1.var_.characterEffect1072ui_story = var_402_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_2 = 0.2

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_2 and not isNil(var_402_0) then
				local var_402_3 = (arg_399_1.time_ - var_402_1) / var_402_2

				if arg_399_1.var_.characterEffect1072ui_story and not isNil(var_402_0) then
					arg_399_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= var_402_1 + var_402_2 and arg_399_1.time_ < var_402_1 + var_402_2 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect1072ui_story then
				arg_399_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_402_4 = arg_399_1.actors_["10037ui_story"]
			local var_402_5 = 0

			if var_402_5 < arg_399_1.time_ and arg_399_1.time_ <= var_402_5 + arg_402_0 and not isNil(var_402_4) and arg_399_1.var_.characterEffect10037ui_story == nil then
				arg_399_1.var_.characterEffect10037ui_story = var_402_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_6 = 0.2

			if var_402_5 <= arg_399_1.time_ and arg_399_1.time_ < var_402_5 + var_402_6 and not isNil(var_402_4) then
				local var_402_7 = (arg_399_1.time_ - var_402_5) / var_402_6

				if arg_399_1.var_.characterEffect10037ui_story and not isNil(var_402_4) then
					local var_402_8 = Mathf.Lerp(0, 0.5, var_402_7)

					arg_399_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_399_1.var_.characterEffect10037ui_story.fillRatio = var_402_8
				end
			end

			if arg_399_1.time_ >= var_402_5 + var_402_6 and arg_399_1.time_ < var_402_5 + var_402_6 + arg_402_0 and not isNil(var_402_4) and arg_399_1.var_.characterEffect10037ui_story then
				local var_402_9 = 0.5

				arg_399_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_399_1.var_.characterEffect10037ui_story.fillRatio = var_402_9
			end

			local var_402_10 = 0
			local var_402_11 = 1.4

			if var_402_10 < arg_399_1.time_ and arg_399_1.time_ <= var_402_10 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_12 = arg_399_1:FormatText(StoryNameCfg[379].name)

				arg_399_1.leftNameTxt_.text = var_402_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_13 = arg_399_1:GetWordFromCfg(120021096)
				local var_402_14 = arg_399_1:FormatText(var_402_13.content)

				arg_399_1.text_.text = var_402_14

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_15 = 56
				local var_402_16 = utf8.len(var_402_14)
				local var_402_17 = var_402_15 <= 0 and var_402_11 or var_402_11 * (var_402_16 / var_402_15)

				if var_402_17 > 0 and var_402_11 < var_402_17 then
					arg_399_1.talkMaxDuration = var_402_17

					if var_402_17 + var_402_10 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_17 + var_402_10
					end
				end

				arg_399_1.text_.text = var_402_14
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021096", "story_v_out_120021.awb") ~= 0 then
					local var_402_18 = manager.audio:GetVoiceLength("story_v_out_120021", "120021096", "story_v_out_120021.awb") / 1000

					if var_402_18 + var_402_10 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_18 + var_402_10
					end

					if var_402_13.prefab_name ~= "" and arg_399_1.actors_[var_402_13.prefab_name] ~= nil then
						local var_402_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_13.prefab_name].transform, "story_v_out_120021", "120021096", "story_v_out_120021.awb")

						arg_399_1:RecordAudio("120021096", var_402_19)
						arg_399_1:RecordAudio("120021096", var_402_19)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_120021", "120021096", "story_v_out_120021.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_120021", "120021096", "story_v_out_120021.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_20 = math.max(var_402_11, arg_399_1.talkMaxDuration)

			if var_402_10 <= arg_399_1.time_ and arg_399_1.time_ < var_402_10 + var_402_20 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_10) / var_402_20

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_10 + var_402_20 and arg_399_1.time_ < var_402_10 + var_402_20 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play120021097 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 120021097
		arg_403_1.duration_ = 12.03

		local var_403_0 = {
			zh = 11.766,
			ja = 12.033
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play120021098(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0
			local var_406_1 = 1.5

			if var_406_0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_2 = arg_403_1:FormatText(StoryNameCfg[379].name)

				arg_403_1.leftNameTxt_.text = var_406_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_3 = arg_403_1:GetWordFromCfg(120021097)
				local var_406_4 = arg_403_1:FormatText(var_406_3.content)

				arg_403_1.text_.text = var_406_4

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_5 = 60
				local var_406_6 = utf8.len(var_406_4)
				local var_406_7 = var_406_5 <= 0 and var_406_1 or var_406_1 * (var_406_6 / var_406_5)

				if var_406_7 > 0 and var_406_1 < var_406_7 then
					arg_403_1.talkMaxDuration = var_406_7

					if var_406_7 + var_406_0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_7 + var_406_0
					end
				end

				arg_403_1.text_.text = var_406_4
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021097", "story_v_out_120021.awb") ~= 0 then
					local var_406_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021097", "story_v_out_120021.awb") / 1000

					if var_406_8 + var_406_0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_8 + var_406_0
					end

					if var_406_3.prefab_name ~= "" and arg_403_1.actors_[var_406_3.prefab_name] ~= nil then
						local var_406_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_3.prefab_name].transform, "story_v_out_120021", "120021097", "story_v_out_120021.awb")

						arg_403_1:RecordAudio("120021097", var_406_9)
						arg_403_1:RecordAudio("120021097", var_406_9)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_120021", "120021097", "story_v_out_120021.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_120021", "120021097", "story_v_out_120021.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_10 = math.max(var_406_1, arg_403_1.talkMaxDuration)

			if var_406_0 <= arg_403_1.time_ and arg_403_1.time_ < var_406_0 + var_406_10 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_0) / var_406_10

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_0 + var_406_10 and arg_403_1.time_ < var_406_0 + var_406_10 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play120021098 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 120021098
		arg_407_1.duration_ = 13.9

		local var_407_0 = {
			zh = 5.733,
			ja = 13.9
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play120021099(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = arg_407_1.actors_["1072ui_story"]
			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1072ui_story == nil then
				arg_407_1.var_.characterEffect1072ui_story = var_410_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_2 = 0.2

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_2 and not isNil(var_410_0) then
				local var_410_3 = (arg_407_1.time_ - var_410_1) / var_410_2

				if arg_407_1.var_.characterEffect1072ui_story and not isNil(var_410_0) then
					local var_410_4 = Mathf.Lerp(0, 0.5, var_410_3)

					arg_407_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_407_1.var_.characterEffect1072ui_story.fillRatio = var_410_4
				end
			end

			if arg_407_1.time_ >= var_410_1 + var_410_2 and arg_407_1.time_ < var_410_1 + var_410_2 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1072ui_story then
				local var_410_5 = 0.5

				arg_407_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_407_1.var_.characterEffect1072ui_story.fillRatio = var_410_5
			end

			local var_410_6 = arg_407_1.actors_["10037ui_story"]
			local var_410_7 = 0

			if var_410_7 < arg_407_1.time_ and arg_407_1.time_ <= var_410_7 + arg_410_0 and not isNil(var_410_6) and arg_407_1.var_.characterEffect10037ui_story == nil then
				arg_407_1.var_.characterEffect10037ui_story = var_410_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_8 = 0.2

			if var_410_7 <= arg_407_1.time_ and arg_407_1.time_ < var_410_7 + var_410_8 and not isNil(var_410_6) then
				local var_410_9 = (arg_407_1.time_ - var_410_7) / var_410_8

				if arg_407_1.var_.characterEffect10037ui_story and not isNil(var_410_6) then
					arg_407_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= var_410_7 + var_410_8 and arg_407_1.time_ < var_410_7 + var_410_8 + arg_410_0 and not isNil(var_410_6) and arg_407_1.var_.characterEffect10037ui_story then
				arg_407_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_410_10 = 0

			if var_410_10 < arg_407_1.time_ and arg_407_1.time_ <= var_410_10 + arg_410_0 then
				arg_407_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_410_11 = 0
			local var_410_12 = 0.575

			if var_410_11 < arg_407_1.time_ and arg_407_1.time_ <= var_410_11 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_13 = arg_407_1:FormatText(StoryNameCfg[383].name)

				arg_407_1.leftNameTxt_.text = var_410_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_14 = arg_407_1:GetWordFromCfg(120021098)
				local var_410_15 = arg_407_1:FormatText(var_410_14.content)

				arg_407_1.text_.text = var_410_15

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_16 = 23
				local var_410_17 = utf8.len(var_410_15)
				local var_410_18 = var_410_16 <= 0 and var_410_12 or var_410_12 * (var_410_17 / var_410_16)

				if var_410_18 > 0 and var_410_12 < var_410_18 then
					arg_407_1.talkMaxDuration = var_410_18

					if var_410_18 + var_410_11 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_18 + var_410_11
					end
				end

				arg_407_1.text_.text = var_410_15
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021098", "story_v_out_120021.awb") ~= 0 then
					local var_410_19 = manager.audio:GetVoiceLength("story_v_out_120021", "120021098", "story_v_out_120021.awb") / 1000

					if var_410_19 + var_410_11 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_19 + var_410_11
					end

					if var_410_14.prefab_name ~= "" and arg_407_1.actors_[var_410_14.prefab_name] ~= nil then
						local var_410_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_14.prefab_name].transform, "story_v_out_120021", "120021098", "story_v_out_120021.awb")

						arg_407_1:RecordAudio("120021098", var_410_20)
						arg_407_1:RecordAudio("120021098", var_410_20)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_120021", "120021098", "story_v_out_120021.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_120021", "120021098", "story_v_out_120021.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_21 = math.max(var_410_12, arg_407_1.talkMaxDuration)

			if var_410_11 <= arg_407_1.time_ and arg_407_1.time_ < var_410_11 + var_410_21 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_11) / var_410_21

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_11 + var_410_21 and arg_407_1.time_ < var_410_11 + var_410_21 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play120021099 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 120021099
		arg_411_1.duration_ = 13.5

		local var_411_0 = {
			zh = 9.266,
			ja = 13.5
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play120021100(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0

			if var_414_0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_0 + arg_414_0 then
				arg_411_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_414_1 = 0
			local var_414_2 = 1.05

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_3 = arg_411_1:FormatText(StoryNameCfg[383].name)

				arg_411_1.leftNameTxt_.text = var_414_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_4 = arg_411_1:GetWordFromCfg(120021099)
				local var_414_5 = arg_411_1:FormatText(var_414_4.content)

				arg_411_1.text_.text = var_414_5

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_6 = 42
				local var_414_7 = utf8.len(var_414_5)
				local var_414_8 = var_414_6 <= 0 and var_414_2 or var_414_2 * (var_414_7 / var_414_6)

				if var_414_8 > 0 and var_414_2 < var_414_8 then
					arg_411_1.talkMaxDuration = var_414_8

					if var_414_8 + var_414_1 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_8 + var_414_1
					end
				end

				arg_411_1.text_.text = var_414_5
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021099", "story_v_out_120021.awb") ~= 0 then
					local var_414_9 = manager.audio:GetVoiceLength("story_v_out_120021", "120021099", "story_v_out_120021.awb") / 1000

					if var_414_9 + var_414_1 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_9 + var_414_1
					end

					if var_414_4.prefab_name ~= "" and arg_411_1.actors_[var_414_4.prefab_name] ~= nil then
						local var_414_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_4.prefab_name].transform, "story_v_out_120021", "120021099", "story_v_out_120021.awb")

						arg_411_1:RecordAudio("120021099", var_414_10)
						arg_411_1:RecordAudio("120021099", var_414_10)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_120021", "120021099", "story_v_out_120021.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_120021", "120021099", "story_v_out_120021.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_11 = math.max(var_414_2, arg_411_1.talkMaxDuration)

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_11 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_1) / var_414_11

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_1 + var_414_11 and arg_411_1.time_ < var_414_1 + var_414_11 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play120021100 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 120021100
		arg_415_1.duration_ = 9.3

		local var_415_0 = {
			zh = 4.666,
			ja = 9.3
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play120021101(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = arg_415_1.actors_["10037ui_story"]
			local var_418_1 = 0

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.characterEffect10037ui_story == nil then
				arg_415_1.var_.characterEffect10037ui_story = var_418_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_2 = 0.2

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_2 and not isNil(var_418_0) then
				local var_418_3 = (arg_415_1.time_ - var_418_1) / var_418_2

				if arg_415_1.var_.characterEffect10037ui_story and not isNil(var_418_0) then
					local var_418_4 = Mathf.Lerp(0, 0.5, var_418_3)

					arg_415_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_415_1.var_.characterEffect10037ui_story.fillRatio = var_418_4
				end
			end

			if arg_415_1.time_ >= var_418_1 + var_418_2 and arg_415_1.time_ < var_418_1 + var_418_2 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.characterEffect10037ui_story then
				local var_418_5 = 0.5

				arg_415_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_415_1.var_.characterEffect10037ui_story.fillRatio = var_418_5
			end

			local var_418_6 = arg_415_1.actors_["1072ui_story"]
			local var_418_7 = 0

			if var_418_7 < arg_415_1.time_ and arg_415_1.time_ <= var_418_7 + arg_418_0 and not isNil(var_418_6) and arg_415_1.var_.characterEffect1072ui_story == nil then
				arg_415_1.var_.characterEffect1072ui_story = var_418_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_8 = 0.2

			if var_418_7 <= arg_415_1.time_ and arg_415_1.time_ < var_418_7 + var_418_8 and not isNil(var_418_6) then
				local var_418_9 = (arg_415_1.time_ - var_418_7) / var_418_8

				if arg_415_1.var_.characterEffect1072ui_story and not isNil(var_418_6) then
					arg_415_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= var_418_7 + var_418_8 and arg_415_1.time_ < var_418_7 + var_418_8 + arg_418_0 and not isNil(var_418_6) and arg_415_1.var_.characterEffect1072ui_story then
				arg_415_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_418_10 = 0
			local var_418_11 = 0.575

			if var_418_10 < arg_415_1.time_ and arg_415_1.time_ <= var_418_10 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_12 = arg_415_1:FormatText(StoryNameCfg[379].name)

				arg_415_1.leftNameTxt_.text = var_418_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_13 = arg_415_1:GetWordFromCfg(120021100)
				local var_418_14 = arg_415_1:FormatText(var_418_13.content)

				arg_415_1.text_.text = var_418_14

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_15 = 23
				local var_418_16 = utf8.len(var_418_14)
				local var_418_17 = var_418_15 <= 0 and var_418_11 or var_418_11 * (var_418_16 / var_418_15)

				if var_418_17 > 0 and var_418_11 < var_418_17 then
					arg_415_1.talkMaxDuration = var_418_17

					if var_418_17 + var_418_10 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_17 + var_418_10
					end
				end

				arg_415_1.text_.text = var_418_14
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021100", "story_v_out_120021.awb") ~= 0 then
					local var_418_18 = manager.audio:GetVoiceLength("story_v_out_120021", "120021100", "story_v_out_120021.awb") / 1000

					if var_418_18 + var_418_10 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_18 + var_418_10
					end

					if var_418_13.prefab_name ~= "" and arg_415_1.actors_[var_418_13.prefab_name] ~= nil then
						local var_418_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_13.prefab_name].transform, "story_v_out_120021", "120021100", "story_v_out_120021.awb")

						arg_415_1:RecordAudio("120021100", var_418_19)
						arg_415_1:RecordAudio("120021100", var_418_19)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_120021", "120021100", "story_v_out_120021.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_120021", "120021100", "story_v_out_120021.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_20 = math.max(var_418_11, arg_415_1.talkMaxDuration)

			if var_418_10 <= arg_415_1.time_ and arg_415_1.time_ < var_418_10 + var_418_20 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_10) / var_418_20

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_10 + var_418_20 and arg_415_1.time_ < var_418_10 + var_418_20 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play120021101 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 120021101
		arg_419_1.duration_ = 9.97

		local var_419_0 = {
			zh = 6.6,
			ja = 9.966
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play120021102(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0

			if var_422_0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			local var_422_1 = 0
			local var_422_2 = 0.75

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_3 = arg_419_1:FormatText(StoryNameCfg[379].name)

				arg_419_1.leftNameTxt_.text = var_422_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_4 = arg_419_1:GetWordFromCfg(120021101)
				local var_422_5 = arg_419_1:FormatText(var_422_4.content)

				arg_419_1.text_.text = var_422_5

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_6 = 30
				local var_422_7 = utf8.len(var_422_5)
				local var_422_8 = var_422_6 <= 0 and var_422_2 or var_422_2 * (var_422_7 / var_422_6)

				if var_422_8 > 0 and var_422_2 < var_422_8 then
					arg_419_1.talkMaxDuration = var_422_8

					if var_422_8 + var_422_1 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_8 + var_422_1
					end
				end

				arg_419_1.text_.text = var_422_5
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021101", "story_v_out_120021.awb") ~= 0 then
					local var_422_9 = manager.audio:GetVoiceLength("story_v_out_120021", "120021101", "story_v_out_120021.awb") / 1000

					if var_422_9 + var_422_1 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_9 + var_422_1
					end

					if var_422_4.prefab_name ~= "" and arg_419_1.actors_[var_422_4.prefab_name] ~= nil then
						local var_422_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_4.prefab_name].transform, "story_v_out_120021", "120021101", "story_v_out_120021.awb")

						arg_419_1:RecordAudio("120021101", var_422_10)
						arg_419_1:RecordAudio("120021101", var_422_10)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_120021", "120021101", "story_v_out_120021.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_120021", "120021101", "story_v_out_120021.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_11 = math.max(var_422_2, arg_419_1.talkMaxDuration)

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_11 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_1) / var_422_11

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_1 + var_422_11 and arg_419_1.time_ < var_422_1 + var_422_11 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play120021102 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 120021102
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play120021103(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = arg_423_1.actors_["1072ui_story"]
			local var_426_1 = 0

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.characterEffect1072ui_story == nil then
				arg_423_1.var_.characterEffect1072ui_story = var_426_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.2

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_2 and not isNil(var_426_0) then
				local var_426_3 = (arg_423_1.time_ - var_426_1) / var_426_2

				if arg_423_1.var_.characterEffect1072ui_story and not isNil(var_426_0) then
					local var_426_4 = Mathf.Lerp(0, 0.5, var_426_3)

					arg_423_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1072ui_story.fillRatio = var_426_4
				end
			end

			if arg_423_1.time_ >= var_426_1 + var_426_2 and arg_423_1.time_ < var_426_1 + var_426_2 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.characterEffect1072ui_story then
				local var_426_5 = 0.5

				arg_423_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1072ui_story.fillRatio = var_426_5
			end

			local var_426_6 = 0
			local var_426_7 = 1.025

			if var_426_6 < arg_423_1.time_ and arg_423_1.time_ <= var_426_6 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, false)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_8 = arg_423_1:GetWordFromCfg(120021102)
				local var_426_9 = arg_423_1:FormatText(var_426_8.content)

				arg_423_1.text_.text = var_426_9

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_10 = 41
				local var_426_11 = utf8.len(var_426_9)
				local var_426_12 = var_426_10 <= 0 and var_426_7 or var_426_7 * (var_426_11 / var_426_10)

				if var_426_12 > 0 and var_426_7 < var_426_12 then
					arg_423_1.talkMaxDuration = var_426_12

					if var_426_12 + var_426_6 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_12 + var_426_6
					end
				end

				arg_423_1.text_.text = var_426_9
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_13 = math.max(var_426_7, arg_423_1.talkMaxDuration)

			if var_426_6 <= arg_423_1.time_ and arg_423_1.time_ < var_426_6 + var_426_13 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_6) / var_426_13

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_6 + var_426_13 and arg_423_1.time_ < var_426_6 + var_426_13 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play120021103 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 120021103
		arg_427_1.duration_ = 8

		local var_427_0 = {
			zh = 6.9,
			ja = 8
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play120021104(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = arg_427_1.actors_["1072ui_story"]
			local var_430_1 = 0

			if var_430_1 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 and not isNil(var_430_0) and arg_427_1.var_.characterEffect1072ui_story == nil then
				arg_427_1.var_.characterEffect1072ui_story = var_430_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_2 = 0.2

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_2 and not isNil(var_430_0) then
				local var_430_3 = (arg_427_1.time_ - var_430_1) / var_430_2

				if arg_427_1.var_.characterEffect1072ui_story and not isNil(var_430_0) then
					arg_427_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= var_430_1 + var_430_2 and arg_427_1.time_ < var_430_1 + var_430_2 + arg_430_0 and not isNil(var_430_0) and arg_427_1.var_.characterEffect1072ui_story then
				arg_427_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_430_4 = 0
			local var_430_5 = 0.85

			if var_430_4 < arg_427_1.time_ and arg_427_1.time_ <= var_430_4 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_6 = arg_427_1:FormatText(StoryNameCfg[379].name)

				arg_427_1.leftNameTxt_.text = var_430_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_7 = arg_427_1:GetWordFromCfg(120021103)
				local var_430_8 = arg_427_1:FormatText(var_430_7.content)

				arg_427_1.text_.text = var_430_8

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_9 = 34
				local var_430_10 = utf8.len(var_430_8)
				local var_430_11 = var_430_9 <= 0 and var_430_5 or var_430_5 * (var_430_10 / var_430_9)

				if var_430_11 > 0 and var_430_5 < var_430_11 then
					arg_427_1.talkMaxDuration = var_430_11

					if var_430_11 + var_430_4 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_11 + var_430_4
					end
				end

				arg_427_1.text_.text = var_430_8
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021103", "story_v_out_120021.awb") ~= 0 then
					local var_430_12 = manager.audio:GetVoiceLength("story_v_out_120021", "120021103", "story_v_out_120021.awb") / 1000

					if var_430_12 + var_430_4 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_12 + var_430_4
					end

					if var_430_7.prefab_name ~= "" and arg_427_1.actors_[var_430_7.prefab_name] ~= nil then
						local var_430_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_7.prefab_name].transform, "story_v_out_120021", "120021103", "story_v_out_120021.awb")

						arg_427_1:RecordAudio("120021103", var_430_13)
						arg_427_1:RecordAudio("120021103", var_430_13)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_120021", "120021103", "story_v_out_120021.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_120021", "120021103", "story_v_out_120021.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_14 = math.max(var_430_5, arg_427_1.talkMaxDuration)

			if var_430_4 <= arg_427_1.time_ and arg_427_1.time_ < var_430_4 + var_430_14 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_4) / var_430_14

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_4 + var_430_14 and arg_427_1.time_ < var_430_4 + var_430_14 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play120021104 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 120021104
		arg_431_1.duration_ = 17.23

		local var_431_0 = {
			zh = 12.033,
			ja = 17.233
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play120021105(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = "ST32"

			if arg_431_1.bgs_[var_434_0] == nil then
				local var_434_1 = Object.Instantiate(arg_431_1.paintGo_)

				var_434_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_434_0)
				var_434_1.name = var_434_0
				var_434_1.transform.parent = arg_431_1.stage_.transform
				var_434_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_431_1.bgs_[var_434_0] = var_434_1
			end

			local var_434_2 = 2

			if var_434_2 < arg_431_1.time_ and arg_431_1.time_ <= var_434_2 + arg_434_0 then
				local var_434_3 = manager.ui.mainCamera.transform.localPosition
				local var_434_4 = Vector3.New(0, 0, 10) + Vector3.New(var_434_3.x, var_434_3.y, 0)
				local var_434_5 = arg_431_1.bgs_.ST32

				var_434_5.transform.localPosition = var_434_4
				var_434_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_434_6 = var_434_5:GetComponent("SpriteRenderer")

				if var_434_6 and var_434_6.sprite then
					local var_434_7 = (var_434_5.transform.localPosition - var_434_3).z
					local var_434_8 = manager.ui.mainCameraCom_
					local var_434_9 = 2 * var_434_7 * Mathf.Tan(var_434_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_434_10 = var_434_9 * var_434_8.aspect
					local var_434_11 = var_434_6.sprite.bounds.size.x
					local var_434_12 = var_434_6.sprite.bounds.size.y
					local var_434_13 = var_434_10 / var_434_11
					local var_434_14 = var_434_9 / var_434_12
					local var_434_15 = var_434_14 < var_434_13 and var_434_13 or var_434_14

					var_434_5.transform.localScale = Vector3.New(var_434_15, var_434_15, 0)
				end

				for iter_434_0, iter_434_1 in pairs(arg_431_1.bgs_) do
					if iter_434_0 ~= "ST32" then
						iter_434_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_434_16 = 0

			if var_434_16 < arg_431_1.time_ and arg_431_1.time_ <= var_434_16 + arg_434_0 then
				arg_431_1.mask_.enabled = true
				arg_431_1.mask_.raycastTarget = true

				arg_431_1:SetGaussion(false)
			end

			local var_434_17 = 2

			if var_434_16 <= arg_431_1.time_ and arg_431_1.time_ < var_434_16 + var_434_17 then
				local var_434_18 = (arg_431_1.time_ - var_434_16) / var_434_17
				local var_434_19 = Color.New(0, 0, 0)

				var_434_19.a = Mathf.Lerp(0, 1, var_434_18)
				arg_431_1.mask_.color = var_434_19
			end

			if arg_431_1.time_ >= var_434_16 + var_434_17 and arg_431_1.time_ < var_434_16 + var_434_17 + arg_434_0 then
				local var_434_20 = Color.New(0, 0, 0)

				var_434_20.a = 1
				arg_431_1.mask_.color = var_434_20
			end

			local var_434_21 = 2

			if var_434_21 < arg_431_1.time_ and arg_431_1.time_ <= var_434_21 + arg_434_0 then
				arg_431_1.mask_.enabled = true
				arg_431_1.mask_.raycastTarget = true

				arg_431_1:SetGaussion(false)
			end

			local var_434_22 = 2

			if var_434_21 <= arg_431_1.time_ and arg_431_1.time_ < var_434_21 + var_434_22 then
				local var_434_23 = (arg_431_1.time_ - var_434_21) / var_434_22
				local var_434_24 = Color.New(0, 0, 0)

				var_434_24.a = Mathf.Lerp(1, 0, var_434_23)
				arg_431_1.mask_.color = var_434_24
			end

			if arg_431_1.time_ >= var_434_21 + var_434_22 and arg_431_1.time_ < var_434_21 + var_434_22 + arg_434_0 then
				local var_434_25 = Color.New(0, 0, 0)
				local var_434_26 = 0

				arg_431_1.mask_.enabled = false
				var_434_25.a = var_434_26
				arg_431_1.mask_.color = var_434_25
			end

			local var_434_27 = arg_431_1.actors_["1072ui_story"].transform
			local var_434_28 = 1.966

			if var_434_28 < arg_431_1.time_ and arg_431_1.time_ <= var_434_28 + arg_434_0 then
				arg_431_1.var_.moveOldPos1072ui_story = var_434_27.localPosition
			end

			local var_434_29 = 0.001

			if var_434_28 <= arg_431_1.time_ and arg_431_1.time_ < var_434_28 + var_434_29 then
				local var_434_30 = (arg_431_1.time_ - var_434_28) / var_434_29
				local var_434_31 = Vector3.New(0, 100, 0)

				var_434_27.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos1072ui_story, var_434_31, var_434_30)

				local var_434_32 = manager.ui.mainCamera.transform.position - var_434_27.position

				var_434_27.forward = Vector3.New(var_434_32.x, var_434_32.y, var_434_32.z)

				local var_434_33 = var_434_27.localEulerAngles

				var_434_33.z = 0
				var_434_33.x = 0
				var_434_27.localEulerAngles = var_434_33
			end

			if arg_431_1.time_ >= var_434_28 + var_434_29 and arg_431_1.time_ < var_434_28 + var_434_29 + arg_434_0 then
				var_434_27.localPosition = Vector3.New(0, 100, 0)

				local var_434_34 = manager.ui.mainCamera.transform.position - var_434_27.position

				var_434_27.forward = Vector3.New(var_434_34.x, var_434_34.y, var_434_34.z)

				local var_434_35 = var_434_27.localEulerAngles

				var_434_35.z = 0
				var_434_35.x = 0
				var_434_27.localEulerAngles = var_434_35
			end

			local var_434_36 = arg_431_1.actors_["10037ui_story"].transform
			local var_434_37 = 1.966

			if var_434_37 < arg_431_1.time_ and arg_431_1.time_ <= var_434_37 + arg_434_0 then
				arg_431_1.var_.moveOldPos10037ui_story = var_434_36.localPosition
			end

			local var_434_38 = 0.001

			if var_434_37 <= arg_431_1.time_ and arg_431_1.time_ < var_434_37 + var_434_38 then
				local var_434_39 = (arg_431_1.time_ - var_434_37) / var_434_38
				local var_434_40 = Vector3.New(0, 100, 0)

				var_434_36.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos10037ui_story, var_434_40, var_434_39)

				local var_434_41 = manager.ui.mainCamera.transform.position - var_434_36.position

				var_434_36.forward = Vector3.New(var_434_41.x, var_434_41.y, var_434_41.z)

				local var_434_42 = var_434_36.localEulerAngles

				var_434_42.z = 0
				var_434_42.x = 0
				var_434_36.localEulerAngles = var_434_42
			end

			if arg_431_1.time_ >= var_434_37 + var_434_38 and arg_431_1.time_ < var_434_37 + var_434_38 + arg_434_0 then
				var_434_36.localPosition = Vector3.New(0, 100, 0)

				local var_434_43 = manager.ui.mainCamera.transform.position - var_434_36.position

				var_434_36.forward = Vector3.New(var_434_43.x, var_434_43.y, var_434_43.z)

				local var_434_44 = var_434_36.localEulerAngles

				var_434_44.z = 0
				var_434_44.x = 0
				var_434_36.localEulerAngles = var_434_44
			end

			local var_434_45 = arg_431_1.actors_["1072ui_story"]
			local var_434_46 = 4

			if var_434_46 < arg_431_1.time_ and arg_431_1.time_ <= var_434_46 + arg_434_0 and not isNil(var_434_45) and arg_431_1.var_.characterEffect1072ui_story == nil then
				arg_431_1.var_.characterEffect1072ui_story = var_434_45:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_47 = 0.2

			if var_434_46 <= arg_431_1.time_ and arg_431_1.time_ < var_434_46 + var_434_47 and not isNil(var_434_45) then
				local var_434_48 = (arg_431_1.time_ - var_434_46) / var_434_47

				if arg_431_1.var_.characterEffect1072ui_story and not isNil(var_434_45) then
					arg_431_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= var_434_46 + var_434_47 and arg_431_1.time_ < var_434_46 + var_434_47 + arg_434_0 and not isNil(var_434_45) and arg_431_1.var_.characterEffect1072ui_story then
				arg_431_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_434_49 = 4

			if var_434_49 < arg_431_1.time_ and arg_431_1.time_ <= var_434_49 + arg_434_0 then
				arg_431_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_434_50 = 4

			if var_434_50 < arg_431_1.time_ and arg_431_1.time_ <= var_434_50 + arg_434_0 then
				arg_431_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_434_51 = arg_431_1.actors_["1072ui_story"].transform
			local var_434_52 = 4

			if var_434_52 < arg_431_1.time_ and arg_431_1.time_ <= var_434_52 + arg_434_0 then
				arg_431_1.var_.moveOldPos1072ui_story = var_434_51.localPosition
			end

			local var_434_53 = 0.001

			if var_434_52 <= arg_431_1.time_ and arg_431_1.time_ < var_434_52 + var_434_53 then
				local var_434_54 = (arg_431_1.time_ - var_434_52) / var_434_53
				local var_434_55 = Vector3.New(0, -0.71, -6)

				var_434_51.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos1072ui_story, var_434_55, var_434_54)

				local var_434_56 = manager.ui.mainCamera.transform.position - var_434_51.position

				var_434_51.forward = Vector3.New(var_434_56.x, var_434_56.y, var_434_56.z)

				local var_434_57 = var_434_51.localEulerAngles

				var_434_57.z = 0
				var_434_57.x = 0
				var_434_51.localEulerAngles = var_434_57
			end

			if arg_431_1.time_ >= var_434_52 + var_434_53 and arg_431_1.time_ < var_434_52 + var_434_53 + arg_434_0 then
				var_434_51.localPosition = Vector3.New(0, -0.71, -6)

				local var_434_58 = manager.ui.mainCamera.transform.position - var_434_51.position

				var_434_51.forward = Vector3.New(var_434_58.x, var_434_58.y, var_434_58.z)

				local var_434_59 = var_434_51.localEulerAngles

				var_434_59.z = 0
				var_434_59.x = 0
				var_434_51.localEulerAngles = var_434_59
			end

			if arg_431_1.frameCnt_ <= 1 then
				arg_431_1.dialog_:SetActive(false)
			end

			local var_434_60 = 4
			local var_434_61 = 0.7

			if var_434_60 < arg_431_1.time_ and arg_431_1.time_ <= var_434_60 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0

				arg_431_1.dialog_:SetActive(true)

				arg_431_1.dialogCg_.alpha = 0

				local var_434_62 = LeanTween.value(arg_431_1.dialog_, 0, 1, 0.3)

				var_434_62:setOnUpdate(LuaHelper.FloatAction(function(arg_435_0)
					arg_431_1.dialogCg_.alpha = arg_435_0
				end))
				var_434_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_431_1.dialog_)
					var_434_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_431_1.duration_ = arg_431_1.duration_ + 0.3

				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_63 = arg_431_1:FormatText(StoryNameCfg[379].name)

				arg_431_1.leftNameTxt_.text = var_434_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_64 = arg_431_1:GetWordFromCfg(120021104)
				local var_434_65 = arg_431_1:FormatText(var_434_64.content)

				arg_431_1.text_.text = var_434_65

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_66 = 28
				local var_434_67 = utf8.len(var_434_65)
				local var_434_68 = var_434_66 <= 0 and var_434_61 or var_434_61 * (var_434_67 / var_434_66)

				if var_434_68 > 0 and var_434_61 < var_434_68 then
					arg_431_1.talkMaxDuration = var_434_68
					var_434_60 = var_434_60 + 0.3

					if var_434_68 + var_434_60 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_68 + var_434_60
					end
				end

				arg_431_1.text_.text = var_434_65
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021104", "story_v_out_120021.awb") ~= 0 then
					local var_434_69 = manager.audio:GetVoiceLength("story_v_out_120021", "120021104", "story_v_out_120021.awb") / 1000

					if var_434_69 + var_434_60 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_69 + var_434_60
					end

					if var_434_64.prefab_name ~= "" and arg_431_1.actors_[var_434_64.prefab_name] ~= nil then
						local var_434_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_64.prefab_name].transform, "story_v_out_120021", "120021104", "story_v_out_120021.awb")

						arg_431_1:RecordAudio("120021104", var_434_70)
						arg_431_1:RecordAudio("120021104", var_434_70)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_120021", "120021104", "story_v_out_120021.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_120021", "120021104", "story_v_out_120021.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_71 = var_434_60 + 0.3
			local var_434_72 = math.max(var_434_61, arg_431_1.talkMaxDuration)

			if var_434_71 <= arg_431_1.time_ and arg_431_1.time_ < var_434_71 + var_434_72 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_71) / var_434_72

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_71 + var_434_72 and arg_431_1.time_ < var_434_71 + var_434_72 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_431_1:InitPlayNodeList()
	end,
	Play120021105 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 120021105
		arg_437_1.duration_ = 9.2

		local var_437_0 = {
			zh = 4.266,
			ja = 9.2
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play120021106(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0
			local var_440_1 = 0.55

			if var_440_0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_2 = arg_437_1:FormatText(StoryNameCfg[379].name)

				arg_437_1.leftNameTxt_.text = var_440_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_3 = arg_437_1:GetWordFromCfg(120021105)
				local var_440_4 = arg_437_1:FormatText(var_440_3.content)

				arg_437_1.text_.text = var_440_4

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_5 = 22
				local var_440_6 = utf8.len(var_440_4)
				local var_440_7 = var_440_5 <= 0 and var_440_1 or var_440_1 * (var_440_6 / var_440_5)

				if var_440_7 > 0 and var_440_1 < var_440_7 then
					arg_437_1.talkMaxDuration = var_440_7

					if var_440_7 + var_440_0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_7 + var_440_0
					end
				end

				arg_437_1.text_.text = var_440_4
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021105", "story_v_out_120021.awb") ~= 0 then
					local var_440_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021105", "story_v_out_120021.awb") / 1000

					if var_440_8 + var_440_0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_8 + var_440_0
					end

					if var_440_3.prefab_name ~= "" and arg_437_1.actors_[var_440_3.prefab_name] ~= nil then
						local var_440_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_3.prefab_name].transform, "story_v_out_120021", "120021105", "story_v_out_120021.awb")

						arg_437_1:RecordAudio("120021105", var_440_9)
						arg_437_1:RecordAudio("120021105", var_440_9)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_120021", "120021105", "story_v_out_120021.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_120021", "120021105", "story_v_out_120021.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_10 = math.max(var_440_1, arg_437_1.talkMaxDuration)

			if var_440_0 <= arg_437_1.time_ and arg_437_1.time_ < var_440_0 + var_440_10 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_0) / var_440_10

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_0 + var_440_10 and arg_437_1.time_ < var_440_0 + var_440_10 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play120021106 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 120021106
		arg_441_1.duration_ = 7.73

		local var_441_0 = {
			zh = 6.166,
			ja = 7.733
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play120021107(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0
			local var_444_1 = 0.725

			if var_444_0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_2 = arg_441_1:FormatText(StoryNameCfg[379].name)

				arg_441_1.leftNameTxt_.text = var_444_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_3 = arg_441_1:GetWordFromCfg(120021106)
				local var_444_4 = arg_441_1:FormatText(var_444_3.content)

				arg_441_1.text_.text = var_444_4

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_5 = 29
				local var_444_6 = utf8.len(var_444_4)
				local var_444_7 = var_444_5 <= 0 and var_444_1 or var_444_1 * (var_444_6 / var_444_5)

				if var_444_7 > 0 and var_444_1 < var_444_7 then
					arg_441_1.talkMaxDuration = var_444_7

					if var_444_7 + var_444_0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_7 + var_444_0
					end
				end

				arg_441_1.text_.text = var_444_4
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021106", "story_v_out_120021.awb") ~= 0 then
					local var_444_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021106", "story_v_out_120021.awb") / 1000

					if var_444_8 + var_444_0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_8 + var_444_0
					end

					if var_444_3.prefab_name ~= "" and arg_441_1.actors_[var_444_3.prefab_name] ~= nil then
						local var_444_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_3.prefab_name].transform, "story_v_out_120021", "120021106", "story_v_out_120021.awb")

						arg_441_1:RecordAudio("120021106", var_444_9)
						arg_441_1:RecordAudio("120021106", var_444_9)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_120021", "120021106", "story_v_out_120021.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_120021", "120021106", "story_v_out_120021.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_10 = math.max(var_444_1, arg_441_1.talkMaxDuration)

			if var_444_0 <= arg_441_1.time_ and arg_441_1.time_ < var_444_0 + var_444_10 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_0) / var_444_10

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_0 + var_444_10 and arg_441_1.time_ < var_444_0 + var_444_10 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play120021107 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 120021107
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play120021108(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = arg_445_1.actors_["1072ui_story"].transform
			local var_448_1 = 0

			if var_448_1 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 then
				arg_445_1.var_.moveOldPos1072ui_story = var_448_0.localPosition
			end

			local var_448_2 = 0.001

			if var_448_1 <= arg_445_1.time_ and arg_445_1.time_ < var_448_1 + var_448_2 then
				local var_448_3 = (arg_445_1.time_ - var_448_1) / var_448_2
				local var_448_4 = Vector3.New(0, 100, 0)

				var_448_0.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos1072ui_story, var_448_4, var_448_3)

				local var_448_5 = manager.ui.mainCamera.transform.position - var_448_0.position

				var_448_0.forward = Vector3.New(var_448_5.x, var_448_5.y, var_448_5.z)

				local var_448_6 = var_448_0.localEulerAngles

				var_448_6.z = 0
				var_448_6.x = 0
				var_448_0.localEulerAngles = var_448_6
			end

			if arg_445_1.time_ >= var_448_1 + var_448_2 and arg_445_1.time_ < var_448_1 + var_448_2 + arg_448_0 then
				var_448_0.localPosition = Vector3.New(0, 100, 0)

				local var_448_7 = manager.ui.mainCamera.transform.position - var_448_0.position

				var_448_0.forward = Vector3.New(var_448_7.x, var_448_7.y, var_448_7.z)

				local var_448_8 = var_448_0.localEulerAngles

				var_448_8.z = 0
				var_448_8.x = 0
				var_448_0.localEulerAngles = var_448_8
			end

			local var_448_9 = 0
			local var_448_10 = 1.45

			if var_448_9 < arg_445_1.time_ and arg_445_1.time_ <= var_448_9 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, false)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_11 = arg_445_1:GetWordFromCfg(120021107)
				local var_448_12 = arg_445_1:FormatText(var_448_11.content)

				arg_445_1.text_.text = var_448_12

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_13 = 58
				local var_448_14 = utf8.len(var_448_12)
				local var_448_15 = var_448_13 <= 0 and var_448_10 or var_448_10 * (var_448_14 / var_448_13)

				if var_448_15 > 0 and var_448_10 < var_448_15 then
					arg_445_1.talkMaxDuration = var_448_15

					if var_448_15 + var_448_9 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_15 + var_448_9
					end
				end

				arg_445_1.text_.text = var_448_12
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_16 = math.max(var_448_10, arg_445_1.talkMaxDuration)

			if var_448_9 <= arg_445_1.time_ and arg_445_1.time_ < var_448_9 + var_448_16 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_9) / var_448_16

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_9 + var_448_16 and arg_445_1.time_ < var_448_9 + var_448_16 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_445_1:InitPlayNodeList()
	end,
	Play120021108 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 120021108
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play120021109(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 0
			local var_452_1 = 0.175

			if var_452_0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_2 = arg_449_1:FormatText(StoryNameCfg[7].name)

				arg_449_1.leftNameTxt_.text = var_452_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_3 = arg_449_1:GetWordFromCfg(120021108)
				local var_452_4 = arg_449_1:FormatText(var_452_3.content)

				arg_449_1.text_.text = var_452_4

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_5 = 7
				local var_452_6 = utf8.len(var_452_4)
				local var_452_7 = var_452_5 <= 0 and var_452_1 or var_452_1 * (var_452_6 / var_452_5)

				if var_452_7 > 0 and var_452_1 < var_452_7 then
					arg_449_1.talkMaxDuration = var_452_7

					if var_452_7 + var_452_0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_7 + var_452_0
					end
				end

				arg_449_1.text_.text = var_452_4
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_8 = math.max(var_452_1, arg_449_1.talkMaxDuration)

			if var_452_0 <= arg_449_1.time_ and arg_449_1.time_ < var_452_0 + var_452_8 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_0) / var_452_8

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_0 + var_452_8 and arg_449_1.time_ < var_452_0 + var_452_8 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play120021109 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 120021109
		arg_453_1.duration_ = 2.03

		local var_453_0 = {
			zh = 1.999999999999,
			ja = 2.033
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play120021110(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = arg_453_1.actors_["1075ui_story"].transform
			local var_456_1 = 0

			if var_456_1 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 then
				arg_453_1.var_.moveOldPos1075ui_story = var_456_0.localPosition
			end

			local var_456_2 = 0.001

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_2 then
				local var_456_3 = (arg_453_1.time_ - var_456_1) / var_456_2
				local var_456_4 = Vector3.New(0, -1.055, -6.16)

				var_456_0.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1075ui_story, var_456_4, var_456_3)

				local var_456_5 = manager.ui.mainCamera.transform.position - var_456_0.position

				var_456_0.forward = Vector3.New(var_456_5.x, var_456_5.y, var_456_5.z)

				local var_456_6 = var_456_0.localEulerAngles

				var_456_6.z = 0
				var_456_6.x = 0
				var_456_0.localEulerAngles = var_456_6
			end

			if arg_453_1.time_ >= var_456_1 + var_456_2 and arg_453_1.time_ < var_456_1 + var_456_2 + arg_456_0 then
				var_456_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_456_7 = manager.ui.mainCamera.transform.position - var_456_0.position

				var_456_0.forward = Vector3.New(var_456_7.x, var_456_7.y, var_456_7.z)

				local var_456_8 = var_456_0.localEulerAngles

				var_456_8.z = 0
				var_456_8.x = 0
				var_456_0.localEulerAngles = var_456_8
			end

			local var_456_9 = arg_453_1.actors_["1075ui_story"]
			local var_456_10 = 0

			if var_456_10 < arg_453_1.time_ and arg_453_1.time_ <= var_456_10 + arg_456_0 and not isNil(var_456_9) and arg_453_1.var_.characterEffect1075ui_story == nil then
				arg_453_1.var_.characterEffect1075ui_story = var_456_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_11 = 0.2

			if var_456_10 <= arg_453_1.time_ and arg_453_1.time_ < var_456_10 + var_456_11 and not isNil(var_456_9) then
				local var_456_12 = (arg_453_1.time_ - var_456_10) / var_456_11

				if arg_453_1.var_.characterEffect1075ui_story and not isNil(var_456_9) then
					arg_453_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_453_1.time_ >= var_456_10 + var_456_11 and arg_453_1.time_ < var_456_10 + var_456_11 + arg_456_0 and not isNil(var_456_9) and arg_453_1.var_.characterEffect1075ui_story then
				arg_453_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_456_13 = 0

			if var_456_13 < arg_453_1.time_ and arg_453_1.time_ <= var_456_13 + arg_456_0 then
				arg_453_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_456_14 = 0

			if var_456_14 < arg_453_1.time_ and arg_453_1.time_ <= var_456_14 + arg_456_0 then
				arg_453_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_456_15 = 0
			local var_456_16 = 0.1

			if var_456_15 < arg_453_1.time_ and arg_453_1.time_ <= var_456_15 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				local var_456_17 = arg_453_1:FormatText(StoryNameCfg[381].name)

				arg_453_1.leftNameTxt_.text = var_456_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_18 = arg_453_1:GetWordFromCfg(120021109)
				local var_456_19 = arg_453_1:FormatText(var_456_18.content)

				arg_453_1.text_.text = var_456_19

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_20 = 4
				local var_456_21 = utf8.len(var_456_19)
				local var_456_22 = var_456_20 <= 0 and var_456_16 or var_456_16 * (var_456_21 / var_456_20)

				if var_456_22 > 0 and var_456_16 < var_456_22 then
					arg_453_1.talkMaxDuration = var_456_22

					if var_456_22 + var_456_15 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_22 + var_456_15
					end
				end

				arg_453_1.text_.text = var_456_19
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021109", "story_v_out_120021.awb") ~= 0 then
					local var_456_23 = manager.audio:GetVoiceLength("story_v_out_120021", "120021109", "story_v_out_120021.awb") / 1000

					if var_456_23 + var_456_15 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_23 + var_456_15
					end

					if var_456_18.prefab_name ~= "" and arg_453_1.actors_[var_456_18.prefab_name] ~= nil then
						local var_456_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_18.prefab_name].transform, "story_v_out_120021", "120021109", "story_v_out_120021.awb")

						arg_453_1:RecordAudio("120021109", var_456_24)
						arg_453_1:RecordAudio("120021109", var_456_24)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_120021", "120021109", "story_v_out_120021.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_120021", "120021109", "story_v_out_120021.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_25 = math.max(var_456_16, arg_453_1.talkMaxDuration)

			if var_456_15 <= arg_453_1.time_ and arg_453_1.time_ < var_456_15 + var_456_25 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_15) / var_456_25

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_15 + var_456_25 and arg_453_1.time_ < var_456_15 + var_456_25 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
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

		arg_453_1:InitPlayNodeList()
	end,
	Play120021110 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 120021110
		arg_457_1.duration_ = 7

		local var_457_0 = {
			zh = 6.066,
			ja = 7
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play120021111(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0

			if var_460_0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				arg_457_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_460_1 = 0
			local var_460_2 = 0.8

			if var_460_1 < arg_457_1.time_ and arg_457_1.time_ <= var_460_1 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				local var_460_3 = arg_457_1:FormatText(StoryNameCfg[381].name)

				arg_457_1.leftNameTxt_.text = var_460_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_4 = arg_457_1:GetWordFromCfg(120021110)
				local var_460_5 = arg_457_1:FormatText(var_460_4.content)

				arg_457_1.text_.text = var_460_5

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_6 = 32
				local var_460_7 = utf8.len(var_460_5)
				local var_460_8 = var_460_6 <= 0 and var_460_2 or var_460_2 * (var_460_7 / var_460_6)

				if var_460_8 > 0 and var_460_2 < var_460_8 then
					arg_457_1.talkMaxDuration = var_460_8

					if var_460_8 + var_460_1 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_8 + var_460_1
					end
				end

				arg_457_1.text_.text = var_460_5
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021110", "story_v_out_120021.awb") ~= 0 then
					local var_460_9 = manager.audio:GetVoiceLength("story_v_out_120021", "120021110", "story_v_out_120021.awb") / 1000

					if var_460_9 + var_460_1 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_9 + var_460_1
					end

					if var_460_4.prefab_name ~= "" and arg_457_1.actors_[var_460_4.prefab_name] ~= nil then
						local var_460_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_4.prefab_name].transform, "story_v_out_120021", "120021110", "story_v_out_120021.awb")

						arg_457_1:RecordAudio("120021110", var_460_10)
						arg_457_1:RecordAudio("120021110", var_460_10)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_120021", "120021110", "story_v_out_120021.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_120021", "120021110", "story_v_out_120021.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_11 = math.max(var_460_2, arg_457_1.talkMaxDuration)

			if var_460_1 <= arg_457_1.time_ and arg_457_1.time_ < var_460_1 + var_460_11 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_1) / var_460_11

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_1 + var_460_11 and arg_457_1.time_ < var_460_1 + var_460_11 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play120021111 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 120021111
		arg_461_1.duration_ = 13.87

		local var_461_0 = {
			zh = 6.366,
			ja = 13.866
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play120021112(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0

			if var_464_0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_0 + arg_464_0 then
				arg_461_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action454")
			end

			local var_464_1 = 0
			local var_464_2 = 0.725

			if var_464_1 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_3 = arg_461_1:FormatText(StoryNameCfg[381].name)

				arg_461_1.leftNameTxt_.text = var_464_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_4 = arg_461_1:GetWordFromCfg(120021111)
				local var_464_5 = arg_461_1:FormatText(var_464_4.content)

				arg_461_1.text_.text = var_464_5

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_6 = 29
				local var_464_7 = utf8.len(var_464_5)
				local var_464_8 = var_464_6 <= 0 and var_464_2 or var_464_2 * (var_464_7 / var_464_6)

				if var_464_8 > 0 and var_464_2 < var_464_8 then
					arg_461_1.talkMaxDuration = var_464_8

					if var_464_8 + var_464_1 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_8 + var_464_1
					end
				end

				arg_461_1.text_.text = var_464_5
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021111", "story_v_out_120021.awb") ~= 0 then
					local var_464_9 = manager.audio:GetVoiceLength("story_v_out_120021", "120021111", "story_v_out_120021.awb") / 1000

					if var_464_9 + var_464_1 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_9 + var_464_1
					end

					if var_464_4.prefab_name ~= "" and arg_461_1.actors_[var_464_4.prefab_name] ~= nil then
						local var_464_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_4.prefab_name].transform, "story_v_out_120021", "120021111", "story_v_out_120021.awb")

						arg_461_1:RecordAudio("120021111", var_464_10)
						arg_461_1:RecordAudio("120021111", var_464_10)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_120021", "120021111", "story_v_out_120021.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_120021", "120021111", "story_v_out_120021.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_11 = math.max(var_464_2, arg_461_1.talkMaxDuration)

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_11 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_1) / var_464_11

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_1 + var_464_11 and arg_461_1.time_ < var_464_1 + var_464_11 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play120021112 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 120021112
		arg_465_1.duration_ = 14.6

		local var_465_0 = {
			zh = 11.433,
			ja = 14.6
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play120021113(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0
			local var_468_1 = 1.4

			if var_468_0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_2 = arg_465_1:FormatText(StoryNameCfg[381].name)

				arg_465_1.leftNameTxt_.text = var_468_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_3 = arg_465_1:GetWordFromCfg(120021112)
				local var_468_4 = arg_465_1:FormatText(var_468_3.content)

				arg_465_1.text_.text = var_468_4

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_5 = 56
				local var_468_6 = utf8.len(var_468_4)
				local var_468_7 = var_468_5 <= 0 and var_468_1 or var_468_1 * (var_468_6 / var_468_5)

				if var_468_7 > 0 and var_468_1 < var_468_7 then
					arg_465_1.talkMaxDuration = var_468_7

					if var_468_7 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_7 + var_468_0
					end
				end

				arg_465_1.text_.text = var_468_4
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021112", "story_v_out_120021.awb") ~= 0 then
					local var_468_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021112", "story_v_out_120021.awb") / 1000

					if var_468_8 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_8 + var_468_0
					end

					if var_468_3.prefab_name ~= "" and arg_465_1.actors_[var_468_3.prefab_name] ~= nil then
						local var_468_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_3.prefab_name].transform, "story_v_out_120021", "120021112", "story_v_out_120021.awb")

						arg_465_1:RecordAudio("120021112", var_468_9)
						arg_465_1:RecordAudio("120021112", var_468_9)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_120021", "120021112", "story_v_out_120021.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_120021", "120021112", "story_v_out_120021.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_10 = math.max(var_468_1, arg_465_1.talkMaxDuration)

			if var_468_0 <= arg_465_1.time_ and arg_465_1.time_ < var_468_0 + var_468_10 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_0) / var_468_10

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_0 + var_468_10 and arg_465_1.time_ < var_468_0 + var_468_10 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play120021113 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 120021113
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play120021114(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = arg_469_1.actors_["1075ui_story"]
			local var_472_1 = 0

			if var_472_1 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 and not isNil(var_472_0) and arg_469_1.var_.characterEffect1075ui_story == nil then
				arg_469_1.var_.characterEffect1075ui_story = var_472_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_2 = 0.2

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_2 and not isNil(var_472_0) then
				local var_472_3 = (arg_469_1.time_ - var_472_1) / var_472_2

				if arg_469_1.var_.characterEffect1075ui_story and not isNil(var_472_0) then
					local var_472_4 = Mathf.Lerp(0, 0.5, var_472_3)

					arg_469_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_469_1.var_.characterEffect1075ui_story.fillRatio = var_472_4
				end
			end

			if arg_469_1.time_ >= var_472_1 + var_472_2 and arg_469_1.time_ < var_472_1 + var_472_2 + arg_472_0 and not isNil(var_472_0) and arg_469_1.var_.characterEffect1075ui_story then
				local var_472_5 = 0.5

				arg_469_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_469_1.var_.characterEffect1075ui_story.fillRatio = var_472_5
			end

			local var_472_6 = 0
			local var_472_7 = 1.15

			if var_472_6 < arg_469_1.time_ and arg_469_1.time_ <= var_472_6 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_8 = arg_469_1:FormatText(StoryNameCfg[7].name)

				arg_469_1.leftNameTxt_.text = var_472_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_469_1.callingController_:SetSelectedState("normal")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_9 = arg_469_1:GetWordFromCfg(120021113)
				local var_472_10 = arg_469_1:FormatText(var_472_9.content)

				arg_469_1.text_.text = var_472_10

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_11 = 46
				local var_472_12 = utf8.len(var_472_10)
				local var_472_13 = var_472_11 <= 0 and var_472_7 or var_472_7 * (var_472_12 / var_472_11)

				if var_472_13 > 0 and var_472_7 < var_472_13 then
					arg_469_1.talkMaxDuration = var_472_13

					if var_472_13 + var_472_6 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_13 + var_472_6
					end
				end

				arg_469_1.text_.text = var_472_10
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_14 = math.max(var_472_7, arg_469_1.talkMaxDuration)

			if var_472_6 <= arg_469_1.time_ and arg_469_1.time_ < var_472_6 + var_472_14 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_6) / var_472_14

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_6 + var_472_14 and arg_469_1.time_ < var_472_6 + var_472_14 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play120021114 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 120021114
		arg_473_1.duration_ = 16.3

		local var_473_0 = {
			zh = 11.666,
			ja = 16.3
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play120021115(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = arg_473_1.actors_["1075ui_story"]
			local var_476_1 = 0

			if var_476_1 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 and not isNil(var_476_0) and arg_473_1.var_.characterEffect1075ui_story == nil then
				arg_473_1.var_.characterEffect1075ui_story = var_476_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_2 = 0.2

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_2 and not isNil(var_476_0) then
				local var_476_3 = (arg_473_1.time_ - var_476_1) / var_476_2

				if arg_473_1.var_.characterEffect1075ui_story and not isNil(var_476_0) then
					arg_473_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= var_476_1 + var_476_2 and arg_473_1.time_ < var_476_1 + var_476_2 + arg_476_0 and not isNil(var_476_0) and arg_473_1.var_.characterEffect1075ui_story then
				arg_473_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_476_4 = 0
			local var_476_5 = 1.2

			if var_476_4 < arg_473_1.time_ and arg_473_1.time_ <= var_476_4 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_6 = arg_473_1:FormatText(StoryNameCfg[381].name)

				arg_473_1.leftNameTxt_.text = var_476_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_7 = arg_473_1:GetWordFromCfg(120021114)
				local var_476_8 = arg_473_1:FormatText(var_476_7.content)

				arg_473_1.text_.text = var_476_8

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_9 = 48
				local var_476_10 = utf8.len(var_476_8)
				local var_476_11 = var_476_9 <= 0 and var_476_5 or var_476_5 * (var_476_10 / var_476_9)

				if var_476_11 > 0 and var_476_5 < var_476_11 then
					arg_473_1.talkMaxDuration = var_476_11

					if var_476_11 + var_476_4 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_11 + var_476_4
					end
				end

				arg_473_1.text_.text = var_476_8
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021114", "story_v_out_120021.awb") ~= 0 then
					local var_476_12 = manager.audio:GetVoiceLength("story_v_out_120021", "120021114", "story_v_out_120021.awb") / 1000

					if var_476_12 + var_476_4 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_12 + var_476_4
					end

					if var_476_7.prefab_name ~= "" and arg_473_1.actors_[var_476_7.prefab_name] ~= nil then
						local var_476_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_7.prefab_name].transform, "story_v_out_120021", "120021114", "story_v_out_120021.awb")

						arg_473_1:RecordAudio("120021114", var_476_13)
						arg_473_1:RecordAudio("120021114", var_476_13)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_120021", "120021114", "story_v_out_120021.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_120021", "120021114", "story_v_out_120021.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_14 = math.max(var_476_5, arg_473_1.talkMaxDuration)

			if var_476_4 <= arg_473_1.time_ and arg_473_1.time_ < var_476_4 + var_476_14 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_4) / var_476_14

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_4 + var_476_14 and arg_473_1.time_ < var_476_4 + var_476_14 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play120021115 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 120021115
		arg_477_1.duration_ = 8.47

		local var_477_0 = {
			zh = 5.6,
			ja = 8.466
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play120021116(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0
			local var_480_1 = 0.7

			if var_480_0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_2 = arg_477_1:FormatText(StoryNameCfg[381].name)

				arg_477_1.leftNameTxt_.text = var_480_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_3 = arg_477_1:GetWordFromCfg(120021115)
				local var_480_4 = arg_477_1:FormatText(var_480_3.content)

				arg_477_1.text_.text = var_480_4

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_5 = 28
				local var_480_6 = utf8.len(var_480_4)
				local var_480_7 = var_480_5 <= 0 and var_480_1 or var_480_1 * (var_480_6 / var_480_5)

				if var_480_7 > 0 and var_480_1 < var_480_7 then
					arg_477_1.talkMaxDuration = var_480_7

					if var_480_7 + var_480_0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_7 + var_480_0
					end
				end

				arg_477_1.text_.text = var_480_4
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021115", "story_v_out_120021.awb") ~= 0 then
					local var_480_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021115", "story_v_out_120021.awb") / 1000

					if var_480_8 + var_480_0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_8 + var_480_0
					end

					if var_480_3.prefab_name ~= "" and arg_477_1.actors_[var_480_3.prefab_name] ~= nil then
						local var_480_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_3.prefab_name].transform, "story_v_out_120021", "120021115", "story_v_out_120021.awb")

						arg_477_1:RecordAudio("120021115", var_480_9)
						arg_477_1:RecordAudio("120021115", var_480_9)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_120021", "120021115", "story_v_out_120021.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_120021", "120021115", "story_v_out_120021.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_10 = math.max(var_480_1, arg_477_1.talkMaxDuration)

			if var_480_0 <= arg_477_1.time_ and arg_477_1.time_ < var_480_0 + var_480_10 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_0) / var_480_10

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_0 + var_480_10 and arg_477_1.time_ < var_480_0 + var_480_10 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play120021116 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 120021116
		arg_481_1.duration_ = 5.67

		local var_481_0 = {
			zh = 5.666,
			ja = 5.433
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play120021117(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0

			if var_484_0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_0 + arg_484_0 then
				arg_481_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_484_1 = 0

			if var_484_1 < arg_481_1.time_ and arg_481_1.time_ <= var_484_1 + arg_484_0 then
				arg_481_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_484_2 = 0
			local var_484_3 = 0.525

			if var_484_2 < arg_481_1.time_ and arg_481_1.time_ <= var_484_2 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_4 = arg_481_1:FormatText(StoryNameCfg[381].name)

				arg_481_1.leftNameTxt_.text = var_484_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_5 = arg_481_1:GetWordFromCfg(120021116)
				local var_484_6 = arg_481_1:FormatText(var_484_5.content)

				arg_481_1.text_.text = var_484_6

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_7 = 21
				local var_484_8 = utf8.len(var_484_6)
				local var_484_9 = var_484_7 <= 0 and var_484_3 or var_484_3 * (var_484_8 / var_484_7)

				if var_484_9 > 0 and var_484_3 < var_484_9 then
					arg_481_1.talkMaxDuration = var_484_9

					if var_484_9 + var_484_2 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_9 + var_484_2
					end
				end

				arg_481_1.text_.text = var_484_6
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021116", "story_v_out_120021.awb") ~= 0 then
					local var_484_10 = manager.audio:GetVoiceLength("story_v_out_120021", "120021116", "story_v_out_120021.awb") / 1000

					if var_484_10 + var_484_2 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_10 + var_484_2
					end

					if var_484_5.prefab_name ~= "" and arg_481_1.actors_[var_484_5.prefab_name] ~= nil then
						local var_484_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_5.prefab_name].transform, "story_v_out_120021", "120021116", "story_v_out_120021.awb")

						arg_481_1:RecordAudio("120021116", var_484_11)
						arg_481_1:RecordAudio("120021116", var_484_11)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_120021", "120021116", "story_v_out_120021.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_120021", "120021116", "story_v_out_120021.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_12 = math.max(var_484_3, arg_481_1.talkMaxDuration)

			if var_484_2 <= arg_481_1.time_ and arg_481_1.time_ < var_484_2 + var_484_12 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_2) / var_484_12

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_2 + var_484_12 and arg_481_1.time_ < var_484_2 + var_484_12 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play120021117 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 120021117
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play120021118(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = arg_485_1.actors_["1075ui_story"]
			local var_488_1 = 0

			if var_488_1 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 and not isNil(var_488_0) and arg_485_1.var_.characterEffect1075ui_story == nil then
				arg_485_1.var_.characterEffect1075ui_story = var_488_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_2 = 0.2

			if var_488_1 <= arg_485_1.time_ and arg_485_1.time_ < var_488_1 + var_488_2 and not isNil(var_488_0) then
				local var_488_3 = (arg_485_1.time_ - var_488_1) / var_488_2

				if arg_485_1.var_.characterEffect1075ui_story and not isNil(var_488_0) then
					local var_488_4 = Mathf.Lerp(0, 0.5, var_488_3)

					arg_485_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_485_1.var_.characterEffect1075ui_story.fillRatio = var_488_4
				end
			end

			if arg_485_1.time_ >= var_488_1 + var_488_2 and arg_485_1.time_ < var_488_1 + var_488_2 + arg_488_0 and not isNil(var_488_0) and arg_485_1.var_.characterEffect1075ui_story then
				local var_488_5 = 0.5

				arg_485_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_485_1.var_.characterEffect1075ui_story.fillRatio = var_488_5
			end

			local var_488_6 = 0
			local var_488_7 = 0.925

			if var_488_6 < arg_485_1.time_ and arg_485_1.time_ <= var_488_6 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, false)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_8 = arg_485_1:GetWordFromCfg(120021117)
				local var_488_9 = arg_485_1:FormatText(var_488_8.content)

				arg_485_1.text_.text = var_488_9

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_10 = 37
				local var_488_11 = utf8.len(var_488_9)
				local var_488_12 = var_488_10 <= 0 and var_488_7 or var_488_7 * (var_488_11 / var_488_10)

				if var_488_12 > 0 and var_488_7 < var_488_12 then
					arg_485_1.talkMaxDuration = var_488_12

					if var_488_12 + var_488_6 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_12 + var_488_6
					end
				end

				arg_485_1.text_.text = var_488_9
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_13 = math.max(var_488_7, arg_485_1.talkMaxDuration)

			if var_488_6 <= arg_485_1.time_ and arg_485_1.time_ < var_488_6 + var_488_13 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_6) / var_488_13

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_6 + var_488_13 and arg_485_1.time_ < var_488_6 + var_488_13 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play120021118 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 120021118
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play120021119(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0
			local var_492_1 = 1.05

			if var_492_0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				local var_492_2 = arg_489_1:FormatText(StoryNameCfg[7].name)

				arg_489_1.leftNameTxt_.text = var_492_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_3 = arg_489_1:GetWordFromCfg(120021118)
				local var_492_4 = arg_489_1:FormatText(var_492_3.content)

				arg_489_1.text_.text = var_492_4

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_5 = 42
				local var_492_6 = utf8.len(var_492_4)
				local var_492_7 = var_492_5 <= 0 and var_492_1 or var_492_1 * (var_492_6 / var_492_5)

				if var_492_7 > 0 and var_492_1 < var_492_7 then
					arg_489_1.talkMaxDuration = var_492_7

					if var_492_7 + var_492_0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_7 + var_492_0
					end
				end

				arg_489_1.text_.text = var_492_4
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_8 = math.max(var_492_1, arg_489_1.talkMaxDuration)

			if var_492_0 <= arg_489_1.time_ and arg_489_1.time_ < var_492_0 + var_492_8 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_0) / var_492_8

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_0 + var_492_8 and arg_489_1.time_ < var_492_0 + var_492_8 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play120021119 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 120021119
		arg_493_1.duration_ = 8.7

		local var_493_0 = {
			zh = 3,
			ja = 8.7
		}
		local var_493_1 = manager.audio:GetLocalizationFlag()

		if var_493_0[var_493_1] ~= nil then
			arg_493_1.duration_ = var_493_0[var_493_1]
		end

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play120021120(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = arg_493_1.actors_["1075ui_story"]
			local var_496_1 = 0

			if var_496_1 < arg_493_1.time_ and arg_493_1.time_ <= var_496_1 + arg_496_0 and not isNil(var_496_0) and arg_493_1.var_.characterEffect1075ui_story == nil then
				arg_493_1.var_.characterEffect1075ui_story = var_496_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_2 = 0.2

			if var_496_1 <= arg_493_1.time_ and arg_493_1.time_ < var_496_1 + var_496_2 and not isNil(var_496_0) then
				local var_496_3 = (arg_493_1.time_ - var_496_1) / var_496_2

				if arg_493_1.var_.characterEffect1075ui_story and not isNil(var_496_0) then
					arg_493_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= var_496_1 + var_496_2 and arg_493_1.time_ < var_496_1 + var_496_2 + arg_496_0 and not isNil(var_496_0) and arg_493_1.var_.characterEffect1075ui_story then
				arg_493_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_496_4 = 0
			local var_496_5 = 0.3

			if var_496_4 < arg_493_1.time_ and arg_493_1.time_ <= var_496_4 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				local var_496_6 = arg_493_1:FormatText(StoryNameCfg[381].name)

				arg_493_1.leftNameTxt_.text = var_496_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_7 = arg_493_1:GetWordFromCfg(120021119)
				local var_496_8 = arg_493_1:FormatText(var_496_7.content)

				arg_493_1.text_.text = var_496_8

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_9 = 12
				local var_496_10 = utf8.len(var_496_8)
				local var_496_11 = var_496_9 <= 0 and var_496_5 or var_496_5 * (var_496_10 / var_496_9)

				if var_496_11 > 0 and var_496_5 < var_496_11 then
					arg_493_1.talkMaxDuration = var_496_11

					if var_496_11 + var_496_4 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_11 + var_496_4
					end
				end

				arg_493_1.text_.text = var_496_8
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021119", "story_v_out_120021.awb") ~= 0 then
					local var_496_12 = manager.audio:GetVoiceLength("story_v_out_120021", "120021119", "story_v_out_120021.awb") / 1000

					if var_496_12 + var_496_4 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_12 + var_496_4
					end

					if var_496_7.prefab_name ~= "" and arg_493_1.actors_[var_496_7.prefab_name] ~= nil then
						local var_496_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_7.prefab_name].transform, "story_v_out_120021", "120021119", "story_v_out_120021.awb")

						arg_493_1:RecordAudio("120021119", var_496_13)
						arg_493_1:RecordAudio("120021119", var_496_13)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_out_120021", "120021119", "story_v_out_120021.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_out_120021", "120021119", "story_v_out_120021.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_14 = math.max(var_496_5, arg_493_1.talkMaxDuration)

			if var_496_4 <= arg_493_1.time_ and arg_493_1.time_ < var_496_4 + var_496_14 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_4) / var_496_14

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_4 + var_496_14 and arg_493_1.time_ < var_496_4 + var_496_14 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play120021120 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 120021120
		arg_497_1.duration_ = 12.43

		local var_497_0 = {
			zh = 7.4,
			ja = 12.433
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play120021121(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0
			local var_500_1 = 0.775

			if var_500_0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_0 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				local var_500_2 = arg_497_1:FormatText(StoryNameCfg[381].name)

				arg_497_1.leftNameTxt_.text = var_500_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_3 = arg_497_1:GetWordFromCfg(120021120)
				local var_500_4 = arg_497_1:FormatText(var_500_3.content)

				arg_497_1.text_.text = var_500_4

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_5 = 31
				local var_500_6 = utf8.len(var_500_4)
				local var_500_7 = var_500_5 <= 0 and var_500_1 or var_500_1 * (var_500_6 / var_500_5)

				if var_500_7 > 0 and var_500_1 < var_500_7 then
					arg_497_1.talkMaxDuration = var_500_7

					if var_500_7 + var_500_0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_7 + var_500_0
					end
				end

				arg_497_1.text_.text = var_500_4
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021120", "story_v_out_120021.awb") ~= 0 then
					local var_500_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021120", "story_v_out_120021.awb") / 1000

					if var_500_8 + var_500_0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_8 + var_500_0
					end

					if var_500_3.prefab_name ~= "" and arg_497_1.actors_[var_500_3.prefab_name] ~= nil then
						local var_500_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_3.prefab_name].transform, "story_v_out_120021", "120021120", "story_v_out_120021.awb")

						arg_497_1:RecordAudio("120021120", var_500_9)
						arg_497_1:RecordAudio("120021120", var_500_9)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_out_120021", "120021120", "story_v_out_120021.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_out_120021", "120021120", "story_v_out_120021.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_10 = math.max(var_500_1, arg_497_1.talkMaxDuration)

			if var_500_0 <= arg_497_1.time_ and arg_497_1.time_ < var_500_0 + var_500_10 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_0) / var_500_10

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_0 + var_500_10 and arg_497_1.time_ < var_500_0 + var_500_10 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play120021121 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 120021121
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play120021122(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = arg_501_1.actors_["1075ui_story"]
			local var_504_1 = 0

			if var_504_1 < arg_501_1.time_ and arg_501_1.time_ <= var_504_1 + arg_504_0 and not isNil(var_504_0) and arg_501_1.var_.characterEffect1075ui_story == nil then
				arg_501_1.var_.characterEffect1075ui_story = var_504_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_2 = 0.2

			if var_504_1 <= arg_501_1.time_ and arg_501_1.time_ < var_504_1 + var_504_2 and not isNil(var_504_0) then
				local var_504_3 = (arg_501_1.time_ - var_504_1) / var_504_2

				if arg_501_1.var_.characterEffect1075ui_story and not isNil(var_504_0) then
					local var_504_4 = Mathf.Lerp(0, 0.5, var_504_3)

					arg_501_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_501_1.var_.characterEffect1075ui_story.fillRatio = var_504_4
				end
			end

			if arg_501_1.time_ >= var_504_1 + var_504_2 and arg_501_1.time_ < var_504_1 + var_504_2 + arg_504_0 and not isNil(var_504_0) and arg_501_1.var_.characterEffect1075ui_story then
				local var_504_5 = 0.5

				arg_501_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_501_1.var_.characterEffect1075ui_story.fillRatio = var_504_5
			end

			local var_504_6 = 0

			if var_504_6 < arg_501_1.time_ and arg_501_1.time_ <= var_504_6 + arg_504_0 then
				arg_501_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_504_7 = 0
			local var_504_8 = 0.575

			if var_504_7 < arg_501_1.time_ and arg_501_1.time_ <= var_504_7 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, false)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_9 = arg_501_1:GetWordFromCfg(120021121)
				local var_504_10 = arg_501_1:FormatText(var_504_9.content)

				arg_501_1.text_.text = var_504_10

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_11 = 23
				local var_504_12 = utf8.len(var_504_10)
				local var_504_13 = var_504_11 <= 0 and var_504_8 or var_504_8 * (var_504_12 / var_504_11)

				if var_504_13 > 0 and var_504_8 < var_504_13 then
					arg_501_1.talkMaxDuration = var_504_13

					if var_504_13 + var_504_7 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_13 + var_504_7
					end
				end

				arg_501_1.text_.text = var_504_10
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_14 = math.max(var_504_8, arg_501_1.talkMaxDuration)

			if var_504_7 <= arg_501_1.time_ and arg_501_1.time_ < var_504_7 + var_504_14 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_7) / var_504_14

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_7 + var_504_14 and arg_501_1.time_ < var_504_7 + var_504_14 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play120021122 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 120021122
		arg_505_1.duration_ = 6.7

		local var_505_0 = {
			zh = 3.333,
			ja = 6.7
		}
		local var_505_1 = manager.audio:GetLocalizationFlag()

		if var_505_0[var_505_1] ~= nil then
			arg_505_1.duration_ = var_505_0[var_505_1]
		end

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play120021123(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = arg_505_1.actors_["1075ui_story"]
			local var_508_1 = 0

			if var_508_1 < arg_505_1.time_ and arg_505_1.time_ <= var_508_1 + arg_508_0 and not isNil(var_508_0) and arg_505_1.var_.characterEffect1075ui_story == nil then
				arg_505_1.var_.characterEffect1075ui_story = var_508_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_2 = 0.2

			if var_508_1 <= arg_505_1.time_ and arg_505_1.time_ < var_508_1 + var_508_2 and not isNil(var_508_0) then
				local var_508_3 = (arg_505_1.time_ - var_508_1) / var_508_2

				if arg_505_1.var_.characterEffect1075ui_story and not isNil(var_508_0) then
					arg_505_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_505_1.time_ >= var_508_1 + var_508_2 and arg_505_1.time_ < var_508_1 + var_508_2 + arg_508_0 and not isNil(var_508_0) and arg_505_1.var_.characterEffect1075ui_story then
				arg_505_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_508_4 = 0

			if var_508_4 < arg_505_1.time_ and arg_505_1.time_ <= var_508_4 + arg_508_0 then
				arg_505_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_508_5 = 0

			if var_508_5 < arg_505_1.time_ and arg_505_1.time_ <= var_508_5 + arg_508_0 then
				arg_505_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action6_1")
			end

			local var_508_6 = 0
			local var_508_7 = 0.425

			if var_508_6 < arg_505_1.time_ and arg_505_1.time_ <= var_508_6 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				local var_508_8 = arg_505_1:FormatText(StoryNameCfg[381].name)

				arg_505_1.leftNameTxt_.text = var_508_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_9 = arg_505_1:GetWordFromCfg(120021122)
				local var_508_10 = arg_505_1:FormatText(var_508_9.content)

				arg_505_1.text_.text = var_508_10

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_11 = 17
				local var_508_12 = utf8.len(var_508_10)
				local var_508_13 = var_508_11 <= 0 and var_508_7 or var_508_7 * (var_508_12 / var_508_11)

				if var_508_13 > 0 and var_508_7 < var_508_13 then
					arg_505_1.talkMaxDuration = var_508_13

					if var_508_13 + var_508_6 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_13 + var_508_6
					end
				end

				arg_505_1.text_.text = var_508_10
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021122", "story_v_out_120021.awb") ~= 0 then
					local var_508_14 = manager.audio:GetVoiceLength("story_v_out_120021", "120021122", "story_v_out_120021.awb") / 1000

					if var_508_14 + var_508_6 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_14 + var_508_6
					end

					if var_508_9.prefab_name ~= "" and arg_505_1.actors_[var_508_9.prefab_name] ~= nil then
						local var_508_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_9.prefab_name].transform, "story_v_out_120021", "120021122", "story_v_out_120021.awb")

						arg_505_1:RecordAudio("120021122", var_508_15)
						arg_505_1:RecordAudio("120021122", var_508_15)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_out_120021", "120021122", "story_v_out_120021.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_out_120021", "120021122", "story_v_out_120021.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_16 = math.max(var_508_7, arg_505_1.talkMaxDuration)

			if var_508_6 <= arg_505_1.time_ and arg_505_1.time_ < var_508_6 + var_508_16 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_6) / var_508_16

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_6 + var_508_16 and arg_505_1.time_ < var_508_6 + var_508_16 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play120021123 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 120021123
		arg_509_1.duration_ = 15.23

		local var_509_0 = {
			zh = 9.966,
			ja = 15.233
		}
		local var_509_1 = manager.audio:GetLocalizationFlag()

		if var_509_0[var_509_1] ~= nil then
			arg_509_1.duration_ = var_509_0[var_509_1]
		end

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play120021124(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 0

			if var_512_0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_0 + arg_512_0 then
				arg_509_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_512_1 = 0
			local var_512_2 = 1.1

			if var_512_1 < arg_509_1.time_ and arg_509_1.time_ <= var_512_1 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				local var_512_3 = arg_509_1:FormatText(StoryNameCfg[381].name)

				arg_509_1.leftNameTxt_.text = var_512_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_4 = arg_509_1:GetWordFromCfg(120021123)
				local var_512_5 = arg_509_1:FormatText(var_512_4.content)

				arg_509_1.text_.text = var_512_5

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_6 = 44
				local var_512_7 = utf8.len(var_512_5)
				local var_512_8 = var_512_6 <= 0 and var_512_2 or var_512_2 * (var_512_7 / var_512_6)

				if var_512_8 > 0 and var_512_2 < var_512_8 then
					arg_509_1.talkMaxDuration = var_512_8

					if var_512_8 + var_512_1 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_8 + var_512_1
					end
				end

				arg_509_1.text_.text = var_512_5
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021123", "story_v_out_120021.awb") ~= 0 then
					local var_512_9 = manager.audio:GetVoiceLength("story_v_out_120021", "120021123", "story_v_out_120021.awb") / 1000

					if var_512_9 + var_512_1 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_9 + var_512_1
					end

					if var_512_4.prefab_name ~= "" and arg_509_1.actors_[var_512_4.prefab_name] ~= nil then
						local var_512_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_4.prefab_name].transform, "story_v_out_120021", "120021123", "story_v_out_120021.awb")

						arg_509_1:RecordAudio("120021123", var_512_10)
						arg_509_1:RecordAudio("120021123", var_512_10)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_out_120021", "120021123", "story_v_out_120021.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_out_120021", "120021123", "story_v_out_120021.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_11 = math.max(var_512_2, arg_509_1.talkMaxDuration)

			if var_512_1 <= arg_509_1.time_ and arg_509_1.time_ < var_512_1 + var_512_11 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_1) / var_512_11

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_1 + var_512_11 and arg_509_1.time_ < var_512_1 + var_512_11 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play120021124 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 120021124
		arg_513_1.duration_ = 20.93

		local var_513_0 = {
			zh = 8.966,
			ja = 20.933
		}
		local var_513_1 = manager.audio:GetLocalizationFlag()

		if var_513_0[var_513_1] ~= nil then
			arg_513_1.duration_ = var_513_0[var_513_1]
		end

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play120021125(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0

			if var_516_0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_0 + arg_516_0 then
				arg_513_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_516_1 = 0

			if var_516_1 < arg_513_1.time_ and arg_513_1.time_ <= var_516_1 + arg_516_0 then
				arg_513_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action6_2")
			end

			local var_516_2 = 0
			local var_516_3 = 1

			if var_516_2 < arg_513_1.time_ and arg_513_1.time_ <= var_516_2 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				local var_516_4 = arg_513_1:FormatText(StoryNameCfg[381].name)

				arg_513_1.leftNameTxt_.text = var_516_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_5 = arg_513_1:GetWordFromCfg(120021124)
				local var_516_6 = arg_513_1:FormatText(var_516_5.content)

				arg_513_1.text_.text = var_516_6

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_7 = 40
				local var_516_8 = utf8.len(var_516_6)
				local var_516_9 = var_516_7 <= 0 and var_516_3 or var_516_3 * (var_516_8 / var_516_7)

				if var_516_9 > 0 and var_516_3 < var_516_9 then
					arg_513_1.talkMaxDuration = var_516_9

					if var_516_9 + var_516_2 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_9 + var_516_2
					end
				end

				arg_513_1.text_.text = var_516_6
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021124", "story_v_out_120021.awb") ~= 0 then
					local var_516_10 = manager.audio:GetVoiceLength("story_v_out_120021", "120021124", "story_v_out_120021.awb") / 1000

					if var_516_10 + var_516_2 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_10 + var_516_2
					end

					if var_516_5.prefab_name ~= "" and arg_513_1.actors_[var_516_5.prefab_name] ~= nil then
						local var_516_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_5.prefab_name].transform, "story_v_out_120021", "120021124", "story_v_out_120021.awb")

						arg_513_1:RecordAudio("120021124", var_516_11)
						arg_513_1:RecordAudio("120021124", var_516_11)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_out_120021", "120021124", "story_v_out_120021.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_out_120021", "120021124", "story_v_out_120021.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_12 = math.max(var_516_3, arg_513_1.talkMaxDuration)

			if var_516_2 <= arg_513_1.time_ and arg_513_1.time_ < var_516_2 + var_516_12 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_2) / var_516_12

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_2 + var_516_12 and arg_513_1.time_ < var_516_2 + var_516_12 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play120021125 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 120021125
		arg_517_1.duration_ = 7.47

		local var_517_0 = {
			zh = 7.466,
			ja = 6.133
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play120021126(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0
			local var_520_1 = 0.725

			if var_520_0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				local var_520_2 = arg_517_1:FormatText(StoryNameCfg[381].name)

				arg_517_1.leftNameTxt_.text = var_520_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_3 = arg_517_1:GetWordFromCfg(120021125)
				local var_520_4 = arg_517_1:FormatText(var_520_3.content)

				arg_517_1.text_.text = var_520_4

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_5 = 29
				local var_520_6 = utf8.len(var_520_4)
				local var_520_7 = var_520_5 <= 0 and var_520_1 or var_520_1 * (var_520_6 / var_520_5)

				if var_520_7 > 0 and var_520_1 < var_520_7 then
					arg_517_1.talkMaxDuration = var_520_7

					if var_520_7 + var_520_0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_7 + var_520_0
					end
				end

				arg_517_1.text_.text = var_520_4
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021125", "story_v_out_120021.awb") ~= 0 then
					local var_520_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021125", "story_v_out_120021.awb") / 1000

					if var_520_8 + var_520_0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_8 + var_520_0
					end

					if var_520_3.prefab_name ~= "" and arg_517_1.actors_[var_520_3.prefab_name] ~= nil then
						local var_520_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_3.prefab_name].transform, "story_v_out_120021", "120021125", "story_v_out_120021.awb")

						arg_517_1:RecordAudio("120021125", var_520_9)
						arg_517_1:RecordAudio("120021125", var_520_9)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_out_120021", "120021125", "story_v_out_120021.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_out_120021", "120021125", "story_v_out_120021.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_10 = math.max(var_520_1, arg_517_1.talkMaxDuration)

			if var_520_0 <= arg_517_1.time_ and arg_517_1.time_ < var_520_0 + var_520_10 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_0) / var_520_10

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_0 + var_520_10 and arg_517_1.time_ < var_520_0 + var_520_10 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play120021126 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 120021126
		arg_521_1.duration_ = 15.07

		local var_521_0 = {
			zh = 9.7,
			ja = 15.066
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play120021127(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0
			local var_524_1 = 0.95

			if var_524_0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				local var_524_2 = arg_521_1:FormatText(StoryNameCfg[381].name)

				arg_521_1.leftNameTxt_.text = var_524_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_3 = arg_521_1:GetWordFromCfg(120021126)
				local var_524_4 = arg_521_1:FormatText(var_524_3.content)

				arg_521_1.text_.text = var_524_4

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_5 = 38
				local var_524_6 = utf8.len(var_524_4)
				local var_524_7 = var_524_5 <= 0 and var_524_1 or var_524_1 * (var_524_6 / var_524_5)

				if var_524_7 > 0 and var_524_1 < var_524_7 then
					arg_521_1.talkMaxDuration = var_524_7

					if var_524_7 + var_524_0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_7 + var_524_0
					end
				end

				arg_521_1.text_.text = var_524_4
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021126", "story_v_out_120021.awb") ~= 0 then
					local var_524_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021126", "story_v_out_120021.awb") / 1000

					if var_524_8 + var_524_0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_8 + var_524_0
					end

					if var_524_3.prefab_name ~= "" and arg_521_1.actors_[var_524_3.prefab_name] ~= nil then
						local var_524_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_3.prefab_name].transform, "story_v_out_120021", "120021126", "story_v_out_120021.awb")

						arg_521_1:RecordAudio("120021126", var_524_9)
						arg_521_1:RecordAudio("120021126", var_524_9)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_out_120021", "120021126", "story_v_out_120021.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_out_120021", "120021126", "story_v_out_120021.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_10 = math.max(var_524_1, arg_521_1.talkMaxDuration)

			if var_524_0 <= arg_521_1.time_ and arg_521_1.time_ < var_524_0 + var_524_10 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_0) / var_524_10

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_0 + var_524_10 and arg_521_1.time_ < var_524_0 + var_524_10 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play120021127 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 120021127
		arg_525_1.duration_ = 15.43

		local var_525_0 = {
			zh = 9.8,
			ja = 15.433
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play120021128(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 0

			if var_528_0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_0 + arg_528_0 then
				arg_525_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_528_1 = 0

			if var_528_1 < arg_525_1.time_ and arg_525_1.time_ <= var_528_1 + arg_528_0 then
				arg_525_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action3_1")
			end

			local var_528_2 = 0
			local var_528_3 = 0.95

			if var_528_2 < arg_525_1.time_ and arg_525_1.time_ <= var_528_2 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				local var_528_4 = arg_525_1:FormatText(StoryNameCfg[381].name)

				arg_525_1.leftNameTxt_.text = var_528_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_5 = arg_525_1:GetWordFromCfg(120021127)
				local var_528_6 = arg_525_1:FormatText(var_528_5.content)

				arg_525_1.text_.text = var_528_6

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_7 = 38
				local var_528_8 = utf8.len(var_528_6)
				local var_528_9 = var_528_7 <= 0 and var_528_3 or var_528_3 * (var_528_8 / var_528_7)

				if var_528_9 > 0 and var_528_3 < var_528_9 then
					arg_525_1.talkMaxDuration = var_528_9

					if var_528_9 + var_528_2 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_9 + var_528_2
					end
				end

				arg_525_1.text_.text = var_528_6
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021127", "story_v_out_120021.awb") ~= 0 then
					local var_528_10 = manager.audio:GetVoiceLength("story_v_out_120021", "120021127", "story_v_out_120021.awb") / 1000

					if var_528_10 + var_528_2 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_10 + var_528_2
					end

					if var_528_5.prefab_name ~= "" and arg_525_1.actors_[var_528_5.prefab_name] ~= nil then
						local var_528_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_5.prefab_name].transform, "story_v_out_120021", "120021127", "story_v_out_120021.awb")

						arg_525_1:RecordAudio("120021127", var_528_11)
						arg_525_1:RecordAudio("120021127", var_528_11)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_out_120021", "120021127", "story_v_out_120021.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_out_120021", "120021127", "story_v_out_120021.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_12 = math.max(var_528_3, arg_525_1.talkMaxDuration)

			if var_528_2 <= arg_525_1.time_ and arg_525_1.time_ < var_528_2 + var_528_12 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_2) / var_528_12

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_2 + var_528_12 and arg_525_1.time_ < var_528_2 + var_528_12 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play120021128 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 120021128
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play120021129(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = arg_529_1.actors_["1075ui_story"]
			local var_532_1 = 0

			if var_532_1 < arg_529_1.time_ and arg_529_1.time_ <= var_532_1 + arg_532_0 and not isNil(var_532_0) and arg_529_1.var_.characterEffect1075ui_story == nil then
				arg_529_1.var_.characterEffect1075ui_story = var_532_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_2 = 0.2

			if var_532_1 <= arg_529_1.time_ and arg_529_1.time_ < var_532_1 + var_532_2 and not isNil(var_532_0) then
				local var_532_3 = (arg_529_1.time_ - var_532_1) / var_532_2

				if arg_529_1.var_.characterEffect1075ui_story and not isNil(var_532_0) then
					local var_532_4 = Mathf.Lerp(0, 0.5, var_532_3)

					arg_529_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_529_1.var_.characterEffect1075ui_story.fillRatio = var_532_4
				end
			end

			if arg_529_1.time_ >= var_532_1 + var_532_2 and arg_529_1.time_ < var_532_1 + var_532_2 + arg_532_0 and not isNil(var_532_0) and arg_529_1.var_.characterEffect1075ui_story then
				local var_532_5 = 0.5

				arg_529_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_529_1.var_.characterEffect1075ui_story.fillRatio = var_532_5
			end

			local var_532_6 = 0
			local var_532_7 = 0.6

			if var_532_6 < arg_529_1.time_ and arg_529_1.time_ <= var_532_6 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, false)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_8 = arg_529_1:GetWordFromCfg(120021128)
				local var_532_9 = arg_529_1:FormatText(var_532_8.content)

				arg_529_1.text_.text = var_532_9

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_10 = 24
				local var_532_11 = utf8.len(var_532_9)
				local var_532_12 = var_532_10 <= 0 and var_532_7 or var_532_7 * (var_532_11 / var_532_10)

				if var_532_12 > 0 and var_532_7 < var_532_12 then
					arg_529_1.talkMaxDuration = var_532_12

					if var_532_12 + var_532_6 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_12 + var_532_6
					end
				end

				arg_529_1.text_.text = var_532_9
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_13 = math.max(var_532_7, arg_529_1.talkMaxDuration)

			if var_532_6 <= arg_529_1.time_ and arg_529_1.time_ < var_532_6 + var_532_13 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_6) / var_532_13

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_6 + var_532_13 and arg_529_1.time_ < var_532_6 + var_532_13 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play120021129 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 120021129
		arg_533_1.duration_ = 5.53

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play120021130(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = arg_533_1.actors_["1075ui_story"].transform
			local var_536_1 = 0

			if var_536_1 < arg_533_1.time_ and arg_533_1.time_ <= var_536_1 + arg_536_0 then
				arg_533_1.var_.moveOldPos1075ui_story = var_536_0.localPosition
			end

			local var_536_2 = 0.001

			if var_536_1 <= arg_533_1.time_ and arg_533_1.time_ < var_536_1 + var_536_2 then
				local var_536_3 = (arg_533_1.time_ - var_536_1) / var_536_2
				local var_536_4 = Vector3.New(0, 100, 0)

				var_536_0.localPosition = Vector3.Lerp(arg_533_1.var_.moveOldPos1075ui_story, var_536_4, var_536_3)

				local var_536_5 = manager.ui.mainCamera.transform.position - var_536_0.position

				var_536_0.forward = Vector3.New(var_536_5.x, var_536_5.y, var_536_5.z)

				local var_536_6 = var_536_0.localEulerAngles

				var_536_6.z = 0
				var_536_6.x = 0
				var_536_0.localEulerAngles = var_536_6
			end

			if arg_533_1.time_ >= var_536_1 + var_536_2 and arg_533_1.time_ < var_536_1 + var_536_2 + arg_536_0 then
				var_536_0.localPosition = Vector3.New(0, 100, 0)

				local var_536_7 = manager.ui.mainCamera.transform.position - var_536_0.position

				var_536_0.forward = Vector3.New(var_536_7.x, var_536_7.y, var_536_7.z)

				local var_536_8 = var_536_0.localEulerAngles

				var_536_8.z = 0
				var_536_8.x = 0
				var_536_0.localEulerAngles = var_536_8
			end

			local var_536_9 = "1084ui_story"

			if arg_533_1.actors_[var_536_9] == nil then
				local var_536_10 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_536_10) then
					local var_536_11 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_533_1.stage_.transform)

					var_536_11.name = var_536_9
					var_536_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_533_1.actors_[var_536_9] = var_536_11

					local var_536_12 = var_536_11:GetComponentInChildren(typeof(CharacterEffect))

					var_536_12.enabled = true

					local var_536_13 = GameObjectTools.GetOrAddComponent(var_536_11, typeof(DynamicBoneHelper))

					if var_536_13 then
						var_536_13:EnableDynamicBone(false)
					end

					arg_533_1:ShowWeapon(var_536_12.transform, false)

					arg_533_1.var_[var_536_9 .. "Animator"] = var_536_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_533_1.var_[var_536_9 .. "Animator"].applyRootMotion = true
					arg_533_1.var_[var_536_9 .. "LipSync"] = var_536_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_536_14 = arg_533_1.actors_["1084ui_story"].transform
			local var_536_15 = 0

			if var_536_15 < arg_533_1.time_ and arg_533_1.time_ <= var_536_15 + arg_536_0 then
				arg_533_1.var_.moveOldPos1084ui_story = var_536_14.localPosition
			end

			local var_536_16 = 0.001

			if var_536_15 <= arg_533_1.time_ and arg_533_1.time_ < var_536_15 + var_536_16 then
				local var_536_17 = (arg_533_1.time_ - var_536_15) / var_536_16
				local var_536_18 = Vector3.New(0, -0.97, -6)

				var_536_14.localPosition = Vector3.Lerp(arg_533_1.var_.moveOldPos1084ui_story, var_536_18, var_536_17)

				local var_536_19 = manager.ui.mainCamera.transform.position - var_536_14.position

				var_536_14.forward = Vector3.New(var_536_19.x, var_536_19.y, var_536_19.z)

				local var_536_20 = var_536_14.localEulerAngles

				var_536_20.z = 0
				var_536_20.x = 0
				var_536_14.localEulerAngles = var_536_20
			end

			if arg_533_1.time_ >= var_536_15 + var_536_16 and arg_533_1.time_ < var_536_15 + var_536_16 + arg_536_0 then
				var_536_14.localPosition = Vector3.New(0, -0.97, -6)

				local var_536_21 = manager.ui.mainCamera.transform.position - var_536_14.position

				var_536_14.forward = Vector3.New(var_536_21.x, var_536_21.y, var_536_21.z)

				local var_536_22 = var_536_14.localEulerAngles

				var_536_22.z = 0
				var_536_22.x = 0
				var_536_14.localEulerAngles = var_536_22
			end

			local var_536_23 = arg_533_1.actors_["1084ui_story"]
			local var_536_24 = 0

			if var_536_24 < arg_533_1.time_ and arg_533_1.time_ <= var_536_24 + arg_536_0 and not isNil(var_536_23) and arg_533_1.var_.characterEffect1084ui_story == nil then
				arg_533_1.var_.characterEffect1084ui_story = var_536_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_536_25 = 0.2

			if var_536_24 <= arg_533_1.time_ and arg_533_1.time_ < var_536_24 + var_536_25 and not isNil(var_536_23) then
				local var_536_26 = (arg_533_1.time_ - var_536_24) / var_536_25

				if arg_533_1.var_.characterEffect1084ui_story and not isNil(var_536_23) then
					arg_533_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_533_1.time_ >= var_536_24 + var_536_25 and arg_533_1.time_ < var_536_24 + var_536_25 + arg_536_0 and not isNil(var_536_23) and arg_533_1.var_.characterEffect1084ui_story then
				arg_533_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_536_27 = 0

			if var_536_27 < arg_533_1.time_ and arg_533_1.time_ <= var_536_27 + arg_536_0 then
				arg_533_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_536_28 = 0

			if var_536_28 < arg_533_1.time_ and arg_533_1.time_ <= var_536_28 + arg_536_0 then
				arg_533_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_536_29 = 0
			local var_536_30 = 0.65

			if var_536_29 < arg_533_1.time_ and arg_533_1.time_ <= var_536_29 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				local var_536_31 = arg_533_1:FormatText(StoryNameCfg[6].name)

				arg_533_1.leftNameTxt_.text = var_536_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_32 = arg_533_1:GetWordFromCfg(120021129)
				local var_536_33 = arg_533_1:FormatText(var_536_32.content)

				arg_533_1.text_.text = var_536_33

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_34 = 26
				local var_536_35 = utf8.len(var_536_33)
				local var_536_36 = var_536_34 <= 0 and var_536_30 or var_536_30 * (var_536_35 / var_536_34)

				if var_536_36 > 0 and var_536_30 < var_536_36 then
					arg_533_1.talkMaxDuration = var_536_36

					if var_536_36 + var_536_29 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_36 + var_536_29
					end
				end

				arg_533_1.text_.text = var_536_33
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021129", "story_v_out_120021.awb") ~= 0 then
					local var_536_37 = manager.audio:GetVoiceLength("story_v_out_120021", "120021129", "story_v_out_120021.awb") / 1000

					if var_536_37 + var_536_29 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_37 + var_536_29
					end

					if var_536_32.prefab_name ~= "" and arg_533_1.actors_[var_536_32.prefab_name] ~= nil then
						local var_536_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_32.prefab_name].transform, "story_v_out_120021", "120021129", "story_v_out_120021.awb")

						arg_533_1:RecordAudio("120021129", var_536_38)
						arg_533_1:RecordAudio("120021129", var_536_38)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_out_120021", "120021129", "story_v_out_120021.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_out_120021", "120021129", "story_v_out_120021.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_39 = math.max(var_536_30, arg_533_1.talkMaxDuration)

			if var_536_29 <= arg_533_1.time_ and arg_533_1.time_ < var_536_29 + var_536_39 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_29) / var_536_39

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_29 + var_536_39 and arg_533_1.time_ < var_536_29 + var_536_39 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_533_1:InitPlayNodeList()
	end,
	Play120021130 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 120021130
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play120021131(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = arg_537_1.actors_["1084ui_story"]
			local var_540_1 = 0

			if var_540_1 < arg_537_1.time_ and arg_537_1.time_ <= var_540_1 + arg_540_0 and not isNil(var_540_0) and arg_537_1.var_.characterEffect1084ui_story == nil then
				arg_537_1.var_.characterEffect1084ui_story = var_540_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_540_2 = 0.2

			if var_540_1 <= arg_537_1.time_ and arg_537_1.time_ < var_540_1 + var_540_2 and not isNil(var_540_0) then
				local var_540_3 = (arg_537_1.time_ - var_540_1) / var_540_2

				if arg_537_1.var_.characterEffect1084ui_story and not isNil(var_540_0) then
					local var_540_4 = Mathf.Lerp(0, 0.5, var_540_3)

					arg_537_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_537_1.var_.characterEffect1084ui_story.fillRatio = var_540_4
				end
			end

			if arg_537_1.time_ >= var_540_1 + var_540_2 and arg_537_1.time_ < var_540_1 + var_540_2 + arg_540_0 and not isNil(var_540_0) and arg_537_1.var_.characterEffect1084ui_story then
				local var_540_5 = 0.5

				arg_537_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_537_1.var_.characterEffect1084ui_story.fillRatio = var_540_5
			end

			local var_540_6 = 0
			local var_540_7 = 0.525

			if var_540_6 < arg_537_1.time_ and arg_537_1.time_ <= var_540_6 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				local var_540_8 = arg_537_1:FormatText(StoryNameCfg[7].name)

				arg_537_1.leftNameTxt_.text = var_540_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, true)
				arg_537_1.iconController_:SetSelectedState("hero")

				arg_537_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_537_1.callingController_:SetSelectedState("normal")

				arg_537_1.keyicon_.color = Color.New(1, 1, 1)
				arg_537_1.icon_.color = Color.New(1, 1, 1)

				local var_540_9 = arg_537_1:GetWordFromCfg(120021130)
				local var_540_10 = arg_537_1:FormatText(var_540_9.content)

				arg_537_1.text_.text = var_540_10

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_11 = 21
				local var_540_12 = utf8.len(var_540_10)
				local var_540_13 = var_540_11 <= 0 and var_540_7 or var_540_7 * (var_540_12 / var_540_11)

				if var_540_13 > 0 and var_540_7 < var_540_13 then
					arg_537_1.talkMaxDuration = var_540_13

					if var_540_13 + var_540_6 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_13 + var_540_6
					end
				end

				arg_537_1.text_.text = var_540_10
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_14 = math.max(var_540_7, arg_537_1.talkMaxDuration)

			if var_540_6 <= arg_537_1.time_ and arg_537_1.time_ < var_540_6 + var_540_14 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_6) / var_540_14

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_6 + var_540_14 and arg_537_1.time_ < var_540_6 + var_540_14 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play120021131 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 120021131
		arg_541_1.duration_ = 9.57

		local var_541_0 = {
			zh = 8.366,
			ja = 9.566
		}
		local var_541_1 = manager.audio:GetLocalizationFlag()

		if var_541_0[var_541_1] ~= nil then
			arg_541_1.duration_ = var_541_0[var_541_1]
		end

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play120021132(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = arg_541_1.actors_["1075ui_story"]
			local var_544_1 = 0

			if var_544_1 < arg_541_1.time_ and arg_541_1.time_ <= var_544_1 + arg_544_0 and not isNil(var_544_0) and arg_541_1.var_.characterEffect1075ui_story == nil then
				arg_541_1.var_.characterEffect1075ui_story = var_544_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_544_2 = 0.2

			if var_544_1 <= arg_541_1.time_ and arg_541_1.time_ < var_544_1 + var_544_2 and not isNil(var_544_0) then
				local var_544_3 = (arg_541_1.time_ - var_544_1) / var_544_2

				if arg_541_1.var_.characterEffect1075ui_story and not isNil(var_544_0) then
					arg_541_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_541_1.time_ >= var_544_1 + var_544_2 and arg_541_1.time_ < var_544_1 + var_544_2 + arg_544_0 and not isNil(var_544_0) and arg_541_1.var_.characterEffect1075ui_story then
				arg_541_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_544_4 = 0

			if var_544_4 < arg_541_1.time_ and arg_541_1.time_ <= var_544_4 + arg_544_0 then
				arg_541_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_544_5 = 0

			if var_544_5 < arg_541_1.time_ and arg_541_1.time_ <= var_544_5 + arg_544_0 then
				arg_541_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_544_6 = arg_541_1.actors_["1084ui_story"].transform
			local var_544_7 = 0

			if var_544_7 < arg_541_1.time_ and arg_541_1.time_ <= var_544_7 + arg_544_0 then
				arg_541_1.var_.moveOldPos1084ui_story = var_544_6.localPosition
			end

			local var_544_8 = 0.001

			if var_544_7 <= arg_541_1.time_ and arg_541_1.time_ < var_544_7 + var_544_8 then
				local var_544_9 = (arg_541_1.time_ - var_544_7) / var_544_8
				local var_544_10 = Vector3.New(0, 100, 0)

				var_544_6.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos1084ui_story, var_544_10, var_544_9)

				local var_544_11 = manager.ui.mainCamera.transform.position - var_544_6.position

				var_544_6.forward = Vector3.New(var_544_11.x, var_544_11.y, var_544_11.z)

				local var_544_12 = var_544_6.localEulerAngles

				var_544_12.z = 0
				var_544_12.x = 0
				var_544_6.localEulerAngles = var_544_12
			end

			if arg_541_1.time_ >= var_544_7 + var_544_8 and arg_541_1.time_ < var_544_7 + var_544_8 + arg_544_0 then
				var_544_6.localPosition = Vector3.New(0, 100, 0)

				local var_544_13 = manager.ui.mainCamera.transform.position - var_544_6.position

				var_544_6.forward = Vector3.New(var_544_13.x, var_544_13.y, var_544_13.z)

				local var_544_14 = var_544_6.localEulerAngles

				var_544_14.z = 0
				var_544_14.x = 0
				var_544_6.localEulerAngles = var_544_14
			end

			local var_544_15 = arg_541_1.actors_["1075ui_story"].transform
			local var_544_16 = 0

			if var_544_16 < arg_541_1.time_ and arg_541_1.time_ <= var_544_16 + arg_544_0 then
				arg_541_1.var_.moveOldPos1075ui_story = var_544_15.localPosition
			end

			local var_544_17 = 0.001

			if var_544_16 <= arg_541_1.time_ and arg_541_1.time_ < var_544_16 + var_544_17 then
				local var_544_18 = (arg_541_1.time_ - var_544_16) / var_544_17
				local var_544_19 = Vector3.New(0, -1.055, -6.16)

				var_544_15.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos1075ui_story, var_544_19, var_544_18)

				local var_544_20 = manager.ui.mainCamera.transform.position - var_544_15.position

				var_544_15.forward = Vector3.New(var_544_20.x, var_544_20.y, var_544_20.z)

				local var_544_21 = var_544_15.localEulerAngles

				var_544_21.z = 0
				var_544_21.x = 0
				var_544_15.localEulerAngles = var_544_21
			end

			if arg_541_1.time_ >= var_544_16 + var_544_17 and arg_541_1.time_ < var_544_16 + var_544_17 + arg_544_0 then
				var_544_15.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_544_22 = manager.ui.mainCamera.transform.position - var_544_15.position

				var_544_15.forward = Vector3.New(var_544_22.x, var_544_22.y, var_544_22.z)

				local var_544_23 = var_544_15.localEulerAngles

				var_544_23.z = 0
				var_544_23.x = 0
				var_544_15.localEulerAngles = var_544_23
			end

			local var_544_24 = 0
			local var_544_25 = 0.925

			if var_544_24 < arg_541_1.time_ and arg_541_1.time_ <= var_544_24 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				local var_544_26 = arg_541_1:FormatText(StoryNameCfg[381].name)

				arg_541_1.leftNameTxt_.text = var_544_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_27 = arg_541_1:GetWordFromCfg(120021131)
				local var_544_28 = arg_541_1:FormatText(var_544_27.content)

				arg_541_1.text_.text = var_544_28

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_29 = 37
				local var_544_30 = utf8.len(var_544_28)
				local var_544_31 = var_544_29 <= 0 and var_544_25 or var_544_25 * (var_544_30 / var_544_29)

				if var_544_31 > 0 and var_544_25 < var_544_31 then
					arg_541_1.talkMaxDuration = var_544_31

					if var_544_31 + var_544_24 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_31 + var_544_24
					end
				end

				arg_541_1.text_.text = var_544_28
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021131", "story_v_out_120021.awb") ~= 0 then
					local var_544_32 = manager.audio:GetVoiceLength("story_v_out_120021", "120021131", "story_v_out_120021.awb") / 1000

					if var_544_32 + var_544_24 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_32 + var_544_24
					end

					if var_544_27.prefab_name ~= "" and arg_541_1.actors_[var_544_27.prefab_name] ~= nil then
						local var_544_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_27.prefab_name].transform, "story_v_out_120021", "120021131", "story_v_out_120021.awb")

						arg_541_1:RecordAudio("120021131", var_544_33)
						arg_541_1:RecordAudio("120021131", var_544_33)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_out_120021", "120021131", "story_v_out_120021.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_out_120021", "120021131", "story_v_out_120021.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_34 = math.max(var_544_25, arg_541_1.talkMaxDuration)

			if var_544_24 <= arg_541_1.time_ and arg_541_1.time_ < var_544_24 + var_544_34 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_24) / var_544_34

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_24 + var_544_34 and arg_541_1.time_ < var_544_24 + var_544_34 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {
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
			}
		}

		arg_541_1:InitPlayNodeList()
	end,
	Play120021132 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 120021132
		arg_545_1.duration_ = 16.2

		local var_545_0 = {
			zh = 9.866,
			ja = 16.2
		}
		local var_545_1 = manager.audio:GetLocalizationFlag()

		if var_545_0[var_545_1] ~= nil then
			arg_545_1.duration_ = var_545_0[var_545_1]
		end

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play120021133(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = 0
			local var_548_1 = 1.125

			if var_548_0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_0 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				local var_548_2 = arg_545_1:FormatText(StoryNameCfg[381].name)

				arg_545_1.leftNameTxt_.text = var_548_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_3 = arg_545_1:GetWordFromCfg(120021132)
				local var_548_4 = arg_545_1:FormatText(var_548_3.content)

				arg_545_1.text_.text = var_548_4

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_5 = 45
				local var_548_6 = utf8.len(var_548_4)
				local var_548_7 = var_548_5 <= 0 and var_548_1 or var_548_1 * (var_548_6 / var_548_5)

				if var_548_7 > 0 and var_548_1 < var_548_7 then
					arg_545_1.talkMaxDuration = var_548_7

					if var_548_7 + var_548_0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_7 + var_548_0
					end
				end

				arg_545_1.text_.text = var_548_4
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021132", "story_v_out_120021.awb") ~= 0 then
					local var_548_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021132", "story_v_out_120021.awb") / 1000

					if var_548_8 + var_548_0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_8 + var_548_0
					end

					if var_548_3.prefab_name ~= "" and arg_545_1.actors_[var_548_3.prefab_name] ~= nil then
						local var_548_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_3.prefab_name].transform, "story_v_out_120021", "120021132", "story_v_out_120021.awb")

						arg_545_1:RecordAudio("120021132", var_548_9)
						arg_545_1:RecordAudio("120021132", var_548_9)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_out_120021", "120021132", "story_v_out_120021.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_out_120021", "120021132", "story_v_out_120021.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_10 = math.max(var_548_1, arg_545_1.talkMaxDuration)

			if var_548_0 <= arg_545_1.time_ and arg_545_1.time_ < var_548_0 + var_548_10 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_0) / var_548_10

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_0 + var_548_10 and arg_545_1.time_ < var_548_0 + var_548_10 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play120021133 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 120021133
		arg_549_1.duration_ = 9.5

		local var_549_0 = {
			zh = 9.5,
			ja = 8.433
		}
		local var_549_1 = manager.audio:GetLocalizationFlag()

		if var_549_0[var_549_1] ~= nil then
			arg_549_1.duration_ = var_549_0[var_549_1]
		end

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play120021134(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0
			local var_552_1 = 1.2

			if var_552_0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				local var_552_2 = arg_549_1:FormatText(StoryNameCfg[381].name)

				arg_549_1.leftNameTxt_.text = var_552_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_3 = arg_549_1:GetWordFromCfg(120021133)
				local var_552_4 = arg_549_1:FormatText(var_552_3.content)

				arg_549_1.text_.text = var_552_4

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_5 = 48
				local var_552_6 = utf8.len(var_552_4)
				local var_552_7 = var_552_5 <= 0 and var_552_1 or var_552_1 * (var_552_6 / var_552_5)

				if var_552_7 > 0 and var_552_1 < var_552_7 then
					arg_549_1.talkMaxDuration = var_552_7

					if var_552_7 + var_552_0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_7 + var_552_0
					end
				end

				arg_549_1.text_.text = var_552_4
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021133", "story_v_out_120021.awb") ~= 0 then
					local var_552_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021133", "story_v_out_120021.awb") / 1000

					if var_552_8 + var_552_0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_8 + var_552_0
					end

					if var_552_3.prefab_name ~= "" and arg_549_1.actors_[var_552_3.prefab_name] ~= nil then
						local var_552_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_3.prefab_name].transform, "story_v_out_120021", "120021133", "story_v_out_120021.awb")

						arg_549_1:RecordAudio("120021133", var_552_9)
						arg_549_1:RecordAudio("120021133", var_552_9)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_out_120021", "120021133", "story_v_out_120021.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_out_120021", "120021133", "story_v_out_120021.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_10 = math.max(var_552_1, arg_549_1.talkMaxDuration)

			if var_552_0 <= arg_549_1.time_ and arg_549_1.time_ < var_552_0 + var_552_10 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_0) / var_552_10

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_0 + var_552_10 and arg_549_1.time_ < var_552_0 + var_552_10 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play120021134 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 120021134
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play120021135(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = arg_553_1.actors_["1075ui_story"]
			local var_556_1 = 0

			if var_556_1 < arg_553_1.time_ and arg_553_1.time_ <= var_556_1 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.characterEffect1075ui_story == nil then
				arg_553_1.var_.characterEffect1075ui_story = var_556_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_2 = 0.2

			if var_556_1 <= arg_553_1.time_ and arg_553_1.time_ < var_556_1 + var_556_2 and not isNil(var_556_0) then
				local var_556_3 = (arg_553_1.time_ - var_556_1) / var_556_2

				if arg_553_1.var_.characterEffect1075ui_story and not isNil(var_556_0) then
					local var_556_4 = Mathf.Lerp(0, 0.5, var_556_3)

					arg_553_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_553_1.var_.characterEffect1075ui_story.fillRatio = var_556_4
				end
			end

			if arg_553_1.time_ >= var_556_1 + var_556_2 and arg_553_1.time_ < var_556_1 + var_556_2 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.characterEffect1075ui_story then
				local var_556_5 = 0.5

				arg_553_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_553_1.var_.characterEffect1075ui_story.fillRatio = var_556_5
			end

			local var_556_6 = 0
			local var_556_7 = 0.175

			if var_556_6 < arg_553_1.time_ and arg_553_1.time_ <= var_556_6 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				local var_556_8 = arg_553_1:FormatText(StoryNameCfg[7].name)

				arg_553_1.leftNameTxt_.text = var_556_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, true)
				arg_553_1.iconController_:SetSelectedState("hero")

				arg_553_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_553_1.callingController_:SetSelectedState("normal")

				arg_553_1.keyicon_.color = Color.New(1, 1, 1)
				arg_553_1.icon_.color = Color.New(1, 1, 1)

				local var_556_9 = arg_553_1:GetWordFromCfg(120021134)
				local var_556_10 = arg_553_1:FormatText(var_556_9.content)

				arg_553_1.text_.text = var_556_10

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_11 = 7
				local var_556_12 = utf8.len(var_556_10)
				local var_556_13 = var_556_11 <= 0 and var_556_7 or var_556_7 * (var_556_12 / var_556_11)

				if var_556_13 > 0 and var_556_7 < var_556_13 then
					arg_553_1.talkMaxDuration = var_556_13

					if var_556_13 + var_556_6 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_13 + var_556_6
					end
				end

				arg_553_1.text_.text = var_556_10
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_14 = math.max(var_556_7, arg_553_1.talkMaxDuration)

			if var_556_6 <= arg_553_1.time_ and arg_553_1.time_ < var_556_6 + var_556_14 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_6) / var_556_14

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_6 + var_556_14 and arg_553_1.time_ < var_556_6 + var_556_14 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play120021135 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 120021135
		arg_557_1.duration_ = 11.3

		local var_557_0 = {
			zh = 8.3,
			ja = 11.3
		}
		local var_557_1 = manager.audio:GetLocalizationFlag()

		if var_557_0[var_557_1] ~= nil then
			arg_557_1.duration_ = var_557_0[var_557_1]
		end

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play120021136(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = arg_557_1.actors_["1075ui_story"]
			local var_560_1 = 0

			if var_560_1 < arg_557_1.time_ and arg_557_1.time_ <= var_560_1 + arg_560_0 and not isNil(var_560_0) and arg_557_1.var_.characterEffect1075ui_story == nil then
				arg_557_1.var_.characterEffect1075ui_story = var_560_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_560_2 = 0.2

			if var_560_1 <= arg_557_1.time_ and arg_557_1.time_ < var_560_1 + var_560_2 and not isNil(var_560_0) then
				local var_560_3 = (arg_557_1.time_ - var_560_1) / var_560_2

				if arg_557_1.var_.characterEffect1075ui_story and not isNil(var_560_0) then
					arg_557_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_557_1.time_ >= var_560_1 + var_560_2 and arg_557_1.time_ < var_560_1 + var_560_2 + arg_560_0 and not isNil(var_560_0) and arg_557_1.var_.characterEffect1075ui_story then
				arg_557_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_560_4 = 0

			if var_560_4 < arg_557_1.time_ and arg_557_1.time_ <= var_560_4 + arg_560_0 then
				arg_557_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_560_5 = 0
			local var_560_6 = 0.875

			if var_560_5 < arg_557_1.time_ and arg_557_1.time_ <= var_560_5 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				local var_560_7 = arg_557_1:FormatText(StoryNameCfg[381].name)

				arg_557_1.leftNameTxt_.text = var_560_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_8 = arg_557_1:GetWordFromCfg(120021135)
				local var_560_9 = arg_557_1:FormatText(var_560_8.content)

				arg_557_1.text_.text = var_560_9

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_10 = 35
				local var_560_11 = utf8.len(var_560_9)
				local var_560_12 = var_560_10 <= 0 and var_560_6 or var_560_6 * (var_560_11 / var_560_10)

				if var_560_12 > 0 and var_560_6 < var_560_12 then
					arg_557_1.talkMaxDuration = var_560_12

					if var_560_12 + var_560_5 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_12 + var_560_5
					end
				end

				arg_557_1.text_.text = var_560_9
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021135", "story_v_out_120021.awb") ~= 0 then
					local var_560_13 = manager.audio:GetVoiceLength("story_v_out_120021", "120021135", "story_v_out_120021.awb") / 1000

					if var_560_13 + var_560_5 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_13 + var_560_5
					end

					if var_560_8.prefab_name ~= "" and arg_557_1.actors_[var_560_8.prefab_name] ~= nil then
						local var_560_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_8.prefab_name].transform, "story_v_out_120021", "120021135", "story_v_out_120021.awb")

						arg_557_1:RecordAudio("120021135", var_560_14)
						arg_557_1:RecordAudio("120021135", var_560_14)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_out_120021", "120021135", "story_v_out_120021.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_out_120021", "120021135", "story_v_out_120021.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_15 = math.max(var_560_6, arg_557_1.talkMaxDuration)

			if var_560_5 <= arg_557_1.time_ and arg_557_1.time_ < var_560_5 + var_560_15 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_5) / var_560_15

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_5 + var_560_15 and arg_557_1.time_ < var_560_5 + var_560_15 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play120021136 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 120021136
		arg_561_1.duration_ = 5

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play120021137(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = arg_561_1.actors_["1075ui_story"]
			local var_564_1 = 0

			if var_564_1 < arg_561_1.time_ and arg_561_1.time_ <= var_564_1 + arg_564_0 and not isNil(var_564_0) and arg_561_1.var_.characterEffect1075ui_story == nil then
				arg_561_1.var_.characterEffect1075ui_story = var_564_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_2 = 0.2

			if var_564_1 <= arg_561_1.time_ and arg_561_1.time_ < var_564_1 + var_564_2 and not isNil(var_564_0) then
				local var_564_3 = (arg_561_1.time_ - var_564_1) / var_564_2

				if arg_561_1.var_.characterEffect1075ui_story and not isNil(var_564_0) then
					local var_564_4 = Mathf.Lerp(0, 0.5, var_564_3)

					arg_561_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_561_1.var_.characterEffect1075ui_story.fillRatio = var_564_4
				end
			end

			if arg_561_1.time_ >= var_564_1 + var_564_2 and arg_561_1.time_ < var_564_1 + var_564_2 + arg_564_0 and not isNil(var_564_0) and arg_561_1.var_.characterEffect1075ui_story then
				local var_564_5 = 0.5

				arg_561_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_561_1.var_.characterEffect1075ui_story.fillRatio = var_564_5
			end

			local var_564_6 = 0
			local var_564_7 = 0.75

			if var_564_6 < arg_561_1.time_ and arg_561_1.time_ <= var_564_6 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				local var_564_8 = arg_561_1:FormatText(StoryNameCfg[7].name)

				arg_561_1.leftNameTxt_.text = var_564_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, true)
				arg_561_1.iconController_:SetSelectedState("hero")

				arg_561_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_561_1.callingController_:SetSelectedState("normal")

				arg_561_1.keyicon_.color = Color.New(1, 1, 1)
				arg_561_1.icon_.color = Color.New(1, 1, 1)

				local var_564_9 = arg_561_1:GetWordFromCfg(120021136)
				local var_564_10 = arg_561_1:FormatText(var_564_9.content)

				arg_561_1.text_.text = var_564_10

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_11 = 30
				local var_564_12 = utf8.len(var_564_10)
				local var_564_13 = var_564_11 <= 0 and var_564_7 or var_564_7 * (var_564_12 / var_564_11)

				if var_564_13 > 0 and var_564_7 < var_564_13 then
					arg_561_1.talkMaxDuration = var_564_13

					if var_564_13 + var_564_6 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_13 + var_564_6
					end
				end

				arg_561_1.text_.text = var_564_10
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_14 = math.max(var_564_7, arg_561_1.talkMaxDuration)

			if var_564_6 <= arg_561_1.time_ and arg_561_1.time_ < var_564_6 + var_564_14 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_6) / var_564_14

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_6 + var_564_14 and arg_561_1.time_ < var_564_6 + var_564_14 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play120021137 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 120021137
		arg_565_1.duration_ = 5

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play120021138(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = 0
			local var_568_1 = 0.275

			if var_568_0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_0 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				local var_568_2 = arg_565_1:FormatText(StoryNameCfg[7].name)

				arg_565_1.leftNameTxt_.text = var_568_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, true)
				arg_565_1.iconController_:SetSelectedState("hero")

				arg_565_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_565_1.callingController_:SetSelectedState("normal")

				arg_565_1.keyicon_.color = Color.New(1, 1, 1)
				arg_565_1.icon_.color = Color.New(1, 1, 1)

				local var_568_3 = arg_565_1:GetWordFromCfg(120021137)
				local var_568_4 = arg_565_1:FormatText(var_568_3.content)

				arg_565_1.text_.text = var_568_4

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_5 = 11
				local var_568_6 = utf8.len(var_568_4)
				local var_568_7 = var_568_5 <= 0 and var_568_1 or var_568_1 * (var_568_6 / var_568_5)

				if var_568_7 > 0 and var_568_1 < var_568_7 then
					arg_565_1.talkMaxDuration = var_568_7

					if var_568_7 + var_568_0 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_7 + var_568_0
					end
				end

				arg_565_1.text_.text = var_568_4
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)
				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_8 = math.max(var_568_1, arg_565_1.talkMaxDuration)

			if var_568_0 <= arg_565_1.time_ and arg_565_1.time_ < var_568_0 + var_568_8 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_0) / var_568_8

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_0 + var_568_8 and arg_565_1.time_ < var_568_0 + var_568_8 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play120021138 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 120021138
		arg_569_1.duration_ = 5

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play120021139(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = 0
			local var_572_1 = 0.425

			if var_572_0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_0 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, false)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_2 = arg_569_1:GetWordFromCfg(120021138)
				local var_572_3 = arg_569_1:FormatText(var_572_2.content)

				arg_569_1.text_.text = var_572_3

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_4 = 17
				local var_572_5 = utf8.len(var_572_3)
				local var_572_6 = var_572_4 <= 0 and var_572_1 or var_572_1 * (var_572_5 / var_572_4)

				if var_572_6 > 0 and var_572_1 < var_572_6 then
					arg_569_1.talkMaxDuration = var_572_6

					if var_572_6 + var_572_0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_6 + var_572_0
					end
				end

				arg_569_1.text_.text = var_572_3
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)
				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_7 = math.max(var_572_1, arg_569_1.talkMaxDuration)

			if var_572_0 <= arg_569_1.time_ and arg_569_1.time_ < var_572_0 + var_572_7 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_0) / var_572_7

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_0 + var_572_7 and arg_569_1.time_ < var_572_0 + var_572_7 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play120021139 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 120021139
		arg_573_1.duration_ = 3.63

		local var_573_0 = {
			zh = 2.6,
			ja = 3.633
		}
		local var_573_1 = manager.audio:GetLocalizationFlag()

		if var_573_0[var_573_1] ~= nil then
			arg_573_1.duration_ = var_573_0[var_573_1]
		end

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play120021140(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			local var_576_0 = arg_573_1.actors_["1075ui_story"]
			local var_576_1 = 0

			if var_576_1 < arg_573_1.time_ and arg_573_1.time_ <= var_576_1 + arg_576_0 and not isNil(var_576_0) and arg_573_1.var_.characterEffect1075ui_story == nil then
				arg_573_1.var_.characterEffect1075ui_story = var_576_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_576_2 = 0.2

			if var_576_1 <= arg_573_1.time_ and arg_573_1.time_ < var_576_1 + var_576_2 and not isNil(var_576_0) then
				local var_576_3 = (arg_573_1.time_ - var_576_1) / var_576_2

				if arg_573_1.var_.characterEffect1075ui_story and not isNil(var_576_0) then
					arg_573_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_573_1.time_ >= var_576_1 + var_576_2 and arg_573_1.time_ < var_576_1 + var_576_2 + arg_576_0 and not isNil(var_576_0) and arg_573_1.var_.characterEffect1075ui_story then
				arg_573_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_576_4 = 0

			if var_576_4 < arg_573_1.time_ and arg_573_1.time_ <= var_576_4 + arg_576_0 then
				arg_573_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_576_5 = 0
			local var_576_6 = 0.325

			if var_576_5 < arg_573_1.time_ and arg_573_1.time_ <= var_576_5 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				local var_576_7 = arg_573_1:FormatText(StoryNameCfg[381].name)

				arg_573_1.leftNameTxt_.text = var_576_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_8 = arg_573_1:GetWordFromCfg(120021139)
				local var_576_9 = arg_573_1:FormatText(var_576_8.content)

				arg_573_1.text_.text = var_576_9

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_10 = 13
				local var_576_11 = utf8.len(var_576_9)
				local var_576_12 = var_576_10 <= 0 and var_576_6 or var_576_6 * (var_576_11 / var_576_10)

				if var_576_12 > 0 and var_576_6 < var_576_12 then
					arg_573_1.talkMaxDuration = var_576_12

					if var_576_12 + var_576_5 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_12 + var_576_5
					end
				end

				arg_573_1.text_.text = var_576_9
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021139", "story_v_out_120021.awb") ~= 0 then
					local var_576_13 = manager.audio:GetVoiceLength("story_v_out_120021", "120021139", "story_v_out_120021.awb") / 1000

					if var_576_13 + var_576_5 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_13 + var_576_5
					end

					if var_576_8.prefab_name ~= "" and arg_573_1.actors_[var_576_8.prefab_name] ~= nil then
						local var_576_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_573_1.actors_[var_576_8.prefab_name].transform, "story_v_out_120021", "120021139", "story_v_out_120021.awb")

						arg_573_1:RecordAudio("120021139", var_576_14)
						arg_573_1:RecordAudio("120021139", var_576_14)
					else
						arg_573_1:AudioAction("play", "voice", "story_v_out_120021", "120021139", "story_v_out_120021.awb")
					end

					arg_573_1:RecordHistoryTalkVoice("story_v_out_120021", "120021139", "story_v_out_120021.awb")
				end

				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_15 = math.max(var_576_6, arg_573_1.talkMaxDuration)

			if var_576_5 <= arg_573_1.time_ and arg_573_1.time_ < var_576_5 + var_576_15 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_5) / var_576_15

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_5 + var_576_15 and arg_573_1.time_ < var_576_5 + var_576_15 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play120021140 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 120021140
		arg_577_1.duration_ = 5

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play120021141(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			local var_580_0 = arg_577_1.actors_["1075ui_story"]
			local var_580_1 = 0

			if var_580_1 < arg_577_1.time_ and arg_577_1.time_ <= var_580_1 + arg_580_0 and not isNil(var_580_0) and arg_577_1.var_.characterEffect1075ui_story == nil then
				arg_577_1.var_.characterEffect1075ui_story = var_580_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_580_2 = 0.2

			if var_580_1 <= arg_577_1.time_ and arg_577_1.time_ < var_580_1 + var_580_2 and not isNil(var_580_0) then
				local var_580_3 = (arg_577_1.time_ - var_580_1) / var_580_2

				if arg_577_1.var_.characterEffect1075ui_story and not isNil(var_580_0) then
					local var_580_4 = Mathf.Lerp(0, 0.5, var_580_3)

					arg_577_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_577_1.var_.characterEffect1075ui_story.fillRatio = var_580_4
				end
			end

			if arg_577_1.time_ >= var_580_1 + var_580_2 and arg_577_1.time_ < var_580_1 + var_580_2 + arg_580_0 and not isNil(var_580_0) and arg_577_1.var_.characterEffect1075ui_story then
				local var_580_5 = 0.5

				arg_577_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_577_1.var_.characterEffect1075ui_story.fillRatio = var_580_5
			end

			local var_580_6 = 0
			local var_580_7 = 0.625

			if var_580_6 < arg_577_1.time_ and arg_577_1.time_ <= var_580_6 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, true)

				local var_580_8 = arg_577_1:FormatText(StoryNameCfg[7].name)

				arg_577_1.leftNameTxt_.text = var_580_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, true)
				arg_577_1.iconController_:SetSelectedState("hero")

				arg_577_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_577_1.callingController_:SetSelectedState("normal")

				arg_577_1.keyicon_.color = Color.New(1, 1, 1)
				arg_577_1.icon_.color = Color.New(1, 1, 1)

				local var_580_9 = arg_577_1:GetWordFromCfg(120021140)
				local var_580_10 = arg_577_1:FormatText(var_580_9.content)

				arg_577_1.text_.text = var_580_10

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_11 = 25
				local var_580_12 = utf8.len(var_580_10)
				local var_580_13 = var_580_11 <= 0 and var_580_7 or var_580_7 * (var_580_12 / var_580_11)

				if var_580_13 > 0 and var_580_7 < var_580_13 then
					arg_577_1.talkMaxDuration = var_580_13

					if var_580_13 + var_580_6 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_13 + var_580_6
					end
				end

				arg_577_1.text_.text = var_580_10
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_14 = math.max(var_580_7, arg_577_1.talkMaxDuration)

			if var_580_6 <= arg_577_1.time_ and arg_577_1.time_ < var_580_6 + var_580_14 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_6) / var_580_14

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_6 + var_580_14 and arg_577_1.time_ < var_580_6 + var_580_14 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play120021141 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 120021141
		arg_581_1.duration_ = 5

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play120021142(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			local var_584_0 = 0
			local var_584_1 = 1

			if var_584_0 < arg_581_1.time_ and arg_581_1.time_ <= var_584_0 + arg_584_0 then
				local var_584_2 = "play"
				local var_584_3 = "effect"

				arg_581_1:AudioAction(var_584_2, var_584_3, "se_story_10", "se_story_10_UI", "")
			end

			local var_584_4 = 0
			local var_584_5 = 0.875

			if var_584_4 < arg_581_1.time_ and arg_581_1.time_ <= var_584_4 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, false)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_6 = arg_581_1:GetWordFromCfg(120021141)
				local var_584_7 = arg_581_1:FormatText(var_584_6.content)

				arg_581_1.text_.text = var_584_7

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_8 = 35
				local var_584_9 = utf8.len(var_584_7)
				local var_584_10 = var_584_8 <= 0 and var_584_5 or var_584_5 * (var_584_9 / var_584_8)

				if var_584_10 > 0 and var_584_5 < var_584_10 then
					arg_581_1.talkMaxDuration = var_584_10

					if var_584_10 + var_584_4 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_10 + var_584_4
					end
				end

				arg_581_1.text_.text = var_584_7
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)
				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_11 = math.max(var_584_5, arg_581_1.talkMaxDuration)

			if var_584_4 <= arg_581_1.time_ and arg_581_1.time_ < var_584_4 + var_584_11 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_4) / var_584_11

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_4 + var_584_11 and arg_581_1.time_ < var_584_4 + var_584_11 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {}

		arg_581_1:InitPlayNodeList()
	end,
	Play120021142 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 120021142
		arg_585_1.duration_ = 6.8

		local var_585_0 = {
			zh = 4.7,
			ja = 6.8
		}
		local var_585_1 = manager.audio:GetLocalizationFlag()

		if var_585_0[var_585_1] ~= nil then
			arg_585_1.duration_ = var_585_0[var_585_1]
		end

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play120021143(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = arg_585_1.actors_["1075ui_story"].transform
			local var_588_1 = 0

			if var_588_1 < arg_585_1.time_ and arg_585_1.time_ <= var_588_1 + arg_588_0 then
				arg_585_1.var_.moveOldPos1075ui_story = var_588_0.localPosition
			end

			local var_588_2 = 0.001

			if var_588_1 <= arg_585_1.time_ and arg_585_1.time_ < var_588_1 + var_588_2 then
				local var_588_3 = (arg_585_1.time_ - var_588_1) / var_588_2
				local var_588_4 = Vector3.New(-0.7, -1.055, -6.16)

				var_588_0.localPosition = Vector3.Lerp(arg_585_1.var_.moveOldPos1075ui_story, var_588_4, var_588_3)

				local var_588_5 = manager.ui.mainCamera.transform.position - var_588_0.position

				var_588_0.forward = Vector3.New(var_588_5.x, var_588_5.y, var_588_5.z)

				local var_588_6 = var_588_0.localEulerAngles

				var_588_6.z = 0
				var_588_6.x = 0
				var_588_0.localEulerAngles = var_588_6
			end

			if arg_585_1.time_ >= var_588_1 + var_588_2 and arg_585_1.time_ < var_588_1 + var_588_2 + arg_588_0 then
				var_588_0.localPosition = Vector3.New(-0.7, -1.055, -6.16)

				local var_588_7 = manager.ui.mainCamera.transform.position - var_588_0.position

				var_588_0.forward = Vector3.New(var_588_7.x, var_588_7.y, var_588_7.z)

				local var_588_8 = var_588_0.localEulerAngles

				var_588_8.z = 0
				var_588_8.x = 0
				var_588_0.localEulerAngles = var_588_8
			end

			local var_588_9 = arg_585_1.actors_["10044ui_story"].transform
			local var_588_10 = 0

			if var_588_10 < arg_585_1.time_ and arg_585_1.time_ <= var_588_10 + arg_588_0 then
				arg_585_1.var_.moveOldPos10044ui_story = var_588_9.localPosition
			end

			local var_588_11 = 0.001

			if var_588_10 <= arg_585_1.time_ and arg_585_1.time_ < var_588_10 + var_588_11 then
				local var_588_12 = (arg_585_1.time_ - var_588_10) / var_588_11
				local var_588_13 = Vector3.New(0.7, -0.72, -6.3)

				var_588_9.localPosition = Vector3.Lerp(arg_585_1.var_.moveOldPos10044ui_story, var_588_13, var_588_12)

				local var_588_14 = manager.ui.mainCamera.transform.position - var_588_9.position

				var_588_9.forward = Vector3.New(var_588_14.x, var_588_14.y, var_588_14.z)

				local var_588_15 = var_588_9.localEulerAngles

				var_588_15.z = 0
				var_588_15.x = 0
				var_588_9.localEulerAngles = var_588_15
			end

			if arg_585_1.time_ >= var_588_10 + var_588_11 and arg_585_1.time_ < var_588_10 + var_588_11 + arg_588_0 then
				var_588_9.localPosition = Vector3.New(0.7, -0.72, -6.3)

				local var_588_16 = manager.ui.mainCamera.transform.position - var_588_9.position

				var_588_9.forward = Vector3.New(var_588_16.x, var_588_16.y, var_588_16.z)

				local var_588_17 = var_588_9.localEulerAngles

				var_588_17.z = 0
				var_588_17.x = 0
				var_588_9.localEulerAngles = var_588_17
			end

			local var_588_18 = arg_585_1.actors_["10044ui_story"]
			local var_588_19 = 0

			if var_588_19 < arg_585_1.time_ and arg_585_1.time_ <= var_588_19 + arg_588_0 and not isNil(var_588_18) and arg_585_1.var_.characterEffect10044ui_story == nil then
				arg_585_1.var_.characterEffect10044ui_story = var_588_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_588_20 = 0.2

			if var_588_19 <= arg_585_1.time_ and arg_585_1.time_ < var_588_19 + var_588_20 and not isNil(var_588_18) then
				local var_588_21 = (arg_585_1.time_ - var_588_19) / var_588_20

				if arg_585_1.var_.characterEffect10044ui_story and not isNil(var_588_18) then
					arg_585_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_585_1.time_ >= var_588_19 + var_588_20 and arg_585_1.time_ < var_588_19 + var_588_20 + arg_588_0 and not isNil(var_588_18) and arg_585_1.var_.characterEffect10044ui_story then
				arg_585_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_588_22 = 0

			if var_588_22 < arg_585_1.time_ and arg_585_1.time_ <= var_588_22 + arg_588_0 then
				arg_585_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action5_1")
			end

			local var_588_23 = 0

			if var_588_23 < arg_585_1.time_ and arg_585_1.time_ <= var_588_23 + arg_588_0 then
				arg_585_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_588_24 = 0
			local var_588_25 = 0.4

			if var_588_24 < arg_585_1.time_ and arg_585_1.time_ <= var_588_24 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				local var_588_26 = arg_585_1:FormatText(StoryNameCfg[380].name)

				arg_585_1.leftNameTxt_.text = var_588_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_27 = arg_585_1:GetWordFromCfg(120021142)
				local var_588_28 = arg_585_1:FormatText(var_588_27.content)

				arg_585_1.text_.text = var_588_28

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_29 = 16
				local var_588_30 = utf8.len(var_588_28)
				local var_588_31 = var_588_29 <= 0 and var_588_25 or var_588_25 * (var_588_30 / var_588_29)

				if var_588_31 > 0 and var_588_25 < var_588_31 then
					arg_585_1.talkMaxDuration = var_588_31

					if var_588_31 + var_588_24 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_31 + var_588_24
					end
				end

				arg_585_1.text_.text = var_588_28
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021142", "story_v_out_120021.awb") ~= 0 then
					local var_588_32 = manager.audio:GetVoiceLength("story_v_out_120021", "120021142", "story_v_out_120021.awb") / 1000

					if var_588_32 + var_588_24 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_32 + var_588_24
					end

					if var_588_27.prefab_name ~= "" and arg_585_1.actors_[var_588_27.prefab_name] ~= nil then
						local var_588_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_585_1.actors_[var_588_27.prefab_name].transform, "story_v_out_120021", "120021142", "story_v_out_120021.awb")

						arg_585_1:RecordAudio("120021142", var_588_33)
						arg_585_1:RecordAudio("120021142", var_588_33)
					else
						arg_585_1:AudioAction("play", "voice", "story_v_out_120021", "120021142", "story_v_out_120021.awb")
					end

					arg_585_1:RecordHistoryTalkVoice("story_v_out_120021", "120021142", "story_v_out_120021.awb")
				end

				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_34 = math.max(var_588_25, arg_585_1.talkMaxDuration)

			if var_588_24 <= arg_585_1.time_ and arg_585_1.time_ < var_588_24 + var_588_34 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_24) / var_588_34

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_24 + var_588_34 and arg_585_1.time_ < var_588_24 + var_588_34 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {
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
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_585_1:InitPlayNodeList()
	end,
	Play120021143 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 120021143
		arg_589_1.duration_ = 5

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play120021144(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = arg_589_1.actors_["10044ui_story"]
			local var_592_1 = 0

			if var_592_1 < arg_589_1.time_ and arg_589_1.time_ <= var_592_1 + arg_592_0 and not isNil(var_592_0) and arg_589_1.var_.characterEffect10044ui_story == nil then
				arg_589_1.var_.characterEffect10044ui_story = var_592_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_592_2 = 0.2

			if var_592_1 <= arg_589_1.time_ and arg_589_1.time_ < var_592_1 + var_592_2 and not isNil(var_592_0) then
				local var_592_3 = (arg_589_1.time_ - var_592_1) / var_592_2

				if arg_589_1.var_.characterEffect10044ui_story and not isNil(var_592_0) then
					local var_592_4 = Mathf.Lerp(0, 0.5, var_592_3)

					arg_589_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_589_1.var_.characterEffect10044ui_story.fillRatio = var_592_4
				end
			end

			if arg_589_1.time_ >= var_592_1 + var_592_2 and arg_589_1.time_ < var_592_1 + var_592_2 + arg_592_0 and not isNil(var_592_0) and arg_589_1.var_.characterEffect10044ui_story then
				local var_592_5 = 0.5

				arg_589_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_589_1.var_.characterEffect10044ui_story.fillRatio = var_592_5
			end

			local var_592_6 = 0
			local var_592_7 = 1.025

			if var_592_6 < arg_589_1.time_ and arg_589_1.time_ <= var_592_6 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				local var_592_8 = arg_589_1:FormatText(StoryNameCfg[7].name)

				arg_589_1.leftNameTxt_.text = var_592_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, true)
				arg_589_1.iconController_:SetSelectedState("hero")

				arg_589_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_589_1.callingController_:SetSelectedState("normal")

				arg_589_1.keyicon_.color = Color.New(1, 1, 1)
				arg_589_1.icon_.color = Color.New(1, 1, 1)

				local var_592_9 = arg_589_1:GetWordFromCfg(120021143)
				local var_592_10 = arg_589_1:FormatText(var_592_9.content)

				arg_589_1.text_.text = var_592_10

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_11 = 41
				local var_592_12 = utf8.len(var_592_10)
				local var_592_13 = var_592_11 <= 0 and var_592_7 or var_592_7 * (var_592_12 / var_592_11)

				if var_592_13 > 0 and var_592_7 < var_592_13 then
					arg_589_1.talkMaxDuration = var_592_13

					if var_592_13 + var_592_6 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_13 + var_592_6
					end
				end

				arg_589_1.text_.text = var_592_10
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_14 = math.max(var_592_7, arg_589_1.talkMaxDuration)

			if var_592_6 <= arg_589_1.time_ and arg_589_1.time_ < var_592_6 + var_592_14 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_6) / var_592_14

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_6 + var_592_14 and arg_589_1.time_ < var_592_6 + var_592_14 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play120021144 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 120021144
		arg_593_1.duration_ = 5

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play120021145(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = 0
			local var_596_1 = 1.15

			if var_596_0 < arg_593_1.time_ and arg_593_1.time_ <= var_596_0 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				local var_596_2 = arg_593_1:FormatText(StoryNameCfg[7].name)

				arg_593_1.leftNameTxt_.text = var_596_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, true)
				arg_593_1.iconController_:SetSelectedState("hero")

				arg_593_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_593_1.callingController_:SetSelectedState("normal")

				arg_593_1.keyicon_.color = Color.New(1, 1, 1)
				arg_593_1.icon_.color = Color.New(1, 1, 1)

				local var_596_3 = arg_593_1:GetWordFromCfg(120021144)
				local var_596_4 = arg_593_1:FormatText(var_596_3.content)

				arg_593_1.text_.text = var_596_4

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_5 = 46
				local var_596_6 = utf8.len(var_596_4)
				local var_596_7 = var_596_5 <= 0 and var_596_1 or var_596_1 * (var_596_6 / var_596_5)

				if var_596_7 > 0 and var_596_1 < var_596_7 then
					arg_593_1.talkMaxDuration = var_596_7

					if var_596_7 + var_596_0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_7 + var_596_0
					end
				end

				arg_593_1.text_.text = var_596_4
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)
				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_8 = math.max(var_596_1, arg_593_1.talkMaxDuration)

			if var_596_0 <= arg_593_1.time_ and arg_593_1.time_ < var_596_0 + var_596_8 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_0) / var_596_8

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_0 + var_596_8 and arg_593_1.time_ < var_596_0 + var_596_8 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play120021145 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 120021145
		arg_597_1.duration_ = 10.47

		local var_597_0 = {
			zh = 8.266,
			ja = 10.466
		}
		local var_597_1 = manager.audio:GetLocalizationFlag()

		if var_597_0[var_597_1] ~= nil then
			arg_597_1.duration_ = var_597_0[var_597_1]
		end

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play120021146(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			local var_600_0 = arg_597_1.actors_["1075ui_story"]
			local var_600_1 = 0

			if var_600_1 < arg_597_1.time_ and arg_597_1.time_ <= var_600_1 + arg_600_0 and not isNil(var_600_0) and arg_597_1.var_.characterEffect1075ui_story == nil then
				arg_597_1.var_.characterEffect1075ui_story = var_600_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_600_2 = 0.2

			if var_600_1 <= arg_597_1.time_ and arg_597_1.time_ < var_600_1 + var_600_2 and not isNil(var_600_0) then
				local var_600_3 = (arg_597_1.time_ - var_600_1) / var_600_2

				if arg_597_1.var_.characterEffect1075ui_story and not isNil(var_600_0) then
					arg_597_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_597_1.time_ >= var_600_1 + var_600_2 and arg_597_1.time_ < var_600_1 + var_600_2 + arg_600_0 and not isNil(var_600_0) and arg_597_1.var_.characterEffect1075ui_story then
				arg_597_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_600_4 = 0

			if var_600_4 < arg_597_1.time_ and arg_597_1.time_ <= var_600_4 + arg_600_0 then
				arg_597_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action5_2")
			end

			local var_600_5 = 0
			local var_600_6 = 0.85

			if var_600_5 < arg_597_1.time_ and arg_597_1.time_ <= var_600_5 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				local var_600_7 = arg_597_1:FormatText(StoryNameCfg[381].name)

				arg_597_1.leftNameTxt_.text = var_600_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_8 = arg_597_1:GetWordFromCfg(120021145)
				local var_600_9 = arg_597_1:FormatText(var_600_8.content)

				arg_597_1.text_.text = var_600_9

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_10 = 34
				local var_600_11 = utf8.len(var_600_9)
				local var_600_12 = var_600_10 <= 0 and var_600_6 or var_600_6 * (var_600_11 / var_600_10)

				if var_600_12 > 0 and var_600_6 < var_600_12 then
					arg_597_1.talkMaxDuration = var_600_12

					if var_600_12 + var_600_5 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_12 + var_600_5
					end
				end

				arg_597_1.text_.text = var_600_9
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021145", "story_v_out_120021.awb") ~= 0 then
					local var_600_13 = manager.audio:GetVoiceLength("story_v_out_120021", "120021145", "story_v_out_120021.awb") / 1000

					if var_600_13 + var_600_5 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_13 + var_600_5
					end

					if var_600_8.prefab_name ~= "" and arg_597_1.actors_[var_600_8.prefab_name] ~= nil then
						local var_600_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_597_1.actors_[var_600_8.prefab_name].transform, "story_v_out_120021", "120021145", "story_v_out_120021.awb")

						arg_597_1:RecordAudio("120021145", var_600_14)
						arg_597_1:RecordAudio("120021145", var_600_14)
					else
						arg_597_1:AudioAction("play", "voice", "story_v_out_120021", "120021145", "story_v_out_120021.awb")
					end

					arg_597_1:RecordHistoryTalkVoice("story_v_out_120021", "120021145", "story_v_out_120021.awb")
				end

				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_15 = math.max(var_600_6, arg_597_1.talkMaxDuration)

			if var_600_5 <= arg_597_1.time_ and arg_597_1.time_ < var_600_5 + var_600_15 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_5) / var_600_15

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_5 + var_600_15 and arg_597_1.time_ < var_600_5 + var_600_15 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play120021146 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 120021146
		arg_601_1.duration_ = 5

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play120021147(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			local var_604_0 = arg_601_1.actors_["1075ui_story"]
			local var_604_1 = 0

			if var_604_1 < arg_601_1.time_ and arg_601_1.time_ <= var_604_1 + arg_604_0 and not isNil(var_604_0) and arg_601_1.var_.characterEffect1075ui_story == nil then
				arg_601_1.var_.characterEffect1075ui_story = var_604_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_604_2 = 0.2

			if var_604_1 <= arg_601_1.time_ and arg_601_1.time_ < var_604_1 + var_604_2 and not isNil(var_604_0) then
				local var_604_3 = (arg_601_1.time_ - var_604_1) / var_604_2

				if arg_601_1.var_.characterEffect1075ui_story and not isNil(var_604_0) then
					local var_604_4 = Mathf.Lerp(0, 0.5, var_604_3)

					arg_601_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_601_1.var_.characterEffect1075ui_story.fillRatio = var_604_4
				end
			end

			if arg_601_1.time_ >= var_604_1 + var_604_2 and arg_601_1.time_ < var_604_1 + var_604_2 + arg_604_0 and not isNil(var_604_0) and arg_601_1.var_.characterEffect1075ui_story then
				local var_604_5 = 0.5

				arg_601_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_601_1.var_.characterEffect1075ui_story.fillRatio = var_604_5
			end

			local var_604_6 = 0
			local var_604_7 = 1.1

			if var_604_6 < arg_601_1.time_ and arg_601_1.time_ <= var_604_6 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				local var_604_8 = arg_601_1:FormatText(StoryNameCfg[7].name)

				arg_601_1.leftNameTxt_.text = var_604_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, true)
				arg_601_1.iconController_:SetSelectedState("hero")

				arg_601_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_601_1.callingController_:SetSelectedState("normal")

				arg_601_1.keyicon_.color = Color.New(1, 1, 1)
				arg_601_1.icon_.color = Color.New(1, 1, 1)

				local var_604_9 = arg_601_1:GetWordFromCfg(120021146)
				local var_604_10 = arg_601_1:FormatText(var_604_9.content)

				arg_601_1.text_.text = var_604_10

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_11 = 44
				local var_604_12 = utf8.len(var_604_10)
				local var_604_13 = var_604_11 <= 0 and var_604_7 or var_604_7 * (var_604_12 / var_604_11)

				if var_604_13 > 0 and var_604_7 < var_604_13 then
					arg_601_1.talkMaxDuration = var_604_13

					if var_604_13 + var_604_6 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_13 + var_604_6
					end
				end

				arg_601_1.text_.text = var_604_10
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_14 = math.max(var_604_7, arg_601_1.talkMaxDuration)

			if var_604_6 <= arg_601_1.time_ and arg_601_1.time_ < var_604_6 + var_604_14 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_6) / var_604_14

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_6 + var_604_14 and arg_601_1.time_ < var_604_6 + var_604_14 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play120021147 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 120021147
		arg_605_1.duration_ = 5

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play120021148(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = 0
			local var_608_1 = 0.8

			if var_608_0 < arg_605_1.time_ and arg_605_1.time_ <= var_608_0 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, false)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_2 = arg_605_1:GetWordFromCfg(120021147)
				local var_608_3 = arg_605_1:FormatText(var_608_2.content)

				arg_605_1.text_.text = var_608_3

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_4 = 32
				local var_608_5 = utf8.len(var_608_3)
				local var_608_6 = var_608_4 <= 0 and var_608_1 or var_608_1 * (var_608_5 / var_608_4)

				if var_608_6 > 0 and var_608_1 < var_608_6 then
					arg_605_1.talkMaxDuration = var_608_6

					if var_608_6 + var_608_0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_6 + var_608_0
					end
				end

				arg_605_1.text_.text = var_608_3
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)
				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_7 = math.max(var_608_1, arg_605_1.talkMaxDuration)

			if var_608_0 <= arg_605_1.time_ and arg_605_1.time_ < var_608_0 + var_608_7 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_0) / var_608_7

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_0 + var_608_7 and arg_605_1.time_ < var_608_0 + var_608_7 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play120021148 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 120021148
		arg_609_1.duration_ = 8.7

		local var_609_0 = {
			zh = 6.5,
			ja = 8.7
		}
		local var_609_1 = manager.audio:GetLocalizationFlag()

		if var_609_0[var_609_1] ~= nil then
			arg_609_1.duration_ = var_609_0[var_609_1]
		end

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play120021149(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = arg_609_1.actors_["10044ui_story"]
			local var_612_1 = 0

			if var_612_1 < arg_609_1.time_ and arg_609_1.time_ <= var_612_1 + arg_612_0 and not isNil(var_612_0) and arg_609_1.var_.characterEffect10044ui_story == nil then
				arg_609_1.var_.characterEffect10044ui_story = var_612_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_612_2 = 0.2

			if var_612_1 <= arg_609_1.time_ and arg_609_1.time_ < var_612_1 + var_612_2 and not isNil(var_612_0) then
				local var_612_3 = (arg_609_1.time_ - var_612_1) / var_612_2

				if arg_609_1.var_.characterEffect10044ui_story and not isNil(var_612_0) then
					arg_609_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_609_1.time_ >= var_612_1 + var_612_2 and arg_609_1.time_ < var_612_1 + var_612_2 + arg_612_0 and not isNil(var_612_0) and arg_609_1.var_.characterEffect10044ui_story then
				arg_609_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_612_4 = 0
			local var_612_5 = 0.7

			if var_612_4 < arg_609_1.time_ and arg_609_1.time_ <= var_612_4 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, true)

				local var_612_6 = arg_609_1:FormatText(StoryNameCfg[380].name)

				arg_609_1.leftNameTxt_.text = var_612_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_609_1.leftNameTxt_.transform)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1.leftNameTxt_.text)
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_7 = arg_609_1:GetWordFromCfg(120021148)
				local var_612_8 = arg_609_1:FormatText(var_612_7.content)

				arg_609_1.text_.text = var_612_8

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_9 = 28
				local var_612_10 = utf8.len(var_612_8)
				local var_612_11 = var_612_9 <= 0 and var_612_5 or var_612_5 * (var_612_10 / var_612_9)

				if var_612_11 > 0 and var_612_5 < var_612_11 then
					arg_609_1.talkMaxDuration = var_612_11

					if var_612_11 + var_612_4 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_11 + var_612_4
					end
				end

				arg_609_1.text_.text = var_612_8
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021148", "story_v_out_120021.awb") ~= 0 then
					local var_612_12 = manager.audio:GetVoiceLength("story_v_out_120021", "120021148", "story_v_out_120021.awb") / 1000

					if var_612_12 + var_612_4 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_12 + var_612_4
					end

					if var_612_7.prefab_name ~= "" and arg_609_1.actors_[var_612_7.prefab_name] ~= nil then
						local var_612_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_609_1.actors_[var_612_7.prefab_name].transform, "story_v_out_120021", "120021148", "story_v_out_120021.awb")

						arg_609_1:RecordAudio("120021148", var_612_13)
						arg_609_1:RecordAudio("120021148", var_612_13)
					else
						arg_609_1:AudioAction("play", "voice", "story_v_out_120021", "120021148", "story_v_out_120021.awb")
					end

					arg_609_1:RecordHistoryTalkVoice("story_v_out_120021", "120021148", "story_v_out_120021.awb")
				end

				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_14 = math.max(var_612_5, arg_609_1.talkMaxDuration)

			if var_612_4 <= arg_609_1.time_ and arg_609_1.time_ < var_612_4 + var_612_14 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_4) / var_612_14

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_4 + var_612_14 and arg_609_1.time_ < var_612_4 + var_612_14 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play120021149 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 120021149
		arg_613_1.duration_ = 3.27

		local var_613_0 = {
			zh = 1.933,
			ja = 3.266
		}
		local var_613_1 = manager.audio:GetLocalizationFlag()

		if var_613_0[var_613_1] ~= nil then
			arg_613_1.duration_ = var_613_0[var_613_1]
		end

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play120021150(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			local var_616_0 = arg_613_1.actors_["10044ui_story"]
			local var_616_1 = 0

			if var_616_1 < arg_613_1.time_ and arg_613_1.time_ <= var_616_1 + arg_616_0 and not isNil(var_616_0) and arg_613_1.var_.characterEffect10044ui_story == nil then
				arg_613_1.var_.characterEffect10044ui_story = var_616_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_616_2 = 0.2

			if var_616_1 <= arg_613_1.time_ and arg_613_1.time_ < var_616_1 + var_616_2 and not isNil(var_616_0) then
				local var_616_3 = (arg_613_1.time_ - var_616_1) / var_616_2

				if arg_613_1.var_.characterEffect10044ui_story and not isNil(var_616_0) then
					local var_616_4 = Mathf.Lerp(0, 0.5, var_616_3)

					arg_613_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_613_1.var_.characterEffect10044ui_story.fillRatio = var_616_4
				end
			end

			if arg_613_1.time_ >= var_616_1 + var_616_2 and arg_613_1.time_ < var_616_1 + var_616_2 + arg_616_0 and not isNil(var_616_0) and arg_613_1.var_.characterEffect10044ui_story then
				local var_616_5 = 0.5

				arg_613_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_613_1.var_.characterEffect10044ui_story.fillRatio = var_616_5
			end

			local var_616_6 = arg_613_1.actors_["1075ui_story"].transform
			local var_616_7 = 0

			if var_616_7 < arg_613_1.time_ and arg_613_1.time_ <= var_616_7 + arg_616_0 then
				arg_613_1.var_.moveOldPos1075ui_story = var_616_6.localPosition
			end

			local var_616_8 = 0.001

			if var_616_7 <= arg_613_1.time_ and arg_613_1.time_ < var_616_7 + var_616_8 then
				local var_616_9 = (arg_613_1.time_ - var_616_7) / var_616_8
				local var_616_10 = Vector3.New(0, 100, 0)

				var_616_6.localPosition = Vector3.Lerp(arg_613_1.var_.moveOldPos1075ui_story, var_616_10, var_616_9)

				local var_616_11 = manager.ui.mainCamera.transform.position - var_616_6.position

				var_616_6.forward = Vector3.New(var_616_11.x, var_616_11.y, var_616_11.z)

				local var_616_12 = var_616_6.localEulerAngles

				var_616_12.z = 0
				var_616_12.x = 0
				var_616_6.localEulerAngles = var_616_12
			end

			if arg_613_1.time_ >= var_616_7 + var_616_8 and arg_613_1.time_ < var_616_7 + var_616_8 + arg_616_0 then
				var_616_6.localPosition = Vector3.New(0, 100, 0)

				local var_616_13 = manager.ui.mainCamera.transform.position - var_616_6.position

				var_616_6.forward = Vector3.New(var_616_13.x, var_616_13.y, var_616_13.z)

				local var_616_14 = var_616_6.localEulerAngles

				var_616_14.z = 0
				var_616_14.x = 0
				var_616_6.localEulerAngles = var_616_14
			end

			local var_616_15 = arg_613_1.actors_["10044ui_story"].transform
			local var_616_16 = 0

			if var_616_16 < arg_613_1.time_ and arg_613_1.time_ <= var_616_16 + arg_616_0 then
				arg_613_1.var_.moveOldPos10044ui_story = var_616_15.localPosition
			end

			local var_616_17 = 0.001

			if var_616_16 <= arg_613_1.time_ and arg_613_1.time_ < var_616_16 + var_616_17 then
				local var_616_18 = (arg_613_1.time_ - var_616_16) / var_616_17
				local var_616_19 = Vector3.New(0, 100, 0)

				var_616_15.localPosition = Vector3.Lerp(arg_613_1.var_.moveOldPos10044ui_story, var_616_19, var_616_18)

				local var_616_20 = manager.ui.mainCamera.transform.position - var_616_15.position

				var_616_15.forward = Vector3.New(var_616_20.x, var_616_20.y, var_616_20.z)

				local var_616_21 = var_616_15.localEulerAngles

				var_616_21.z = 0
				var_616_21.x = 0
				var_616_15.localEulerAngles = var_616_21
			end

			if arg_613_1.time_ >= var_616_16 + var_616_17 and arg_613_1.time_ < var_616_16 + var_616_17 + arg_616_0 then
				var_616_15.localPosition = Vector3.New(0, 100, 0)

				local var_616_22 = manager.ui.mainCamera.transform.position - var_616_15.position

				var_616_15.forward = Vector3.New(var_616_22.x, var_616_22.y, var_616_22.z)

				local var_616_23 = var_616_15.localEulerAngles

				var_616_23.z = 0
				var_616_23.x = 0
				var_616_15.localEulerAngles = var_616_23
			end

			local var_616_24 = 0
			local var_616_25 = 0.125

			if var_616_24 < arg_613_1.time_ and arg_613_1.time_ <= var_616_24 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				local var_616_26 = arg_613_1:FormatText(StoryNameCfg[10].name)

				arg_613_1.leftNameTxt_.text = var_616_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, true)
				arg_613_1.iconController_:SetSelectedState("hero")

				arg_613_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_613_1.callingController_:SetSelectedState("normal")

				arg_613_1.keyicon_.color = Color.New(1, 1, 1)
				arg_613_1.icon_.color = Color.New(1, 1, 1)

				local var_616_27 = arg_613_1:GetWordFromCfg(120021149)
				local var_616_28 = arg_613_1:FormatText(var_616_27.content)

				arg_613_1.text_.text = var_616_28

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_29 = 5
				local var_616_30 = utf8.len(var_616_28)
				local var_616_31 = var_616_29 <= 0 and var_616_25 or var_616_25 * (var_616_30 / var_616_29)

				if var_616_31 > 0 and var_616_25 < var_616_31 then
					arg_613_1.talkMaxDuration = var_616_31

					if var_616_31 + var_616_24 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_31 + var_616_24
					end
				end

				arg_613_1.text_.text = var_616_28
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021149", "story_v_out_120021.awb") ~= 0 then
					local var_616_32 = manager.audio:GetVoiceLength("story_v_out_120021", "120021149", "story_v_out_120021.awb") / 1000

					if var_616_32 + var_616_24 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_32 + var_616_24
					end

					if var_616_27.prefab_name ~= "" and arg_613_1.actors_[var_616_27.prefab_name] ~= nil then
						local var_616_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_613_1.actors_[var_616_27.prefab_name].transform, "story_v_out_120021", "120021149", "story_v_out_120021.awb")

						arg_613_1:RecordAudio("120021149", var_616_33)
						arg_613_1:RecordAudio("120021149", var_616_33)
					else
						arg_613_1:AudioAction("play", "voice", "story_v_out_120021", "120021149", "story_v_out_120021.awb")
					end

					arg_613_1:RecordHistoryTalkVoice("story_v_out_120021", "120021149", "story_v_out_120021.awb")
				end

				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_34 = math.max(var_616_25, arg_613_1.talkMaxDuration)

			if var_616_24 <= arg_613_1.time_ and arg_613_1.time_ < var_616_24 + var_616_34 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_24) / var_616_34

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_24 + var_616_34 and arg_613_1.time_ < var_616_24 + var_616_34 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {
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
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_613_1:InitPlayNodeList()
	end,
	Play120021150 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 120021150
		arg_617_1.duration_ = 15.73

		local var_617_0 = {
			zh = 15.733,
			ja = 10.333
		}
		local var_617_1 = manager.audio:GetLocalizationFlag()

		if var_617_0[var_617_1] ~= nil then
			arg_617_1.duration_ = var_617_0[var_617_1]
		end

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play120021151(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			local var_620_0 = 0
			local var_620_1 = 1.675

			if var_620_0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_0 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				local var_620_2 = arg_617_1:FormatText(StoryNameCfg[10].name)

				arg_617_1.leftNameTxt_.text = var_620_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, true)
				arg_617_1.iconController_:SetSelectedState("hero")

				arg_617_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_617_1.callingController_:SetSelectedState("normal")

				arg_617_1.keyicon_.color = Color.New(1, 1, 1)
				arg_617_1.icon_.color = Color.New(1, 1, 1)

				local var_620_3 = arg_617_1:GetWordFromCfg(120021150)
				local var_620_4 = arg_617_1:FormatText(var_620_3.content)

				arg_617_1.text_.text = var_620_4

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_5 = 67
				local var_620_6 = utf8.len(var_620_4)
				local var_620_7 = var_620_5 <= 0 and var_620_1 or var_620_1 * (var_620_6 / var_620_5)

				if var_620_7 > 0 and var_620_1 < var_620_7 then
					arg_617_1.talkMaxDuration = var_620_7

					if var_620_7 + var_620_0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_7 + var_620_0
					end
				end

				arg_617_1.text_.text = var_620_4
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021150", "story_v_out_120021.awb") ~= 0 then
					local var_620_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021150", "story_v_out_120021.awb") / 1000

					if var_620_8 + var_620_0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_8 + var_620_0
					end

					if var_620_3.prefab_name ~= "" and arg_617_1.actors_[var_620_3.prefab_name] ~= nil then
						local var_620_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_617_1.actors_[var_620_3.prefab_name].transform, "story_v_out_120021", "120021150", "story_v_out_120021.awb")

						arg_617_1:RecordAudio("120021150", var_620_9)
						arg_617_1:RecordAudio("120021150", var_620_9)
					else
						arg_617_1:AudioAction("play", "voice", "story_v_out_120021", "120021150", "story_v_out_120021.awb")
					end

					arg_617_1:RecordHistoryTalkVoice("story_v_out_120021", "120021150", "story_v_out_120021.awb")
				end

				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_10 = math.max(var_620_1, arg_617_1.talkMaxDuration)

			if var_620_0 <= arg_617_1.time_ and arg_617_1.time_ < var_620_0 + var_620_10 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_0) / var_620_10

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_0 + var_620_10 and arg_617_1.time_ < var_620_0 + var_620_10 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play120021151 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 120021151
		arg_621_1.duration_ = 12.2

		local var_621_0 = {
			zh = 8.3,
			ja = 12.2
		}
		local var_621_1 = manager.audio:GetLocalizationFlag()

		if var_621_0[var_621_1] ~= nil then
			arg_621_1.duration_ = var_621_0[var_621_1]
		end

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play120021152(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			local var_624_0 = 0
			local var_624_1 = 0.85

			if var_624_0 < arg_621_1.time_ and arg_621_1.time_ <= var_624_0 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, true)

				local var_624_2 = arg_621_1:FormatText(StoryNameCfg[10].name)

				arg_621_1.leftNameTxt_.text = var_624_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, true)
				arg_621_1.iconController_:SetSelectedState("hero")

				arg_621_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_621_1.callingController_:SetSelectedState("normal")

				arg_621_1.keyicon_.color = Color.New(1, 1, 1)
				arg_621_1.icon_.color = Color.New(1, 1, 1)

				local var_624_3 = arg_621_1:GetWordFromCfg(120021151)
				local var_624_4 = arg_621_1:FormatText(var_624_3.content)

				arg_621_1.text_.text = var_624_4

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_5 = 34
				local var_624_6 = utf8.len(var_624_4)
				local var_624_7 = var_624_5 <= 0 and var_624_1 or var_624_1 * (var_624_6 / var_624_5)

				if var_624_7 > 0 and var_624_1 < var_624_7 then
					arg_621_1.talkMaxDuration = var_624_7

					if var_624_7 + var_624_0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_7 + var_624_0
					end
				end

				arg_621_1.text_.text = var_624_4
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021151", "story_v_out_120021.awb") ~= 0 then
					local var_624_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021151", "story_v_out_120021.awb") / 1000

					if var_624_8 + var_624_0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_8 + var_624_0
					end

					if var_624_3.prefab_name ~= "" and arg_621_1.actors_[var_624_3.prefab_name] ~= nil then
						local var_624_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_621_1.actors_[var_624_3.prefab_name].transform, "story_v_out_120021", "120021151", "story_v_out_120021.awb")

						arg_621_1:RecordAudio("120021151", var_624_9)
						arg_621_1:RecordAudio("120021151", var_624_9)
					else
						arg_621_1:AudioAction("play", "voice", "story_v_out_120021", "120021151", "story_v_out_120021.awb")
					end

					arg_621_1:RecordHistoryTalkVoice("story_v_out_120021", "120021151", "story_v_out_120021.awb")
				end

				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_10 = math.max(var_624_1, arg_621_1.talkMaxDuration)

			if var_624_0 <= arg_621_1.time_ and arg_621_1.time_ < var_624_0 + var_624_10 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - var_624_0) / var_624_10

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= var_624_0 + var_624_10 and arg_621_1.time_ < var_624_0 + var_624_10 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play120021152 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 120021152
		arg_625_1.duration_ = 2.73

		local var_625_0 = {
			zh = 2.733,
			ja = 1.999999999999
		}
		local var_625_1 = manager.audio:GetLocalizationFlag()

		if var_625_0[var_625_1] ~= nil then
			arg_625_1.duration_ = var_625_0[var_625_1]
		end

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play120021153(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = arg_625_1.actors_["1075ui_story"]
			local var_628_1 = 0

			if var_628_1 < arg_625_1.time_ and arg_625_1.time_ <= var_628_1 + arg_628_0 and not isNil(var_628_0) and arg_625_1.var_.characterEffect1075ui_story == nil then
				arg_625_1.var_.characterEffect1075ui_story = var_628_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_628_2 = 0.2

			if var_628_1 <= arg_625_1.time_ and arg_625_1.time_ < var_628_1 + var_628_2 and not isNil(var_628_0) then
				local var_628_3 = (arg_625_1.time_ - var_628_1) / var_628_2

				if arg_625_1.var_.characterEffect1075ui_story and not isNil(var_628_0) then
					arg_625_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_625_1.time_ >= var_628_1 + var_628_2 and arg_625_1.time_ < var_628_1 + var_628_2 + arg_628_0 and not isNil(var_628_0) and arg_625_1.var_.characterEffect1075ui_story then
				arg_625_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_628_4 = 0

			if var_628_4 < arg_625_1.time_ and arg_625_1.time_ <= var_628_4 + arg_628_0 then
				arg_625_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_628_5 = arg_625_1.actors_["1075ui_story"].transform
			local var_628_6 = 0

			if var_628_6 < arg_625_1.time_ and arg_625_1.time_ <= var_628_6 + arg_628_0 then
				arg_625_1.var_.moveOldPos1075ui_story = var_628_5.localPosition
			end

			local var_628_7 = 0.001

			if var_628_6 <= arg_625_1.time_ and arg_625_1.time_ < var_628_6 + var_628_7 then
				local var_628_8 = (arg_625_1.time_ - var_628_6) / var_628_7
				local var_628_9 = Vector3.New(-0.7, -1.055, -6.16)

				var_628_5.localPosition = Vector3.Lerp(arg_625_1.var_.moveOldPos1075ui_story, var_628_9, var_628_8)

				local var_628_10 = manager.ui.mainCamera.transform.position - var_628_5.position

				var_628_5.forward = Vector3.New(var_628_10.x, var_628_10.y, var_628_10.z)

				local var_628_11 = var_628_5.localEulerAngles

				var_628_11.z = 0
				var_628_11.x = 0
				var_628_5.localEulerAngles = var_628_11
			end

			if arg_625_1.time_ >= var_628_6 + var_628_7 and arg_625_1.time_ < var_628_6 + var_628_7 + arg_628_0 then
				var_628_5.localPosition = Vector3.New(-0.7, -1.055, -6.16)

				local var_628_12 = manager.ui.mainCamera.transform.position - var_628_5.position

				var_628_5.forward = Vector3.New(var_628_12.x, var_628_12.y, var_628_12.z)

				local var_628_13 = var_628_5.localEulerAngles

				var_628_13.z = 0
				var_628_13.x = 0
				var_628_5.localEulerAngles = var_628_13
			end

			local var_628_14 = 0
			local var_628_15 = 0.075

			if var_628_14 < arg_625_1.time_ and arg_625_1.time_ <= var_628_14 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, true)

				local var_628_16 = arg_625_1:FormatText(StoryNameCfg[381].name)

				arg_625_1.leftNameTxt_.text = var_628_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_625_1.leftNameTxt_.transform)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1.leftNameTxt_.text)
				SetActive(arg_625_1.iconTrs_.gameObject, false)
				arg_625_1.callingController_:SetSelectedState("normal")

				local var_628_17 = arg_625_1:GetWordFromCfg(120021152)
				local var_628_18 = arg_625_1:FormatText(var_628_17.content)

				arg_625_1.text_.text = var_628_18

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_19 = 3
				local var_628_20 = utf8.len(var_628_18)
				local var_628_21 = var_628_19 <= 0 and var_628_15 or var_628_15 * (var_628_20 / var_628_19)

				if var_628_21 > 0 and var_628_15 < var_628_21 then
					arg_625_1.talkMaxDuration = var_628_21

					if var_628_21 + var_628_14 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_21 + var_628_14
					end
				end

				arg_625_1.text_.text = var_628_18
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021152", "story_v_out_120021.awb") ~= 0 then
					local var_628_22 = manager.audio:GetVoiceLength("story_v_out_120021", "120021152", "story_v_out_120021.awb") / 1000

					if var_628_22 + var_628_14 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_22 + var_628_14
					end

					if var_628_17.prefab_name ~= "" and arg_625_1.actors_[var_628_17.prefab_name] ~= nil then
						local var_628_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_625_1.actors_[var_628_17.prefab_name].transform, "story_v_out_120021", "120021152", "story_v_out_120021.awb")

						arg_625_1:RecordAudio("120021152", var_628_23)
						arg_625_1:RecordAudio("120021152", var_628_23)
					else
						arg_625_1:AudioAction("play", "voice", "story_v_out_120021", "120021152", "story_v_out_120021.awb")
					end

					arg_625_1:RecordHistoryTalkVoice("story_v_out_120021", "120021152", "story_v_out_120021.awb")
				end

				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_24 = math.max(var_628_15, arg_625_1.talkMaxDuration)

			if var_628_14 <= arg_625_1.time_ and arg_625_1.time_ < var_628_14 + var_628_24 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - var_628_14) / var_628_24

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= var_628_14 + var_628_24 and arg_625_1.time_ < var_628_14 + var_628_24 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {
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

		arg_625_1:InitPlayNodeList()
	end,
	Play120021153 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 120021153
		arg_629_1.duration_ = 4.8

		local var_629_0 = {
			zh = 2.4,
			ja = 4.8
		}
		local var_629_1 = manager.audio:GetLocalizationFlag()

		if var_629_0[var_629_1] ~= nil then
			arg_629_1.duration_ = var_629_0[var_629_1]
		end

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play120021154(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			local var_632_0 = arg_629_1.actors_["10044ui_story"].transform
			local var_632_1 = 0

			if var_632_1 < arg_629_1.time_ and arg_629_1.time_ <= var_632_1 + arg_632_0 then
				arg_629_1.var_.moveOldPos10044ui_story = var_632_0.localPosition
			end

			local var_632_2 = 0.001

			if var_632_1 <= arg_629_1.time_ and arg_629_1.time_ < var_632_1 + var_632_2 then
				local var_632_3 = (arg_629_1.time_ - var_632_1) / var_632_2
				local var_632_4 = Vector3.New(0, 100, 0)

				var_632_0.localPosition = Vector3.Lerp(arg_629_1.var_.moveOldPos10044ui_story, var_632_4, var_632_3)

				local var_632_5 = manager.ui.mainCamera.transform.position - var_632_0.position

				var_632_0.forward = Vector3.New(var_632_5.x, var_632_5.y, var_632_5.z)

				local var_632_6 = var_632_0.localEulerAngles

				var_632_6.z = 0
				var_632_6.x = 0
				var_632_0.localEulerAngles = var_632_6
			end

			if arg_629_1.time_ >= var_632_1 + var_632_2 and arg_629_1.time_ < var_632_1 + var_632_2 + arg_632_0 then
				var_632_0.localPosition = Vector3.New(0, 100, 0)

				local var_632_7 = manager.ui.mainCamera.transform.position - var_632_0.position

				var_632_0.forward = Vector3.New(var_632_7.x, var_632_7.y, var_632_7.z)

				local var_632_8 = var_632_0.localEulerAngles

				var_632_8.z = 0
				var_632_8.x = 0
				var_632_0.localEulerAngles = var_632_8
			end

			local var_632_9 = arg_629_1.actors_["1084ui_story"].transform
			local var_632_10 = 0

			if var_632_10 < arg_629_1.time_ and arg_629_1.time_ <= var_632_10 + arg_632_0 then
				arg_629_1.var_.moveOldPos1084ui_story = var_632_9.localPosition
			end

			local var_632_11 = 0.001

			if var_632_10 <= arg_629_1.time_ and arg_629_1.time_ < var_632_10 + var_632_11 then
				local var_632_12 = (arg_629_1.time_ - var_632_10) / var_632_11
				local var_632_13 = Vector3.New(0.7, -0.97, -6)

				var_632_9.localPosition = Vector3.Lerp(arg_629_1.var_.moveOldPos1084ui_story, var_632_13, var_632_12)

				local var_632_14 = manager.ui.mainCamera.transform.position - var_632_9.position

				var_632_9.forward = Vector3.New(var_632_14.x, var_632_14.y, var_632_14.z)

				local var_632_15 = var_632_9.localEulerAngles

				var_632_15.z = 0
				var_632_15.x = 0
				var_632_9.localEulerAngles = var_632_15
			end

			if arg_629_1.time_ >= var_632_10 + var_632_11 and arg_629_1.time_ < var_632_10 + var_632_11 + arg_632_0 then
				var_632_9.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_632_16 = manager.ui.mainCamera.transform.position - var_632_9.position

				var_632_9.forward = Vector3.New(var_632_16.x, var_632_16.y, var_632_16.z)

				local var_632_17 = var_632_9.localEulerAngles

				var_632_17.z = 0
				var_632_17.x = 0
				var_632_9.localEulerAngles = var_632_17
			end

			local var_632_18 = arg_629_1.actors_["1075ui_story"]
			local var_632_19 = 0

			if var_632_19 < arg_629_1.time_ and arg_629_1.time_ <= var_632_19 + arg_632_0 and not isNil(var_632_18) and arg_629_1.var_.characterEffect1075ui_story == nil then
				arg_629_1.var_.characterEffect1075ui_story = var_632_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_632_20 = 0.2

			if var_632_19 <= arg_629_1.time_ and arg_629_1.time_ < var_632_19 + var_632_20 and not isNil(var_632_18) then
				local var_632_21 = (arg_629_1.time_ - var_632_19) / var_632_20

				if arg_629_1.var_.characterEffect1075ui_story and not isNil(var_632_18) then
					local var_632_22 = Mathf.Lerp(0, 0.5, var_632_21)

					arg_629_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_629_1.var_.characterEffect1075ui_story.fillRatio = var_632_22
				end
			end

			if arg_629_1.time_ >= var_632_19 + var_632_20 and arg_629_1.time_ < var_632_19 + var_632_20 + arg_632_0 and not isNil(var_632_18) and arg_629_1.var_.characterEffect1075ui_story then
				local var_632_23 = 0.5

				arg_629_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_629_1.var_.characterEffect1075ui_story.fillRatio = var_632_23
			end

			local var_632_24 = arg_629_1.actors_["1084ui_story"]
			local var_632_25 = 0

			if var_632_25 < arg_629_1.time_ and arg_629_1.time_ <= var_632_25 + arg_632_0 and not isNil(var_632_24) and arg_629_1.var_.characterEffect1084ui_story == nil then
				arg_629_1.var_.characterEffect1084ui_story = var_632_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_632_26 = 0.2

			if var_632_25 <= arg_629_1.time_ and arg_629_1.time_ < var_632_25 + var_632_26 and not isNil(var_632_24) then
				local var_632_27 = (arg_629_1.time_ - var_632_25) / var_632_26

				if arg_629_1.var_.characterEffect1084ui_story and not isNil(var_632_24) then
					arg_629_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_629_1.time_ >= var_632_25 + var_632_26 and arg_629_1.time_ < var_632_25 + var_632_26 + arg_632_0 and not isNil(var_632_24) and arg_629_1.var_.characterEffect1084ui_story then
				arg_629_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_632_28 = 0

			if var_632_28 < arg_629_1.time_ and arg_629_1.time_ <= var_632_28 + arg_632_0 then
				arg_629_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_632_29 = 0

			if var_632_29 < arg_629_1.time_ and arg_629_1.time_ <= var_632_29 + arg_632_0 then
				arg_629_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_632_30 = 0
			local var_632_31 = 0.25

			if var_632_30 < arg_629_1.time_ and arg_629_1.time_ <= var_632_30 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0
				arg_629_1.dialogCg_.alpha = 1

				arg_629_1.dialog_:SetActive(true)
				SetActive(arg_629_1.leftNameGo_, true)

				local var_632_32 = arg_629_1:FormatText(StoryNameCfg[6].name)

				arg_629_1.leftNameTxt_.text = var_632_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_629_1.leftNameTxt_.transform)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1.leftNameTxt_.text)
				SetActive(arg_629_1.iconTrs_.gameObject, false)
				arg_629_1.callingController_:SetSelectedState("normal")

				local var_632_33 = arg_629_1:GetWordFromCfg(120021153)
				local var_632_34 = arg_629_1:FormatText(var_632_33.content)

				arg_629_1.text_.text = var_632_34

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_35 = 10
				local var_632_36 = utf8.len(var_632_34)
				local var_632_37 = var_632_35 <= 0 and var_632_31 or var_632_31 * (var_632_36 / var_632_35)

				if var_632_37 > 0 and var_632_31 < var_632_37 then
					arg_629_1.talkMaxDuration = var_632_37

					if var_632_37 + var_632_30 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_37 + var_632_30
					end
				end

				arg_629_1.text_.text = var_632_34
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021153", "story_v_out_120021.awb") ~= 0 then
					local var_632_38 = manager.audio:GetVoiceLength("story_v_out_120021", "120021153", "story_v_out_120021.awb") / 1000

					if var_632_38 + var_632_30 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_38 + var_632_30
					end

					if var_632_33.prefab_name ~= "" and arg_629_1.actors_[var_632_33.prefab_name] ~= nil then
						local var_632_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_629_1.actors_[var_632_33.prefab_name].transform, "story_v_out_120021", "120021153", "story_v_out_120021.awb")

						arg_629_1:RecordAudio("120021153", var_632_39)
						arg_629_1:RecordAudio("120021153", var_632_39)
					else
						arg_629_1:AudioAction("play", "voice", "story_v_out_120021", "120021153", "story_v_out_120021.awb")
					end

					arg_629_1:RecordHistoryTalkVoice("story_v_out_120021", "120021153", "story_v_out_120021.awb")
				end

				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_40 = math.max(var_632_31, arg_629_1.talkMaxDuration)

			if var_632_30 <= arg_629_1.time_ and arg_629_1.time_ < var_632_30 + var_632_40 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - var_632_30) / var_632_40

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= var_632_30 + var_632_40 and arg_629_1.time_ < var_632_30 + var_632_40 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_629_1:InitPlayNodeList()
	end,
	Play120021154 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 120021154
		arg_633_1.duration_ = 5

		SetActive(arg_633_1.tipsGo_, false)

		function arg_633_1.onSingleLineFinish_()
			arg_633_1.onSingleLineUpdate_ = nil
			arg_633_1.onSingleLineFinish_ = nil
			arg_633_1.state_ = "waiting"
		end

		function arg_633_1.playNext_(arg_635_0)
			if arg_635_0 == 1 then
				arg_633_0:Play120021155(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			local var_636_0 = arg_633_1.actors_["1084ui_story"]
			local var_636_1 = 0

			if var_636_1 < arg_633_1.time_ and arg_633_1.time_ <= var_636_1 + arg_636_0 and not isNil(var_636_0) and arg_633_1.var_.characterEffect1084ui_story == nil then
				arg_633_1.var_.characterEffect1084ui_story = var_636_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_636_2 = 0.2

			if var_636_1 <= arg_633_1.time_ and arg_633_1.time_ < var_636_1 + var_636_2 and not isNil(var_636_0) then
				local var_636_3 = (arg_633_1.time_ - var_636_1) / var_636_2

				if arg_633_1.var_.characterEffect1084ui_story and not isNil(var_636_0) then
					local var_636_4 = Mathf.Lerp(0, 0.5, var_636_3)

					arg_633_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_633_1.var_.characterEffect1084ui_story.fillRatio = var_636_4
				end
			end

			if arg_633_1.time_ >= var_636_1 + var_636_2 and arg_633_1.time_ < var_636_1 + var_636_2 + arg_636_0 and not isNil(var_636_0) and arg_633_1.var_.characterEffect1084ui_story then
				local var_636_5 = 0.5

				arg_633_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_633_1.var_.characterEffect1084ui_story.fillRatio = var_636_5
			end

			local var_636_6 = 0

			if var_636_6 < arg_633_1.time_ and arg_633_1.time_ <= var_636_6 + arg_636_0 then
				arg_633_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_636_7 = 0
			local var_636_8 = 0.925

			if var_636_7 < arg_633_1.time_ and arg_633_1.time_ <= var_636_7 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0
				arg_633_1.dialogCg_.alpha = 1

				arg_633_1.dialog_:SetActive(true)
				SetActive(arg_633_1.leftNameGo_, true)

				local var_636_9 = arg_633_1:FormatText(StoryNameCfg[7].name)

				arg_633_1.leftNameTxt_.text = var_636_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_633_1.leftNameTxt_.transform)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1.leftNameTxt_.text)
				SetActive(arg_633_1.iconTrs_.gameObject, true)
				arg_633_1.iconController_:SetSelectedState("hero")

				arg_633_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_633_1.callingController_:SetSelectedState("normal")

				arg_633_1.keyicon_.color = Color.New(1, 1, 1)
				arg_633_1.icon_.color = Color.New(1, 1, 1)

				local var_636_10 = arg_633_1:GetWordFromCfg(120021154)
				local var_636_11 = arg_633_1:FormatText(var_636_10.content)

				arg_633_1.text_.text = var_636_11

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_12 = 37
				local var_636_13 = utf8.len(var_636_11)
				local var_636_14 = var_636_12 <= 0 and var_636_8 or var_636_8 * (var_636_13 / var_636_12)

				if var_636_14 > 0 and var_636_8 < var_636_14 then
					arg_633_1.talkMaxDuration = var_636_14

					if var_636_14 + var_636_7 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_14 + var_636_7
					end
				end

				arg_633_1.text_.text = var_636_11
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)
				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_15 = math.max(var_636_8, arg_633_1.talkMaxDuration)

			if var_636_7 <= arg_633_1.time_ and arg_633_1.time_ < var_636_7 + var_636_15 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - var_636_7) / var_636_15

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= var_636_7 + var_636_15 and arg_633_1.time_ < var_636_7 + var_636_15 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {}

		arg_633_1:InitPlayNodeList()
	end,
	Play120021155 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 120021155
		arg_637_1.duration_ = 5

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play120021156(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			local var_640_0 = 0
			local var_640_1 = 0.275

			if var_640_0 < arg_637_1.time_ and arg_637_1.time_ <= var_640_0 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, true)

				local var_640_2 = arg_637_1:FormatText(StoryNameCfg[7].name)

				arg_637_1.leftNameTxt_.text = var_640_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_637_1.leftNameTxt_.transform)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1.leftNameTxt_.text)
				SetActive(arg_637_1.iconTrs_.gameObject, true)
				arg_637_1.iconController_:SetSelectedState("hero")

				arg_637_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_637_1.callingController_:SetSelectedState("normal")

				arg_637_1.keyicon_.color = Color.New(1, 1, 1)
				arg_637_1.icon_.color = Color.New(1, 1, 1)

				local var_640_3 = arg_637_1:GetWordFromCfg(120021155)
				local var_640_4 = arg_637_1:FormatText(var_640_3.content)

				arg_637_1.text_.text = var_640_4

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_5 = 11
				local var_640_6 = utf8.len(var_640_4)
				local var_640_7 = var_640_5 <= 0 and var_640_1 or var_640_1 * (var_640_6 / var_640_5)

				if var_640_7 > 0 and var_640_1 < var_640_7 then
					arg_637_1.talkMaxDuration = var_640_7

					if var_640_7 + var_640_0 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_7 + var_640_0
					end
				end

				arg_637_1.text_.text = var_640_4
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)
				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_8 = math.max(var_640_1, arg_637_1.talkMaxDuration)

			if var_640_0 <= arg_637_1.time_ and arg_637_1.time_ < var_640_0 + var_640_8 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - var_640_0) / var_640_8

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= var_640_0 + var_640_8 and arg_637_1.time_ < var_640_0 + var_640_8 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {}

		arg_637_1:InitPlayNodeList()
	end,
	Play120021156 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 120021156
		arg_641_1.duration_ = 15.43

		local var_641_0 = {
			zh = 15.433,
			ja = 7.933
		}
		local var_641_1 = manager.audio:GetLocalizationFlag()

		if var_641_0[var_641_1] ~= nil then
			arg_641_1.duration_ = var_641_0[var_641_1]
		end

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play120021157(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			local var_644_0 = arg_641_1.actors_["1075ui_story"]
			local var_644_1 = 0

			if var_644_1 < arg_641_1.time_ and arg_641_1.time_ <= var_644_1 + arg_644_0 and not isNil(var_644_0) and arg_641_1.var_.characterEffect1075ui_story == nil then
				arg_641_1.var_.characterEffect1075ui_story = var_644_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_644_2 = 0.2

			if var_644_1 <= arg_641_1.time_ and arg_641_1.time_ < var_644_1 + var_644_2 and not isNil(var_644_0) then
				local var_644_3 = (arg_641_1.time_ - var_644_1) / var_644_2

				if arg_641_1.var_.characterEffect1075ui_story and not isNil(var_644_0) then
					arg_641_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_641_1.time_ >= var_644_1 + var_644_2 and arg_641_1.time_ < var_644_1 + var_644_2 + arg_644_0 and not isNil(var_644_0) and arg_641_1.var_.characterEffect1075ui_story then
				arg_641_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_644_4 = 0

			if var_644_4 < arg_641_1.time_ and arg_641_1.time_ <= var_644_4 + arg_644_0 then
				arg_641_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_644_5 = 0

			if var_644_5 < arg_641_1.time_ and arg_641_1.time_ <= var_644_5 + arg_644_0 then
				arg_641_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_644_6 = 0
			local var_644_7 = 1.275

			if var_644_6 < arg_641_1.time_ and arg_641_1.time_ <= var_644_6 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, true)

				local var_644_8 = arg_641_1:FormatText(StoryNameCfg[381].name)

				arg_641_1.leftNameTxt_.text = var_644_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, false)
				arg_641_1.callingController_:SetSelectedState("normal")

				local var_644_9 = arg_641_1:GetWordFromCfg(120021156)
				local var_644_10 = arg_641_1:FormatText(var_644_9.content)

				arg_641_1.text_.text = var_644_10

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_11 = 51
				local var_644_12 = utf8.len(var_644_10)
				local var_644_13 = var_644_11 <= 0 and var_644_7 or var_644_7 * (var_644_12 / var_644_11)

				if var_644_13 > 0 and var_644_7 < var_644_13 then
					arg_641_1.talkMaxDuration = var_644_13

					if var_644_13 + var_644_6 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_13 + var_644_6
					end
				end

				arg_641_1.text_.text = var_644_10
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021156", "story_v_out_120021.awb") ~= 0 then
					local var_644_14 = manager.audio:GetVoiceLength("story_v_out_120021", "120021156", "story_v_out_120021.awb") / 1000

					if var_644_14 + var_644_6 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_14 + var_644_6
					end

					if var_644_9.prefab_name ~= "" and arg_641_1.actors_[var_644_9.prefab_name] ~= nil then
						local var_644_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_641_1.actors_[var_644_9.prefab_name].transform, "story_v_out_120021", "120021156", "story_v_out_120021.awb")

						arg_641_1:RecordAudio("120021156", var_644_15)
						arg_641_1:RecordAudio("120021156", var_644_15)
					else
						arg_641_1:AudioAction("play", "voice", "story_v_out_120021", "120021156", "story_v_out_120021.awb")
					end

					arg_641_1:RecordHistoryTalkVoice("story_v_out_120021", "120021156", "story_v_out_120021.awb")
				end

				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_16 = math.max(var_644_7, arg_641_1.talkMaxDuration)

			if var_644_6 <= arg_641_1.time_ and arg_641_1.time_ < var_644_6 + var_644_16 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - var_644_6) / var_644_16

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= var_644_6 + var_644_16 and arg_641_1.time_ < var_644_6 + var_644_16 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {}

		arg_641_1:InitPlayNodeList()
	end,
	Play120021157 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 120021157
		arg_645_1.duration_ = 12.13

		local var_645_0 = {
			zh = 7.8,
			ja = 12.133
		}
		local var_645_1 = manager.audio:GetLocalizationFlag()

		if var_645_0[var_645_1] ~= nil then
			arg_645_1.duration_ = var_645_0[var_645_1]
		end

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play120021158(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			local var_648_0 = 0
			local var_648_1 = 0.75

			if var_648_0 < arg_645_1.time_ and arg_645_1.time_ <= var_648_0 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, true)

				local var_648_2 = arg_645_1:FormatText(StoryNameCfg[381].name)

				arg_645_1.leftNameTxt_.text = var_648_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_645_1.leftNameTxt_.transform)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1.leftNameTxt_.text)
				SetActive(arg_645_1.iconTrs_.gameObject, false)
				arg_645_1.callingController_:SetSelectedState("normal")

				local var_648_3 = arg_645_1:GetWordFromCfg(120021157)
				local var_648_4 = arg_645_1:FormatText(var_648_3.content)

				arg_645_1.text_.text = var_648_4

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_5 = 30
				local var_648_6 = utf8.len(var_648_4)
				local var_648_7 = var_648_5 <= 0 and var_648_1 or var_648_1 * (var_648_6 / var_648_5)

				if var_648_7 > 0 and var_648_1 < var_648_7 then
					arg_645_1.talkMaxDuration = var_648_7

					if var_648_7 + var_648_0 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_7 + var_648_0
					end
				end

				arg_645_1.text_.text = var_648_4
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021157", "story_v_out_120021.awb") ~= 0 then
					local var_648_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021157", "story_v_out_120021.awb") / 1000

					if var_648_8 + var_648_0 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_8 + var_648_0
					end

					if var_648_3.prefab_name ~= "" and arg_645_1.actors_[var_648_3.prefab_name] ~= nil then
						local var_648_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_645_1.actors_[var_648_3.prefab_name].transform, "story_v_out_120021", "120021157", "story_v_out_120021.awb")

						arg_645_1:RecordAudio("120021157", var_648_9)
						arg_645_1:RecordAudio("120021157", var_648_9)
					else
						arg_645_1:AudioAction("play", "voice", "story_v_out_120021", "120021157", "story_v_out_120021.awb")
					end

					arg_645_1:RecordHistoryTalkVoice("story_v_out_120021", "120021157", "story_v_out_120021.awb")
				end

				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_10 = math.max(var_648_1, arg_645_1.talkMaxDuration)

			if var_648_0 <= arg_645_1.time_ and arg_645_1.time_ < var_648_0 + var_648_10 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_0) / var_648_10

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_0 + var_648_10 and arg_645_1.time_ < var_648_0 + var_648_10 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play120021158 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 120021158
		arg_649_1.duration_ = 5.33

		local var_649_0 = {
			zh = 3.3,
			ja = 5.333
		}
		local var_649_1 = manager.audio:GetLocalizationFlag()

		if var_649_0[var_649_1] ~= nil then
			arg_649_1.duration_ = var_649_0[var_649_1]
		end

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play120021159(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = arg_649_1.actors_["1075ui_story"]
			local var_652_1 = 0

			if var_652_1 < arg_649_1.time_ and arg_649_1.time_ <= var_652_1 + arg_652_0 and not isNil(var_652_0) and arg_649_1.var_.characterEffect1075ui_story == nil then
				arg_649_1.var_.characterEffect1075ui_story = var_652_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_652_2 = 0.2

			if var_652_1 <= arg_649_1.time_ and arg_649_1.time_ < var_652_1 + var_652_2 and not isNil(var_652_0) then
				local var_652_3 = (arg_649_1.time_ - var_652_1) / var_652_2

				if arg_649_1.var_.characterEffect1075ui_story and not isNil(var_652_0) then
					local var_652_4 = Mathf.Lerp(0, 0.5, var_652_3)

					arg_649_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_649_1.var_.characterEffect1075ui_story.fillRatio = var_652_4
				end
			end

			if arg_649_1.time_ >= var_652_1 + var_652_2 and arg_649_1.time_ < var_652_1 + var_652_2 + arg_652_0 and not isNil(var_652_0) and arg_649_1.var_.characterEffect1075ui_story then
				local var_652_5 = 0.5

				arg_649_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_649_1.var_.characterEffect1075ui_story.fillRatio = var_652_5
			end

			local var_652_6 = arg_649_1.actors_["1084ui_story"]
			local var_652_7 = 0

			if var_652_7 < arg_649_1.time_ and arg_649_1.time_ <= var_652_7 + arg_652_0 and not isNil(var_652_6) and arg_649_1.var_.characterEffect1084ui_story == nil then
				arg_649_1.var_.characterEffect1084ui_story = var_652_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_652_8 = 0.2

			if var_652_7 <= arg_649_1.time_ and arg_649_1.time_ < var_652_7 + var_652_8 and not isNil(var_652_6) then
				local var_652_9 = (arg_649_1.time_ - var_652_7) / var_652_8

				if arg_649_1.var_.characterEffect1084ui_story and not isNil(var_652_6) then
					arg_649_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_649_1.time_ >= var_652_7 + var_652_8 and arg_649_1.time_ < var_652_7 + var_652_8 + arg_652_0 and not isNil(var_652_6) and arg_649_1.var_.characterEffect1084ui_story then
				arg_649_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_652_10 = 0

			if var_652_10 < arg_649_1.time_ and arg_649_1.time_ <= var_652_10 + arg_652_0 then
				arg_649_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_652_11 = 0

			if var_652_11 < arg_649_1.time_ and arg_649_1.time_ <= var_652_11 + arg_652_0 then
				arg_649_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_652_12 = 0
			local var_652_13 = 0.4

			if var_652_12 < arg_649_1.time_ and arg_649_1.time_ <= var_652_12 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, true)

				local var_652_14 = arg_649_1:FormatText(StoryNameCfg[6].name)

				arg_649_1.leftNameTxt_.text = var_652_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_649_1.leftNameTxt_.transform)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1.leftNameTxt_.text)
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_15 = arg_649_1:GetWordFromCfg(120021158)
				local var_652_16 = arg_649_1:FormatText(var_652_15.content)

				arg_649_1.text_.text = var_652_16

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_17 = 16
				local var_652_18 = utf8.len(var_652_16)
				local var_652_19 = var_652_17 <= 0 and var_652_13 or var_652_13 * (var_652_18 / var_652_17)

				if var_652_19 > 0 and var_652_13 < var_652_19 then
					arg_649_1.talkMaxDuration = var_652_19

					if var_652_19 + var_652_12 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_19 + var_652_12
					end
				end

				arg_649_1.text_.text = var_652_16
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021158", "story_v_out_120021.awb") ~= 0 then
					local var_652_20 = manager.audio:GetVoiceLength("story_v_out_120021", "120021158", "story_v_out_120021.awb") / 1000

					if var_652_20 + var_652_12 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_20 + var_652_12
					end

					if var_652_15.prefab_name ~= "" and arg_649_1.actors_[var_652_15.prefab_name] ~= nil then
						local var_652_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_649_1.actors_[var_652_15.prefab_name].transform, "story_v_out_120021", "120021158", "story_v_out_120021.awb")

						arg_649_1:RecordAudio("120021158", var_652_21)
						arg_649_1:RecordAudio("120021158", var_652_21)
					else
						arg_649_1:AudioAction("play", "voice", "story_v_out_120021", "120021158", "story_v_out_120021.awb")
					end

					arg_649_1:RecordHistoryTalkVoice("story_v_out_120021", "120021158", "story_v_out_120021.awb")
				end

				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_22 = math.max(var_652_13, arg_649_1.talkMaxDuration)

			if var_652_12 <= arg_649_1.time_ and arg_649_1.time_ < var_652_12 + var_652_22 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_12) / var_652_22

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_12 + var_652_22 and arg_649_1.time_ < var_652_12 + var_652_22 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play120021159 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 120021159
		arg_653_1.duration_ = 2.8

		local var_653_0 = {
			zh = 2.1,
			ja = 2.8
		}
		local var_653_1 = manager.audio:GetLocalizationFlag()

		if var_653_0[var_653_1] ~= nil then
			arg_653_1.duration_ = var_653_0[var_653_1]
		end

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play120021160(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			local var_656_0 = 0

			if var_656_0 < arg_653_1.time_ and arg_653_1.time_ <= var_656_0 + arg_656_0 then
				arg_653_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4512")
			end

			local var_656_1 = 0

			if var_656_1 < arg_653_1.time_ and arg_653_1.time_ <= var_656_1 + arg_656_0 then
				arg_653_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_656_2 = 0
			local var_656_3 = 0.225

			if var_656_2 < arg_653_1.time_ and arg_653_1.time_ <= var_656_2 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, true)

				local var_656_4 = arg_653_1:FormatText(StoryNameCfg[6].name)

				arg_653_1.leftNameTxt_.text = var_656_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_653_1.leftNameTxt_.transform)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1.leftNameTxt_.text)
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_5 = arg_653_1:GetWordFromCfg(120021159)
				local var_656_6 = arg_653_1:FormatText(var_656_5.content)

				arg_653_1.text_.text = var_656_6

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_7 = 9
				local var_656_8 = utf8.len(var_656_6)
				local var_656_9 = var_656_7 <= 0 and var_656_3 or var_656_3 * (var_656_8 / var_656_7)

				if var_656_9 > 0 and var_656_3 < var_656_9 then
					arg_653_1.talkMaxDuration = var_656_9

					if var_656_9 + var_656_2 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_9 + var_656_2
					end
				end

				arg_653_1.text_.text = var_656_6
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021159", "story_v_out_120021.awb") ~= 0 then
					local var_656_10 = manager.audio:GetVoiceLength("story_v_out_120021", "120021159", "story_v_out_120021.awb") / 1000

					if var_656_10 + var_656_2 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_10 + var_656_2
					end

					if var_656_5.prefab_name ~= "" and arg_653_1.actors_[var_656_5.prefab_name] ~= nil then
						local var_656_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_653_1.actors_[var_656_5.prefab_name].transform, "story_v_out_120021", "120021159", "story_v_out_120021.awb")

						arg_653_1:RecordAudio("120021159", var_656_11)
						arg_653_1:RecordAudio("120021159", var_656_11)
					else
						arg_653_1:AudioAction("play", "voice", "story_v_out_120021", "120021159", "story_v_out_120021.awb")
					end

					arg_653_1:RecordHistoryTalkVoice("story_v_out_120021", "120021159", "story_v_out_120021.awb")
				end

				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_12 = math.max(var_656_3, arg_653_1.talkMaxDuration)

			if var_656_2 <= arg_653_1.time_ and arg_653_1.time_ < var_656_2 + var_656_12 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_2) / var_656_12

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_2 + var_656_12 and arg_653_1.time_ < var_656_2 + var_656_12 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play120021160 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 120021160
		arg_657_1.duration_ = 6.1

		local var_657_0 = {
			zh = 6.1,
			ja = 5.6
		}
		local var_657_1 = manager.audio:GetLocalizationFlag()

		if var_657_0[var_657_1] ~= nil then
			arg_657_1.duration_ = var_657_0[var_657_1]
		end

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play120021161(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			local var_660_0 = arg_657_1.actors_["1075ui_story"]
			local var_660_1 = 0

			if var_660_1 < arg_657_1.time_ and arg_657_1.time_ <= var_660_1 + arg_660_0 and not isNil(var_660_0) and arg_657_1.var_.characterEffect1075ui_story == nil then
				arg_657_1.var_.characterEffect1075ui_story = var_660_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_660_2 = 0.2

			if var_660_1 <= arg_657_1.time_ and arg_657_1.time_ < var_660_1 + var_660_2 and not isNil(var_660_0) then
				local var_660_3 = (arg_657_1.time_ - var_660_1) / var_660_2

				if arg_657_1.var_.characterEffect1075ui_story and not isNil(var_660_0) then
					arg_657_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_657_1.time_ >= var_660_1 + var_660_2 and arg_657_1.time_ < var_660_1 + var_660_2 + arg_660_0 and not isNil(var_660_0) and arg_657_1.var_.characterEffect1075ui_story then
				arg_657_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_660_4 = arg_657_1.actors_["1084ui_story"]
			local var_660_5 = 0

			if var_660_5 < arg_657_1.time_ and arg_657_1.time_ <= var_660_5 + arg_660_0 and not isNil(var_660_4) and arg_657_1.var_.characterEffect1084ui_story == nil then
				arg_657_1.var_.characterEffect1084ui_story = var_660_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_660_6 = 0.2

			if var_660_5 <= arg_657_1.time_ and arg_657_1.time_ < var_660_5 + var_660_6 and not isNil(var_660_4) then
				local var_660_7 = (arg_657_1.time_ - var_660_5) / var_660_6

				if arg_657_1.var_.characterEffect1084ui_story and not isNil(var_660_4) then
					local var_660_8 = Mathf.Lerp(0, 0.5, var_660_7)

					arg_657_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_657_1.var_.characterEffect1084ui_story.fillRatio = var_660_8
				end
			end

			if arg_657_1.time_ >= var_660_5 + var_660_6 and arg_657_1.time_ < var_660_5 + var_660_6 + arg_660_0 and not isNil(var_660_4) and arg_657_1.var_.characterEffect1084ui_story then
				local var_660_9 = 0.5

				arg_657_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_657_1.var_.characterEffect1084ui_story.fillRatio = var_660_9
			end

			local var_660_10 = 0

			if var_660_10 < arg_657_1.time_ and arg_657_1.time_ <= var_660_10 + arg_660_0 then
				arg_657_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			local var_660_11 = 0

			if var_660_11 < arg_657_1.time_ and arg_657_1.time_ <= var_660_11 + arg_660_0 then
				arg_657_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_660_12 = 0
			local var_660_13 = 0.75

			if var_660_12 < arg_657_1.time_ and arg_657_1.time_ <= var_660_12 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, true)

				local var_660_14 = arg_657_1:FormatText(StoryNameCfg[381].name)

				arg_657_1.leftNameTxt_.text = var_660_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_657_1.leftNameTxt_.transform)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1.leftNameTxt_.text)
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_15 = arg_657_1:GetWordFromCfg(120021160)
				local var_660_16 = arg_657_1:FormatText(var_660_15.content)

				arg_657_1.text_.text = var_660_16

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_17 = 30
				local var_660_18 = utf8.len(var_660_16)
				local var_660_19 = var_660_17 <= 0 and var_660_13 or var_660_13 * (var_660_18 / var_660_17)

				if var_660_19 > 0 and var_660_13 < var_660_19 then
					arg_657_1.talkMaxDuration = var_660_19

					if var_660_19 + var_660_12 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_19 + var_660_12
					end
				end

				arg_657_1.text_.text = var_660_16
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021160", "story_v_out_120021.awb") ~= 0 then
					local var_660_20 = manager.audio:GetVoiceLength("story_v_out_120021", "120021160", "story_v_out_120021.awb") / 1000

					if var_660_20 + var_660_12 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_20 + var_660_12
					end

					if var_660_15.prefab_name ~= "" and arg_657_1.actors_[var_660_15.prefab_name] ~= nil then
						local var_660_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_657_1.actors_[var_660_15.prefab_name].transform, "story_v_out_120021", "120021160", "story_v_out_120021.awb")

						arg_657_1:RecordAudio("120021160", var_660_21)
						arg_657_1:RecordAudio("120021160", var_660_21)
					else
						arg_657_1:AudioAction("play", "voice", "story_v_out_120021", "120021160", "story_v_out_120021.awb")
					end

					arg_657_1:RecordHistoryTalkVoice("story_v_out_120021", "120021160", "story_v_out_120021.awb")
				end

				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_22 = math.max(var_660_13, arg_657_1.talkMaxDuration)

			if var_660_12 <= arg_657_1.time_ and arg_657_1.time_ < var_660_12 + var_660_22 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_12) / var_660_22

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_12 + var_660_22 and arg_657_1.time_ < var_660_12 + var_660_22 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {}

		arg_657_1:InitPlayNodeList()
	end,
	Play120021161 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 120021161
		arg_661_1.duration_ = 5

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play120021162(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			local var_664_0 = arg_661_1.actors_["1075ui_story"]
			local var_664_1 = 0

			if var_664_1 < arg_661_1.time_ and arg_661_1.time_ <= var_664_1 + arg_664_0 and not isNil(var_664_0) and arg_661_1.var_.characterEffect1075ui_story == nil then
				arg_661_1.var_.characterEffect1075ui_story = var_664_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_664_2 = 0.2

			if var_664_1 <= arg_661_1.time_ and arg_661_1.time_ < var_664_1 + var_664_2 and not isNil(var_664_0) then
				local var_664_3 = (arg_661_1.time_ - var_664_1) / var_664_2

				if arg_661_1.var_.characterEffect1075ui_story and not isNil(var_664_0) then
					local var_664_4 = Mathf.Lerp(0, 0.5, var_664_3)

					arg_661_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_661_1.var_.characterEffect1075ui_story.fillRatio = var_664_4
				end
			end

			if arg_661_1.time_ >= var_664_1 + var_664_2 and arg_661_1.time_ < var_664_1 + var_664_2 + arg_664_0 and not isNil(var_664_0) and arg_661_1.var_.characterEffect1075ui_story then
				local var_664_5 = 0.5

				arg_661_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_661_1.var_.characterEffect1075ui_story.fillRatio = var_664_5
			end

			local var_664_6 = 0
			local var_664_7 = 0.1

			if var_664_6 < arg_661_1.time_ and arg_661_1.time_ <= var_664_6 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0
				arg_661_1.dialogCg_.alpha = 1

				arg_661_1.dialog_:SetActive(true)
				SetActive(arg_661_1.leftNameGo_, true)

				local var_664_8 = arg_661_1:FormatText(StoryNameCfg[7].name)

				arg_661_1.leftNameTxt_.text = var_664_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_661_1.leftNameTxt_.transform)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1.leftNameTxt_.text)
				SetActive(arg_661_1.iconTrs_.gameObject, true)
				arg_661_1.iconController_:SetSelectedState("hero")

				arg_661_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_661_1.callingController_:SetSelectedState("normal")

				arg_661_1.keyicon_.color = Color.New(1, 1, 1)
				arg_661_1.icon_.color = Color.New(1, 1, 1)

				local var_664_9 = arg_661_1:GetWordFromCfg(120021161)
				local var_664_10 = arg_661_1:FormatText(var_664_9.content)

				arg_661_1.text_.text = var_664_10

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_11 = 4
				local var_664_12 = utf8.len(var_664_10)
				local var_664_13 = var_664_11 <= 0 and var_664_7 or var_664_7 * (var_664_12 / var_664_11)

				if var_664_13 > 0 and var_664_7 < var_664_13 then
					arg_661_1.talkMaxDuration = var_664_13

					if var_664_13 + var_664_6 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_13 + var_664_6
					end
				end

				arg_661_1.text_.text = var_664_10
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)
				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_14 = math.max(var_664_7, arg_661_1.talkMaxDuration)

			if var_664_6 <= arg_661_1.time_ and arg_661_1.time_ < var_664_6 + var_664_14 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_6) / var_664_14

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_6 + var_664_14 and arg_661_1.time_ < var_664_6 + var_664_14 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {}

		arg_661_1:InitPlayNodeList()
	end,
	Play120021162 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 120021162
		arg_665_1.duration_ = 5.93

		local var_665_0 = {
			zh = 3.4,
			ja = 5.933
		}
		local var_665_1 = manager.audio:GetLocalizationFlag()

		if var_665_0[var_665_1] ~= nil then
			arg_665_1.duration_ = var_665_0[var_665_1]
		end

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play120021163(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			local var_668_0 = arg_665_1.actors_["1075ui_story"]
			local var_668_1 = 0

			if var_668_1 < arg_665_1.time_ and arg_665_1.time_ <= var_668_1 + arg_668_0 and not isNil(var_668_0) and arg_665_1.var_.characterEffect1075ui_story == nil then
				arg_665_1.var_.characterEffect1075ui_story = var_668_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_668_2 = 0.2

			if var_668_1 <= arg_665_1.time_ and arg_665_1.time_ < var_668_1 + var_668_2 and not isNil(var_668_0) then
				local var_668_3 = (arg_665_1.time_ - var_668_1) / var_668_2

				if arg_665_1.var_.characterEffect1075ui_story and not isNil(var_668_0) then
					arg_665_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_665_1.time_ >= var_668_1 + var_668_2 and arg_665_1.time_ < var_668_1 + var_668_2 + arg_668_0 and not isNil(var_668_0) and arg_665_1.var_.characterEffect1075ui_story then
				arg_665_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_668_4 = 0
			local var_668_5 = 0.4

			if var_668_4 < arg_665_1.time_ and arg_665_1.time_ <= var_668_4 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0
				arg_665_1.dialogCg_.alpha = 1

				arg_665_1.dialog_:SetActive(true)
				SetActive(arg_665_1.leftNameGo_, true)

				local var_668_6 = arg_665_1:FormatText(StoryNameCfg[381].name)

				arg_665_1.leftNameTxt_.text = var_668_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_665_1.leftNameTxt_.transform)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1.leftNameTxt_.text)
				SetActive(arg_665_1.iconTrs_.gameObject, false)
				arg_665_1.callingController_:SetSelectedState("normal")

				local var_668_7 = arg_665_1:GetWordFromCfg(120021162)
				local var_668_8 = arg_665_1:FormatText(var_668_7.content)

				arg_665_1.text_.text = var_668_8

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_9 = 16
				local var_668_10 = utf8.len(var_668_8)
				local var_668_11 = var_668_9 <= 0 and var_668_5 or var_668_5 * (var_668_10 / var_668_9)

				if var_668_11 > 0 and var_668_5 < var_668_11 then
					arg_665_1.talkMaxDuration = var_668_11

					if var_668_11 + var_668_4 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_11 + var_668_4
					end
				end

				arg_665_1.text_.text = var_668_8
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021162", "story_v_out_120021.awb") ~= 0 then
					local var_668_12 = manager.audio:GetVoiceLength("story_v_out_120021", "120021162", "story_v_out_120021.awb") / 1000

					if var_668_12 + var_668_4 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_12 + var_668_4
					end

					if var_668_7.prefab_name ~= "" and arg_665_1.actors_[var_668_7.prefab_name] ~= nil then
						local var_668_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_665_1.actors_[var_668_7.prefab_name].transform, "story_v_out_120021", "120021162", "story_v_out_120021.awb")

						arg_665_1:RecordAudio("120021162", var_668_13)
						arg_665_1:RecordAudio("120021162", var_668_13)
					else
						arg_665_1:AudioAction("play", "voice", "story_v_out_120021", "120021162", "story_v_out_120021.awb")
					end

					arg_665_1:RecordHistoryTalkVoice("story_v_out_120021", "120021162", "story_v_out_120021.awb")
				end

				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_14 = math.max(var_668_5, arg_665_1.talkMaxDuration)

			if var_668_4 <= arg_665_1.time_ and arg_665_1.time_ < var_668_4 + var_668_14 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - var_668_4) / var_668_14

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= var_668_4 + var_668_14 and arg_665_1.time_ < var_668_4 + var_668_14 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {}

		arg_665_1:InitPlayNodeList()
	end,
	Play120021163 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 120021163
		arg_669_1.duration_ = 4.6

		local var_669_0 = {
			zh = 3.2,
			ja = 4.6
		}
		local var_669_1 = manager.audio:GetLocalizationFlag()

		if var_669_0[var_669_1] ~= nil then
			arg_669_1.duration_ = var_669_0[var_669_1]
		end

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play120021164(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			local var_672_0 = 0
			local var_672_1 = 0.375

			if var_672_0 < arg_669_1.time_ and arg_669_1.time_ <= var_672_0 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, true)

				local var_672_2 = arg_669_1:FormatText(StoryNameCfg[381].name)

				arg_669_1.leftNameTxt_.text = var_672_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_669_1.leftNameTxt_.transform)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1.leftNameTxt_.text)
				SetActive(arg_669_1.iconTrs_.gameObject, false)
				arg_669_1.callingController_:SetSelectedState("normal")

				local var_672_3 = arg_669_1:GetWordFromCfg(120021163)
				local var_672_4 = arg_669_1:FormatText(var_672_3.content)

				arg_669_1.text_.text = var_672_4

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_5 = 15
				local var_672_6 = utf8.len(var_672_4)
				local var_672_7 = var_672_5 <= 0 and var_672_1 or var_672_1 * (var_672_6 / var_672_5)

				if var_672_7 > 0 and var_672_1 < var_672_7 then
					arg_669_1.talkMaxDuration = var_672_7

					if var_672_7 + var_672_0 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_7 + var_672_0
					end
				end

				arg_669_1.text_.text = var_672_4
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021163", "story_v_out_120021.awb") ~= 0 then
					local var_672_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021163", "story_v_out_120021.awb") / 1000

					if var_672_8 + var_672_0 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_8 + var_672_0
					end

					if var_672_3.prefab_name ~= "" and arg_669_1.actors_[var_672_3.prefab_name] ~= nil then
						local var_672_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_669_1.actors_[var_672_3.prefab_name].transform, "story_v_out_120021", "120021163", "story_v_out_120021.awb")

						arg_669_1:RecordAudio("120021163", var_672_9)
						arg_669_1:RecordAudio("120021163", var_672_9)
					else
						arg_669_1:AudioAction("play", "voice", "story_v_out_120021", "120021163", "story_v_out_120021.awb")
					end

					arg_669_1:RecordHistoryTalkVoice("story_v_out_120021", "120021163", "story_v_out_120021.awb")
				end

				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_10 = math.max(var_672_1, arg_669_1.talkMaxDuration)

			if var_672_0 <= arg_669_1.time_ and arg_669_1.time_ < var_672_0 + var_672_10 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - var_672_0) / var_672_10

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= var_672_0 + var_672_10 and arg_669_1.time_ < var_672_0 + var_672_10 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {}

		arg_669_1:InitPlayNodeList()
	end,
	Play120021164 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 120021164
		arg_673_1.duration_ = 5

		SetActive(arg_673_1.tipsGo_, false)

		function arg_673_1.onSingleLineFinish_()
			arg_673_1.onSingleLineUpdate_ = nil
			arg_673_1.onSingleLineFinish_ = nil
			arg_673_1.state_ = "waiting"
		end

		function arg_673_1.playNext_(arg_675_0)
			if arg_675_0 == 1 then
				arg_673_0:Play120021165(arg_673_1)
			end
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			local var_676_0 = arg_673_1.actors_["1084ui_story"].transform
			local var_676_1 = 0

			if var_676_1 < arg_673_1.time_ and arg_673_1.time_ <= var_676_1 + arg_676_0 then
				arg_673_1.var_.moveOldPos1084ui_story = var_676_0.localPosition
			end

			local var_676_2 = 0.001

			if var_676_1 <= arg_673_1.time_ and arg_673_1.time_ < var_676_1 + var_676_2 then
				local var_676_3 = (arg_673_1.time_ - var_676_1) / var_676_2
				local var_676_4 = Vector3.New(0, 100, 0)

				var_676_0.localPosition = Vector3.Lerp(arg_673_1.var_.moveOldPos1084ui_story, var_676_4, var_676_3)

				local var_676_5 = manager.ui.mainCamera.transform.position - var_676_0.position

				var_676_0.forward = Vector3.New(var_676_5.x, var_676_5.y, var_676_5.z)

				local var_676_6 = var_676_0.localEulerAngles

				var_676_6.z = 0
				var_676_6.x = 0
				var_676_0.localEulerAngles = var_676_6
			end

			if arg_673_1.time_ >= var_676_1 + var_676_2 and arg_673_1.time_ < var_676_1 + var_676_2 + arg_676_0 then
				var_676_0.localPosition = Vector3.New(0, 100, 0)

				local var_676_7 = manager.ui.mainCamera.transform.position - var_676_0.position

				var_676_0.forward = Vector3.New(var_676_7.x, var_676_7.y, var_676_7.z)

				local var_676_8 = var_676_0.localEulerAngles

				var_676_8.z = 0
				var_676_8.x = 0
				var_676_0.localEulerAngles = var_676_8
			end

			local var_676_9 = arg_673_1.actors_["10044ui_story"].transform
			local var_676_10 = 0

			if var_676_10 < arg_673_1.time_ and arg_673_1.time_ <= var_676_10 + arg_676_0 then
				arg_673_1.var_.moveOldPos10044ui_story = var_676_9.localPosition
			end

			local var_676_11 = 0.001

			if var_676_10 <= arg_673_1.time_ and arg_673_1.time_ < var_676_10 + var_676_11 then
				local var_676_12 = (arg_673_1.time_ - var_676_10) / var_676_11
				local var_676_13 = Vector3.New(0, -0.72, -6.3)

				var_676_9.localPosition = Vector3.Lerp(arg_673_1.var_.moveOldPos10044ui_story, var_676_13, var_676_12)

				local var_676_14 = manager.ui.mainCamera.transform.position - var_676_9.position

				var_676_9.forward = Vector3.New(var_676_14.x, var_676_14.y, var_676_14.z)

				local var_676_15 = var_676_9.localEulerAngles

				var_676_15.z = 0
				var_676_15.x = 0
				var_676_9.localEulerAngles = var_676_15
			end

			if arg_673_1.time_ >= var_676_10 + var_676_11 and arg_673_1.time_ < var_676_10 + var_676_11 + arg_676_0 then
				var_676_9.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_676_16 = manager.ui.mainCamera.transform.position - var_676_9.position

				var_676_9.forward = Vector3.New(var_676_16.x, var_676_16.y, var_676_16.z)

				local var_676_17 = var_676_9.localEulerAngles

				var_676_17.z = 0
				var_676_17.x = 0
				var_676_9.localEulerAngles = var_676_17
			end

			local var_676_18 = arg_673_1.actors_["1075ui_story"]
			local var_676_19 = 0

			if var_676_19 < arg_673_1.time_ and arg_673_1.time_ <= var_676_19 + arg_676_0 and not isNil(var_676_18) and arg_673_1.var_.characterEffect1075ui_story == nil then
				arg_673_1.var_.characterEffect1075ui_story = var_676_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_676_20 = 0.034

			if var_676_19 <= arg_673_1.time_ and arg_673_1.time_ < var_676_19 + var_676_20 and not isNil(var_676_18) then
				local var_676_21 = (arg_673_1.time_ - var_676_19) / var_676_20

				if arg_673_1.var_.characterEffect1075ui_story and not isNil(var_676_18) then
					local var_676_22 = Mathf.Lerp(0, 0.5, var_676_21)

					arg_673_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_673_1.var_.characterEffect1075ui_story.fillRatio = var_676_22
				end
			end

			if arg_673_1.time_ >= var_676_19 + var_676_20 and arg_673_1.time_ < var_676_19 + var_676_20 + arg_676_0 and not isNil(var_676_18) and arg_673_1.var_.characterEffect1075ui_story then
				local var_676_23 = 0.5

				arg_673_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_673_1.var_.characterEffect1075ui_story.fillRatio = var_676_23
			end

			local var_676_24 = 0
			local var_676_25 = 1

			if var_676_24 < arg_673_1.time_ and arg_673_1.time_ <= var_676_24 + arg_676_0 then
				local var_676_26 = "play"
				local var_676_27 = "effect"

				arg_673_1:AudioAction(var_676_26, var_676_27, "se_story_120_00", "se_story_120_00_tool", "")
			end

			local var_676_28 = 0

			if var_676_28 < arg_673_1.time_ and arg_673_1.time_ <= var_676_28 + arg_676_0 then
				arg_673_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_676_29 = 0

			if var_676_29 < arg_673_1.time_ and arg_673_1.time_ <= var_676_29 + arg_676_0 then
				arg_673_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_676_30 = arg_673_1.actors_["1075ui_story"].transform
			local var_676_31 = 0

			if var_676_31 < arg_673_1.time_ and arg_673_1.time_ <= var_676_31 + arg_676_0 then
				arg_673_1.var_.moveOldPos1075ui_story = var_676_30.localPosition
			end

			local var_676_32 = 0.001

			if var_676_31 <= arg_673_1.time_ and arg_673_1.time_ < var_676_31 + var_676_32 then
				local var_676_33 = (arg_673_1.time_ - var_676_31) / var_676_32
				local var_676_34 = Vector3.New(0, 100, 0)

				var_676_30.localPosition = Vector3.Lerp(arg_673_1.var_.moveOldPos1075ui_story, var_676_34, var_676_33)

				local var_676_35 = manager.ui.mainCamera.transform.position - var_676_30.position

				var_676_30.forward = Vector3.New(var_676_35.x, var_676_35.y, var_676_35.z)

				local var_676_36 = var_676_30.localEulerAngles

				var_676_36.z = 0
				var_676_36.x = 0
				var_676_30.localEulerAngles = var_676_36
			end

			if arg_673_1.time_ >= var_676_31 + var_676_32 and arg_673_1.time_ < var_676_31 + var_676_32 + arg_676_0 then
				var_676_30.localPosition = Vector3.New(0, 100, 0)

				local var_676_37 = manager.ui.mainCamera.transform.position - var_676_30.position

				var_676_30.forward = Vector3.New(var_676_37.x, var_676_37.y, var_676_37.z)

				local var_676_38 = var_676_30.localEulerAngles

				var_676_38.z = 0
				var_676_38.x = 0
				var_676_30.localEulerAngles = var_676_38
			end

			local var_676_39 = 0
			local var_676_40 = 0.75

			if var_676_39 < arg_673_1.time_ and arg_673_1.time_ <= var_676_39 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0
				arg_673_1.dialogCg_.alpha = 1

				arg_673_1.dialog_:SetActive(true)
				SetActive(arg_673_1.leftNameGo_, false)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_673_1.iconTrs_.gameObject, false)
				arg_673_1.callingController_:SetSelectedState("normal")

				local var_676_41 = arg_673_1:GetWordFromCfg(120021164)
				local var_676_42 = arg_673_1:FormatText(var_676_41.content)

				arg_673_1.text_.text = var_676_42

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_43 = 30
				local var_676_44 = utf8.len(var_676_42)
				local var_676_45 = var_676_43 <= 0 and var_676_40 or var_676_40 * (var_676_44 / var_676_43)

				if var_676_45 > 0 and var_676_40 < var_676_45 then
					arg_673_1.talkMaxDuration = var_676_45

					if var_676_45 + var_676_39 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_45 + var_676_39
					end
				end

				arg_673_1.text_.text = var_676_42
				arg_673_1.typewritter.percent = 0

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(false)
				arg_673_1:RecordContent(arg_673_1.text_.text)
			end

			local var_676_46 = math.max(var_676_40, arg_673_1.talkMaxDuration)

			if var_676_39 <= arg_673_1.time_ and arg_673_1.time_ < var_676_39 + var_676_46 then
				arg_673_1.typewritter.percent = (arg_673_1.time_ - var_676_39) / var_676_46

				arg_673_1.typewritter:SetDirty()
			end

			if arg_673_1.time_ >= var_676_39 + var_676_46 and arg_673_1.time_ < var_676_39 + var_676_46 + arg_676_0 then
				arg_673_1.typewritter.percent = 1

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(true)
			end
		end

		arg_673_1.nodeConfigList_ = {
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

		arg_673_1:InitPlayNodeList()
	end,
	Play120021165 = function(arg_677_0, arg_677_1)
		arg_677_1.time_ = 0
		arg_677_1.frameCnt_ = 0
		arg_677_1.state_ = "playing"
		arg_677_1.curTalkId_ = 120021165
		arg_677_1.duration_ = 2.9

		local var_677_0 = {
			zh = 1.5,
			ja = 2.9
		}
		local var_677_1 = manager.audio:GetLocalizationFlag()

		if var_677_0[var_677_1] ~= nil then
			arg_677_1.duration_ = var_677_0[var_677_1]
		end

		SetActive(arg_677_1.tipsGo_, false)

		function arg_677_1.onSingleLineFinish_()
			arg_677_1.onSingleLineUpdate_ = nil
			arg_677_1.onSingleLineFinish_ = nil
			arg_677_1.state_ = "waiting"
		end

		function arg_677_1.playNext_(arg_679_0)
			if arg_679_0 == 1 then
				arg_677_0:Play120021166(arg_677_1)
			end
		end

		function arg_677_1.onSingleLineUpdate_(arg_680_0)
			local var_680_0 = arg_677_1.actors_["10044ui_story"]
			local var_680_1 = 0

			if var_680_1 < arg_677_1.time_ and arg_677_1.time_ <= var_680_1 + arg_680_0 and not isNil(var_680_0) and arg_677_1.var_.characterEffect10044ui_story == nil then
				arg_677_1.var_.characterEffect10044ui_story = var_680_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_680_2 = 0.2

			if var_680_1 <= arg_677_1.time_ and arg_677_1.time_ < var_680_1 + var_680_2 and not isNil(var_680_0) then
				local var_680_3 = (arg_677_1.time_ - var_680_1) / var_680_2

				if arg_677_1.var_.characterEffect10044ui_story and not isNil(var_680_0) then
					arg_677_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_677_1.time_ >= var_680_1 + var_680_2 and arg_677_1.time_ < var_680_1 + var_680_2 + arg_680_0 and not isNil(var_680_0) and arg_677_1.var_.characterEffect10044ui_story then
				arg_677_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_680_4 = 0
			local var_680_5 = 0.175

			if var_680_4 < arg_677_1.time_ and arg_677_1.time_ <= var_680_4 + arg_680_0 then
				arg_677_1.talkMaxDuration = 0
				arg_677_1.dialogCg_.alpha = 1

				arg_677_1.dialog_:SetActive(true)
				SetActive(arg_677_1.leftNameGo_, true)

				local var_680_6 = arg_677_1:FormatText(StoryNameCfg[380].name)

				arg_677_1.leftNameTxt_.text = var_680_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_677_1.leftNameTxt_.transform)

				arg_677_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_677_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_677_1:RecordName(arg_677_1.leftNameTxt_.text)
				SetActive(arg_677_1.iconTrs_.gameObject, false)
				arg_677_1.callingController_:SetSelectedState("normal")

				local var_680_7 = arg_677_1:GetWordFromCfg(120021165)
				local var_680_8 = arg_677_1:FormatText(var_680_7.content)

				arg_677_1.text_.text = var_680_8

				LuaForUtil.ClearLinePrefixSymbol(arg_677_1.text_)

				local var_680_9 = 7
				local var_680_10 = utf8.len(var_680_8)
				local var_680_11 = var_680_9 <= 0 and var_680_5 or var_680_5 * (var_680_10 / var_680_9)

				if var_680_11 > 0 and var_680_5 < var_680_11 then
					arg_677_1.talkMaxDuration = var_680_11

					if var_680_11 + var_680_4 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_11 + var_680_4
					end
				end

				arg_677_1.text_.text = var_680_8
				arg_677_1.typewritter.percent = 0

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021165", "story_v_out_120021.awb") ~= 0 then
					local var_680_12 = manager.audio:GetVoiceLength("story_v_out_120021", "120021165", "story_v_out_120021.awb") / 1000

					if var_680_12 + var_680_4 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_12 + var_680_4
					end

					if var_680_7.prefab_name ~= "" and arg_677_1.actors_[var_680_7.prefab_name] ~= nil then
						local var_680_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_677_1.actors_[var_680_7.prefab_name].transform, "story_v_out_120021", "120021165", "story_v_out_120021.awb")

						arg_677_1:RecordAudio("120021165", var_680_13)
						arg_677_1:RecordAudio("120021165", var_680_13)
					else
						arg_677_1:AudioAction("play", "voice", "story_v_out_120021", "120021165", "story_v_out_120021.awb")
					end

					arg_677_1:RecordHistoryTalkVoice("story_v_out_120021", "120021165", "story_v_out_120021.awb")
				end

				arg_677_1:RecordContent(arg_677_1.text_.text)
			end

			local var_680_14 = math.max(var_680_5, arg_677_1.talkMaxDuration)

			if var_680_4 <= arg_677_1.time_ and arg_677_1.time_ < var_680_4 + var_680_14 then
				arg_677_1.typewritter.percent = (arg_677_1.time_ - var_680_4) / var_680_14

				arg_677_1.typewritter:SetDirty()
			end

			if arg_677_1.time_ >= var_680_4 + var_680_14 and arg_677_1.time_ < var_680_4 + var_680_14 + arg_680_0 then
				arg_677_1.typewritter.percent = 1

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(true)
			end
		end

		arg_677_1.nodeConfigList_ = {}

		arg_677_1:InitPlayNodeList()
	end,
	Play120021166 = function(arg_681_0, arg_681_1)
		arg_681_1.time_ = 0
		arg_681_1.frameCnt_ = 0
		arg_681_1.state_ = "playing"
		arg_681_1.curTalkId_ = 120021166
		arg_681_1.duration_ = 6.37

		local var_681_0 = {
			zh = 4.5,
			ja = 6.366
		}
		local var_681_1 = manager.audio:GetLocalizationFlag()

		if var_681_0[var_681_1] ~= nil then
			arg_681_1.duration_ = var_681_0[var_681_1]
		end

		SetActive(arg_681_1.tipsGo_, false)

		function arg_681_1.onSingleLineFinish_()
			arg_681_1.onSingleLineUpdate_ = nil
			arg_681_1.onSingleLineFinish_ = nil
			arg_681_1.state_ = "waiting"
			arg_681_1.auto_ = false
		end

		function arg_681_1.playNext_(arg_683_0)
			arg_681_1.onStoryFinished_()
		end

		function arg_681_1.onSingleLineUpdate_(arg_684_0)
			local var_684_0 = 0
			local var_684_1 = 0.625

			if var_684_0 < arg_681_1.time_ and arg_681_1.time_ <= var_684_0 + arg_684_0 then
				arg_681_1.talkMaxDuration = 0
				arg_681_1.dialogCg_.alpha = 1

				arg_681_1.dialog_:SetActive(true)
				SetActive(arg_681_1.leftNameGo_, true)

				local var_684_2 = arg_681_1:FormatText(StoryNameCfg[380].name)

				arg_681_1.leftNameTxt_.text = var_684_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_681_1.leftNameTxt_.transform)

				arg_681_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_681_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_681_1:RecordName(arg_681_1.leftNameTxt_.text)
				SetActive(arg_681_1.iconTrs_.gameObject, false)
				arg_681_1.callingController_:SetSelectedState("normal")

				local var_684_3 = arg_681_1:GetWordFromCfg(120021166)
				local var_684_4 = arg_681_1:FormatText(var_684_3.content)

				arg_681_1.text_.text = var_684_4

				LuaForUtil.ClearLinePrefixSymbol(arg_681_1.text_)

				local var_684_5 = 25
				local var_684_6 = utf8.len(var_684_4)
				local var_684_7 = var_684_5 <= 0 and var_684_1 or var_684_1 * (var_684_6 / var_684_5)

				if var_684_7 > 0 and var_684_1 < var_684_7 then
					arg_681_1.talkMaxDuration = var_684_7

					if var_684_7 + var_684_0 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_7 + var_684_0
					end
				end

				arg_681_1.text_.text = var_684_4
				arg_681_1.typewritter.percent = 0

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120021", "120021166", "story_v_out_120021.awb") ~= 0 then
					local var_684_8 = manager.audio:GetVoiceLength("story_v_out_120021", "120021166", "story_v_out_120021.awb") / 1000

					if var_684_8 + var_684_0 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_8 + var_684_0
					end

					if var_684_3.prefab_name ~= "" and arg_681_1.actors_[var_684_3.prefab_name] ~= nil then
						local var_684_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_681_1.actors_[var_684_3.prefab_name].transform, "story_v_out_120021", "120021166", "story_v_out_120021.awb")

						arg_681_1:RecordAudio("120021166", var_684_9)
						arg_681_1:RecordAudio("120021166", var_684_9)
					else
						arg_681_1:AudioAction("play", "voice", "story_v_out_120021", "120021166", "story_v_out_120021.awb")
					end

					arg_681_1:RecordHistoryTalkVoice("story_v_out_120021", "120021166", "story_v_out_120021.awb")
				end

				arg_681_1:RecordContent(arg_681_1.text_.text)
			end

			local var_684_10 = math.max(var_684_1, arg_681_1.talkMaxDuration)

			if var_684_0 <= arg_681_1.time_ and arg_681_1.time_ < var_684_0 + var_684_10 then
				arg_681_1.typewritter.percent = (arg_681_1.time_ - var_684_0) / var_684_10

				arg_681_1.typewritter:SetDirty()
			end

			if arg_681_1.time_ >= var_684_0 + var_684_10 and arg_681_1.time_ < var_684_0 + var_684_10 + arg_684_0 then
				arg_681_1.typewritter.percent = 1

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(true)
			end
		end

		arg_681_1.nodeConfigList_ = {}

		arg_681_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST29",
		"TextureConfig/Background/XH0103",
		"TextureConfig/Background/XH0108",
		"TextureConfig/Background/ST32"
	},
	voices = {
		"story_v_out_120021.awb"
	}
}
