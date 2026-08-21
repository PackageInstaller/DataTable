return {
	Play111171001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111171001
		arg_1_1.duration_ = 4.33

		local var_1_0 = {
			ja = 2.999999999999,
			ko = 4.334,
			zh = 3.634,
			en = 3.334
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
				arg_1_0:Play111171002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST10"

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
				local var_4_5 = arg_1_1.bgs_.ST10

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
					if iter_4_0 ~= "ST10" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.ST10
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueST10 = var_4_18.color.a
					arg_1_1.var_.alphaMatValueST10 = var_4_18
				end

				arg_1_1.var_.alphaOldValueST10 = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueST10, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueST10 then
					local var_4_22 = arg_1_1.var_.alphaMatValueST10.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueST10.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueST10 then
				local var_4_23 = arg_1_1.var_.alphaMatValueST10
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = "1019ui_story"

			if arg_1_1.actors_[var_4_25] == nil then
				local var_4_26 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_4_26) then
					local var_4_27 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_1_1.stage_.transform)

					var_4_27.name = var_4_25
					var_4_27.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_25] = var_4_27

					local var_4_28 = var_4_27:GetComponentInChildren(typeof(CharacterEffect))

					var_4_28.enabled = true

					local var_4_29 = GameObjectTools.GetOrAddComponent(var_4_27, typeof(DynamicBoneHelper))

					if var_4_29 then
						var_4_29:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_28.transform, false)

					arg_1_1.var_[var_4_25 .. "Animator"] = var_4_28.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_25 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_25 .. "LipSync"] = var_4_28.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_30 = arg_1_1.actors_["1019ui_story"].transform
			local var_4_31 = 1.5

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.var_.moveOldPos1019ui_story = var_4_30.localPosition
			end

			local var_4_32 = 0.001

			if var_4_31 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_31) / var_4_32
				local var_4_34 = Vector3.New(-0.7, -1.08, -5.9)

				var_4_30.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1019ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_30.position

				var_4_30.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_30.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_30.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				var_4_30.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_4_37 = manager.ui.mainCamera.transform.position - var_4_30.position

				var_4_30.forward = Vector3.New(var_4_37.x, var_4_37.y, var_4_37.z)

				local var_4_38 = var_4_30.localEulerAngles

				var_4_38.z = 0
				var_4_38.x = 0
				var_4_30.localEulerAngles = var_4_38
			end

			local var_4_39 = 1.5

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_4_40 = 1.5

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_4_41 = arg_1_1.actors_["1019ui_story"]
			local var_4_42 = 1.5

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 and not isNil(var_4_41) and arg_1_1.var_.characterEffect1019ui_story == nil then
				arg_1_1.var_.characterEffect1019ui_story = var_4_41:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_43 = 0.2

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 and not isNil(var_4_41) then
				local var_4_44 = (arg_1_1.time_ - var_4_42) / var_4_43

				if arg_1_1.var_.characterEffect1019ui_story and not isNil(var_4_41) then
					arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 and not isNil(var_4_41) and arg_1_1.var_.characterEffect1019ui_story then
				arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_4_45 = 0

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_46 = 1.534

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_47 = 0
			local var_4_48 = 1

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_49 = "play"
				local var_4_50 = "music"

				arg_1_1:AudioAction(var_4_49, var_4_50, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_51 = ""
				local var_4_52 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_53 = 1.534
			local var_4_54 = 0.25

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

				local var_4_56 = arg_1_1:FormatText(StoryNameCfg[13].name)

				arg_1_1.leftNameTxt_.text = var_4_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_57 = arg_1_1:GetWordFromCfg(111171001)
				local var_4_58 = arg_1_1:FormatText(var_4_57.content)

				arg_1_1.text_.text = var_4_58

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_59 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171001", "story_v_out_111171.awb") ~= 0 then
					local var_4_62 = manager.audio:GetVoiceLength("story_v_out_111171", "111171001", "story_v_out_111171.awb") / 1000

					if var_4_62 + var_4_53 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_53
					end

					if var_4_57.prefab_name ~= "" and arg_1_1.actors_[var_4_57.prefab_name] ~= nil then
						local var_4_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_57.prefab_name].transform, "story_v_out_111171", "111171001", "story_v_out_111171.awb")

						arg_1_1:RecordAudio("111171001", var_4_63)
						arg_1_1:RecordAudio("111171001", var_4_63)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_111171", "111171001", "story_v_out_111171.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_111171", "111171001", "story_v_out_111171.awb")
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play111171002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 111171002
		arg_8_1.duration_ = 4.73

		local var_8_0 = {
			ja = 4.333,
			ko = 4.733,
			zh = 4.466,
			en = 4.433
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
				arg_8_0:Play111171003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1066ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_8_1.stage_.transform)

					var_11_2.name = var_11_0
					var_11_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_8_1.actors_[var_11_0] = var_11_2

					local var_11_3 = var_11_2:GetComponentInChildren(typeof(CharacterEffect))

					var_11_3.enabled = true

					local var_11_4 = GameObjectTools.GetOrAddComponent(var_11_2, typeof(DynamicBoneHelper))

					if var_11_4 then
						var_11_4:EnableDynamicBone(false)
					end

					arg_8_1:ShowWeapon(var_11_3.transform, false)

					arg_8_1.var_[var_11_0 .. "Animator"] = var_11_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_8_1.var_[var_11_0 .. "Animator"].applyRootMotion = true
					arg_8_1.var_[var_11_0 .. "LipSync"] = var_11_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_11_5 = arg_8_1.actors_["1066ui_story"].transform
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.var_.moveOldPos1066ui_story = var_11_5.localPosition
			end

			local var_11_7 = 0.001

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7
				local var_11_9 = Vector3.New(0.7, -0.77, -6.1)

				var_11_5.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1066ui_story, var_11_9, var_11_8)

				local var_11_10 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_10.x, var_11_10.y, var_11_10.z)

				local var_11_11 = var_11_5.localEulerAngles

				var_11_11.z = 0
				var_11_11.x = 0
				var_11_5.localEulerAngles = var_11_11
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 then
				var_11_5.localPosition = Vector3.New(0.7, -0.77, -6.1)

				local var_11_12 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_12.x, var_11_12.y, var_11_12.z)

				local var_11_13 = var_11_5.localEulerAngles

				var_11_13.z = 0
				var_11_13.x = 0
				var_11_5.localEulerAngles = var_11_13
			end

			local var_11_14 = 0

			if var_11_14 < arg_8_1.time_ and arg_8_1.time_ <= var_11_14 + arg_11_0 then
				arg_8_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			local var_11_15 = 0

			if var_11_15 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 then
				arg_8_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_11_16 = arg_8_1.actors_["1019ui_story"]
			local var_11_17 = 0

			if var_11_17 < arg_8_1.time_ and arg_8_1.time_ <= var_11_17 + arg_11_0 and not isNil(var_11_16) and arg_8_1.var_.characterEffect1019ui_story == nil then
				arg_8_1.var_.characterEffect1019ui_story = var_11_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_18 = 0.2

			if var_11_17 <= arg_8_1.time_ and arg_8_1.time_ < var_11_17 + var_11_18 and not isNil(var_11_16) then
				local var_11_19 = (arg_8_1.time_ - var_11_17) / var_11_18

				if arg_8_1.var_.characterEffect1019ui_story and not isNil(var_11_16) then
					local var_11_20 = Mathf.Lerp(0, 0.5, var_11_19)

					arg_8_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1019ui_story.fillRatio = var_11_20
				end
			end

			if arg_8_1.time_ >= var_11_17 + var_11_18 and arg_8_1.time_ < var_11_17 + var_11_18 + arg_11_0 and not isNil(var_11_16) and arg_8_1.var_.characterEffect1019ui_story then
				local var_11_21 = 0.5

				arg_8_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1019ui_story.fillRatio = var_11_21
			end

			local var_11_22 = arg_8_1.actors_["1066ui_story"]
			local var_11_23 = 0

			if var_11_23 < arg_8_1.time_ and arg_8_1.time_ <= var_11_23 + arg_11_0 and not isNil(var_11_22) and arg_8_1.var_.characterEffect1066ui_story == nil then
				arg_8_1.var_.characterEffect1066ui_story = var_11_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_24 = 0.2

			if var_11_23 <= arg_8_1.time_ and arg_8_1.time_ < var_11_23 + var_11_24 and not isNil(var_11_22) then
				local var_11_25 = (arg_8_1.time_ - var_11_23) / var_11_24

				if arg_8_1.var_.characterEffect1066ui_story and not isNil(var_11_22) then
					arg_8_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_23 + var_11_24 and arg_8_1.time_ < var_11_23 + var_11_24 + arg_11_0 and not isNil(var_11_22) and arg_8_1.var_.characterEffect1066ui_story then
				arg_8_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_11_26 = 0
			local var_11_27 = 1

			if var_11_26 < arg_8_1.time_ and arg_8_1.time_ <= var_11_26 + arg_11_0 then
				local var_11_28 = "play"
				local var_11_29 = "music"

				arg_8_1:AudioAction(var_11_28, var_11_29, "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_11_30 = ""
				local var_11_31 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if var_11_31 ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_31 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_31

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_31
						arg_8_1.bgmTxt2_.text = var_11_31
					end

					if arg_8_1.bgmTimer then
						arg_8_1.bgmTimer:Stop()

						arg_8_1.bgmTimer = nil
					end

					if arg_8_1.settingData.show_music_name == 1 then
						arg_8_1.musicController:SetSelectedState("show")
						arg_8_1.musicAnimator_:Play("open", 0, 0)

						if arg_8_1.settingData.music_time ~= 0 then
							arg_8_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_8_1.settingData.music_time), function()
								if arg_8_1 == nil or isNil(arg_8_1.bgmTxt_) then
									return
								end

								arg_8_1.musicController:SetSelectedState("hide")
								arg_8_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_11_32 = 0
			local var_11_33 = 0.475

			if var_11_32 < arg_8_1.time_ and arg_8_1.time_ <= var_11_32 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_34 = arg_8_1:FormatText(StoryNameCfg[32].name)

				arg_8_1.leftNameTxt_.text = var_11_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_35 = arg_8_1:GetWordFromCfg(111171002)
				local var_11_36 = arg_8_1:FormatText(var_11_35.content)

				arg_8_1.text_.text = var_11_36

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_37 = 19
				local var_11_38 = utf8.len(var_11_36)
				local var_11_39 = var_11_37 <= 0 and var_11_33 or var_11_33 * (var_11_38 / var_11_37)

				if var_11_39 > 0 and var_11_33 < var_11_39 then
					arg_8_1.talkMaxDuration = var_11_39

					if var_11_39 + var_11_32 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_39 + var_11_32
					end
				end

				arg_8_1.text_.text = var_11_36
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171002", "story_v_out_111171.awb") ~= 0 then
					local var_11_40 = manager.audio:GetVoiceLength("story_v_out_111171", "111171002", "story_v_out_111171.awb") / 1000

					if var_11_40 + var_11_32 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_40 + var_11_32
					end

					if var_11_35.prefab_name ~= "" and arg_8_1.actors_[var_11_35.prefab_name] ~= nil then
						local var_11_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_35.prefab_name].transform, "story_v_out_111171", "111171002", "story_v_out_111171.awb")

						arg_8_1:RecordAudio("111171002", var_11_41)
						arg_8_1:RecordAudio("111171002", var_11_41)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_111171", "111171002", "story_v_out_111171.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_111171", "111171002", "story_v_out_111171.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_42 = math.max(var_11_33, arg_8_1.talkMaxDuration)

			if var_11_32 <= arg_8_1.time_ and arg_8_1.time_ < var_11_32 + var_11_42 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_32) / var_11_42

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_32 + var_11_42 and arg_8_1.time_ < var_11_32 + var_11_42 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play111171003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 111171003
		arg_13_1.duration_ = 4.77

		local var_13_0 = {
			ja = 4.766,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_13_0:Play111171004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_16_1 = arg_13_1.actors_["1019ui_story"]
			local var_16_2 = 0

			if var_16_2 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1019ui_story == nil then
				arg_13_1.var_.characterEffect1019ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_3 = 0.2

			if var_16_2 <= arg_13_1.time_ and arg_13_1.time_ < var_16_2 + var_16_3 and not isNil(var_16_1) then
				local var_16_4 = (arg_13_1.time_ - var_16_2) / var_16_3

				if arg_13_1.var_.characterEffect1019ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_2 + var_16_3 and arg_13_1.time_ < var_16_2 + var_16_3 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1019ui_story then
				arg_13_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_16_5 = arg_13_1.actors_["1066ui_story"]
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1066ui_story == nil then
				arg_13_1.var_.characterEffect1066ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_7 = 0.2

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 and not isNil(var_16_5) then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7

				if arg_13_1.var_.characterEffect1066ui_story and not isNil(var_16_5) then
					local var_16_9 = Mathf.Lerp(0, 0.5, var_16_8)

					arg_13_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1066ui_story.fillRatio = var_16_9
				end
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1066ui_story then
				local var_16_10 = 0.5

				arg_13_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1066ui_story.fillRatio = var_16_10
			end

			local var_16_11 = 0
			local var_16_12 = 0.175

			if var_16_11 < arg_13_1.time_ and arg_13_1.time_ <= var_16_11 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_13 = arg_13_1:FormatText(StoryNameCfg[13].name)

				arg_13_1.leftNameTxt_.text = var_16_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_14 = arg_13_1:GetWordFromCfg(111171003)
				local var_16_15 = arg_13_1:FormatText(var_16_14.content)

				arg_13_1.text_.text = var_16_15

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_16 = 7
				local var_16_17 = utf8.len(var_16_15)
				local var_16_18 = var_16_16 <= 0 and var_16_12 or var_16_12 * (var_16_17 / var_16_16)

				if var_16_18 > 0 and var_16_12 < var_16_18 then
					arg_13_1.talkMaxDuration = var_16_18

					if var_16_18 + var_16_11 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_18 + var_16_11
					end
				end

				arg_13_1.text_.text = var_16_15
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171003", "story_v_out_111171.awb") ~= 0 then
					local var_16_19 = manager.audio:GetVoiceLength("story_v_out_111171", "111171003", "story_v_out_111171.awb") / 1000

					if var_16_19 + var_16_11 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_19 + var_16_11
					end

					if var_16_14.prefab_name ~= "" and arg_13_1.actors_[var_16_14.prefab_name] ~= nil then
						local var_16_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_14.prefab_name].transform, "story_v_out_111171", "111171003", "story_v_out_111171.awb")

						arg_13_1:RecordAudio("111171003", var_16_20)
						arg_13_1:RecordAudio("111171003", var_16_20)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_111171", "111171003", "story_v_out_111171.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_111171", "111171003", "story_v_out_111171.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_21 = math.max(var_16_12, arg_13_1.talkMaxDuration)

			if var_16_11 <= arg_13_1.time_ and arg_13_1.time_ < var_16_11 + var_16_21 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_11) / var_16_21

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_11 + var_16_21 and arg_13_1.time_ < var_16_11 + var_16_21 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play111171004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 111171004
		arg_17_1.duration_ = 9.53

		local var_17_0 = {
			ja = 2.933,
			ko = 9.533,
			zh = 5.733,
			en = 6.5
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
				arg_17_0:Play111171005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_20_1 = arg_17_1.actors_["1066ui_story"]
			local var_20_2 = 0

			if var_20_2 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1066ui_story == nil then
				arg_17_1.var_.characterEffect1066ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_3 = 0.2

			if var_20_2 <= arg_17_1.time_ and arg_17_1.time_ < var_20_2 + var_20_3 and not isNil(var_20_1) then
				local var_20_4 = (arg_17_1.time_ - var_20_2) / var_20_3

				if arg_17_1.var_.characterEffect1066ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_2 + var_20_3 and arg_17_1.time_ < var_20_2 + var_20_3 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1066ui_story then
				arg_17_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_20_5 = arg_17_1.actors_["1019ui_story"]
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1019ui_story == nil then
				arg_17_1.var_.characterEffect1019ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_7 = 0.2

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 and not isNil(var_20_5) then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7

				if arg_17_1.var_.characterEffect1019ui_story and not isNil(var_20_5) then
					local var_20_9 = Mathf.Lerp(0, 0.5, var_20_8)

					arg_17_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1019ui_story.fillRatio = var_20_9
				end
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1019ui_story then
				local var_20_10 = 0.5

				arg_17_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1019ui_story.fillRatio = var_20_10
			end

			local var_20_11 = 0
			local var_20_12 = 0.65

			if var_20_11 < arg_17_1.time_ and arg_17_1.time_ <= var_20_11 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_13 = arg_17_1:FormatText(StoryNameCfg[32].name)

				arg_17_1.leftNameTxt_.text = var_20_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_14 = arg_17_1:GetWordFromCfg(111171004)
				local var_20_15 = arg_17_1:FormatText(var_20_14.content)

				arg_17_1.text_.text = var_20_15

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_16 = 26
				local var_20_17 = utf8.len(var_20_15)
				local var_20_18 = var_20_16 <= 0 and var_20_12 or var_20_12 * (var_20_17 / var_20_16)

				if var_20_18 > 0 and var_20_12 < var_20_18 then
					arg_17_1.talkMaxDuration = var_20_18

					if var_20_18 + var_20_11 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_18 + var_20_11
					end
				end

				arg_17_1.text_.text = var_20_15
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171004", "story_v_out_111171.awb") ~= 0 then
					local var_20_19 = manager.audio:GetVoiceLength("story_v_out_111171", "111171004", "story_v_out_111171.awb") / 1000

					if var_20_19 + var_20_11 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_19 + var_20_11
					end

					if var_20_14.prefab_name ~= "" and arg_17_1.actors_[var_20_14.prefab_name] ~= nil then
						local var_20_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_14.prefab_name].transform, "story_v_out_111171", "111171004", "story_v_out_111171.awb")

						arg_17_1:RecordAudio("111171004", var_20_20)
						arg_17_1:RecordAudio("111171004", var_20_20)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_111171", "111171004", "story_v_out_111171.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_111171", "111171004", "story_v_out_111171.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_21 = math.max(var_20_12, arg_17_1.talkMaxDuration)

			if var_20_11 <= arg_17_1.time_ and arg_17_1.time_ < var_20_11 + var_20_21 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_11) / var_20_21

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_11 + var_20_21 and arg_17_1.time_ < var_20_11 + var_20_21 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play111171005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 111171005
		arg_21_1.duration_ = 13.43

		local var_21_0 = {
			ja = 7.7,
			ko = 13.433,
			zh = 9.833,
			en = 12.8
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
				arg_21_0:Play111171006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_24_1 = 0
			local var_24_2 = 1.4

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_3 = arg_21_1:FormatText(StoryNameCfg[32].name)

				arg_21_1.leftNameTxt_.text = var_24_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(111171005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 56
				local var_24_7 = utf8.len(var_24_5)
				local var_24_8 = var_24_6 <= 0 and var_24_2 or var_24_2 * (var_24_7 / var_24_6)

				if var_24_8 > 0 and var_24_2 < var_24_8 then
					arg_21_1.talkMaxDuration = var_24_8

					if var_24_8 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171005", "story_v_out_111171.awb") ~= 0 then
					local var_24_9 = manager.audio:GetVoiceLength("story_v_out_111171", "111171005", "story_v_out_111171.awb") / 1000

					if var_24_9 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_1
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_111171", "111171005", "story_v_out_111171.awb")

						arg_21_1:RecordAudio("111171005", var_24_10)
						arg_21_1:RecordAudio("111171005", var_24_10)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_111171", "111171005", "story_v_out_111171.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_111171", "111171005", "story_v_out_111171.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_11 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_11 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_11

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_11 and arg_21_1.time_ < var_24_1 + var_24_11 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play111171006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 111171006
		arg_25_1.duration_ = 3.9

		local var_25_0 = {
			ja = 3.9,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.033
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
				arg_25_0:Play111171007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_28_1 = arg_25_1.actors_["1019ui_story"]
			local var_28_2 = 0

			if var_28_2 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1019ui_story == nil then
				arg_25_1.var_.characterEffect1019ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_3 = 0.2

			if var_28_2 <= arg_25_1.time_ and arg_25_1.time_ < var_28_2 + var_28_3 and not isNil(var_28_1) then
				local var_28_4 = (arg_25_1.time_ - var_28_2) / var_28_3

				if arg_25_1.var_.characterEffect1019ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_2 + var_28_3 and arg_25_1.time_ < var_28_2 + var_28_3 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1019ui_story then
				arg_25_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_28_5 = arg_25_1.actors_["1066ui_story"]
			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1066ui_story == nil then
				arg_25_1.var_.characterEffect1066ui_story = var_28_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_7 = 0.2

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_7 and not isNil(var_28_5) then
				local var_28_8 = (arg_25_1.time_ - var_28_6) / var_28_7

				if arg_25_1.var_.characterEffect1066ui_story and not isNil(var_28_5) then
					local var_28_9 = Mathf.Lerp(0, 0.5, var_28_8)

					arg_25_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1066ui_story.fillRatio = var_28_9
				end
			end

			if arg_25_1.time_ >= var_28_6 + var_28_7 and arg_25_1.time_ < var_28_6 + var_28_7 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1066ui_story then
				local var_28_10 = 0.5

				arg_25_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1066ui_story.fillRatio = var_28_10
			end

			local var_28_11 = 0
			local var_28_12 = 0.15

			if var_28_11 < arg_25_1.time_ and arg_25_1.time_ <= var_28_11 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_13 = arg_25_1:FormatText(StoryNameCfg[13].name)

				arg_25_1.leftNameTxt_.text = var_28_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_14 = arg_25_1:GetWordFromCfg(111171006)
				local var_28_15 = arg_25_1:FormatText(var_28_14.content)

				arg_25_1.text_.text = var_28_15

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_16 = 6
				local var_28_17 = utf8.len(var_28_15)
				local var_28_18 = var_28_16 <= 0 and var_28_12 or var_28_12 * (var_28_17 / var_28_16)

				if var_28_18 > 0 and var_28_12 < var_28_18 then
					arg_25_1.talkMaxDuration = var_28_18

					if var_28_18 + var_28_11 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_18 + var_28_11
					end
				end

				arg_25_1.text_.text = var_28_15
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171006", "story_v_out_111171.awb") ~= 0 then
					local var_28_19 = manager.audio:GetVoiceLength("story_v_out_111171", "111171006", "story_v_out_111171.awb") / 1000

					if var_28_19 + var_28_11 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_19 + var_28_11
					end

					if var_28_14.prefab_name ~= "" and arg_25_1.actors_[var_28_14.prefab_name] ~= nil then
						local var_28_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_14.prefab_name].transform, "story_v_out_111171", "111171006", "story_v_out_111171.awb")

						arg_25_1:RecordAudio("111171006", var_28_20)
						arg_25_1:RecordAudio("111171006", var_28_20)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_111171", "111171006", "story_v_out_111171.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_111171", "111171006", "story_v_out_111171.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_21 = math.max(var_28_12, arg_25_1.talkMaxDuration)

			if var_28_11 <= arg_25_1.time_ and arg_25_1.time_ < var_28_11 + var_28_21 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_11) / var_28_21

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_11 + var_28_21 and arg_25_1.time_ < var_28_11 + var_28_21 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play111171007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 111171007
		arg_29_1.duration_ = 8.77

		local var_29_0 = {
			ja = 6.333,
			ko = 8.766,
			zh = 6.966,
			en = 8.633
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
				arg_29_0:Play111171008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action443")
			end

			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_32_2 = arg_29_1.actors_["1066ui_story"]
			local var_32_3 = 0

			if var_32_3 < arg_29_1.time_ and arg_29_1.time_ <= var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect1066ui_story == nil then
				arg_29_1.var_.characterEffect1066ui_story = var_32_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_4 = 0.2

			if var_32_3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_3 + var_32_4 and not isNil(var_32_2) then
				local var_32_5 = (arg_29_1.time_ - var_32_3) / var_32_4

				if arg_29_1.var_.characterEffect1066ui_story and not isNil(var_32_2) then
					arg_29_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_3 + var_32_4 and arg_29_1.time_ < var_32_3 + var_32_4 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect1066ui_story then
				arg_29_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_32_6 = arg_29_1.actors_["1019ui_story"]
			local var_32_7 = 0

			if var_32_7 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect1019ui_story == nil then
				arg_29_1.var_.characterEffect1019ui_story = var_32_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_8 = 0.2

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_8 and not isNil(var_32_6) then
				local var_32_9 = (arg_29_1.time_ - var_32_7) / var_32_8

				if arg_29_1.var_.characterEffect1019ui_story and not isNil(var_32_6) then
					local var_32_10 = Mathf.Lerp(0, 0.5, var_32_9)

					arg_29_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1019ui_story.fillRatio = var_32_10
				end
			end

			if arg_29_1.time_ >= var_32_7 + var_32_8 and arg_29_1.time_ < var_32_7 + var_32_8 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect1019ui_story then
				local var_32_11 = 0.5

				arg_29_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1019ui_story.fillRatio = var_32_11
			end

			local var_32_12 = 0
			local var_32_13 = 0.85

			if var_32_12 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_14 = arg_29_1:FormatText(StoryNameCfg[32].name)

				arg_29_1.leftNameTxt_.text = var_32_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_15 = arg_29_1:GetWordFromCfg(111171007)
				local var_32_16 = arg_29_1:FormatText(var_32_15.content)

				arg_29_1.text_.text = var_32_16

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_17 = 34
				local var_32_18 = utf8.len(var_32_16)
				local var_32_19 = var_32_17 <= 0 and var_32_13 or var_32_13 * (var_32_18 / var_32_17)

				if var_32_19 > 0 and var_32_13 < var_32_19 then
					arg_29_1.talkMaxDuration = var_32_19

					if var_32_19 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_12
					end
				end

				arg_29_1.text_.text = var_32_16
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171007", "story_v_out_111171.awb") ~= 0 then
					local var_32_20 = manager.audio:GetVoiceLength("story_v_out_111171", "111171007", "story_v_out_111171.awb") / 1000

					if var_32_20 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_20 + var_32_12
					end

					if var_32_15.prefab_name ~= "" and arg_29_1.actors_[var_32_15.prefab_name] ~= nil then
						local var_32_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_15.prefab_name].transform, "story_v_out_111171", "111171007", "story_v_out_111171.awb")

						arg_29_1:RecordAudio("111171007", var_32_21)
						arg_29_1:RecordAudio("111171007", var_32_21)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_111171", "111171007", "story_v_out_111171.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_111171", "111171007", "story_v_out_111171.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_22 = math.max(var_32_13, arg_29_1.talkMaxDuration)

			if var_32_12 <= arg_29_1.time_ and arg_29_1.time_ < var_32_12 + var_32_22 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_12) / var_32_22

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_12 + var_32_22 and arg_29_1.time_ < var_32_12 + var_32_22 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play111171008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 111171008
		arg_33_1.duration_ = 12.7

		local var_33_0 = {
			ja = 8.5,
			ko = 12.7,
			zh = 8.6,
			en = 11.966
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
				arg_33_0:Play111171009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_36_1 = 0
			local var_36_2 = 1.1

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_3 = arg_33_1:FormatText(StoryNameCfg[32].name)

				arg_33_1.leftNameTxt_.text = var_36_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_4 = arg_33_1:GetWordFromCfg(111171008)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 44
				local var_36_7 = utf8.len(var_36_5)
				local var_36_8 = var_36_6 <= 0 and var_36_2 or var_36_2 * (var_36_7 / var_36_6)

				if var_36_8 > 0 and var_36_2 < var_36_8 then
					arg_33_1.talkMaxDuration = var_36_8

					if var_36_8 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171008", "story_v_out_111171.awb") ~= 0 then
					local var_36_9 = manager.audio:GetVoiceLength("story_v_out_111171", "111171008", "story_v_out_111171.awb") / 1000

					if var_36_9 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_1
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_out_111171", "111171008", "story_v_out_111171.awb")

						arg_33_1:RecordAudio("111171008", var_36_10)
						arg_33_1:RecordAudio("111171008", var_36_10)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_111171", "111171008", "story_v_out_111171.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_111171", "111171008", "story_v_out_111171.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_11 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_11 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_11

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_11 and arg_33_1.time_ < var_36_1 + var_36_11 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play111171009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 111171009
		arg_37_1.duration_ = 3.27

		local var_37_0 = {
			ja = 2.033,
			ko = 1.999999999999,
			zh = 3.2,
			en = 3.266
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
				arg_37_0:Play111171010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_40_1 = arg_37_1.actors_["1019ui_story"]
			local var_40_2 = 0

			if var_40_2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1019ui_story == nil then
				arg_37_1.var_.characterEffect1019ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_3 = 0.2

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_3 and not isNil(var_40_1) then
				local var_40_4 = (arg_37_1.time_ - var_40_2) / var_40_3

				if arg_37_1.var_.characterEffect1019ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_2 + var_40_3 and arg_37_1.time_ < var_40_2 + var_40_3 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1019ui_story then
				arg_37_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_40_5 = arg_37_1.actors_["1066ui_story"]
			local var_40_6 = 0

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect1066ui_story == nil then
				arg_37_1.var_.characterEffect1066ui_story = var_40_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_7 = 0.2

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_7 and not isNil(var_40_5) then
				local var_40_8 = (arg_37_1.time_ - var_40_6) / var_40_7

				if arg_37_1.var_.characterEffect1066ui_story and not isNil(var_40_5) then
					local var_40_9 = Mathf.Lerp(0, 0.5, var_40_8)

					arg_37_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1066ui_story.fillRatio = var_40_9
				end
			end

			if arg_37_1.time_ >= var_40_6 + var_40_7 and arg_37_1.time_ < var_40_6 + var_40_7 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect1066ui_story then
				local var_40_10 = 0.5

				arg_37_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1066ui_story.fillRatio = var_40_10
			end

			local var_40_11 = 0
			local var_40_12 = 0.2

			if var_40_11 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_13 = arg_37_1:FormatText(StoryNameCfg[13].name)

				arg_37_1.leftNameTxt_.text = var_40_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_14 = arg_37_1:GetWordFromCfg(111171009)
				local var_40_15 = arg_37_1:FormatText(var_40_14.content)

				arg_37_1.text_.text = var_40_15

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_16 = 8
				local var_40_17 = utf8.len(var_40_15)
				local var_40_18 = var_40_16 <= 0 and var_40_12 or var_40_12 * (var_40_17 / var_40_16)

				if var_40_18 > 0 and var_40_12 < var_40_18 then
					arg_37_1.talkMaxDuration = var_40_18

					if var_40_18 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_18 + var_40_11
					end
				end

				arg_37_1.text_.text = var_40_15
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171009", "story_v_out_111171.awb") ~= 0 then
					local var_40_19 = manager.audio:GetVoiceLength("story_v_out_111171", "111171009", "story_v_out_111171.awb") / 1000

					if var_40_19 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_19 + var_40_11
					end

					if var_40_14.prefab_name ~= "" and arg_37_1.actors_[var_40_14.prefab_name] ~= nil then
						local var_40_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_14.prefab_name].transform, "story_v_out_111171", "111171009", "story_v_out_111171.awb")

						arg_37_1:RecordAudio("111171009", var_40_20)
						arg_37_1:RecordAudio("111171009", var_40_20)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_111171", "111171009", "story_v_out_111171.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_111171", "111171009", "story_v_out_111171.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_21 = math.max(var_40_12, arg_37_1.talkMaxDuration)

			if var_40_11 <= arg_37_1.time_ and arg_37_1.time_ < var_40_11 + var_40_21 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_11) / var_40_21

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_11 + var_40_21 and arg_37_1.time_ < var_40_11 + var_40_21 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play111171010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 111171010
		arg_41_1.duration_ = 2.83

		local var_41_0 = {
			ja = 2.833,
			ko = 2.266,
			zh = 1.666,
			en = 2.666
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
				arg_41_0:Play111171011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1019ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos1019ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(0, 100, 0)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1019ui_story, var_44_4, var_44_3)

				local var_44_5 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_5.x, var_44_5.y, var_44_5.z)

				local var_44_6 = var_44_0.localEulerAngles

				var_44_6.z = 0
				var_44_6.x = 0
				var_44_0.localEulerAngles = var_44_6
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(0, 100, 0)

				local var_44_7 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_7.x, var_44_7.y, var_44_7.z)

				local var_44_8 = var_44_0.localEulerAngles

				var_44_8.z = 0
				var_44_8.x = 0
				var_44_0.localEulerAngles = var_44_8
			end

			local var_44_9 = arg_41_1.actors_["1066ui_story"].transform
			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 then
				arg_41_1.var_.moveOldPos1066ui_story = var_44_9.localPosition
			end

			local var_44_11 = 0.001

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_11 then
				local var_44_12 = (arg_41_1.time_ - var_44_10) / var_44_11
				local var_44_13 = Vector3.New(0, 100, 0)

				var_44_9.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1066ui_story, var_44_13, var_44_12)

				local var_44_14 = manager.ui.mainCamera.transform.position - var_44_9.position

				var_44_9.forward = Vector3.New(var_44_14.x, var_44_14.y, var_44_14.z)

				local var_44_15 = var_44_9.localEulerAngles

				var_44_15.z = 0
				var_44_15.x = 0
				var_44_9.localEulerAngles = var_44_15
			end

			if arg_41_1.time_ >= var_44_10 + var_44_11 and arg_41_1.time_ < var_44_10 + var_44_11 + arg_44_0 then
				var_44_9.localPosition = Vector3.New(0, 100, 0)

				local var_44_16 = manager.ui.mainCamera.transform.position - var_44_9.position

				var_44_9.forward = Vector3.New(var_44_16.x, var_44_16.y, var_44_16.z)

				local var_44_17 = var_44_9.localEulerAngles

				var_44_17.z = 0
				var_44_17.x = 0
				var_44_9.localEulerAngles = var_44_17
			end

			local var_44_18 = manager.ui.mainCamera.transform
			local var_44_19 = 0.5

			if var_44_19 < arg_41_1.time_ and arg_41_1.time_ <= var_44_19 + arg_44_0 then
				arg_41_1.var_.shakeOldPos = var_44_18.localPosition
			end

			local var_44_20 = 0.3

			if var_44_19 <= arg_41_1.time_ and arg_41_1.time_ < var_44_19 + var_44_20 then
				local var_44_21 = (arg_41_1.time_ - var_44_19) / 0.066
				local var_44_22, var_44_23 = math.modf(var_44_21)

				var_44_18.localPosition = Vector3.New(var_44_23 * 0.13, var_44_23 * 0.13, var_44_23 * 0.13) + arg_41_1.var_.shakeOldPos
			end

			if arg_41_1.time_ >= var_44_19 + var_44_20 and arg_41_1.time_ < var_44_19 + var_44_20 + arg_44_0 then
				var_44_18.localPosition = arg_41_1.var_.shakeOldPos
			end

			local var_44_24 = 0
			local var_44_25 = 0.125

			if var_44_24 < arg_41_1.time_ and arg_41_1.time_ <= var_44_24 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_26 = arg_41_1:FormatText(StoryNameCfg[32].name)

				arg_41_1.leftNameTxt_.text = var_44_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_27 = arg_41_1:GetWordFromCfg(111171010)
				local var_44_28 = arg_41_1:FormatText(var_44_27.content)

				arg_41_1.text_.text = var_44_28

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_29 = 5
				local var_44_30 = utf8.len(var_44_28)
				local var_44_31 = var_44_29 <= 0 and var_44_25 or var_44_25 * (var_44_30 / var_44_29)

				if var_44_31 > 0 and var_44_25 < var_44_31 then
					arg_41_1.talkMaxDuration = var_44_31

					if var_44_31 + var_44_24 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_31 + var_44_24
					end
				end

				arg_41_1.text_.text = var_44_28
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171010", "story_v_out_111171.awb") ~= 0 then
					local var_44_32 = manager.audio:GetVoiceLength("story_v_out_111171", "111171010", "story_v_out_111171.awb") / 1000

					if var_44_32 + var_44_24 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_32 + var_44_24
					end

					if var_44_27.prefab_name ~= "" and arg_41_1.actors_[var_44_27.prefab_name] ~= nil then
						local var_44_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_27.prefab_name].transform, "story_v_out_111171", "111171010", "story_v_out_111171.awb")

						arg_41_1:RecordAudio("111171010", var_44_33)
						arg_41_1:RecordAudio("111171010", var_44_33)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_111171", "111171010", "story_v_out_111171.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_111171", "111171010", "story_v_out_111171.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_34 = math.max(var_44_25, arg_41_1.talkMaxDuration)

			if var_44_24 <= arg_41_1.time_ and arg_41_1.time_ < var_44_24 + var_44_34 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_24) / var_44_34

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_24 + var_44_34 and arg_41_1.time_ < var_44_24 + var_44_34 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play111171011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 111171011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play111171012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.75

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_2 = arg_45_1:GetWordFromCfg(111171011)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 30
				local var_48_5 = utf8.len(var_48_3)
				local var_48_6 = var_48_4 <= 0 and var_48_1 or var_48_1 * (var_48_5 / var_48_4)

				if var_48_6 > 0 and var_48_1 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_7 and arg_45_1.time_ < var_48_0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play111171012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 111171012
		arg_49_1.duration_ = 15.3

		local var_49_0 = {
			ja = 15.3,
			ko = 10.566,
			zh = 9.7,
			en = 9.133
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
				arg_49_0:Play111171013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1066ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1066ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(-0.7, -0.77, -6.1)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1066ui_story, var_52_4, var_52_3)

				local var_52_5 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_5.x, var_52_5.y, var_52_5.z)

				local var_52_6 = var_52_0.localEulerAngles

				var_52_6.z = 0
				var_52_6.x = 0
				var_52_0.localEulerAngles = var_52_6
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(-0.7, -0.77, -6.1)

				local var_52_7 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_7.x, var_52_7.y, var_52_7.z)

				local var_52_8 = var_52_0.localEulerAngles

				var_52_8.z = 0
				var_52_8.x = 0
				var_52_0.localEulerAngles = var_52_8
			end

			local var_52_9 = 0

			if var_52_9 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 then
				arg_49_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_52_11 = arg_49_1.actors_["1066ui_story"]
			local var_52_12 = 0

			if var_52_12 < arg_49_1.time_ and arg_49_1.time_ <= var_52_12 + arg_52_0 and not isNil(var_52_11) and arg_49_1.var_.characterEffect1066ui_story == nil then
				arg_49_1.var_.characterEffect1066ui_story = var_52_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_13 = 0.2

			if var_52_12 <= arg_49_1.time_ and arg_49_1.time_ < var_52_12 + var_52_13 and not isNil(var_52_11) then
				local var_52_14 = (arg_49_1.time_ - var_52_12) / var_52_13

				if arg_49_1.var_.characterEffect1066ui_story and not isNil(var_52_11) then
					arg_49_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_12 + var_52_13 and arg_49_1.time_ < var_52_12 + var_52_13 + arg_52_0 and not isNil(var_52_11) and arg_49_1.var_.characterEffect1066ui_story then
				arg_49_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_52_15 = 0
			local var_52_16 = 1.3

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_17 = arg_49_1:FormatText(StoryNameCfg[32].name)

				arg_49_1.leftNameTxt_.text = var_52_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_18 = arg_49_1:GetWordFromCfg(111171012)
				local var_52_19 = arg_49_1:FormatText(var_52_18.content)

				arg_49_1.text_.text = var_52_19

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_20 = 52
				local var_52_21 = utf8.len(var_52_19)
				local var_52_22 = var_52_20 <= 0 and var_52_16 or var_52_16 * (var_52_21 / var_52_20)

				if var_52_22 > 0 and var_52_16 < var_52_22 then
					arg_49_1.talkMaxDuration = var_52_22

					if var_52_22 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_22 + var_52_15
					end
				end

				arg_49_1.text_.text = var_52_19
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171012", "story_v_out_111171.awb") ~= 0 then
					local var_52_23 = manager.audio:GetVoiceLength("story_v_out_111171", "111171012", "story_v_out_111171.awb") / 1000

					if var_52_23 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_23 + var_52_15
					end

					if var_52_18.prefab_name ~= "" and arg_49_1.actors_[var_52_18.prefab_name] ~= nil then
						local var_52_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_18.prefab_name].transform, "story_v_out_111171", "111171012", "story_v_out_111171.awb")

						arg_49_1:RecordAudio("111171012", var_52_24)
						arg_49_1:RecordAudio("111171012", var_52_24)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_111171", "111171012", "story_v_out_111171.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_111171", "111171012", "story_v_out_111171.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_25 = math.max(var_52_16, arg_49_1.talkMaxDuration)

			if var_52_15 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_25 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_15) / var_52_25

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_15 + var_52_25 and arg_49_1.time_ < var_52_15 + var_52_25 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play111171013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 111171013
		arg_53_1.duration_ = 4.87

		local var_53_0 = {
			ja = 4.866,
			ko = 1.999999999999,
			zh = 4.3,
			en = 2.4
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
				arg_53_0:Play111171014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1019ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1019ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0.7, -1.08, -5.9)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1019ui_story, var_56_4, var_56_3)

				local var_56_5 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_5.x, var_56_5.y, var_56_5.z)

				local var_56_6 = var_56_0.localEulerAngles

				var_56_6.z = 0
				var_56_6.x = 0
				var_56_0.localEulerAngles = var_56_6
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_56_7 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_7.x, var_56_7.y, var_56_7.z)

				local var_56_8 = var_56_0.localEulerAngles

				var_56_8.z = 0
				var_56_8.x = 0
				var_56_0.localEulerAngles = var_56_8
			end

			local var_56_9 = 0

			if var_56_9 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 then
				arg_53_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 then
				arg_53_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_56_11 = arg_53_1.actors_["1019ui_story"]
			local var_56_12 = 0

			if var_56_12 < arg_53_1.time_ and arg_53_1.time_ <= var_56_12 + arg_56_0 and not isNil(var_56_11) and arg_53_1.var_.characterEffect1019ui_story == nil then
				arg_53_1.var_.characterEffect1019ui_story = var_56_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_13 = 0.2

			if var_56_12 <= arg_53_1.time_ and arg_53_1.time_ < var_56_12 + var_56_13 and not isNil(var_56_11) then
				local var_56_14 = (arg_53_1.time_ - var_56_12) / var_56_13

				if arg_53_1.var_.characterEffect1019ui_story and not isNil(var_56_11) then
					arg_53_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_12 + var_56_13 and arg_53_1.time_ < var_56_12 + var_56_13 + arg_56_0 and not isNil(var_56_11) and arg_53_1.var_.characterEffect1019ui_story then
				arg_53_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_56_15 = arg_53_1.actors_["1066ui_story"]
			local var_56_16 = 0

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 and not isNil(var_56_15) and arg_53_1.var_.characterEffect1066ui_story == nil then
				arg_53_1.var_.characterEffect1066ui_story = var_56_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_17 = 0.2

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_17 and not isNil(var_56_15) then
				local var_56_18 = (arg_53_1.time_ - var_56_16) / var_56_17

				if arg_53_1.var_.characterEffect1066ui_story and not isNil(var_56_15) then
					local var_56_19 = Mathf.Lerp(0, 0.5, var_56_18)

					arg_53_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1066ui_story.fillRatio = var_56_19
				end
			end

			if arg_53_1.time_ >= var_56_16 + var_56_17 and arg_53_1.time_ < var_56_16 + var_56_17 + arg_56_0 and not isNil(var_56_15) and arg_53_1.var_.characterEffect1066ui_story then
				local var_56_20 = 0.5

				arg_53_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1066ui_story.fillRatio = var_56_20
			end

			local var_56_21 = 0
			local var_56_22 = 0.2

			if var_56_21 < arg_53_1.time_ and arg_53_1.time_ <= var_56_21 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_23 = arg_53_1:FormatText(StoryNameCfg[13].name)

				arg_53_1.leftNameTxt_.text = var_56_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_24 = arg_53_1:GetWordFromCfg(111171013)
				local var_56_25 = arg_53_1:FormatText(var_56_24.content)

				arg_53_1.text_.text = var_56_25

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_26 = 8
				local var_56_27 = utf8.len(var_56_25)
				local var_56_28 = var_56_26 <= 0 and var_56_22 or var_56_22 * (var_56_27 / var_56_26)

				if var_56_28 > 0 and var_56_22 < var_56_28 then
					arg_53_1.talkMaxDuration = var_56_28

					if var_56_28 + var_56_21 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_28 + var_56_21
					end
				end

				arg_53_1.text_.text = var_56_25
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171013", "story_v_out_111171.awb") ~= 0 then
					local var_56_29 = manager.audio:GetVoiceLength("story_v_out_111171", "111171013", "story_v_out_111171.awb") / 1000

					if var_56_29 + var_56_21 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_29 + var_56_21
					end

					if var_56_24.prefab_name ~= "" and arg_53_1.actors_[var_56_24.prefab_name] ~= nil then
						local var_56_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_24.prefab_name].transform, "story_v_out_111171", "111171013", "story_v_out_111171.awb")

						arg_53_1:RecordAudio("111171013", var_56_30)
						arg_53_1:RecordAudio("111171013", var_56_30)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_111171", "111171013", "story_v_out_111171.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_111171", "111171013", "story_v_out_111171.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_31 = math.max(var_56_22, arg_53_1.talkMaxDuration)

			if var_56_21 <= arg_53_1.time_ and arg_53_1.time_ < var_56_21 + var_56_31 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_21) / var_56_31

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_21 + var_56_31 and arg_53_1.time_ < var_56_21 + var_56_31 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play111171014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 111171014
		arg_57_1.duration_ = 12.1

		local var_57_0 = {
			ja = 12.1,
			ko = 9.833,
			zh = 8.933,
			en = 8.266
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
				arg_57_0:Play111171015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_60_1 = arg_57_1.actors_["1066ui_story"]
			local var_60_2 = 0

			if var_60_2 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1066ui_story == nil then
				arg_57_1.var_.characterEffect1066ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_3 = 0.2

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_3 and not isNil(var_60_1) then
				local var_60_4 = (arg_57_1.time_ - var_60_2) / var_60_3

				if arg_57_1.var_.characterEffect1066ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_2 + var_60_3 and arg_57_1.time_ < var_60_2 + var_60_3 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1066ui_story then
				arg_57_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_60_5 = arg_57_1.actors_["1019ui_story"]
			local var_60_6 = 0

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.characterEffect1019ui_story == nil then
				arg_57_1.var_.characterEffect1019ui_story = var_60_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_7 = 0.2

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_7 and not isNil(var_60_5) then
				local var_60_8 = (arg_57_1.time_ - var_60_6) / var_60_7

				if arg_57_1.var_.characterEffect1019ui_story and not isNil(var_60_5) then
					local var_60_9 = Mathf.Lerp(0, 0.5, var_60_8)

					arg_57_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1019ui_story.fillRatio = var_60_9
				end
			end

			if arg_57_1.time_ >= var_60_6 + var_60_7 and arg_57_1.time_ < var_60_6 + var_60_7 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.characterEffect1019ui_story then
				local var_60_10 = 0.5

				arg_57_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1019ui_story.fillRatio = var_60_10
			end

			local var_60_11 = 0
			local var_60_12 = 1.05

			if var_60_11 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_13 = arg_57_1:FormatText(StoryNameCfg[32].name)

				arg_57_1.leftNameTxt_.text = var_60_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_14 = arg_57_1:GetWordFromCfg(111171014)
				local var_60_15 = arg_57_1:FormatText(var_60_14.content)

				arg_57_1.text_.text = var_60_15

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_16 = 41
				local var_60_17 = utf8.len(var_60_15)
				local var_60_18 = var_60_16 <= 0 and var_60_12 or var_60_12 * (var_60_17 / var_60_16)

				if var_60_18 > 0 and var_60_12 < var_60_18 then
					arg_57_1.talkMaxDuration = var_60_18

					if var_60_18 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_18 + var_60_11
					end
				end

				arg_57_1.text_.text = var_60_15
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171014", "story_v_out_111171.awb") ~= 0 then
					local var_60_19 = manager.audio:GetVoiceLength("story_v_out_111171", "111171014", "story_v_out_111171.awb") / 1000

					if var_60_19 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_19 + var_60_11
					end

					if var_60_14.prefab_name ~= "" and arg_57_1.actors_[var_60_14.prefab_name] ~= nil then
						local var_60_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_14.prefab_name].transform, "story_v_out_111171", "111171014", "story_v_out_111171.awb")

						arg_57_1:RecordAudio("111171014", var_60_20)
						arg_57_1:RecordAudio("111171014", var_60_20)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_111171", "111171014", "story_v_out_111171.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_111171", "111171014", "story_v_out_111171.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_21 = math.max(var_60_12, arg_57_1.talkMaxDuration)

			if var_60_11 <= arg_57_1.time_ and arg_57_1.time_ < var_60_11 + var_60_21 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_11) / var_60_21

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_11 + var_60_21 and arg_57_1.time_ < var_60_11 + var_60_21 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play111171015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 111171015
		arg_61_1.duration_ = 4.57

		local var_61_0 = {
			ja = 3.4,
			ko = 3.966,
			zh = 4.566,
			en = 2.966
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
				arg_61_0:Play111171016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_64_1 = arg_61_1.actors_["1066ui_story"]
			local var_64_2 = 0

			if var_64_2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1066ui_story == nil then
				arg_61_1.var_.characterEffect1066ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_3 = 0.2

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_3 and not isNil(var_64_1) then
				local var_64_4 = (arg_61_1.time_ - var_64_2) / var_64_3

				if arg_61_1.var_.characterEffect1066ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_2 + var_64_3 and arg_61_1.time_ < var_64_2 + var_64_3 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1066ui_story then
				arg_61_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_64_5 = 0
			local var_64_6 = 0.4

			if var_64_5 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_7 = arg_61_1:FormatText(StoryNameCfg[32].name)

				arg_61_1.leftNameTxt_.text = var_64_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_8 = arg_61_1:GetWordFromCfg(111171015)
				local var_64_9 = arg_61_1:FormatText(var_64_8.content)

				arg_61_1.text_.text = var_64_9

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_10 = 16
				local var_64_11 = utf8.len(var_64_9)
				local var_64_12 = var_64_10 <= 0 and var_64_6 or var_64_6 * (var_64_11 / var_64_10)

				if var_64_12 > 0 and var_64_6 < var_64_12 then
					arg_61_1.talkMaxDuration = var_64_12

					if var_64_12 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_5
					end
				end

				arg_61_1.text_.text = var_64_9
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171015", "story_v_out_111171.awb") ~= 0 then
					local var_64_13 = manager.audio:GetVoiceLength("story_v_out_111171", "111171015", "story_v_out_111171.awb") / 1000

					if var_64_13 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_5
					end

					if var_64_8.prefab_name ~= "" and arg_61_1.actors_[var_64_8.prefab_name] ~= nil then
						local var_64_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_8.prefab_name].transform, "story_v_out_111171", "111171015", "story_v_out_111171.awb")

						arg_61_1:RecordAudio("111171015", var_64_14)
						arg_61_1:RecordAudio("111171015", var_64_14)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_111171", "111171015", "story_v_out_111171.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_111171", "111171015", "story_v_out_111171.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_15 = math.max(var_64_6, arg_61_1.talkMaxDuration)

			if var_64_5 <= arg_61_1.time_ and arg_61_1.time_ < var_64_5 + var_64_15 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_5) / var_64_15

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_5 + var_64_15 and arg_61_1.time_ < var_64_5 + var_64_15 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play111171016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 111171016
		arg_65_1.duration_ = 10.6

		local var_65_0 = {
			ja = 10.6,
			ko = 7.366,
			zh = 7.733,
			en = 8.6
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
				arg_65_0:Play111171017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_68_2 = arg_65_1.actors_["1019ui_story"]
			local var_68_3 = 0

			if var_68_3 < arg_65_1.time_ and arg_65_1.time_ <= var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1019ui_story == nil then
				arg_65_1.var_.characterEffect1019ui_story = var_68_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_4 = 0.2

			if var_68_3 <= arg_65_1.time_ and arg_65_1.time_ < var_68_3 + var_68_4 and not isNil(var_68_2) then
				local var_68_5 = (arg_65_1.time_ - var_68_3) / var_68_4

				if arg_65_1.var_.characterEffect1019ui_story and not isNil(var_68_2) then
					arg_65_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_3 + var_68_4 and arg_65_1.time_ < var_68_3 + var_68_4 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1019ui_story then
				arg_65_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_68_6 = arg_65_1.actors_["1066ui_story"]
			local var_68_7 = 0

			if var_68_7 < arg_65_1.time_ and arg_65_1.time_ <= var_68_7 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect1066ui_story == nil then
				arg_65_1.var_.characterEffect1066ui_story = var_68_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_8 = 0.2

			if var_68_7 <= arg_65_1.time_ and arg_65_1.time_ < var_68_7 + var_68_8 and not isNil(var_68_6) then
				local var_68_9 = (arg_65_1.time_ - var_68_7) / var_68_8

				if arg_65_1.var_.characterEffect1066ui_story and not isNil(var_68_6) then
					local var_68_10 = Mathf.Lerp(0, 0.5, var_68_9)

					arg_65_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1066ui_story.fillRatio = var_68_10
				end
			end

			if arg_65_1.time_ >= var_68_7 + var_68_8 and arg_65_1.time_ < var_68_7 + var_68_8 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect1066ui_story then
				local var_68_11 = 0.5

				arg_65_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1066ui_story.fillRatio = var_68_11
			end

			local var_68_12 = 0
			local var_68_13 = 0.95

			if var_68_12 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_14 = arg_65_1:FormatText(StoryNameCfg[13].name)

				arg_65_1.leftNameTxt_.text = var_68_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_15 = arg_65_1:GetWordFromCfg(111171016)
				local var_68_16 = arg_65_1:FormatText(var_68_15.content)

				arg_65_1.text_.text = var_68_16

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_17 = 38
				local var_68_18 = utf8.len(var_68_16)
				local var_68_19 = var_68_17 <= 0 and var_68_13 or var_68_13 * (var_68_18 / var_68_17)

				if var_68_19 > 0 and var_68_13 < var_68_19 then
					arg_65_1.talkMaxDuration = var_68_19

					if var_68_19 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_19 + var_68_12
					end
				end

				arg_65_1.text_.text = var_68_16
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171016", "story_v_out_111171.awb") ~= 0 then
					local var_68_20 = manager.audio:GetVoiceLength("story_v_out_111171", "111171016", "story_v_out_111171.awb") / 1000

					if var_68_20 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_20 + var_68_12
					end

					if var_68_15.prefab_name ~= "" and arg_65_1.actors_[var_68_15.prefab_name] ~= nil then
						local var_68_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_15.prefab_name].transform, "story_v_out_111171", "111171016", "story_v_out_111171.awb")

						arg_65_1:RecordAudio("111171016", var_68_21)
						arg_65_1:RecordAudio("111171016", var_68_21)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_111171", "111171016", "story_v_out_111171.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_111171", "111171016", "story_v_out_111171.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_22 = math.max(var_68_13, arg_65_1.talkMaxDuration)

			if var_68_12 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_22 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_12) / var_68_22

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_12 + var_68_22 and arg_65_1.time_ < var_68_12 + var_68_22 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play111171017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 111171017
		arg_69_1.duration_ = 6.18

		local var_69_0 = {
			ja = 6.175,
			ko = 4.308,
			zh = 5.475,
			en = 5.541
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
				arg_69_0:Play111171018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1019ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1019ui_story = var_72_0.localPosition
			end

			local var_72_2 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2
				local var_72_4 = Vector3.New(0, 100, 0)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1019ui_story, var_72_4, var_72_3)

				local var_72_5 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_5.x, var_72_5.y, var_72_5.z)

				local var_72_6 = var_72_0.localEulerAngles

				var_72_6.z = 0
				var_72_6.x = 0
				var_72_0.localEulerAngles = var_72_6
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0, 100, 0)

				local var_72_7 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_7.x, var_72_7.y, var_72_7.z)

				local var_72_8 = var_72_0.localEulerAngles

				var_72_8.z = 0
				var_72_8.x = 0
				var_72_0.localEulerAngles = var_72_8
			end

			local var_72_9 = arg_69_1.actors_["1066ui_story"].transform
			local var_72_10 = 0

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 then
				arg_69_1.var_.moveOldPos1066ui_story = var_72_9.localPosition
			end

			local var_72_11 = 0.001

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_11 then
				local var_72_12 = (arg_69_1.time_ - var_72_10) / var_72_11
				local var_72_13 = Vector3.New(0, 100, 0)

				var_72_9.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1066ui_story, var_72_13, var_72_12)

				local var_72_14 = manager.ui.mainCamera.transform.position - var_72_9.position

				var_72_9.forward = Vector3.New(var_72_14.x, var_72_14.y, var_72_14.z)

				local var_72_15 = var_72_9.localEulerAngles

				var_72_15.z = 0
				var_72_15.x = 0
				var_72_9.localEulerAngles = var_72_15
			end

			if arg_69_1.time_ >= var_72_10 + var_72_11 and arg_69_1.time_ < var_72_10 + var_72_11 + arg_72_0 then
				var_72_9.localPosition = Vector3.New(0, 100, 0)

				local var_72_16 = manager.ui.mainCamera.transform.position - var_72_9.position

				var_72_9.forward = Vector3.New(var_72_16.x, var_72_16.y, var_72_16.z)

				local var_72_17 = var_72_9.localEulerAngles

				var_72_17.z = 0
				var_72_17.x = 0
				var_72_9.localEulerAngles = var_72_17
			end

			local var_72_18 = arg_69_1.bgs_.ST10
			local var_72_19 = 0

			if var_72_19 < arg_69_1.time_ and arg_69_1.time_ <= var_72_19 + arg_72_0 then
				local var_72_20 = var_72_18:GetComponent("SpriteRenderer")

				if var_72_20 then
					arg_69_1.var_.alphaOldValueST10 = var_72_20.color.a
					arg_69_1.var_.alphaMatValueST10 = var_72_20
				end

				arg_69_1.var_.alphaOldValueST10 = 1
			end

			local var_72_21 = 1.5

			if var_72_19 <= arg_69_1.time_ and arg_69_1.time_ < var_72_19 + var_72_21 then
				local var_72_22 = (arg_69_1.time_ - var_72_19) / var_72_21
				local var_72_23 = Mathf.Lerp(arg_69_1.var_.alphaOldValueST10, 0, var_72_22)

				if arg_69_1.var_.alphaMatValueST10 then
					local var_72_24 = arg_69_1.var_.alphaMatValueST10.color

					var_72_24.a = var_72_23
					arg_69_1.var_.alphaMatValueST10.color = var_72_24
				end
			end

			if arg_69_1.time_ >= var_72_19 + var_72_21 and arg_69_1.time_ < var_72_19 + var_72_21 + arg_72_0 and arg_69_1.var_.alphaMatValueST10 then
				local var_72_25 = arg_69_1.var_.alphaMatValueST10
				local var_72_26 = var_72_25.color

				var_72_26.a = 0
				var_72_25.color = var_72_26
			end

			local var_72_27 = "D05"

			if arg_69_1.bgs_[var_72_27] == nil then
				local var_72_28 = Object.Instantiate(arg_69_1.paintGo_)

				var_72_28:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_72_27)
				var_72_28.name = var_72_27
				var_72_28.transform.parent = arg_69_1.stage_.transform
				var_72_28.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_[var_72_27] = var_72_28
			end

			local var_72_29 = arg_69_1.bgs_.D05
			local var_72_30 = 1.5

			if var_72_30 < arg_69_1.time_ and arg_69_1.time_ <= var_72_30 + arg_72_0 then
				local var_72_31 = var_72_29:GetComponent("SpriteRenderer")

				if var_72_31 then
					arg_69_1.var_.alphaOldValueD05 = var_72_31.color.a
					arg_69_1.var_.alphaMatValueD05 = var_72_31
				end

				arg_69_1.var_.alphaOldValueD05 = 0
			end

			local var_72_32 = 1.5

			if var_72_30 <= arg_69_1.time_ and arg_69_1.time_ < var_72_30 + var_72_32 then
				local var_72_33 = (arg_69_1.time_ - var_72_30) / var_72_32
				local var_72_34 = Mathf.Lerp(arg_69_1.var_.alphaOldValueD05, 1, var_72_33)

				if arg_69_1.var_.alphaMatValueD05 then
					local var_72_35 = arg_69_1.var_.alphaMatValueD05.color

					var_72_35.a = var_72_34
					arg_69_1.var_.alphaMatValueD05.color = var_72_35
				end
			end

			if arg_69_1.time_ >= var_72_30 + var_72_32 and arg_69_1.time_ < var_72_30 + var_72_32 + arg_72_0 and arg_69_1.var_.alphaMatValueD05 then
				local var_72_36 = arg_69_1.var_.alphaMatValueD05
				local var_72_37 = var_72_36.color

				var_72_37.a = 1
				var_72_36.color = var_72_37
			end

			local var_72_38 = 1.5

			if var_72_38 < arg_69_1.time_ and arg_69_1.time_ <= var_72_38 + arg_72_0 then
				local var_72_39 = manager.ui.mainCamera.transform.localPosition
				local var_72_40 = Vector3.New(0, 0, 10) + Vector3.New(var_72_39.x, var_72_39.y, 0)
				local var_72_41 = arg_69_1.bgs_.D05

				var_72_41.transform.localPosition = var_72_40
				var_72_41.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_42 = var_72_41:GetComponent("SpriteRenderer")

				if var_72_42 and var_72_42.sprite then
					local var_72_43 = (var_72_41.transform.localPosition - var_72_39).z
					local var_72_44 = manager.ui.mainCameraCom_
					local var_72_45 = 2 * var_72_43 * Mathf.Tan(var_72_44.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_72_46 = var_72_45 * var_72_44.aspect
					local var_72_47 = var_72_42.sprite.bounds.size.x
					local var_72_48 = var_72_42.sprite.bounds.size.y
					local var_72_49 = var_72_46 / var_72_47
					local var_72_50 = var_72_45 / var_72_48
					local var_72_51 = var_72_50 < var_72_49 and var_72_49 or var_72_50

					var_72_41.transform.localScale = Vector3.New(var_72_51, var_72_51, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "D05" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_52 = 0

			if var_72_52 < arg_69_1.time_ and arg_69_1.time_ <= var_72_52 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			local var_72_53 = 2.675

			if arg_69_1.time_ >= var_72_52 + var_72_53 and arg_69_1.time_ < var_72_52 + var_72_53 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end

			local var_72_54 = 2.675
			local var_72_55 = 1

			if var_72_54 < arg_69_1.time_ and arg_69_1.time_ <= var_72_54 + arg_72_0 then
				local var_72_56 = "play"
				local var_72_57 = "music"

				arg_69_1:AudioAction(var_72_56, var_72_57, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_72_58 = ""
				local var_72_59 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_72_59 ~= "" then
					if arg_69_1.bgmTxt_.text ~= var_72_59 and arg_69_1.bgmTxt_.text ~= "" then
						if arg_69_1.bgmTxt2_.text ~= "" then
							arg_69_1.bgmTxt_.text = arg_69_1.bgmTxt2_.text
						end

						arg_69_1.bgmTxt2_.text = var_72_59

						arg_69_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_69_1.bgmTxt_.text = var_72_59
						arg_69_1.bgmTxt2_.text = var_72_59
					end

					if arg_69_1.bgmTimer then
						arg_69_1.bgmTimer:Stop()

						arg_69_1.bgmTimer = nil
					end

					if arg_69_1.settingData.show_music_name == 1 then
						arg_69_1.musicController:SetSelectedState("show")
						arg_69_1.musicAnimator_:Play("open", 0, 0)

						if arg_69_1.settingData.music_time ~= 0 then
							arg_69_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_69_1.settingData.music_time), function()
								if arg_69_1 == nil or isNil(arg_69_1.bgmTxt_) then
									return
								end

								arg_69_1.musicController:SetSelectedState("hide")
								arg_69_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_60 = 2.675
			local var_72_61 = 0.325

			if var_72_60 < arg_69_1.time_ and arg_69_1.time_ <= var_72_60 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_62 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_62:setOnUpdate(LuaHelper.FloatAction(function(arg_74_0)
					arg_69_1.dialogCg_.alpha = arg_74_0
				end))
				var_72_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_63 = arg_69_1:FormatText(StoryNameCfg[167].name)

				arg_69_1.leftNameTxt_.text = var_72_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedc")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_64 = arg_69_1:GetWordFromCfg(111171017)
				local var_72_65 = arg_69_1:FormatText(var_72_64.content)

				arg_69_1.text_.text = var_72_65

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_66 = 9
				local var_72_67 = utf8.len(var_72_65)
				local var_72_68 = var_72_66 <= 0 and var_72_61 or var_72_61 * (var_72_67 / var_72_66)

				if var_72_68 > 0 and var_72_61 < var_72_68 then
					arg_69_1.talkMaxDuration = var_72_68
					var_72_60 = var_72_60 + 0.3

					if var_72_68 + var_72_60 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_68 + var_72_60
					end
				end

				arg_69_1.text_.text = var_72_65
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171017", "story_v_out_111171.awb") ~= 0 then
					local var_72_69 = manager.audio:GetVoiceLength("story_v_out_111171", "111171017", "story_v_out_111171.awb") / 1000

					if var_72_69 + var_72_60 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_69 + var_72_60
					end

					if var_72_64.prefab_name ~= "" and arg_69_1.actors_[var_72_64.prefab_name] ~= nil then
						local var_72_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_64.prefab_name].transform, "story_v_out_111171", "111171017", "story_v_out_111171.awb")

						arg_69_1:RecordAudio("111171017", var_72_70)
						arg_69_1:RecordAudio("111171017", var_72_70)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_111171", "111171017", "story_v_out_111171.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_111171", "111171017", "story_v_out_111171.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_71 = var_72_60 + 0.3
			local var_72_72 = math.max(var_72_61, arg_69_1.talkMaxDuration)

			if var_72_71 <= arg_69_1.time_ and arg_69_1.time_ < var_72_71 + var_72_72 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_71) / var_72_72

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_71 + var_72_72 and arg_69_1.time_ < var_72_71 + var_72_72 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play111171018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 111171018
		arg_76_1.duration_ = 6.97

		local var_76_0 = {
			ja = 6.966,
			ko = 3.666,
			zh = 5.5,
			en = 5.533
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play111171019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = manager.ui.mainCamera.transform
			local var_79_1 = 0.4

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.var_.shakeOldPos = var_79_0.localPosition
			end

			local var_79_2 = 0.6

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / 0.066
				local var_79_4, var_79_5 = math.modf(var_79_3)

				var_79_0.localPosition = Vector3.New(var_79_5 * 0.13, var_79_5 * 0.13, var_79_5 * 0.13) + arg_76_1.var_.shakeOldPos
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 then
				var_79_0.localPosition = arg_76_1.var_.shakeOldPos
			end

			local var_79_6 = 0
			local var_79_7 = 0.55

			if var_79_6 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_8 = arg_76_1:FormatText(StoryNameCfg[167].name)

				arg_76_1.leftNameTxt_.text = var_79_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedc")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_9 = arg_76_1:GetWordFromCfg(111171018)
				local var_79_10 = arg_76_1:FormatText(var_79_9.content)

				arg_76_1.text_.text = var_79_10

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 18
				local var_79_12 = utf8.len(var_79_10)
				local var_79_13 = var_79_11 <= 0 and var_79_7 or var_79_7 * (var_79_12 / var_79_11)

				if var_79_13 > 0 and var_79_7 < var_79_13 then
					arg_76_1.talkMaxDuration = var_79_13

					if var_79_13 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_13 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_10
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171018", "story_v_out_111171.awb") ~= 0 then
					local var_79_14 = manager.audio:GetVoiceLength("story_v_out_111171", "111171018", "story_v_out_111171.awb") / 1000

					if var_79_14 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_14 + var_79_6
					end

					if var_79_9.prefab_name ~= "" and arg_76_1.actors_[var_79_9.prefab_name] ~= nil then
						local var_79_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_9.prefab_name].transform, "story_v_out_111171", "111171018", "story_v_out_111171.awb")

						arg_76_1:RecordAudio("111171018", var_79_15)
						arg_76_1:RecordAudio("111171018", var_79_15)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_111171", "111171018", "story_v_out_111171.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_111171", "111171018", "story_v_out_111171.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_16 = math.max(var_79_7, arg_76_1.talkMaxDuration)

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_16 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_6) / var_79_16

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_6 + var_79_16 and arg_76_1.time_ < var_79_6 + var_79_16 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play111171019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 111171019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play111171020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 1.15

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_2 = arg_80_1:GetWordFromCfg(111171019)
				local var_83_3 = arg_80_1:FormatText(var_83_2.content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_4 = 46
				local var_83_5 = utf8.len(var_83_3)
				local var_83_6 = var_83_4 <= 0 and var_83_1 or var_83_1 * (var_83_5 / var_83_4)

				if var_83_6 > 0 and var_83_1 < var_83_6 then
					arg_80_1.talkMaxDuration = var_83_6

					if var_83_6 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_6 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_3
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_7 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_7 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_7

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_7 and arg_80_1.time_ < var_83_0 + var_83_7 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play111171020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 111171020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play111171021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 0.65

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_2 = arg_84_1:GetWordFromCfg(111171020)
				local var_87_3 = arg_84_1:FormatText(var_87_2.content)

				arg_84_1.text_.text = var_87_3

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_4 = 26
				local var_87_5 = utf8.len(var_87_3)
				local var_87_6 = var_87_4 <= 0 and var_87_1 or var_87_1 * (var_87_5 / var_87_4)

				if var_87_6 > 0 and var_87_1 < var_87_6 then
					arg_84_1.talkMaxDuration = var_87_6

					if var_87_6 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_6 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_3
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_7 and arg_84_1.time_ < var_87_0 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play111171021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 111171021
		arg_88_1.duration_ = 2.87

		local var_88_0 = {
			ja = 1.933,
			ko = 2.866,
			zh = 2.4,
			en = 2.3
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
				arg_88_0:Play111171022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 1

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				local var_91_2 = "play"
				local var_91_3 = "effect"

				arg_88_1:AudioAction(var_91_2, var_91_3, "se_story", "se_story_fight_metal", "")
			end

			local var_91_4 = 0
			local var_91_5 = 0.25

			if var_91_4 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0

				arg_88_1.dialog_:SetActive(true)

				arg_88_1.dialogCg_.alpha = 0

				local var_91_6 = LeanTween.value(arg_88_1.dialog_, 0, 1, 0.3)

				var_91_6:setOnUpdate(LuaHelper.FloatAction(function(arg_92_0)
					arg_88_1.dialogCg_.alpha = arg_92_0
				end))
				var_91_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_88_1.dialog_)
					var_91_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_88_1.duration_ = arg_88_1.duration_ + 0.3

				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_7 = arg_88_1:FormatText(StoryNameCfg[36].name)

				arg_88_1.leftNameTxt_.text = var_91_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1096")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_8 = arg_88_1:GetWordFromCfg(111171021)
				local var_91_9 = arg_88_1:FormatText(var_91_8.content)

				arg_88_1.text_.text = var_91_9

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_10 = 10
				local var_91_11 = utf8.len(var_91_9)
				local var_91_12 = var_91_10 <= 0 and var_91_5 or var_91_5 * (var_91_11 / var_91_10)

				if var_91_12 > 0 and var_91_5 < var_91_12 then
					arg_88_1.talkMaxDuration = var_91_12
					var_91_4 = var_91_4 + 0.3

					if var_91_12 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_12 + var_91_4
					end
				end

				arg_88_1.text_.text = var_91_9
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171021", "story_v_out_111171.awb") ~= 0 then
					local var_91_13 = manager.audio:GetVoiceLength("story_v_out_111171", "111171021", "story_v_out_111171.awb") / 1000

					if var_91_13 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_4
					end

					if var_91_8.prefab_name ~= "" and arg_88_1.actors_[var_91_8.prefab_name] ~= nil then
						local var_91_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_8.prefab_name].transform, "story_v_out_111171", "111171021", "story_v_out_111171.awb")

						arg_88_1:RecordAudio("111171021", var_91_14)
						arg_88_1:RecordAudio("111171021", var_91_14)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_111171", "111171021", "story_v_out_111171.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_111171", "111171021", "story_v_out_111171.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_15 = var_91_4 + 0.3
			local var_91_16 = math.max(var_91_5, arg_88_1.talkMaxDuration)

			if var_91_15 <= arg_88_1.time_ and arg_88_1.time_ < var_91_15 + var_91_16 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_15) / var_91_16

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_15 + var_91_16 and arg_88_1.time_ < var_91_15 + var_91_16 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play111171022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 111171022
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play111171023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 1.025

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_2 = arg_94_1:GetWordFromCfg(111171022)
				local var_97_3 = arg_94_1:FormatText(var_97_2.content)

				arg_94_1.text_.text = var_97_3

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 41
				local var_97_5 = utf8.len(var_97_3)
				local var_97_6 = var_97_4 <= 0 and var_97_1 or var_97_1 * (var_97_5 / var_97_4)

				if var_97_6 > 0 and var_97_1 < var_97_6 then
					arg_94_1.talkMaxDuration = var_97_6

					if var_97_6 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_6 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_3
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_7 and arg_94_1.time_ < var_97_0 + var_97_7 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play111171023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 111171023
		arg_98_1.duration_ = 7.1

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play111171024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = "AS0108"

			if arg_98_1.bgs_[var_101_0] == nil then
				local var_101_1 = Object.Instantiate(arg_98_1.paintGo_)

				var_101_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_101_0)
				var_101_1.name = var_101_0
				var_101_1.transform.parent = arg_98_1.stage_.transform
				var_101_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_98_1.bgs_[var_101_0] = var_101_1
			end

			local var_101_2 = arg_98_1.bgs_.AS0108
			local var_101_3 = 0

			if var_101_3 < arg_98_1.time_ and arg_98_1.time_ <= var_101_3 + arg_101_0 then
				local var_101_4 = var_101_2:GetComponent("SpriteRenderer")

				if var_101_4 then
					arg_98_1.var_.alphaOldValueAS0108 = var_101_4.color.a
					arg_98_1.var_.alphaMatValueAS0108 = var_101_4
				end

				arg_98_1.var_.alphaOldValueAS0108 = 0
			end

			local var_101_5 = 1.5

			if var_101_3 <= arg_98_1.time_ and arg_98_1.time_ < var_101_3 + var_101_5 then
				local var_101_6 = (arg_98_1.time_ - var_101_3) / var_101_5
				local var_101_7 = Mathf.Lerp(arg_98_1.var_.alphaOldValueAS0108, 1, var_101_6)

				if arg_98_1.var_.alphaMatValueAS0108 then
					local var_101_8 = arg_98_1.var_.alphaMatValueAS0108.color

					var_101_8.a = var_101_7
					arg_98_1.var_.alphaMatValueAS0108.color = var_101_8
				end
			end

			if arg_98_1.time_ >= var_101_3 + var_101_5 and arg_98_1.time_ < var_101_3 + var_101_5 + arg_101_0 and arg_98_1.var_.alphaMatValueAS0108 then
				local var_101_9 = arg_98_1.var_.alphaMatValueAS0108
				local var_101_10 = var_101_9.color

				var_101_10.a = 1
				var_101_9.color = var_101_10
			end

			local var_101_11 = 0

			if var_101_11 < arg_98_1.time_ and arg_98_1.time_ <= var_101_11 + arg_101_0 then
				local var_101_12 = manager.ui.mainCamera.transform.localPosition
				local var_101_13 = Vector3.New(0, 0, 10) + Vector3.New(var_101_12.x, var_101_12.y, 0)
				local var_101_14 = arg_98_1.bgs_.AS0108

				var_101_14.transform.localPosition = var_101_13
				var_101_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_101_15 = var_101_14:GetComponent("SpriteRenderer")

				if var_101_15 and var_101_15.sprite then
					local var_101_16 = (var_101_14.transform.localPosition - var_101_12).z
					local var_101_17 = manager.ui.mainCameraCom_
					local var_101_18 = 2 * var_101_16 * Mathf.Tan(var_101_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_101_19 = var_101_18 * var_101_17.aspect
					local var_101_20 = var_101_15.sprite.bounds.size.x
					local var_101_21 = var_101_15.sprite.bounds.size.y
					local var_101_22 = var_101_19 / var_101_20
					local var_101_23 = var_101_18 / var_101_21
					local var_101_24 = var_101_23 < var_101_22 and var_101_22 or var_101_23

					var_101_14.transform.localScale = Vector3.New(var_101_24, var_101_24, 0)
				end

				for iter_101_0, iter_101_1 in pairs(arg_98_1.bgs_) do
					if iter_101_0 ~= "AS0108" then
						iter_101_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_101_25 = manager.ui.mainCamera.transform
			local var_101_26 = 1.5

			if var_101_26 < arg_98_1.time_ and arg_98_1.time_ <= var_101_26 + arg_101_0 then
				arg_98_1.var_.shakeOldPos = var_101_25.localPosition
			end

			local var_101_27 = 0.6

			if var_101_26 <= arg_98_1.time_ and arg_98_1.time_ < var_101_26 + var_101_27 then
				local var_101_28 = (arg_98_1.time_ - var_101_26) / 0.066
				local var_101_29, var_101_30 = math.modf(var_101_28)

				var_101_25.localPosition = Vector3.New(var_101_30 * 0.13, var_101_30 * 0.13, var_101_30 * 0.13) + arg_98_1.var_.shakeOldPos
			end

			if arg_98_1.time_ >= var_101_26 + var_101_27 and arg_98_1.time_ < var_101_26 + var_101_27 + arg_101_0 then
				var_101_25.localPosition = arg_98_1.var_.shakeOldPos
			end

			local var_101_31 = arg_98_1.bgs_.AS0108.transform
			local var_101_32 = 0

			if var_101_32 < arg_98_1.time_ and arg_98_1.time_ <= var_101_32 + arg_101_0 then
				arg_98_1.var_.moveOldPosAS0108 = var_101_31.localPosition
			end

			local var_101_33 = 0.001

			if var_101_32 <= arg_98_1.time_ and arg_98_1.time_ < var_101_32 + var_101_33 then
				local var_101_34 = (arg_98_1.time_ - var_101_32) / var_101_33
				local var_101_35 = Vector3.New(0.5, 1, 8)

				var_101_31.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPosAS0108, var_101_35, var_101_34)
			end

			if arg_98_1.time_ >= var_101_32 + var_101_33 and arg_98_1.time_ < var_101_32 + var_101_33 + arg_101_0 then
				var_101_31.localPosition = Vector3.New(0.5, 1, 8)
			end

			local var_101_36 = arg_98_1.bgs_.AS0108.transform
			local var_101_37 = 0.034

			if var_101_37 < arg_98_1.time_ and arg_98_1.time_ <= var_101_37 + arg_101_0 then
				arg_98_1.var_.moveOldPosAS0108 = var_101_36.localPosition
			end

			local var_101_38 = 2.066

			if var_101_37 <= arg_98_1.time_ and arg_98_1.time_ < var_101_37 + var_101_38 then
				local var_101_39 = (arg_98_1.time_ - var_101_37) / var_101_38
				local var_101_40 = Vector3.New(0, 1, 10)

				var_101_36.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPosAS0108, var_101_40, var_101_39)
			end

			if arg_98_1.time_ >= var_101_37 + var_101_38 and arg_98_1.time_ < var_101_37 + var_101_38 + arg_101_0 then
				var_101_36.localPosition = Vector3.New(0, 1, 10)
			end

			local var_101_41 = 0

			if var_101_41 < arg_98_1.time_ and arg_98_1.time_ <= var_101_41 + arg_101_0 then
				arg_98_1.allBtn_.enabled = false
			end

			local var_101_42 = 2.1

			if arg_98_1.time_ >= var_101_41 + var_101_42 and arg_98_1.time_ < var_101_41 + var_101_42 + arg_101_0 then
				arg_98_1.allBtn_.enabled = true
			end

			local var_101_43 = 1.3

			if var_101_43 < arg_98_1.time_ and arg_98_1.time_ <= var_101_43 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = false

				arg_98_1:SetGaussion(false)
			end

			local var_101_44 = 0.5

			if var_101_43 <= arg_98_1.time_ and arg_98_1.time_ < var_101_43 + var_101_44 then
				local var_101_45 = (arg_98_1.time_ - var_101_43) / var_101_44
				local var_101_46 = Color.New(1, 1, 1)

				var_101_46.a = Mathf.Lerp(1, 0, var_101_45)
				arg_98_1.mask_.color = var_101_46
			end

			if arg_98_1.time_ >= var_101_43 + var_101_44 and arg_98_1.time_ < var_101_43 + var_101_44 + arg_101_0 then
				local var_101_47 = Color.New(1, 1, 1)
				local var_101_48 = 0

				arg_98_1.mask_.enabled = false
				var_101_47.a = var_101_48
				arg_98_1.mask_.color = var_101_47
			end

			if arg_98_1.frameCnt_ <= 1 then
				arg_98_1.dialog_:SetActive(false)
			end

			local var_101_49 = 2.1
			local var_101_50 = 1.35

			if var_101_49 < arg_98_1.time_ and arg_98_1.time_ <= var_101_49 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0

				arg_98_1.dialog_:SetActive(true)

				arg_98_1.dialogCg_.alpha = 0

				local var_101_51 = LeanTween.value(arg_98_1.dialog_, 0, 1, 0.3)

				var_101_51:setOnUpdate(LuaHelper.FloatAction(function(arg_102_0)
					arg_98_1.dialogCg_.alpha = arg_102_0
				end))
				var_101_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_98_1.dialog_)
					var_101_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_98_1.duration_ = arg_98_1.duration_ + 0.3

				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_52 = arg_98_1:GetWordFromCfg(111171023)
				local var_101_53 = arg_98_1:FormatText(var_101_52.content)

				arg_98_1.text_.text = var_101_53

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_54 = 54
				local var_101_55 = utf8.len(var_101_53)
				local var_101_56 = var_101_54 <= 0 and var_101_50 or var_101_50 * (var_101_55 / var_101_54)

				if var_101_56 > 0 and var_101_50 < var_101_56 then
					arg_98_1.talkMaxDuration = var_101_56
					var_101_49 = var_101_49 + 0.3

					if var_101_56 + var_101_49 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_56 + var_101_49
					end
				end

				arg_98_1.text_.text = var_101_53
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_57 = var_101_49 + 0.3
			local var_101_58 = math.max(var_101_50, arg_98_1.talkMaxDuration)

			if var_101_57 <= arg_98_1.time_ and arg_98_1.time_ < var_101_57 + var_101_58 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_57) / var_101_58

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_57 + var_101_58 and arg_98_1.time_ < var_101_57 + var_101_58 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "AS0108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "AS0108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.066,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play111171024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 111171024
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play111171025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.875

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_2 = arg_104_1:GetWordFromCfg(111171024)
				local var_107_3 = arg_104_1:FormatText(var_107_2.content)

				arg_104_1.text_.text = var_107_3

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_4 = 35
				local var_107_5 = utf8.len(var_107_3)
				local var_107_6 = var_107_4 <= 0 and var_107_1 or var_107_1 * (var_107_5 / var_107_4)

				if var_107_6 > 0 and var_107_1 < var_107_6 then
					arg_104_1.talkMaxDuration = var_107_6

					if var_107_6 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_6 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_3
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_7 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_7 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_7

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_7 and arg_104_1.time_ < var_107_0 + var_107_7 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play111171025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 111171025
		arg_108_1.duration_ = 2.13

		local var_108_0 = {
			ja = 1.2,
			ko = 1.2,
			zh = 2.133,
			en = 1.333
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play111171026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.125

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[36].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1096")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_3 = arg_108_1:GetWordFromCfg(111171025)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 5
				local var_111_6 = utf8.len(var_111_4)
				local var_111_7 = var_111_5 <= 0 and var_111_1 or var_111_1 * (var_111_6 / var_111_5)

				if var_111_7 > 0 and var_111_1 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_4
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171025", "story_v_out_111171.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_out_111171", "111171025", "story_v_out_111171.awb") / 1000

					if var_111_8 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_0
					end

					if var_111_3.prefab_name ~= "" and arg_108_1.actors_[var_111_3.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_3.prefab_name].transform, "story_v_out_111171", "111171025", "story_v_out_111171.awb")

						arg_108_1:RecordAudio("111171025", var_111_9)
						arg_108_1:RecordAudio("111171025", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_111171", "111171025", "story_v_out_111171.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_111171", "111171025", "story_v_out_111171.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_10 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_10 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_10

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_10 and arg_108_1.time_ < var_111_0 + var_111_10 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play111171026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 111171026
		arg_112_1.duration_ = 6.4

		local var_112_0 = {
			ja = 3.033,
			ko = 1.433,
			zh = 6.4,
			en = 0.966
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play111171027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.225

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[167].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedc")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_3 = arg_112_1:GetWordFromCfg(111171026)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 4
				local var_115_6 = utf8.len(var_115_4)
				local var_115_7 = var_115_5 <= 0 and var_115_1 or var_115_1 * (var_115_6 / var_115_5)

				if var_115_7 > 0 and var_115_1 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_0
					end
				end

				arg_112_1.text_.text = var_115_4
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171026", "story_v_out_111171.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_111171", "111171026", "story_v_out_111171.awb") / 1000

					if var_115_8 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_0
					end

					if var_115_3.prefab_name ~= "" and arg_112_1.actors_[var_115_3.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_3.prefab_name].transform, "story_v_out_111171", "111171026", "story_v_out_111171.awb")

						arg_112_1:RecordAudio("111171026", var_115_9)
						arg_112_1:RecordAudio("111171026", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_111171", "111171026", "story_v_out_111171.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_111171", "111171026", "story_v_out_111171.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_10 and arg_112_1.time_ < var_115_0 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play111171027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 111171027
		arg_116_1.duration_ = 16.97

		local var_116_0 = {
			ja = 16.966,
			ko = 11.933,
			zh = 16.633,
			en = 12.1
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play111171028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 1

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				local var_119_1 = manager.ui.mainCamera.transform.localPosition
				local var_119_2 = Vector3.New(0, 0, 10) + Vector3.New(var_119_1.x, var_119_1.y, 0)
				local var_119_3 = arg_116_1.bgs_.D05

				var_119_3.transform.localPosition = var_119_2
				var_119_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_119_4 = var_119_3:GetComponent("SpriteRenderer")

				if var_119_4 and var_119_4.sprite then
					local var_119_5 = (var_119_3.transform.localPosition - var_119_1).z
					local var_119_6 = manager.ui.mainCameraCom_
					local var_119_7 = 2 * var_119_5 * Mathf.Tan(var_119_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_119_8 = var_119_7 * var_119_6.aspect
					local var_119_9 = var_119_4.sprite.bounds.size.x
					local var_119_10 = var_119_4.sprite.bounds.size.y
					local var_119_11 = var_119_8 / var_119_9
					local var_119_12 = var_119_7 / var_119_10
					local var_119_13 = var_119_12 < var_119_11 and var_119_11 or var_119_12

					var_119_3.transform.localScale = Vector3.New(var_119_13, var_119_13, 0)
				end

				for iter_119_0, iter_119_1 in pairs(arg_116_1.bgs_) do
					if iter_119_0 ~= "D05" then
						iter_119_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_119_14 = arg_116_1.bgs_.AS0108
			local var_119_15 = 0

			if var_119_15 < arg_116_1.time_ and arg_116_1.time_ <= var_119_15 + arg_119_0 then
				local var_119_16 = var_119_14:GetComponent("SpriteRenderer")

				if var_119_16 then
					arg_116_1.var_.alphaOldValueAS0108 = var_119_16.color.a
					arg_116_1.var_.alphaMatValueAS0108 = var_119_16
				end

				arg_116_1.var_.alphaOldValueAS0108 = 1
			end

			local var_119_17 = 1

			if var_119_15 <= arg_116_1.time_ and arg_116_1.time_ < var_119_15 + var_119_17 then
				local var_119_18 = (arg_116_1.time_ - var_119_15) / var_119_17
				local var_119_19 = Mathf.Lerp(arg_116_1.var_.alphaOldValueAS0108, 0, var_119_18)

				if arg_116_1.var_.alphaMatValueAS0108 then
					local var_119_20 = arg_116_1.var_.alphaMatValueAS0108.color

					var_119_20.a = var_119_19
					arg_116_1.var_.alphaMatValueAS0108.color = var_119_20
				end
			end

			if arg_116_1.time_ >= var_119_15 + var_119_17 and arg_116_1.time_ < var_119_15 + var_119_17 + arg_119_0 and arg_116_1.var_.alphaMatValueAS0108 then
				local var_119_21 = arg_116_1.var_.alphaMatValueAS0108
				local var_119_22 = var_119_21.color

				var_119_22.a = 0
				var_119_21.color = var_119_22
			end

			local var_119_23 = arg_116_1.bgs_.D05
			local var_119_24 = 1

			if var_119_24 < arg_116_1.time_ and arg_116_1.time_ <= var_119_24 + arg_119_0 then
				local var_119_25 = var_119_23:GetComponent("SpriteRenderer")

				if var_119_25 then
					arg_116_1.var_.alphaOldValueD05 = var_119_25.color.a
					arg_116_1.var_.alphaMatValueD05 = var_119_25
				end

				arg_116_1.var_.alphaOldValueD05 = 0
			end

			local var_119_26 = 1

			if var_119_24 <= arg_116_1.time_ and arg_116_1.time_ < var_119_24 + var_119_26 then
				local var_119_27 = (arg_116_1.time_ - var_119_24) / var_119_26
				local var_119_28 = Mathf.Lerp(arg_116_1.var_.alphaOldValueD05, 1, var_119_27)

				if arg_116_1.var_.alphaMatValueD05 then
					local var_119_29 = arg_116_1.var_.alphaMatValueD05.color

					var_119_29.a = var_119_28
					arg_116_1.var_.alphaMatValueD05.color = var_119_29
				end
			end

			if arg_116_1.time_ >= var_119_24 + var_119_26 and arg_116_1.time_ < var_119_24 + var_119_26 + arg_119_0 and arg_116_1.var_.alphaMatValueD05 then
				local var_119_30 = arg_116_1.var_.alphaMatValueD05
				local var_119_31 = var_119_30.color

				var_119_31.a = 1
				var_119_30.color = var_119_31
			end

			local var_119_32 = "1096ui_story"

			if arg_116_1.actors_[var_119_32] == nil then
				local var_119_33 = Asset.Load("Char/" .. "1096ui_story")

				if not isNil(var_119_33) then
					local var_119_34 = Object.Instantiate(Asset.Load("Char/" .. "1096ui_story"), arg_116_1.stage_.transform)

					var_119_34.name = var_119_32
					var_119_34.transform.localPosition = Vector3.New(0, 100, 0)
					arg_116_1.actors_[var_119_32] = var_119_34

					local var_119_35 = var_119_34:GetComponentInChildren(typeof(CharacterEffect))

					var_119_35.enabled = true

					local var_119_36 = GameObjectTools.GetOrAddComponent(var_119_34, typeof(DynamicBoneHelper))

					if var_119_36 then
						var_119_36:EnableDynamicBone(false)
					end

					arg_116_1:ShowWeapon(var_119_35.transform, false)

					arg_116_1.var_[var_119_32 .. "Animator"] = var_119_35.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_116_1.var_[var_119_32 .. "Animator"].applyRootMotion = true
					arg_116_1.var_[var_119_32 .. "LipSync"] = var_119_35.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_119_37 = arg_116_1.actors_["1096ui_story"].transform
			local var_119_38 = 1.8

			if var_119_38 < arg_116_1.time_ and arg_116_1.time_ <= var_119_38 + arg_119_0 then
				arg_116_1.var_.moveOldPos1096ui_story = var_119_37.localPosition
			end

			local var_119_39 = 0.1

			if var_119_38 <= arg_116_1.time_ and arg_116_1.time_ < var_119_38 + var_119_39 then
				local var_119_40 = (arg_116_1.time_ - var_119_38) / var_119_39
				local var_119_41 = Vector3.New(0, -1.13, -5.6)

				var_119_37.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1096ui_story, var_119_41, var_119_40)

				local var_119_42 = manager.ui.mainCamera.transform.position - var_119_37.position

				var_119_37.forward = Vector3.New(var_119_42.x, var_119_42.y, var_119_42.z)

				local var_119_43 = var_119_37.localEulerAngles

				var_119_43.z = 0
				var_119_43.x = 0
				var_119_37.localEulerAngles = var_119_43
			end

			if arg_116_1.time_ >= var_119_38 + var_119_39 and arg_116_1.time_ < var_119_38 + var_119_39 + arg_119_0 then
				var_119_37.localPosition = Vector3.New(0, -1.13, -5.6)

				local var_119_44 = manager.ui.mainCamera.transform.position - var_119_37.position

				var_119_37.forward = Vector3.New(var_119_44.x, var_119_44.y, var_119_44.z)

				local var_119_45 = var_119_37.localEulerAngles

				var_119_45.z = 0
				var_119_45.x = 0
				var_119_37.localEulerAngles = var_119_45
			end

			local var_119_46 = 1.8

			if var_119_46 < arg_116_1.time_ and arg_116_1.time_ <= var_119_46 + arg_119_0 then
				arg_116_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action4_1")
			end

			local var_119_47 = 1.8

			if var_119_47 < arg_116_1.time_ and arg_116_1.time_ <= var_119_47 + arg_119_0 then
				arg_116_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_119_48 = arg_116_1.actors_["1096ui_story"]
			local var_119_49 = 1.8

			if var_119_49 < arg_116_1.time_ and arg_116_1.time_ <= var_119_49 + arg_119_0 and not isNil(var_119_48) and arg_116_1.var_.characterEffect1096ui_story == nil then
				arg_116_1.var_.characterEffect1096ui_story = var_119_48:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_50 = 0.2

			if var_119_49 <= arg_116_1.time_ and arg_116_1.time_ < var_119_49 + var_119_50 and not isNil(var_119_48) then
				local var_119_51 = (arg_116_1.time_ - var_119_49) / var_119_50

				if arg_116_1.var_.characterEffect1096ui_story and not isNil(var_119_48) then
					arg_116_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_49 + var_119_50 and arg_116_1.time_ < var_119_49 + var_119_50 + arg_119_0 and not isNil(var_119_48) and arg_116_1.var_.characterEffect1096ui_story then
				arg_116_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_119_52 = 0

			if var_119_52 < arg_116_1.time_ and arg_116_1.time_ <= var_119_52 + arg_119_0 then
				arg_116_1.allBtn_.enabled = false
			end

			local var_119_53 = 2

			if arg_116_1.time_ >= var_119_52 + var_119_53 and arg_116_1.time_ < var_119_52 + var_119_53 + arg_119_0 then
				arg_116_1.allBtn_.enabled = true
			end

			if arg_116_1.frameCnt_ <= 1 then
				arg_116_1.dialog_:SetActive(false)
			end

			local var_119_54 = 2
			local var_119_55 = 1.025

			if var_119_54 < arg_116_1.time_ and arg_116_1.time_ <= var_119_54 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0

				arg_116_1.dialog_:SetActive(true)

				arg_116_1.dialogCg_.alpha = 0

				local var_119_56 = LeanTween.value(arg_116_1.dialog_, 0, 1, 0.3)

				var_119_56:setOnUpdate(LuaHelper.FloatAction(function(arg_120_0)
					arg_116_1.dialogCg_.alpha = arg_120_0
				end))
				var_119_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_116_1.dialog_)
					var_119_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_116_1.duration_ = arg_116_1.duration_ + 0.3

				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_57 = arg_116_1:FormatText(StoryNameCfg[36].name)

				arg_116_1.leftNameTxt_.text = var_119_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_58 = arg_116_1:GetWordFromCfg(111171027)
				local var_119_59 = arg_116_1:FormatText(var_119_58.content)

				arg_116_1.text_.text = var_119_59

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_60 = 41
				local var_119_61 = utf8.len(var_119_59)
				local var_119_62 = var_119_60 <= 0 and var_119_55 or var_119_55 * (var_119_61 / var_119_60)

				if var_119_62 > 0 and var_119_55 < var_119_62 then
					arg_116_1.talkMaxDuration = var_119_62
					var_119_54 = var_119_54 + 0.3

					if var_119_62 + var_119_54 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_62 + var_119_54
					end
				end

				arg_116_1.text_.text = var_119_59
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171027", "story_v_out_111171.awb") ~= 0 then
					local var_119_63 = manager.audio:GetVoiceLength("story_v_out_111171", "111171027", "story_v_out_111171.awb") / 1000

					if var_119_63 + var_119_54 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_63 + var_119_54
					end

					if var_119_58.prefab_name ~= "" and arg_116_1.actors_[var_119_58.prefab_name] ~= nil then
						local var_119_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_58.prefab_name].transform, "story_v_out_111171", "111171027", "story_v_out_111171.awb")

						arg_116_1:RecordAudio("111171027", var_119_64)
						arg_116_1:RecordAudio("111171027", var_119_64)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_111171", "111171027", "story_v_out_111171.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_111171", "111171027", "story_v_out_111171.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_65 = var_119_54 + 0.3
			local var_119_66 = math.max(var_119_55, arg_116_1.talkMaxDuration)

			if var_119_65 <= arg_116_1.time_ and arg_116_1.time_ < var_119_65 + var_119_66 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_65) / var_119_66

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_65 + var_119_66 and arg_116_1.time_ < var_119_65 + var_119_66 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play111171028 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 111171028
		arg_122_1.duration_ = 8.1

		local var_122_0 = {
			ja = 4.6,
			ko = 3.6,
			zh = 8.1,
			en = 6.833
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
				arg_122_0:Play111171029(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1096ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1096ui_story == nil then
				arg_122_1.var_.characterEffect1096ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.2

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect1096ui_story and not isNil(var_125_0) then
					local var_125_4 = Mathf.Lerp(0, 0.5, var_125_3)

					arg_122_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1096ui_story.fillRatio = var_125_4
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1096ui_story then
				local var_125_5 = 0.5

				arg_122_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1096ui_story.fillRatio = var_125_5
			end

			local var_125_6 = 0
			local var_125_7 = 0.425

			if var_125_6 < arg_122_1.time_ and arg_122_1.time_ <= var_125_6 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_8 = arg_122_1:FormatText(StoryNameCfg[167].name)

				arg_122_1.leftNameTxt_.text = var_125_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedc")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_9 = arg_122_1:GetWordFromCfg(111171028)
				local var_125_10 = arg_122_1:FormatText(var_125_9.content)

				arg_122_1.text_.text = var_125_10

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_11 = 13
				local var_125_12 = utf8.len(var_125_10)
				local var_125_13 = var_125_11 <= 0 and var_125_7 or var_125_7 * (var_125_12 / var_125_11)

				if var_125_13 > 0 and var_125_7 < var_125_13 then
					arg_122_1.talkMaxDuration = var_125_13

					if var_125_13 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_13 + var_125_6
					end
				end

				arg_122_1.text_.text = var_125_10
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171028", "story_v_out_111171.awb") ~= 0 then
					local var_125_14 = manager.audio:GetVoiceLength("story_v_out_111171", "111171028", "story_v_out_111171.awb") / 1000

					if var_125_14 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_14 + var_125_6
					end

					if var_125_9.prefab_name ~= "" and arg_122_1.actors_[var_125_9.prefab_name] ~= nil then
						local var_125_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_9.prefab_name].transform, "story_v_out_111171", "111171028", "story_v_out_111171.awb")

						arg_122_1:RecordAudio("111171028", var_125_15)
						arg_122_1:RecordAudio("111171028", var_125_15)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_111171", "111171028", "story_v_out_111171.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_111171", "111171028", "story_v_out_111171.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_16 = math.max(var_125_7, arg_122_1.talkMaxDuration)

			if var_125_6 <= arg_122_1.time_ and arg_122_1.time_ < var_125_6 + var_125_16 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_6) / var_125_16

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_6 + var_125_16 and arg_122_1.time_ < var_125_6 + var_125_16 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play111171029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 111171029
		arg_126_1.duration_ = 7.2

		local var_126_0 = {
			ja = 3.4,
			ko = 7.2,
			zh = 5.3,
			en = 5.5
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
				arg_126_0:Play111171030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0

			if var_129_0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				arg_126_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action4_2")
			end

			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_129_2 = arg_126_1.actors_["1096ui_story"]
			local var_129_3 = 0

			if var_129_3 < arg_126_1.time_ and arg_126_1.time_ <= var_129_3 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.characterEffect1096ui_story == nil then
				arg_126_1.var_.characterEffect1096ui_story = var_129_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_4 = 0.2

			if var_129_3 <= arg_126_1.time_ and arg_126_1.time_ < var_129_3 + var_129_4 and not isNil(var_129_2) then
				local var_129_5 = (arg_126_1.time_ - var_129_3) / var_129_4

				if arg_126_1.var_.characterEffect1096ui_story and not isNil(var_129_2) then
					arg_126_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_3 + var_129_4 and arg_126_1.time_ < var_129_3 + var_129_4 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.characterEffect1096ui_story then
				arg_126_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_129_6 = 0
			local var_129_7 = 0.6

			if var_129_6 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_8 = arg_126_1:FormatText(StoryNameCfg[36].name)

				arg_126_1.leftNameTxt_.text = var_129_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_9 = arg_126_1:GetWordFromCfg(111171029)
				local var_129_10 = arg_126_1:FormatText(var_129_9.content)

				arg_126_1.text_.text = var_129_10

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_11 = 24
				local var_129_12 = utf8.len(var_129_10)
				local var_129_13 = var_129_11 <= 0 and var_129_7 or var_129_7 * (var_129_12 / var_129_11)

				if var_129_13 > 0 and var_129_7 < var_129_13 then
					arg_126_1.talkMaxDuration = var_129_13

					if var_129_13 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_13 + var_129_6
					end
				end

				arg_126_1.text_.text = var_129_10
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171029", "story_v_out_111171.awb") ~= 0 then
					local var_129_14 = manager.audio:GetVoiceLength("story_v_out_111171", "111171029", "story_v_out_111171.awb") / 1000

					if var_129_14 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_14 + var_129_6
					end

					if var_129_9.prefab_name ~= "" and arg_126_1.actors_[var_129_9.prefab_name] ~= nil then
						local var_129_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_9.prefab_name].transform, "story_v_out_111171", "111171029", "story_v_out_111171.awb")

						arg_126_1:RecordAudio("111171029", var_129_15)
						arg_126_1:RecordAudio("111171029", var_129_15)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_111171", "111171029", "story_v_out_111171.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_111171", "111171029", "story_v_out_111171.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_16 = math.max(var_129_7, arg_126_1.talkMaxDuration)

			if var_129_6 <= arg_126_1.time_ and arg_126_1.time_ < var_129_6 + var_129_16 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_6) / var_129_16

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_6 + var_129_16 and arg_126_1.time_ < var_129_6 + var_129_16 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play111171030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 111171030
		arg_130_1.duration_ = 8.13

		local var_130_0 = {
			ja = 8.133,
			ko = 7.733,
			zh = 5.3,
			en = 4.966
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
				arg_130_0:Play111171031(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_133_1 = 0
			local var_133_2 = 0.775

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_3 = arg_130_1:FormatText(StoryNameCfg[36].name)

				arg_130_1.leftNameTxt_.text = var_133_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_4 = arg_130_1:GetWordFromCfg(111171030)
				local var_133_5 = arg_130_1:FormatText(var_133_4.content)

				arg_130_1.text_.text = var_133_5

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_6 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171030", "story_v_out_111171.awb") ~= 0 then
					local var_133_9 = manager.audio:GetVoiceLength("story_v_out_111171", "111171030", "story_v_out_111171.awb") / 1000

					if var_133_9 + var_133_1 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_9 + var_133_1
					end

					if var_133_4.prefab_name ~= "" and arg_130_1.actors_[var_133_4.prefab_name] ~= nil then
						local var_133_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_4.prefab_name].transform, "story_v_out_111171", "111171030", "story_v_out_111171.awb")

						arg_130_1:RecordAudio("111171030", var_133_10)
						arg_130_1:RecordAudio("111171030", var_133_10)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_111171", "111171030", "story_v_out_111171.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_111171", "111171030", "story_v_out_111171.awb")
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
	Play111171031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 111171031
		arg_134_1.duration_ = 5.33

		local var_134_0 = {
			ja = 2.633,
			ko = 3.866,
			zh = 5.333,
			en = 4.833
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
				arg_134_0:Play111171032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1096ui_story"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1096ui_story == nil then
				arg_134_1.var_.characterEffect1096ui_story = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.2

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect1096ui_story and not isNil(var_137_0) then
					local var_137_4 = Mathf.Lerp(0, 0.5, var_137_3)

					arg_134_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1096ui_story.fillRatio = var_137_4
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1096ui_story then
				local var_137_5 = 0.5

				arg_134_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1096ui_story.fillRatio = var_137_5
			end

			local var_137_6 = 0
			local var_137_7 = 0.575

			if var_137_6 < arg_134_1.time_ and arg_134_1.time_ <= var_137_6 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_8 = arg_134_1:FormatText(StoryNameCfg[167].name)

				arg_134_1.leftNameTxt_.text = var_137_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedc")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_9 = arg_134_1:GetWordFromCfg(111171031)
				local var_137_10 = arg_134_1:FormatText(var_137_9.content)

				arg_134_1.text_.text = var_137_10

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_11 = 19
				local var_137_12 = utf8.len(var_137_10)
				local var_137_13 = var_137_11 <= 0 and var_137_7 or var_137_7 * (var_137_12 / var_137_11)

				if var_137_13 > 0 and var_137_7 < var_137_13 then
					arg_134_1.talkMaxDuration = var_137_13

					if var_137_13 + var_137_6 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_13 + var_137_6
					end
				end

				arg_134_1.text_.text = var_137_10
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171031", "story_v_out_111171.awb") ~= 0 then
					local var_137_14 = manager.audio:GetVoiceLength("story_v_out_111171", "111171031", "story_v_out_111171.awb") / 1000

					if var_137_14 + var_137_6 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_14 + var_137_6
					end

					if var_137_9.prefab_name ~= "" and arg_134_1.actors_[var_137_9.prefab_name] ~= nil then
						local var_137_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_9.prefab_name].transform, "story_v_out_111171", "111171031", "story_v_out_111171.awb")

						arg_134_1:RecordAudio("111171031", var_137_15)
						arg_134_1:RecordAudio("111171031", var_137_15)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_111171", "111171031", "story_v_out_111171.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_111171", "111171031", "story_v_out_111171.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_16 = math.max(var_137_7, arg_134_1.talkMaxDuration)

			if var_137_6 <= arg_134_1.time_ and arg_134_1.time_ < var_137_6 + var_137_16 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_6) / var_137_16

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_6 + var_137_16 and arg_134_1.time_ < var_137_6 + var_137_16 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play111171032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 111171032
		arg_138_1.duration_ = 4.63

		local var_138_0 = {
			ja = 4.633,
			ko = 4.633,
			zh = 4.1,
			en = 3.4
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
			arg_138_1.auto_ = false
		end

		function arg_138_1.playNext_(arg_140_0)
			arg_138_1.onStoryFinished_()
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_141_1 = arg_138_1.actors_["1096ui_story"]
			local var_141_2 = 0

			if var_141_2 < arg_138_1.time_ and arg_138_1.time_ <= var_141_2 + arg_141_0 and not isNil(var_141_1) and arg_138_1.var_.characterEffect1096ui_story == nil then
				arg_138_1.var_.characterEffect1096ui_story = var_141_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_3 = 0.2

			if var_141_2 <= arg_138_1.time_ and arg_138_1.time_ < var_141_2 + var_141_3 and not isNil(var_141_1) then
				local var_141_4 = (arg_138_1.time_ - var_141_2) / var_141_3

				if arg_138_1.var_.characterEffect1096ui_story and not isNil(var_141_1) then
					arg_138_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_2 + var_141_3 and arg_138_1.time_ < var_141_2 + var_141_3 + arg_141_0 and not isNil(var_141_1) and arg_138_1.var_.characterEffect1096ui_story then
				arg_138_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_141_5 = 0
			local var_141_6 = 0.475

			if var_141_5 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_7 = arg_138_1:FormatText(StoryNameCfg[36].name)

				arg_138_1.leftNameTxt_.text = var_141_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_8 = arg_138_1:GetWordFromCfg(111171032)
				local var_141_9 = arg_138_1:FormatText(var_141_8.content)

				arg_138_1.text_.text = var_141_9

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_10 = 17
				local var_141_11 = utf8.len(var_141_9)
				local var_141_12 = var_141_10 <= 0 and var_141_6 or var_141_6 * (var_141_11 / var_141_10)

				if var_141_12 > 0 and var_141_6 < var_141_12 then
					arg_138_1.talkMaxDuration = var_141_12

					if var_141_12 + var_141_5 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_12 + var_141_5
					end
				end

				arg_138_1.text_.text = var_141_9
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111171", "111171032", "story_v_out_111171.awb") ~= 0 then
					local var_141_13 = manager.audio:GetVoiceLength("story_v_out_111171", "111171032", "story_v_out_111171.awb") / 1000

					if var_141_13 + var_141_5 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_13 + var_141_5
					end

					if var_141_8.prefab_name ~= "" and arg_138_1.actors_[var_141_8.prefab_name] ~= nil then
						local var_141_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_8.prefab_name].transform, "story_v_out_111171", "111171032", "story_v_out_111171.awb")

						arg_138_1:RecordAudio("111171032", var_141_14)
						arg_138_1:RecordAudio("111171032", var_141_14)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_111171", "111171032", "story_v_out_111171.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_111171", "111171032", "story_v_out_111171.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_15 = math.max(var_141_6, arg_138_1.talkMaxDuration)

			if var_141_5 <= arg_138_1.time_ and arg_138_1.time_ < var_141_5 + var_141_15 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_5) / var_141_15

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_5 + var_141_15 and arg_138_1.time_ < var_141_5 + var_141_15 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/D05",
		"TextureConfig/Background/AS0108"
	},
	voices = {
		"story_v_out_111171.awb"
	}
}
