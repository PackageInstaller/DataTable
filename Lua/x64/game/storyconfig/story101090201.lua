return {
	Play109021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 109021001
		arg_1_1.duration_ = 8.3

		local var_1_0 = {
			ja = 8.3,
			ko = 7.733,
			zh = 6.266,
			en = 7.1
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
				arg_1_0:Play109021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "C02b"

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
				local var_4_5 = arg_1_1.bgs_.C02b

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
					if iter_4_0 ~= "C02b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.C02b
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueC02b = var_4_18.color.a
					arg_1_1.var_.alphaMatValueC02b = var_4_18
				end

				arg_1_1.var_.alphaOldValueC02b = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueC02b, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueC02b then
					local var_4_22 = arg_1_1.var_.alphaMatValueC02b.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueC02b.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueC02b then
				local var_4_23 = arg_1_1.var_.alphaMatValueC02b
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = "1084ui_story"

			if arg_1_1.actors_[var_4_25] == nil then
				local var_4_26 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_4_26) then
					local var_4_27 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

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

			local var_4_30 = arg_1_1.actors_["1084ui_story"].transform
			local var_4_31 = 1.8

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_30.localPosition
			end

			local var_4_32 = 0.001

			if var_4_31 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_31) / var_4_32
				local var_4_34 = Vector3.New(-0.7, -0.97, -6)

				var_4_30.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_30.position

				var_4_30.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_30.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_30.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				var_4_30.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_4_37 = manager.ui.mainCamera.transform.position - var_4_30.position

				var_4_30.forward = Vector3.New(var_4_37.x, var_4_37.y, var_4_37.z)

				local var_4_38 = var_4_30.localEulerAngles

				var_4_38.z = 0
				var_4_38.x = 0
				var_4_30.localEulerAngles = var_4_38
			end

			local var_4_39 = arg_1_1.actors_["1084ui_story"]
			local var_4_40 = 1.8

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 and not isNil(var_4_39) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_41 = 0.2

			if var_4_40 <= arg_1_1.time_ and arg_1_1.time_ < var_4_40 + var_4_41 and not isNil(var_4_39) then
				local var_4_42 = (arg_1_1.time_ - var_4_40) / var_4_41

				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_39) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 and not isNil(var_4_39) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_4_43 = 1.8

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_4_44 = 1.8

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_4_45 = 0
			local var_4_46 = 1

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				local var_4_47 = "play"
				local var_4_48 = "music"

				arg_1_1:AudioAction(var_4_47, var_4_48, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_49 = ""
				local var_4_50 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_4_50 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_50 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_50

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_50
						arg_1_1.bgmTxt2_.text = var_4_50
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

			local var_4_51 = 0

			if var_4_51 < arg_1_1.time_ and arg_1_1.time_ <= var_4_51 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_52 = 2

			if arg_1_1.time_ >= var_4_51 + var_4_52 and arg_1_1.time_ < var_4_51 + var_4_52 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_53 = 2
			local var_4_54 = 0.575

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

				local var_4_56 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_57 = arg_1_1:GetWordFromCfg(109021001)
				local var_4_58 = arg_1_1:FormatText(var_4_57.content)

				arg_1_1.text_.text = var_4_58

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_59 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_109021", "109021001", "story_v_out_109021.awb") ~= 0 then
					local var_4_62 = manager.audio:GetVoiceLength("story_v_out_109021", "109021001", "story_v_out_109021.awb") / 1000

					if var_4_62 + var_4_53 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_53
					end

					if var_4_57.prefab_name ~= "" and arg_1_1.actors_[var_4_57.prefab_name] ~= nil then
						local var_4_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_57.prefab_name].transform, "story_v_out_109021", "109021001", "story_v_out_109021.awb")

						arg_1_1:RecordAudio("109021001", var_4_63)
						arg_1_1:RecordAudio("109021001", var_4_63)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_109021", "109021001", "story_v_out_109021.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_109021", "109021001", "story_v_out_109021.awb")
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play109021002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 109021002
		arg_8_1.duration_ = 7.6

		local var_8_0 = {
			ja = 7.433,
			ko = 6.433,
			zh = 5.1,
			en = 7.6
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
				arg_8_0:Play109021003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1099ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1099ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1099ui_story"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1099ui_story == nil then
				arg_8_1.var_.characterEffect1099ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.2

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect1099ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1099ui_story then
				arg_8_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_11_9 = arg_8_1.actors_["1084ui_story"]
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_11 = 0.2

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_11 and not isNil(var_11_9) then
				local var_11_12 = (arg_8_1.time_ - var_11_10) / var_11_11

				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_9) then
					local var_11_13 = Mathf.Lerp(0, 0.5, var_11_12)

					arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1084ui_story.fillRatio = var_11_13
				end
			end

			if arg_8_1.time_ >= var_11_10 + var_11_11 and arg_8_1.time_ < var_11_10 + var_11_11 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect1084ui_story then
				local var_11_14 = 0.5

				arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1084ui_story.fillRatio = var_11_14
			end

			local var_11_15 = 0

			if var_11_15 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 then
				arg_8_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_1")
			end

			local var_11_16 = arg_8_1.actors_["1099ui_story"].transform
			local var_11_17 = 0

			if var_11_17 < arg_8_1.time_ and arg_8_1.time_ <= var_11_17 + arg_11_0 then
				arg_8_1.var_.moveOldPos1099ui_story = var_11_16.localPosition
			end

			local var_11_18 = 0.001

			if var_11_17 <= arg_8_1.time_ and arg_8_1.time_ < var_11_17 + var_11_18 then
				local var_11_19 = (arg_8_1.time_ - var_11_17) / var_11_18
				local var_11_20 = Vector3.New(0.7, -1.08, -5.9)

				var_11_16.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1099ui_story, var_11_20, var_11_19)

				local var_11_21 = manager.ui.mainCamera.transform.position - var_11_16.position

				var_11_16.forward = Vector3.New(var_11_21.x, var_11_21.y, var_11_21.z)

				local var_11_22 = var_11_16.localEulerAngles

				var_11_22.z = 0
				var_11_22.x = 0
				var_11_16.localEulerAngles = var_11_22
			end

			if arg_8_1.time_ >= var_11_17 + var_11_18 and arg_8_1.time_ < var_11_17 + var_11_18 + arg_11_0 then
				var_11_16.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_11_23 = manager.ui.mainCamera.transform.position - var_11_16.position

				var_11_16.forward = Vector3.New(var_11_23.x, var_11_23.y, var_11_23.z)

				local var_11_24 = var_11_16.localEulerAngles

				var_11_24.z = 0
				var_11_24.x = 0
				var_11_16.localEulerAngles = var_11_24
			end

			local var_11_25 = 0

			if var_11_25 < arg_8_1.time_ and arg_8_1.time_ <= var_11_25 + arg_11_0 then
				arg_8_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_11_26 = 0
			local var_11_27 = 0.725

			if var_11_26 < arg_8_1.time_ and arg_8_1.time_ <= var_11_26 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_28 = arg_8_1:FormatText(StoryNameCfg[84].name)

				arg_8_1.leftNameTxt_.text = var_11_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_29 = arg_8_1:GetWordFromCfg(109021002)
				local var_11_30 = arg_8_1:FormatText(var_11_29.content)

				arg_8_1.text_.text = var_11_30

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_31 = 24
				local var_11_32 = utf8.len(var_11_30)
				local var_11_33 = var_11_31 <= 0 and var_11_27 or var_11_27 * (var_11_32 / var_11_31)

				if var_11_33 > 0 and var_11_27 < var_11_33 then
					arg_8_1.talkMaxDuration = var_11_33

					if var_11_33 + var_11_26 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_33 + var_11_26
					end
				end

				arg_8_1.text_.text = var_11_30
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109021", "109021002", "story_v_out_109021.awb") ~= 0 then
					local var_11_34 = manager.audio:GetVoiceLength("story_v_out_109021", "109021002", "story_v_out_109021.awb") / 1000

					if var_11_34 + var_11_26 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_34 + var_11_26
					end

					if var_11_29.prefab_name ~= "" and arg_8_1.actors_[var_11_29.prefab_name] ~= nil then
						local var_11_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_29.prefab_name].transform, "story_v_out_109021", "109021002", "story_v_out_109021.awb")

						arg_8_1:RecordAudio("109021002", var_11_35)
						arg_8_1:RecordAudio("109021002", var_11_35)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_109021", "109021002", "story_v_out_109021.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_109021", "109021002", "story_v_out_109021.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_36 = math.max(var_11_27, arg_8_1.talkMaxDuration)

			if var_11_26 <= arg_8_1.time_ and arg_8_1.time_ < var_11_26 + var_11_36 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_26) / var_11_36

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_26 + var_11_36 and arg_8_1.time_ < var_11_26 + var_11_36 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
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

		arg_8_1:InitPlayNodeList()
	end,
	Play109021003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 109021003
		arg_12_1.duration_ = 11.17

		local var_12_0 = {
			ja = 11.166,
			ko = 10,
			zh = 7.866,
			en = 8.6
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
				arg_12_0:Play109021004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_15_1 = 0
			local var_15_2 = 1

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_3 = arg_12_1:FormatText(StoryNameCfg[84].name)

				arg_12_1.leftNameTxt_.text = var_15_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_4 = arg_12_1:GetWordFromCfg(109021003)
				local var_15_5 = arg_12_1:FormatText(var_15_4.content)

				arg_12_1.text_.text = var_15_5

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_6 = 40
				local var_15_7 = utf8.len(var_15_5)
				local var_15_8 = var_15_6 <= 0 and var_15_2 or var_15_2 * (var_15_7 / var_15_6)

				if var_15_8 > 0 and var_15_2 < var_15_8 then
					arg_12_1.talkMaxDuration = var_15_8

					if var_15_8 + var_15_1 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_1
					end
				end

				arg_12_1.text_.text = var_15_5
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109021", "109021003", "story_v_out_109021.awb") ~= 0 then
					local var_15_9 = manager.audio:GetVoiceLength("story_v_out_109021", "109021003", "story_v_out_109021.awb") / 1000

					if var_15_9 + var_15_1 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_9 + var_15_1
					end

					if var_15_4.prefab_name ~= "" and arg_12_1.actors_[var_15_4.prefab_name] ~= nil then
						local var_15_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_4.prefab_name].transform, "story_v_out_109021", "109021003", "story_v_out_109021.awb")

						arg_12_1:RecordAudio("109021003", var_15_10)
						arg_12_1:RecordAudio("109021003", var_15_10)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_109021", "109021003", "story_v_out_109021.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_109021", "109021003", "story_v_out_109021.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_11 = math.max(var_15_2, arg_12_1.talkMaxDuration)

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_11 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_1) / var_15_11

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_1 + var_15_11 and arg_12_1.time_ < var_15_1 + var_15_11 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play109021004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 109021004
		arg_16_1.duration_ = 8.8

		local var_16_0 = {
			ja = 8.8,
			ko = 4.333,
			zh = 6.366,
			en = 4.8
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play109021005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1084ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.2

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_0) then
					arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1084ui_story then
				arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_19_4 = arg_16_1.actors_["1099ui_story"]
			local var_19_5 = 0

			if var_19_5 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.characterEffect1099ui_story == nil then
				arg_16_1.var_.characterEffect1099ui_story = var_19_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_6 = 0.2

			if var_19_5 <= arg_16_1.time_ and arg_16_1.time_ < var_19_5 + var_19_6 and not isNil(var_19_4) then
				local var_19_7 = (arg_16_1.time_ - var_19_5) / var_19_6

				if arg_16_1.var_.characterEffect1099ui_story and not isNil(var_19_4) then
					local var_19_8 = Mathf.Lerp(0, 0.5, var_19_7)

					arg_16_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1099ui_story.fillRatio = var_19_8
				end
			end

			if arg_16_1.time_ >= var_19_5 + var_19_6 and arg_16_1.time_ < var_19_5 + var_19_6 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.characterEffect1099ui_story then
				local var_19_9 = 0.5

				arg_16_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1099ui_story.fillRatio = var_19_9
			end

			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4139")
			end

			local var_19_11 = 0

			if var_19_11 < arg_16_1.time_ and arg_16_1.time_ <= var_19_11 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_19_12 = 0
			local var_19_13 = 0.825

			if var_19_12 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_14 = arg_16_1:FormatText(StoryNameCfg[6].name)

				arg_16_1.leftNameTxt_.text = var_19_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_15 = arg_16_1:GetWordFromCfg(109021004)
				local var_19_16 = arg_16_1:FormatText(var_19_15.content)

				arg_16_1.text_.text = var_19_16

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_17 = 33
				local var_19_18 = utf8.len(var_19_16)
				local var_19_19 = var_19_17 <= 0 and var_19_13 or var_19_13 * (var_19_18 / var_19_17)

				if var_19_19 > 0 and var_19_13 < var_19_19 then
					arg_16_1.talkMaxDuration = var_19_19

					if var_19_19 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_19 + var_19_12
					end
				end

				arg_16_1.text_.text = var_19_16
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109021", "109021004", "story_v_out_109021.awb") ~= 0 then
					local var_19_20 = manager.audio:GetVoiceLength("story_v_out_109021", "109021004", "story_v_out_109021.awb") / 1000

					if var_19_20 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_20 + var_19_12
					end

					if var_19_15.prefab_name ~= "" and arg_16_1.actors_[var_19_15.prefab_name] ~= nil then
						local var_19_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_15.prefab_name].transform, "story_v_out_109021", "109021004", "story_v_out_109021.awb")

						arg_16_1:RecordAudio("109021004", var_19_21)
						arg_16_1:RecordAudio("109021004", var_19_21)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_109021", "109021004", "story_v_out_109021.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_109021", "109021004", "story_v_out_109021.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_22 = math.max(var_19_13, arg_16_1.talkMaxDuration)

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_22 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_12) / var_19_22

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_12 + var_19_22 and arg_16_1.time_ < var_19_12 + var_19_22 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play109021005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 109021005
		arg_20_1.duration_ = 3.23

		local var_20_0 = {
			ja = 2.6,
			ko = 2.366,
			zh = 2.266,
			en = 3.233
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
				arg_20_0:Play109021006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "1050ui_story"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Char/" .. "1050ui_story")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_20_1.stage_.transform)

					var_23_2.name = var_23_0
					var_23_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_20_1.actors_[var_23_0] = var_23_2

					local var_23_3 = var_23_2:GetComponentInChildren(typeof(CharacterEffect))

					var_23_3.enabled = true

					local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_2, typeof(DynamicBoneHelper))

					if var_23_4 then
						var_23_4:EnableDynamicBone(false)
					end

					arg_20_1:ShowWeapon(var_23_3.transform, false)

					arg_20_1.var_[var_23_0 .. "Animator"] = var_23_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_20_1.var_[var_23_0 .. "Animator"].applyRootMotion = true
					arg_20_1.var_[var_23_0 .. "LipSync"] = var_23_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_23_5 = arg_20_1.actors_["1050ui_story"]
			local var_23_6 = 0

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1050ui_story == nil then
				arg_20_1.var_.characterEffect1050ui_story = var_23_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_7 = 0.2

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_7 and not isNil(var_23_5) then
				local var_23_8 = (arg_20_1.time_ - var_23_6) / var_23_7

				if arg_20_1.var_.characterEffect1050ui_story and not isNil(var_23_5) then
					arg_20_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_6 + var_23_7 and arg_20_1.time_ < var_23_6 + var_23_7 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1050ui_story then
				arg_20_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_23_9 = arg_20_1.actors_["1084ui_story"]
			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect1084ui_story == nil then
				arg_20_1.var_.characterEffect1084ui_story = var_23_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_11 = 0.2

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_11 and not isNil(var_23_9) then
				local var_23_12 = (arg_20_1.time_ - var_23_10) / var_23_11

				if arg_20_1.var_.characterEffect1084ui_story and not isNil(var_23_9) then
					local var_23_13 = Mathf.Lerp(0, 0.5, var_23_12)

					arg_20_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1084ui_story.fillRatio = var_23_13
				end
			end

			if arg_20_1.time_ >= var_23_10 + var_23_11 and arg_20_1.time_ < var_23_10 + var_23_11 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect1084ui_story then
				local var_23_14 = 0.5

				arg_20_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1084ui_story.fillRatio = var_23_14
			end

			local var_23_15 = arg_20_1.actors_["1099ui_story"].transform
			local var_23_16 = 0

			if var_23_16 < arg_20_1.time_ and arg_20_1.time_ <= var_23_16 + arg_23_0 then
				arg_20_1.var_.moveOldPos1099ui_story = var_23_15.localPosition
			end

			local var_23_17 = 0.001

			if var_23_16 <= arg_20_1.time_ and arg_20_1.time_ < var_23_16 + var_23_17 then
				local var_23_18 = (arg_20_1.time_ - var_23_16) / var_23_17
				local var_23_19 = Vector3.New(0, 100, 0)

				var_23_15.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1099ui_story, var_23_19, var_23_18)

				local var_23_20 = manager.ui.mainCamera.transform.position - var_23_15.position

				var_23_15.forward = Vector3.New(var_23_20.x, var_23_20.y, var_23_20.z)

				local var_23_21 = var_23_15.localEulerAngles

				var_23_21.z = 0
				var_23_21.x = 0
				var_23_15.localEulerAngles = var_23_21
			end

			if arg_20_1.time_ >= var_23_16 + var_23_17 and arg_20_1.time_ < var_23_16 + var_23_17 + arg_23_0 then
				var_23_15.localPosition = Vector3.New(0, 100, 0)

				local var_23_22 = manager.ui.mainCamera.transform.position - var_23_15.position

				var_23_15.forward = Vector3.New(var_23_22.x, var_23_22.y, var_23_22.z)

				local var_23_23 = var_23_15.localEulerAngles

				var_23_23.z = 0
				var_23_23.x = 0
				var_23_15.localEulerAngles = var_23_23
			end

			local var_23_24 = arg_20_1.actors_["1050ui_story"].transform
			local var_23_25 = 0

			if var_23_25 < arg_20_1.time_ and arg_20_1.time_ <= var_23_25 + arg_23_0 then
				arg_20_1.var_.moveOldPos1050ui_story = var_23_24.localPosition
			end

			local var_23_26 = 0.001

			if var_23_25 <= arg_20_1.time_ and arg_20_1.time_ < var_23_25 + var_23_26 then
				local var_23_27 = (arg_20_1.time_ - var_23_25) / var_23_26
				local var_23_28 = Vector3.New(0.7, -1, -6.1)

				var_23_24.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1050ui_story, var_23_28, var_23_27)

				local var_23_29 = manager.ui.mainCamera.transform.position - var_23_24.position

				var_23_24.forward = Vector3.New(var_23_29.x, var_23_29.y, var_23_29.z)

				local var_23_30 = var_23_24.localEulerAngles

				var_23_30.z = 0
				var_23_30.x = 0
				var_23_24.localEulerAngles = var_23_30
			end

			if arg_20_1.time_ >= var_23_25 + var_23_26 and arg_20_1.time_ < var_23_25 + var_23_26 + arg_23_0 then
				var_23_24.localPosition = Vector3.New(0.7, -1, -6.1)

				local var_23_31 = manager.ui.mainCamera.transform.position - var_23_24.position

				var_23_24.forward = Vector3.New(var_23_31.x, var_23_31.y, var_23_31.z)

				local var_23_32 = var_23_24.localEulerAngles

				var_23_32.z = 0
				var_23_32.x = 0
				var_23_24.localEulerAngles = var_23_32
			end

			local var_23_33 = 0

			if var_23_33 < arg_20_1.time_ and arg_20_1.time_ <= var_23_33 + arg_23_0 then
				arg_20_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action5_1")
			end

			local var_23_34 = 0

			if var_23_34 < arg_20_1.time_ and arg_20_1.time_ <= var_23_34 + arg_23_0 then
				arg_20_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_23_35 = 0
			local var_23_36 = 0.3

			if var_23_35 < arg_20_1.time_ and arg_20_1.time_ <= var_23_35 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_37 = arg_20_1:FormatText(StoryNameCfg[74].name)

				arg_20_1.leftNameTxt_.text = var_23_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_38 = arg_20_1:GetWordFromCfg(109021005)
				local var_23_39 = arg_20_1:FormatText(var_23_38.content)

				arg_20_1.text_.text = var_23_39

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_40 = 12
				local var_23_41 = utf8.len(var_23_39)
				local var_23_42 = var_23_40 <= 0 and var_23_36 or var_23_36 * (var_23_41 / var_23_40)

				if var_23_42 > 0 and var_23_36 < var_23_42 then
					arg_20_1.talkMaxDuration = var_23_42

					if var_23_42 + var_23_35 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_42 + var_23_35
					end
				end

				arg_20_1.text_.text = var_23_39
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109021", "109021005", "story_v_out_109021.awb") ~= 0 then
					local var_23_43 = manager.audio:GetVoiceLength("story_v_out_109021", "109021005", "story_v_out_109021.awb") / 1000

					if var_23_43 + var_23_35 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_43 + var_23_35
					end

					if var_23_38.prefab_name ~= "" and arg_20_1.actors_[var_23_38.prefab_name] ~= nil then
						local var_23_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_38.prefab_name].transform, "story_v_out_109021", "109021005", "story_v_out_109021.awb")

						arg_20_1:RecordAudio("109021005", var_23_44)
						arg_20_1:RecordAudio("109021005", var_23_44)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_109021", "109021005", "story_v_out_109021.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_109021", "109021005", "story_v_out_109021.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_45 = math.max(var_23_36, arg_20_1.talkMaxDuration)

			if var_23_35 <= arg_20_1.time_ and arg_20_1.time_ < var_23_35 + var_23_45 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_35) / var_23_45

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_35 + var_23_45 and arg_20_1.time_ < var_23_35 + var_23_45 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play109021006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 109021006
		arg_24_1.duration_ = 4.07

		local var_24_0 = {
			ja = 3.5,
			ko = 3.966,
			zh = 3.7,
			en = 4.066
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
				arg_24_0:Play109021007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1084ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1084ui_story == nil then
				arg_24_1.var_.characterEffect1084ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.2

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1084ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1084ui_story then
				arg_24_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_27_4 = arg_24_1.actors_["1050ui_story"]
			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect1050ui_story == nil then
				arg_24_1.var_.characterEffect1050ui_story = var_27_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_6 = 0.2

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_6 and not isNil(var_27_4) then
				local var_27_7 = (arg_24_1.time_ - var_27_5) / var_27_6

				if arg_24_1.var_.characterEffect1050ui_story and not isNil(var_27_4) then
					local var_27_8 = Mathf.Lerp(0, 0.5, var_27_7)

					arg_24_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1050ui_story.fillRatio = var_27_8
				end
			end

			if arg_24_1.time_ >= var_27_5 + var_27_6 and arg_24_1.time_ < var_27_5 + var_27_6 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect1050ui_story then
				local var_27_9 = 0.5

				arg_24_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1050ui_story.fillRatio = var_27_9
			end

			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4912")
			end

			local var_27_11 = 0

			if var_27_11 < arg_24_1.time_ and arg_24_1.time_ <= var_27_11 + arg_27_0 then
				arg_24_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_27_12 = 0
			local var_27_13 = 0.325

			if var_27_12 < arg_24_1.time_ and arg_24_1.time_ <= var_27_12 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_14 = arg_24_1:FormatText(StoryNameCfg[6].name)

				arg_24_1.leftNameTxt_.text = var_27_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_15 = arg_24_1:GetWordFromCfg(109021006)
				local var_27_16 = arg_24_1:FormatText(var_27_15.content)

				arg_24_1.text_.text = var_27_16

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_17 = 13
				local var_27_18 = utf8.len(var_27_16)
				local var_27_19 = var_27_17 <= 0 and var_27_13 or var_27_13 * (var_27_18 / var_27_17)

				if var_27_19 > 0 and var_27_13 < var_27_19 then
					arg_24_1.talkMaxDuration = var_27_19

					if var_27_19 + var_27_12 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_19 + var_27_12
					end
				end

				arg_24_1.text_.text = var_27_16
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109021", "109021006", "story_v_out_109021.awb") ~= 0 then
					local var_27_20 = manager.audio:GetVoiceLength("story_v_out_109021", "109021006", "story_v_out_109021.awb") / 1000

					if var_27_20 + var_27_12 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_20 + var_27_12
					end

					if var_27_15.prefab_name ~= "" and arg_24_1.actors_[var_27_15.prefab_name] ~= nil then
						local var_27_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_15.prefab_name].transform, "story_v_out_109021", "109021006", "story_v_out_109021.awb")

						arg_24_1:RecordAudio("109021006", var_27_21)
						arg_24_1:RecordAudio("109021006", var_27_21)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_109021", "109021006", "story_v_out_109021.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_109021", "109021006", "story_v_out_109021.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_22 = math.max(var_27_13, arg_24_1.talkMaxDuration)

			if var_27_12 <= arg_24_1.time_ and arg_24_1.time_ < var_27_12 + var_27_22 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_12) / var_27_22

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_12 + var_27_22 and arg_24_1.time_ < var_27_12 + var_27_22 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play109021007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 109021007
		arg_28_1.duration_ = 7.6

		local var_28_0 = {
			ja = 5.066,
			ko = 7.6,
			zh = 7.533,
			en = 7.366
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
				arg_28_0:Play109021008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1050ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1050ui_story == nil then
				arg_28_1.var_.characterEffect1050ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.2

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1050ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1050ui_story then
				arg_28_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_31_4 = arg_28_1.actors_["1084ui_story"]
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect1084ui_story == nil then
				arg_28_1.var_.characterEffect1084ui_story = var_31_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.2

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 and not isNil(var_31_4) then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6

				if arg_28_1.var_.characterEffect1084ui_story and not isNil(var_31_4) then
					local var_31_8 = Mathf.Lerp(0, 0.5, var_31_7)

					arg_28_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1084ui_story.fillRatio = var_31_8
				end
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect1084ui_story then
				local var_31_9 = 0.5

				arg_28_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1084ui_story.fillRatio = var_31_9
			end

			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_31_11 = 0
			local var_31_12 = 0.85

			if var_31_11 < arg_28_1.time_ and arg_28_1.time_ <= var_31_11 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_13 = arg_28_1:FormatText(StoryNameCfg[74].name)

				arg_28_1.leftNameTxt_.text = var_31_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_14 = arg_28_1:GetWordFromCfg(109021007)
				local var_31_15 = arg_28_1:FormatText(var_31_14.content)

				arg_28_1.text_.text = var_31_15

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_16 = 34
				local var_31_17 = utf8.len(var_31_15)
				local var_31_18 = var_31_16 <= 0 and var_31_12 or var_31_12 * (var_31_17 / var_31_16)

				if var_31_18 > 0 and var_31_12 < var_31_18 then
					arg_28_1.talkMaxDuration = var_31_18

					if var_31_18 + var_31_11 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_18 + var_31_11
					end
				end

				arg_28_1.text_.text = var_31_15
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109021", "109021007", "story_v_out_109021.awb") ~= 0 then
					local var_31_19 = manager.audio:GetVoiceLength("story_v_out_109021", "109021007", "story_v_out_109021.awb") / 1000

					if var_31_19 + var_31_11 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_19 + var_31_11
					end

					if var_31_14.prefab_name ~= "" and arg_28_1.actors_[var_31_14.prefab_name] ~= nil then
						local var_31_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_14.prefab_name].transform, "story_v_out_109021", "109021007", "story_v_out_109021.awb")

						arg_28_1:RecordAudio("109021007", var_31_20)
						arg_28_1:RecordAudio("109021007", var_31_20)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_109021", "109021007", "story_v_out_109021.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_109021", "109021007", "story_v_out_109021.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_21 = math.max(var_31_12, arg_28_1.talkMaxDuration)

			if var_31_11 <= arg_28_1.time_ and arg_28_1.time_ < var_31_11 + var_31_21 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_11) / var_31_21

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_11 + var_31_21 and arg_28_1.time_ < var_31_11 + var_31_21 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play109021008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 109021008
		arg_32_1.duration_ = 12.13

		local var_32_0 = {
			ja = 12.133,
			ko = 9.566,
			zh = 9.366,
			en = 9.833
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
				arg_32_0:Play109021009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1084ui_story"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos1084ui_story = var_35_0.localPosition
			end

			local var_35_2 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2
				local var_35_4 = Vector3.New(0, 100, 0)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1084ui_story, var_35_4, var_35_3)

				local var_35_5 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_5.x, var_35_5.y, var_35_5.z)

				local var_35_6 = var_35_0.localEulerAngles

				var_35_6.z = 0
				var_35_6.x = 0
				var_35_0.localEulerAngles = var_35_6
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(0, 100, 0)

				local var_35_7 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_7.x, var_35_7.y, var_35_7.z)

				local var_35_8 = var_35_0.localEulerAngles

				var_35_8.z = 0
				var_35_8.x = 0
				var_35_0.localEulerAngles = var_35_8
			end

			local var_35_9 = arg_32_1.actors_["1050ui_story"].transform
			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1.var_.moveOldPos1050ui_story = var_35_9.localPosition
			end

			local var_35_11 = 0.001

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_11 then
				local var_35_12 = (arg_32_1.time_ - var_35_10) / var_35_11
				local var_35_13 = Vector3.New(0, 100, 0)

				var_35_9.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1050ui_story, var_35_13, var_35_12)

				local var_35_14 = manager.ui.mainCamera.transform.position - var_35_9.position

				var_35_9.forward = Vector3.New(var_35_14.x, var_35_14.y, var_35_14.z)

				local var_35_15 = var_35_9.localEulerAngles

				var_35_15.z = 0
				var_35_15.x = 0
				var_35_9.localEulerAngles = var_35_15
			end

			if arg_32_1.time_ >= var_35_10 + var_35_11 and arg_32_1.time_ < var_35_10 + var_35_11 + arg_35_0 then
				var_35_9.localPosition = Vector3.New(0, 100, 0)

				local var_35_16 = manager.ui.mainCamera.transform.position - var_35_9.position

				var_35_9.forward = Vector3.New(var_35_16.x, var_35_16.y, var_35_16.z)

				local var_35_17 = var_35_9.localEulerAngles

				var_35_17.z = 0
				var_35_17.x = 0
				var_35_9.localEulerAngles = var_35_17
			end

			local var_35_18 = "1038ui_story"

			if arg_32_1.actors_[var_35_18] == nil then
				local var_35_19 = Asset.Load("Char/" .. "1038ui_story")

				if not isNil(var_35_19) then
					local var_35_20 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_32_1.stage_.transform)

					var_35_20.name = var_35_18
					var_35_20.transform.localPosition = Vector3.New(0, 100, 0)
					arg_32_1.actors_[var_35_18] = var_35_20

					local var_35_21 = var_35_20:GetComponentInChildren(typeof(CharacterEffect))

					var_35_21.enabled = true

					local var_35_22 = GameObjectTools.GetOrAddComponent(var_35_20, typeof(DynamicBoneHelper))

					if var_35_22 then
						var_35_22:EnableDynamicBone(false)
					end

					arg_32_1:ShowWeapon(var_35_21.transform, false)

					arg_32_1.var_[var_35_18 .. "Animator"] = var_35_21.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_32_1.var_[var_35_18 .. "Animator"].applyRootMotion = true
					arg_32_1.var_[var_35_18 .. "LipSync"] = var_35_21.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_35_23 = arg_32_1.actors_["1038ui_story"].transform
			local var_35_24 = 0

			if var_35_24 < arg_32_1.time_ and arg_32_1.time_ <= var_35_24 + arg_35_0 then
				arg_32_1.var_.moveOldPos1038ui_story = var_35_23.localPosition
			end

			local var_35_25 = 0.001

			if var_35_24 <= arg_32_1.time_ and arg_32_1.time_ < var_35_24 + var_35_25 then
				local var_35_26 = (arg_32_1.time_ - var_35_24) / var_35_25
				local var_35_27 = Vector3.New(0, -1.11, -5.9)

				var_35_23.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1038ui_story, var_35_27, var_35_26)

				local var_35_28 = manager.ui.mainCamera.transform.position - var_35_23.position

				var_35_23.forward = Vector3.New(var_35_28.x, var_35_28.y, var_35_28.z)

				local var_35_29 = var_35_23.localEulerAngles

				var_35_29.z = 0
				var_35_29.x = 0
				var_35_23.localEulerAngles = var_35_29
			end

			if arg_32_1.time_ >= var_35_24 + var_35_25 and arg_32_1.time_ < var_35_24 + var_35_25 + arg_35_0 then
				var_35_23.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_35_30 = manager.ui.mainCamera.transform.position - var_35_23.position

				var_35_23.forward = Vector3.New(var_35_30.x, var_35_30.y, var_35_30.z)

				local var_35_31 = var_35_23.localEulerAngles

				var_35_31.z = 0
				var_35_31.x = 0
				var_35_23.localEulerAngles = var_35_31
			end

			local var_35_32 = arg_32_1.actors_["1038ui_story"]
			local var_35_33 = 0

			if var_35_33 < arg_32_1.time_ and arg_32_1.time_ <= var_35_33 + arg_35_0 and not isNil(var_35_32) and arg_32_1.var_.characterEffect1038ui_story == nil then
				arg_32_1.var_.characterEffect1038ui_story = var_35_32:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_34 = 0.2

			if var_35_33 <= arg_32_1.time_ and arg_32_1.time_ < var_35_33 + var_35_34 and not isNil(var_35_32) then
				local var_35_35 = (arg_32_1.time_ - var_35_33) / var_35_34

				if arg_32_1.var_.characterEffect1038ui_story and not isNil(var_35_32) then
					arg_32_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_33 + var_35_34 and arg_32_1.time_ < var_35_33 + var_35_34 + arg_35_0 and not isNil(var_35_32) and arg_32_1.var_.characterEffect1038ui_story then
				arg_32_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_35_36 = 0

			if var_35_36 < arg_32_1.time_ and arg_32_1.time_ <= var_35_36 + arg_35_0 then
				arg_32_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action3_1")
			end

			local var_35_37 = 0

			if var_35_37 < arg_32_1.time_ and arg_32_1.time_ <= var_35_37 + arg_35_0 then
				arg_32_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_35_38 = 0
			local var_35_39 = 1.125

			if var_35_38 < arg_32_1.time_ and arg_32_1.time_ <= var_35_38 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_40 = arg_32_1:FormatText(StoryNameCfg[94].name)

				arg_32_1.leftNameTxt_.text = var_35_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_41 = arg_32_1:GetWordFromCfg(109021008)
				local var_35_42 = arg_32_1:FormatText(var_35_41.content)

				arg_32_1.text_.text = var_35_42

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_43 = 45
				local var_35_44 = utf8.len(var_35_42)
				local var_35_45 = var_35_43 <= 0 and var_35_39 or var_35_39 * (var_35_44 / var_35_43)

				if var_35_45 > 0 and var_35_39 < var_35_45 then
					arg_32_1.talkMaxDuration = var_35_45

					if var_35_45 + var_35_38 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_45 + var_35_38
					end
				end

				arg_32_1.text_.text = var_35_42
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109021", "109021008", "story_v_out_109021.awb") ~= 0 then
					local var_35_46 = manager.audio:GetVoiceLength("story_v_out_109021", "109021008", "story_v_out_109021.awb") / 1000

					if var_35_46 + var_35_38 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_46 + var_35_38
					end

					if var_35_41.prefab_name ~= "" and arg_32_1.actors_[var_35_41.prefab_name] ~= nil then
						local var_35_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_41.prefab_name].transform, "story_v_out_109021", "109021008", "story_v_out_109021.awb")

						arg_32_1:RecordAudio("109021008", var_35_47)
						arg_32_1:RecordAudio("109021008", var_35_47)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_109021", "109021008", "story_v_out_109021.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_109021", "109021008", "story_v_out_109021.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_48 = math.max(var_35_39, arg_32_1.talkMaxDuration)

			if var_35_38 <= arg_32_1.time_ and arg_32_1.time_ < var_35_38 + var_35_48 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_38) / var_35_48

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_38 + var_35_48 and arg_32_1.time_ < var_35_38 + var_35_48 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
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
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play109021009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 109021009
		arg_36_1.duration_ = 9.03

		local var_36_0 = {
			ja = 6.866,
			ko = 8.933,
			zh = 9.033,
			en = 6.2
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
				arg_36_0:Play109021010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_39_1 = 0
			local var_39_2 = 1.075

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_3 = arg_36_1:FormatText(StoryNameCfg[94].name)

				arg_36_1.leftNameTxt_.text = var_39_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_4 = arg_36_1:GetWordFromCfg(109021009)
				local var_39_5 = arg_36_1:FormatText(var_39_4.content)

				arg_36_1.text_.text = var_39_5

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_6 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_109021", "109021009", "story_v_out_109021.awb") ~= 0 then
					local var_39_9 = manager.audio:GetVoiceLength("story_v_out_109021", "109021009", "story_v_out_109021.awb") / 1000

					if var_39_9 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_1
					end

					if var_39_4.prefab_name ~= "" and arg_36_1.actors_[var_39_4.prefab_name] ~= nil then
						local var_39_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_4.prefab_name].transform, "story_v_out_109021", "109021009", "story_v_out_109021.awb")

						arg_36_1:RecordAudio("109021009", var_39_10)
						arg_36_1:RecordAudio("109021009", var_39_10)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_109021", "109021009", "story_v_out_109021.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_109021", "109021009", "story_v_out_109021.awb")
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
	Play109021010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 109021010
		arg_40_1.duration_ = 14.6

		local var_40_0 = {
			ja = 12.4,
			ko = 12.3,
			zh = 11.2,
			en = 14.6
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
				arg_40_0:Play109021011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1038ui_story"].transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.moveOldPos1038ui_story = var_43_0.localPosition
			end

			local var_43_2 = 0.001

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2
				local var_43_4 = Vector3.New(0, 100, 0)

				var_43_0.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1038ui_story, var_43_4, var_43_3)

				local var_43_5 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_5.x, var_43_5.y, var_43_5.z)

				local var_43_6 = var_43_0.localEulerAngles

				var_43_6.z = 0
				var_43_6.x = 0
				var_43_0.localEulerAngles = var_43_6
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 then
				var_43_0.localPosition = Vector3.New(0, 100, 0)

				local var_43_7 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_7.x, var_43_7.y, var_43_7.z)

				local var_43_8 = var_43_0.localEulerAngles

				var_43_8.z = 0
				var_43_8.x = 0
				var_43_0.localEulerAngles = var_43_8
			end

			local var_43_9 = 0
			local var_43_10 = 1

			if var_43_9 < arg_40_1.time_ and arg_40_1.time_ <= var_43_9 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_11 = arg_40_1:FormatText(StoryNameCfg[10].name)

				arg_40_1.leftNameTxt_.text = var_43_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_12 = arg_40_1:GetWordFromCfg(109021010)
				local var_43_13 = arg_40_1:FormatText(var_43_12.content)

				arg_40_1.text_.text = var_43_13

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_14 = 58
				local var_43_15 = utf8.len(var_43_13)
				local var_43_16 = var_43_14 <= 0 and var_43_10 or var_43_10 * (var_43_15 / var_43_14)

				if var_43_16 > 0 and var_43_10 < var_43_16 then
					arg_40_1.talkMaxDuration = var_43_16

					if var_43_16 + var_43_9 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_16 + var_43_9
					end
				end

				arg_40_1.text_.text = var_43_13
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109021", "109021010", "story_v_out_109021.awb") ~= 0 then
					local var_43_17 = manager.audio:GetVoiceLength("story_v_out_109021", "109021010", "story_v_out_109021.awb") / 1000

					if var_43_17 + var_43_9 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_17 + var_43_9
					end

					if var_43_12.prefab_name ~= "" and arg_40_1.actors_[var_43_12.prefab_name] ~= nil then
						local var_43_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_12.prefab_name].transform, "story_v_out_109021", "109021010", "story_v_out_109021.awb")

						arg_40_1:RecordAudio("109021010", var_43_18)
						arg_40_1:RecordAudio("109021010", var_43_18)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_109021", "109021010", "story_v_out_109021.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_109021", "109021010", "story_v_out_109021.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_19 = math.max(var_43_10, arg_40_1.talkMaxDuration)

			if var_43_9 <= arg_40_1.time_ and arg_40_1.time_ < var_43_9 + var_43_19 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_9) / var_43_19

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_9 + var_43_19 and arg_40_1.time_ < var_43_9 + var_43_19 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play109021011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 109021011
		arg_44_1.duration_ = 0.1

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"

			SetActive(arg_44_1.choicesGo_, true)

			for iter_45_0, iter_45_1 in ipairs(arg_44_1.choices_) do
				local var_45_0 = iter_45_0 <= 1

				SetActive(iter_45_1.go, var_45_0)
			end

			arg_44_1.choices_[1].txt.text = arg_44_1:FormatText(StoryChoiceCfg[84].name)
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play109021012(arg_44_1)
			end

			arg_44_1:RecordChoiceLog(109021011, 84)
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			return
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play109021012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 109021012
		arg_48_1.duration_ = 8.57

		local var_48_0 = {
			ja = 8.566,
			ko = 8.266,
			zh = 7.933,
			en = 6.166
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
				arg_48_0:Play109021013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.15

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[10].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_3 = arg_48_1:GetWordFromCfg(109021012)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 34
				local var_51_6 = utf8.len(var_51_4)
				local var_51_7 = var_51_5 <= 0 and var_51_1 or var_51_1 * (var_51_6 / var_51_5)

				if var_51_7 > 0 and var_51_1 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109021", "109021012", "story_v_out_109021.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_109021", "109021012", "story_v_out_109021.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_109021", "109021012", "story_v_out_109021.awb")

						arg_48_1:RecordAudio("109021012", var_51_9)
						arg_48_1:RecordAudio("109021012", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_109021", "109021012", "story_v_out_109021.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_109021", "109021012", "story_v_out_109021.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_10 and arg_48_1.time_ < var_51_0 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play109021013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 109021013
		arg_52_1.duration_ = 2.37

		local var_52_0 = {
			ja = 2.233,
			ko = 2.366,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_52_0:Play109021014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1050ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos1050ui_story = var_55_0.localPosition
			end

			local var_55_2 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2
				local var_55_4 = Vector3.New(-0.7, -1, -6.1)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1050ui_story, var_55_4, var_55_3)

				local var_55_5 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_5.x, var_55_5.y, var_55_5.z)

				local var_55_6 = var_55_0.localEulerAngles

				var_55_6.z = 0
				var_55_6.x = 0
				var_55_0.localEulerAngles = var_55_6
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(-0.7, -1, -6.1)

				local var_55_7 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_7.x, var_55_7.y, var_55_7.z)

				local var_55_8 = var_55_0.localEulerAngles

				var_55_8.z = 0
				var_55_8.x = 0
				var_55_0.localEulerAngles = var_55_8
			end

			local var_55_9 = arg_52_1.actors_["1050ui_story"]
			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1050ui_story == nil then
				arg_52_1.var_.characterEffect1050ui_story = var_55_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_11 = 0.2

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_11 and not isNil(var_55_9) then
				local var_55_12 = (arg_52_1.time_ - var_55_10) / var_55_11

				if arg_52_1.var_.characterEffect1050ui_story and not isNil(var_55_9) then
					arg_52_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_10 + var_55_11 and arg_52_1.time_ < var_55_10 + var_55_11 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1050ui_story then
				arg_52_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_55_13 = 0

			if var_55_13 < arg_52_1.time_ and arg_52_1.time_ <= var_55_13 + arg_55_0 then
				arg_52_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action5_1")
			end

			local var_55_14 = 0

			if var_55_14 < arg_52_1.time_ and arg_52_1.time_ <= var_55_14 + arg_55_0 then
				arg_52_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_55_15 = 0
			local var_55_16 = 0.1

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_17 = arg_52_1:FormatText(StoryNameCfg[74].name)

				arg_52_1.leftNameTxt_.text = var_55_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_18 = arg_52_1:GetWordFromCfg(109021013)
				local var_55_19 = arg_52_1:FormatText(var_55_18.content)

				arg_52_1.text_.text = var_55_19

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_20 = 6
				local var_55_21 = utf8.len(var_55_19)
				local var_55_22 = var_55_20 <= 0 and var_55_16 or var_55_16 * (var_55_21 / var_55_20)

				if var_55_22 > 0 and var_55_16 < var_55_22 then
					arg_52_1.talkMaxDuration = var_55_22

					if var_55_22 + var_55_15 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_22 + var_55_15
					end
				end

				arg_52_1.text_.text = var_55_19
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109021", "109021013", "story_v_out_109021.awb") ~= 0 then
					local var_55_23 = manager.audio:GetVoiceLength("story_v_out_109021", "109021013", "story_v_out_109021.awb") / 1000

					if var_55_23 + var_55_15 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_23 + var_55_15
					end

					if var_55_18.prefab_name ~= "" and arg_52_1.actors_[var_55_18.prefab_name] ~= nil then
						local var_55_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_18.prefab_name].transform, "story_v_out_109021", "109021013", "story_v_out_109021.awb")

						arg_52_1:RecordAudio("109021013", var_55_24)
						arg_52_1:RecordAudio("109021013", var_55_24)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_109021", "109021013", "story_v_out_109021.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_109021", "109021013", "story_v_out_109021.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_25 = math.max(var_55_16, arg_52_1.talkMaxDuration)

			if var_55_15 <= arg_52_1.time_ and arg_52_1.time_ < var_55_15 + var_55_25 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_15) / var_55_25

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_15 + var_55_25 and arg_52_1.time_ < var_55_15 + var_55_25 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play109021014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 109021014
		arg_56_1.duration_ = 2.03

		local var_56_0 = {
			ja = 1.499999999999,
			ko = 1.499999999999,
			zh = 2.033,
			en = 1.499999999999
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play109021015(arg_56_1)
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
					local var_59_4 = Mathf.Lerp(0, 0.5, var_59_3)

					arg_56_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1050ui_story.fillRatio = var_59_4
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1050ui_story then
				local var_59_5 = 0.5

				arg_56_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1050ui_story.fillRatio = var_59_5
			end

			local var_59_6 = arg_56_1.actors_["1099ui_story"]
			local var_59_7 = 0

			if var_59_7 < arg_56_1.time_ and arg_56_1.time_ <= var_59_7 + arg_59_0 and not isNil(var_59_6) and arg_56_1.var_.characterEffect1099ui_story == nil then
				arg_56_1.var_.characterEffect1099ui_story = var_59_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_8 = 0.2

			if var_59_7 <= arg_56_1.time_ and arg_56_1.time_ < var_59_7 + var_59_8 and not isNil(var_59_6) then
				local var_59_9 = (arg_56_1.time_ - var_59_7) / var_59_8

				if arg_56_1.var_.characterEffect1099ui_story and not isNil(var_59_6) then
					arg_56_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_7 + var_59_8 and arg_56_1.time_ < var_59_7 + var_59_8 + arg_59_0 and not isNil(var_59_6) and arg_56_1.var_.characterEffect1099ui_story then
				arg_56_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_1")
			end

			local var_59_11 = arg_56_1.actors_["1099ui_story"].transform
			local var_59_12 = 0

			if var_59_12 < arg_56_1.time_ and arg_56_1.time_ <= var_59_12 + arg_59_0 then
				arg_56_1.var_.moveOldPos1099ui_story = var_59_11.localPosition
			end

			local var_59_13 = 0.001

			if var_59_12 <= arg_56_1.time_ and arg_56_1.time_ < var_59_12 + var_59_13 then
				local var_59_14 = (arg_56_1.time_ - var_59_12) / var_59_13
				local var_59_15 = Vector3.New(0.7, -1.08, -5.9)

				var_59_11.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1099ui_story, var_59_15, var_59_14)

				local var_59_16 = manager.ui.mainCamera.transform.position - var_59_11.position

				var_59_11.forward = Vector3.New(var_59_16.x, var_59_16.y, var_59_16.z)

				local var_59_17 = var_59_11.localEulerAngles

				var_59_17.z = 0
				var_59_17.x = 0
				var_59_11.localEulerAngles = var_59_17
			end

			if arg_56_1.time_ >= var_59_12 + var_59_13 and arg_56_1.time_ < var_59_12 + var_59_13 + arg_59_0 then
				var_59_11.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_59_18 = manager.ui.mainCamera.transform.position - var_59_11.position

				var_59_11.forward = Vector3.New(var_59_18.x, var_59_18.y, var_59_18.z)

				local var_59_19 = var_59_11.localEulerAngles

				var_59_19.z = 0
				var_59_19.x = 0
				var_59_11.localEulerAngles = var_59_19
			end

			local var_59_20 = 0

			if var_59_20 < arg_56_1.time_ and arg_56_1.time_ <= var_59_20 + arg_59_0 then
				arg_56_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_59_21 = 0
			local var_59_22 = 0.1

			if var_59_21 < arg_56_1.time_ and arg_56_1.time_ <= var_59_21 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_23 = arg_56_1:FormatText(StoryNameCfg[84].name)

				arg_56_1.leftNameTxt_.text = var_59_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_24 = arg_56_1:GetWordFromCfg(109021014)
				local var_59_25 = arg_56_1:FormatText(var_59_24.content)

				arg_56_1.text_.text = var_59_25

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_26 = 4
				local var_59_27 = utf8.len(var_59_25)
				local var_59_28 = var_59_26 <= 0 and var_59_22 or var_59_22 * (var_59_27 / var_59_26)

				if var_59_28 > 0 and var_59_22 < var_59_28 then
					arg_56_1.talkMaxDuration = var_59_28

					if var_59_28 + var_59_21 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_28 + var_59_21
					end
				end

				arg_56_1.text_.text = var_59_25
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109021", "109021014", "story_v_out_109021.awb") ~= 0 then
					local var_59_29 = manager.audio:GetVoiceLength("story_v_out_109021", "109021014", "story_v_out_109021.awb") / 1000

					if var_59_29 + var_59_21 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_29 + var_59_21
					end

					if var_59_24.prefab_name ~= "" and arg_56_1.actors_[var_59_24.prefab_name] ~= nil then
						local var_59_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_24.prefab_name].transform, "story_v_out_109021", "109021014", "story_v_out_109021.awb")

						arg_56_1:RecordAudio("109021014", var_59_30)
						arg_56_1:RecordAudio("109021014", var_59_30)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_109021", "109021014", "story_v_out_109021.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_109021", "109021014", "story_v_out_109021.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_31 = math.max(var_59_22, arg_56_1.talkMaxDuration)

			if var_59_21 <= arg_56_1.time_ and arg_56_1.time_ < var_59_21 + var_59_31 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_21) / var_59_31

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_21 + var_59_31 and arg_56_1.time_ < var_59_21 + var_59_31 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
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

		arg_56_1:InitPlayNodeList()
	end,
	Play109021015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 109021015
		arg_60_1.duration_ = 7.23

		local var_60_0 = {
			ja = 6.366,
			ko = 4.5,
			zh = 7.233,
			en = 6.6
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
				arg_60_0:Play109021016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1050ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1050ui_story == nil then
				arg_60_1.var_.characterEffect1050ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.2

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1050ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1050ui_story then
				arg_60_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_63_4 = arg_60_1.actors_["1099ui_story"]
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1099ui_story == nil then
				arg_60_1.var_.characterEffect1099ui_story = var_63_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.2

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 and not isNil(var_63_4) then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6

				if arg_60_1.var_.characterEffect1099ui_story and not isNil(var_63_4) then
					local var_63_8 = Mathf.Lerp(0, 0.5, var_63_7)

					arg_60_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1099ui_story.fillRatio = var_63_8
				end
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1099ui_story then
				local var_63_9 = 0.5

				arg_60_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1099ui_story.fillRatio = var_63_9
			end

			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_63_11 = 0
			local var_63_12 = 0.625

			if var_63_11 < arg_60_1.time_ and arg_60_1.time_ <= var_63_11 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_13 = arg_60_1:FormatText(StoryNameCfg[74].name)

				arg_60_1.leftNameTxt_.text = var_63_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_14 = arg_60_1:GetWordFromCfg(109021015)
				local var_63_15 = arg_60_1:FormatText(var_63_14.content)

				arg_60_1.text_.text = var_63_15

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_16 = 27
				local var_63_17 = utf8.len(var_63_15)
				local var_63_18 = var_63_16 <= 0 and var_63_12 or var_63_12 * (var_63_17 / var_63_16)

				if var_63_18 > 0 and var_63_12 < var_63_18 then
					arg_60_1.talkMaxDuration = var_63_18

					if var_63_18 + var_63_11 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_18 + var_63_11
					end
				end

				arg_60_1.text_.text = var_63_15
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109021", "109021015", "story_v_out_109021.awb") ~= 0 then
					local var_63_19 = manager.audio:GetVoiceLength("story_v_out_109021", "109021015", "story_v_out_109021.awb") / 1000

					if var_63_19 + var_63_11 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_19 + var_63_11
					end

					if var_63_14.prefab_name ~= "" and arg_60_1.actors_[var_63_14.prefab_name] ~= nil then
						local var_63_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_14.prefab_name].transform, "story_v_out_109021", "109021015", "story_v_out_109021.awb")

						arg_60_1:RecordAudio("109021015", var_63_20)
						arg_60_1:RecordAudio("109021015", var_63_20)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_109021", "109021015", "story_v_out_109021.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_109021", "109021015", "story_v_out_109021.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_21 = math.max(var_63_12, arg_60_1.talkMaxDuration)

			if var_63_11 <= arg_60_1.time_ and arg_60_1.time_ < var_63_11 + var_63_21 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_11) / var_63_21

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_11 + var_63_21 and arg_60_1.time_ < var_63_11 + var_63_21 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play109021016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 109021016
		arg_64_1.duration_ = 12.83

		local var_64_0 = {
			ja = 12.833,
			ko = 5.633,
			zh = 5.5,
			en = 5.966
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play109021017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1050ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1050ui_story == nil then
				arg_64_1.var_.characterEffect1050ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.2

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1050ui_story and not isNil(var_67_0) then
					local var_67_4 = Mathf.Lerp(0, 0.5, var_67_3)

					arg_64_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1050ui_story.fillRatio = var_67_4
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1050ui_story then
				local var_67_5 = 0.5

				arg_64_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1050ui_story.fillRatio = var_67_5
			end

			local var_67_6 = arg_64_1.actors_["1099ui_story"]
			local var_67_7 = 0

			if var_67_7 < arg_64_1.time_ and arg_64_1.time_ <= var_67_7 + arg_67_0 and not isNil(var_67_6) and arg_64_1.var_.characterEffect1099ui_story == nil then
				arg_64_1.var_.characterEffect1099ui_story = var_67_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_8 = 0.2

			if var_67_7 <= arg_64_1.time_ and arg_64_1.time_ < var_67_7 + var_67_8 and not isNil(var_67_6) then
				local var_67_9 = (arg_64_1.time_ - var_67_7) / var_67_8

				if arg_64_1.var_.characterEffect1099ui_story and not isNil(var_67_6) then
					arg_64_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_7 + var_67_8 and arg_64_1.time_ < var_67_7 + var_67_8 + arg_67_0 and not isNil(var_67_6) and arg_64_1.var_.characterEffect1099ui_story then
				arg_64_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_67_11 = 0
			local var_67_12 = 0.05

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_13 = arg_64_1:FormatText(StoryNameCfg[84].name)

				arg_64_1.leftNameTxt_.text = var_67_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_14 = arg_64_1:GetWordFromCfg(109021016)
				local var_67_15 = arg_64_1:FormatText(var_67_14.content)

				arg_64_1.text_.text = var_67_15

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_16 = 24
				local var_67_17 = utf8.len(var_67_15)
				local var_67_18 = var_67_16 <= 0 and var_67_12 or var_67_12 * (var_67_17 / var_67_16)

				if var_67_18 > 0 and var_67_12 < var_67_18 then
					arg_64_1.talkMaxDuration = var_67_18

					if var_67_18 + var_67_11 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_18 + var_67_11
					end
				end

				arg_64_1.text_.text = var_67_15
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109021", "109021016", "story_v_out_109021.awb") ~= 0 then
					local var_67_19 = manager.audio:GetVoiceLength("story_v_out_109021", "109021016", "story_v_out_109021.awb") / 1000

					if var_67_19 + var_67_11 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_19 + var_67_11
					end

					if var_67_14.prefab_name ~= "" and arg_64_1.actors_[var_67_14.prefab_name] ~= nil then
						local var_67_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_14.prefab_name].transform, "story_v_out_109021", "109021016", "story_v_out_109021.awb")

						arg_64_1:RecordAudio("109021016", var_67_20)
						arg_64_1:RecordAudio("109021016", var_67_20)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_109021", "109021016", "story_v_out_109021.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_109021", "109021016", "story_v_out_109021.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_21 = math.max(var_67_12, arg_64_1.talkMaxDuration)

			if var_67_11 <= arg_64_1.time_ and arg_64_1.time_ < var_67_11 + var_67_21 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_11) / var_67_21

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_11 + var_67_21 and arg_64_1.time_ < var_67_11 + var_67_21 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play109021017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 109021017
		arg_68_1.duration_ = 2.43

		local var_68_0 = {
			ja = 0.9,
			ko = 1.1,
			zh = 2.433,
			en = 2.433
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
			arg_68_1.auto_ = false
		end

		function arg_68_1.playNext_(arg_70_0)
			arg_68_1.onStoryFinished_()
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1099ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1099ui_story == nil then
				arg_68_1.var_.characterEffect1099ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.2

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect1099ui_story and not isNil(var_71_0) then
					local var_71_4 = Mathf.Lerp(0, 0.5, var_71_3)

					arg_68_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1099ui_story.fillRatio = var_71_4
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1099ui_story then
				local var_71_5 = 0.5

				arg_68_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1099ui_story.fillRatio = var_71_5
			end

			local var_71_6 = arg_68_1.actors_["1050ui_story"]
			local var_71_7 = 0

			if var_71_7 < arg_68_1.time_ and arg_68_1.time_ <= var_71_7 + arg_71_0 and not isNil(var_71_6) and arg_68_1.var_.characterEffect1050ui_story == nil then
				arg_68_1.var_.characterEffect1050ui_story = var_71_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_8 = 0.2

			if var_71_7 <= arg_68_1.time_ and arg_68_1.time_ < var_71_7 + var_71_8 and not isNil(var_71_6) then
				local var_71_9 = (arg_68_1.time_ - var_71_7) / var_71_8

				if arg_68_1.var_.characterEffect1050ui_story and not isNil(var_71_6) then
					arg_68_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_7 + var_71_8 and arg_68_1.time_ < var_71_7 + var_71_8 + arg_71_0 and not isNil(var_71_6) and arg_68_1.var_.characterEffect1050ui_story then
				arg_68_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 then
				arg_68_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_71_11 = 0
			local var_71_12 = 0.05

			if var_71_11 < arg_68_1.time_ and arg_68_1.time_ <= var_71_11 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_13 = arg_68_1:FormatText(StoryNameCfg[74].name)

				arg_68_1.leftNameTxt_.text = var_71_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_14 = arg_68_1:GetWordFromCfg(109021017)
				local var_71_15 = arg_68_1:FormatText(var_71_14.content)

				arg_68_1.text_.text = var_71_15

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_16 = 2
				local var_71_17 = utf8.len(var_71_15)
				local var_71_18 = var_71_16 <= 0 and var_71_12 or var_71_12 * (var_71_17 / var_71_16)

				if var_71_18 > 0 and var_71_12 < var_71_18 then
					arg_68_1.talkMaxDuration = var_71_18

					if var_71_18 + var_71_11 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_18 + var_71_11
					end
				end

				arg_68_1.text_.text = var_71_15
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109021", "109021017", "story_v_out_109021.awb") ~= 0 then
					local var_71_19 = manager.audio:GetVoiceLength("story_v_out_109021", "109021017", "story_v_out_109021.awb") / 1000

					if var_71_19 + var_71_11 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_19 + var_71_11
					end

					if var_71_14.prefab_name ~= "" and arg_68_1.actors_[var_71_14.prefab_name] ~= nil then
						local var_71_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_14.prefab_name].transform, "story_v_out_109021", "109021017", "story_v_out_109021.awb")

						arg_68_1:RecordAudio("109021017", var_71_20)
						arg_68_1:RecordAudio("109021017", var_71_20)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_109021", "109021017", "story_v_out_109021.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_109021", "109021017", "story_v_out_109021.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_21 = math.max(var_71_12, arg_68_1.talkMaxDuration)

			if var_71_11 <= arg_68_1.time_ and arg_68_1.time_ < var_71_11 + var_71_21 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_11) / var_71_21

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_11 + var_71_21 and arg_68_1.time_ < var_71_11 + var_71_21 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C02b"
	},
	voices = {
		"story_v_out_109021.awb"
	}
}
