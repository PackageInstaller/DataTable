return {
	Play104041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104041001
		arg_1_1.duration_ = 5.07

		local var_1_0 = {
			ja = 4.6,
			ko = 4.566,
			zh = 5.066,
			en = 3.8
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
				arg_1_0:Play104041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_4_5 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_5 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_5

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_5
						arg_1_1.bgmTxt2_.text = var_4_5
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

			local var_4_6 = 0
			local var_4_7 = 1

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				local var_4_8 = "play"
				local var_4_9 = "effect"

				arg_1_1:AudioAction(var_4_8, var_4_9, "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_10 = "1084ui_story"

			if arg_1_1.actors_[var_4_10] == nil then
				local var_4_11 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_4_11) then
					local var_4_12 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

					var_4_12.name = var_4_10
					var_4_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_10] = var_4_12

					local var_4_13 = var_4_12:GetComponentInChildren(typeof(CharacterEffect))

					var_4_13.enabled = true

					local var_4_14 = GameObjectTools.GetOrAddComponent(var_4_12, typeof(DynamicBoneHelper))

					if var_4_14 then
						var_4_14:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_13.transform, false)

					arg_1_1.var_[var_4_10 .. "Animator"] = var_4_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_10 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_10 .. "LipSync"] = var_4_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_15 = arg_1_1.actors_["1084ui_story"]
			local var_4_16 = 1.5

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_17 = 0.1

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 and not isNil(var_4_15) then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17

				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_4_19 = "B04b"

			if arg_1_1.bgs_[var_4_19] == nil then
				local var_4_20 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_19)
				var_4_20.name = var_4_19
				var_4_20.transform.parent = arg_1_1.stage_.transform
				var_4_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_19] = var_4_20
			end

			local var_4_21 = arg_1_1.bgs_.B04b
			local var_4_22 = 0

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_23 = var_4_21:GetComponent("SpriteRenderer")

				if var_4_23 then
					arg_1_1.var_.alphaOldValueB04b = var_4_23.color.a
					arg_1_1.var_.alphaMatValueB04b = var_4_23
				end

				arg_1_1.var_.alphaOldValueB04b = 0
			end

			local var_4_24 = 1.5

			if var_4_22 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_24 then
				local var_4_25 = (arg_1_1.time_ - var_4_22) / var_4_24
				local var_4_26 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB04b, 1, var_4_25)

				if arg_1_1.var_.alphaMatValueB04b then
					local var_4_27 = arg_1_1.var_.alphaMatValueB04b.color

					var_4_27.a = var_4_26
					arg_1_1.var_.alphaMatValueB04b.color = var_4_27
				end
			end

			if arg_1_1.time_ >= var_4_22 + var_4_24 and arg_1_1.time_ < var_4_22 + var_4_24 + arg_4_0 and arg_1_1.var_.alphaMatValueB04b then
				local var_4_28 = arg_1_1.var_.alphaMatValueB04b
				local var_4_29 = var_4_28.color

				var_4_29.a = 1
				var_4_28.color = var_4_29
			end

			local var_4_30 = 0

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_31 = manager.ui.mainCamera.transform.localPosition
				local var_4_32 = Vector3.New(0, 0, 10) + Vector3.New(var_4_31.x, var_4_31.y, 0)
				local var_4_33 = arg_1_1.bgs_.B04b

				var_4_33.transform.localPosition = var_4_32
				var_4_33.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_34 = var_4_33:GetComponent("SpriteRenderer")

				if var_4_34 and var_4_34.sprite then
					local var_4_35 = (var_4_33.transform.localPosition - var_4_31).z
					local var_4_36 = manager.ui.mainCameraCom_
					local var_4_37 = 2 * var_4_35 * Mathf.Tan(var_4_36.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_38 = var_4_37 * var_4_36.aspect
					local var_4_39 = var_4_34.sprite.bounds.size.x
					local var_4_40 = var_4_34.sprite.bounds.size.y
					local var_4_41 = var_4_38 / var_4_39
					local var_4_42 = var_4_37 / var_4_40
					local var_4_43 = var_4_42 < var_4_41 and var_4_41 or var_4_42

					var_4_33.transform.localScale = Vector3.New(var_4_43, var_4_43, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B04b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_44 = arg_1_1.actors_["1084ui_story"].transform
			local var_4_45 = 1.5

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_44.localPosition
			end

			local var_4_46 = 0.001

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_45) / var_4_46
				local var_4_48 = Vector3.New(-0.7, -0.97, -6)

				var_4_44.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, var_4_48, var_4_47)

				local var_4_49 = manager.ui.mainCamera.transform.position - var_4_44.position

				var_4_44.forward = Vector3.New(var_4_49.x, var_4_49.y, var_4_49.z)

				local var_4_50 = var_4_44.localEulerAngles

				var_4_50.z = 0
				var_4_50.x = 0
				var_4_44.localEulerAngles = var_4_50
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				var_4_44.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_4_51 = manager.ui.mainCamera.transform.position - var_4_44.position

				var_4_44.forward = Vector3.New(var_4_51.x, var_4_51.y, var_4_51.z)

				local var_4_52 = var_4_44.localEulerAngles

				var_4_52.z = 0
				var_4_52.x = 0
				var_4_44.localEulerAngles = var_4_52
			end

			local var_4_53 = 1.5

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_4_54 = 0

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_55 = 1.5

			if arg_1_1.time_ >= var_4_54 + var_4_55 and arg_1_1.time_ < var_4_54 + var_4_55 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_56 = 0

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_57 = 1.5
			local var_4_58 = 0.375

			if var_4_57 < arg_1_1.time_ and arg_1_1.time_ <= var_4_57 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_59 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_59:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_60 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_61 = arg_1_1:GetWordFromCfg(104041001)
				local var_4_62 = arg_1_1:FormatText(var_4_61.content)

				arg_1_1.text_.text = var_4_62

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_63 = 14
				local var_4_64 = utf8.len(var_4_62)
				local var_4_65 = var_4_63 <= 0 and var_4_58 or var_4_58 * (var_4_64 / var_4_63)

				if var_4_65 > 0 and var_4_58 < var_4_65 then
					arg_1_1.talkMaxDuration = var_4_65
					var_4_57 = var_4_57 + 0.3

					if var_4_65 + var_4_57 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_57
					end
				end

				arg_1_1.text_.text = var_4_62
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104041", "104041001", "story_v_out_104041.awb") ~= 0 then
					local var_4_66 = manager.audio:GetVoiceLength("story_v_out_104041", "104041001", "story_v_out_104041.awb") / 1000

					if var_4_66 + var_4_57 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_66 + var_4_57
					end

					if var_4_61.prefab_name ~= "" and arg_1_1.actors_[var_4_61.prefab_name] ~= nil then
						local var_4_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_61.prefab_name].transform, "story_v_out_104041", "104041001", "story_v_out_104041.awb")

						arg_1_1:RecordAudio("104041001", var_4_67)
						arg_1_1:RecordAudio("104041001", var_4_67)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_104041", "104041001", "story_v_out_104041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_104041", "104041001", "story_v_out_104041.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_68 = var_4_57 + 0.3
			local var_4_69 = math.max(var_4_58, arg_1_1.talkMaxDuration)

			if var_4_68 <= arg_1_1.time_ and arg_1_1.time_ < var_4_68 + var_4_69 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_68) / var_4_69

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_68 + var_4_69 and arg_1_1.time_ < var_4_68 + var_4_69 + arg_4_0 then
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
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play104041002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 104041002
		arg_8_1.duration_ = 14.63

		local var_8_0 = {
			ja = 13.4,
			ko = 14.633,
			zh = 10.933,
			en = 13.5
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
				arg_8_0:Play104041003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1036ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1036ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1036ui_story"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1036ui_story == nil then
				arg_8_1.var_.characterEffect1036ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect1036ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1036ui_story then
				arg_8_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_11_9 = arg_8_1.actors_["1084ui_story"]
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_11 = 0.1

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

			local var_11_15 = arg_8_1.actors_["1036ui_story"].transform
			local var_11_16 = 0

			if var_11_16 < arg_8_1.time_ and arg_8_1.time_ <= var_11_16 + arg_11_0 then
				arg_8_1.var_.moveOldPos1036ui_story = var_11_15.localPosition
			end

			local var_11_17 = 0.001

			if var_11_16 <= arg_8_1.time_ and arg_8_1.time_ < var_11_16 + var_11_17 then
				local var_11_18 = (arg_8_1.time_ - var_11_16) / var_11_17
				local var_11_19 = Vector3.New(0.7, -1.09, -5.78)

				var_11_15.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1036ui_story, var_11_19, var_11_18)

				local var_11_20 = manager.ui.mainCamera.transform.position - var_11_15.position

				var_11_15.forward = Vector3.New(var_11_20.x, var_11_20.y, var_11_20.z)

				local var_11_21 = var_11_15.localEulerAngles

				var_11_21.z = 0
				var_11_21.x = 0
				var_11_15.localEulerAngles = var_11_21
			end

			if arg_8_1.time_ >= var_11_16 + var_11_17 and arg_8_1.time_ < var_11_16 + var_11_17 + arg_11_0 then
				var_11_15.localPosition = Vector3.New(0.7, -1.09, -5.78)

				local var_11_22 = manager.ui.mainCamera.transform.position - var_11_15.position

				var_11_15.forward = Vector3.New(var_11_22.x, var_11_22.y, var_11_22.z)

				local var_11_23 = var_11_15.localEulerAngles

				var_11_23.z = 0
				var_11_23.x = 0
				var_11_15.localEulerAngles = var_11_23
			end

			local var_11_24 = 0

			if var_11_24 < arg_8_1.time_ and arg_8_1.time_ <= var_11_24 + arg_11_0 then
				arg_8_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action2_1")
			end

			local var_11_25 = 0

			if var_11_25 < arg_8_1.time_ and arg_8_1.time_ <= var_11_25 + arg_11_0 then
				arg_8_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_11_26 = 0
			local var_11_27 = 1.45

			if var_11_26 < arg_8_1.time_ and arg_8_1.time_ <= var_11_26 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_28 = arg_8_1:FormatText(StoryNameCfg[5].name)

				arg_8_1.leftNameTxt_.text = var_11_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_29 = arg_8_1:GetWordFromCfg(104041002)
				local var_11_30 = arg_8_1:FormatText(var_11_29.content)

				arg_8_1.text_.text = var_11_30

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_31 = 57
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

				if manager.audio:GetVoiceLength("story_v_out_104041", "104041002", "story_v_out_104041.awb") ~= 0 then
					local var_11_34 = manager.audio:GetVoiceLength("story_v_out_104041", "104041002", "story_v_out_104041.awb") / 1000

					if var_11_34 + var_11_26 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_34 + var_11_26
					end

					if var_11_29.prefab_name ~= "" and arg_8_1.actors_[var_11_29.prefab_name] ~= nil then
						local var_11_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_29.prefab_name].transform, "story_v_out_104041", "104041002", "story_v_out_104041.awb")

						arg_8_1:RecordAudio("104041002", var_11_35)
						arg_8_1:RecordAudio("104041002", var_11_35)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_104041", "104041002", "story_v_out_104041.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_104041", "104041002", "story_v_out_104041.awb")
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
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play104041003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 104041003
		arg_12_1.duration_ = 9.43

		local var_12_0 = {
			ja = 9.433,
			ko = 5.2,
			zh = 1.4,
			en = 4.033
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
				arg_12_0:Play104041004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1036ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1036ui_story == nil then
				arg_12_1.var_.characterEffect1036ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.1

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1036ui_story and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1036ui_story.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1036ui_story then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1036ui_story.fillRatio = var_15_5
			end

			local var_15_6 = arg_12_1.actors_["1036ui_story"].transform
			local var_15_7 = 0

			if var_15_7 < arg_12_1.time_ and arg_12_1.time_ <= var_15_7 + arg_15_0 then
				arg_12_1.var_.moveOldPos1036ui_story = var_15_6.localPosition
			end

			local var_15_8 = 0.001

			if var_15_7 <= arg_12_1.time_ and arg_12_1.time_ < var_15_7 + var_15_8 then
				local var_15_9 = (arg_12_1.time_ - var_15_7) / var_15_8
				local var_15_10 = Vector3.New(0, 100, 0)

				var_15_6.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1036ui_story, var_15_10, var_15_9)

				local var_15_11 = manager.ui.mainCamera.transform.position - var_15_6.position

				var_15_6.forward = Vector3.New(var_15_11.x, var_15_11.y, var_15_11.z)

				local var_15_12 = var_15_6.localEulerAngles

				var_15_12.z = 0
				var_15_12.x = 0
				var_15_6.localEulerAngles = var_15_12
			end

			if arg_12_1.time_ >= var_15_7 + var_15_8 and arg_12_1.time_ < var_15_7 + var_15_8 + arg_15_0 then
				var_15_6.localPosition = Vector3.New(0, 100, 0)

				local var_15_13 = manager.ui.mainCamera.transform.position - var_15_6.position

				var_15_6.forward = Vector3.New(var_15_13.x, var_15_13.y, var_15_13.z)

				local var_15_14 = var_15_6.localEulerAngles

				var_15_14.z = 0
				var_15_14.x = 0
				var_15_6.localEulerAngles = var_15_14
			end

			local var_15_15 = arg_12_1.actors_["1084ui_story"].transform
			local var_15_16 = 0

			if var_15_16 < arg_12_1.time_ and arg_12_1.time_ <= var_15_16 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = var_15_15.localPosition
			end

			local var_15_17 = 0.001

			if var_15_16 <= arg_12_1.time_ and arg_12_1.time_ < var_15_16 + var_15_17 then
				local var_15_18 = (arg_12_1.time_ - var_15_16) / var_15_17
				local var_15_19 = Vector3.New(0, 100, 0)

				var_15_15.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, var_15_19, var_15_18)

				local var_15_20 = manager.ui.mainCamera.transform.position - var_15_15.position

				var_15_15.forward = Vector3.New(var_15_20.x, var_15_20.y, var_15_20.z)

				local var_15_21 = var_15_15.localEulerAngles

				var_15_21.z = 0
				var_15_21.x = 0
				var_15_15.localEulerAngles = var_15_21
			end

			if arg_12_1.time_ >= var_15_16 + var_15_17 and arg_12_1.time_ < var_15_16 + var_15_17 + arg_15_0 then
				var_15_15.localPosition = Vector3.New(0, 100, 0)

				local var_15_22 = manager.ui.mainCamera.transform.position - var_15_15.position

				var_15_15.forward = Vector3.New(var_15_22.x, var_15_22.y, var_15_22.z)

				local var_15_23 = var_15_15.localEulerAngles

				var_15_23.z = 0
				var_15_23.x = 0
				var_15_15.localEulerAngles = var_15_23
			end

			local var_15_24 = 0
			local var_15_25 = 0.45

			if var_15_24 < arg_12_1.time_ and arg_12_1.time_ <= var_15_24 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_26 = arg_12_1:FormatText(StoryNameCfg[57].name)

				arg_12_1.leftNameTxt_.text = var_15_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2026")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_27 = arg_12_1:GetWordFromCfg(104041003)
				local var_15_28 = arg_12_1:FormatText(var_15_27.content)

				arg_12_1.text_.text = var_15_28

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_29 = 18
				local var_15_30 = utf8.len(var_15_28)
				local var_15_31 = var_15_29 <= 0 and var_15_25 or var_15_25 * (var_15_30 / var_15_29)

				if var_15_31 > 0 and var_15_25 < var_15_31 then
					arg_12_1.talkMaxDuration = var_15_31

					if var_15_31 + var_15_24 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_31 + var_15_24
					end
				end

				arg_12_1.text_.text = var_15_28
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104041", "104041003", "story_v_out_104041.awb") ~= 0 then
					local var_15_32 = manager.audio:GetVoiceLength("story_v_out_104041", "104041003", "story_v_out_104041.awb") / 1000

					if var_15_32 + var_15_24 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_32 + var_15_24
					end

					if var_15_27.prefab_name ~= "" and arg_12_1.actors_[var_15_27.prefab_name] ~= nil then
						local var_15_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_27.prefab_name].transform, "story_v_out_104041", "104041003", "story_v_out_104041.awb")

						arg_12_1:RecordAudio("104041003", var_15_33)
						arg_12_1:RecordAudio("104041003", var_15_33)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_104041", "104041003", "story_v_out_104041.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_104041", "104041003", "story_v_out_104041.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_34 = math.max(var_15_25, arg_12_1.talkMaxDuration)

			if var_15_24 <= arg_12_1.time_ and arg_12_1.time_ < var_15_24 + var_15_34 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_24) / var_15_34

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_24 + var_15_34 and arg_12_1.time_ < var_15_24 + var_15_34 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play104041004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 104041004
		arg_16_1.duration_ = 2

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play104041005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1011ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_16_1.stage_.transform)

					var_19_2.name = var_19_0
					var_19_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_0] = var_19_2

					local var_19_3 = var_19_2:GetComponentInChildren(typeof(CharacterEffect))

					var_19_3.enabled = true

					local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_2, typeof(DynamicBoneHelper))

					if var_19_4 then
						var_19_4:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_3.transform, false)

					arg_16_1.var_[var_19_0 .. "Animator"] = var_19_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_0 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_0 .. "LipSync"] = var_19_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_5 = arg_16_1.actors_["1011ui_story"]
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1011ui_story == nil then
				arg_16_1.var_.characterEffect1011ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.1

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 and not isNil(var_19_5) then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7

				if arg_16_1.var_.characterEffect1011ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1011ui_story then
				arg_16_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_19_9 = arg_16_1.actors_["1011ui_story"].transform
			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1.var_.moveOldPos1011ui_story = var_19_9.localPosition
			end

			local var_19_11 = 0.001

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_11 then
				local var_19_12 = (arg_16_1.time_ - var_19_10) / var_19_11
				local var_19_13 = Vector3.New(-0.7, -0.71, -6)

				var_19_9.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1011ui_story, var_19_13, var_19_12)

				local var_19_14 = manager.ui.mainCamera.transform.position - var_19_9.position

				var_19_9.forward = Vector3.New(var_19_14.x, var_19_14.y, var_19_14.z)

				local var_19_15 = var_19_9.localEulerAngles

				var_19_15.z = 0
				var_19_15.x = 0
				var_19_9.localEulerAngles = var_19_15
			end

			if arg_16_1.time_ >= var_19_10 + var_19_11 and arg_16_1.time_ < var_19_10 + var_19_11 + arg_19_0 then
				var_19_9.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_19_16 = manager.ui.mainCamera.transform.position - var_19_9.position

				var_19_9.forward = Vector3.New(var_19_16.x, var_19_16.y, var_19_16.z)

				local var_19_17 = var_19_9.localEulerAngles

				var_19_17.z = 0
				var_19_17.x = 0
				var_19_9.localEulerAngles = var_19_17
			end

			local var_19_18 = 0

			if var_19_18 < arg_16_1.time_ and arg_16_1.time_ <= var_19_18 + arg_19_0 then
				arg_16_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			local var_19_19 = 0

			if var_19_19 < arg_16_1.time_ and arg_16_1.time_ <= var_19_19 + arg_19_0 then
				arg_16_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_19_20 = 0
			local var_19_21 = 0.075

			if var_19_20 < arg_16_1.time_ and arg_16_1.time_ <= var_19_20 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_22 = arg_16_1:FormatText(StoryNameCfg[37].name)

				arg_16_1.leftNameTxt_.text = var_19_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_23 = arg_16_1:GetWordFromCfg(104041004)
				local var_19_24 = arg_16_1:FormatText(var_19_23.content)

				arg_16_1.text_.text = var_19_24

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_25 = 3
				local var_19_26 = utf8.len(var_19_24)
				local var_19_27 = var_19_25 <= 0 and var_19_21 or var_19_21 * (var_19_26 / var_19_25)

				if var_19_27 > 0 and var_19_21 < var_19_27 then
					arg_16_1.talkMaxDuration = var_19_27

					if var_19_27 + var_19_20 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_27 + var_19_20
					end
				end

				arg_16_1.text_.text = var_19_24
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104041", "104041004", "story_v_out_104041.awb") ~= 0 then
					local var_19_28 = manager.audio:GetVoiceLength("story_v_out_104041", "104041004", "story_v_out_104041.awb") / 1000

					if var_19_28 + var_19_20 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_28 + var_19_20
					end

					if var_19_23.prefab_name ~= "" and arg_16_1.actors_[var_19_23.prefab_name] ~= nil then
						local var_19_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_23.prefab_name].transform, "story_v_out_104041", "104041004", "story_v_out_104041.awb")

						arg_16_1:RecordAudio("104041004", var_19_29)
						arg_16_1:RecordAudio("104041004", var_19_29)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_104041", "104041004", "story_v_out_104041.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_104041", "104041004", "story_v_out_104041.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_30 = math.max(var_19_21, arg_16_1.talkMaxDuration)

			if var_19_20 <= arg_16_1.time_ and arg_16_1.time_ < var_19_20 + var_19_30 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_20) / var_19_30

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_20 + var_19_30 and arg_16_1.time_ < var_19_20 + var_19_30 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play104041005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 104041005
		arg_20_1.duration_ = 3.57

		local var_20_0 = {
			ja = 3.566,
			ko = 2.066,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_20_0:Play104041006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1084ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1084ui_story == nil then
				arg_20_1.var_.characterEffect1084ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.1

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1084ui_story and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1084ui_story then
				arg_20_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_23_4 = arg_20_1.actors_["1011ui_story"]
			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect1011ui_story == nil then
				arg_20_1.var_.characterEffect1011ui_story = var_23_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_6 = 0.1

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_6 and not isNil(var_23_4) then
				local var_23_7 = (arg_20_1.time_ - var_23_5) / var_23_6

				if arg_20_1.var_.characterEffect1011ui_story and not isNil(var_23_4) then
					local var_23_8 = Mathf.Lerp(0, 0.5, var_23_7)

					arg_20_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1011ui_story.fillRatio = var_23_8
				end
			end

			if arg_20_1.time_ >= var_23_5 + var_23_6 and arg_20_1.time_ < var_23_5 + var_23_6 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect1011ui_story then
				local var_23_9 = 0.5

				arg_20_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1011ui_story.fillRatio = var_23_9
			end

			local var_23_10 = arg_20_1.actors_["1084ui_story"].transform
			local var_23_11 = 0

			if var_23_11 < arg_20_1.time_ and arg_20_1.time_ <= var_23_11 + arg_23_0 then
				arg_20_1.var_.moveOldPos1084ui_story = var_23_10.localPosition
			end

			local var_23_12 = 0.001

			if var_23_11 <= arg_20_1.time_ and arg_20_1.time_ < var_23_11 + var_23_12 then
				local var_23_13 = (arg_20_1.time_ - var_23_11) / var_23_12
				local var_23_14 = Vector3.New(0.7, -0.97, -6)

				var_23_10.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1084ui_story, var_23_14, var_23_13)

				local var_23_15 = manager.ui.mainCamera.transform.position - var_23_10.position

				var_23_10.forward = Vector3.New(var_23_15.x, var_23_15.y, var_23_15.z)

				local var_23_16 = var_23_10.localEulerAngles

				var_23_16.z = 0
				var_23_16.x = 0
				var_23_10.localEulerAngles = var_23_16
			end

			if arg_20_1.time_ >= var_23_11 + var_23_12 and arg_20_1.time_ < var_23_11 + var_23_12 + arg_23_0 then
				var_23_10.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_23_17 = manager.ui.mainCamera.transform.position - var_23_10.position

				var_23_10.forward = Vector3.New(var_23_17.x, var_23_17.y, var_23_17.z)

				local var_23_18 = var_23_10.localEulerAngles

				var_23_18.z = 0
				var_23_18.x = 0
				var_23_10.localEulerAngles = var_23_18
			end

			local var_23_19 = 0

			if var_23_19 < arg_20_1.time_ and arg_20_1.time_ <= var_23_19 + arg_23_0 then
				arg_20_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_23_20 = 0

			if var_23_20 < arg_20_1.time_ and arg_20_1.time_ <= var_23_20 + arg_23_0 then
				arg_20_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_23_21 = 0
			local var_23_22 = 0.175

			if var_23_21 < arg_20_1.time_ and arg_20_1.time_ <= var_23_21 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_23 = arg_20_1:FormatText(StoryNameCfg[6].name)

				arg_20_1.leftNameTxt_.text = var_23_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_24 = arg_20_1:GetWordFromCfg(104041005)
				local var_23_25 = arg_20_1:FormatText(var_23_24.content)

				arg_20_1.text_.text = var_23_25

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_26 = 7
				local var_23_27 = utf8.len(var_23_25)
				local var_23_28 = var_23_26 <= 0 and var_23_22 or var_23_22 * (var_23_27 / var_23_26)

				if var_23_28 > 0 and var_23_22 < var_23_28 then
					arg_20_1.talkMaxDuration = var_23_28

					if var_23_28 + var_23_21 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_28 + var_23_21
					end
				end

				arg_20_1.text_.text = var_23_25
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104041", "104041005", "story_v_out_104041.awb") ~= 0 then
					local var_23_29 = manager.audio:GetVoiceLength("story_v_out_104041", "104041005", "story_v_out_104041.awb") / 1000

					if var_23_29 + var_23_21 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_29 + var_23_21
					end

					if var_23_24.prefab_name ~= "" and arg_20_1.actors_[var_23_24.prefab_name] ~= nil then
						local var_23_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_24.prefab_name].transform, "story_v_out_104041", "104041005", "story_v_out_104041.awb")

						arg_20_1:RecordAudio("104041005", var_23_30)
						arg_20_1:RecordAudio("104041005", var_23_30)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_104041", "104041005", "story_v_out_104041.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_104041", "104041005", "story_v_out_104041.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_31 = math.max(var_23_22, arg_20_1.talkMaxDuration)

			if var_23_21 <= arg_20_1.time_ and arg_20_1.time_ < var_23_21 + var_23_31 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_21) / var_23_31

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_21 + var_23_31 and arg_20_1.time_ < var_23_21 + var_23_31 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play104041006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 104041006
		arg_24_1.duration_ = 17.97

		local var_24_0 = {
			ja = 17.966,
			ko = 7.733,
			zh = 7.833,
			en = 9.4
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
				arg_24_0:Play104041007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "1019ui_story"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_24_1.stage_.transform)

					var_27_2.name = var_27_0
					var_27_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_24_1.actors_[var_27_0] = var_27_2

					local var_27_3 = var_27_2:GetComponentInChildren(typeof(CharacterEffect))

					var_27_3.enabled = true

					local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_2, typeof(DynamicBoneHelper))

					if var_27_4 then
						var_27_4:EnableDynamicBone(false)
					end

					arg_24_1:ShowWeapon(var_27_3.transform, false)

					arg_24_1.var_[var_27_0 .. "Animator"] = var_27_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_24_1.var_[var_27_0 .. "Animator"].applyRootMotion = true
					arg_24_1.var_[var_27_0 .. "LipSync"] = var_27_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_27_5 = arg_24_1.actors_["1019ui_story"]
			local var_27_6 = 0

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect1019ui_story == nil then
				arg_24_1.var_.characterEffect1019ui_story = var_27_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_7 = 0.1

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_7 and not isNil(var_27_5) then
				local var_27_8 = (arg_24_1.time_ - var_27_6) / var_27_7

				if arg_24_1.var_.characterEffect1019ui_story and not isNil(var_27_5) then
					arg_24_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_6 + var_27_7 and arg_24_1.time_ < var_27_6 + var_27_7 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect1019ui_story then
				arg_24_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_27_9 = arg_24_1.actors_["1084ui_story"]
			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect1084ui_story == nil then
				arg_24_1.var_.characterEffect1084ui_story = var_27_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_11 = 0.1

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_11 and not isNil(var_27_9) then
				local var_27_12 = (arg_24_1.time_ - var_27_10) / var_27_11

				if arg_24_1.var_.characterEffect1084ui_story and not isNil(var_27_9) then
					local var_27_13 = Mathf.Lerp(0, 0.5, var_27_12)

					arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1084ui_story.fillRatio = var_27_13
				end
			end

			if arg_24_1.time_ >= var_27_10 + var_27_11 and arg_24_1.time_ < var_27_10 + var_27_11 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect1084ui_story then
				local var_27_14 = 0.5

				arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1084ui_story.fillRatio = var_27_14
			end

			local var_27_15 = arg_24_1.actors_["1084ui_story"].transform
			local var_27_16 = 0

			if var_27_16 < arg_24_1.time_ and arg_24_1.time_ <= var_27_16 + arg_27_0 then
				arg_24_1.var_.moveOldPos1084ui_story = var_27_15.localPosition
			end

			local var_27_17 = 0.001

			if var_27_16 <= arg_24_1.time_ and arg_24_1.time_ < var_27_16 + var_27_17 then
				local var_27_18 = (arg_24_1.time_ - var_27_16) / var_27_17
				local var_27_19 = Vector3.New(0, 100, 0)

				var_27_15.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1084ui_story, var_27_19, var_27_18)

				local var_27_20 = manager.ui.mainCamera.transform.position - var_27_15.position

				var_27_15.forward = Vector3.New(var_27_20.x, var_27_20.y, var_27_20.z)

				local var_27_21 = var_27_15.localEulerAngles

				var_27_21.z = 0
				var_27_21.x = 0
				var_27_15.localEulerAngles = var_27_21
			end

			if arg_24_1.time_ >= var_27_16 + var_27_17 and arg_24_1.time_ < var_27_16 + var_27_17 + arg_27_0 then
				var_27_15.localPosition = Vector3.New(0, 100, 0)

				local var_27_22 = manager.ui.mainCamera.transform.position - var_27_15.position

				var_27_15.forward = Vector3.New(var_27_22.x, var_27_22.y, var_27_22.z)

				local var_27_23 = var_27_15.localEulerAngles

				var_27_23.z = 0
				var_27_23.x = 0
				var_27_15.localEulerAngles = var_27_23
			end

			local var_27_24 = arg_24_1.actors_["1011ui_story"].transform
			local var_27_25 = 0

			if var_27_25 < arg_24_1.time_ and arg_24_1.time_ <= var_27_25 + arg_27_0 then
				arg_24_1.var_.moveOldPos1011ui_story = var_27_24.localPosition
			end

			local var_27_26 = 0.001

			if var_27_25 <= arg_24_1.time_ and arg_24_1.time_ < var_27_25 + var_27_26 then
				local var_27_27 = (arg_24_1.time_ - var_27_25) / var_27_26
				local var_27_28 = Vector3.New(0, 100, 0)

				var_27_24.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1011ui_story, var_27_28, var_27_27)

				local var_27_29 = manager.ui.mainCamera.transform.position - var_27_24.position

				var_27_24.forward = Vector3.New(var_27_29.x, var_27_29.y, var_27_29.z)

				local var_27_30 = var_27_24.localEulerAngles

				var_27_30.z = 0
				var_27_30.x = 0
				var_27_24.localEulerAngles = var_27_30
			end

			if arg_24_1.time_ >= var_27_25 + var_27_26 and arg_24_1.time_ < var_27_25 + var_27_26 + arg_27_0 then
				var_27_24.localPosition = Vector3.New(0, 100, 0)

				local var_27_31 = manager.ui.mainCamera.transform.position - var_27_24.position

				var_27_24.forward = Vector3.New(var_27_31.x, var_27_31.y, var_27_31.z)

				local var_27_32 = var_27_24.localEulerAngles

				var_27_32.z = 0
				var_27_32.x = 0
				var_27_24.localEulerAngles = var_27_32
			end

			local var_27_33 = arg_24_1.actors_["1019ui_story"].transform
			local var_27_34 = 0

			if var_27_34 < arg_24_1.time_ and arg_24_1.time_ <= var_27_34 + arg_27_0 then
				arg_24_1.var_.moveOldPos1019ui_story = var_27_33.localPosition
			end

			local var_27_35 = 0.001

			if var_27_34 <= arg_24_1.time_ and arg_24_1.time_ < var_27_34 + var_27_35 then
				local var_27_36 = (arg_24_1.time_ - var_27_34) / var_27_35
				local var_27_37 = Vector3.New(-0.2, -1.08, -5.9)

				var_27_33.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1019ui_story, var_27_37, var_27_36)

				local var_27_38 = manager.ui.mainCamera.transform.position - var_27_33.position

				var_27_33.forward = Vector3.New(var_27_38.x, var_27_38.y, var_27_38.z)

				local var_27_39 = var_27_33.localEulerAngles

				var_27_39.z = 0
				var_27_39.x = 0
				var_27_33.localEulerAngles = var_27_39
			end

			if arg_24_1.time_ >= var_27_34 + var_27_35 and arg_24_1.time_ < var_27_34 + var_27_35 + arg_27_0 then
				var_27_33.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_27_40 = manager.ui.mainCamera.transform.position - var_27_33.position

				var_27_33.forward = Vector3.New(var_27_40.x, var_27_40.y, var_27_40.z)

				local var_27_41 = var_27_33.localEulerAngles

				var_27_41.z = 0
				var_27_41.x = 0
				var_27_33.localEulerAngles = var_27_41
			end

			local var_27_42 = 0

			if var_27_42 < arg_24_1.time_ and arg_24_1.time_ <= var_27_42 + arg_27_0 then
				arg_24_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_27_43 = 0

			if var_27_43 < arg_24_1.time_ and arg_24_1.time_ <= var_27_43 + arg_27_0 then
				arg_24_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_27_44 = 0
			local var_27_45 = 0.925

			if var_27_44 < arg_24_1.time_ and arg_24_1.time_ <= var_27_44 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_46 = arg_24_1:FormatText(StoryNameCfg[13].name)

				arg_24_1.leftNameTxt_.text = var_27_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_47 = arg_24_1:GetWordFromCfg(104041006)
				local var_27_48 = arg_24_1:FormatText(var_27_47.content)

				arg_24_1.text_.text = var_27_48

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_49 = 37
				local var_27_50 = utf8.len(var_27_48)
				local var_27_51 = var_27_49 <= 0 and var_27_45 or var_27_45 * (var_27_50 / var_27_49)

				if var_27_51 > 0 and var_27_45 < var_27_51 then
					arg_24_1.talkMaxDuration = var_27_51

					if var_27_51 + var_27_44 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_51 + var_27_44
					end
				end

				arg_24_1.text_.text = var_27_48
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104041", "104041006", "story_v_out_104041.awb") ~= 0 then
					local var_27_52 = manager.audio:GetVoiceLength("story_v_out_104041", "104041006", "story_v_out_104041.awb") / 1000

					if var_27_52 + var_27_44 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_52 + var_27_44
					end

					if var_27_47.prefab_name ~= "" and arg_24_1.actors_[var_27_47.prefab_name] ~= nil then
						local var_27_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_47.prefab_name].transform, "story_v_out_104041", "104041006", "story_v_out_104041.awb")

						arg_24_1:RecordAudio("104041006", var_27_53)
						arg_24_1:RecordAudio("104041006", var_27_53)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_104041", "104041006", "story_v_out_104041.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_104041", "104041006", "story_v_out_104041.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_54 = math.max(var_27_45, arg_24_1.talkMaxDuration)

			if var_27_44 <= arg_24_1.time_ and arg_24_1.time_ < var_27_44 + var_27_54 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_44) / var_27_54

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_44 + var_27_54 and arg_24_1.time_ < var_27_44 + var_27_54 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_24_1:InitPlayNodeList()
	end,
	Play104041007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 104041007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play104041008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1019ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1019ui_story and not isNil(var_31_0) then
					local var_31_4 = Mathf.Lerp(0, 0.5, var_31_3)

					arg_28_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1019ui_story.fillRatio = var_31_4
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1019ui_story then
				local var_31_5 = 0.5

				arg_28_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1019ui_story.fillRatio = var_31_5
			end

			local var_31_6 = arg_28_1.actors_["1019ui_story"].transform
			local var_31_7 = 0

			if var_31_7 < arg_28_1.time_ and arg_28_1.time_ <= var_31_7 + arg_31_0 then
				arg_28_1.var_.moveOldPos1019ui_story = var_31_6.localPosition
			end

			local var_31_8 = 0.001

			if var_31_7 <= arg_28_1.time_ and arg_28_1.time_ < var_31_7 + var_31_8 then
				local var_31_9 = (arg_28_1.time_ - var_31_7) / var_31_8
				local var_31_10 = Vector3.New(0, 100, 0)

				var_31_6.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1019ui_story, var_31_10, var_31_9)

				local var_31_11 = manager.ui.mainCamera.transform.position - var_31_6.position

				var_31_6.forward = Vector3.New(var_31_11.x, var_31_11.y, var_31_11.z)

				local var_31_12 = var_31_6.localEulerAngles

				var_31_12.z = 0
				var_31_12.x = 0
				var_31_6.localEulerAngles = var_31_12
			end

			if arg_28_1.time_ >= var_31_7 + var_31_8 and arg_28_1.time_ < var_31_7 + var_31_8 + arg_31_0 then
				var_31_6.localPosition = Vector3.New(0, 100, 0)

				local var_31_13 = manager.ui.mainCamera.transform.position - var_31_6.position

				var_31_6.forward = Vector3.New(var_31_13.x, var_31_13.y, var_31_13.z)

				local var_31_14 = var_31_6.localEulerAngles

				var_31_14.z = 0
				var_31_14.x = 0
				var_31_6.localEulerAngles = var_31_14
			end

			local var_31_15 = 0
			local var_31_16 = 1.3

			if var_31_15 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_17 = arg_28_1:GetWordFromCfg(104041007)
				local var_31_18 = arg_28_1:FormatText(var_31_17.content)

				arg_28_1.text_.text = var_31_18

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_19 = 52
				local var_31_20 = utf8.len(var_31_18)
				local var_31_21 = var_31_19 <= 0 and var_31_16 or var_31_16 * (var_31_20 / var_31_19)

				if var_31_21 > 0 and var_31_16 < var_31_21 then
					arg_28_1.talkMaxDuration = var_31_21

					if var_31_21 + var_31_15 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_21 + var_31_15
					end
				end

				arg_28_1.text_.text = var_31_18
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_22 = math.max(var_31_16, arg_28_1.talkMaxDuration)

			if var_31_15 <= arg_28_1.time_ and arg_28_1.time_ < var_31_15 + var_31_22 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_15) / var_31_22

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_15 + var_31_22 and arg_28_1.time_ < var_31_15 + var_31_22 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
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

		arg_28_1:InitPlayNodeList()
	end,
	Play104041008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 104041008
		arg_32_1.duration_ = 2.87

		local var_32_0 = {
			ja = 2.266,
			ko = 2.2,
			zh = 2.5,
			en = 2.866
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
				arg_32_0:Play104041009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1036ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1036ui_story == nil then
				arg_32_1.var_.characterEffect1036ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1036ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1036ui_story then
				arg_32_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["1036ui_story"].transform
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 then
				arg_32_1.var_.moveOldPos1036ui_story = var_35_4.localPosition
			end

			local var_35_6 = 0.001

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6
				local var_35_8 = Vector3.New(0, -1.09, -5.78)

				var_35_4.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1036ui_story, var_35_8, var_35_7)

				local var_35_9 = manager.ui.mainCamera.transform.position - var_35_4.position

				var_35_4.forward = Vector3.New(var_35_9.x, var_35_9.y, var_35_9.z)

				local var_35_10 = var_35_4.localEulerAngles

				var_35_10.z = 0
				var_35_10.x = 0
				var_35_4.localEulerAngles = var_35_10
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 then
				var_35_4.localPosition = Vector3.New(0, -1.09, -5.78)

				local var_35_11 = manager.ui.mainCamera.transform.position - var_35_4.position

				var_35_4.forward = Vector3.New(var_35_11.x, var_35_11.y, var_35_11.z)

				local var_35_12 = var_35_4.localEulerAngles

				var_35_12.z = 0
				var_35_12.x = 0
				var_35_4.localEulerAngles = var_35_12
			end

			local var_35_13 = 0

			if var_35_13 < arg_32_1.time_ and arg_32_1.time_ <= var_35_13 + arg_35_0 then
				arg_32_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action7_1")
			end

			local var_35_14 = 0

			if var_35_14 < arg_32_1.time_ and arg_32_1.time_ <= var_35_14 + arg_35_0 then
				arg_32_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_35_15 = 0
			local var_35_16 = 0.275

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_17 = arg_32_1:FormatText(StoryNameCfg[5].name)

				arg_32_1.leftNameTxt_.text = var_35_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_18 = arg_32_1:GetWordFromCfg(104041008)
				local var_35_19 = arg_32_1:FormatText(var_35_18.content)

				arg_32_1.text_.text = var_35_19

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_20 = 11
				local var_35_21 = utf8.len(var_35_19)
				local var_35_22 = var_35_20 <= 0 and var_35_16 or var_35_16 * (var_35_21 / var_35_20)

				if var_35_22 > 0 and var_35_16 < var_35_22 then
					arg_32_1.talkMaxDuration = var_35_22

					if var_35_22 + var_35_15 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_22 + var_35_15
					end
				end

				arg_32_1.text_.text = var_35_19
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104041", "104041008", "story_v_out_104041.awb") ~= 0 then
					local var_35_23 = manager.audio:GetVoiceLength("story_v_out_104041", "104041008", "story_v_out_104041.awb") / 1000

					if var_35_23 + var_35_15 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_23 + var_35_15
					end

					if var_35_18.prefab_name ~= "" and arg_32_1.actors_[var_35_18.prefab_name] ~= nil then
						local var_35_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_18.prefab_name].transform, "story_v_out_104041", "104041008", "story_v_out_104041.awb")

						arg_32_1:RecordAudio("104041008", var_35_24)
						arg_32_1:RecordAudio("104041008", var_35_24)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_104041", "104041008", "story_v_out_104041.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_104041", "104041008", "story_v_out_104041.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_25 = math.max(var_35_16, arg_32_1.talkMaxDuration)

			if var_35_15 <= arg_32_1.time_ and arg_32_1.time_ < var_35_15 + var_35_25 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_15) / var_35_25

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_15 + var_35_25 and arg_32_1.time_ < var_35_15 + var_35_25 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play104041009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 104041009
		arg_36_1.duration_ = 5.47

		local var_36_0 = {
			ja = 4.766,
			ko = 4.266,
			zh = 5.466,
			en = 4.733
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
				arg_36_0:Play104041010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1011ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1011ui_story == nil then
				arg_36_1.var_.characterEffect1011ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.1

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1011ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1011ui_story then
				arg_36_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["1036ui_story"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1036ui_story == nil then
				arg_36_1.var_.characterEffect1036ui_story = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.1

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect1036ui_story and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1036ui_story.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1036ui_story then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1036ui_story.fillRatio = var_39_9
			end

			local var_39_10 = arg_36_1.actors_["1036ui_story"].transform
			local var_39_11 = 0

			if var_39_11 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1.var_.moveOldPos1036ui_story = var_39_10.localPosition
			end

			local var_39_12 = 0.001

			if var_39_11 <= arg_36_1.time_ and arg_36_1.time_ < var_39_11 + var_39_12 then
				local var_39_13 = (arg_36_1.time_ - var_39_11) / var_39_12
				local var_39_14 = Vector3.New(0, 100, 0)

				var_39_10.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1036ui_story, var_39_14, var_39_13)

				local var_39_15 = manager.ui.mainCamera.transform.position - var_39_10.position

				var_39_10.forward = Vector3.New(var_39_15.x, var_39_15.y, var_39_15.z)

				local var_39_16 = var_39_10.localEulerAngles

				var_39_16.z = 0
				var_39_16.x = 0
				var_39_10.localEulerAngles = var_39_16
			end

			if arg_36_1.time_ >= var_39_11 + var_39_12 and arg_36_1.time_ < var_39_11 + var_39_12 + arg_39_0 then
				var_39_10.localPosition = Vector3.New(0, 100, 0)

				local var_39_17 = manager.ui.mainCamera.transform.position - var_39_10.position

				var_39_10.forward = Vector3.New(var_39_17.x, var_39_17.y, var_39_17.z)

				local var_39_18 = var_39_10.localEulerAngles

				var_39_18.z = 0
				var_39_18.x = 0
				var_39_10.localEulerAngles = var_39_18
			end

			local var_39_19 = arg_36_1.actors_["1011ui_story"].transform
			local var_39_20 = 0

			if var_39_20 < arg_36_1.time_ and arg_36_1.time_ <= var_39_20 + arg_39_0 then
				arg_36_1.var_.moveOldPos1011ui_story = var_39_19.localPosition
			end

			local var_39_21 = 0.001

			if var_39_20 <= arg_36_1.time_ and arg_36_1.time_ < var_39_20 + var_39_21 then
				local var_39_22 = (arg_36_1.time_ - var_39_20) / var_39_21
				local var_39_23 = Vector3.New(0, -0.71, -6)

				var_39_19.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1011ui_story, var_39_23, var_39_22)

				local var_39_24 = manager.ui.mainCamera.transform.position - var_39_19.position

				var_39_19.forward = Vector3.New(var_39_24.x, var_39_24.y, var_39_24.z)

				local var_39_25 = var_39_19.localEulerAngles

				var_39_25.z = 0
				var_39_25.x = 0
				var_39_19.localEulerAngles = var_39_25
			end

			if arg_36_1.time_ >= var_39_20 + var_39_21 and arg_36_1.time_ < var_39_20 + var_39_21 + arg_39_0 then
				var_39_19.localPosition = Vector3.New(0, -0.71, -6)

				local var_39_26 = manager.ui.mainCamera.transform.position - var_39_19.position

				var_39_19.forward = Vector3.New(var_39_26.x, var_39_26.y, var_39_26.z)

				local var_39_27 = var_39_19.localEulerAngles

				var_39_27.z = 0
				var_39_27.x = 0
				var_39_19.localEulerAngles = var_39_27
			end

			local var_39_28 = 0

			if var_39_28 < arg_36_1.time_ and arg_36_1.time_ <= var_39_28 + arg_39_0 then
				arg_36_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_39_29 = 0

			if var_39_29 < arg_36_1.time_ and arg_36_1.time_ <= var_39_29 + arg_39_0 then
				arg_36_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_39_30 = 0
			local var_39_31 = 0.425

			if var_39_30 < arg_36_1.time_ and arg_36_1.time_ <= var_39_30 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_32 = arg_36_1:FormatText(StoryNameCfg[37].name)

				arg_36_1.leftNameTxt_.text = var_39_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_33 = arg_36_1:GetWordFromCfg(104041009)
				local var_39_34 = arg_36_1:FormatText(var_39_33.content)

				arg_36_1.text_.text = var_39_34

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_35 = 17
				local var_39_36 = utf8.len(var_39_34)
				local var_39_37 = var_39_35 <= 0 and var_39_31 or var_39_31 * (var_39_36 / var_39_35)

				if var_39_37 > 0 and var_39_31 < var_39_37 then
					arg_36_1.talkMaxDuration = var_39_37

					if var_39_37 + var_39_30 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_37 + var_39_30
					end
				end

				arg_36_1.text_.text = var_39_34
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104041", "104041009", "story_v_out_104041.awb") ~= 0 then
					local var_39_38 = manager.audio:GetVoiceLength("story_v_out_104041", "104041009", "story_v_out_104041.awb") / 1000

					if var_39_38 + var_39_30 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_38 + var_39_30
					end

					if var_39_33.prefab_name ~= "" and arg_36_1.actors_[var_39_33.prefab_name] ~= nil then
						local var_39_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_33.prefab_name].transform, "story_v_out_104041", "104041009", "story_v_out_104041.awb")

						arg_36_1:RecordAudio("104041009", var_39_39)
						arg_36_1:RecordAudio("104041009", var_39_39)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_104041", "104041009", "story_v_out_104041.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_104041", "104041009", "story_v_out_104041.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_40 = math.max(var_39_31, arg_36_1.talkMaxDuration)

			if var_39_30 <= arg_36_1.time_ and arg_36_1.time_ < var_39_30 + var_39_40 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_30) / var_39_40

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_30 + var_39_40 and arg_36_1.time_ < var_39_30 + var_39_40 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play104041010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 104041010
		arg_40_1.duration_ = 11.57

		local var_40_0 = {
			ja = 11.566,
			ko = 8.166,
			zh = 10.166,
			en = 10.166
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
				arg_40_0:Play104041011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_43_2 = 0
			local var_43_3 = 0.975

			if var_43_2 < arg_40_1.time_ and arg_40_1.time_ <= var_43_2 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_4 = arg_40_1:FormatText(StoryNameCfg[37].name)

				arg_40_1.leftNameTxt_.text = var_43_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_5 = arg_40_1:GetWordFromCfg(104041010)
				local var_43_6 = arg_40_1:FormatText(var_43_5.content)

				arg_40_1.text_.text = var_43_6

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_7 = 39
				local var_43_8 = utf8.len(var_43_6)
				local var_43_9 = var_43_7 <= 0 and var_43_3 or var_43_3 * (var_43_8 / var_43_7)

				if var_43_9 > 0 and var_43_3 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_2
					end
				end

				arg_40_1.text_.text = var_43_6
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104041", "104041010", "story_v_out_104041.awb") ~= 0 then
					local var_43_10 = manager.audio:GetVoiceLength("story_v_out_104041", "104041010", "story_v_out_104041.awb") / 1000

					if var_43_10 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_2
					end

					if var_43_5.prefab_name ~= "" and arg_40_1.actors_[var_43_5.prefab_name] ~= nil then
						local var_43_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_5.prefab_name].transform, "story_v_out_104041", "104041010", "story_v_out_104041.awb")

						arg_40_1:RecordAudio("104041010", var_43_11)
						arg_40_1:RecordAudio("104041010", var_43_11)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_104041", "104041010", "story_v_out_104041.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_104041", "104041010", "story_v_out_104041.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_12 = math.max(var_43_3, arg_40_1.talkMaxDuration)

			if var_43_2 <= arg_40_1.time_ and arg_40_1.time_ < var_43_2 + var_43_12 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_2) / var_43_12

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_2 + var_43_12 and arg_40_1.time_ < var_43_2 + var_43_12 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play104041011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 104041011
		arg_44_1.duration_ = 2.87

		local var_44_0 = {
			ja = 1.3,
			ko = 1.066,
			zh = 2.866,
			en = 1.4
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
			arg_44_1.auto_ = false
		end

		function arg_44_1.playNext_(arg_46_0)
			arg_44_1.onStoryFinished_()
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1019ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1019ui_story == nil then
				arg_44_1.var_.characterEffect1019ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1019ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1019ui_story then
				arg_44_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_47_4 = arg_44_1.actors_["1011ui_story"]
			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1011ui_story == nil then
				arg_44_1.var_.characterEffect1011ui_story = var_47_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_6 = 0.1

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_6 and not isNil(var_47_4) then
				local var_47_7 = (arg_44_1.time_ - var_47_5) / var_47_6

				if arg_44_1.var_.characterEffect1011ui_story and not isNil(var_47_4) then
					local var_47_8 = Mathf.Lerp(0, 0.5, var_47_7)

					arg_44_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1011ui_story.fillRatio = var_47_8
				end
			end

			if arg_44_1.time_ >= var_47_5 + var_47_6 and arg_44_1.time_ < var_47_5 + var_47_6 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1011ui_story then
				local var_47_9 = 0.5

				arg_44_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1011ui_story.fillRatio = var_47_9
			end

			local var_47_10 = arg_44_1.actors_["1011ui_story"].transform
			local var_47_11 = 0

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1.var_.moveOldPos1011ui_story = var_47_10.localPosition
			end

			local var_47_12 = 0.001

			if var_47_11 <= arg_44_1.time_ and arg_44_1.time_ < var_47_11 + var_47_12 then
				local var_47_13 = (arg_44_1.time_ - var_47_11) / var_47_12
				local var_47_14 = Vector3.New(0, 100, 0)

				var_47_10.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1011ui_story, var_47_14, var_47_13)

				local var_47_15 = manager.ui.mainCamera.transform.position - var_47_10.position

				var_47_10.forward = Vector3.New(var_47_15.x, var_47_15.y, var_47_15.z)

				local var_47_16 = var_47_10.localEulerAngles

				var_47_16.z = 0
				var_47_16.x = 0
				var_47_10.localEulerAngles = var_47_16
			end

			if arg_44_1.time_ >= var_47_11 + var_47_12 and arg_44_1.time_ < var_47_11 + var_47_12 + arg_47_0 then
				var_47_10.localPosition = Vector3.New(0, 100, 0)

				local var_47_17 = manager.ui.mainCamera.transform.position - var_47_10.position

				var_47_10.forward = Vector3.New(var_47_17.x, var_47_17.y, var_47_17.z)

				local var_47_18 = var_47_10.localEulerAngles

				var_47_18.z = 0
				var_47_18.x = 0
				var_47_10.localEulerAngles = var_47_18
			end

			local var_47_19 = arg_44_1.actors_["1019ui_story"].transform
			local var_47_20 = 0

			if var_47_20 < arg_44_1.time_ and arg_44_1.time_ <= var_47_20 + arg_47_0 then
				arg_44_1.var_.moveOldPos1019ui_story = var_47_19.localPosition
			end

			local var_47_21 = 0.001

			if var_47_20 <= arg_44_1.time_ and arg_44_1.time_ < var_47_20 + var_47_21 then
				local var_47_22 = (arg_44_1.time_ - var_47_20) / var_47_21
				local var_47_23 = Vector3.New(-0.2, -1.08, -5.9)

				var_47_19.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1019ui_story, var_47_23, var_47_22)

				local var_47_24 = manager.ui.mainCamera.transform.position - var_47_19.position

				var_47_19.forward = Vector3.New(var_47_24.x, var_47_24.y, var_47_24.z)

				local var_47_25 = var_47_19.localEulerAngles

				var_47_25.z = 0
				var_47_25.x = 0
				var_47_19.localEulerAngles = var_47_25
			end

			if arg_44_1.time_ >= var_47_20 + var_47_21 and arg_44_1.time_ < var_47_20 + var_47_21 + arg_47_0 then
				var_47_19.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_47_26 = manager.ui.mainCamera.transform.position - var_47_19.position

				var_47_19.forward = Vector3.New(var_47_26.x, var_47_26.y, var_47_26.z)

				local var_47_27 = var_47_19.localEulerAngles

				var_47_27.z = 0
				var_47_27.x = 0
				var_47_19.localEulerAngles = var_47_27
			end

			local var_47_28 = 0

			if var_47_28 < arg_44_1.time_ and arg_44_1.time_ <= var_47_28 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_47_29 = 0
			local var_47_30 = 0.05

			if var_47_29 < arg_44_1.time_ and arg_44_1.time_ <= var_47_29 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_31 = arg_44_1:FormatText(StoryNameCfg[13].name)

				arg_44_1.leftNameTxt_.text = var_47_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_32 = arg_44_1:GetWordFromCfg(104041011)
				local var_47_33 = arg_44_1:FormatText(var_47_32.content)

				arg_44_1.text_.text = var_47_33

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_34 = 2
				local var_47_35 = utf8.len(var_47_33)
				local var_47_36 = var_47_34 <= 0 and var_47_30 or var_47_30 * (var_47_35 / var_47_34)

				if var_47_36 > 0 and var_47_30 < var_47_36 then
					arg_44_1.talkMaxDuration = var_47_36

					if var_47_36 + var_47_29 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_36 + var_47_29
					end
				end

				arg_44_1.text_.text = var_47_33
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104041", "104041011", "story_v_out_104041.awb") ~= 0 then
					local var_47_37 = manager.audio:GetVoiceLength("story_v_out_104041", "104041011", "story_v_out_104041.awb") / 1000

					if var_47_37 + var_47_29 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_37 + var_47_29
					end

					if var_47_32.prefab_name ~= "" and arg_44_1.actors_[var_47_32.prefab_name] ~= nil then
						local var_47_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_32.prefab_name].transform, "story_v_out_104041", "104041011", "story_v_out_104041.awb")

						arg_44_1:RecordAudio("104041011", var_47_38)
						arg_44_1:RecordAudio("104041011", var_47_38)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_104041", "104041011", "story_v_out_104041.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_104041", "104041011", "story_v_out_104041.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_39 = math.max(var_47_30, arg_44_1.talkMaxDuration)

			if var_47_29 <= arg_44_1.time_ and arg_44_1.time_ < var_47_29 + var_47_39 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_29) / var_47_39

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_29 + var_47_39 and arg_44_1.time_ < var_47_29 + var_47_39 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_44_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B04b"
	},
	voices = {
		"story_v_out_104041.awb"
	}
}
