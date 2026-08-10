return {
	Play102111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 102111001
		arg_1_1.duration_ = 8.77

		local var_1_0 = {
			ja = 7.2,
			ko = 7.666,
			zh = 8.766,
			en = 7.666
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
				arg_1_0:Play102111002(arg_1_1)
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
			local var_4_16 = 2

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

			local var_4_19 = "B08b"

			if arg_1_1.bgs_[var_4_19] == nil then
				local var_4_20 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_19)
				var_4_20.name = var_4_19
				var_4_20.transform.parent = arg_1_1.stage_.transform
				var_4_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_19] = var_4_20
			end

			local var_4_21 = arg_1_1.bgs_.B08b
			local var_4_22 = 0

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_23 = var_4_21:GetComponent("SpriteRenderer")

				if var_4_23 then
					arg_1_1.var_.alphaOldValueB08b = var_4_23.color.a
					arg_1_1.var_.alphaMatValueB08b = var_4_23
				end

				arg_1_1.var_.alphaOldValueB08b = 0
			end

			local var_4_24 = 1.5

			if var_4_22 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_24 then
				local var_4_25 = (arg_1_1.time_ - var_4_22) / var_4_24
				local var_4_26 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB08b, 1, var_4_25)

				if arg_1_1.var_.alphaMatValueB08b then
					local var_4_27 = arg_1_1.var_.alphaMatValueB08b.color

					var_4_27.a = var_4_26
					arg_1_1.var_.alphaMatValueB08b.color = var_4_27
				end
			end

			if arg_1_1.time_ >= var_4_22 + var_4_24 and arg_1_1.time_ < var_4_22 + var_4_24 + arg_4_0 and arg_1_1.var_.alphaMatValueB08b then
				local var_4_28 = arg_1_1.var_.alphaMatValueB08b
				local var_4_29 = var_4_28.color

				var_4_29.a = 1
				var_4_28.color = var_4_29
			end

			local var_4_30 = 0

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_31 = manager.ui.mainCamera.transform.localPosition
				local var_4_32 = Vector3.New(0, 0, 10) + Vector3.New(var_4_31.x, var_4_31.y, 0)
				local var_4_33 = arg_1_1.bgs_.B08b

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
					if iter_4_0 ~= "B08b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_44 = arg_1_1.actors_["1084ui_story"].transform
			local var_4_45 = 1.79999995231628

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

			local var_4_53 = 1.79999995231628

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_4_54 = 0

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_55 = 2

			if arg_1_1.time_ >= var_4_54 + var_4_55 and arg_1_1.time_ < var_4_54 + var_4_55 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_56 = 0

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_57 = 2
			local var_4_58 = 0.675

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

				local var_4_61 = arg_1_1:GetWordFromCfg(102111001)
				local var_4_62 = arg_1_1:FormatText(var_4_61.content)

				arg_1_1.text_.text = var_4_62

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_63 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111001", "story_v_out_102111.awb") ~= 0 then
					local var_4_66 = manager.audio:GetVoiceLength("story_v_out_102111", "102111001", "story_v_out_102111.awb") / 1000

					if var_4_66 + var_4_57 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_66 + var_4_57
					end

					if var_4_61.prefab_name ~= "" and arg_1_1.actors_[var_4_61.prefab_name] ~= nil then
						local var_4_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_61.prefab_name].transform, "story_v_out_102111", "102111001", "story_v_out_102111.awb")

						arg_1_1:RecordAudio("102111001", var_4_67)
						arg_1_1:RecordAudio("102111001", var_4_67)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_102111", "102111001", "story_v_out_102111.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_102111", "102111001", "story_v_out_102111.awb")
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
				startTime = 1.79999995231628,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play102111002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 102111002
		arg_8_1.duration_ = 2.8

		local var_8_0 = {
			ja = 2.6,
			ko = 2.5,
			zh = 2.8,
			en = 2.666
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
				arg_8_0:Play102111003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1011ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1011ui_story"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1011ui_story == nil then
				arg_8_1.var_.characterEffect1011ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect1011ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1011ui_story then
				arg_8_1.var_.characterEffect1011ui_story.fillFlat = false
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

			local var_11_15 = arg_8_1.actors_["1011ui_story"].transform
			local var_11_16 = 0

			if var_11_16 < arg_8_1.time_ and arg_8_1.time_ <= var_11_16 + arg_11_0 then
				arg_8_1.var_.moveOldPos1011ui_story = var_11_15.localPosition
			end

			local var_11_17 = 0.001

			if var_11_16 <= arg_8_1.time_ and arg_8_1.time_ < var_11_16 + var_11_17 then
				local var_11_18 = (arg_8_1.time_ - var_11_16) / var_11_17
				local var_11_19 = Vector3.New(0.7, -0.71, -6)

				var_11_15.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1011ui_story, var_11_19, var_11_18)

				local var_11_20 = manager.ui.mainCamera.transform.position - var_11_15.position

				var_11_15.forward = Vector3.New(var_11_20.x, var_11_20.y, var_11_20.z)

				local var_11_21 = var_11_15.localEulerAngles

				var_11_21.z = 0
				var_11_21.x = 0
				var_11_15.localEulerAngles = var_11_21
			end

			if arg_8_1.time_ >= var_11_16 + var_11_17 and arg_8_1.time_ < var_11_16 + var_11_17 + arg_11_0 then
				var_11_15.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_11_22 = manager.ui.mainCamera.transform.position - var_11_15.position

				var_11_15.forward = Vector3.New(var_11_22.x, var_11_22.y, var_11_22.z)

				local var_11_23 = var_11_15.localEulerAngles

				var_11_23.z = 0
				var_11_23.x = 0
				var_11_15.localEulerAngles = var_11_23
			end

			local var_11_24 = 0

			if var_11_24 < arg_8_1.time_ and arg_8_1.time_ <= var_11_24 + arg_11_0 then
				arg_8_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_11_25 = 0

			if var_11_25 < arg_8_1.time_ and arg_8_1.time_ <= var_11_25 + arg_11_0 then
				arg_8_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_11_26 = 0
			local var_11_27 = 0.25

			if var_11_26 < arg_8_1.time_ and arg_8_1.time_ <= var_11_26 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_28 = arg_8_1:FormatText(StoryNameCfg[37].name)

				arg_8_1.leftNameTxt_.text = var_11_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_29 = arg_8_1:GetWordFromCfg(102111002)
				local var_11_30 = arg_8_1:FormatText(var_11_29.content)

				arg_8_1.text_.text = var_11_30

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_31 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111002", "story_v_out_102111.awb") ~= 0 then
					local var_11_34 = manager.audio:GetVoiceLength("story_v_out_102111", "102111002", "story_v_out_102111.awb") / 1000

					if var_11_34 + var_11_26 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_34 + var_11_26
					end

					if var_11_29.prefab_name ~= "" and arg_8_1.actors_[var_11_29.prefab_name] ~= nil then
						local var_11_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_29.prefab_name].transform, "story_v_out_102111", "102111002", "story_v_out_102111.awb")

						arg_8_1:RecordAudio("102111002", var_11_35)
						arg_8_1:RecordAudio("102111002", var_11_35)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_102111", "102111002", "story_v_out_102111.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_102111", "102111002", "story_v_out_102111.awb")
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
				actorName = "1011ui_story",
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
	Play102111003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 102111003
		arg_12_1.duration_ = 5.83

		local var_12_0 = {
			ja = 5.433,
			ko = 5.066,
			zh = 4.4,
			en = 5.833
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
				arg_12_0:Play102111004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "3008ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "3008ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_12_1.stage_.transform)

					var_15_2.name = var_15_0
					var_15_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_12_1.actors_[var_15_0] = var_15_2

					local var_15_3 = var_15_2:GetComponentInChildren(typeof(CharacterEffect))

					var_15_3.enabled = true

					local var_15_4 = GameObjectTools.GetOrAddComponent(var_15_2, typeof(DynamicBoneHelper))

					if var_15_4 then
						var_15_4:EnableDynamicBone(false)
					end

					arg_12_1:ShowWeapon(var_15_3.transform, false)

					arg_12_1.var_[var_15_0 .. "Animator"] = var_15_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_12_1.var_[var_15_0 .. "Animator"].applyRootMotion = true
					arg_12_1.var_[var_15_0 .. "LipSync"] = var_15_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_15_5 = arg_12_1.actors_["3008ui_story"]
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect3008ui_story == nil then
				arg_12_1.var_.characterEffect3008ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_7 = 0.1

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 and not isNil(var_15_5) then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7

				if arg_12_1.var_.characterEffect3008ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect3008ui_story then
				arg_12_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_15_9 = arg_12_1.actors_["1011ui_story"]
			local var_15_10 = 0

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect1011ui_story == nil then
				arg_12_1.var_.characterEffect1011ui_story = var_15_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_11 = 0.1

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_11 and not isNil(var_15_9) then
				local var_15_12 = (arg_12_1.time_ - var_15_10) / var_15_11

				if arg_12_1.var_.characterEffect1011ui_story and not isNil(var_15_9) then
					local var_15_13 = Mathf.Lerp(0, 0.5, var_15_12)

					arg_12_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1011ui_story.fillRatio = var_15_13
				end
			end

			if arg_12_1.time_ >= var_15_10 + var_15_11 and arg_12_1.time_ < var_15_10 + var_15_11 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect1011ui_story then
				local var_15_14 = 0.5

				arg_12_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1011ui_story.fillRatio = var_15_14
			end

			local var_15_15 = arg_12_1.actors_["1011ui_story"].transform
			local var_15_16 = 0

			if var_15_16 < arg_12_1.time_ and arg_12_1.time_ <= var_15_16 + arg_15_0 then
				arg_12_1.var_.moveOldPos1011ui_story = var_15_15.localPosition
			end

			local var_15_17 = 0.001

			if var_15_16 <= arg_12_1.time_ and arg_12_1.time_ < var_15_16 + var_15_17 then
				local var_15_18 = (arg_12_1.time_ - var_15_16) / var_15_17
				local var_15_19 = Vector3.New(0, 100, 0)

				var_15_15.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1011ui_story, var_15_19, var_15_18)

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

			local var_15_24 = arg_12_1.actors_["1084ui_story"].transform
			local var_15_25 = 0

			if var_15_25 < arg_12_1.time_ and arg_12_1.time_ <= var_15_25 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = var_15_24.localPosition
			end

			local var_15_26 = 0.001

			if var_15_25 <= arg_12_1.time_ and arg_12_1.time_ < var_15_25 + var_15_26 then
				local var_15_27 = (arg_12_1.time_ - var_15_25) / var_15_26
				local var_15_28 = Vector3.New(0, 100, 0)

				var_15_24.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, var_15_28, var_15_27)

				local var_15_29 = manager.ui.mainCamera.transform.position - var_15_24.position

				var_15_24.forward = Vector3.New(var_15_29.x, var_15_29.y, var_15_29.z)

				local var_15_30 = var_15_24.localEulerAngles

				var_15_30.z = 0
				var_15_30.x = 0
				var_15_24.localEulerAngles = var_15_30
			end

			if arg_12_1.time_ >= var_15_25 + var_15_26 and arg_12_1.time_ < var_15_25 + var_15_26 + arg_15_0 then
				var_15_24.localPosition = Vector3.New(0, 100, 0)

				local var_15_31 = manager.ui.mainCamera.transform.position - var_15_24.position

				var_15_24.forward = Vector3.New(var_15_31.x, var_15_31.y, var_15_31.z)

				local var_15_32 = var_15_24.localEulerAngles

				var_15_32.z = 0
				var_15_32.x = 0
				var_15_24.localEulerAngles = var_15_32
			end

			local var_15_33 = arg_12_1.actors_["3008ui_story"].transform
			local var_15_34 = 0

			if var_15_34 < arg_12_1.time_ and arg_12_1.time_ <= var_15_34 + arg_15_0 then
				arg_12_1.var_.moveOldPos3008ui_story = var_15_33.localPosition
			end

			local var_15_35 = 0.001

			if var_15_34 <= arg_12_1.time_ and arg_12_1.time_ < var_15_34 + var_15_35 then
				local var_15_36 = (arg_12_1.time_ - var_15_34) / var_15_35
				local var_15_37 = Vector3.New(0, -1.51, -4.3)

				var_15_33.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos3008ui_story, var_15_37, var_15_36)

				local var_15_38 = manager.ui.mainCamera.transform.position - var_15_33.position

				var_15_33.forward = Vector3.New(var_15_38.x, var_15_38.y, var_15_38.z)

				local var_15_39 = var_15_33.localEulerAngles

				var_15_39.z = 0
				var_15_39.x = 0
				var_15_33.localEulerAngles = var_15_39
			end

			if arg_12_1.time_ >= var_15_34 + var_15_35 and arg_12_1.time_ < var_15_34 + var_15_35 + arg_15_0 then
				var_15_33.localPosition = Vector3.New(0, -1.51, -4.3)

				local var_15_40 = manager.ui.mainCamera.transform.position - var_15_33.position

				var_15_33.forward = Vector3.New(var_15_40.x, var_15_40.y, var_15_40.z)

				local var_15_41 = var_15_33.localEulerAngles

				var_15_41.z = 0
				var_15_41.x = 0
				var_15_33.localEulerAngles = var_15_41
			end

			local var_15_42 = 0

			if var_15_42 < arg_12_1.time_ and arg_12_1.time_ <= var_15_42 + arg_15_0 then
				arg_12_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action1_1")
			end

			local var_15_43 = 0

			if var_15_43 < arg_12_1.time_ and arg_12_1.time_ <= var_15_43 + arg_15_0 then
				arg_12_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_15_44 = 0
			local var_15_45 = 0.45

			if var_15_44 < arg_12_1.time_ and arg_12_1.time_ <= var_15_44 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_46 = arg_12_1:FormatText(StoryNameCfg[20].name)

				arg_12_1.leftNameTxt_.text = var_15_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_47 = arg_12_1:GetWordFromCfg(102111003)
				local var_15_48 = arg_12_1:FormatText(var_15_47.content)

				arg_12_1.text_.text = var_15_48

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_49 = 18
				local var_15_50 = utf8.len(var_15_48)
				local var_15_51 = var_15_49 <= 0 and var_15_45 or var_15_45 * (var_15_50 / var_15_49)

				if var_15_51 > 0 and var_15_45 < var_15_51 then
					arg_12_1.talkMaxDuration = var_15_51

					if var_15_51 + var_15_44 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_51 + var_15_44
					end
				end

				arg_12_1.text_.text = var_15_48
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111003", "story_v_out_102111.awb") ~= 0 then
					local var_15_52 = manager.audio:GetVoiceLength("story_v_out_102111", "102111003", "story_v_out_102111.awb") / 1000

					if var_15_52 + var_15_44 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_52 + var_15_44
					end

					if var_15_47.prefab_name ~= "" and arg_12_1.actors_[var_15_47.prefab_name] ~= nil then
						local var_15_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_47.prefab_name].transform, "story_v_out_102111", "102111003", "story_v_out_102111.awb")

						arg_12_1:RecordAudio("102111003", var_15_53)
						arg_12_1:RecordAudio("102111003", var_15_53)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_102111", "102111003", "story_v_out_102111.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_102111", "102111003", "story_v_out_102111.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_54 = math.max(var_15_45, arg_12_1.talkMaxDuration)

			if var_15_44 <= arg_12_1.time_ and arg_12_1.time_ < var_15_44 + var_15_54 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_44) / var_15_54

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_44 + var_15_54 and arg_12_1.time_ < var_15_44 + var_15_54 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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
				actorName = "3008ui_story",
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
	Play102111004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 102111004
		arg_16_1.duration_ = 3.37

		local var_16_0 = {
			ja = 1.999999999999,
			ko = 3.366,
			zh = 2.266,
			en = 2.166
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
				arg_16_0:Play102111005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1084ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.1

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_0) then
					arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1084ui_story then
				arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_19_4 = arg_16_1.actors_["3008ui_story"].transform
			local var_19_5 = 0

			if var_19_5 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 then
				arg_16_1.var_.moveOldPos3008ui_story = var_19_4.localPosition
			end

			local var_19_6 = 0.001

			if var_19_5 <= arg_16_1.time_ and arg_16_1.time_ < var_19_5 + var_19_6 then
				local var_19_7 = (arg_16_1.time_ - var_19_5) / var_19_6
				local var_19_8 = Vector3.New(0, 100, 0)

				var_19_4.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos3008ui_story, var_19_8, var_19_7)

				local var_19_9 = manager.ui.mainCamera.transform.position - var_19_4.position

				var_19_4.forward = Vector3.New(var_19_9.x, var_19_9.y, var_19_9.z)

				local var_19_10 = var_19_4.localEulerAngles

				var_19_10.z = 0
				var_19_10.x = 0
				var_19_4.localEulerAngles = var_19_10
			end

			if arg_16_1.time_ >= var_19_5 + var_19_6 and arg_16_1.time_ < var_19_5 + var_19_6 + arg_19_0 then
				var_19_4.localPosition = Vector3.New(0, 100, 0)

				local var_19_11 = manager.ui.mainCamera.transform.position - var_19_4.position

				var_19_4.forward = Vector3.New(var_19_11.x, var_19_11.y, var_19_11.z)

				local var_19_12 = var_19_4.localEulerAngles

				var_19_12.z = 0
				var_19_12.x = 0
				var_19_4.localEulerAngles = var_19_12
			end

			local var_19_13 = arg_16_1.actors_["1084ui_story"].transform
			local var_19_14 = 0

			if var_19_14 < arg_16_1.time_ and arg_16_1.time_ <= var_19_14 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_13.localPosition
			end

			local var_19_15 = 0.001

			if var_19_14 <= arg_16_1.time_ and arg_16_1.time_ < var_19_14 + var_19_15 then
				local var_19_16 = (arg_16_1.time_ - var_19_14) / var_19_15
				local var_19_17 = Vector3.New(0, -0.97, -6)

				var_19_13.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, var_19_17, var_19_16)

				local var_19_18 = manager.ui.mainCamera.transform.position - var_19_13.position

				var_19_13.forward = Vector3.New(var_19_18.x, var_19_18.y, var_19_18.z)

				local var_19_19 = var_19_13.localEulerAngles

				var_19_19.z = 0
				var_19_19.x = 0
				var_19_13.localEulerAngles = var_19_19
			end

			if arg_16_1.time_ >= var_19_14 + var_19_15 and arg_16_1.time_ < var_19_14 + var_19_15 + arg_19_0 then
				var_19_13.localPosition = Vector3.New(0, -0.97, -6)

				local var_19_20 = manager.ui.mainCamera.transform.position - var_19_13.position

				var_19_13.forward = Vector3.New(var_19_20.x, var_19_20.y, var_19_20.z)

				local var_19_21 = var_19_13.localEulerAngles

				var_19_21.z = 0
				var_19_21.x = 0
				var_19_13.localEulerAngles = var_19_21
			end

			local var_19_22 = 0

			if var_19_22 < arg_16_1.time_ and arg_16_1.time_ <= var_19_22 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_19_23 = 0

			if var_19_23 < arg_16_1.time_ and arg_16_1.time_ <= var_19_23 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_19_24 = 0
			local var_19_25 = 0.175

			if var_19_24 < arg_16_1.time_ and arg_16_1.time_ <= var_19_24 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_26 = arg_16_1:FormatText(StoryNameCfg[6].name)

				arg_16_1.leftNameTxt_.text = var_19_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_27 = arg_16_1:GetWordFromCfg(102111004)
				local var_19_28 = arg_16_1:FormatText(var_19_27.content)

				arg_16_1.text_.text = var_19_28

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_29 = 7
				local var_19_30 = utf8.len(var_19_28)
				local var_19_31 = var_19_29 <= 0 and var_19_25 or var_19_25 * (var_19_30 / var_19_29)

				if var_19_31 > 0 and var_19_25 < var_19_31 then
					arg_16_1.talkMaxDuration = var_19_31

					if var_19_31 + var_19_24 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_31 + var_19_24
					end
				end

				arg_16_1.text_.text = var_19_28
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111004", "story_v_out_102111.awb") ~= 0 then
					local var_19_32 = manager.audio:GetVoiceLength("story_v_out_102111", "102111004", "story_v_out_102111.awb") / 1000

					if var_19_32 + var_19_24 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_32 + var_19_24
					end

					if var_19_27.prefab_name ~= "" and arg_16_1.actors_[var_19_27.prefab_name] ~= nil then
						local var_19_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_27.prefab_name].transform, "story_v_out_102111", "102111004", "story_v_out_102111.awb")

						arg_16_1:RecordAudio("102111004", var_19_33)
						arg_16_1:RecordAudio("102111004", var_19_33)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_102111", "102111004", "story_v_out_102111.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_102111", "102111004", "story_v_out_102111.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_34 = math.max(var_19_25, arg_16_1.talkMaxDuration)

			if var_19_24 <= arg_16_1.time_ and arg_16_1.time_ < var_19_24 + var_19_34 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_24) / var_19_34

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_24 + var_19_34 and arg_16_1.time_ < var_19_24 + var_19_34 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
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

		arg_16_1:InitPlayNodeList()
	end,
	Play102111005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 102111005
		arg_20_1.duration_ = 4.7

		local var_20_0 = {
			ja = 4,
			ko = 3.7,
			zh = 3.8,
			en = 4.7
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
				arg_20_0:Play102111006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action459")
			end

			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_23_2 = 0
			local var_23_3 = 0.375

			if var_23_2 < arg_20_1.time_ and arg_20_1.time_ <= var_23_2 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_4 = arg_20_1:FormatText(StoryNameCfg[6].name)

				arg_20_1.leftNameTxt_.text = var_23_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_5 = arg_20_1:GetWordFromCfg(102111005)
				local var_23_6 = arg_20_1:FormatText(var_23_5.content)

				arg_20_1.text_.text = var_23_6

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_7 = 15
				local var_23_8 = utf8.len(var_23_6)
				local var_23_9 = var_23_7 <= 0 and var_23_3 or var_23_3 * (var_23_8 / var_23_7)

				if var_23_9 > 0 and var_23_3 < var_23_9 then
					arg_20_1.talkMaxDuration = var_23_9

					if var_23_9 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_2
					end
				end

				arg_20_1.text_.text = var_23_6
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111005", "story_v_out_102111.awb") ~= 0 then
					local var_23_10 = manager.audio:GetVoiceLength("story_v_out_102111", "102111005", "story_v_out_102111.awb") / 1000

					if var_23_10 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_10 + var_23_2
					end

					if var_23_5.prefab_name ~= "" and arg_20_1.actors_[var_23_5.prefab_name] ~= nil then
						local var_23_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_5.prefab_name].transform, "story_v_out_102111", "102111005", "story_v_out_102111.awb")

						arg_20_1:RecordAudio("102111005", var_23_11)
						arg_20_1:RecordAudio("102111005", var_23_11)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_102111", "102111005", "story_v_out_102111.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_102111", "102111005", "story_v_out_102111.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_12 = math.max(var_23_3, arg_20_1.talkMaxDuration)

			if var_23_2 <= arg_20_1.time_ and arg_20_1.time_ < var_23_2 + var_23_12 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_2) / var_23_12

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_2 + var_23_12 and arg_20_1.time_ < var_23_2 + var_23_12 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play102111006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 102111006
		arg_24_1.duration_ = 6.87

		local var_24_0 = {
			ja = 4.466,
			ko = 6.866,
			zh = 5.4,
			en = 4.533
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
				arg_24_0:Play102111007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["3008ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect3008ui_story == nil then
				arg_24_1.var_.characterEffect3008ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.1

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect3008ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect3008ui_story then
				arg_24_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_27_4 = arg_24_1.actors_["1084ui_story"]
			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect1084ui_story == nil then
				arg_24_1.var_.characterEffect1084ui_story = var_27_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_6 = 0.1

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_6 and not isNil(var_27_4) then
				local var_27_7 = (arg_24_1.time_ - var_27_5) / var_27_6

				if arg_24_1.var_.characterEffect1084ui_story and not isNil(var_27_4) then
					local var_27_8 = Mathf.Lerp(0, 0.5, var_27_7)

					arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1084ui_story.fillRatio = var_27_8
				end
			end

			if arg_24_1.time_ >= var_27_5 + var_27_6 and arg_24_1.time_ < var_27_5 + var_27_6 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect1084ui_story then
				local var_27_9 = 0.5

				arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1084ui_story.fillRatio = var_27_9
			end

			local var_27_10 = arg_24_1.actors_["1084ui_story"].transform
			local var_27_11 = 0

			if var_27_11 < arg_24_1.time_ and arg_24_1.time_ <= var_27_11 + arg_27_0 then
				arg_24_1.var_.moveOldPos1084ui_story = var_27_10.localPosition
			end

			local var_27_12 = 0.001

			if var_27_11 <= arg_24_1.time_ and arg_24_1.time_ < var_27_11 + var_27_12 then
				local var_27_13 = (arg_24_1.time_ - var_27_11) / var_27_12
				local var_27_14 = Vector3.New(0, 100, 0)

				var_27_10.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1084ui_story, var_27_14, var_27_13)

				local var_27_15 = manager.ui.mainCamera.transform.position - var_27_10.position

				var_27_10.forward = Vector3.New(var_27_15.x, var_27_15.y, var_27_15.z)

				local var_27_16 = var_27_10.localEulerAngles

				var_27_16.z = 0
				var_27_16.x = 0
				var_27_10.localEulerAngles = var_27_16
			end

			if arg_24_1.time_ >= var_27_11 + var_27_12 and arg_24_1.time_ < var_27_11 + var_27_12 + arg_27_0 then
				var_27_10.localPosition = Vector3.New(0, 100, 0)

				local var_27_17 = manager.ui.mainCamera.transform.position - var_27_10.position

				var_27_10.forward = Vector3.New(var_27_17.x, var_27_17.y, var_27_17.z)

				local var_27_18 = var_27_10.localEulerAngles

				var_27_18.z = 0
				var_27_18.x = 0
				var_27_10.localEulerAngles = var_27_18
			end

			local var_27_19 = arg_24_1.actors_["3008ui_story"].transform
			local var_27_20 = 0

			if var_27_20 < arg_24_1.time_ and arg_24_1.time_ <= var_27_20 + arg_27_0 then
				arg_24_1.var_.moveOldPos3008ui_story = var_27_19.localPosition
			end

			local var_27_21 = 0.001

			if var_27_20 <= arg_24_1.time_ and arg_24_1.time_ < var_27_20 + var_27_21 then
				local var_27_22 = (arg_24_1.time_ - var_27_20) / var_27_21
				local var_27_23 = Vector3.New(0, -1.51, -4.3)

				var_27_19.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos3008ui_story, var_27_23, var_27_22)

				local var_27_24 = manager.ui.mainCamera.transform.position - var_27_19.position

				var_27_19.forward = Vector3.New(var_27_24.x, var_27_24.y, var_27_24.z)

				local var_27_25 = var_27_19.localEulerAngles

				var_27_25.z = 0
				var_27_25.x = 0
				var_27_19.localEulerAngles = var_27_25
			end

			if arg_24_1.time_ >= var_27_20 + var_27_21 and arg_24_1.time_ < var_27_20 + var_27_21 + arg_27_0 then
				var_27_19.localPosition = Vector3.New(0, -1.51, -4.3)

				local var_27_26 = manager.ui.mainCamera.transform.position - var_27_19.position

				var_27_19.forward = Vector3.New(var_27_26.x, var_27_26.y, var_27_26.z)

				local var_27_27 = var_27_19.localEulerAngles

				var_27_27.z = 0
				var_27_27.x = 0
				var_27_19.localEulerAngles = var_27_27
			end

			local var_27_28 = 0

			if var_27_28 < arg_24_1.time_ and arg_24_1.time_ <= var_27_28 + arg_27_0 then
				arg_24_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action7_1")
			end

			local var_27_29 = 0

			if var_27_29 < arg_24_1.time_ and arg_24_1.time_ <= var_27_29 + arg_27_0 then
				arg_24_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_27_30 = 0
			local var_27_31 = 0.55

			if var_27_30 < arg_24_1.time_ and arg_24_1.time_ <= var_27_30 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_32 = arg_24_1:FormatText(StoryNameCfg[20].name)

				arg_24_1.leftNameTxt_.text = var_27_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_33 = arg_24_1:GetWordFromCfg(102111006)
				local var_27_34 = arg_24_1:FormatText(var_27_33.content)

				arg_24_1.text_.text = var_27_34

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_35 = 22
				local var_27_36 = utf8.len(var_27_34)
				local var_27_37 = var_27_35 <= 0 and var_27_31 or var_27_31 * (var_27_36 / var_27_35)

				if var_27_37 > 0 and var_27_31 < var_27_37 then
					arg_24_1.talkMaxDuration = var_27_37

					if var_27_37 + var_27_30 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_37 + var_27_30
					end
				end

				arg_24_1.text_.text = var_27_34
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111006", "story_v_out_102111.awb") ~= 0 then
					local var_27_38 = manager.audio:GetVoiceLength("story_v_out_102111", "102111006", "story_v_out_102111.awb") / 1000

					if var_27_38 + var_27_30 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_38 + var_27_30
					end

					if var_27_33.prefab_name ~= "" and arg_24_1.actors_[var_27_33.prefab_name] ~= nil then
						local var_27_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_33.prefab_name].transform, "story_v_out_102111", "102111006", "story_v_out_102111.awb")

						arg_24_1:RecordAudio("102111006", var_27_39)
						arg_24_1:RecordAudio("102111006", var_27_39)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_102111", "102111006", "story_v_out_102111.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_102111", "102111006", "story_v_out_102111.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_40 = math.max(var_27_31, arg_24_1.talkMaxDuration)

			if var_27_30 <= arg_24_1.time_ and arg_24_1.time_ < var_27_30 + var_27_40 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_30) / var_27_40

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_30 + var_27_40 and arg_24_1.time_ < var_27_30 + var_27_40 + arg_27_0 then
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
				actorName = "3008ui_story",
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
	Play102111007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 102111007
		arg_28_1.duration_ = 7

		local var_28_0 = {
			ja = 6.6,
			ko = 4.233,
			zh = 5.4,
			en = 7
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
				arg_28_0:Play102111008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1011ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1011ui_story == nil then
				arg_28_1.var_.characterEffect1011ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1011ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1011ui_story then
				arg_28_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_31_4 = arg_28_1.actors_["3008ui_story"]
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect3008ui_story == nil then
				arg_28_1.var_.characterEffect3008ui_story = var_31_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.1

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 and not isNil(var_31_4) then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6

				if arg_28_1.var_.characterEffect3008ui_story and not isNil(var_31_4) then
					local var_31_8 = Mathf.Lerp(0, 0.5, var_31_7)

					arg_28_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_28_1.var_.characterEffect3008ui_story.fillRatio = var_31_8
				end
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect3008ui_story then
				local var_31_9 = 0.5

				arg_28_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_28_1.var_.characterEffect3008ui_story.fillRatio = var_31_9
			end

			local var_31_10 = arg_28_1.actors_["3008ui_story"].transform
			local var_31_11 = 0

			if var_31_11 < arg_28_1.time_ and arg_28_1.time_ <= var_31_11 + arg_31_0 then
				arg_28_1.var_.moveOldPos3008ui_story = var_31_10.localPosition
			end

			local var_31_12 = 0.001

			if var_31_11 <= arg_28_1.time_ and arg_28_1.time_ < var_31_11 + var_31_12 then
				local var_31_13 = (arg_28_1.time_ - var_31_11) / var_31_12
				local var_31_14 = Vector3.New(0, 100, 0)

				var_31_10.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos3008ui_story, var_31_14, var_31_13)

				local var_31_15 = manager.ui.mainCamera.transform.position - var_31_10.position

				var_31_10.forward = Vector3.New(var_31_15.x, var_31_15.y, var_31_15.z)

				local var_31_16 = var_31_10.localEulerAngles

				var_31_16.z = 0
				var_31_16.x = 0
				var_31_10.localEulerAngles = var_31_16
			end

			if arg_28_1.time_ >= var_31_11 + var_31_12 and arg_28_1.time_ < var_31_11 + var_31_12 + arg_31_0 then
				var_31_10.localPosition = Vector3.New(0, 100, 0)

				local var_31_17 = manager.ui.mainCamera.transform.position - var_31_10.position

				var_31_10.forward = Vector3.New(var_31_17.x, var_31_17.y, var_31_17.z)

				local var_31_18 = var_31_10.localEulerAngles

				var_31_18.z = 0
				var_31_18.x = 0
				var_31_10.localEulerAngles = var_31_18
			end

			local var_31_19 = 0

			if var_31_19 < arg_28_1.time_ and arg_28_1.time_ <= var_31_19 + arg_31_0 then
				arg_28_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_31_20 = arg_28_1.actors_["1011ui_story"].transform
			local var_31_21 = 0

			if var_31_21 < arg_28_1.time_ and arg_28_1.time_ <= var_31_21 + arg_31_0 then
				arg_28_1.var_.moveOldPos1011ui_story = var_31_20.localPosition
			end

			local var_31_22 = 0.001

			if var_31_21 <= arg_28_1.time_ and arg_28_1.time_ < var_31_21 + var_31_22 then
				local var_31_23 = (arg_28_1.time_ - var_31_21) / var_31_22
				local var_31_24 = Vector3.New(-0.7, -0.71, -6)

				var_31_20.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1011ui_story, var_31_24, var_31_23)

				local var_31_25 = manager.ui.mainCamera.transform.position - var_31_20.position

				var_31_20.forward = Vector3.New(var_31_25.x, var_31_25.y, var_31_25.z)

				local var_31_26 = var_31_20.localEulerAngles

				var_31_26.z = 0
				var_31_26.x = 0
				var_31_20.localEulerAngles = var_31_26
			end

			if arg_28_1.time_ >= var_31_21 + var_31_22 and arg_28_1.time_ < var_31_21 + var_31_22 + arg_31_0 then
				var_31_20.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_31_27 = manager.ui.mainCamera.transform.position - var_31_20.position

				var_31_20.forward = Vector3.New(var_31_27.x, var_31_27.y, var_31_27.z)

				local var_31_28 = var_31_20.localEulerAngles

				var_31_28.z = 0
				var_31_28.x = 0
				var_31_20.localEulerAngles = var_31_28
			end

			local var_31_29 = 0

			if var_31_29 < arg_28_1.time_ and arg_28_1.time_ <= var_31_29 + arg_31_0 then
				arg_28_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_31_30 = 0
			local var_31_31 = 0.575

			if var_31_30 < arg_28_1.time_ and arg_28_1.time_ <= var_31_30 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_32 = arg_28_1:FormatText(StoryNameCfg[37].name)

				arg_28_1.leftNameTxt_.text = var_31_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_33 = arg_28_1:GetWordFromCfg(102111007)
				local var_31_34 = arg_28_1:FormatText(var_31_33.content)

				arg_28_1.text_.text = var_31_34

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_35 = 23
				local var_31_36 = utf8.len(var_31_34)
				local var_31_37 = var_31_35 <= 0 and var_31_31 or var_31_31 * (var_31_36 / var_31_35)

				if var_31_37 > 0 and var_31_31 < var_31_37 then
					arg_28_1.talkMaxDuration = var_31_37

					if var_31_37 + var_31_30 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_37 + var_31_30
					end
				end

				arg_28_1.text_.text = var_31_34
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111007", "story_v_out_102111.awb") ~= 0 then
					local var_31_38 = manager.audio:GetVoiceLength("story_v_out_102111", "102111007", "story_v_out_102111.awb") / 1000

					if var_31_38 + var_31_30 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_38 + var_31_30
					end

					if var_31_33.prefab_name ~= "" and arg_28_1.actors_[var_31_33.prefab_name] ~= nil then
						local var_31_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_33.prefab_name].transform, "story_v_out_102111", "102111007", "story_v_out_102111.awb")

						arg_28_1:RecordAudio("102111007", var_31_39)
						arg_28_1:RecordAudio("102111007", var_31_39)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_102111", "102111007", "story_v_out_102111.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_102111", "102111007", "story_v_out_102111.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_40 = math.max(var_31_31, arg_28_1.talkMaxDuration)

			if var_31_30 <= arg_28_1.time_ and arg_28_1.time_ < var_31_30 + var_31_40 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_30) / var_31_40

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_30 + var_31_40 and arg_28_1.time_ < var_31_30 + var_31_40 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
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

		arg_28_1:InitPlayNodeList()
	end,
	Play102111008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 102111008
		arg_32_1.duration_ = 2.57

		local var_32_0 = {
			ja = 2.566,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_32_0:Play102111009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = "1019ui_story"

			if arg_32_1.actors_[var_35_0] == nil then
				local var_35_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_35_1) then
					local var_35_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_32_1.stage_.transform)

					var_35_2.name = var_35_0
					var_35_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_32_1.actors_[var_35_0] = var_35_2

					local var_35_3 = var_35_2:GetComponentInChildren(typeof(CharacterEffect))

					var_35_3.enabled = true

					local var_35_4 = GameObjectTools.GetOrAddComponent(var_35_2, typeof(DynamicBoneHelper))

					if var_35_4 then
						var_35_4:EnableDynamicBone(false)
					end

					arg_32_1:ShowWeapon(var_35_3.transform, false)

					arg_32_1.var_[var_35_0 .. "Animator"] = var_35_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_32_1.var_[var_35_0 .. "Animator"].applyRootMotion = true
					arg_32_1.var_[var_35_0 .. "LipSync"] = var_35_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_35_5 = arg_32_1.actors_["1019ui_story"]
			local var_35_6 = 0

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect1019ui_story == nil then
				arg_32_1.var_.characterEffect1019ui_story = var_35_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_7 = 0.1

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_7 and not isNil(var_35_5) then
				local var_35_8 = (arg_32_1.time_ - var_35_6) / var_35_7

				if arg_32_1.var_.characterEffect1019ui_story and not isNil(var_35_5) then
					arg_32_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_6 + var_35_7 and arg_32_1.time_ < var_35_6 + var_35_7 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect1019ui_story then
				arg_32_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_35_9 = arg_32_1.actors_["1011ui_story"]
			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 and not isNil(var_35_9) and arg_32_1.var_.characterEffect1011ui_story == nil then
				arg_32_1.var_.characterEffect1011ui_story = var_35_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_11 = 0.1

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_11 and not isNil(var_35_9) then
				local var_35_12 = (arg_32_1.time_ - var_35_10) / var_35_11

				if arg_32_1.var_.characterEffect1011ui_story and not isNil(var_35_9) then
					local var_35_13 = Mathf.Lerp(0, 0.5, var_35_12)

					arg_32_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1011ui_story.fillRatio = var_35_13
				end
			end

			if arg_32_1.time_ >= var_35_10 + var_35_11 and arg_32_1.time_ < var_35_10 + var_35_11 + arg_35_0 and not isNil(var_35_9) and arg_32_1.var_.characterEffect1011ui_story then
				local var_35_14 = 0.5

				arg_32_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1011ui_story.fillRatio = var_35_14
			end

			local var_35_15 = arg_32_1.actors_["1019ui_story"].transform
			local var_35_16 = 0

			if var_35_16 < arg_32_1.time_ and arg_32_1.time_ <= var_35_16 + arg_35_0 then
				arg_32_1.var_.moveOldPos1019ui_story = var_35_15.localPosition
			end

			local var_35_17 = 0.001

			if var_35_16 <= arg_32_1.time_ and arg_32_1.time_ < var_35_16 + var_35_17 then
				local var_35_18 = (arg_32_1.time_ - var_35_16) / var_35_17
				local var_35_19 = Vector3.New(0.7, -1.08, -5.9)

				var_35_15.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1019ui_story, var_35_19, var_35_18)

				local var_35_20 = manager.ui.mainCamera.transform.position - var_35_15.position

				var_35_15.forward = Vector3.New(var_35_20.x, var_35_20.y, var_35_20.z)

				local var_35_21 = var_35_15.localEulerAngles

				var_35_21.z = 0
				var_35_21.x = 0
				var_35_15.localEulerAngles = var_35_21
			end

			if arg_32_1.time_ >= var_35_16 + var_35_17 and arg_32_1.time_ < var_35_16 + var_35_17 + arg_35_0 then
				var_35_15.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_35_22 = manager.ui.mainCamera.transform.position - var_35_15.position

				var_35_15.forward = Vector3.New(var_35_22.x, var_35_22.y, var_35_22.z)

				local var_35_23 = var_35_15.localEulerAngles

				var_35_23.z = 0
				var_35_23.x = 0
				var_35_15.localEulerAngles = var_35_23
			end

			local var_35_24 = 0

			if var_35_24 < arg_32_1.time_ and arg_32_1.time_ <= var_35_24 + arg_35_0 then
				arg_32_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_35_25 = 0

			if var_35_25 < arg_32_1.time_ and arg_32_1.time_ <= var_35_25 + arg_35_0 then
				arg_32_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_35_26 = 0
			local var_35_27 = 0.175

			if var_35_26 < arg_32_1.time_ and arg_32_1.time_ <= var_35_26 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_28 = arg_32_1:FormatText(StoryNameCfg[13].name)

				arg_32_1.leftNameTxt_.text = var_35_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_29 = arg_32_1:GetWordFromCfg(102111008)
				local var_35_30 = arg_32_1:FormatText(var_35_29.content)

				arg_32_1.text_.text = var_35_30

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_31 = 7
				local var_35_32 = utf8.len(var_35_30)
				local var_35_33 = var_35_31 <= 0 and var_35_27 or var_35_27 * (var_35_32 / var_35_31)

				if var_35_33 > 0 and var_35_27 < var_35_33 then
					arg_32_1.talkMaxDuration = var_35_33

					if var_35_33 + var_35_26 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_33 + var_35_26
					end
				end

				arg_32_1.text_.text = var_35_30
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111008", "story_v_out_102111.awb") ~= 0 then
					local var_35_34 = manager.audio:GetVoiceLength("story_v_out_102111", "102111008", "story_v_out_102111.awb") / 1000

					if var_35_34 + var_35_26 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_34 + var_35_26
					end

					if var_35_29.prefab_name ~= "" and arg_32_1.actors_[var_35_29.prefab_name] ~= nil then
						local var_35_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_29.prefab_name].transform, "story_v_out_102111", "102111008", "story_v_out_102111.awb")

						arg_32_1:RecordAudio("102111008", var_35_35)
						arg_32_1:RecordAudio("102111008", var_35_35)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_102111", "102111008", "story_v_out_102111.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_102111", "102111008", "story_v_out_102111.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_36 = math.max(var_35_27, arg_32_1.talkMaxDuration)

			if var_35_26 <= arg_32_1.time_ and arg_32_1.time_ < var_35_26 + var_35_36 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_26) / var_35_36

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_26 + var_35_36 and arg_32_1.time_ < var_35_26 + var_35_36 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
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

		arg_32_1:InitPlayNodeList()
	end,
	Play102111009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 102111009
		arg_36_1.duration_ = 3.07

		local var_36_0 = {
			ja = 3.066,
			ko = 2.4,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_36_0:Play102111010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1084ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1084ui_story == nil then
				arg_36_1.var_.characterEffect1084ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.1

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1084ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1084ui_story then
				arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["1019ui_story"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1019ui_story == nil then
				arg_36_1.var_.characterEffect1019ui_story = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.1

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect1019ui_story and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1019ui_story.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1019ui_story then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1019ui_story.fillRatio = var_39_9
			end

			local var_39_10 = arg_36_1.actors_["1019ui_story"].transform
			local var_39_11 = 0

			if var_39_11 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1.var_.moveOldPos1019ui_story = var_39_10.localPosition
			end

			local var_39_12 = 0.001

			if var_39_11 <= arg_36_1.time_ and arg_36_1.time_ < var_39_11 + var_39_12 then
				local var_39_13 = (arg_36_1.time_ - var_39_11) / var_39_12
				local var_39_14 = Vector3.New(0, 100, 0)

				var_39_10.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1019ui_story, var_39_14, var_39_13)

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
				local var_39_23 = Vector3.New(0, 100, 0)

				var_39_19.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1011ui_story, var_39_23, var_39_22)

				local var_39_24 = manager.ui.mainCamera.transform.position - var_39_19.position

				var_39_19.forward = Vector3.New(var_39_24.x, var_39_24.y, var_39_24.z)

				local var_39_25 = var_39_19.localEulerAngles

				var_39_25.z = 0
				var_39_25.x = 0
				var_39_19.localEulerAngles = var_39_25
			end

			if arg_36_1.time_ >= var_39_20 + var_39_21 and arg_36_1.time_ < var_39_20 + var_39_21 + arg_39_0 then
				var_39_19.localPosition = Vector3.New(0, 100, 0)

				local var_39_26 = manager.ui.mainCamera.transform.position - var_39_19.position

				var_39_19.forward = Vector3.New(var_39_26.x, var_39_26.y, var_39_26.z)

				local var_39_27 = var_39_19.localEulerAngles

				var_39_27.z = 0
				var_39_27.x = 0
				var_39_19.localEulerAngles = var_39_27
			end

			local var_39_28 = arg_36_1.actors_["1084ui_story"].transform
			local var_39_29 = 0

			if var_39_29 < arg_36_1.time_ and arg_36_1.time_ <= var_39_29 + arg_39_0 then
				arg_36_1.var_.moveOldPos1084ui_story = var_39_28.localPosition
			end

			local var_39_30 = 0.001

			if var_39_29 <= arg_36_1.time_ and arg_36_1.time_ < var_39_29 + var_39_30 then
				local var_39_31 = (arg_36_1.time_ - var_39_29) / var_39_30
				local var_39_32 = Vector3.New(0, -0.97, -6)

				var_39_28.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1084ui_story, var_39_32, var_39_31)

				local var_39_33 = manager.ui.mainCamera.transform.position - var_39_28.position

				var_39_28.forward = Vector3.New(var_39_33.x, var_39_33.y, var_39_33.z)

				local var_39_34 = var_39_28.localEulerAngles

				var_39_34.z = 0
				var_39_34.x = 0
				var_39_28.localEulerAngles = var_39_34
			end

			if arg_36_1.time_ >= var_39_29 + var_39_30 and arg_36_1.time_ < var_39_29 + var_39_30 + arg_39_0 then
				var_39_28.localPosition = Vector3.New(0, -0.97, -6)

				local var_39_35 = manager.ui.mainCamera.transform.position - var_39_28.position

				var_39_28.forward = Vector3.New(var_39_35.x, var_39_35.y, var_39_35.z)

				local var_39_36 = var_39_28.localEulerAngles

				var_39_36.z = 0
				var_39_36.x = 0
				var_39_28.localEulerAngles = var_39_36
			end

			local var_39_37 = 0

			if var_39_37 < arg_36_1.time_ and arg_36_1.time_ <= var_39_37 + arg_39_0 then
				arg_36_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_39_38 = 0

			if var_39_38 < arg_36_1.time_ and arg_36_1.time_ <= var_39_38 + arg_39_0 then
				arg_36_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_39_39 = 0
			local var_39_40 = 0.175

			if var_39_39 < arg_36_1.time_ and arg_36_1.time_ <= var_39_39 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_41 = arg_36_1:FormatText(StoryNameCfg[6].name)

				arg_36_1.leftNameTxt_.text = var_39_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_42 = arg_36_1:GetWordFromCfg(102111009)
				local var_39_43 = arg_36_1:FormatText(var_39_42.content)

				arg_36_1.text_.text = var_39_43

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_44 = 7
				local var_39_45 = utf8.len(var_39_43)
				local var_39_46 = var_39_44 <= 0 and var_39_40 or var_39_40 * (var_39_45 / var_39_44)

				if var_39_46 > 0 and var_39_40 < var_39_46 then
					arg_36_1.talkMaxDuration = var_39_46

					if var_39_46 + var_39_39 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_46 + var_39_39
					end
				end

				arg_36_1.text_.text = var_39_43
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111009", "story_v_out_102111.awb") ~= 0 then
					local var_39_47 = manager.audio:GetVoiceLength("story_v_out_102111", "102111009", "story_v_out_102111.awb") / 1000

					if var_39_47 + var_39_39 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_47 + var_39_39
					end

					if var_39_42.prefab_name ~= "" and arg_36_1.actors_[var_39_42.prefab_name] ~= nil then
						local var_39_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_42.prefab_name].transform, "story_v_out_102111", "102111009", "story_v_out_102111.awb")

						arg_36_1:RecordAudio("102111009", var_39_48)
						arg_36_1:RecordAudio("102111009", var_39_48)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_102111", "102111009", "story_v_out_102111.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_102111", "102111009", "story_v_out_102111.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_49 = math.max(var_39_40, arg_36_1.talkMaxDuration)

			if var_39_39 <= arg_36_1.time_ and arg_36_1.time_ < var_39_39 + var_39_49 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_39) / var_39_49

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_39 + var_39_49 and arg_36_1.time_ < var_39_39 + var_39_49 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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
				actorName = "1084ui_story",
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
	Play102111010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 102111010
		arg_40_1.duration_ = 4.97

		local var_40_0 = {
			ja = 2.633,
			ko = 3.433,
			zh = 3.8,
			en = 4.966
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
				arg_40_0:Play102111011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1011ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1011ui_story == nil then
				arg_40_1.var_.characterEffect1011ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1011ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1011ui_story then
				arg_40_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_43_4 = arg_40_1.actors_["1084ui_story"]
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = var_43_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.1

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 and not isNil(var_43_4) then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6

				if arg_40_1.var_.characterEffect1084ui_story and not isNil(var_43_4) then
					local var_43_8 = Mathf.Lerp(0, 0.5, var_43_7)

					arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1084ui_story.fillRatio = var_43_8
				end
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1084ui_story then
				local var_43_9 = 0.5

				arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1084ui_story.fillRatio = var_43_9
			end

			local var_43_10 = arg_40_1.actors_["1084ui_story"].transform
			local var_43_11 = 0

			if var_43_11 < arg_40_1.time_ and arg_40_1.time_ <= var_43_11 + arg_43_0 then
				arg_40_1.var_.moveOldPos1084ui_story = var_43_10.localPosition
			end

			local var_43_12 = 0.001

			if var_43_11 <= arg_40_1.time_ and arg_40_1.time_ < var_43_11 + var_43_12 then
				local var_43_13 = (arg_40_1.time_ - var_43_11) / var_43_12
				local var_43_14 = Vector3.New(0, 100, 0)

				var_43_10.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1084ui_story, var_43_14, var_43_13)

				local var_43_15 = manager.ui.mainCamera.transform.position - var_43_10.position

				var_43_10.forward = Vector3.New(var_43_15.x, var_43_15.y, var_43_15.z)

				local var_43_16 = var_43_10.localEulerAngles

				var_43_16.z = 0
				var_43_16.x = 0
				var_43_10.localEulerAngles = var_43_16
			end

			if arg_40_1.time_ >= var_43_11 + var_43_12 and arg_40_1.time_ < var_43_11 + var_43_12 + arg_43_0 then
				var_43_10.localPosition = Vector3.New(0, 100, 0)

				local var_43_17 = manager.ui.mainCamera.transform.position - var_43_10.position

				var_43_10.forward = Vector3.New(var_43_17.x, var_43_17.y, var_43_17.z)

				local var_43_18 = var_43_10.localEulerAngles

				var_43_18.z = 0
				var_43_18.x = 0
				var_43_10.localEulerAngles = var_43_18
			end

			local var_43_19 = arg_40_1.actors_["1011ui_story"].transform
			local var_43_20 = 0

			if var_43_20 < arg_40_1.time_ and arg_40_1.time_ <= var_43_20 + arg_43_0 then
				arg_40_1.var_.moveOldPos1011ui_story = var_43_19.localPosition
			end

			local var_43_21 = 0.001

			if var_43_20 <= arg_40_1.time_ and arg_40_1.time_ < var_43_20 + var_43_21 then
				local var_43_22 = (arg_40_1.time_ - var_43_20) / var_43_21
				local var_43_23 = Vector3.New(-0.7, -0.71, -6)

				var_43_19.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1011ui_story, var_43_23, var_43_22)

				local var_43_24 = manager.ui.mainCamera.transform.position - var_43_19.position

				var_43_19.forward = Vector3.New(var_43_24.x, var_43_24.y, var_43_24.z)

				local var_43_25 = var_43_19.localEulerAngles

				var_43_25.z = 0
				var_43_25.x = 0
				var_43_19.localEulerAngles = var_43_25
			end

			if arg_40_1.time_ >= var_43_20 + var_43_21 and arg_40_1.time_ < var_43_20 + var_43_21 + arg_43_0 then
				var_43_19.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_43_26 = manager.ui.mainCamera.transform.position - var_43_19.position

				var_43_19.forward = Vector3.New(var_43_26.x, var_43_26.y, var_43_26.z)

				local var_43_27 = var_43_19.localEulerAngles

				var_43_27.z = 0
				var_43_27.x = 0
				var_43_19.localEulerAngles = var_43_27
			end

			local var_43_28 = 0

			if var_43_28 < arg_40_1.time_ and arg_40_1.time_ <= var_43_28 + arg_43_0 then
				arg_40_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_43_29 = 0

			if var_43_29 < arg_40_1.time_ and arg_40_1.time_ <= var_43_29 + arg_43_0 then
				arg_40_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_43_30 = 0
			local var_43_31 = 0.55

			if var_43_30 < arg_40_1.time_ and arg_40_1.time_ <= var_43_30 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_32 = arg_40_1:FormatText(StoryNameCfg[37].name)

				arg_40_1.leftNameTxt_.text = var_43_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_33 = arg_40_1:GetWordFromCfg(102111010)
				local var_43_34 = arg_40_1:FormatText(var_43_33.content)

				arg_40_1.text_.text = var_43_34

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_35 = 22
				local var_43_36 = utf8.len(var_43_34)
				local var_43_37 = var_43_35 <= 0 and var_43_31 or var_43_31 * (var_43_36 / var_43_35)

				if var_43_37 > 0 and var_43_31 < var_43_37 then
					arg_40_1.talkMaxDuration = var_43_37

					if var_43_37 + var_43_30 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_37 + var_43_30
					end
				end

				arg_40_1.text_.text = var_43_34
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111010", "story_v_out_102111.awb") ~= 0 then
					local var_43_38 = manager.audio:GetVoiceLength("story_v_out_102111", "102111010", "story_v_out_102111.awb") / 1000

					if var_43_38 + var_43_30 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_38 + var_43_30
					end

					if var_43_33.prefab_name ~= "" and arg_40_1.actors_[var_43_33.prefab_name] ~= nil then
						local var_43_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_33.prefab_name].transform, "story_v_out_102111", "102111010", "story_v_out_102111.awb")

						arg_40_1:RecordAudio("102111010", var_43_39)
						arg_40_1:RecordAudio("102111010", var_43_39)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_102111", "102111010", "story_v_out_102111.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_102111", "102111010", "story_v_out_102111.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_40 = math.max(var_43_31, arg_40_1.talkMaxDuration)

			if var_43_30 <= arg_40_1.time_ and arg_40_1.time_ < var_43_30 + var_43_40 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_30) / var_43_40

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_30 + var_43_40 and arg_40_1.time_ < var_43_30 + var_43_40 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
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
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play102111011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 102111011
		arg_44_1.duration_ = 7.9

		local var_44_0 = {
			ja = 7.9,
			ko = 3.833,
			zh = 3.5,
			en = 3.633
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
				arg_44_0:Play102111012(arg_44_1)
			end
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

			local var_47_10 = arg_44_1.actors_["1019ui_story"].transform
			local var_47_11 = 0

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1.var_.moveOldPos1019ui_story = var_47_10.localPosition
			end

			local var_47_12 = 0.001

			if var_47_11 <= arg_44_1.time_ and arg_44_1.time_ < var_47_11 + var_47_12 then
				local var_47_13 = (arg_44_1.time_ - var_47_11) / var_47_12
				local var_47_14 = Vector3.New(0.7, -1.08, -5.9)

				var_47_10.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1019ui_story, var_47_14, var_47_13)

				local var_47_15 = manager.ui.mainCamera.transform.position - var_47_10.position

				var_47_10.forward = Vector3.New(var_47_15.x, var_47_15.y, var_47_15.z)

				local var_47_16 = var_47_10.localEulerAngles

				var_47_16.z = 0
				var_47_16.x = 0
				var_47_10.localEulerAngles = var_47_16
			end

			if arg_44_1.time_ >= var_47_11 + var_47_12 and arg_44_1.time_ < var_47_11 + var_47_12 + arg_47_0 then
				var_47_10.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_47_17 = manager.ui.mainCamera.transform.position - var_47_10.position

				var_47_10.forward = Vector3.New(var_47_17.x, var_47_17.y, var_47_17.z)

				local var_47_18 = var_47_10.localEulerAngles

				var_47_18.z = 0
				var_47_18.x = 0
				var_47_10.localEulerAngles = var_47_18
			end

			local var_47_19 = 0

			if var_47_19 < arg_44_1.time_ and arg_44_1.time_ <= var_47_19 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_47_20 = 0

			if var_47_20 < arg_44_1.time_ and arg_44_1.time_ <= var_47_20 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_47_21 = 0
			local var_47_22 = 0.475

			if var_47_21 < arg_44_1.time_ and arg_44_1.time_ <= var_47_21 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_23 = arg_44_1:FormatText(StoryNameCfg[13].name)

				arg_44_1.leftNameTxt_.text = var_47_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_24 = arg_44_1:GetWordFromCfg(102111011)
				local var_47_25 = arg_44_1:FormatText(var_47_24.content)

				arg_44_1.text_.text = var_47_25

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_26 = 19
				local var_47_27 = utf8.len(var_47_25)
				local var_47_28 = var_47_26 <= 0 and var_47_22 or var_47_22 * (var_47_27 / var_47_26)

				if var_47_28 > 0 and var_47_22 < var_47_28 then
					arg_44_1.talkMaxDuration = var_47_28

					if var_47_28 + var_47_21 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_28 + var_47_21
					end
				end

				arg_44_1.text_.text = var_47_25
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111011", "story_v_out_102111.awb") ~= 0 then
					local var_47_29 = manager.audio:GetVoiceLength("story_v_out_102111", "102111011", "story_v_out_102111.awb") / 1000

					if var_47_29 + var_47_21 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_29 + var_47_21
					end

					if var_47_24.prefab_name ~= "" and arg_44_1.actors_[var_47_24.prefab_name] ~= nil then
						local var_47_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_24.prefab_name].transform, "story_v_out_102111", "102111011", "story_v_out_102111.awb")

						arg_44_1:RecordAudio("102111011", var_47_30)
						arg_44_1:RecordAudio("102111011", var_47_30)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_102111", "102111011", "story_v_out_102111.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_102111", "102111011", "story_v_out_102111.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_31 = math.max(var_47_22, arg_44_1.talkMaxDuration)

			if var_47_21 <= arg_44_1.time_ and arg_44_1.time_ < var_47_21 + var_47_31 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_21) / var_47_31

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_21 + var_47_31 and arg_44_1.time_ < var_47_21 + var_47_31 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
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
	Play102111012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 102111012
		arg_48_1.duration_ = 7.47

		local var_48_0 = {
			ja = 7.466,
			ko = 3.533,
			zh = 3.166,
			en = 4.166
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
				arg_48_0:Play102111013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["3008ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect3008ui_story == nil then
				arg_48_1.var_.characterEffect3008ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect3008ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect3008ui_story then
				arg_48_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["1019ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1019ui_story == nil then
				arg_48_1.var_.characterEffect1019ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.1

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect1019ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1019ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1019ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1019ui_story.fillRatio = var_51_9
			end

			local var_51_10 = arg_48_1.actors_["1019ui_story"].transform
			local var_51_11 = 0

			if var_51_11 < arg_48_1.time_ and arg_48_1.time_ <= var_51_11 + arg_51_0 then
				arg_48_1.var_.moveOldPos1019ui_story = var_51_10.localPosition
			end

			local var_51_12 = 0.001

			if var_51_11 <= arg_48_1.time_ and arg_48_1.time_ < var_51_11 + var_51_12 then
				local var_51_13 = (arg_48_1.time_ - var_51_11) / var_51_12
				local var_51_14 = Vector3.New(0, 100, 0)

				var_51_10.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1019ui_story, var_51_14, var_51_13)

				local var_51_15 = manager.ui.mainCamera.transform.position - var_51_10.position

				var_51_10.forward = Vector3.New(var_51_15.x, var_51_15.y, var_51_15.z)

				local var_51_16 = var_51_10.localEulerAngles

				var_51_16.z = 0
				var_51_16.x = 0
				var_51_10.localEulerAngles = var_51_16
			end

			if arg_48_1.time_ >= var_51_11 + var_51_12 and arg_48_1.time_ < var_51_11 + var_51_12 + arg_51_0 then
				var_51_10.localPosition = Vector3.New(0, 100, 0)

				local var_51_17 = manager.ui.mainCamera.transform.position - var_51_10.position

				var_51_10.forward = Vector3.New(var_51_17.x, var_51_17.y, var_51_17.z)

				local var_51_18 = var_51_10.localEulerAngles

				var_51_18.z = 0
				var_51_18.x = 0
				var_51_10.localEulerAngles = var_51_18
			end

			local var_51_19 = arg_48_1.actors_["1011ui_story"].transform
			local var_51_20 = 0

			if var_51_20 < arg_48_1.time_ and arg_48_1.time_ <= var_51_20 + arg_51_0 then
				arg_48_1.var_.moveOldPos1011ui_story = var_51_19.localPosition
			end

			local var_51_21 = 0.001

			if var_51_20 <= arg_48_1.time_ and arg_48_1.time_ < var_51_20 + var_51_21 then
				local var_51_22 = (arg_48_1.time_ - var_51_20) / var_51_21
				local var_51_23 = Vector3.New(0, 100, 0)

				var_51_19.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1011ui_story, var_51_23, var_51_22)

				local var_51_24 = manager.ui.mainCamera.transform.position - var_51_19.position

				var_51_19.forward = Vector3.New(var_51_24.x, var_51_24.y, var_51_24.z)

				local var_51_25 = var_51_19.localEulerAngles

				var_51_25.z = 0
				var_51_25.x = 0
				var_51_19.localEulerAngles = var_51_25
			end

			if arg_48_1.time_ >= var_51_20 + var_51_21 and arg_48_1.time_ < var_51_20 + var_51_21 + arg_51_0 then
				var_51_19.localPosition = Vector3.New(0, 100, 0)

				local var_51_26 = manager.ui.mainCamera.transform.position - var_51_19.position

				var_51_19.forward = Vector3.New(var_51_26.x, var_51_26.y, var_51_26.z)

				local var_51_27 = var_51_19.localEulerAngles

				var_51_27.z = 0
				var_51_27.x = 0
				var_51_19.localEulerAngles = var_51_27
			end

			local var_51_28 = arg_48_1.actors_["3008ui_story"].transform
			local var_51_29 = 0

			if var_51_29 < arg_48_1.time_ and arg_48_1.time_ <= var_51_29 + arg_51_0 then
				arg_48_1.var_.moveOldPos3008ui_story = var_51_28.localPosition
			end

			local var_51_30 = 0.001

			if var_51_29 <= arg_48_1.time_ and arg_48_1.time_ < var_51_29 + var_51_30 then
				local var_51_31 = (arg_48_1.time_ - var_51_29) / var_51_30
				local var_51_32 = Vector3.New(0, -1.51, -4.3)

				var_51_28.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos3008ui_story, var_51_32, var_51_31)

				local var_51_33 = manager.ui.mainCamera.transform.position - var_51_28.position

				var_51_28.forward = Vector3.New(var_51_33.x, var_51_33.y, var_51_33.z)

				local var_51_34 = var_51_28.localEulerAngles

				var_51_34.z = 0
				var_51_34.x = 0
				var_51_28.localEulerAngles = var_51_34
			end

			if arg_48_1.time_ >= var_51_29 + var_51_30 and arg_48_1.time_ < var_51_29 + var_51_30 + arg_51_0 then
				var_51_28.localPosition = Vector3.New(0, -1.51, -4.3)

				local var_51_35 = manager.ui.mainCamera.transform.position - var_51_28.position

				var_51_28.forward = Vector3.New(var_51_35.x, var_51_35.y, var_51_35.z)

				local var_51_36 = var_51_28.localEulerAngles

				var_51_36.z = 0
				var_51_36.x = 0
				var_51_28.localEulerAngles = var_51_36
			end

			local var_51_37 = 0

			if var_51_37 < arg_48_1.time_ and arg_48_1.time_ <= var_51_37 + arg_51_0 then
				arg_48_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action1_1")
			end

			local var_51_38 = 0

			if var_51_38 < arg_48_1.time_ and arg_48_1.time_ <= var_51_38 + arg_51_0 then
				arg_48_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_51_39 = 0
			local var_51_40 = 0.3

			if var_51_39 < arg_48_1.time_ and arg_48_1.time_ <= var_51_39 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_41 = arg_48_1:FormatText(StoryNameCfg[20].name)

				arg_48_1.leftNameTxt_.text = var_51_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_42 = arg_48_1:GetWordFromCfg(102111012)
				local var_51_43 = arg_48_1:FormatText(var_51_42.content)

				arg_48_1.text_.text = var_51_43

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_44 = 12
				local var_51_45 = utf8.len(var_51_43)
				local var_51_46 = var_51_44 <= 0 and var_51_40 or var_51_40 * (var_51_45 / var_51_44)

				if var_51_46 > 0 and var_51_40 < var_51_46 then
					arg_48_1.talkMaxDuration = var_51_46

					if var_51_46 + var_51_39 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_46 + var_51_39
					end
				end

				arg_48_1.text_.text = var_51_43
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111012", "story_v_out_102111.awb") ~= 0 then
					local var_51_47 = manager.audio:GetVoiceLength("story_v_out_102111", "102111012", "story_v_out_102111.awb") / 1000

					if var_51_47 + var_51_39 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_47 + var_51_39
					end

					if var_51_42.prefab_name ~= "" and arg_48_1.actors_[var_51_42.prefab_name] ~= nil then
						local var_51_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_42.prefab_name].transform, "story_v_out_102111", "102111012", "story_v_out_102111.awb")

						arg_48_1:RecordAudio("102111012", var_51_48)
						arg_48_1:RecordAudio("102111012", var_51_48)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_102111", "102111012", "story_v_out_102111.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_102111", "102111012", "story_v_out_102111.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_49 = math.max(var_51_40, arg_48_1.talkMaxDuration)

			if var_51_39 <= arg_48_1.time_ and arg_48_1.time_ < var_51_39 + var_51_49 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_39) / var_51_49

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_39 + var_51_49 and arg_48_1.time_ < var_51_39 + var_51_49 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play102111013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 102111013
		arg_52_1.duration_ = 4.53

		local var_52_0 = {
			ja = 4.533,
			ko = 3.566,
			zh = 3.4,
			en = 3.266
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
				arg_52_0:Play102111014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = "2020_tpose"

			if arg_52_1.actors_[var_55_0] == nil then
				local var_55_1 = Asset.Load("Char/" .. "2020_tpose")

				if not isNil(var_55_1) then
					local var_55_2 = Object.Instantiate(Asset.Load("Char/" .. "2020_tpose"), arg_52_1.stage_.transform)

					var_55_2.name = var_55_0
					var_55_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_52_1.actors_[var_55_0] = var_55_2

					local var_55_3 = var_55_2:GetComponentInChildren(typeof(CharacterEffect))

					var_55_3.enabled = true

					local var_55_4 = GameObjectTools.GetOrAddComponent(var_55_2, typeof(DynamicBoneHelper))

					if var_55_4 then
						var_55_4:EnableDynamicBone(false)
					end

					arg_52_1:ShowWeapon(var_55_3.transform, false)

					arg_52_1.var_[var_55_0 .. "Animator"] = var_55_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_52_1.var_[var_55_0 .. "Animator"].applyRootMotion = true
					arg_52_1.var_[var_55_0 .. "LipSync"] = var_55_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_55_5 = arg_52_1.actors_["2020_tpose"]
			local var_55_6 = 0

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 and not isNil(var_55_5) and arg_52_1.var_.characterEffect2020_tpose == nil then
				arg_52_1.var_.characterEffect2020_tpose = var_55_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_7 = 0.1

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_7 and not isNil(var_55_5) then
				local var_55_8 = (arg_52_1.time_ - var_55_6) / var_55_7

				if arg_52_1.var_.characterEffect2020_tpose and not isNil(var_55_5) then
					arg_52_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_6 + var_55_7 and arg_52_1.time_ < var_55_6 + var_55_7 + arg_55_0 and not isNil(var_55_5) and arg_52_1.var_.characterEffect2020_tpose then
				arg_52_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_55_9 = arg_52_1.actors_["3008ui_story"]
			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect3008ui_story == nil then
				arg_52_1.var_.characterEffect3008ui_story = var_55_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_11 = 0.1

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_11 and not isNil(var_55_9) then
				local var_55_12 = (arg_52_1.time_ - var_55_10) / var_55_11

				if arg_52_1.var_.characterEffect3008ui_story and not isNil(var_55_9) then
					local var_55_13 = Mathf.Lerp(0, 0.5, var_55_12)

					arg_52_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_52_1.var_.characterEffect3008ui_story.fillRatio = var_55_13
				end
			end

			if arg_52_1.time_ >= var_55_10 + var_55_11 and arg_52_1.time_ < var_55_10 + var_55_11 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect3008ui_story then
				local var_55_14 = 0.5

				arg_52_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_52_1.var_.characterEffect3008ui_story.fillRatio = var_55_14
			end

			local var_55_15 = arg_52_1.actors_["3008ui_story"].transform
			local var_55_16 = 0

			if var_55_16 < arg_52_1.time_ and arg_52_1.time_ <= var_55_16 + arg_55_0 then
				arg_52_1.var_.moveOldPos3008ui_story = var_55_15.localPosition
			end

			local var_55_17 = 0.001

			if var_55_16 <= arg_52_1.time_ and arg_52_1.time_ < var_55_16 + var_55_17 then
				local var_55_18 = (arg_52_1.time_ - var_55_16) / var_55_17
				local var_55_19 = Vector3.New(0, 100, 0)

				var_55_15.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos3008ui_story, var_55_19, var_55_18)

				local var_55_20 = manager.ui.mainCamera.transform.position - var_55_15.position

				var_55_15.forward = Vector3.New(var_55_20.x, var_55_20.y, var_55_20.z)

				local var_55_21 = var_55_15.localEulerAngles

				var_55_21.z = 0
				var_55_21.x = 0
				var_55_15.localEulerAngles = var_55_21
			end

			if arg_52_1.time_ >= var_55_16 + var_55_17 and arg_52_1.time_ < var_55_16 + var_55_17 + arg_55_0 then
				var_55_15.localPosition = Vector3.New(0, 100, 0)

				local var_55_22 = manager.ui.mainCamera.transform.position - var_55_15.position

				var_55_15.forward = Vector3.New(var_55_22.x, var_55_22.y, var_55_22.z)

				local var_55_23 = var_55_15.localEulerAngles

				var_55_23.z = 0
				var_55_23.x = 0
				var_55_15.localEulerAngles = var_55_23
			end

			local var_55_24 = arg_52_1.actors_["2020_tpose"].transform
			local var_55_25 = 0

			if var_55_25 < arg_52_1.time_ and arg_52_1.time_ <= var_55_25 + arg_55_0 then
				arg_52_1.var_.moveOldPos2020_tpose = var_55_24.localPosition

				local var_55_26 = GameObjectTools.GetOrAddComponent(var_55_24.gameObject, typeof(DynamicBoneHelper))

				if var_55_26 then
					var_55_26:EnableDynamicBone(false)
				end
			end

			local var_55_27 = 0.001

			if var_55_25 <= arg_52_1.time_ and arg_52_1.time_ < var_55_25 + var_55_27 then
				local var_55_28 = (arg_52_1.time_ - var_55_25) / var_55_27
				local var_55_29 = Vector3.New(-0.7, -1.2, -4.1)

				var_55_24.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos2020_tpose, var_55_29, var_55_28)

				local var_55_30 = manager.ui.mainCamera.transform.position - var_55_24.position

				var_55_24.forward = Vector3.New(var_55_30.x, var_55_30.y, var_55_30.z)

				local var_55_31 = var_55_24.localEulerAngles

				var_55_31.z = 0
				var_55_31.x = 0
				var_55_24.localEulerAngles = var_55_31
			end

			if arg_52_1.time_ >= var_55_25 + var_55_27 and arg_52_1.time_ < var_55_25 + var_55_27 + arg_55_0 then
				var_55_24.localPosition = Vector3.New(-0.7, -1.2, -4.1)

				local var_55_32 = manager.ui.mainCamera.transform.position - var_55_24.position

				var_55_24.forward = Vector3.New(var_55_32.x, var_55_32.y, var_55_32.z)

				local var_55_33 = var_55_24.localEulerAngles

				var_55_33.z = 0
				var_55_33.x = 0
				var_55_24.localEulerAngles = var_55_33

				local var_55_34 = GameObjectTools.GetOrAddComponent(var_55_24.gameObject, typeof(DynamicBoneHelper))

				if var_55_34 then
					var_55_34:EnableDynamicBone(true)
				end
			end

			local var_55_35 = 0

			if var_55_35 < arg_52_1.time_ and arg_52_1.time_ <= var_55_35 + arg_55_0 then
				arg_52_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_55_36 = "2030_tpose"

			if arg_52_1.actors_[var_55_36] == nil then
				local var_55_37 = Asset.Load("Char/" .. "2030_tpose")

				if not isNil(var_55_37) then
					local var_55_38 = Object.Instantiate(Asset.Load("Char/" .. "2030_tpose"), arg_52_1.stage_.transform)

					var_55_38.name = var_55_36
					var_55_38.transform.localPosition = Vector3.New(0, 100, 0)
					arg_52_1.actors_[var_55_36] = var_55_38

					local var_55_39 = var_55_38:GetComponentInChildren(typeof(CharacterEffect))

					var_55_39.enabled = true

					local var_55_40 = GameObjectTools.GetOrAddComponent(var_55_38, typeof(DynamicBoneHelper))

					if var_55_40 then
						var_55_40:EnableDynamicBone(false)
					end

					arg_52_1:ShowWeapon(var_55_39.transform, false)

					arg_52_1.var_[var_55_36 .. "Animator"] = var_55_39.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_52_1.var_[var_55_36 .. "Animator"].applyRootMotion = true
					arg_52_1.var_[var_55_36 .. "LipSync"] = var_55_39.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_55_41 = arg_52_1.actors_["2030_tpose"].transform
			local var_55_42 = 0

			if var_55_42 < arg_52_1.time_ and arg_52_1.time_ <= var_55_42 + arg_55_0 then
				arg_52_1.var_.moveOldPos2030_tpose = var_55_41.localPosition

				local var_55_43 = GameObjectTools.GetOrAddComponent(var_55_41.gameObject, typeof(DynamicBoneHelper))

				if var_55_43 then
					var_55_43:EnableDynamicBone(false)
				end
			end

			local var_55_44 = 0.001

			if var_55_42 <= arg_52_1.time_ and arg_52_1.time_ < var_55_42 + var_55_44 then
				local var_55_45 = (arg_52_1.time_ - var_55_42) / var_55_44
				local var_55_46 = Vector3.New(0.7, -1.2, -4.2)

				var_55_41.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos2030_tpose, var_55_46, var_55_45)

				local var_55_47 = manager.ui.mainCamera.transform.position - var_55_41.position

				var_55_41.forward = Vector3.New(var_55_47.x, var_55_47.y, var_55_47.z)

				local var_55_48 = var_55_41.localEulerAngles

				var_55_48.z = 0
				var_55_48.x = 0
				var_55_41.localEulerAngles = var_55_48
			end

			if arg_52_1.time_ >= var_55_42 + var_55_44 and arg_52_1.time_ < var_55_42 + var_55_44 + arg_55_0 then
				var_55_41.localPosition = Vector3.New(0.7, -1.2, -4.2)

				local var_55_49 = manager.ui.mainCamera.transform.position - var_55_41.position

				var_55_41.forward = Vector3.New(var_55_49.x, var_55_49.y, var_55_49.z)

				local var_55_50 = var_55_41.localEulerAngles

				var_55_50.z = 0
				var_55_50.x = 0
				var_55_41.localEulerAngles = var_55_50

				local var_55_51 = GameObjectTools.GetOrAddComponent(var_55_41.gameObject, typeof(DynamicBoneHelper))

				if var_55_51 then
					var_55_51:EnableDynamicBone(true)
				end
			end

			local var_55_52 = 0

			if var_55_52 < arg_52_1.time_ and arg_52_1.time_ <= var_55_52 + arg_55_0 then
				arg_52_1:PlayTimeline("2030_tpose", "StoryTimeline/CharAction/story2030/story2030action/2030action1_1")
			end

			local var_55_53 = 0
			local var_55_54 = 0.325

			if var_55_53 < arg_52_1.time_ and arg_52_1.time_ <= var_55_53 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_55 = arg_52_1:FormatText(StoryNameCfg[19].name)

				arg_52_1.leftNameTxt_.text = var_55_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_56 = arg_52_1:GetWordFromCfg(102111013)
				local var_55_57 = arg_52_1:FormatText(var_55_56.content)

				arg_52_1.text_.text = var_55_57

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_58 = 13
				local var_55_59 = utf8.len(var_55_57)
				local var_55_60 = var_55_58 <= 0 and var_55_54 or var_55_54 * (var_55_59 / var_55_58)

				if var_55_60 > 0 and var_55_54 < var_55_60 then
					arg_52_1.talkMaxDuration = var_55_60

					if var_55_60 + var_55_53 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_60 + var_55_53
					end
				end

				arg_52_1.text_.text = var_55_57
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111013", "story_v_out_102111.awb") ~= 0 then
					local var_55_61 = manager.audio:GetVoiceLength("story_v_out_102111", "102111013", "story_v_out_102111.awb") / 1000

					if var_55_61 + var_55_53 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_61 + var_55_53
					end

					if var_55_56.prefab_name ~= "" and arg_52_1.actors_[var_55_56.prefab_name] ~= nil then
						local var_55_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_56.prefab_name].transform, "story_v_out_102111", "102111013", "story_v_out_102111.awb")

						arg_52_1:RecordAudio("102111013", var_55_62)
						arg_52_1:RecordAudio("102111013", var_55_62)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_102111", "102111013", "story_v_out_102111.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_102111", "102111013", "story_v_out_102111.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_63 = math.max(var_55_54, arg_52_1.talkMaxDuration)

			if var_55_53 <= arg_52_1.time_ and arg_52_1.time_ < var_55_53 + var_55_63 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_53) / var_55_63

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_53 + var_55_63 and arg_52_1.time_ < var_55_53 + var_55_63 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2030_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play102111014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 102111014
		arg_56_1.duration_ = 4.83

		local var_56_0 = {
			ja = 4.833,
			ko = 4.3,
			zh = 3.8,
			en = 3.633
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
				arg_56_0:Play102111015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["2020_tpose"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect2020_tpose == nil then
				arg_56_1.var_.characterEffect2020_tpose = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.1

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect2020_tpose and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect2020_tpose then
				arg_56_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_59_4 = arg_56_1.actors_["2030_tpose"]
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect2030_tpose == nil then
				arg_56_1.var_.characterEffect2030_tpose = var_59_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_6 = 0.1

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 and not isNil(var_59_4) then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6

				if arg_56_1.var_.characterEffect2030_tpose and not isNil(var_59_4) then
					local var_59_8 = Mathf.Lerp(0, 0.5, var_59_7)

					arg_56_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_56_1.var_.characterEffect2030_tpose.fillRatio = var_59_8
				end
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect2030_tpose then
				local var_59_9 = 0.5

				arg_56_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_56_1.var_.characterEffect2030_tpose.fillRatio = var_59_9
			end

			local var_59_10 = 0
			local var_59_11 = 0.5

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_12 = arg_56_1:FormatText(StoryNameCfg[33].name)

				arg_56_1.leftNameTxt_.text = var_59_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_13 = arg_56_1:GetWordFromCfg(102111014)
				local var_59_14 = arg_56_1:FormatText(var_59_13.content)

				arg_56_1.text_.text = var_59_14

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_15 = 20
				local var_59_16 = utf8.len(var_59_14)
				local var_59_17 = var_59_15 <= 0 and var_59_11 or var_59_11 * (var_59_16 / var_59_15)

				if var_59_17 > 0 and var_59_11 < var_59_17 then
					arg_56_1.talkMaxDuration = var_59_17

					if var_59_17 + var_59_10 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_17 + var_59_10
					end
				end

				arg_56_1.text_.text = var_59_14
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111014", "story_v_out_102111.awb") ~= 0 then
					local var_59_18 = manager.audio:GetVoiceLength("story_v_out_102111", "102111014", "story_v_out_102111.awb") / 1000

					if var_59_18 + var_59_10 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_18 + var_59_10
					end

					if var_59_13.prefab_name ~= "" and arg_56_1.actors_[var_59_13.prefab_name] ~= nil then
						local var_59_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_13.prefab_name].transform, "story_v_out_102111", "102111014", "story_v_out_102111.awb")

						arg_56_1:RecordAudio("102111014", var_59_19)
						arg_56_1:RecordAudio("102111014", var_59_19)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_102111", "102111014", "story_v_out_102111.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_102111", "102111014", "story_v_out_102111.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_20 = math.max(var_59_11, arg_56_1.talkMaxDuration)

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_20 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_10) / var_59_20

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_10 + var_59_20 and arg_56_1.time_ < var_59_10 + var_59_20 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play102111015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 102111015
		arg_60_1.duration_ = 5

		local var_60_0 = {
			ja = 5,
			ko = 3.733,
			zh = 3.033,
			en = 3.233
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
				arg_60_0:Play102111016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["2030_tpose"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect2030_tpose == nil then
				arg_60_1.var_.characterEffect2030_tpose = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.1

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect2030_tpose and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect2030_tpose then
				arg_60_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_63_4 = arg_60_1.actors_["2020_tpose"]
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect2020_tpose == nil then
				arg_60_1.var_.characterEffect2020_tpose = var_63_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.1

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 and not isNil(var_63_4) then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6

				if arg_60_1.var_.characterEffect2020_tpose and not isNil(var_63_4) then
					local var_63_8 = Mathf.Lerp(0, 0.5, var_63_7)

					arg_60_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_60_1.var_.characterEffect2020_tpose.fillRatio = var_63_8
				end
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect2020_tpose then
				local var_63_9 = 0.5

				arg_60_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_60_1.var_.characterEffect2020_tpose.fillRatio = var_63_9
			end

			local var_63_10 = 0
			local var_63_11 = 0.5

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_12 = arg_60_1:FormatText(StoryNameCfg[19].name)

				arg_60_1.leftNameTxt_.text = var_63_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_13 = arg_60_1:GetWordFromCfg(102111015)
				local var_63_14 = arg_60_1:FormatText(var_63_13.content)

				arg_60_1.text_.text = var_63_14

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_15 = 20
				local var_63_16 = utf8.len(var_63_14)
				local var_63_17 = var_63_15 <= 0 and var_63_11 or var_63_11 * (var_63_16 / var_63_15)

				if var_63_17 > 0 and var_63_11 < var_63_17 then
					arg_60_1.talkMaxDuration = var_63_17

					if var_63_17 + var_63_10 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_17 + var_63_10
					end
				end

				arg_60_1.text_.text = var_63_14
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111015", "story_v_out_102111.awb") ~= 0 then
					local var_63_18 = manager.audio:GetVoiceLength("story_v_out_102111", "102111015", "story_v_out_102111.awb") / 1000

					if var_63_18 + var_63_10 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_18 + var_63_10
					end

					if var_63_13.prefab_name ~= "" and arg_60_1.actors_[var_63_13.prefab_name] ~= nil then
						local var_63_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_13.prefab_name].transform, "story_v_out_102111", "102111015", "story_v_out_102111.awb")

						arg_60_1:RecordAudio("102111015", var_63_19)
						arg_60_1:RecordAudio("102111015", var_63_19)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_102111", "102111015", "story_v_out_102111.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_102111", "102111015", "story_v_out_102111.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_20 = math.max(var_63_11, arg_60_1.talkMaxDuration)

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_20 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_10) / var_63_20

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_10 + var_63_20 and arg_60_1.time_ < var_63_10 + var_63_20 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play102111016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 102111016
		arg_64_1.duration_ = 6.43

		local var_64_0 = {
			ja = 6.433,
			ko = 2.233,
			zh = 2.8,
			en = 2.533
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
				arg_64_0:Play102111017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1084ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1084ui_story == nil then
				arg_64_1.var_.characterEffect1084ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.1

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1084ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1084ui_story then
				arg_64_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_67_4 = arg_64_1.actors_["2030_tpose"]
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect2030_tpose == nil then
				arg_64_1.var_.characterEffect2030_tpose = var_67_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.1

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 and not isNil(var_67_4) then
				local var_67_7 = (arg_64_1.time_ - var_67_5) / var_67_6

				if arg_64_1.var_.characterEffect2030_tpose and not isNil(var_67_4) then
					local var_67_8 = Mathf.Lerp(0, 0.5, var_67_7)

					arg_64_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_64_1.var_.characterEffect2030_tpose.fillRatio = var_67_8
				end
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect2030_tpose then
				local var_67_9 = 0.5

				arg_64_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_64_1.var_.characterEffect2030_tpose.fillRatio = var_67_9
			end

			local var_67_10 = arg_64_1.actors_["2030_tpose"].transform
			local var_67_11 = 0

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.var_.moveOldPos2030_tpose = var_67_10.localPosition

				local var_67_12 = GameObjectTools.GetOrAddComponent(var_67_10.gameObject, typeof(DynamicBoneHelper))

				if var_67_12 then
					var_67_12:EnableDynamicBone(false)
				end
			end

			local var_67_13 = 0.001

			if var_67_11 <= arg_64_1.time_ and arg_64_1.time_ < var_67_11 + var_67_13 then
				local var_67_14 = (arg_64_1.time_ - var_67_11) / var_67_13
				local var_67_15 = Vector3.New(0, 100, 0)

				var_67_10.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos2030_tpose, var_67_15, var_67_14)

				local var_67_16 = manager.ui.mainCamera.transform.position - var_67_10.position

				var_67_10.forward = Vector3.New(var_67_16.x, var_67_16.y, var_67_16.z)

				local var_67_17 = var_67_10.localEulerAngles

				var_67_17.z = 0
				var_67_17.x = 0
				var_67_10.localEulerAngles = var_67_17
			end

			if arg_64_1.time_ >= var_67_11 + var_67_13 and arg_64_1.time_ < var_67_11 + var_67_13 + arg_67_0 then
				var_67_10.localPosition = Vector3.New(0, 100, 0)

				local var_67_18 = manager.ui.mainCamera.transform.position - var_67_10.position

				var_67_10.forward = Vector3.New(var_67_18.x, var_67_18.y, var_67_18.z)

				local var_67_19 = var_67_10.localEulerAngles

				var_67_19.z = 0
				var_67_19.x = 0
				var_67_10.localEulerAngles = var_67_19

				local var_67_20 = GameObjectTools.GetOrAddComponent(var_67_10.gameObject, typeof(DynamicBoneHelper))

				if var_67_20 then
					var_67_20:EnableDynamicBone(true)
				end
			end

			local var_67_21 = arg_64_1.actors_["2020_tpose"].transform
			local var_67_22 = 0

			if var_67_22 < arg_64_1.time_ and arg_64_1.time_ <= var_67_22 + arg_67_0 then
				arg_64_1.var_.moveOldPos2020_tpose = var_67_21.localPosition

				local var_67_23 = GameObjectTools.GetOrAddComponent(var_67_21.gameObject, typeof(DynamicBoneHelper))

				if var_67_23 then
					var_67_23:EnableDynamicBone(false)
				end
			end

			local var_67_24 = 0.001

			if var_67_22 <= arg_64_1.time_ and arg_64_1.time_ < var_67_22 + var_67_24 then
				local var_67_25 = (arg_64_1.time_ - var_67_22) / var_67_24
				local var_67_26 = Vector3.New(0, 100, 0)

				var_67_21.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos2020_tpose, var_67_26, var_67_25)

				local var_67_27 = manager.ui.mainCamera.transform.position - var_67_21.position

				var_67_21.forward = Vector3.New(var_67_27.x, var_67_27.y, var_67_27.z)

				local var_67_28 = var_67_21.localEulerAngles

				var_67_28.z = 0
				var_67_28.x = 0
				var_67_21.localEulerAngles = var_67_28
			end

			if arg_64_1.time_ >= var_67_22 + var_67_24 and arg_64_1.time_ < var_67_22 + var_67_24 + arg_67_0 then
				var_67_21.localPosition = Vector3.New(0, 100, 0)

				local var_67_29 = manager.ui.mainCamera.transform.position - var_67_21.position

				var_67_21.forward = Vector3.New(var_67_29.x, var_67_29.y, var_67_29.z)

				local var_67_30 = var_67_21.localEulerAngles

				var_67_30.z = 0
				var_67_30.x = 0
				var_67_21.localEulerAngles = var_67_30

				local var_67_31 = GameObjectTools.GetOrAddComponent(var_67_21.gameObject, typeof(DynamicBoneHelper))

				if var_67_31 then
					var_67_31:EnableDynamicBone(true)
				end
			end

			local var_67_32 = arg_64_1.actors_["1084ui_story"].transform
			local var_67_33 = 0

			if var_67_33 < arg_64_1.time_ and arg_64_1.time_ <= var_67_33 + arg_67_0 then
				arg_64_1.var_.moveOldPos1084ui_story = var_67_32.localPosition
			end

			local var_67_34 = 0.001

			if var_67_33 <= arg_64_1.time_ and arg_64_1.time_ < var_67_33 + var_67_34 then
				local var_67_35 = (arg_64_1.time_ - var_67_33) / var_67_34
				local var_67_36 = Vector3.New(0, -0.97, -6)

				var_67_32.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1084ui_story, var_67_36, var_67_35)

				local var_67_37 = manager.ui.mainCamera.transform.position - var_67_32.position

				var_67_32.forward = Vector3.New(var_67_37.x, var_67_37.y, var_67_37.z)

				local var_67_38 = var_67_32.localEulerAngles

				var_67_38.z = 0
				var_67_38.x = 0
				var_67_32.localEulerAngles = var_67_38
			end

			if arg_64_1.time_ >= var_67_33 + var_67_34 and arg_64_1.time_ < var_67_33 + var_67_34 + arg_67_0 then
				var_67_32.localPosition = Vector3.New(0, -0.97, -6)

				local var_67_39 = manager.ui.mainCamera.transform.position - var_67_32.position

				var_67_32.forward = Vector3.New(var_67_39.x, var_67_39.y, var_67_39.z)

				local var_67_40 = var_67_32.localEulerAngles

				var_67_40.z = 0
				var_67_40.x = 0
				var_67_32.localEulerAngles = var_67_40
			end

			local var_67_41 = 0

			if var_67_41 < arg_64_1.time_ and arg_64_1.time_ <= var_67_41 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_67_42 = 0

			if var_67_42 < arg_64_1.time_ and arg_64_1.time_ <= var_67_42 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_67_43 = 0
			local var_67_44 = 0.25

			if var_67_43 < arg_64_1.time_ and arg_64_1.time_ <= var_67_43 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_45 = arg_64_1:FormatText(StoryNameCfg[6].name)

				arg_64_1.leftNameTxt_.text = var_67_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_46 = arg_64_1:GetWordFromCfg(102111016)
				local var_67_47 = arg_64_1:FormatText(var_67_46.content)

				arg_64_1.text_.text = var_67_47

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_48 = 10
				local var_67_49 = utf8.len(var_67_47)
				local var_67_50 = var_67_48 <= 0 and var_67_44 or var_67_44 * (var_67_49 / var_67_48)

				if var_67_50 > 0 and var_67_44 < var_67_50 then
					arg_64_1.talkMaxDuration = var_67_50

					if var_67_50 + var_67_43 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_50 + var_67_43
					end
				end

				arg_64_1.text_.text = var_67_47
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111016", "story_v_out_102111.awb") ~= 0 then
					local var_67_51 = manager.audio:GetVoiceLength("story_v_out_102111", "102111016", "story_v_out_102111.awb") / 1000

					if var_67_51 + var_67_43 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_51 + var_67_43
					end

					if var_67_46.prefab_name ~= "" and arg_64_1.actors_[var_67_46.prefab_name] ~= nil then
						local var_67_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_46.prefab_name].transform, "story_v_out_102111", "102111016", "story_v_out_102111.awb")

						arg_64_1:RecordAudio("102111016", var_67_52)
						arg_64_1:RecordAudio("102111016", var_67_52)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_102111", "102111016", "story_v_out_102111.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_102111", "102111016", "story_v_out_102111.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_53 = math.max(var_67_44, arg_64_1.talkMaxDuration)

			if var_67_43 <= arg_64_1.time_ and arg_64_1.time_ < var_67_43 + var_67_53 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_43) / var_67_53

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_43 + var_67_53 and arg_64_1.time_ < var_67_43 + var_67_53 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2030_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2020_tpose",
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

		arg_64_1:InitPlayNodeList()
	end,
	Play102111017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 102111017
		arg_68_1.duration_ = 2.27

		local var_68_0 = {
			ja = 2.266,
			ko = 1.433,
			zh = 2.033,
			en = 1.6
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
				arg_68_0:Play102111018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1084ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1084ui_story == nil then
				arg_68_1.var_.characterEffect1084ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.1

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect1084ui_story and not isNil(var_71_0) then
					local var_71_4 = Mathf.Lerp(0, 0.5, var_71_3)

					arg_68_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1084ui_story.fillRatio = var_71_4
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1084ui_story then
				local var_71_5 = 0.5

				arg_68_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1084ui_story.fillRatio = var_71_5
			end

			local var_71_6 = 0
			local var_71_7 = 0.2

			if var_71_6 < arg_68_1.time_ and arg_68_1.time_ <= var_71_6 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_8 = arg_68_1:FormatText(StoryNameCfg[41].name)

				arg_68_1.leftNameTxt_.text = var_71_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_9 = arg_68_1:GetWordFromCfg(102111017)
				local var_71_10 = arg_68_1:FormatText(var_71_9.content)

				arg_68_1.text_.text = var_71_10

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_11 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111017", "story_v_out_102111.awb") ~= 0 then
					local var_71_14 = manager.audio:GetVoiceLength("story_v_out_102111", "102111017", "story_v_out_102111.awb") / 1000

					if var_71_14 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_14 + var_71_6
					end

					if var_71_9.prefab_name ~= "" and arg_68_1.actors_[var_71_9.prefab_name] ~= nil then
						local var_71_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_9.prefab_name].transform, "story_v_out_102111", "102111017", "story_v_out_102111.awb")

						arg_68_1:RecordAudio("102111017", var_71_15)
						arg_68_1:RecordAudio("102111017", var_71_15)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_102111", "102111017", "story_v_out_102111.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_102111", "102111017", "story_v_out_102111.awb")
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
	Play102111018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 102111018
		arg_72_1.duration_ = 2.8

		local var_72_0 = {
			ja = 2.8,
			ko = 1.866,
			zh = 1.7,
			en = 1.9
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play102111019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1084ui_story"].transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.moveOldPos1084ui_story = var_75_0.localPosition
			end

			local var_75_2 = 0.001

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2
				local var_75_4 = Vector3.New(0, 100, 0)

				var_75_0.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1084ui_story, var_75_4, var_75_3)

				local var_75_5 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_5.x, var_75_5.y, var_75_5.z)

				local var_75_6 = var_75_0.localEulerAngles

				var_75_6.z = 0
				var_75_6.x = 0
				var_75_0.localEulerAngles = var_75_6
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 then
				var_75_0.localPosition = Vector3.New(0, 100, 0)

				local var_75_7 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_7.x, var_75_7.y, var_75_7.z)

				local var_75_8 = var_75_0.localEulerAngles

				var_75_8.z = 0
				var_75_8.x = 0
				var_75_0.localEulerAngles = var_75_8
			end

			local var_75_9 = 0
			local var_75_10 = 0.2

			if var_75_9 < arg_72_1.time_ and arg_72_1.time_ <= var_75_9 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_11 = arg_72_1:FormatText(StoryNameCfg[13].name)

				arg_72_1.leftNameTxt_.text = var_75_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_12 = arg_72_1:GetWordFromCfg(102111018)
				local var_75_13 = arg_72_1:FormatText(var_75_12.content)

				arg_72_1.text_.text = var_75_13

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_14 = 8
				local var_75_15 = utf8.len(var_75_13)
				local var_75_16 = var_75_14 <= 0 and var_75_10 or var_75_10 * (var_75_15 / var_75_14)

				if var_75_16 > 0 and var_75_10 < var_75_16 then
					arg_72_1.talkMaxDuration = var_75_16

					if var_75_16 + var_75_9 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_16 + var_75_9
					end
				end

				arg_72_1.text_.text = var_75_13
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111018", "story_v_out_102111.awb") ~= 0 then
					local var_75_17 = manager.audio:GetVoiceLength("story_v_out_102111", "102111018", "story_v_out_102111.awb") / 1000

					if var_75_17 + var_75_9 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_17 + var_75_9
					end

					if var_75_12.prefab_name ~= "" and arg_72_1.actors_[var_75_12.prefab_name] ~= nil then
						local var_75_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_12.prefab_name].transform, "story_v_out_102111", "102111018", "story_v_out_102111.awb")

						arg_72_1:RecordAudio("102111018", var_75_18)
						arg_72_1:RecordAudio("102111018", var_75_18)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_102111", "102111018", "story_v_out_102111.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_102111", "102111018", "story_v_out_102111.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_19 = math.max(var_75_10, arg_72_1.talkMaxDuration)

			if var_75_9 <= arg_72_1.time_ and arg_72_1.time_ < var_75_9 + var_75_19 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_9) / var_75_19

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_9 + var_75_19 and arg_72_1.time_ < var_75_9 + var_75_19 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
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

		arg_72_1:InitPlayNodeList()
	end,
	Play102111019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 102111019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play102111020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 1

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				local var_79_2 = "play"
				local var_79_3 = "effect"

				arg_76_1:AudioAction(var_79_2, var_79_3, "se_story_2", "se_story_2_knives", "")
			end

			local var_79_4 = 0
			local var_79_5 = 0.15

			if var_79_4 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_6 = arg_76_1:GetWordFromCfg(102111019)
				local var_79_7 = arg_76_1:FormatText(var_79_6.content)

				arg_76_1.text_.text = var_79_7

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_8 = 6
				local var_79_9 = utf8.len(var_79_7)
				local var_79_10 = var_79_8 <= 0 and var_79_5 or var_79_5 * (var_79_9 / var_79_8)

				if var_79_10 > 0 and var_79_5 < var_79_10 then
					arg_76_1.talkMaxDuration = var_79_10

					if var_79_10 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_10 + var_79_4
					end
				end

				arg_76_1.text_.text = var_79_7
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_11 = math.max(var_79_5, arg_76_1.talkMaxDuration)

			if var_79_4 <= arg_76_1.time_ and arg_76_1.time_ < var_79_4 + var_79_11 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_4) / var_79_11

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_4 + var_79_11 and arg_76_1.time_ < var_79_4 + var_79_11 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play102111020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 102111020
		arg_80_1.duration_ = 2.47

		local var_80_0 = {
			ja = 2.233,
			ko = 2.266,
			zh = 2.166,
			en = 2.466
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
				arg_80_0:Play102111021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1084ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1084ui_story == nil then
				arg_80_1.var_.characterEffect1084ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.1

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect1084ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1084ui_story then
				arg_80_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_83_4 = arg_80_1.actors_["1084ui_story"].transform
			local var_83_5 = 0

			if var_83_5 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 then
				arg_80_1.var_.moveOldPos1084ui_story = var_83_4.localPosition
			end

			local var_83_6 = 0.001

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_6 then
				local var_83_7 = (arg_80_1.time_ - var_83_5) / var_83_6
				local var_83_8 = Vector3.New(0, -0.97, -6)

				var_83_4.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1084ui_story, var_83_8, var_83_7)

				local var_83_9 = manager.ui.mainCamera.transform.position - var_83_4.position

				var_83_4.forward = Vector3.New(var_83_9.x, var_83_9.y, var_83_9.z)

				local var_83_10 = var_83_4.localEulerAngles

				var_83_10.z = 0
				var_83_10.x = 0
				var_83_4.localEulerAngles = var_83_10
			end

			if arg_80_1.time_ >= var_83_5 + var_83_6 and arg_80_1.time_ < var_83_5 + var_83_6 + arg_83_0 then
				var_83_4.localPosition = Vector3.New(0, -0.97, -6)

				local var_83_11 = manager.ui.mainCamera.transform.position - var_83_4.position

				var_83_4.forward = Vector3.New(var_83_11.x, var_83_11.y, var_83_11.z)

				local var_83_12 = var_83_4.localEulerAngles

				var_83_12.z = 0
				var_83_12.x = 0
				var_83_4.localEulerAngles = var_83_12
			end

			local var_83_13 = 0

			if var_83_13 < arg_80_1.time_ and arg_80_1.time_ <= var_83_13 + arg_83_0 then
				arg_80_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_83_14 = 0

			if var_83_14 < arg_80_1.time_ and arg_80_1.time_ <= var_83_14 + arg_83_0 then
				arg_80_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_83_15 = 0
			local var_83_16 = 0.25

			if var_83_15 < arg_80_1.time_ and arg_80_1.time_ <= var_83_15 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_17 = arg_80_1:FormatText(StoryNameCfg[6].name)

				arg_80_1.leftNameTxt_.text = var_83_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_18 = arg_80_1:GetWordFromCfg(102111020)
				local var_83_19 = arg_80_1:FormatText(var_83_18.content)

				arg_80_1.text_.text = var_83_19

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_20 = 10
				local var_83_21 = utf8.len(var_83_19)
				local var_83_22 = var_83_20 <= 0 and var_83_16 or var_83_16 * (var_83_21 / var_83_20)

				if var_83_22 > 0 and var_83_16 < var_83_22 then
					arg_80_1.talkMaxDuration = var_83_22

					if var_83_22 + var_83_15 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_22 + var_83_15
					end
				end

				arg_80_1.text_.text = var_83_19
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111020", "story_v_out_102111.awb") ~= 0 then
					local var_83_23 = manager.audio:GetVoiceLength("story_v_out_102111", "102111020", "story_v_out_102111.awb") / 1000

					if var_83_23 + var_83_15 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_23 + var_83_15
					end

					if var_83_18.prefab_name ~= "" and arg_80_1.actors_[var_83_18.prefab_name] ~= nil then
						local var_83_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_18.prefab_name].transform, "story_v_out_102111", "102111020", "story_v_out_102111.awb")

						arg_80_1:RecordAudio("102111020", var_83_24)
						arg_80_1:RecordAudio("102111020", var_83_24)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_102111", "102111020", "story_v_out_102111.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_102111", "102111020", "story_v_out_102111.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_25 = math.max(var_83_16, arg_80_1.talkMaxDuration)

			if var_83_15 <= arg_80_1.time_ and arg_80_1.time_ < var_83_15 + var_83_25 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_15) / var_83_25

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_15 + var_83_25 and arg_80_1.time_ < var_83_15 + var_83_25 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
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

		arg_80_1:InitPlayNodeList()
	end,
	Play102111021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 102111021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play102111022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1084ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1084ui_story == nil then
				arg_84_1.var_.characterEffect1084ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.1

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1084ui_story and not isNil(var_87_0) then
					local var_87_4 = Mathf.Lerp(0, 0.5, var_87_3)

					arg_84_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1084ui_story.fillRatio = var_87_4
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1084ui_story then
				local var_87_5 = 0.5

				arg_84_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1084ui_story.fillRatio = var_87_5
			end

			local var_87_6 = arg_84_1.actors_["1084ui_story"].transform
			local var_87_7 = 0

			if var_87_7 < arg_84_1.time_ and arg_84_1.time_ <= var_87_7 + arg_87_0 then
				arg_84_1.var_.moveOldPos1084ui_story = var_87_6.localPosition
			end

			local var_87_8 = 0.001

			if var_87_7 <= arg_84_1.time_ and arg_84_1.time_ < var_87_7 + var_87_8 then
				local var_87_9 = (arg_84_1.time_ - var_87_7) / var_87_8
				local var_87_10 = Vector3.New(0, 100, 0)

				var_87_6.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1084ui_story, var_87_10, var_87_9)

				local var_87_11 = manager.ui.mainCamera.transform.position - var_87_6.position

				var_87_6.forward = Vector3.New(var_87_11.x, var_87_11.y, var_87_11.z)

				local var_87_12 = var_87_6.localEulerAngles

				var_87_12.z = 0
				var_87_12.x = 0
				var_87_6.localEulerAngles = var_87_12
			end

			if arg_84_1.time_ >= var_87_7 + var_87_8 and arg_84_1.time_ < var_87_7 + var_87_8 + arg_87_0 then
				var_87_6.localPosition = Vector3.New(0, 100, 0)

				local var_87_13 = manager.ui.mainCamera.transform.position - var_87_6.position

				var_87_6.forward = Vector3.New(var_87_13.x, var_87_13.y, var_87_13.z)

				local var_87_14 = var_87_6.localEulerAngles

				var_87_14.z = 0
				var_87_14.x = 0
				var_87_6.localEulerAngles = var_87_14
			end

			local var_87_15 = 0
			local var_87_16 = 0.8

			if var_87_15 < arg_84_1.time_ and arg_84_1.time_ <= var_87_15 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_17 = arg_84_1:GetWordFromCfg(102111021)
				local var_87_18 = arg_84_1:FormatText(var_87_17.content)

				arg_84_1.text_.text = var_87_18

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_19 = 32
				local var_87_20 = utf8.len(var_87_18)
				local var_87_21 = var_87_19 <= 0 and var_87_16 or var_87_16 * (var_87_20 / var_87_19)

				if var_87_21 > 0 and var_87_16 < var_87_21 then
					arg_84_1.talkMaxDuration = var_87_21

					if var_87_21 + var_87_15 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_21 + var_87_15
					end
				end

				arg_84_1.text_.text = var_87_18
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_22 = math.max(var_87_16, arg_84_1.talkMaxDuration)

			if var_87_15 <= arg_84_1.time_ and arg_84_1.time_ < var_87_15 + var_87_22 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_15) / var_87_22

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_15 + var_87_22 and arg_84_1.time_ < var_87_15 + var_87_22 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
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

		arg_84_1:InitPlayNodeList()
	end,
	Play102111022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 102111022
		arg_88_1.duration_ = 10.1

		local var_88_0 = {
			ja = 10.1,
			ko = 6.933,
			zh = 8.666,
			en = 9
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
				arg_88_0:Play102111023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1019ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1019ui_story == nil then
				arg_88_1.var_.characterEffect1019ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.1

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1019ui_story and not isNil(var_91_0) then
					arg_88_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1019ui_story then
				arg_88_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_91_4 = 0

			if var_91_4 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_91_5 = arg_88_1.actors_["1019ui_story"].transform
			local var_91_6 = 0

			if var_91_6 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1.var_.moveOldPos1019ui_story = var_91_5.localPosition
			end

			local var_91_7 = 0.001

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_7 then
				local var_91_8 = (arg_88_1.time_ - var_91_6) / var_91_7
				local var_91_9 = Vector3.New(-0.2, -1.08, -5.9)

				var_91_5.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1019ui_story, var_91_9, var_91_8)

				local var_91_10 = manager.ui.mainCamera.transform.position - var_91_5.position

				var_91_5.forward = Vector3.New(var_91_10.x, var_91_10.y, var_91_10.z)

				local var_91_11 = var_91_5.localEulerAngles

				var_91_11.z = 0
				var_91_11.x = 0
				var_91_5.localEulerAngles = var_91_11
			end

			if arg_88_1.time_ >= var_91_6 + var_91_7 and arg_88_1.time_ < var_91_6 + var_91_7 + arg_91_0 then
				var_91_5.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_91_12 = manager.ui.mainCamera.transform.position - var_91_5.position

				var_91_5.forward = Vector3.New(var_91_12.x, var_91_12.y, var_91_12.z)

				local var_91_13 = var_91_5.localEulerAngles

				var_91_13.z = 0
				var_91_13.x = 0
				var_91_5.localEulerAngles = var_91_13
			end

			local var_91_14 = 0

			if var_91_14 < arg_88_1.time_ and arg_88_1.time_ <= var_91_14 + arg_91_0 then
				arg_88_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_91_15 = 0
			local var_91_16 = 0.9

			if var_91_15 < arg_88_1.time_ and arg_88_1.time_ <= var_91_15 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_17 = arg_88_1:FormatText(StoryNameCfg[13].name)

				arg_88_1.leftNameTxt_.text = var_91_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_18 = arg_88_1:GetWordFromCfg(102111022)
				local var_91_19 = arg_88_1:FormatText(var_91_18.content)

				arg_88_1.text_.text = var_91_19

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_20 = 36
				local var_91_21 = utf8.len(var_91_19)
				local var_91_22 = var_91_20 <= 0 and var_91_16 or var_91_16 * (var_91_21 / var_91_20)

				if var_91_22 > 0 and var_91_16 < var_91_22 then
					arg_88_1.talkMaxDuration = var_91_22

					if var_91_22 + var_91_15 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_22 + var_91_15
					end
				end

				arg_88_1.text_.text = var_91_19
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111022", "story_v_out_102111.awb") ~= 0 then
					local var_91_23 = manager.audio:GetVoiceLength("story_v_out_102111", "102111022", "story_v_out_102111.awb") / 1000

					if var_91_23 + var_91_15 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_23 + var_91_15
					end

					if var_91_18.prefab_name ~= "" and arg_88_1.actors_[var_91_18.prefab_name] ~= nil then
						local var_91_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_18.prefab_name].transform, "story_v_out_102111", "102111022", "story_v_out_102111.awb")

						arg_88_1:RecordAudio("102111022", var_91_24)
						arg_88_1:RecordAudio("102111022", var_91_24)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_102111", "102111022", "story_v_out_102111.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_102111", "102111022", "story_v_out_102111.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_25 = math.max(var_91_16, arg_88_1.talkMaxDuration)

			if var_91_15 <= arg_88_1.time_ and arg_88_1.time_ < var_91_15 + var_91_25 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_15) / var_91_25

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_15 + var_91_25 and arg_88_1.time_ < var_91_15 + var_91_25 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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

		arg_88_1:InitPlayNodeList()
	end,
	Play102111023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 102111023
		arg_92_1.duration_ = 6.73

		local var_92_0 = {
			ja = 6.733,
			ko = 5.433,
			zh = 5.9,
			en = 4.533
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play102111024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["3008ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect3008ui_story == nil then
				arg_92_1.var_.characterEffect3008ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.1

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect3008ui_story and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect3008ui_story then
				arg_92_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_95_4 = arg_92_1.actors_["1019ui_story"]
			local var_95_5 = 0

			if var_95_5 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect1019ui_story == nil then
				arg_92_1.var_.characterEffect1019ui_story = var_95_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_6 = 0.1

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_6 and not isNil(var_95_4) then
				local var_95_7 = (arg_92_1.time_ - var_95_5) / var_95_6

				if arg_92_1.var_.characterEffect1019ui_story and not isNil(var_95_4) then
					local var_95_8 = Mathf.Lerp(0, 0.5, var_95_7)

					arg_92_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1019ui_story.fillRatio = var_95_8
				end
			end

			if arg_92_1.time_ >= var_95_5 + var_95_6 and arg_92_1.time_ < var_95_5 + var_95_6 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect1019ui_story then
				local var_95_9 = 0.5

				arg_92_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1019ui_story.fillRatio = var_95_9
			end

			local var_95_10 = arg_92_1.actors_["1019ui_story"].transform
			local var_95_11 = 0

			if var_95_11 < arg_92_1.time_ and arg_92_1.time_ <= var_95_11 + arg_95_0 then
				arg_92_1.var_.moveOldPos1019ui_story = var_95_10.localPosition
			end

			local var_95_12 = 0.001

			if var_95_11 <= arg_92_1.time_ and arg_92_1.time_ < var_95_11 + var_95_12 then
				local var_95_13 = (arg_92_1.time_ - var_95_11) / var_95_12
				local var_95_14 = Vector3.New(0, 100, 0)

				var_95_10.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1019ui_story, var_95_14, var_95_13)

				local var_95_15 = manager.ui.mainCamera.transform.position - var_95_10.position

				var_95_10.forward = Vector3.New(var_95_15.x, var_95_15.y, var_95_15.z)

				local var_95_16 = var_95_10.localEulerAngles

				var_95_16.z = 0
				var_95_16.x = 0
				var_95_10.localEulerAngles = var_95_16
			end

			if arg_92_1.time_ >= var_95_11 + var_95_12 and arg_92_1.time_ < var_95_11 + var_95_12 + arg_95_0 then
				var_95_10.localPosition = Vector3.New(0, 100, 0)

				local var_95_17 = manager.ui.mainCamera.transform.position - var_95_10.position

				var_95_10.forward = Vector3.New(var_95_17.x, var_95_17.y, var_95_17.z)

				local var_95_18 = var_95_10.localEulerAngles

				var_95_18.z = 0
				var_95_18.x = 0
				var_95_10.localEulerAngles = var_95_18
			end

			local var_95_19 = arg_92_1.actors_["3008ui_story"].transform
			local var_95_20 = 0

			if var_95_20 < arg_92_1.time_ and arg_92_1.time_ <= var_95_20 + arg_95_0 then
				arg_92_1.var_.moveOldPos3008ui_story = var_95_19.localPosition
			end

			local var_95_21 = 0.001

			if var_95_20 <= arg_92_1.time_ and arg_92_1.time_ < var_95_20 + var_95_21 then
				local var_95_22 = (arg_92_1.time_ - var_95_20) / var_95_21
				local var_95_23 = Vector3.New(-0.7, -1.51, -4.3)

				var_95_19.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos3008ui_story, var_95_23, var_95_22)

				local var_95_24 = manager.ui.mainCamera.transform.position - var_95_19.position

				var_95_19.forward = Vector3.New(var_95_24.x, var_95_24.y, var_95_24.z)

				local var_95_25 = var_95_19.localEulerAngles

				var_95_25.z = 0
				var_95_25.x = 0
				var_95_19.localEulerAngles = var_95_25
			end

			if arg_92_1.time_ >= var_95_20 + var_95_21 and arg_92_1.time_ < var_95_20 + var_95_21 + arg_95_0 then
				var_95_19.localPosition = Vector3.New(-0.7, -1.51, -4.3)

				local var_95_26 = manager.ui.mainCamera.transform.position - var_95_19.position

				var_95_19.forward = Vector3.New(var_95_26.x, var_95_26.y, var_95_26.z)

				local var_95_27 = var_95_19.localEulerAngles

				var_95_27.z = 0
				var_95_27.x = 0
				var_95_19.localEulerAngles = var_95_27
			end

			local var_95_28 = 0

			if var_95_28 < arg_92_1.time_ and arg_92_1.time_ <= var_95_28 + arg_95_0 then
				arg_92_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action7_1")
			end

			local var_95_29 = 0

			if var_95_29 < arg_92_1.time_ and arg_92_1.time_ <= var_95_29 + arg_95_0 then
				arg_92_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_95_30 = 0
			local var_95_31 = 0.625

			if var_95_30 < arg_92_1.time_ and arg_92_1.time_ <= var_95_30 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_32 = arg_92_1:FormatText(StoryNameCfg[20].name)

				arg_92_1.leftNameTxt_.text = var_95_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_33 = arg_92_1:GetWordFromCfg(102111023)
				local var_95_34 = arg_92_1:FormatText(var_95_33.content)

				arg_92_1.text_.text = var_95_34

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_35 = 24
				local var_95_36 = utf8.len(var_95_34)
				local var_95_37 = var_95_35 <= 0 and var_95_31 or var_95_31 * (var_95_36 / var_95_35)

				if var_95_37 > 0 and var_95_31 < var_95_37 then
					arg_92_1.talkMaxDuration = var_95_37

					if var_95_37 + var_95_30 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_37 + var_95_30
					end
				end

				arg_92_1.text_.text = var_95_34
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111023", "story_v_out_102111.awb") ~= 0 then
					local var_95_38 = manager.audio:GetVoiceLength("story_v_out_102111", "102111023", "story_v_out_102111.awb") / 1000

					if var_95_38 + var_95_30 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_38 + var_95_30
					end

					if var_95_33.prefab_name ~= "" and arg_92_1.actors_[var_95_33.prefab_name] ~= nil then
						local var_95_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_33.prefab_name].transform, "story_v_out_102111", "102111023", "story_v_out_102111.awb")

						arg_92_1:RecordAudio("102111023", var_95_39)
						arg_92_1:RecordAudio("102111023", var_95_39)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_102111", "102111023", "story_v_out_102111.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_102111", "102111023", "story_v_out_102111.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_40 = math.max(var_95_31, arg_92_1.talkMaxDuration)

			if var_95_30 <= arg_92_1.time_ and arg_92_1.time_ < var_95_30 + var_95_40 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_30) / var_95_40

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_30 + var_95_40 and arg_92_1.time_ < var_95_30 + var_95_40 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play102111024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 102111024
		arg_96_1.duration_ = 6.57

		local var_96_0 = {
			ja = 6.566,
			ko = 4.3,
			zh = 5.433,
			en = 5.066
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play102111025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = "3009ui_story"

			if arg_96_1.actors_[var_99_0] == nil then
				local var_99_1 = Asset.Load("Char/" .. "3009ui_story")

				if not isNil(var_99_1) then
					local var_99_2 = Object.Instantiate(Asset.Load("Char/" .. "3009ui_story"), arg_96_1.stage_.transform)

					var_99_2.name = var_99_0
					var_99_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_96_1.actors_[var_99_0] = var_99_2

					local var_99_3 = var_99_2:GetComponentInChildren(typeof(CharacterEffect))

					var_99_3.enabled = true

					local var_99_4 = GameObjectTools.GetOrAddComponent(var_99_2, typeof(DynamicBoneHelper))

					if var_99_4 then
						var_99_4:EnableDynamicBone(false)
					end

					arg_96_1:ShowWeapon(var_99_3.transform, false)

					arg_96_1.var_[var_99_0 .. "Animator"] = var_99_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_96_1.var_[var_99_0 .. "Animator"].applyRootMotion = true
					arg_96_1.var_[var_99_0 .. "LipSync"] = var_99_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_99_5 = arg_96_1.actors_["3009ui_story"]
			local var_99_6 = 0

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 and not isNil(var_99_5) and arg_96_1.var_.characterEffect3009ui_story == nil then
				arg_96_1.var_.characterEffect3009ui_story = var_99_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_7 = 0.1

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_7 and not isNil(var_99_5) then
				local var_99_8 = (arg_96_1.time_ - var_99_6) / var_99_7

				if arg_96_1.var_.characterEffect3009ui_story and not isNil(var_99_5) then
					arg_96_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_6 + var_99_7 and arg_96_1.time_ < var_99_6 + var_99_7 + arg_99_0 and not isNil(var_99_5) and arg_96_1.var_.characterEffect3009ui_story then
				arg_96_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_99_9 = arg_96_1.actors_["3008ui_story"]
			local var_99_10 = 0

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 and not isNil(var_99_9) and arg_96_1.var_.characterEffect3008ui_story == nil then
				arg_96_1.var_.characterEffect3008ui_story = var_99_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_11 = 0.1

			if var_99_10 <= arg_96_1.time_ and arg_96_1.time_ < var_99_10 + var_99_11 and not isNil(var_99_9) then
				local var_99_12 = (arg_96_1.time_ - var_99_10) / var_99_11

				if arg_96_1.var_.characterEffect3008ui_story and not isNil(var_99_9) then
					local var_99_13 = Mathf.Lerp(0, 0.5, var_99_12)

					arg_96_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_96_1.var_.characterEffect3008ui_story.fillRatio = var_99_13
				end
			end

			if arg_96_1.time_ >= var_99_10 + var_99_11 and arg_96_1.time_ < var_99_10 + var_99_11 + arg_99_0 and not isNil(var_99_9) and arg_96_1.var_.characterEffect3008ui_story then
				local var_99_14 = 0.5

				arg_96_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_96_1.var_.characterEffect3008ui_story.fillRatio = var_99_14
			end

			local var_99_15 = arg_96_1.actors_["3009ui_story"].transform
			local var_99_16 = 0

			if var_99_16 < arg_96_1.time_ and arg_96_1.time_ <= var_99_16 + arg_99_0 then
				arg_96_1.var_.moveOldPos3009ui_story = var_99_15.localPosition

				local var_99_17 = "3009ui_story"

				arg_96_1:ShowWeapon(arg_96_1.var_[var_99_17 .. "Animator"].transform, true)
			end

			local var_99_18 = 0.001

			if var_99_16 <= arg_96_1.time_ and arg_96_1.time_ < var_99_16 + var_99_18 then
				local var_99_19 = (arg_96_1.time_ - var_99_16) / var_99_18
				local var_99_20 = Vector3.New(0.7, -1.75, -4.8)

				var_99_15.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos3009ui_story, var_99_20, var_99_19)

				local var_99_21 = manager.ui.mainCamera.transform.position - var_99_15.position

				var_99_15.forward = Vector3.New(var_99_21.x, var_99_21.y, var_99_21.z)

				local var_99_22 = var_99_15.localEulerAngles

				var_99_22.z = 0
				var_99_22.x = 0
				var_99_15.localEulerAngles = var_99_22
			end

			if arg_96_1.time_ >= var_99_16 + var_99_18 and arg_96_1.time_ < var_99_16 + var_99_18 + arg_99_0 then
				var_99_15.localPosition = Vector3.New(0.7, -1.75, -4.8)

				local var_99_23 = manager.ui.mainCamera.transform.position - var_99_15.position

				var_99_15.forward = Vector3.New(var_99_23.x, var_99_23.y, var_99_23.z)

				local var_99_24 = var_99_15.localEulerAngles

				var_99_24.z = 0
				var_99_24.x = 0
				var_99_15.localEulerAngles = var_99_24
			end

			local var_99_25 = 0

			if var_99_25 < arg_96_1.time_ and arg_96_1.time_ <= var_99_25 + arg_99_0 then
				arg_96_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action2_1")
			end

			local var_99_26 = 0

			if var_99_26 < arg_96_1.time_ and arg_96_1.time_ <= var_99_26 + arg_99_0 then
				arg_96_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_99_27 = 0
			local var_99_28 = 0.675

			if var_99_27 < arg_96_1.time_ and arg_96_1.time_ <= var_99_27 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_29 = arg_96_1:FormatText(StoryNameCfg[43].name)

				arg_96_1.leftNameTxt_.text = var_99_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_30 = arg_96_1:GetWordFromCfg(102111024)
				local var_99_31 = arg_96_1:FormatText(var_99_30.content)

				arg_96_1.text_.text = var_99_31

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_32 = 27
				local var_99_33 = utf8.len(var_99_31)
				local var_99_34 = var_99_32 <= 0 and var_99_28 or var_99_28 * (var_99_33 / var_99_32)

				if var_99_34 > 0 and var_99_28 < var_99_34 then
					arg_96_1.talkMaxDuration = var_99_34

					if var_99_34 + var_99_27 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_34 + var_99_27
					end
				end

				arg_96_1.text_.text = var_99_31
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111024", "story_v_out_102111.awb") ~= 0 then
					local var_99_35 = manager.audio:GetVoiceLength("story_v_out_102111", "102111024", "story_v_out_102111.awb") / 1000

					if var_99_35 + var_99_27 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_35 + var_99_27
					end

					if var_99_30.prefab_name ~= "" and arg_96_1.actors_[var_99_30.prefab_name] ~= nil then
						local var_99_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_30.prefab_name].transform, "story_v_out_102111", "102111024", "story_v_out_102111.awb")

						arg_96_1:RecordAudio("102111024", var_99_36)
						arg_96_1:RecordAudio("102111024", var_99_36)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_102111", "102111024", "story_v_out_102111.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_102111", "102111024", "story_v_out_102111.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_37 = math.max(var_99_28, arg_96_1.talkMaxDuration)

			if var_99_27 <= arg_96_1.time_ and arg_96_1.time_ < var_99_27 + var_99_37 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_27) / var_99_37

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_27 + var_99_37 and arg_96_1.time_ < var_99_27 + var_99_37 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3009ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play102111025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 102111025
		arg_100_1.duration_ = 6.47

		local var_100_0 = {
			ja = 6.2,
			ko = 5.766,
			zh = 6.466,
			en = 5.866
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play102111026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["3008ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect3008ui_story == nil then
				arg_100_1.var_.characterEffect3008ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.1

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect3008ui_story and not isNil(var_103_0) then
					arg_100_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect3008ui_story then
				arg_100_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_103_4 = arg_100_1.actors_["3009ui_story"]
			local var_103_5 = 0

			if var_103_5 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect3009ui_story == nil then
				arg_100_1.var_.characterEffect3009ui_story = var_103_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_6 = 0.1

			if var_103_5 <= arg_100_1.time_ and arg_100_1.time_ < var_103_5 + var_103_6 and not isNil(var_103_4) then
				local var_103_7 = (arg_100_1.time_ - var_103_5) / var_103_6

				if arg_100_1.var_.characterEffect3009ui_story and not isNil(var_103_4) then
					local var_103_8 = Mathf.Lerp(0, 0.5, var_103_7)

					arg_100_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_100_1.var_.characterEffect3009ui_story.fillRatio = var_103_8
				end
			end

			if arg_100_1.time_ >= var_103_5 + var_103_6 and arg_100_1.time_ < var_103_5 + var_103_6 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect3009ui_story then
				local var_103_9 = 0.5

				arg_100_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_100_1.var_.characterEffect3009ui_story.fillRatio = var_103_9
			end

			local var_103_10 = 0

			if var_103_10 < arg_100_1.time_ and arg_100_1.time_ <= var_103_10 + arg_103_0 then
				arg_100_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_103_11 = 0

			if var_103_11 < arg_100_1.time_ and arg_100_1.time_ <= var_103_11 + arg_103_0 then
				arg_100_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action7_2")
			end

			local var_103_12 = 0
			local var_103_13 = 0.825

			if var_103_12 < arg_100_1.time_ and arg_100_1.time_ <= var_103_12 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_14 = arg_100_1:FormatText(StoryNameCfg[20].name)

				arg_100_1.leftNameTxt_.text = var_103_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_15 = arg_100_1:GetWordFromCfg(102111025)
				local var_103_16 = arg_100_1:FormatText(var_103_15.content)

				arg_100_1.text_.text = var_103_16

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_17 = 33
				local var_103_18 = utf8.len(var_103_16)
				local var_103_19 = var_103_17 <= 0 and var_103_13 or var_103_13 * (var_103_18 / var_103_17)

				if var_103_19 > 0 and var_103_13 < var_103_19 then
					arg_100_1.talkMaxDuration = var_103_19

					if var_103_19 + var_103_12 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_19 + var_103_12
					end
				end

				arg_100_1.text_.text = var_103_16
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111025", "story_v_out_102111.awb") ~= 0 then
					local var_103_20 = manager.audio:GetVoiceLength("story_v_out_102111", "102111025", "story_v_out_102111.awb") / 1000

					if var_103_20 + var_103_12 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_20 + var_103_12
					end

					if var_103_15.prefab_name ~= "" and arg_100_1.actors_[var_103_15.prefab_name] ~= nil then
						local var_103_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_15.prefab_name].transform, "story_v_out_102111", "102111025", "story_v_out_102111.awb")

						arg_100_1:RecordAudio("102111025", var_103_21)
						arg_100_1:RecordAudio("102111025", var_103_21)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_102111", "102111025", "story_v_out_102111.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_102111", "102111025", "story_v_out_102111.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_22 = math.max(var_103_13, arg_100_1.talkMaxDuration)

			if var_103_12 <= arg_100_1.time_ and arg_100_1.time_ < var_103_12 + var_103_22 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_12) / var_103_22

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_12 + var_103_22 and arg_100_1.time_ < var_103_12 + var_103_22 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play102111026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 102111026
		arg_104_1.duration_ = 4.53

		local var_104_0 = {
			ja = 4.4,
			ko = 4.166,
			zh = 4.533,
			en = 3.6
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
				arg_104_0:Play102111027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["3009ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect3009ui_story == nil then
				arg_104_1.var_.characterEffect3009ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.1

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect3009ui_story and not isNil(var_107_0) then
					arg_104_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect3009ui_story then
				arg_104_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_107_4 = arg_104_1.actors_["3008ui_story"]
			local var_107_5 = 0

			if var_107_5 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 and not isNil(var_107_4) and arg_104_1.var_.characterEffect3008ui_story == nil then
				arg_104_1.var_.characterEffect3008ui_story = var_107_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_6 = 0.1

			if var_107_5 <= arg_104_1.time_ and arg_104_1.time_ < var_107_5 + var_107_6 and not isNil(var_107_4) then
				local var_107_7 = (arg_104_1.time_ - var_107_5) / var_107_6

				if arg_104_1.var_.characterEffect3008ui_story and not isNil(var_107_4) then
					local var_107_8 = Mathf.Lerp(0, 0.5, var_107_7)

					arg_104_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_104_1.var_.characterEffect3008ui_story.fillRatio = var_107_8
				end
			end

			if arg_104_1.time_ >= var_107_5 + var_107_6 and arg_104_1.time_ < var_107_5 + var_107_6 + arg_107_0 and not isNil(var_107_4) and arg_104_1.var_.characterEffect3008ui_story then
				local var_107_9 = 0.5

				arg_104_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_104_1.var_.characterEffect3008ui_story.fillRatio = var_107_9
			end

			local var_107_10 = 0

			if var_107_10 < arg_104_1.time_ and arg_104_1.time_ <= var_107_10 + arg_107_0 then
				arg_104_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_107_11 = 0
			local var_107_12 = 0.5

			if var_107_11 < arg_104_1.time_ and arg_104_1.time_ <= var_107_11 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_13 = arg_104_1:FormatText(StoryNameCfg[43].name)

				arg_104_1.leftNameTxt_.text = var_107_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_14 = arg_104_1:GetWordFromCfg(102111026)
				local var_107_15 = arg_104_1:FormatText(var_107_14.content)

				arg_104_1.text_.text = var_107_15

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_16 = 20
				local var_107_17 = utf8.len(var_107_15)
				local var_107_18 = var_107_16 <= 0 and var_107_12 or var_107_12 * (var_107_17 / var_107_16)

				if var_107_18 > 0 and var_107_12 < var_107_18 then
					arg_104_1.talkMaxDuration = var_107_18

					if var_107_18 + var_107_11 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_18 + var_107_11
					end
				end

				arg_104_1.text_.text = var_107_15
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111026", "story_v_out_102111.awb") ~= 0 then
					local var_107_19 = manager.audio:GetVoiceLength("story_v_out_102111", "102111026", "story_v_out_102111.awb") / 1000

					if var_107_19 + var_107_11 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_19 + var_107_11
					end

					if var_107_14.prefab_name ~= "" and arg_104_1.actors_[var_107_14.prefab_name] ~= nil then
						local var_107_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_14.prefab_name].transform, "story_v_out_102111", "102111026", "story_v_out_102111.awb")

						arg_104_1:RecordAudio("102111026", var_107_20)
						arg_104_1:RecordAudio("102111026", var_107_20)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_102111", "102111026", "story_v_out_102111.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_102111", "102111026", "story_v_out_102111.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_21 = math.max(var_107_12, arg_104_1.talkMaxDuration)

			if var_107_11 <= arg_104_1.time_ and arg_104_1.time_ < var_107_11 + var_107_21 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_11) / var_107_21

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_11 + var_107_21 and arg_104_1.time_ < var_107_11 + var_107_21 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play102111027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 102111027
		arg_108_1.duration_ = 4.57

		local var_108_0 = {
			ja = 4.566,
			ko = 3.7,
			zh = 3.9,
			en = 3.3
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
				arg_108_0:Play102111028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["3008ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect3008ui_story == nil then
				arg_108_1.var_.characterEffect3008ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.1

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect3008ui_story and not isNil(var_111_0) then
					arg_108_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect3008ui_story then
				arg_108_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_111_4 = arg_108_1.actors_["3009ui_story"]
			local var_111_5 = 0

			if var_111_5 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect3009ui_story == nil then
				arg_108_1.var_.characterEffect3009ui_story = var_111_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_6 = 0.1

			if var_111_5 <= arg_108_1.time_ and arg_108_1.time_ < var_111_5 + var_111_6 and not isNil(var_111_4) then
				local var_111_7 = (arg_108_1.time_ - var_111_5) / var_111_6

				if arg_108_1.var_.characterEffect3009ui_story and not isNil(var_111_4) then
					local var_111_8 = Mathf.Lerp(0, 0.5, var_111_7)

					arg_108_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_108_1.var_.characterEffect3009ui_story.fillRatio = var_111_8
				end
			end

			if arg_108_1.time_ >= var_111_5 + var_111_6 and arg_108_1.time_ < var_111_5 + var_111_6 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect3009ui_story then
				local var_111_9 = 0.5

				arg_108_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_108_1.var_.characterEffect3009ui_story.fillRatio = var_111_9
			end

			local var_111_10 = 0

			if var_111_10 < arg_108_1.time_ and arg_108_1.time_ <= var_111_10 + arg_111_0 then
				arg_108_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_111_11 = 0

			if var_111_11 < arg_108_1.time_ and arg_108_1.time_ <= var_111_11 + arg_111_0 then
				arg_108_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action2_1")
			end

			local var_111_12 = 0
			local var_111_13 = 0.3

			if var_111_12 < arg_108_1.time_ and arg_108_1.time_ <= var_111_12 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_14 = arg_108_1:FormatText(StoryNameCfg[20].name)

				arg_108_1.leftNameTxt_.text = var_111_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_15 = arg_108_1:GetWordFromCfg(102111027)
				local var_111_16 = arg_108_1:FormatText(var_111_15.content)

				arg_108_1.text_.text = var_111_16

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_17 = 12
				local var_111_18 = utf8.len(var_111_16)
				local var_111_19 = var_111_17 <= 0 and var_111_13 or var_111_13 * (var_111_18 / var_111_17)

				if var_111_19 > 0 and var_111_13 < var_111_19 then
					arg_108_1.talkMaxDuration = var_111_19

					if var_111_19 + var_111_12 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_19 + var_111_12
					end
				end

				arg_108_1.text_.text = var_111_16
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111027", "story_v_out_102111.awb") ~= 0 then
					local var_111_20 = manager.audio:GetVoiceLength("story_v_out_102111", "102111027", "story_v_out_102111.awb") / 1000

					if var_111_20 + var_111_12 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_20 + var_111_12
					end

					if var_111_15.prefab_name ~= "" and arg_108_1.actors_[var_111_15.prefab_name] ~= nil then
						local var_111_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_15.prefab_name].transform, "story_v_out_102111", "102111027", "story_v_out_102111.awb")

						arg_108_1:RecordAudio("102111027", var_111_21)
						arg_108_1:RecordAudio("102111027", var_111_21)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_102111", "102111027", "story_v_out_102111.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_102111", "102111027", "story_v_out_102111.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_22 = math.max(var_111_13, arg_108_1.talkMaxDuration)

			if var_111_12 <= arg_108_1.time_ and arg_108_1.time_ < var_111_12 + var_111_22 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_12) / var_111_22

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_12 + var_111_22 and arg_108_1.time_ < var_111_12 + var_111_22 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play102111028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 102111028
		arg_112_1.duration_ = 6.07

		local var_112_0 = {
			ja = 6.066,
			ko = 3.533,
			zh = 4.1,
			en = 3.433
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
				arg_112_0:Play102111029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["3009ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect3009ui_story == nil then
				arg_112_1.var_.characterEffect3009ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.1

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect3009ui_story and not isNil(var_115_0) then
					arg_112_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect3009ui_story then
				arg_112_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_115_4 = arg_112_1.actors_["3008ui_story"]
			local var_115_5 = 0

			if var_115_5 < arg_112_1.time_ and arg_112_1.time_ <= var_115_5 + arg_115_0 and not isNil(var_115_4) and arg_112_1.var_.characterEffect3008ui_story == nil then
				arg_112_1.var_.characterEffect3008ui_story = var_115_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_6 = 0.1

			if var_115_5 <= arg_112_1.time_ and arg_112_1.time_ < var_115_5 + var_115_6 and not isNil(var_115_4) then
				local var_115_7 = (arg_112_1.time_ - var_115_5) / var_115_6

				if arg_112_1.var_.characterEffect3008ui_story and not isNil(var_115_4) then
					local var_115_8 = Mathf.Lerp(0, 0.5, var_115_7)

					arg_112_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_112_1.var_.characterEffect3008ui_story.fillRatio = var_115_8
				end
			end

			if arg_112_1.time_ >= var_115_5 + var_115_6 and arg_112_1.time_ < var_115_5 + var_115_6 + arg_115_0 and not isNil(var_115_4) and arg_112_1.var_.characterEffect3008ui_story then
				local var_115_9 = 0.5

				arg_112_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_112_1.var_.characterEffect3008ui_story.fillRatio = var_115_9
			end

			local var_115_10 = 0

			if var_115_10 < arg_112_1.time_ and arg_112_1.time_ <= var_115_10 + arg_115_0 then
				arg_112_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_115_11 = 0
			local var_115_12 = 0.4

			if var_115_11 < arg_112_1.time_ and arg_112_1.time_ <= var_115_11 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_13 = arg_112_1:FormatText(StoryNameCfg[43].name)

				arg_112_1.leftNameTxt_.text = var_115_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_14 = arg_112_1:GetWordFromCfg(102111028)
				local var_115_15 = arg_112_1:FormatText(var_115_14.content)

				arg_112_1.text_.text = var_115_15

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_16 = 16
				local var_115_17 = utf8.len(var_115_15)
				local var_115_18 = var_115_16 <= 0 and var_115_12 or var_115_12 * (var_115_17 / var_115_16)

				if var_115_18 > 0 and var_115_12 < var_115_18 then
					arg_112_1.talkMaxDuration = var_115_18

					if var_115_18 + var_115_11 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_18 + var_115_11
					end
				end

				arg_112_1.text_.text = var_115_15
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111028", "story_v_out_102111.awb") ~= 0 then
					local var_115_19 = manager.audio:GetVoiceLength("story_v_out_102111", "102111028", "story_v_out_102111.awb") / 1000

					if var_115_19 + var_115_11 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_19 + var_115_11
					end

					if var_115_14.prefab_name ~= "" and arg_112_1.actors_[var_115_14.prefab_name] ~= nil then
						local var_115_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_14.prefab_name].transform, "story_v_out_102111", "102111028", "story_v_out_102111.awb")

						arg_112_1:RecordAudio("102111028", var_115_20)
						arg_112_1:RecordAudio("102111028", var_115_20)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_102111", "102111028", "story_v_out_102111.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_102111", "102111028", "story_v_out_102111.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_21 = math.max(var_115_12, arg_112_1.talkMaxDuration)

			if var_115_11 <= arg_112_1.time_ and arg_112_1.time_ < var_115_11 + var_115_21 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_11) / var_115_21

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_11 + var_115_21 and arg_112_1.time_ < var_115_11 + var_115_21 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play102111029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 102111029
		arg_116_1.duration_ = 5.53

		local var_116_0 = {
			ja = 5.533,
			ko = 4.233,
			zh = 4.533,
			en = 3.6
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
				arg_116_0:Play102111030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1019ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1019ui_story == nil then
				arg_116_1.var_.characterEffect1019ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.1

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect1019ui_story and not isNil(var_119_0) then
					arg_116_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1019ui_story then
				arg_116_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_119_4 = arg_116_1.actors_["3009ui_story"]
			local var_119_5 = 0

			if var_119_5 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 and not isNil(var_119_4) and arg_116_1.var_.characterEffect3009ui_story == nil then
				arg_116_1.var_.characterEffect3009ui_story = var_119_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_6 = 0.1

			if var_119_5 <= arg_116_1.time_ and arg_116_1.time_ < var_119_5 + var_119_6 and not isNil(var_119_4) then
				local var_119_7 = (arg_116_1.time_ - var_119_5) / var_119_6

				if arg_116_1.var_.characterEffect3009ui_story and not isNil(var_119_4) then
					local var_119_8 = Mathf.Lerp(0, 0.5, var_119_7)

					arg_116_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_116_1.var_.characterEffect3009ui_story.fillRatio = var_119_8
				end
			end

			if arg_116_1.time_ >= var_119_5 + var_119_6 and arg_116_1.time_ < var_119_5 + var_119_6 + arg_119_0 and not isNil(var_119_4) and arg_116_1.var_.characterEffect3009ui_story then
				local var_119_9 = 0.5

				arg_116_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_116_1.var_.characterEffect3009ui_story.fillRatio = var_119_9
			end

			local var_119_10 = arg_116_1.actors_["3009ui_story"].transform
			local var_119_11 = 0

			if var_119_11 < arg_116_1.time_ and arg_116_1.time_ <= var_119_11 + arg_119_0 then
				arg_116_1.var_.moveOldPos3009ui_story = var_119_10.localPosition
			end

			local var_119_12 = 0.001

			if var_119_11 <= arg_116_1.time_ and arg_116_1.time_ < var_119_11 + var_119_12 then
				local var_119_13 = (arg_116_1.time_ - var_119_11) / var_119_12
				local var_119_14 = Vector3.New(0, 100, 0)

				var_119_10.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos3009ui_story, var_119_14, var_119_13)

				local var_119_15 = manager.ui.mainCamera.transform.position - var_119_10.position

				var_119_10.forward = Vector3.New(var_119_15.x, var_119_15.y, var_119_15.z)

				local var_119_16 = var_119_10.localEulerAngles

				var_119_16.z = 0
				var_119_16.x = 0
				var_119_10.localEulerAngles = var_119_16
			end

			if arg_116_1.time_ >= var_119_11 + var_119_12 and arg_116_1.time_ < var_119_11 + var_119_12 + arg_119_0 then
				var_119_10.localPosition = Vector3.New(0, 100, 0)

				local var_119_17 = manager.ui.mainCamera.transform.position - var_119_10.position

				var_119_10.forward = Vector3.New(var_119_17.x, var_119_17.y, var_119_17.z)

				local var_119_18 = var_119_10.localEulerAngles

				var_119_18.z = 0
				var_119_18.x = 0
				var_119_10.localEulerAngles = var_119_18
			end

			local var_119_19 = 0

			if var_119_19 < arg_116_1.time_ and arg_116_1.time_ <= var_119_19 + arg_119_0 then
				arg_116_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_119_20 = arg_116_1.actors_["1019ui_story"].transform
			local var_119_21 = 0

			if var_119_21 < arg_116_1.time_ and arg_116_1.time_ <= var_119_21 + arg_119_0 then
				arg_116_1.var_.moveOldPos1019ui_story = var_119_20.localPosition
			end

			local var_119_22 = 0.001

			if var_119_21 <= arg_116_1.time_ and arg_116_1.time_ < var_119_21 + var_119_22 then
				local var_119_23 = (arg_116_1.time_ - var_119_21) / var_119_22
				local var_119_24 = Vector3.New(-0.2, -1.08, -5.9)

				var_119_20.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1019ui_story, var_119_24, var_119_23)

				local var_119_25 = manager.ui.mainCamera.transform.position - var_119_20.position

				var_119_20.forward = Vector3.New(var_119_25.x, var_119_25.y, var_119_25.z)

				local var_119_26 = var_119_20.localEulerAngles

				var_119_26.z = 0
				var_119_26.x = 0
				var_119_20.localEulerAngles = var_119_26
			end

			if arg_116_1.time_ >= var_119_21 + var_119_22 and arg_116_1.time_ < var_119_21 + var_119_22 + arg_119_0 then
				var_119_20.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_119_27 = manager.ui.mainCamera.transform.position - var_119_20.position

				var_119_20.forward = Vector3.New(var_119_27.x, var_119_27.y, var_119_27.z)

				local var_119_28 = var_119_20.localEulerAngles

				var_119_28.z = 0
				var_119_28.x = 0
				var_119_20.localEulerAngles = var_119_28
			end

			local var_119_29 = 0

			if var_119_29 < arg_116_1.time_ and arg_116_1.time_ <= var_119_29 + arg_119_0 then
				arg_116_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_119_30 = arg_116_1.actors_["3008ui_story"].transform
			local var_119_31 = 0

			if var_119_31 < arg_116_1.time_ and arg_116_1.time_ <= var_119_31 + arg_119_0 then
				arg_116_1.var_.moveOldPos3008ui_story = var_119_30.localPosition
			end

			local var_119_32 = 0.001

			if var_119_31 <= arg_116_1.time_ and arg_116_1.time_ < var_119_31 + var_119_32 then
				local var_119_33 = (arg_116_1.time_ - var_119_31) / var_119_32
				local var_119_34 = Vector3.New(0, 100, 0)

				var_119_30.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos3008ui_story, var_119_34, var_119_33)

				local var_119_35 = manager.ui.mainCamera.transform.position - var_119_30.position

				var_119_30.forward = Vector3.New(var_119_35.x, var_119_35.y, var_119_35.z)

				local var_119_36 = var_119_30.localEulerAngles

				var_119_36.z = 0
				var_119_36.x = 0
				var_119_30.localEulerAngles = var_119_36
			end

			if arg_116_1.time_ >= var_119_31 + var_119_32 and arg_116_1.time_ < var_119_31 + var_119_32 + arg_119_0 then
				var_119_30.localPosition = Vector3.New(0, 100, 0)

				local var_119_37 = manager.ui.mainCamera.transform.position - var_119_30.position

				var_119_30.forward = Vector3.New(var_119_37.x, var_119_37.y, var_119_37.z)

				local var_119_38 = var_119_30.localEulerAngles

				var_119_38.z = 0
				var_119_38.x = 0
				var_119_30.localEulerAngles = var_119_38
			end

			local var_119_39 = 0
			local var_119_40 = 0.55

			if var_119_39 < arg_116_1.time_ and arg_116_1.time_ <= var_119_39 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_41 = arg_116_1:FormatText(StoryNameCfg[13].name)

				arg_116_1.leftNameTxt_.text = var_119_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_42 = arg_116_1:GetWordFromCfg(102111029)
				local var_119_43 = arg_116_1:FormatText(var_119_42.content)

				arg_116_1.text_.text = var_119_43

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_44 = 22
				local var_119_45 = utf8.len(var_119_43)
				local var_119_46 = var_119_44 <= 0 and var_119_40 or var_119_40 * (var_119_45 / var_119_44)

				if var_119_46 > 0 and var_119_40 < var_119_46 then
					arg_116_1.talkMaxDuration = var_119_46

					if var_119_46 + var_119_39 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_46 + var_119_39
					end
				end

				arg_116_1.text_.text = var_119_43
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111029", "story_v_out_102111.awb") ~= 0 then
					local var_119_47 = manager.audio:GetVoiceLength("story_v_out_102111", "102111029", "story_v_out_102111.awb") / 1000

					if var_119_47 + var_119_39 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_47 + var_119_39
					end

					if var_119_42.prefab_name ~= "" and arg_116_1.actors_[var_119_42.prefab_name] ~= nil then
						local var_119_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_42.prefab_name].transform, "story_v_out_102111", "102111029", "story_v_out_102111.awb")

						arg_116_1:RecordAudio("102111029", var_119_48)
						arg_116_1:RecordAudio("102111029", var_119_48)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_102111", "102111029", "story_v_out_102111.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_102111", "102111029", "story_v_out_102111.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_49 = math.max(var_119_40, arg_116_1.talkMaxDuration)

			if var_119_39 <= arg_116_1.time_ and arg_116_1.time_ < var_119_39 + var_119_49 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_39) / var_119_49

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_39 + var_119_49 and arg_116_1.time_ < var_119_39 + var_119_49 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3009ui_story",
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
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play102111030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 102111030
		arg_120_1.duration_ = 3.87

		local var_120_0 = {
			ja = 3.866,
			ko = 2.733,
			zh = 3.4,
			en = 2.133
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play102111031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["3009ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect3009ui_story == nil then
				arg_120_1.var_.characterEffect3009ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.1

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect3009ui_story and not isNil(var_123_0) then
					arg_120_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect3009ui_story then
				arg_120_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_123_4 = arg_120_1.actors_["1019ui_story"]
			local var_123_5 = 0

			if var_123_5 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 and not isNil(var_123_4) and arg_120_1.var_.characterEffect1019ui_story == nil then
				arg_120_1.var_.characterEffect1019ui_story = var_123_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_6 = 0.1

			if var_123_5 <= arg_120_1.time_ and arg_120_1.time_ < var_123_5 + var_123_6 and not isNil(var_123_4) then
				local var_123_7 = (arg_120_1.time_ - var_123_5) / var_123_6

				if arg_120_1.var_.characterEffect1019ui_story and not isNil(var_123_4) then
					local var_123_8 = Mathf.Lerp(0, 0.5, var_123_7)

					arg_120_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1019ui_story.fillRatio = var_123_8
				end
			end

			if arg_120_1.time_ >= var_123_5 + var_123_6 and arg_120_1.time_ < var_123_5 + var_123_6 + arg_123_0 and not isNil(var_123_4) and arg_120_1.var_.characterEffect1019ui_story then
				local var_123_9 = 0.5

				arg_120_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1019ui_story.fillRatio = var_123_9
			end

			local var_123_10 = arg_120_1.actors_["1019ui_story"].transform
			local var_123_11 = 0

			if var_123_11 < arg_120_1.time_ and arg_120_1.time_ <= var_123_11 + arg_123_0 then
				arg_120_1.var_.moveOldPos1019ui_story = var_123_10.localPosition
			end

			local var_123_12 = 0.001

			if var_123_11 <= arg_120_1.time_ and arg_120_1.time_ < var_123_11 + var_123_12 then
				local var_123_13 = (arg_120_1.time_ - var_123_11) / var_123_12
				local var_123_14 = Vector3.New(0, 100, 0)

				var_123_10.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1019ui_story, var_123_14, var_123_13)

				local var_123_15 = manager.ui.mainCamera.transform.position - var_123_10.position

				var_123_10.forward = Vector3.New(var_123_15.x, var_123_15.y, var_123_15.z)

				local var_123_16 = var_123_10.localEulerAngles

				var_123_16.z = 0
				var_123_16.x = 0
				var_123_10.localEulerAngles = var_123_16
			end

			if arg_120_1.time_ >= var_123_11 + var_123_12 and arg_120_1.time_ < var_123_11 + var_123_12 + arg_123_0 then
				var_123_10.localPosition = Vector3.New(0, 100, 0)

				local var_123_17 = manager.ui.mainCamera.transform.position - var_123_10.position

				var_123_10.forward = Vector3.New(var_123_17.x, var_123_17.y, var_123_17.z)

				local var_123_18 = var_123_10.localEulerAngles

				var_123_18.z = 0
				var_123_18.x = 0
				var_123_10.localEulerAngles = var_123_18
			end

			local var_123_19 = arg_120_1.actors_["3009ui_story"].transform
			local var_123_20 = 0

			if var_123_20 < arg_120_1.time_ and arg_120_1.time_ <= var_123_20 + arg_123_0 then
				arg_120_1.var_.moveOldPos3009ui_story = var_123_19.localPosition

				local var_123_21 = "3009ui_story"

				arg_120_1:ShowWeapon(arg_120_1.var_[var_123_21 .. "Animator"].transform, true)
			end

			local var_123_22 = 0.001

			if var_123_20 <= arg_120_1.time_ and arg_120_1.time_ < var_123_20 + var_123_22 then
				local var_123_23 = (arg_120_1.time_ - var_123_20) / var_123_22
				local var_123_24 = Vector3.New(0, -1.75, -4.8)

				var_123_19.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos3009ui_story, var_123_24, var_123_23)

				local var_123_25 = manager.ui.mainCamera.transform.position - var_123_19.position

				var_123_19.forward = Vector3.New(var_123_25.x, var_123_25.y, var_123_25.z)

				local var_123_26 = var_123_19.localEulerAngles

				var_123_26.z = 0
				var_123_26.x = 0
				var_123_19.localEulerAngles = var_123_26
			end

			if arg_120_1.time_ >= var_123_20 + var_123_22 and arg_120_1.time_ < var_123_20 + var_123_22 + arg_123_0 then
				var_123_19.localPosition = Vector3.New(0, -1.75, -4.8)

				local var_123_27 = manager.ui.mainCamera.transform.position - var_123_19.position

				var_123_19.forward = Vector3.New(var_123_27.x, var_123_27.y, var_123_27.z)

				local var_123_28 = var_123_19.localEulerAngles

				var_123_28.z = 0
				var_123_28.x = 0
				var_123_19.localEulerAngles = var_123_28
			end

			local var_123_29 = 0

			if var_123_29 < arg_120_1.time_ and arg_120_1.time_ <= var_123_29 + arg_123_0 then
				arg_120_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_123_30 = 0
			local var_123_31 = 0.225

			if var_123_30 < arg_120_1.time_ and arg_120_1.time_ <= var_123_30 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_32 = arg_120_1:FormatText(StoryNameCfg[43].name)

				arg_120_1.leftNameTxt_.text = var_123_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_33 = arg_120_1:GetWordFromCfg(102111030)
				local var_123_34 = arg_120_1:FormatText(var_123_33.content)

				arg_120_1.text_.text = var_123_34

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_35 = 9
				local var_123_36 = utf8.len(var_123_34)
				local var_123_37 = var_123_35 <= 0 and var_123_31 or var_123_31 * (var_123_36 / var_123_35)

				if var_123_37 > 0 and var_123_31 < var_123_37 then
					arg_120_1.talkMaxDuration = var_123_37

					if var_123_37 + var_123_30 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_37 + var_123_30
					end
				end

				arg_120_1.text_.text = var_123_34
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111030", "story_v_out_102111.awb") ~= 0 then
					local var_123_38 = manager.audio:GetVoiceLength("story_v_out_102111", "102111030", "story_v_out_102111.awb") / 1000

					if var_123_38 + var_123_30 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_38 + var_123_30
					end

					if var_123_33.prefab_name ~= "" and arg_120_1.actors_[var_123_33.prefab_name] ~= nil then
						local var_123_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_33.prefab_name].transform, "story_v_out_102111", "102111030", "story_v_out_102111.awb")

						arg_120_1:RecordAudio("102111030", var_123_39)
						arg_120_1:RecordAudio("102111030", var_123_39)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_102111", "102111030", "story_v_out_102111.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_102111", "102111030", "story_v_out_102111.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_40 = math.max(var_123_31, arg_120_1.talkMaxDuration)

			if var_123_30 <= arg_120_1.time_ and arg_120_1.time_ < var_123_30 + var_123_40 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_30) / var_123_40

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_30 + var_123_40 and arg_120_1.time_ < var_123_30 + var_123_40 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3009ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play102111031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 102111031
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play102111032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["3009ui_story"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect3009ui_story == nil then
				arg_124_1.var_.characterEffect3009ui_story = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.1

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.characterEffect3009ui_story and not isNil(var_127_0) then
					local var_127_4 = Mathf.Lerp(0, 0.5, var_127_3)

					arg_124_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_124_1.var_.characterEffect3009ui_story.fillRatio = var_127_4
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect3009ui_story then
				local var_127_5 = 0.5

				arg_124_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_124_1.var_.characterEffect3009ui_story.fillRatio = var_127_5
			end

			local var_127_6 = arg_124_1.actors_["3009ui_story"].transform
			local var_127_7 = 0

			if var_127_7 < arg_124_1.time_ and arg_124_1.time_ <= var_127_7 + arg_127_0 then
				arg_124_1.var_.moveOldPos3009ui_story = var_127_6.localPosition
			end

			local var_127_8 = 0.001

			if var_127_7 <= arg_124_1.time_ and arg_124_1.time_ < var_127_7 + var_127_8 then
				local var_127_9 = (arg_124_1.time_ - var_127_7) / var_127_8
				local var_127_10 = Vector3.New(0, 100, 0)

				var_127_6.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos3009ui_story, var_127_10, var_127_9)

				local var_127_11 = manager.ui.mainCamera.transform.position - var_127_6.position

				var_127_6.forward = Vector3.New(var_127_11.x, var_127_11.y, var_127_11.z)

				local var_127_12 = var_127_6.localEulerAngles

				var_127_12.z = 0
				var_127_12.x = 0
				var_127_6.localEulerAngles = var_127_12
			end

			if arg_124_1.time_ >= var_127_7 + var_127_8 and arg_124_1.time_ < var_127_7 + var_127_8 + arg_127_0 then
				var_127_6.localPosition = Vector3.New(0, 100, 0)

				local var_127_13 = manager.ui.mainCamera.transform.position - var_127_6.position

				var_127_6.forward = Vector3.New(var_127_13.x, var_127_13.y, var_127_13.z)

				local var_127_14 = var_127_6.localEulerAngles

				var_127_14.z = 0
				var_127_14.x = 0
				var_127_6.localEulerAngles = var_127_14
			end

			local var_127_15 = 0

			if var_127_15 < arg_124_1.time_ and arg_124_1.time_ <= var_127_15 + arg_127_0 then
				arg_124_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_127_16 = 0
			local var_127_17 = 0.775

			if var_127_16 < arg_124_1.time_ and arg_124_1.time_ <= var_127_16 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_18 = arg_124_1:GetWordFromCfg(102111031)
				local var_127_19 = arg_124_1:FormatText(var_127_18.content)

				arg_124_1.text_.text = var_127_19

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_20 = 31
				local var_127_21 = utf8.len(var_127_19)
				local var_127_22 = var_127_20 <= 0 and var_127_17 or var_127_17 * (var_127_21 / var_127_20)

				if var_127_22 > 0 and var_127_17 < var_127_22 then
					arg_124_1.talkMaxDuration = var_127_22

					if var_127_22 + var_127_16 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_22 + var_127_16
					end
				end

				arg_124_1.text_.text = var_127_19
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_23 = math.max(var_127_17, arg_124_1.talkMaxDuration)

			if var_127_16 <= arg_124_1.time_ and arg_124_1.time_ < var_127_16 + var_127_23 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_16) / var_127_23

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_16 + var_127_23 and arg_124_1.time_ < var_127_16 + var_127_23 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3009ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play102111032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 102111032
		arg_128_1.duration_ = 6.47

		local var_128_0 = {
			ja = 6.466,
			ko = 2.866,
			zh = 5.666,
			en = 5.533
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
			arg_128_1.auto_ = false
		end

		function arg_128_1.playNext_(arg_130_0)
			arg_128_1.onStoryFinished_()
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1019ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1019ui_story == nil then
				arg_128_1.var_.characterEffect1019ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.1

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect1019ui_story and not isNil(var_131_0) then
					arg_128_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1019ui_story then
				arg_128_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_131_4 = arg_128_1.actors_["1019ui_story"].transform
			local var_131_5 = 0

			if var_131_5 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 then
				arg_128_1.var_.moveOldPos1019ui_story = var_131_4.localPosition
			end

			local var_131_6 = 0.001

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_6 then
				local var_131_7 = (arg_128_1.time_ - var_131_5) / var_131_6
				local var_131_8 = Vector3.New(-0.2, -1.08, -5.9)

				var_131_4.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1019ui_story, var_131_8, var_131_7)

				local var_131_9 = manager.ui.mainCamera.transform.position - var_131_4.position

				var_131_4.forward = Vector3.New(var_131_9.x, var_131_9.y, var_131_9.z)

				local var_131_10 = var_131_4.localEulerAngles

				var_131_10.z = 0
				var_131_10.x = 0
				var_131_4.localEulerAngles = var_131_10
			end

			if arg_128_1.time_ >= var_131_5 + var_131_6 and arg_128_1.time_ < var_131_5 + var_131_6 + arg_131_0 then
				var_131_4.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_131_11 = manager.ui.mainCamera.transform.position - var_131_4.position

				var_131_4.forward = Vector3.New(var_131_11.x, var_131_11.y, var_131_11.z)

				local var_131_12 = var_131_4.localEulerAngles

				var_131_12.z = 0
				var_131_12.x = 0
				var_131_4.localEulerAngles = var_131_12
			end

			local var_131_13 = 0

			if var_131_13 < arg_128_1.time_ and arg_128_1.time_ <= var_131_13 + arg_131_0 then
				arg_128_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_131_14 = 0
			local var_131_15 = 0.5

			if var_131_14 < arg_128_1.time_ and arg_128_1.time_ <= var_131_14 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_16 = arg_128_1:FormatText(StoryNameCfg[13].name)

				arg_128_1.leftNameTxt_.text = var_131_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_17 = arg_128_1:GetWordFromCfg(102111032)
				local var_131_18 = arg_128_1:FormatText(var_131_17.content)

				arg_128_1.text_.text = var_131_18

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_19 = 20
				local var_131_20 = utf8.len(var_131_18)
				local var_131_21 = var_131_19 <= 0 and var_131_15 or var_131_15 * (var_131_20 / var_131_19)

				if var_131_21 > 0 and var_131_15 < var_131_21 then
					arg_128_1.talkMaxDuration = var_131_21

					if var_131_21 + var_131_14 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_21 + var_131_14
					end
				end

				arg_128_1.text_.text = var_131_18
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111032", "story_v_out_102111.awb") ~= 0 then
					local var_131_22 = manager.audio:GetVoiceLength("story_v_out_102111", "102111032", "story_v_out_102111.awb") / 1000

					if var_131_22 + var_131_14 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_22 + var_131_14
					end

					if var_131_17.prefab_name ~= "" and arg_128_1.actors_[var_131_17.prefab_name] ~= nil then
						local var_131_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_17.prefab_name].transform, "story_v_out_102111", "102111032", "story_v_out_102111.awb")

						arg_128_1:RecordAudio("102111032", var_131_23)
						arg_128_1:RecordAudio("102111032", var_131_23)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_102111", "102111032", "story_v_out_102111.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_102111", "102111032", "story_v_out_102111.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_24 = math.max(var_131_15, arg_128_1.talkMaxDuration)

			if var_131_14 <= arg_128_1.time_ and arg_128_1.time_ < var_131_14 + var_131_24 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_14) / var_131_24

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_14 + var_131_24 and arg_128_1.time_ < var_131_14 + var_131_24 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
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

		arg_128_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B08b"
	},
	voices = {
		"story_v_out_102111.awb"
	}
}
