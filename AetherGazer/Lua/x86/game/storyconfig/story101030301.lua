return {
	Play103031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 103031001
		arg_1_1.duration_ = 11.33

		local var_1_0 = {
			ja = 11.333,
			ko = 6.766,
			zh = 8.933,
			en = 10.6
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
				arg_1_0:Play103031002(arg_1_1)
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

			local var_4_10 = "4010ui_story"

			if arg_1_1.actors_[var_4_10] == nil then
				local var_4_11 = Asset.Load("Char/" .. "4010ui_story")

				if not isNil(var_4_11) then
					local var_4_12 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_1_1.stage_.transform)

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

			local var_4_15 = arg_1_1.actors_["4010ui_story"]
			local var_4_16 = 1.8

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect4010ui_story == nil then
				arg_1_1.var_.characterEffect4010ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_17 = 0.1

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 and not isNil(var_4_15) then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17

				if arg_1_1.var_.characterEffect4010ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect4010ui_story then
				arg_1_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_4_19 = 0

			if var_4_19 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_20 = 2

			if var_4_19 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				local var_4_21 = (arg_1_1.time_ - var_4_19) / var_4_20
				local var_4_22 = Color.New(0, 0, 0)

				var_4_22.a = Mathf.Lerp(1, 0, var_4_21)
				arg_1_1.mask_.color = var_4_22
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				local var_4_23 = Color.New(0, 0, 0)
				local var_4_24 = 0

				arg_1_1.mask_.enabled = false
				var_4_23.a = var_4_24
				arg_1_1.mask_.color = var_4_23
			end

			local var_4_25 = "B08b"

			if arg_1_1.bgs_[var_4_25] == nil then
				local var_4_26 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_26:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_25)
				var_4_26.name = var_4_25
				var_4_26.transform.parent = arg_1_1.stage_.transform
				var_4_26.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_25] = var_4_26
			end

			local var_4_27 = 0

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				local var_4_28 = manager.ui.mainCamera.transform.localPosition
				local var_4_29 = Vector3.New(0, 0, 10) + Vector3.New(var_4_28.x, var_4_28.y, 0)
				local var_4_30 = arg_1_1.bgs_.B08b

				var_4_30.transform.localPosition = var_4_29
				var_4_30.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_31 = var_4_30:GetComponent("SpriteRenderer")

				if var_4_31 and var_4_31.sprite then
					local var_4_32 = (var_4_30.transform.localPosition - var_4_28).z
					local var_4_33 = manager.ui.mainCameraCom_
					local var_4_34 = 2 * var_4_32 * Mathf.Tan(var_4_33.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_35 = var_4_34 * var_4_33.aspect
					local var_4_36 = var_4_31.sprite.bounds.size.x
					local var_4_37 = var_4_31.sprite.bounds.size.y
					local var_4_38 = var_4_35 / var_4_36
					local var_4_39 = var_4_34 / var_4_37
					local var_4_40 = var_4_39 < var_4_38 and var_4_38 or var_4_39

					var_4_30.transform.localScale = Vector3.New(var_4_40, var_4_40, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B08b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_41 = arg_1_1.actors_["4010ui_story"].transform
			local var_4_42 = 1.79999995231628

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1.var_.moveOldPos4010ui_story = var_4_41.localPosition
			end

			local var_4_43 = 0.001

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				local var_4_44 = (arg_1_1.time_ - var_4_42) / var_4_43
				local var_4_45 = Vector3.New(0, -1.59, -5.2)

				var_4_41.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos4010ui_story, var_4_45, var_4_44)

				local var_4_46 = manager.ui.mainCamera.transform.position - var_4_41.position

				var_4_41.forward = Vector3.New(var_4_46.x, var_4_46.y, var_4_46.z)

				local var_4_47 = var_4_41.localEulerAngles

				var_4_47.z = 0
				var_4_47.x = 0
				var_4_41.localEulerAngles = var_4_47
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				var_4_41.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_4_48 = manager.ui.mainCamera.transform.position - var_4_41.position

				var_4_41.forward = Vector3.New(var_4_48.x, var_4_48.y, var_4_48.z)

				local var_4_49 = var_4_41.localEulerAngles

				var_4_49.z = 0
				var_4_49.x = 0
				var_4_41.localEulerAngles = var_4_49
			end

			local var_4_50 = 1.8

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				arg_1_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_4_51 = 1.8

			if var_4_51 < arg_1_1.time_ and arg_1_1.time_ <= var_4_51 + arg_4_0 then
				arg_1_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_52 = 2
			local var_4_53 = 0.7

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_54 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_54:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_55 = arg_1_1:FormatText(StoryNameCfg[42].name)

				arg_1_1.leftNameTxt_.text = var_4_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_56 = arg_1_1:GetWordFromCfg(103031001)
				local var_4_57 = arg_1_1:FormatText(var_4_56.content)

				arg_1_1.text_.text = var_4_57

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_58 = 28
				local var_4_59 = utf8.len(var_4_57)
				local var_4_60 = var_4_58 <= 0 and var_4_53 or var_4_53 * (var_4_59 / var_4_58)

				if var_4_60 > 0 and var_4_53 < var_4_60 then
					arg_1_1.talkMaxDuration = var_4_60
					var_4_52 = var_4_52 + 0.3

					if var_4_60 + var_4_52 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_60 + var_4_52
					end
				end

				arg_1_1.text_.text = var_4_57
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031001", "story_v_out_103031.awb") ~= 0 then
					local var_4_61 = manager.audio:GetVoiceLength("story_v_out_103031", "103031001", "story_v_out_103031.awb") / 1000

					if var_4_61 + var_4_52 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_61 + var_4_52
					end

					if var_4_56.prefab_name ~= "" and arg_1_1.actors_[var_4_56.prefab_name] ~= nil then
						local var_4_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_56.prefab_name].transform, "story_v_out_103031", "103031001", "story_v_out_103031.awb")

						arg_1_1:RecordAudio("103031001", var_4_62)
						arg_1_1:RecordAudio("103031001", var_4_62)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_103031", "103031001", "story_v_out_103031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_103031", "103031001", "story_v_out_103031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_63 = var_4_52 + 0.3
			local var_4_64 = math.max(var_4_53, arg_1_1.talkMaxDuration)

			if var_4_63 <= arg_1_1.time_ and arg_1_1.time_ < var_4_63 + var_4_64 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_63) / var_4_64

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_63 + var_4_64 and arg_1_1.time_ < var_4_63 + var_4_64 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play103031002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 103031002
		arg_8_1.duration_ = 2

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play103031003(arg_8_1)
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

			local var_11_9 = "1019ui_story"

			if arg_8_1.actors_[var_11_9] == nil then
				local var_11_10 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_11_10) then
					local var_11_11 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_8_1.stage_.transform)

					var_11_11.name = var_11_9
					var_11_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_8_1.actors_[var_11_9] = var_11_11

					local var_11_12 = var_11_11:GetComponentInChildren(typeof(CharacterEffect))

					var_11_12.enabled = true

					local var_11_13 = GameObjectTools.GetOrAddComponent(var_11_11, typeof(DynamicBoneHelper))

					if var_11_13 then
						var_11_13:EnableDynamicBone(false)
					end

					arg_8_1:ShowWeapon(var_11_12.transform, false)

					arg_8_1.var_[var_11_9 .. "Animator"] = var_11_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_8_1.var_[var_11_9 .. "Animator"].applyRootMotion = true
					arg_8_1.var_[var_11_9 .. "LipSync"] = var_11_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_11_14 = arg_8_1.actors_["1019ui_story"]
			local var_11_15 = 0

			if var_11_15 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 and not isNil(var_11_14) and arg_8_1.var_.characterEffect1019ui_story == nil then
				arg_8_1.var_.characterEffect1019ui_story = var_11_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_16 = 0.1

			if var_11_15 <= arg_8_1.time_ and arg_8_1.time_ < var_11_15 + var_11_16 and not isNil(var_11_14) then
				local var_11_17 = (arg_8_1.time_ - var_11_15) / var_11_16

				if arg_8_1.var_.characterEffect1019ui_story and not isNil(var_11_14) then
					arg_8_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_15 + var_11_16 and arg_8_1.time_ < var_11_15 + var_11_16 + arg_11_0 and not isNil(var_11_14) and arg_8_1.var_.characterEffect1019ui_story then
				arg_8_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_11_18 = "1084ui_story"

			if arg_8_1.actors_[var_11_18] == nil then
				local var_11_19 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_11_19) then
					local var_11_20 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_8_1.stage_.transform)

					var_11_20.name = var_11_18
					var_11_20.transform.localPosition = Vector3.New(0, 100, 0)
					arg_8_1.actors_[var_11_18] = var_11_20

					local var_11_21 = var_11_20:GetComponentInChildren(typeof(CharacterEffect))

					var_11_21.enabled = true

					local var_11_22 = GameObjectTools.GetOrAddComponent(var_11_20, typeof(DynamicBoneHelper))

					if var_11_22 then
						var_11_22:EnableDynamicBone(false)
					end

					arg_8_1:ShowWeapon(var_11_21.transform, false)

					arg_8_1.var_[var_11_18 .. "Animator"] = var_11_21.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_8_1.var_[var_11_18 .. "Animator"].applyRootMotion = true
					arg_8_1.var_[var_11_18 .. "LipSync"] = var_11_21.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_11_23 = arg_8_1.actors_["1084ui_story"]
			local var_11_24 = 0

			if var_11_24 < arg_8_1.time_ and arg_8_1.time_ <= var_11_24 + arg_11_0 and not isNil(var_11_23) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_25 = 0.1

			if var_11_24 <= arg_8_1.time_ and arg_8_1.time_ < var_11_24 + var_11_25 and not isNil(var_11_23) then
				local var_11_26 = (arg_8_1.time_ - var_11_24) / var_11_25

				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_23) then
					arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_24 + var_11_25 and arg_8_1.time_ < var_11_24 + var_11_25 + arg_11_0 and not isNil(var_11_23) and arg_8_1.var_.characterEffect1084ui_story then
				arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_11_27 = arg_8_1.actors_["4010ui_story"]
			local var_11_28 = 0

			if var_11_28 < arg_8_1.time_ and arg_8_1.time_ <= var_11_28 + arg_11_0 and not isNil(var_11_27) and arg_8_1.var_.characterEffect4010ui_story == nil then
				arg_8_1.var_.characterEffect4010ui_story = var_11_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_29 = 0.1

			if var_11_28 <= arg_8_1.time_ and arg_8_1.time_ < var_11_28 + var_11_29 and not isNil(var_11_27) then
				local var_11_30 = (arg_8_1.time_ - var_11_28) / var_11_29

				if arg_8_1.var_.characterEffect4010ui_story and not isNil(var_11_27) then
					local var_11_31 = Mathf.Lerp(0, 0.5, var_11_30)

					arg_8_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_8_1.var_.characterEffect4010ui_story.fillRatio = var_11_31
				end
			end

			if arg_8_1.time_ >= var_11_28 + var_11_29 and arg_8_1.time_ < var_11_28 + var_11_29 + arg_11_0 and not isNil(var_11_27) and arg_8_1.var_.characterEffect4010ui_story then
				local var_11_32 = 0.5

				arg_8_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_8_1.var_.characterEffect4010ui_story.fillRatio = var_11_32
			end

			local var_11_33 = arg_8_1.actors_["4010ui_story"].transform
			local var_11_34 = 0

			if var_11_34 < arg_8_1.time_ and arg_8_1.time_ <= var_11_34 + arg_11_0 then
				arg_8_1.var_.moveOldPos4010ui_story = var_11_33.localPosition
			end

			local var_11_35 = 0.001

			if var_11_34 <= arg_8_1.time_ and arg_8_1.time_ < var_11_34 + var_11_35 then
				local var_11_36 = (arg_8_1.time_ - var_11_34) / var_11_35
				local var_11_37 = Vector3.New(0, 100, 0)

				var_11_33.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos4010ui_story, var_11_37, var_11_36)

				local var_11_38 = manager.ui.mainCamera.transform.position - var_11_33.position

				var_11_33.forward = Vector3.New(var_11_38.x, var_11_38.y, var_11_38.z)

				local var_11_39 = var_11_33.localEulerAngles

				var_11_39.z = 0
				var_11_39.x = 0
				var_11_33.localEulerAngles = var_11_39
			end

			if arg_8_1.time_ >= var_11_34 + var_11_35 and arg_8_1.time_ < var_11_34 + var_11_35 + arg_11_0 then
				var_11_33.localPosition = Vector3.New(0, 100, 0)

				local var_11_40 = manager.ui.mainCamera.transform.position - var_11_33.position

				var_11_33.forward = Vector3.New(var_11_40.x, var_11_40.y, var_11_40.z)

				local var_11_41 = var_11_33.localEulerAngles

				var_11_41.z = 0
				var_11_41.x = 0
				var_11_33.localEulerAngles = var_11_41
			end

			local var_11_42 = 0

			if var_11_42 < arg_8_1.time_ and arg_8_1.time_ <= var_11_42 + arg_11_0 then
				arg_8_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_11_43 = arg_8_1.actors_["1011ui_story"].transform
			local var_11_44 = 0

			if var_11_44 < arg_8_1.time_ and arg_8_1.time_ <= var_11_44 + arg_11_0 then
				arg_8_1.var_.moveOldPos1011ui_story = var_11_43.localPosition
			end

			local var_11_45 = 0.001

			if var_11_44 <= arg_8_1.time_ and arg_8_1.time_ < var_11_44 + var_11_45 then
				local var_11_46 = (arg_8_1.time_ - var_11_44) / var_11_45
				local var_11_47 = Vector3.New(-0.7, -0.71, -6)

				var_11_43.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1011ui_story, var_11_47, var_11_46)

				local var_11_48 = manager.ui.mainCamera.transform.position - var_11_43.position

				var_11_43.forward = Vector3.New(var_11_48.x, var_11_48.y, var_11_48.z)

				local var_11_49 = var_11_43.localEulerAngles

				var_11_49.z = 0
				var_11_49.x = 0
				var_11_43.localEulerAngles = var_11_49
			end

			if arg_8_1.time_ >= var_11_44 + var_11_45 and arg_8_1.time_ < var_11_44 + var_11_45 + arg_11_0 then
				var_11_43.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_11_50 = manager.ui.mainCamera.transform.position - var_11_43.position

				var_11_43.forward = Vector3.New(var_11_50.x, var_11_50.y, var_11_50.z)

				local var_11_51 = var_11_43.localEulerAngles

				var_11_51.z = 0
				var_11_51.x = 0
				var_11_43.localEulerAngles = var_11_51
			end

			local var_11_52 = 0

			if var_11_52 < arg_8_1.time_ and arg_8_1.time_ <= var_11_52 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_11_53 = arg_8_1.actors_["1084ui_story"].transform
			local var_11_54 = 0

			if var_11_54 < arg_8_1.time_ and arg_8_1.time_ <= var_11_54 + arg_11_0 then
				arg_8_1.var_.moveOldPos1084ui_story = var_11_53.localPosition
			end

			local var_11_55 = 0.001

			if var_11_54 <= arg_8_1.time_ and arg_8_1.time_ < var_11_54 + var_11_55 then
				local var_11_56 = (arg_8_1.time_ - var_11_54) / var_11_55
				local var_11_57 = Vector3.New(0, -0.97, -6)

				var_11_53.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1084ui_story, var_11_57, var_11_56)

				local var_11_58 = manager.ui.mainCamera.transform.position - var_11_53.position

				var_11_53.forward = Vector3.New(var_11_58.x, var_11_58.y, var_11_58.z)

				local var_11_59 = var_11_53.localEulerAngles

				var_11_59.z = 0
				var_11_59.x = 0
				var_11_53.localEulerAngles = var_11_59
			end

			if arg_8_1.time_ >= var_11_54 + var_11_55 and arg_8_1.time_ < var_11_54 + var_11_55 + arg_11_0 then
				var_11_53.localPosition = Vector3.New(0, -0.97, -6)

				local var_11_60 = manager.ui.mainCamera.transform.position - var_11_53.position

				var_11_53.forward = Vector3.New(var_11_60.x, var_11_60.y, var_11_60.z)

				local var_11_61 = var_11_53.localEulerAngles

				var_11_61.z = 0
				var_11_61.x = 0
				var_11_53.localEulerAngles = var_11_61
			end

			local var_11_62 = 0

			if var_11_62 < arg_8_1.time_ and arg_8_1.time_ <= var_11_62 + arg_11_0 then
				arg_8_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_11_63 = arg_8_1.actors_["1019ui_story"].transform
			local var_11_64 = 0

			if var_11_64 < arg_8_1.time_ and arg_8_1.time_ <= var_11_64 + arg_11_0 then
				arg_8_1.var_.moveOldPos1019ui_story = var_11_63.localPosition
			end

			local var_11_65 = 0.001

			if var_11_64 <= arg_8_1.time_ and arg_8_1.time_ < var_11_64 + var_11_65 then
				local var_11_66 = (arg_8_1.time_ - var_11_64) / var_11_65
				local var_11_67 = Vector3.New(0.7, -1.08, -5.9)

				var_11_63.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1019ui_story, var_11_67, var_11_66)

				local var_11_68 = manager.ui.mainCamera.transform.position - var_11_63.position

				var_11_63.forward = Vector3.New(var_11_68.x, var_11_68.y, var_11_68.z)

				local var_11_69 = var_11_63.localEulerAngles

				var_11_69.z = 0
				var_11_69.x = 0
				var_11_63.localEulerAngles = var_11_69
			end

			if arg_8_1.time_ >= var_11_64 + var_11_65 and arg_8_1.time_ < var_11_64 + var_11_65 + arg_11_0 then
				var_11_63.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_11_70 = manager.ui.mainCamera.transform.position - var_11_63.position

				var_11_63.forward = Vector3.New(var_11_70.x, var_11_70.y, var_11_70.z)

				local var_11_71 = var_11_63.localEulerAngles

				var_11_71.z = 0
				var_11_71.x = 0
				var_11_63.localEulerAngles = var_11_71
			end

			local var_11_72 = 0

			if var_11_72 < arg_8_1.time_ and arg_8_1.time_ <= var_11_72 + arg_11_0 then
				arg_8_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_11_73 = 0
			local var_11_74 = 0.05

			if var_11_73 < arg_8_1.time_ and arg_8_1.time_ <= var_11_73 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_75 = arg_8_1:FormatText(StoryNameCfg[50].name)

				arg_8_1.leftNameTxt_.text = var_11_75

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_76 = arg_8_1:GetWordFromCfg(103031002)
				local var_11_77 = arg_8_1:FormatText(var_11_76.content)

				arg_8_1.text_.text = var_11_77

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_78 = 2
				local var_11_79 = utf8.len(var_11_77)
				local var_11_80 = var_11_78 <= 0 and var_11_74 or var_11_74 * (var_11_79 / var_11_78)

				if var_11_80 > 0 and var_11_74 < var_11_80 then
					arg_8_1.talkMaxDuration = var_11_80

					if var_11_80 + var_11_73 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_80 + var_11_73
					end
				end

				arg_8_1.text_.text = var_11_77
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031002", "story_v_out_103031.awb") ~= 0 then
					local var_11_81 = manager.audio:GetVoiceLength("story_v_out_103031", "103031002", "story_v_out_103031.awb") / 1000

					if var_11_81 + var_11_73 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_81 + var_11_73
					end

					if var_11_76.prefab_name ~= "" and arg_8_1.actors_[var_11_76.prefab_name] ~= nil then
						local var_11_82 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_76.prefab_name].transform, "story_v_out_103031", "103031002", "story_v_out_103031.awb")

						arg_8_1:RecordAudio("103031002", var_11_82)
						arg_8_1:RecordAudio("103031002", var_11_82)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_103031", "103031002", "story_v_out_103031.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_103031", "103031002", "story_v_out_103031.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_83 = math.max(var_11_74, arg_8_1.talkMaxDuration)

			if var_11_73 <= arg_8_1.time_ and arg_8_1.time_ < var_11_73 + var_11_83 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_73) / var_11_83

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_73 + var_11_83 and arg_8_1.time_ < var_11_73 + var_11_83 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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

		arg_8_1:InitPlayNodeList()
	end,
	Play103031003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 103031003
		arg_12_1.duration_ = 5.7

		local var_12_0 = {
			ja = 5.1,
			ko = 3.8,
			zh = 5.7,
			en = 5.3
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
				arg_12_0:Play103031004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["4010ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect4010ui_story == nil then
				arg_12_1.var_.characterEffect4010ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.1

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect4010ui_story and not isNil(var_15_0) then
					arg_12_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect4010ui_story then
				arg_12_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_15_4 = arg_12_1.actors_["1011ui_story"].transform
			local var_15_5 = 0

			if var_15_5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 then
				arg_12_1.var_.moveOldPos1011ui_story = var_15_4.localPosition
			end

			local var_15_6 = 0.001

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_6 then
				local var_15_7 = (arg_12_1.time_ - var_15_5) / var_15_6
				local var_15_8 = Vector3.New(0, 100, 0)

				var_15_4.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1011ui_story, var_15_8, var_15_7)

				local var_15_9 = manager.ui.mainCamera.transform.position - var_15_4.position

				var_15_4.forward = Vector3.New(var_15_9.x, var_15_9.y, var_15_9.z)

				local var_15_10 = var_15_4.localEulerAngles

				var_15_10.z = 0
				var_15_10.x = 0
				var_15_4.localEulerAngles = var_15_10
			end

			if arg_12_1.time_ >= var_15_5 + var_15_6 and arg_12_1.time_ < var_15_5 + var_15_6 + arg_15_0 then
				var_15_4.localPosition = Vector3.New(0, 100, 0)

				local var_15_11 = manager.ui.mainCamera.transform.position - var_15_4.position

				var_15_4.forward = Vector3.New(var_15_11.x, var_15_11.y, var_15_11.z)

				local var_15_12 = var_15_4.localEulerAngles

				var_15_12.z = 0
				var_15_12.x = 0
				var_15_4.localEulerAngles = var_15_12
			end

			local var_15_13 = arg_12_1.actors_["1084ui_story"].transform
			local var_15_14 = 0

			if var_15_14 < arg_12_1.time_ and arg_12_1.time_ <= var_15_14 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = var_15_13.localPosition
			end

			local var_15_15 = 0.001

			if var_15_14 <= arg_12_1.time_ and arg_12_1.time_ < var_15_14 + var_15_15 then
				local var_15_16 = (arg_12_1.time_ - var_15_14) / var_15_15
				local var_15_17 = Vector3.New(0, 100, 0)

				var_15_13.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, var_15_17, var_15_16)

				local var_15_18 = manager.ui.mainCamera.transform.position - var_15_13.position

				var_15_13.forward = Vector3.New(var_15_18.x, var_15_18.y, var_15_18.z)

				local var_15_19 = var_15_13.localEulerAngles

				var_15_19.z = 0
				var_15_19.x = 0
				var_15_13.localEulerAngles = var_15_19
			end

			if arg_12_1.time_ >= var_15_14 + var_15_15 and arg_12_1.time_ < var_15_14 + var_15_15 + arg_15_0 then
				var_15_13.localPosition = Vector3.New(0, 100, 0)

				local var_15_20 = manager.ui.mainCamera.transform.position - var_15_13.position

				var_15_13.forward = Vector3.New(var_15_20.x, var_15_20.y, var_15_20.z)

				local var_15_21 = var_15_13.localEulerAngles

				var_15_21.z = 0
				var_15_21.x = 0
				var_15_13.localEulerAngles = var_15_21
			end

			local var_15_22 = arg_12_1.actors_["1019ui_story"].transform
			local var_15_23 = 0

			if var_15_23 < arg_12_1.time_ and arg_12_1.time_ <= var_15_23 + arg_15_0 then
				arg_12_1.var_.moveOldPos1019ui_story = var_15_22.localPosition
			end

			local var_15_24 = 0.001

			if var_15_23 <= arg_12_1.time_ and arg_12_1.time_ < var_15_23 + var_15_24 then
				local var_15_25 = (arg_12_1.time_ - var_15_23) / var_15_24
				local var_15_26 = Vector3.New(0, 100, 0)

				var_15_22.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1019ui_story, var_15_26, var_15_25)

				local var_15_27 = manager.ui.mainCamera.transform.position - var_15_22.position

				var_15_22.forward = Vector3.New(var_15_27.x, var_15_27.y, var_15_27.z)

				local var_15_28 = var_15_22.localEulerAngles

				var_15_28.z = 0
				var_15_28.x = 0
				var_15_22.localEulerAngles = var_15_28
			end

			if arg_12_1.time_ >= var_15_23 + var_15_24 and arg_12_1.time_ < var_15_23 + var_15_24 + arg_15_0 then
				var_15_22.localPosition = Vector3.New(0, 100, 0)

				local var_15_29 = manager.ui.mainCamera.transform.position - var_15_22.position

				var_15_22.forward = Vector3.New(var_15_29.x, var_15_29.y, var_15_29.z)

				local var_15_30 = var_15_22.localEulerAngles

				var_15_30.z = 0
				var_15_30.x = 0
				var_15_22.localEulerAngles = var_15_30
			end

			local var_15_31 = arg_12_1.actors_["4010ui_story"].transform
			local var_15_32 = 0

			if var_15_32 < arg_12_1.time_ and arg_12_1.time_ <= var_15_32 + arg_15_0 then
				arg_12_1.var_.moveOldPos4010ui_story = var_15_31.localPosition
			end

			local var_15_33 = 0.001

			if var_15_32 <= arg_12_1.time_ and arg_12_1.time_ < var_15_32 + var_15_33 then
				local var_15_34 = (arg_12_1.time_ - var_15_32) / var_15_33
				local var_15_35 = Vector3.New(0, -1.59, -5.2)

				var_15_31.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos4010ui_story, var_15_35, var_15_34)

				local var_15_36 = manager.ui.mainCamera.transform.position - var_15_31.position

				var_15_31.forward = Vector3.New(var_15_36.x, var_15_36.y, var_15_36.z)

				local var_15_37 = var_15_31.localEulerAngles

				var_15_37.z = 0
				var_15_37.x = 0
				var_15_31.localEulerAngles = var_15_37
			end

			if arg_12_1.time_ >= var_15_32 + var_15_33 and arg_12_1.time_ < var_15_32 + var_15_33 + arg_15_0 then
				var_15_31.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_15_38 = manager.ui.mainCamera.transform.position - var_15_31.position

				var_15_31.forward = Vector3.New(var_15_38.x, var_15_38.y, var_15_38.z)

				local var_15_39 = var_15_31.localEulerAngles

				var_15_39.z = 0
				var_15_39.x = 0
				var_15_31.localEulerAngles = var_15_39
			end

			local var_15_40 = 0

			if var_15_40 < arg_12_1.time_ and arg_12_1.time_ <= var_15_40 + arg_15_0 then
				arg_12_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			local var_15_41 = 0

			if var_15_41 < arg_12_1.time_ and arg_12_1.time_ <= var_15_41 + arg_15_0 then
				arg_12_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_15_42 = 0
			local var_15_43 = 0.65

			if var_15_42 < arg_12_1.time_ and arg_12_1.time_ <= var_15_42 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_44 = arg_12_1:FormatText(StoryNameCfg[42].name)

				arg_12_1.leftNameTxt_.text = var_15_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_45 = arg_12_1:GetWordFromCfg(103031003)
				local var_15_46 = arg_12_1:FormatText(var_15_45.content)

				arg_12_1.text_.text = var_15_46

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_47 = 25
				local var_15_48 = utf8.len(var_15_46)
				local var_15_49 = var_15_47 <= 0 and var_15_43 or var_15_43 * (var_15_48 / var_15_47)

				if var_15_49 > 0 and var_15_43 < var_15_49 then
					arg_12_1.talkMaxDuration = var_15_49

					if var_15_49 + var_15_42 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_49 + var_15_42
					end
				end

				arg_12_1.text_.text = var_15_46
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031003", "story_v_out_103031.awb") ~= 0 then
					local var_15_50 = manager.audio:GetVoiceLength("story_v_out_103031", "103031003", "story_v_out_103031.awb") / 1000

					if var_15_50 + var_15_42 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_50 + var_15_42
					end

					if var_15_45.prefab_name ~= "" and arg_12_1.actors_[var_15_45.prefab_name] ~= nil then
						local var_15_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_45.prefab_name].transform, "story_v_out_103031", "103031003", "story_v_out_103031.awb")

						arg_12_1:RecordAudio("103031003", var_15_51)
						arg_12_1:RecordAudio("103031003", var_15_51)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_103031", "103031003", "story_v_out_103031.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_103031", "103031003", "story_v_out_103031.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_52 = math.max(var_15_43, arg_12_1.talkMaxDuration)

			if var_15_42 <= arg_12_1.time_ and arg_12_1.time_ < var_15_42 + var_15_52 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_42) / var_15_52

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_42 + var_15_52 and arg_12_1.time_ < var_15_42 + var_15_52 + arg_15_0 then
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
				actorName = "4010ui_story",
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
	Play103031004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 103031004
		arg_16_1.duration_ = 4.6

		local var_16_0 = {
			ja = 4.266,
			ko = 4.033,
			zh = 4.6,
			en = 3.533
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
				arg_16_0:Play103031005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1011ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1011ui_story == nil then
				arg_16_1.var_.characterEffect1011ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.1

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect1011ui_story and not isNil(var_19_0) then
					arg_16_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1011ui_story then
				arg_16_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_19_4 = arg_16_1.actors_["4010ui_story"]
			local var_19_5 = 0

			if var_19_5 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.characterEffect4010ui_story == nil then
				arg_16_1.var_.characterEffect4010ui_story = var_19_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_6 = 0.1

			if var_19_5 <= arg_16_1.time_ and arg_16_1.time_ < var_19_5 + var_19_6 and not isNil(var_19_4) then
				local var_19_7 = (arg_16_1.time_ - var_19_5) / var_19_6

				if arg_16_1.var_.characterEffect4010ui_story and not isNil(var_19_4) then
					local var_19_8 = Mathf.Lerp(0, 0.5, var_19_7)

					arg_16_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_16_1.var_.characterEffect4010ui_story.fillRatio = var_19_8
				end
			end

			if arg_16_1.time_ >= var_19_5 + var_19_6 and arg_16_1.time_ < var_19_5 + var_19_6 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.characterEffect4010ui_story then
				local var_19_9 = 0.5

				arg_16_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_16_1.var_.characterEffect4010ui_story.fillRatio = var_19_9
			end

			local var_19_10 = arg_16_1.actors_["4010ui_story"].transform
			local var_19_11 = 0

			if var_19_11 < arg_16_1.time_ and arg_16_1.time_ <= var_19_11 + arg_19_0 then
				arg_16_1.var_.moveOldPos4010ui_story = var_19_10.localPosition
			end

			local var_19_12 = 0.001

			if var_19_11 <= arg_16_1.time_ and arg_16_1.time_ < var_19_11 + var_19_12 then
				local var_19_13 = (arg_16_1.time_ - var_19_11) / var_19_12
				local var_19_14 = Vector3.New(0, 100, 0)

				var_19_10.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos4010ui_story, var_19_14, var_19_13)

				local var_19_15 = manager.ui.mainCamera.transform.position - var_19_10.position

				var_19_10.forward = Vector3.New(var_19_15.x, var_19_15.y, var_19_15.z)

				local var_19_16 = var_19_10.localEulerAngles

				var_19_16.z = 0
				var_19_16.x = 0
				var_19_10.localEulerAngles = var_19_16
			end

			if arg_16_1.time_ >= var_19_11 + var_19_12 and arg_16_1.time_ < var_19_11 + var_19_12 + arg_19_0 then
				var_19_10.localPosition = Vector3.New(0, 100, 0)

				local var_19_17 = manager.ui.mainCamera.transform.position - var_19_10.position

				var_19_10.forward = Vector3.New(var_19_17.x, var_19_17.y, var_19_17.z)

				local var_19_18 = var_19_10.localEulerAngles

				var_19_18.z = 0
				var_19_18.x = 0
				var_19_10.localEulerAngles = var_19_18
			end

			local var_19_19 = arg_16_1.actors_["1011ui_story"].transform
			local var_19_20 = 0

			if var_19_20 < arg_16_1.time_ and arg_16_1.time_ <= var_19_20 + arg_19_0 then
				arg_16_1.var_.moveOldPos1011ui_story = var_19_19.localPosition
			end

			local var_19_21 = 0.001

			if var_19_20 <= arg_16_1.time_ and arg_16_1.time_ < var_19_20 + var_19_21 then
				local var_19_22 = (arg_16_1.time_ - var_19_20) / var_19_21
				local var_19_23 = Vector3.New(-0.7, -0.71, -6)

				var_19_19.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1011ui_story, var_19_23, var_19_22)

				local var_19_24 = manager.ui.mainCamera.transform.position - var_19_19.position

				var_19_19.forward = Vector3.New(var_19_24.x, var_19_24.y, var_19_24.z)

				local var_19_25 = var_19_19.localEulerAngles

				var_19_25.z = 0
				var_19_25.x = 0
				var_19_19.localEulerAngles = var_19_25
			end

			if arg_16_1.time_ >= var_19_20 + var_19_21 and arg_16_1.time_ < var_19_20 + var_19_21 + arg_19_0 then
				var_19_19.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_19_26 = manager.ui.mainCamera.transform.position - var_19_19.position

				var_19_19.forward = Vector3.New(var_19_26.x, var_19_26.y, var_19_26.z)

				local var_19_27 = var_19_19.localEulerAngles

				var_19_27.z = 0
				var_19_27.x = 0
				var_19_19.localEulerAngles = var_19_27
			end

			local var_19_28 = 0

			if var_19_28 < arg_16_1.time_ and arg_16_1.time_ <= var_19_28 + arg_19_0 then
				arg_16_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			local var_19_29 = 0

			if var_19_29 < arg_16_1.time_ and arg_16_1.time_ <= var_19_29 + arg_19_0 then
				arg_16_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_19_30 = 0
			local var_19_31 = 0.375

			if var_19_30 < arg_16_1.time_ and arg_16_1.time_ <= var_19_30 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_32 = arg_16_1:FormatText(StoryNameCfg[37].name)

				arg_16_1.leftNameTxt_.text = var_19_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_33 = arg_16_1:GetWordFromCfg(103031004)
				local var_19_34 = arg_16_1:FormatText(var_19_33.content)

				arg_16_1.text_.text = var_19_34

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_35 = 15
				local var_19_36 = utf8.len(var_19_34)
				local var_19_37 = var_19_35 <= 0 and var_19_31 or var_19_31 * (var_19_36 / var_19_35)

				if var_19_37 > 0 and var_19_31 < var_19_37 then
					arg_16_1.talkMaxDuration = var_19_37

					if var_19_37 + var_19_30 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_37 + var_19_30
					end
				end

				arg_16_1.text_.text = var_19_34
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031004", "story_v_out_103031.awb") ~= 0 then
					local var_19_38 = manager.audio:GetVoiceLength("story_v_out_103031", "103031004", "story_v_out_103031.awb") / 1000

					if var_19_38 + var_19_30 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_38 + var_19_30
					end

					if var_19_33.prefab_name ~= "" and arg_16_1.actors_[var_19_33.prefab_name] ~= nil then
						local var_19_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_33.prefab_name].transform, "story_v_out_103031", "103031004", "story_v_out_103031.awb")

						arg_16_1:RecordAudio("103031004", var_19_39)
						arg_16_1:RecordAudio("103031004", var_19_39)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_103031", "103031004", "story_v_out_103031.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_103031", "103031004", "story_v_out_103031.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_40 = math.max(var_19_31, arg_16_1.talkMaxDuration)

			if var_19_30 <= arg_16_1.time_ and arg_16_1.time_ < var_19_30 + var_19_40 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_30) / var_19_40

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_30 + var_19_40 and arg_16_1.time_ < var_19_30 + var_19_40 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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

		arg_16_1:InitPlayNodeList()
	end,
	Play103031005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 103031005
		arg_20_1.duration_ = 5.17

		local var_20_0 = {
			ja = 5.166,
			ko = 4.266,
			zh = 4.4,
			en = 4.233
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
				arg_20_0:Play103031006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1019ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1019ui_story == nil then
				arg_20_1.var_.characterEffect1019ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.1

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1019ui_story and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1019ui_story then
				arg_20_1.var_.characterEffect1019ui_story.fillFlat = false
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

			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_23_11 = arg_20_1.actors_["1019ui_story"].transform
			local var_23_12 = 0

			if var_23_12 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 then
				arg_20_1.var_.moveOldPos1019ui_story = var_23_11.localPosition
			end

			local var_23_13 = 0.001

			if var_23_12 <= arg_20_1.time_ and arg_20_1.time_ < var_23_12 + var_23_13 then
				local var_23_14 = (arg_20_1.time_ - var_23_12) / var_23_13
				local var_23_15 = Vector3.New(0.7, -1.08, -5.9)

				var_23_11.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1019ui_story, var_23_15, var_23_14)

				local var_23_16 = manager.ui.mainCamera.transform.position - var_23_11.position

				var_23_11.forward = Vector3.New(var_23_16.x, var_23_16.y, var_23_16.z)

				local var_23_17 = var_23_11.localEulerAngles

				var_23_17.z = 0
				var_23_17.x = 0
				var_23_11.localEulerAngles = var_23_17
			end

			if arg_20_1.time_ >= var_23_12 + var_23_13 and arg_20_1.time_ < var_23_12 + var_23_13 + arg_23_0 then
				var_23_11.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_23_18 = manager.ui.mainCamera.transform.position - var_23_11.position

				var_23_11.forward = Vector3.New(var_23_18.x, var_23_18.y, var_23_18.z)

				local var_23_19 = var_23_11.localEulerAngles

				var_23_19.z = 0
				var_23_19.x = 0
				var_23_11.localEulerAngles = var_23_19
			end

			local var_23_20 = 0

			if var_23_20 < arg_20_1.time_ and arg_20_1.time_ <= var_23_20 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_23_21 = 0
			local var_23_22 = 0.45

			if var_23_21 < arg_20_1.time_ and arg_20_1.time_ <= var_23_21 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_23 = arg_20_1:FormatText(StoryNameCfg[13].name)

				arg_20_1.leftNameTxt_.text = var_23_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_24 = arg_20_1:GetWordFromCfg(103031005)
				local var_23_25 = arg_20_1:FormatText(var_23_24.content)

				arg_20_1.text_.text = var_23_25

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_26 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031005", "story_v_out_103031.awb") ~= 0 then
					local var_23_29 = manager.audio:GetVoiceLength("story_v_out_103031", "103031005", "story_v_out_103031.awb") / 1000

					if var_23_29 + var_23_21 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_29 + var_23_21
					end

					if var_23_24.prefab_name ~= "" and arg_20_1.actors_[var_23_24.prefab_name] ~= nil then
						local var_23_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_24.prefab_name].transform, "story_v_out_103031", "103031005", "story_v_out_103031.awb")

						arg_20_1:RecordAudio("103031005", var_23_30)
						arg_20_1:RecordAudio("103031005", var_23_30)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_103031", "103031005", "story_v_out_103031.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_103031", "103031005", "story_v_out_103031.awb")
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
				actorName = "1019ui_story",
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
	Play103031006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 103031006
		arg_24_1.duration_ = 2

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play103031007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["4010ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect4010ui_story == nil then
				arg_24_1.var_.characterEffect4010ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.1

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect4010ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect4010ui_story then
				arg_24_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_27_4 = arg_24_1.actors_["1019ui_story"]
			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect1019ui_story == nil then
				arg_24_1.var_.characterEffect1019ui_story = var_27_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_6 = 0.1

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_6 and not isNil(var_27_4) then
				local var_27_7 = (arg_24_1.time_ - var_27_5) / var_27_6

				if arg_24_1.var_.characterEffect1019ui_story and not isNil(var_27_4) then
					local var_27_8 = Mathf.Lerp(0, 0.5, var_27_7)

					arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1019ui_story.fillRatio = var_27_8
				end
			end

			if arg_24_1.time_ >= var_27_5 + var_27_6 and arg_24_1.time_ < var_27_5 + var_27_6 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect1019ui_story then
				local var_27_9 = 0.5

				arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1019ui_story.fillRatio = var_27_9
			end

			local var_27_10 = arg_24_1.actors_["1019ui_story"].transform
			local var_27_11 = 0

			if var_27_11 < arg_24_1.time_ and arg_24_1.time_ <= var_27_11 + arg_27_0 then
				arg_24_1.var_.moveOldPos1019ui_story = var_27_10.localPosition
			end

			local var_27_12 = 0.001

			if var_27_11 <= arg_24_1.time_ and arg_24_1.time_ < var_27_11 + var_27_12 then
				local var_27_13 = (arg_24_1.time_ - var_27_11) / var_27_12
				local var_27_14 = Vector3.New(0, 100, 0)

				var_27_10.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1019ui_story, var_27_14, var_27_13)

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

			local var_27_19 = arg_24_1.actors_["1011ui_story"].transform
			local var_27_20 = 0

			if var_27_20 < arg_24_1.time_ and arg_24_1.time_ <= var_27_20 + arg_27_0 then
				arg_24_1.var_.moveOldPos1011ui_story = var_27_19.localPosition
			end

			local var_27_21 = 0.001

			if var_27_20 <= arg_24_1.time_ and arg_24_1.time_ < var_27_20 + var_27_21 then
				local var_27_22 = (arg_24_1.time_ - var_27_20) / var_27_21
				local var_27_23 = Vector3.New(0, 100, 0)

				var_27_19.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1011ui_story, var_27_23, var_27_22)

				local var_27_24 = manager.ui.mainCamera.transform.position - var_27_19.position

				var_27_19.forward = Vector3.New(var_27_24.x, var_27_24.y, var_27_24.z)

				local var_27_25 = var_27_19.localEulerAngles

				var_27_25.z = 0
				var_27_25.x = 0
				var_27_19.localEulerAngles = var_27_25
			end

			if arg_24_1.time_ >= var_27_20 + var_27_21 and arg_24_1.time_ < var_27_20 + var_27_21 + arg_27_0 then
				var_27_19.localPosition = Vector3.New(0, 100, 0)

				local var_27_26 = manager.ui.mainCamera.transform.position - var_27_19.position

				var_27_19.forward = Vector3.New(var_27_26.x, var_27_26.y, var_27_26.z)

				local var_27_27 = var_27_19.localEulerAngles

				var_27_27.z = 0
				var_27_27.x = 0
				var_27_19.localEulerAngles = var_27_27
			end

			local var_27_28 = arg_24_1.actors_["4010ui_story"].transform
			local var_27_29 = 0

			if var_27_29 < arg_24_1.time_ and arg_24_1.time_ <= var_27_29 + arg_27_0 then
				arg_24_1.var_.moveOldPos4010ui_story = var_27_28.localPosition
			end

			local var_27_30 = 0.001

			if var_27_29 <= arg_24_1.time_ and arg_24_1.time_ < var_27_29 + var_27_30 then
				local var_27_31 = (arg_24_1.time_ - var_27_29) / var_27_30
				local var_27_32 = Vector3.New(0, -1.59, -5.2)

				var_27_28.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos4010ui_story, var_27_32, var_27_31)

				local var_27_33 = manager.ui.mainCamera.transform.position - var_27_28.position

				var_27_28.forward = Vector3.New(var_27_33.x, var_27_33.y, var_27_33.z)

				local var_27_34 = var_27_28.localEulerAngles

				var_27_34.z = 0
				var_27_34.x = 0
				var_27_28.localEulerAngles = var_27_34
			end

			if arg_24_1.time_ >= var_27_29 + var_27_30 and arg_24_1.time_ < var_27_29 + var_27_30 + arg_27_0 then
				var_27_28.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_27_35 = manager.ui.mainCamera.transform.position - var_27_28.position

				var_27_28.forward = Vector3.New(var_27_35.x, var_27_35.y, var_27_35.z)

				local var_27_36 = var_27_28.localEulerAngles

				var_27_36.z = 0
				var_27_36.x = 0
				var_27_28.localEulerAngles = var_27_36
			end

			local var_27_37 = 0

			if var_27_37 < arg_24_1.time_ and arg_24_1.time_ <= var_27_37 + arg_27_0 then
				arg_24_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_2")
			end

			local var_27_38 = 0

			if var_27_38 < arg_24_1.time_ and arg_24_1.time_ <= var_27_38 + arg_27_0 then
				arg_24_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_27_39 = 0
			local var_27_40 = 0.05

			if var_27_39 < arg_24_1.time_ and arg_24_1.time_ <= var_27_39 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_41 = arg_24_1:FormatText(StoryNameCfg[42].name)

				arg_24_1.leftNameTxt_.text = var_27_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_42 = arg_24_1:GetWordFromCfg(103031006)
				local var_27_43 = arg_24_1:FormatText(var_27_42.content)

				arg_24_1.text_.text = var_27_43

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_44 = 2
				local var_27_45 = utf8.len(var_27_43)
				local var_27_46 = var_27_44 <= 0 and var_27_40 or var_27_40 * (var_27_45 / var_27_44)

				if var_27_46 > 0 and var_27_40 < var_27_46 then
					arg_24_1.talkMaxDuration = var_27_46

					if var_27_46 + var_27_39 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_46 + var_27_39
					end
				end

				arg_24_1.text_.text = var_27_43
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031006", "story_v_out_103031.awb") ~= 0 then
					local var_27_47 = manager.audio:GetVoiceLength("story_v_out_103031", "103031006", "story_v_out_103031.awb") / 1000

					if var_27_47 + var_27_39 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_47 + var_27_39
					end

					if var_27_42.prefab_name ~= "" and arg_24_1.actors_[var_27_42.prefab_name] ~= nil then
						local var_27_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_42.prefab_name].transform, "story_v_out_103031", "103031006", "story_v_out_103031.awb")

						arg_24_1:RecordAudio("103031006", var_27_48)
						arg_24_1:RecordAudio("103031006", var_27_48)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_103031", "103031006", "story_v_out_103031.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_103031", "103031006", "story_v_out_103031.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_49 = math.max(var_27_40, arg_24_1.talkMaxDuration)

			if var_27_39 <= arg_24_1.time_ and arg_24_1.time_ < var_27_39 + var_27_49 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_39) / var_27_49

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_39 + var_27_49 and arg_24_1.time_ < var_27_39 + var_27_49 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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
				actorName = "4010ui_story",
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
	Play103031007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 103031007
		arg_28_1.duration_ = 3.07

		local var_28_0 = {
			ja = 3.066,
			ko = 2.266,
			zh = 2.466,
			en = 2.133
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
				arg_28_0:Play103031008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "3009ui_story"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Char/" .. "3009ui_story")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(Asset.Load("Char/" .. "3009ui_story"), arg_28_1.stage_.transform)

					var_31_2.name = var_31_0
					var_31_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_28_1.actors_[var_31_0] = var_31_2

					local var_31_3 = var_31_2:GetComponentInChildren(typeof(CharacterEffect))

					var_31_3.enabled = true

					local var_31_4 = GameObjectTools.GetOrAddComponent(var_31_2, typeof(DynamicBoneHelper))

					if var_31_4 then
						var_31_4:EnableDynamicBone(false)
					end

					arg_28_1:ShowWeapon(var_31_3.transform, false)

					arg_28_1.var_[var_31_0 .. "Animator"] = var_31_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_28_1.var_[var_31_0 .. "Animator"].applyRootMotion = true
					arg_28_1.var_[var_31_0 .. "LipSync"] = var_31_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_31_5 = arg_28_1.actors_["3009ui_story"]
			local var_31_6 = 0

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect3009ui_story == nil then
				arg_28_1.var_.characterEffect3009ui_story = var_31_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_7 = 0.1

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_7 and not isNil(var_31_5) then
				local var_31_8 = (arg_28_1.time_ - var_31_6) / var_31_7

				if arg_28_1.var_.characterEffect3009ui_story and not isNil(var_31_5) then
					arg_28_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_6 + var_31_7 and arg_28_1.time_ < var_31_6 + var_31_7 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect3009ui_story then
				arg_28_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_31_9 = arg_28_1.actors_["4010ui_story"]
			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect4010ui_story == nil then
				arg_28_1.var_.characterEffect4010ui_story = var_31_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_11 = 0.1

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_11 and not isNil(var_31_9) then
				local var_31_12 = (arg_28_1.time_ - var_31_10) / var_31_11

				if arg_28_1.var_.characterEffect4010ui_story and not isNil(var_31_9) then
					local var_31_13 = Mathf.Lerp(0, 0.5, var_31_12)

					arg_28_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_28_1.var_.characterEffect4010ui_story.fillRatio = var_31_13
				end
			end

			if arg_28_1.time_ >= var_31_10 + var_31_11 and arg_28_1.time_ < var_31_10 + var_31_11 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect4010ui_story then
				local var_31_14 = 0.5

				arg_28_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_28_1.var_.characterEffect4010ui_story.fillRatio = var_31_14
			end

			local var_31_15 = arg_28_1.actors_["4010ui_story"].transform
			local var_31_16 = 0

			if var_31_16 < arg_28_1.time_ and arg_28_1.time_ <= var_31_16 + arg_31_0 then
				arg_28_1.var_.moveOldPos4010ui_story = var_31_15.localPosition
			end

			local var_31_17 = 0.5

			if var_31_16 <= arg_28_1.time_ and arg_28_1.time_ < var_31_16 + var_31_17 then
				local var_31_18 = (arg_28_1.time_ - var_31_16) / var_31_17
				local var_31_19 = Vector3.New(-0.7, -1.59, -5.2)

				var_31_15.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos4010ui_story, var_31_19, var_31_18)

				local var_31_20 = manager.ui.mainCamera.transform.position - var_31_15.position

				var_31_15.forward = Vector3.New(var_31_20.x, var_31_20.y, var_31_20.z)

				local var_31_21 = var_31_15.localEulerAngles

				var_31_21.z = 0
				var_31_21.x = 0
				var_31_15.localEulerAngles = var_31_21
			end

			if arg_28_1.time_ >= var_31_16 + var_31_17 and arg_28_1.time_ < var_31_16 + var_31_17 + arg_31_0 then
				var_31_15.localPosition = Vector3.New(-0.7, -1.59, -5.2)

				local var_31_22 = manager.ui.mainCamera.transform.position - var_31_15.position

				var_31_15.forward = Vector3.New(var_31_22.x, var_31_22.y, var_31_22.z)

				local var_31_23 = var_31_15.localEulerAngles

				var_31_23.z = 0
				var_31_23.x = 0
				var_31_15.localEulerAngles = var_31_23
			end

			local var_31_24 = arg_28_1.actors_["3009ui_story"].transform
			local var_31_25 = 0

			if var_31_25 < arg_28_1.time_ and arg_28_1.time_ <= var_31_25 + arg_31_0 then
				arg_28_1.var_.moveOldPos3009ui_story = var_31_24.localPosition

				local var_31_26 = "3009ui_story"

				arg_28_1:ShowWeapon(arg_28_1.var_[var_31_26 .. "Animator"].transform, true)
			end

			local var_31_27 = 0.001

			if var_31_25 <= arg_28_1.time_ and arg_28_1.time_ < var_31_25 + var_31_27 then
				local var_31_28 = (arg_28_1.time_ - var_31_25) / var_31_27
				local var_31_29 = Vector3.New(0.7, -1.75, -4.8)

				var_31_24.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos3009ui_story, var_31_29, var_31_28)

				local var_31_30 = manager.ui.mainCamera.transform.position - var_31_24.position

				var_31_24.forward = Vector3.New(var_31_30.x, var_31_30.y, var_31_30.z)

				local var_31_31 = var_31_24.localEulerAngles

				var_31_31.z = 0
				var_31_31.x = 0
				var_31_24.localEulerAngles = var_31_31
			end

			if arg_28_1.time_ >= var_31_25 + var_31_27 and arg_28_1.time_ < var_31_25 + var_31_27 + arg_31_0 then
				var_31_24.localPosition = Vector3.New(0.7, -1.75, -4.8)

				local var_31_32 = manager.ui.mainCamera.transform.position - var_31_24.position

				var_31_24.forward = Vector3.New(var_31_32.x, var_31_32.y, var_31_32.z)

				local var_31_33 = var_31_24.localEulerAngles

				var_31_33.z = 0
				var_31_33.x = 0
				var_31_24.localEulerAngles = var_31_33
			end

			local var_31_34 = 0

			if var_31_34 < arg_28_1.time_ and arg_28_1.time_ <= var_31_34 + arg_31_0 then
				arg_28_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action2_1")
			end

			local var_31_35 = 0

			if var_31_35 < arg_28_1.time_ and arg_28_1.time_ <= var_31_35 + arg_31_0 then
				arg_28_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_31_36 = 0
			local var_31_37 = 0.25

			if var_31_36 < arg_28_1.time_ and arg_28_1.time_ <= var_31_36 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_38 = arg_28_1:FormatText(StoryNameCfg[43].name)

				arg_28_1.leftNameTxt_.text = var_31_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_39 = arg_28_1:GetWordFromCfg(103031007)
				local var_31_40 = arg_28_1:FormatText(var_31_39.content)

				arg_28_1.text_.text = var_31_40

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_41 = 10
				local var_31_42 = utf8.len(var_31_40)
				local var_31_43 = var_31_41 <= 0 and var_31_37 or var_31_37 * (var_31_42 / var_31_41)

				if var_31_43 > 0 and var_31_37 < var_31_43 then
					arg_28_1.talkMaxDuration = var_31_43

					if var_31_43 + var_31_36 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_43 + var_31_36
					end
				end

				arg_28_1.text_.text = var_31_40
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031007", "story_v_out_103031.awb") ~= 0 then
					local var_31_44 = manager.audio:GetVoiceLength("story_v_out_103031", "103031007", "story_v_out_103031.awb") / 1000

					if var_31_44 + var_31_36 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_44 + var_31_36
					end

					if var_31_39.prefab_name ~= "" and arg_28_1.actors_[var_31_39.prefab_name] ~= nil then
						local var_31_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_39.prefab_name].transform, "story_v_out_103031", "103031007", "story_v_out_103031.awb")

						arg_28_1:RecordAudio("103031007", var_31_45)
						arg_28_1:RecordAudio("103031007", var_31_45)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_103031", "103031007", "story_v_out_103031.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_103031", "103031007", "story_v_out_103031.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_46 = math.max(var_31_37, arg_28_1.talkMaxDuration)

			if var_31_36 <= arg_28_1.time_ and arg_28_1.time_ < var_31_36 + var_31_46 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_36) / var_31_46

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_36 + var_31_46 and arg_28_1.time_ < var_31_36 + var_31_46 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
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

		arg_28_1:InitPlayNodeList()
	end,
	Play103031008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 103031008
		arg_32_1.duration_ = 6.27

		local var_32_0 = {
			ja = 6.266,
			ko = 4.633,
			zh = 3.633,
			en = 5.6
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
				arg_32_0:Play103031009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["4010ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect4010ui_story == nil then
				arg_32_1.var_.characterEffect4010ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect4010ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect4010ui_story then
				arg_32_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["3009ui_story"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect3009ui_story == nil then
				arg_32_1.var_.characterEffect3009ui_story = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.1

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect3009ui_story and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_32_1.var_.characterEffect3009ui_story.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect3009ui_story then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_32_1.var_.characterEffect3009ui_story.fillRatio = var_35_9
			end

			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_35_11 = 0
			local var_35_12 = 0.375

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_13 = arg_32_1:FormatText(StoryNameCfg[42].name)

				arg_32_1.leftNameTxt_.text = var_35_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_14 = arg_32_1:GetWordFromCfg(103031008)
				local var_35_15 = arg_32_1:FormatText(var_35_14.content)

				arg_32_1.text_.text = var_35_15

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_16 = 15
				local var_35_17 = utf8.len(var_35_15)
				local var_35_18 = var_35_16 <= 0 and var_35_12 or var_35_12 * (var_35_17 / var_35_16)

				if var_35_18 > 0 and var_35_12 < var_35_18 then
					arg_32_1.talkMaxDuration = var_35_18

					if var_35_18 + var_35_11 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_18 + var_35_11
					end
				end

				arg_32_1.text_.text = var_35_15
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031008", "story_v_out_103031.awb") ~= 0 then
					local var_35_19 = manager.audio:GetVoiceLength("story_v_out_103031", "103031008", "story_v_out_103031.awb") / 1000

					if var_35_19 + var_35_11 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_19 + var_35_11
					end

					if var_35_14.prefab_name ~= "" and arg_32_1.actors_[var_35_14.prefab_name] ~= nil then
						local var_35_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_14.prefab_name].transform, "story_v_out_103031", "103031008", "story_v_out_103031.awb")

						arg_32_1:RecordAudio("103031008", var_35_20)
						arg_32_1:RecordAudio("103031008", var_35_20)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_103031", "103031008", "story_v_out_103031.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_103031", "103031008", "story_v_out_103031.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_21 = math.max(var_35_12, arg_32_1.talkMaxDuration)

			if var_35_11 <= arg_32_1.time_ and arg_32_1.time_ < var_35_11 + var_35_21 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_11) / var_35_21

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_11 + var_35_21 and arg_32_1.time_ < var_35_11 + var_35_21 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play103031009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 103031009
		arg_36_1.duration_ = 8.4

		local var_36_0 = {
			ja = 3.166,
			ko = 8.4,
			zh = 5.533,
			en = 6.7
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
				arg_36_0:Play103031010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = "3008ui_story"

			if arg_36_1.actors_[var_39_0] == nil then
				local var_39_1 = Asset.Load("Char/" .. "3008ui_story")

				if not isNil(var_39_1) then
					local var_39_2 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_36_1.stage_.transform)

					var_39_2.name = var_39_0
					var_39_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_36_1.actors_[var_39_0] = var_39_2

					local var_39_3 = var_39_2:GetComponentInChildren(typeof(CharacterEffect))

					var_39_3.enabled = true

					local var_39_4 = GameObjectTools.GetOrAddComponent(var_39_2, typeof(DynamicBoneHelper))

					if var_39_4 then
						var_39_4:EnableDynamicBone(false)
					end

					arg_36_1:ShowWeapon(var_39_3.transform, false)

					arg_36_1.var_[var_39_0 .. "Animator"] = var_39_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_36_1.var_[var_39_0 .. "Animator"].applyRootMotion = true
					arg_36_1.var_[var_39_0 .. "LipSync"] = var_39_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_39_5 = arg_36_1.actors_["3008ui_story"]
			local var_39_6 = 0

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect3008ui_story == nil then
				arg_36_1.var_.characterEffect3008ui_story = var_39_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_7 = 0.1

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_7 and not isNil(var_39_5) then
				local var_39_8 = (arg_36_1.time_ - var_39_6) / var_39_7

				if arg_36_1.var_.characterEffect3008ui_story and not isNil(var_39_5) then
					arg_36_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_6 + var_39_7 and arg_36_1.time_ < var_39_6 + var_39_7 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect3008ui_story then
				arg_36_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_39_9 = arg_36_1.actors_["3009ui_story"].transform
			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.var_.moveOldPos3009ui_story = var_39_9.localPosition
			end

			local var_39_11 = 0.001

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_11 then
				local var_39_12 = (arg_36_1.time_ - var_39_10) / var_39_11
				local var_39_13 = Vector3.New(0, 100, 0)

				var_39_9.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos3009ui_story, var_39_13, var_39_12)

				local var_39_14 = manager.ui.mainCamera.transform.position - var_39_9.position

				var_39_9.forward = Vector3.New(var_39_14.x, var_39_14.y, var_39_14.z)

				local var_39_15 = var_39_9.localEulerAngles

				var_39_15.z = 0
				var_39_15.x = 0
				var_39_9.localEulerAngles = var_39_15
			end

			if arg_36_1.time_ >= var_39_10 + var_39_11 and arg_36_1.time_ < var_39_10 + var_39_11 + arg_39_0 then
				var_39_9.localPosition = Vector3.New(0, 100, 0)

				local var_39_16 = manager.ui.mainCamera.transform.position - var_39_9.position

				var_39_9.forward = Vector3.New(var_39_16.x, var_39_16.y, var_39_16.z)

				local var_39_17 = var_39_9.localEulerAngles

				var_39_17.z = 0
				var_39_17.x = 0
				var_39_9.localEulerAngles = var_39_17
			end

			local var_39_18 = arg_36_1.actors_["4010ui_story"].transform
			local var_39_19 = 0

			if var_39_19 < arg_36_1.time_ and arg_36_1.time_ <= var_39_19 + arg_39_0 then
				arg_36_1.var_.moveOldPos4010ui_story = var_39_18.localPosition
			end

			local var_39_20 = 0.001

			if var_39_19 <= arg_36_1.time_ and arg_36_1.time_ < var_39_19 + var_39_20 then
				local var_39_21 = (arg_36_1.time_ - var_39_19) / var_39_20
				local var_39_22 = Vector3.New(0, 100, 0)

				var_39_18.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos4010ui_story, var_39_22, var_39_21)

				local var_39_23 = manager.ui.mainCamera.transform.position - var_39_18.position

				var_39_18.forward = Vector3.New(var_39_23.x, var_39_23.y, var_39_23.z)

				local var_39_24 = var_39_18.localEulerAngles

				var_39_24.z = 0
				var_39_24.x = 0
				var_39_18.localEulerAngles = var_39_24
			end

			if arg_36_1.time_ >= var_39_19 + var_39_20 and arg_36_1.time_ < var_39_19 + var_39_20 + arg_39_0 then
				var_39_18.localPosition = Vector3.New(0, 100, 0)

				local var_39_25 = manager.ui.mainCamera.transform.position - var_39_18.position

				var_39_18.forward = Vector3.New(var_39_25.x, var_39_25.y, var_39_25.z)

				local var_39_26 = var_39_18.localEulerAngles

				var_39_26.z = 0
				var_39_26.x = 0
				var_39_18.localEulerAngles = var_39_26
			end

			local var_39_27 = arg_36_1.actors_["3008ui_story"].transform
			local var_39_28 = 0

			if var_39_28 < arg_36_1.time_ and arg_36_1.time_ <= var_39_28 + arg_39_0 then
				arg_36_1.var_.moveOldPos3008ui_story = var_39_27.localPosition
			end

			local var_39_29 = 0.001

			if var_39_28 <= arg_36_1.time_ and arg_36_1.time_ < var_39_28 + var_39_29 then
				local var_39_30 = (arg_36_1.time_ - var_39_28) / var_39_29
				local var_39_31 = Vector3.New(0, -1.51, -4.3)

				var_39_27.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos3008ui_story, var_39_31, var_39_30)

				local var_39_32 = manager.ui.mainCamera.transform.position - var_39_27.position

				var_39_27.forward = Vector3.New(var_39_32.x, var_39_32.y, var_39_32.z)

				local var_39_33 = var_39_27.localEulerAngles

				var_39_33.z = 0
				var_39_33.x = 0
				var_39_27.localEulerAngles = var_39_33
			end

			if arg_36_1.time_ >= var_39_28 + var_39_29 and arg_36_1.time_ < var_39_28 + var_39_29 + arg_39_0 then
				var_39_27.localPosition = Vector3.New(0, -1.51, -4.3)

				local var_39_34 = manager.ui.mainCamera.transform.position - var_39_27.position

				var_39_27.forward = Vector3.New(var_39_34.x, var_39_34.y, var_39_34.z)

				local var_39_35 = var_39_27.localEulerAngles

				var_39_35.z = 0
				var_39_35.x = 0
				var_39_27.localEulerAngles = var_39_35
			end

			local var_39_36 = 0

			if var_39_36 < arg_36_1.time_ and arg_36_1.time_ <= var_39_36 + arg_39_0 then
				arg_36_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action2_1")
			end

			local var_39_37 = 0

			if var_39_37 < arg_36_1.time_ and arg_36_1.time_ <= var_39_37 + arg_39_0 then
				arg_36_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_39_38 = 0
			local var_39_39 = 0.775

			if var_39_38 < arg_36_1.time_ and arg_36_1.time_ <= var_39_38 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_40 = arg_36_1:FormatText(StoryNameCfg[20].name)

				arg_36_1.leftNameTxt_.text = var_39_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_41 = arg_36_1:GetWordFromCfg(103031009)
				local var_39_42 = arg_36_1:FormatText(var_39_41.content)

				arg_36_1.text_.text = var_39_42

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_43 = 30
				local var_39_44 = utf8.len(var_39_42)
				local var_39_45 = var_39_43 <= 0 and var_39_39 or var_39_39 * (var_39_44 / var_39_43)

				if var_39_45 > 0 and var_39_39 < var_39_45 then
					arg_36_1.talkMaxDuration = var_39_45

					if var_39_45 + var_39_38 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_45 + var_39_38
					end
				end

				arg_36_1.text_.text = var_39_42
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031009", "story_v_out_103031.awb") ~= 0 then
					local var_39_46 = manager.audio:GetVoiceLength("story_v_out_103031", "103031009", "story_v_out_103031.awb") / 1000

					if var_39_46 + var_39_38 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_46 + var_39_38
					end

					if var_39_41.prefab_name ~= "" and arg_36_1.actors_[var_39_41.prefab_name] ~= nil then
						local var_39_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_41.prefab_name].transform, "story_v_out_103031", "103031009", "story_v_out_103031.awb")

						arg_36_1:RecordAudio("103031009", var_39_47)
						arg_36_1:RecordAudio("103031009", var_39_47)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_103031", "103031009", "story_v_out_103031.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_103031", "103031009", "story_v_out_103031.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_48 = math.max(var_39_39, arg_36_1.talkMaxDuration)

			if var_39_38 <= arg_36_1.time_ and arg_36_1.time_ < var_39_38 + var_39_48 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_38) / var_39_48

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_38 + var_39_48 and arg_36_1.time_ < var_39_38 + var_39_48 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
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
				actorName = "4010ui_story",
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

		arg_36_1:InitPlayNodeList()
	end,
	Play103031010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 103031010
		arg_40_1.duration_ = 14.2

		local var_40_0 = {
			ja = 14.2,
			ko = 11.733,
			zh = 11.433,
			en = 10.8
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
				arg_40_0:Play103031011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["4010ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect4010ui_story == nil then
				arg_40_1.var_.characterEffect4010ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect4010ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect4010ui_story then
				arg_40_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_43_4 = arg_40_1.actors_["3008ui_story"]
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect3008ui_story == nil then
				arg_40_1.var_.characterEffect3008ui_story = var_43_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.1

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 and not isNil(var_43_4) then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6

				if arg_40_1.var_.characterEffect3008ui_story and not isNil(var_43_4) then
					local var_43_8 = Mathf.Lerp(0, 0.5, var_43_7)

					arg_40_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_40_1.var_.characterEffect3008ui_story.fillRatio = var_43_8
				end
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect3008ui_story then
				local var_43_9 = 0.5

				arg_40_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_40_1.var_.characterEffect3008ui_story.fillRatio = var_43_9
			end

			local var_43_10 = arg_40_1.actors_["3008ui_story"].transform
			local var_43_11 = 0

			if var_43_11 < arg_40_1.time_ and arg_40_1.time_ <= var_43_11 + arg_43_0 then
				arg_40_1.var_.moveOldPos3008ui_story = var_43_10.localPosition
			end

			local var_43_12 = 0.001

			if var_43_11 <= arg_40_1.time_ and arg_40_1.time_ < var_43_11 + var_43_12 then
				local var_43_13 = (arg_40_1.time_ - var_43_11) / var_43_12
				local var_43_14 = Vector3.New(0, 100, 0)

				var_43_10.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos3008ui_story, var_43_14, var_43_13)

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

			local var_43_19 = arg_40_1.actors_["4010ui_story"].transform
			local var_43_20 = 0

			if var_43_20 < arg_40_1.time_ and arg_40_1.time_ <= var_43_20 + arg_43_0 then
				arg_40_1.var_.moveOldPos4010ui_story = var_43_19.localPosition
			end

			local var_43_21 = 0.001

			if var_43_20 <= arg_40_1.time_ and arg_40_1.time_ < var_43_20 + var_43_21 then
				local var_43_22 = (arg_40_1.time_ - var_43_20) / var_43_21
				local var_43_23 = Vector3.New(0, -1.59, -5.2)

				var_43_19.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos4010ui_story, var_43_23, var_43_22)

				local var_43_24 = manager.ui.mainCamera.transform.position - var_43_19.position

				var_43_19.forward = Vector3.New(var_43_24.x, var_43_24.y, var_43_24.z)

				local var_43_25 = var_43_19.localEulerAngles

				var_43_25.z = 0
				var_43_25.x = 0
				var_43_19.localEulerAngles = var_43_25
			end

			if arg_40_1.time_ >= var_43_20 + var_43_21 and arg_40_1.time_ < var_43_20 + var_43_21 + arg_43_0 then
				var_43_19.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_43_26 = manager.ui.mainCamera.transform.position - var_43_19.position

				var_43_19.forward = Vector3.New(var_43_26.x, var_43_26.y, var_43_26.z)

				local var_43_27 = var_43_19.localEulerAngles

				var_43_27.z = 0
				var_43_27.x = 0
				var_43_19.localEulerAngles = var_43_27
			end

			local var_43_28 = 0

			if var_43_28 < arg_40_1.time_ and arg_40_1.time_ <= var_43_28 + arg_43_0 then
				arg_40_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_1")
			end

			local var_43_29 = 0

			if var_43_29 < arg_40_1.time_ and arg_40_1.time_ <= var_43_29 + arg_43_0 then
				arg_40_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_43_30 = 0
			local var_43_31 = 1.325

			if var_43_30 < arg_40_1.time_ and arg_40_1.time_ <= var_43_30 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_32 = arg_40_1:FormatText(StoryNameCfg[42].name)

				arg_40_1.leftNameTxt_.text = var_43_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_33 = arg_40_1:GetWordFromCfg(103031010)
				local var_43_34 = arg_40_1:FormatText(var_43_33.content)

				arg_40_1.text_.text = var_43_34

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_35 = 52
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

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031010", "story_v_out_103031.awb") ~= 0 then
					local var_43_38 = manager.audio:GetVoiceLength("story_v_out_103031", "103031010", "story_v_out_103031.awb") / 1000

					if var_43_38 + var_43_30 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_38 + var_43_30
					end

					if var_43_33.prefab_name ~= "" and arg_40_1.actors_[var_43_33.prefab_name] ~= nil then
						local var_43_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_33.prefab_name].transform, "story_v_out_103031", "103031010", "story_v_out_103031.awb")

						arg_40_1:RecordAudio("103031010", var_43_39)
						arg_40_1:RecordAudio("103031010", var_43_39)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_103031", "103031010", "story_v_out_103031.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_103031", "103031010", "story_v_out_103031.awb")
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
				actorName = "4010ui_story",
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
	Play103031011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 103031011
		arg_44_1.duration_ = 13.23

		local var_44_0 = {
			ja = 13.233,
			ko = 8.966,
			zh = 10,
			en = 8.833
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
				arg_44_0:Play103031012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_2")
			end

			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_47_2 = 0
			local var_47_3 = 1.075

			if var_47_2 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_4 = arg_44_1:FormatText(StoryNameCfg[42].name)

				arg_44_1.leftNameTxt_.text = var_47_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_5 = arg_44_1:GetWordFromCfg(103031011)
				local var_47_6 = arg_44_1:FormatText(var_47_5.content)

				arg_44_1.text_.text = var_47_6

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_7 = 43
				local var_47_8 = utf8.len(var_47_6)
				local var_47_9 = var_47_7 <= 0 and var_47_3 or var_47_3 * (var_47_8 / var_47_7)

				if var_47_9 > 0 and var_47_3 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_2
					end
				end

				arg_44_1.text_.text = var_47_6
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031011", "story_v_out_103031.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_out_103031", "103031011", "story_v_out_103031.awb") / 1000

					if var_47_10 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_2
					end

					if var_47_5.prefab_name ~= "" and arg_44_1.actors_[var_47_5.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_5.prefab_name].transform, "story_v_out_103031", "103031011", "story_v_out_103031.awb")

						arg_44_1:RecordAudio("103031011", var_47_11)
						arg_44_1:RecordAudio("103031011", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_103031", "103031011", "story_v_out_103031.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_103031", "103031011", "story_v_out_103031.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_12 = math.max(var_47_3, arg_44_1.talkMaxDuration)

			if var_47_2 <= arg_44_1.time_ and arg_44_1.time_ < var_47_2 + var_47_12 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_2) / var_47_12

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_2 + var_47_12 and arg_44_1.time_ < var_47_2 + var_47_12 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play103031012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 103031012
		arg_48_1.duration_ = 3.2

		local var_48_0 = {
			ja = 3.2,
			ko = 2.5,
			zh = 1.666,
			en = 1.633
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
				arg_48_0:Play103031013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1084ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1084ui_story then
				arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["4010ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect4010ui_story == nil then
				arg_48_1.var_.characterEffect4010ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.1

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect4010ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_48_1.var_.characterEffect4010ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect4010ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_48_1.var_.characterEffect4010ui_story.fillRatio = var_51_9
			end

			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_51_11 = 0
			local var_51_12 = 0.125

			if var_51_11 < arg_48_1.time_ and arg_48_1.time_ <= var_51_11 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_13 = arg_48_1:FormatText(StoryNameCfg[6].name)

				arg_48_1.leftNameTxt_.text = var_51_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_14 = arg_48_1:GetWordFromCfg(103031012)
				local var_51_15 = arg_48_1:FormatText(var_51_14.content)

				arg_48_1.text_.text = var_51_15

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_16 = 5
				local var_51_17 = utf8.len(var_51_15)
				local var_51_18 = var_51_16 <= 0 and var_51_12 or var_51_12 * (var_51_17 / var_51_16)

				if var_51_18 > 0 and var_51_12 < var_51_18 then
					arg_48_1.talkMaxDuration = var_51_18

					if var_51_18 + var_51_11 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_18 + var_51_11
					end
				end

				arg_48_1.text_.text = var_51_15
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031012", "story_v_out_103031.awb") ~= 0 then
					local var_51_19 = manager.audio:GetVoiceLength("story_v_out_103031", "103031012", "story_v_out_103031.awb") / 1000

					if var_51_19 + var_51_11 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_19 + var_51_11
					end

					if var_51_14.prefab_name ~= "" and arg_48_1.actors_[var_51_14.prefab_name] ~= nil then
						local var_51_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_14.prefab_name].transform, "story_v_out_103031", "103031012", "story_v_out_103031.awb")

						arg_48_1:RecordAudio("103031012", var_51_20)
						arg_48_1:RecordAudio("103031012", var_51_20)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_103031", "103031012", "story_v_out_103031.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_103031", "103031012", "story_v_out_103031.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_21 = math.max(var_51_12, arg_48_1.talkMaxDuration)

			if var_51_11 <= arg_48_1.time_ and arg_48_1.time_ < var_51_11 + var_51_21 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_11) / var_51_21

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_11 + var_51_21 and arg_48_1.time_ < var_51_11 + var_51_21 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play103031013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 103031013
		arg_52_1.duration_ = 11.57

		local var_52_0 = {
			ja = 11.566,
			ko = 7.4,
			zh = 7.633,
			en = 6.966
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
				arg_52_0:Play103031014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["4010ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect4010ui_story == nil then
				arg_52_1.var_.characterEffect4010ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.1

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect4010ui_story and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect4010ui_story then
				arg_52_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_55_4 = arg_52_1.actors_["1084ui_story"]
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = var_55_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_6 = 0.1

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 and not isNil(var_55_4) then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6

				if arg_52_1.var_.characterEffect1084ui_story and not isNil(var_55_4) then
					local var_55_8 = Mathf.Lerp(0, 0.5, var_55_7)

					arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1084ui_story.fillRatio = var_55_8
				end
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect1084ui_story then
				local var_55_9 = 0.5

				arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1084ui_story.fillRatio = var_55_9
			end

			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_55_11 = 0
			local var_55_12 = 0.925

			if var_55_11 < arg_52_1.time_ and arg_52_1.time_ <= var_55_11 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_13 = arg_52_1:FormatText(StoryNameCfg[42].name)

				arg_52_1.leftNameTxt_.text = var_55_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_14 = arg_52_1:GetWordFromCfg(103031013)
				local var_55_15 = arg_52_1:FormatText(var_55_14.content)

				arg_52_1.text_.text = var_55_15

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_16 = 37
				local var_55_17 = utf8.len(var_55_15)
				local var_55_18 = var_55_16 <= 0 and var_55_12 or var_55_12 * (var_55_17 / var_55_16)

				if var_55_18 > 0 and var_55_12 < var_55_18 then
					arg_52_1.talkMaxDuration = var_55_18

					if var_55_18 + var_55_11 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_18 + var_55_11
					end
				end

				arg_52_1.text_.text = var_55_15
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031013", "story_v_out_103031.awb") ~= 0 then
					local var_55_19 = manager.audio:GetVoiceLength("story_v_out_103031", "103031013", "story_v_out_103031.awb") / 1000

					if var_55_19 + var_55_11 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_19 + var_55_11
					end

					if var_55_14.prefab_name ~= "" and arg_52_1.actors_[var_55_14.prefab_name] ~= nil then
						local var_55_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_14.prefab_name].transform, "story_v_out_103031", "103031013", "story_v_out_103031.awb")

						arg_52_1:RecordAudio("103031013", var_55_20)
						arg_52_1:RecordAudio("103031013", var_55_20)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_103031", "103031013", "story_v_out_103031.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_103031", "103031013", "story_v_out_103031.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_21 = math.max(var_55_12, arg_52_1.talkMaxDuration)

			if var_55_11 <= arg_52_1.time_ and arg_52_1.time_ < var_55_11 + var_55_21 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_11) / var_55_21

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_11 + var_55_21 and arg_52_1.time_ < var_55_11 + var_55_21 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play103031014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 103031014
		arg_56_1.duration_ = 5.63

		local var_56_0 = {
			ja = 5.633,
			ko = 4.9,
			zh = 5.433,
			en = 3.966
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
				arg_56_0:Play103031015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["4010ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect4010ui_story == nil then
				arg_56_1.var_.characterEffect4010ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.1

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect4010ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect4010ui_story then
				arg_56_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_59_4 = arg_56_1.actors_["1011ui_story"]
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect1011ui_story == nil then
				arg_56_1.var_.characterEffect1011ui_story = var_59_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_6 = 0.1

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 and not isNil(var_59_4) then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6

				if arg_56_1.var_.characterEffect1011ui_story and not isNil(var_59_4) then
					local var_59_8 = Mathf.Lerp(0, 0.5, var_59_7)

					arg_56_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1011ui_story.fillRatio = var_59_8
				end
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect1011ui_story then
				local var_59_9 = 0.5

				arg_56_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1011ui_story.fillRatio = var_59_9
			end

			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_59_11 = 0
			local var_59_12 = 0.625

			if var_59_11 < arg_56_1.time_ and arg_56_1.time_ <= var_59_11 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_13 = arg_56_1:FormatText(StoryNameCfg[42].name)

				arg_56_1.leftNameTxt_.text = var_59_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_14 = arg_56_1:GetWordFromCfg(103031014)
				local var_59_15 = arg_56_1:FormatText(var_59_14.content)

				arg_56_1.text_.text = var_59_15

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_16 = 25
				local var_59_17 = utf8.len(var_59_15)
				local var_59_18 = var_59_16 <= 0 and var_59_12 or var_59_12 * (var_59_17 / var_59_16)

				if var_59_18 > 0 and var_59_12 < var_59_18 then
					arg_56_1.talkMaxDuration = var_59_18

					if var_59_18 + var_59_11 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_18 + var_59_11
					end
				end

				arg_56_1.text_.text = var_59_15
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031014", "story_v_out_103031.awb") ~= 0 then
					local var_59_19 = manager.audio:GetVoiceLength("story_v_out_103031", "103031014", "story_v_out_103031.awb") / 1000

					if var_59_19 + var_59_11 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_19 + var_59_11
					end

					if var_59_14.prefab_name ~= "" and arg_56_1.actors_[var_59_14.prefab_name] ~= nil then
						local var_59_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_14.prefab_name].transform, "story_v_out_103031", "103031014", "story_v_out_103031.awb")

						arg_56_1:RecordAudio("103031014", var_59_20)
						arg_56_1:RecordAudio("103031014", var_59_20)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_103031", "103031014", "story_v_out_103031.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_103031", "103031014", "story_v_out_103031.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_21 = math.max(var_59_12, arg_56_1.talkMaxDuration)

			if var_59_11 <= arg_56_1.time_ and arg_56_1.time_ < var_59_11 + var_59_21 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_11) / var_59_21

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_11 + var_59_21 and arg_56_1.time_ < var_59_11 + var_59_21 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play103031015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 103031015
		arg_60_1.duration_ = 16.23

		local var_60_0 = {
			ja = 16.233,
			ko = 12.566,
			zh = 13,
			en = 13.666
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
				arg_60_0:Play103031016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_63_1 = 0
			local var_63_2 = 1.6

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_3 = arg_60_1:FormatText(StoryNameCfg[42].name)

				arg_60_1.leftNameTxt_.text = var_63_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_4 = arg_60_1:GetWordFromCfg(103031015)
				local var_63_5 = arg_60_1:FormatText(var_63_4.content)

				arg_60_1.text_.text = var_63_5

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_6 = 64
				local var_63_7 = utf8.len(var_63_5)
				local var_63_8 = var_63_6 <= 0 and var_63_2 or var_63_2 * (var_63_7 / var_63_6)

				if var_63_8 > 0 and var_63_2 < var_63_8 then
					arg_60_1.talkMaxDuration = var_63_8

					if var_63_8 + var_63_1 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_1
					end
				end

				arg_60_1.text_.text = var_63_5
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031015", "story_v_out_103031.awb") ~= 0 then
					local var_63_9 = manager.audio:GetVoiceLength("story_v_out_103031", "103031015", "story_v_out_103031.awb") / 1000

					if var_63_9 + var_63_1 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_1
					end

					if var_63_4.prefab_name ~= "" and arg_60_1.actors_[var_63_4.prefab_name] ~= nil then
						local var_63_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_4.prefab_name].transform, "story_v_out_103031", "103031015", "story_v_out_103031.awb")

						arg_60_1:RecordAudio("103031015", var_63_10)
						arg_60_1:RecordAudio("103031015", var_63_10)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_103031", "103031015", "story_v_out_103031.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_103031", "103031015", "story_v_out_103031.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_11 = math.max(var_63_2, arg_60_1.talkMaxDuration)

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_11 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_1) / var_63_11

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_1 + var_63_11 and arg_60_1.time_ < var_63_1 + var_63_11 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play103031016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 103031016
		arg_64_1.duration_ = 3.7

		local var_64_0 = {
			ja = 3.566,
			ko = 3,
			zh = 3.7,
			en = 3.066
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
				arg_64_0:Play103031017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1011ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1011ui_story == nil then
				arg_64_1.var_.characterEffect1011ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.1

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1011ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1011ui_story then
				arg_64_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_67_4 = arg_64_1.actors_["4010ui_story"]
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect4010ui_story == nil then
				arg_64_1.var_.characterEffect4010ui_story = var_67_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.1

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 and not isNil(var_67_4) then
				local var_67_7 = (arg_64_1.time_ - var_67_5) / var_67_6

				if arg_64_1.var_.characterEffect4010ui_story and not isNil(var_67_4) then
					local var_67_8 = Mathf.Lerp(0, 0.5, var_67_7)

					arg_64_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_64_1.var_.characterEffect4010ui_story.fillRatio = var_67_8
				end
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect4010ui_story then
				local var_67_9 = 0.5

				arg_64_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_64_1.var_.characterEffect4010ui_story.fillRatio = var_67_9
			end

			local var_67_10 = arg_64_1.actors_["4010ui_story"].transform
			local var_67_11 = 0

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.var_.moveOldPos4010ui_story = var_67_10.localPosition
			end

			local var_67_12 = 0.5

			if var_67_11 <= arg_64_1.time_ and arg_64_1.time_ < var_67_11 + var_67_12 then
				local var_67_13 = (arg_64_1.time_ - var_67_11) / var_67_12
				local var_67_14 = Vector3.New(0.7, -1.59, -5.2)

				var_67_10.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos4010ui_story, var_67_14, var_67_13)

				local var_67_15 = manager.ui.mainCamera.transform.position - var_67_10.position

				var_67_10.forward = Vector3.New(var_67_15.x, var_67_15.y, var_67_15.z)

				local var_67_16 = var_67_10.localEulerAngles

				var_67_16.z = 0
				var_67_16.x = 0
				var_67_10.localEulerAngles = var_67_16
			end

			if arg_64_1.time_ >= var_67_11 + var_67_12 and arg_64_1.time_ < var_67_11 + var_67_12 + arg_67_0 then
				var_67_10.localPosition = Vector3.New(0.7, -1.59, -5.2)

				local var_67_17 = manager.ui.mainCamera.transform.position - var_67_10.position

				var_67_10.forward = Vector3.New(var_67_17.x, var_67_17.y, var_67_17.z)

				local var_67_18 = var_67_10.localEulerAngles

				var_67_18.z = 0
				var_67_18.x = 0
				var_67_10.localEulerAngles = var_67_18
			end

			local var_67_19 = arg_64_1.actors_["1011ui_story"].transform
			local var_67_20 = 0

			if var_67_20 < arg_64_1.time_ and arg_64_1.time_ <= var_67_20 + arg_67_0 then
				arg_64_1.var_.moveOldPos1011ui_story = var_67_19.localPosition
			end

			local var_67_21 = 0.001

			if var_67_20 <= arg_64_1.time_ and arg_64_1.time_ < var_67_20 + var_67_21 then
				local var_67_22 = (arg_64_1.time_ - var_67_20) / var_67_21
				local var_67_23 = Vector3.New(-0.7, -0.71, -6)

				var_67_19.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1011ui_story, var_67_23, var_67_22)

				local var_67_24 = manager.ui.mainCamera.transform.position - var_67_19.position

				var_67_19.forward = Vector3.New(var_67_24.x, var_67_24.y, var_67_24.z)

				local var_67_25 = var_67_19.localEulerAngles

				var_67_25.z = 0
				var_67_25.x = 0
				var_67_19.localEulerAngles = var_67_25
			end

			if arg_64_1.time_ >= var_67_20 + var_67_21 and arg_64_1.time_ < var_67_20 + var_67_21 + arg_67_0 then
				var_67_19.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_67_26 = manager.ui.mainCamera.transform.position - var_67_19.position

				var_67_19.forward = Vector3.New(var_67_26.x, var_67_26.y, var_67_26.z)

				local var_67_27 = var_67_19.localEulerAngles

				var_67_27.z = 0
				var_67_27.x = 0
				var_67_19.localEulerAngles = var_67_27
			end

			local var_67_28 = 0

			if var_67_28 < arg_64_1.time_ and arg_64_1.time_ <= var_67_28 + arg_67_0 then
				arg_64_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_67_29 = 0

			if var_67_29 < arg_64_1.time_ and arg_64_1.time_ <= var_67_29 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_67_30 = 0
			local var_67_31 = 0.275

			if var_67_30 < arg_64_1.time_ and arg_64_1.time_ <= var_67_30 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_32 = arg_64_1:FormatText(StoryNameCfg[37].name)

				arg_64_1.leftNameTxt_.text = var_67_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_33 = arg_64_1:GetWordFromCfg(103031016)
				local var_67_34 = arg_64_1:FormatText(var_67_33.content)

				arg_64_1.text_.text = var_67_34

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_35 = 11
				local var_67_36 = utf8.len(var_67_34)
				local var_67_37 = var_67_35 <= 0 and var_67_31 or var_67_31 * (var_67_36 / var_67_35)

				if var_67_37 > 0 and var_67_31 < var_67_37 then
					arg_64_1.talkMaxDuration = var_67_37

					if var_67_37 + var_67_30 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_37 + var_67_30
					end
				end

				arg_64_1.text_.text = var_67_34
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031016", "story_v_out_103031.awb") ~= 0 then
					local var_67_38 = manager.audio:GetVoiceLength("story_v_out_103031", "103031016", "story_v_out_103031.awb") / 1000

					if var_67_38 + var_67_30 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_38 + var_67_30
					end

					if var_67_33.prefab_name ~= "" and arg_64_1.actors_[var_67_33.prefab_name] ~= nil then
						local var_67_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_33.prefab_name].transform, "story_v_out_103031", "103031016", "story_v_out_103031.awb")

						arg_64_1:RecordAudio("103031016", var_67_39)
						arg_64_1:RecordAudio("103031016", var_67_39)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_103031", "103031016", "story_v_out_103031.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_103031", "103031016", "story_v_out_103031.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_40 = math.max(var_67_31, arg_64_1.talkMaxDuration)

			if var_67_30 <= arg_64_1.time_ and arg_64_1.time_ < var_67_30 + var_67_40 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_30) / var_67_40

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_30 + var_67_40 and arg_64_1.time_ < var_67_30 + var_67_40 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
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

		arg_64_1:InitPlayNodeList()
	end,
	Play103031017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 103031017
		arg_68_1.duration_ = 11.7

		local var_68_0 = {
			ja = 11.7,
			ko = 9.633,
			zh = 9.933,
			en = 7.6
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
				arg_68_0:Play103031018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["4010ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect4010ui_story == nil then
				arg_68_1.var_.characterEffect4010ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.1

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect4010ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect4010ui_story then
				arg_68_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_71_4 = arg_68_1.actors_["1011ui_story"]
			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect1011ui_story == nil then
				arg_68_1.var_.characterEffect1011ui_story = var_71_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_6 = 0.1

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_6 and not isNil(var_71_4) then
				local var_71_7 = (arg_68_1.time_ - var_71_5) / var_71_6

				if arg_68_1.var_.characterEffect1011ui_story and not isNil(var_71_4) then
					local var_71_8 = Mathf.Lerp(0, 0.5, var_71_7)

					arg_68_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1011ui_story.fillRatio = var_71_8
				end
			end

			if arg_68_1.time_ >= var_71_5 + var_71_6 and arg_68_1.time_ < var_71_5 + var_71_6 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect1011ui_story then
				local var_71_9 = 0.5

				arg_68_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1011ui_story.fillRatio = var_71_9
			end

			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 then
				arg_68_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_71_11 = 0
			local var_71_12 = 1.075

			if var_71_11 < arg_68_1.time_ and arg_68_1.time_ <= var_71_11 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_13 = arg_68_1:FormatText(StoryNameCfg[42].name)

				arg_68_1.leftNameTxt_.text = var_71_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_14 = arg_68_1:GetWordFromCfg(103031017)
				local var_71_15 = arg_68_1:FormatText(var_71_14.content)

				arg_68_1.text_.text = var_71_15

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_16 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031017", "story_v_out_103031.awb") ~= 0 then
					local var_71_19 = manager.audio:GetVoiceLength("story_v_out_103031", "103031017", "story_v_out_103031.awb") / 1000

					if var_71_19 + var_71_11 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_19 + var_71_11
					end

					if var_71_14.prefab_name ~= "" and arg_68_1.actors_[var_71_14.prefab_name] ~= nil then
						local var_71_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_14.prefab_name].transform, "story_v_out_103031", "103031017", "story_v_out_103031.awb")

						arg_68_1:RecordAudio("103031017", var_71_20)
						arg_68_1:RecordAudio("103031017", var_71_20)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_103031", "103031017", "story_v_out_103031.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_103031", "103031017", "story_v_out_103031.awb")
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
	Play103031018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 103031018
		arg_72_1.duration_ = 12.7

		local var_72_0 = {
			ja = 12.7,
			ko = 9.5,
			zh = 10.666,
			en = 11.8
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
				arg_72_0:Play103031019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_75_1 = 0
			local var_75_2 = 1.15

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_3 = arg_72_1:FormatText(StoryNameCfg[42].name)

				arg_72_1.leftNameTxt_.text = var_75_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_4 = arg_72_1:GetWordFromCfg(103031018)
				local var_75_5 = arg_72_1:FormatText(var_75_4.content)

				arg_72_1.text_.text = var_75_5

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_6 = 47
				local var_75_7 = utf8.len(var_75_5)
				local var_75_8 = var_75_6 <= 0 and var_75_2 or var_75_2 * (var_75_7 / var_75_6)

				if var_75_8 > 0 and var_75_2 < var_75_8 then
					arg_72_1.talkMaxDuration = var_75_8

					if var_75_8 + var_75_1 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_1
					end
				end

				arg_72_1.text_.text = var_75_5
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031018", "story_v_out_103031.awb") ~= 0 then
					local var_75_9 = manager.audio:GetVoiceLength("story_v_out_103031", "103031018", "story_v_out_103031.awb") / 1000

					if var_75_9 + var_75_1 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_9 + var_75_1
					end

					if var_75_4.prefab_name ~= "" and arg_72_1.actors_[var_75_4.prefab_name] ~= nil then
						local var_75_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_4.prefab_name].transform, "story_v_out_103031", "103031018", "story_v_out_103031.awb")

						arg_72_1:RecordAudio("103031018", var_75_10)
						arg_72_1:RecordAudio("103031018", var_75_10)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_103031", "103031018", "story_v_out_103031.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_103031", "103031018", "story_v_out_103031.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_11 = math.max(var_75_2, arg_72_1.talkMaxDuration)

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_11 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_1) / var_75_11

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_1 + var_75_11 and arg_72_1.time_ < var_75_1 + var_75_11 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play103031019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 103031019
		arg_76_1.duration_ = 6.2

		local var_76_0 = {
			ja = 4.433,
			ko = 5.533,
			zh = 4.8,
			en = 6.2
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
				arg_76_0:Play103031020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_79_1 = 0
			local var_79_2 = 0.375

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_3 = arg_76_1:FormatText(StoryNameCfg[42].name)

				arg_76_1.leftNameTxt_.text = var_79_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_4 = arg_76_1:GetWordFromCfg(103031019)
				local var_79_5 = arg_76_1:FormatText(var_79_4.content)

				arg_76_1.text_.text = var_79_5

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_6 = 15
				local var_79_7 = utf8.len(var_79_5)
				local var_79_8 = var_79_6 <= 0 and var_79_2 or var_79_2 * (var_79_7 / var_79_6)

				if var_79_8 > 0 and var_79_2 < var_79_8 then
					arg_76_1.talkMaxDuration = var_79_8

					if var_79_8 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_1
					end
				end

				arg_76_1.text_.text = var_79_5
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031019", "story_v_out_103031.awb") ~= 0 then
					local var_79_9 = manager.audio:GetVoiceLength("story_v_out_103031", "103031019", "story_v_out_103031.awb") / 1000

					if var_79_9 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_9 + var_79_1
					end

					if var_79_4.prefab_name ~= "" and arg_76_1.actors_[var_79_4.prefab_name] ~= nil then
						local var_79_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_4.prefab_name].transform, "story_v_out_103031", "103031019", "story_v_out_103031.awb")

						arg_76_1:RecordAudio("103031019", var_79_10)
						arg_76_1:RecordAudio("103031019", var_79_10)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_103031", "103031019", "story_v_out_103031.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_103031", "103031019", "story_v_out_103031.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_11 = math.max(var_79_2, arg_76_1.talkMaxDuration)

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_11 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_1) / var_79_11

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_1 + var_79_11 and arg_76_1.time_ < var_79_1 + var_79_11 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play103031020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 103031020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play103031021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1019ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1019ui_story == nil then
				arg_80_1.var_.characterEffect1019ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.1

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect1019ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1019ui_story then
				arg_80_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_83_4 = arg_80_1.actors_["4010ui_story"]
			local var_83_5 = 0

			if var_83_5 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect4010ui_story == nil then
				arg_80_1.var_.characterEffect4010ui_story = var_83_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_6 = 0.1

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_6 and not isNil(var_83_4) then
				local var_83_7 = (arg_80_1.time_ - var_83_5) / var_83_6

				if arg_80_1.var_.characterEffect4010ui_story and not isNil(var_83_4) then
					local var_83_8 = Mathf.Lerp(0, 0.5, var_83_7)

					arg_80_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_80_1.var_.characterEffect4010ui_story.fillRatio = var_83_8
				end
			end

			if arg_80_1.time_ >= var_83_5 + var_83_6 and arg_80_1.time_ < var_83_5 + var_83_6 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect4010ui_story then
				local var_83_9 = 0.5

				arg_80_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_80_1.var_.characterEffect4010ui_story.fillRatio = var_83_9
			end

			local var_83_10 = 0
			local var_83_11 = 0.875

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_12 = arg_80_1:FormatText(StoryNameCfg[7].name)

				arg_80_1.leftNameTxt_.text = var_83_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_13 = arg_80_1:GetWordFromCfg(103031020)
				local var_83_14 = arg_80_1:FormatText(var_83_13.content)

				arg_80_1.text_.text = var_83_14

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_15 = 35
				local var_83_16 = utf8.len(var_83_14)
				local var_83_17 = var_83_15 <= 0 and var_83_11 or var_83_11 * (var_83_16 / var_83_15)

				if var_83_17 > 0 and var_83_11 < var_83_17 then
					arg_80_1.talkMaxDuration = var_83_17

					if var_83_17 + var_83_10 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_17 + var_83_10
					end
				end

				arg_80_1.text_.text = var_83_14
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_18 = math.max(var_83_11, arg_80_1.talkMaxDuration)

			if var_83_10 <= arg_80_1.time_ and arg_80_1.time_ < var_83_10 + var_83_18 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_10) / var_83_18

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_10 + var_83_18 and arg_80_1.time_ < var_83_10 + var_83_18 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play103031021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 103031021
		arg_84_1.duration_ = 9.17

		local var_84_0 = {
			ja = 9.166,
			ko = 6.7,
			zh = 7.533,
			en = 7.5
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play103031022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_87_1 = 0
			local var_87_2 = 0.925

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_3 = arg_84_1:FormatText(StoryNameCfg[13].name)

				arg_84_1.leftNameTxt_.text = var_87_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_4 = arg_84_1:GetWordFromCfg(103031021)
				local var_87_5 = arg_84_1:FormatText(var_87_4.content)

				arg_84_1.text_.text = var_87_5

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_6 = 37
				local var_87_7 = utf8.len(var_87_5)
				local var_87_8 = var_87_6 <= 0 and var_87_2 or var_87_2 * (var_87_7 / var_87_6)

				if var_87_8 > 0 and var_87_2 < var_87_8 then
					arg_84_1.talkMaxDuration = var_87_8

					if var_87_8 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_1
					end
				end

				arg_84_1.text_.text = var_87_5
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031021", "story_v_out_103031.awb") ~= 0 then
					local var_87_9 = manager.audio:GetVoiceLength("story_v_out_103031", "103031021", "story_v_out_103031.awb") / 1000

					if var_87_9 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_9 + var_87_1
					end

					if var_87_4.prefab_name ~= "" and arg_84_1.actors_[var_87_4.prefab_name] ~= nil then
						local var_87_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_4.prefab_name].transform, "story_v_out_103031", "103031021", "story_v_out_103031.awb")

						arg_84_1:RecordAudio("103031021", var_87_10)
						arg_84_1:RecordAudio("103031021", var_87_10)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_103031", "103031021", "story_v_out_103031.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_103031", "103031021", "story_v_out_103031.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_11 = math.max(var_87_2, arg_84_1.talkMaxDuration)

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_11 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_1) / var_87_11

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_1 + var_87_11 and arg_84_1.time_ < var_87_1 + var_87_11 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play103031022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 103031022
		arg_88_1.duration_ = 5.8

		local var_88_0 = {
			ja = 5.8,
			ko = 3.6,
			zh = 3,
			en = 2.8
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
				arg_88_0:Play103031023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["4010ui_story"].transform
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.var_.moveOldPos4010ui_story = var_91_0.localPosition
			end

			local var_91_2 = 0.001

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2
				local var_91_4 = Vector3.New(0, 100, 0)

				var_91_0.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos4010ui_story, var_91_4, var_91_3)

				local var_91_5 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_5.x, var_91_5.y, var_91_5.z)

				local var_91_6 = var_91_0.localEulerAngles

				var_91_6.z = 0
				var_91_6.x = 0
				var_91_0.localEulerAngles = var_91_6
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 then
				var_91_0.localPosition = Vector3.New(0, 100, 0)

				local var_91_7 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_7.x, var_91_7.y, var_91_7.z)

				local var_91_8 = var_91_0.localEulerAngles

				var_91_8.z = 0
				var_91_8.x = 0
				var_91_0.localEulerAngles = var_91_8
			end

			local var_91_9 = arg_88_1.actors_["1011ui_story"].transform
			local var_91_10 = 0

			if var_91_10 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 then
				arg_88_1.var_.moveOldPos1011ui_story = var_91_9.localPosition
			end

			local var_91_11 = 0.001

			if var_91_10 <= arg_88_1.time_ and arg_88_1.time_ < var_91_10 + var_91_11 then
				local var_91_12 = (arg_88_1.time_ - var_91_10) / var_91_11
				local var_91_13 = Vector3.New(0, 100, 0)

				var_91_9.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1011ui_story, var_91_13, var_91_12)

				local var_91_14 = manager.ui.mainCamera.transform.position - var_91_9.position

				var_91_9.forward = Vector3.New(var_91_14.x, var_91_14.y, var_91_14.z)

				local var_91_15 = var_91_9.localEulerAngles

				var_91_15.z = 0
				var_91_15.x = 0
				var_91_9.localEulerAngles = var_91_15
			end

			if arg_88_1.time_ >= var_91_10 + var_91_11 and arg_88_1.time_ < var_91_10 + var_91_11 + arg_91_0 then
				var_91_9.localPosition = Vector3.New(0, 100, 0)

				local var_91_16 = manager.ui.mainCamera.transform.position - var_91_9.position

				var_91_9.forward = Vector3.New(var_91_16.x, var_91_16.y, var_91_16.z)

				local var_91_17 = var_91_9.localEulerAngles

				var_91_17.z = 0
				var_91_17.x = 0
				var_91_9.localEulerAngles = var_91_17
			end

			local var_91_18 = arg_88_1.actors_["1019ui_story"].transform
			local var_91_19 = 0

			if var_91_19 < arg_88_1.time_ and arg_88_1.time_ <= var_91_19 + arg_91_0 then
				arg_88_1.var_.moveOldPos1019ui_story = var_91_18.localPosition
			end

			local var_91_20 = 0.001

			if var_91_19 <= arg_88_1.time_ and arg_88_1.time_ < var_91_19 + var_91_20 then
				local var_91_21 = (arg_88_1.time_ - var_91_19) / var_91_20
				local var_91_22 = Vector3.New(-0.2, -1.08, -5.9)

				var_91_18.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1019ui_story, var_91_22, var_91_21)

				local var_91_23 = manager.ui.mainCamera.transform.position - var_91_18.position

				var_91_18.forward = Vector3.New(var_91_23.x, var_91_23.y, var_91_23.z)

				local var_91_24 = var_91_18.localEulerAngles

				var_91_24.z = 0
				var_91_24.x = 0
				var_91_18.localEulerAngles = var_91_24
			end

			if arg_88_1.time_ >= var_91_19 + var_91_20 and arg_88_1.time_ < var_91_19 + var_91_20 + arg_91_0 then
				var_91_18.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_91_25 = manager.ui.mainCamera.transform.position - var_91_18.position

				var_91_18.forward = Vector3.New(var_91_25.x, var_91_25.y, var_91_25.z)

				local var_91_26 = var_91_18.localEulerAngles

				var_91_26.z = 0
				var_91_26.x = 0
				var_91_18.localEulerAngles = var_91_26
			end

			local var_91_27 = 0

			if var_91_27 < arg_88_1.time_ and arg_88_1.time_ <= var_91_27 + arg_91_0 then
				arg_88_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action4_1")
			end

			local var_91_28 = 0

			if var_91_28 < arg_88_1.time_ and arg_88_1.time_ <= var_91_28 + arg_91_0 then
				arg_88_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_91_29 = 0
			local var_91_30 = 0.325

			if var_91_29 < arg_88_1.time_ and arg_88_1.time_ <= var_91_29 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_31 = arg_88_1:FormatText(StoryNameCfg[13].name)

				arg_88_1.leftNameTxt_.text = var_91_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_32 = arg_88_1:GetWordFromCfg(103031022)
				local var_91_33 = arg_88_1:FormatText(var_91_32.content)

				arg_88_1.text_.text = var_91_33

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_34 = 13
				local var_91_35 = utf8.len(var_91_33)
				local var_91_36 = var_91_34 <= 0 and var_91_30 or var_91_30 * (var_91_35 / var_91_34)

				if var_91_36 > 0 and var_91_30 < var_91_36 then
					arg_88_1.talkMaxDuration = var_91_36

					if var_91_36 + var_91_29 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_36 + var_91_29
					end
				end

				arg_88_1.text_.text = var_91_33
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031022", "story_v_out_103031.awb") ~= 0 then
					local var_91_37 = manager.audio:GetVoiceLength("story_v_out_103031", "103031022", "story_v_out_103031.awb") / 1000

					if var_91_37 + var_91_29 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_37 + var_91_29
					end

					if var_91_32.prefab_name ~= "" and arg_88_1.actors_[var_91_32.prefab_name] ~= nil then
						local var_91_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_32.prefab_name].transform, "story_v_out_103031", "103031022", "story_v_out_103031.awb")

						arg_88_1:RecordAudio("103031022", var_91_38)
						arg_88_1:RecordAudio("103031022", var_91_38)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_103031", "103031022", "story_v_out_103031.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_103031", "103031022", "story_v_out_103031.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_39 = math.max(var_91_30, arg_88_1.talkMaxDuration)

			if var_91_29 <= arg_88_1.time_ and arg_88_1.time_ < var_91_29 + var_91_39 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_29) / var_91_39

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_29 + var_91_39 and arg_88_1.time_ < var_91_29 + var_91_39 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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

		arg_88_1:InitPlayNodeList()
	end,
	Play103031023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 103031023
		arg_92_1.duration_ = 5.13

		local var_92_0 = {
			ja = 5.133,
			ko = 3.466,
			zh = 3.6,
			en = 3.066
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
				arg_92_0:Play103031024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["4010ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect4010ui_story == nil then
				arg_92_1.var_.characterEffect4010ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.1

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect4010ui_story and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect4010ui_story then
				arg_92_1.var_.characterEffect4010ui_story.fillFlat = false
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

			local var_95_12 = 0.5

			if var_95_11 <= arg_92_1.time_ and arg_92_1.time_ < var_95_11 + var_95_12 then
				local var_95_13 = (arg_92_1.time_ - var_95_11) / var_95_12
				local var_95_14 = Vector3.New(-0.7, -1.08, -5.9)

				var_95_10.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1019ui_story, var_95_14, var_95_13)

				local var_95_15 = manager.ui.mainCamera.transform.position - var_95_10.position

				var_95_10.forward = Vector3.New(var_95_15.x, var_95_15.y, var_95_15.z)

				local var_95_16 = var_95_10.localEulerAngles

				var_95_16.z = 0
				var_95_16.x = 0
				var_95_10.localEulerAngles = var_95_16
			end

			if arg_92_1.time_ >= var_95_11 + var_95_12 and arg_92_1.time_ < var_95_11 + var_95_12 + arg_95_0 then
				var_95_10.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_95_17 = manager.ui.mainCamera.transform.position - var_95_10.position

				var_95_10.forward = Vector3.New(var_95_17.x, var_95_17.y, var_95_17.z)

				local var_95_18 = var_95_10.localEulerAngles

				var_95_18.z = 0
				var_95_18.x = 0
				var_95_10.localEulerAngles = var_95_18
			end

			local var_95_19 = arg_92_1.actors_["4010ui_story"].transform
			local var_95_20 = 0

			if var_95_20 < arg_92_1.time_ and arg_92_1.time_ <= var_95_20 + arg_95_0 then
				arg_92_1.var_.moveOldPos4010ui_story = var_95_19.localPosition
			end

			local var_95_21 = 0.001

			if var_95_20 <= arg_92_1.time_ and arg_92_1.time_ < var_95_20 + var_95_21 then
				local var_95_22 = (arg_92_1.time_ - var_95_20) / var_95_21
				local var_95_23 = Vector3.New(0.7, -1.59, -5.2)

				var_95_19.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos4010ui_story, var_95_23, var_95_22)

				local var_95_24 = manager.ui.mainCamera.transform.position - var_95_19.position

				var_95_19.forward = Vector3.New(var_95_24.x, var_95_24.y, var_95_24.z)

				local var_95_25 = var_95_19.localEulerAngles

				var_95_25.z = 0
				var_95_25.x = 0
				var_95_19.localEulerAngles = var_95_25
			end

			if arg_92_1.time_ >= var_95_20 + var_95_21 and arg_92_1.time_ < var_95_20 + var_95_21 + arg_95_0 then
				var_95_19.localPosition = Vector3.New(0.7, -1.59, -5.2)

				local var_95_26 = manager.ui.mainCamera.transform.position - var_95_19.position

				var_95_19.forward = Vector3.New(var_95_26.x, var_95_26.y, var_95_26.z)

				local var_95_27 = var_95_19.localEulerAngles

				var_95_27.z = 0
				var_95_27.x = 0
				var_95_19.localEulerAngles = var_95_27
			end

			local var_95_28 = 0

			if var_95_28 < arg_92_1.time_ and arg_92_1.time_ <= var_95_28 + arg_95_0 then
				arg_92_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_95_29 = 0

			if var_95_29 < arg_92_1.time_ and arg_92_1.time_ <= var_95_29 + arg_95_0 then
				arg_92_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_95_30 = 0
			local var_95_31 = 0.275

			if var_95_30 < arg_92_1.time_ and arg_92_1.time_ <= var_95_30 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_32 = arg_92_1:FormatText(StoryNameCfg[42].name)

				arg_92_1.leftNameTxt_.text = var_95_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_33 = arg_92_1:GetWordFromCfg(103031023)
				local var_95_34 = arg_92_1:FormatText(var_95_33.content)

				arg_92_1.text_.text = var_95_34

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_35 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031023", "story_v_out_103031.awb") ~= 0 then
					local var_95_38 = manager.audio:GetVoiceLength("story_v_out_103031", "103031023", "story_v_out_103031.awb") / 1000

					if var_95_38 + var_95_30 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_38 + var_95_30
					end

					if var_95_33.prefab_name ~= "" and arg_92_1.actors_[var_95_33.prefab_name] ~= nil then
						local var_95_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_33.prefab_name].transform, "story_v_out_103031", "103031023", "story_v_out_103031.awb")

						arg_92_1:RecordAudio("103031023", var_95_39)
						arg_92_1:RecordAudio("103031023", var_95_39)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_103031", "103031023", "story_v_out_103031.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_103031", "103031023", "story_v_out_103031.awb")
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
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play103031024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 103031024
		arg_96_1.duration_ = 7.7

		local var_96_0 = {
			ja = 7.7,
			ko = 5.4,
			zh = 5.633,
			en = 7.233
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
				arg_96_0:Play103031025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["3008ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect3008ui_story == nil then
				arg_96_1.var_.characterEffect3008ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.1

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect3008ui_story and not isNil(var_99_0) then
					arg_96_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect3008ui_story then
				arg_96_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_99_4 = arg_96_1.actors_["4010ui_story"]
			local var_99_5 = 0

			if var_99_5 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect4010ui_story == nil then
				arg_96_1.var_.characterEffect4010ui_story = var_99_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_6 = 0.1

			if var_99_5 <= arg_96_1.time_ and arg_96_1.time_ < var_99_5 + var_99_6 and not isNil(var_99_4) then
				local var_99_7 = (arg_96_1.time_ - var_99_5) / var_99_6

				if arg_96_1.var_.characterEffect4010ui_story and not isNil(var_99_4) then
					local var_99_8 = Mathf.Lerp(0, 0.5, var_99_7)

					arg_96_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_96_1.var_.characterEffect4010ui_story.fillRatio = var_99_8
				end
			end

			if arg_96_1.time_ >= var_99_5 + var_99_6 and arg_96_1.time_ < var_99_5 + var_99_6 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect4010ui_story then
				local var_99_9 = 0.5

				arg_96_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_96_1.var_.characterEffect4010ui_story.fillRatio = var_99_9
			end

			local var_99_10 = 0
			local var_99_11 = 0.575

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_12 = arg_96_1:FormatText(StoryNameCfg[20].name)

				arg_96_1.leftNameTxt_.text = var_99_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_13 = arg_96_1:GetWordFromCfg(103031024)
				local var_99_14 = arg_96_1:FormatText(var_99_13.content)

				arg_96_1.text_.text = var_99_14

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_15 = 23
				local var_99_16 = utf8.len(var_99_14)
				local var_99_17 = var_99_15 <= 0 and var_99_11 or var_99_11 * (var_99_16 / var_99_15)

				if var_99_17 > 0 and var_99_11 < var_99_17 then
					arg_96_1.talkMaxDuration = var_99_17

					if var_99_17 + var_99_10 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_17 + var_99_10
					end
				end

				arg_96_1.text_.text = var_99_14
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031024", "story_v_out_103031.awb") ~= 0 then
					local var_99_18 = manager.audio:GetVoiceLength("story_v_out_103031", "103031024", "story_v_out_103031.awb") / 1000

					if var_99_18 + var_99_10 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_18 + var_99_10
					end

					if var_99_13.prefab_name ~= "" and arg_96_1.actors_[var_99_13.prefab_name] ~= nil then
						local var_99_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_13.prefab_name].transform, "story_v_out_103031", "103031024", "story_v_out_103031.awb")

						arg_96_1:RecordAudio("103031024", var_99_19)
						arg_96_1:RecordAudio("103031024", var_99_19)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_103031", "103031024", "story_v_out_103031.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_103031", "103031024", "story_v_out_103031.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_20 = math.max(var_99_11, arg_96_1.talkMaxDuration)

			if var_99_10 <= arg_96_1.time_ and arg_96_1.time_ < var_99_10 + var_99_20 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_10) / var_99_20

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_10 + var_99_20 and arg_96_1.time_ < var_99_10 + var_99_20 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play103031025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 103031025
		arg_100_1.duration_ = 6.07

		local var_100_0 = {
			ja = 6.066,
			ko = 3.633,
			zh = 2.833,
			en = 2.7
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
				arg_100_0:Play103031026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1019ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1019ui_story == nil then
				arg_100_1.var_.characterEffect1019ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.1

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1019ui_story and not isNil(var_103_0) then
					arg_100_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1019ui_story then
				arg_100_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_103_4 = arg_100_1.actors_["3008ui_story"]
			local var_103_5 = 0

			if var_103_5 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect3008ui_story == nil then
				arg_100_1.var_.characterEffect3008ui_story = var_103_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_6 = 0.1

			if var_103_5 <= arg_100_1.time_ and arg_100_1.time_ < var_103_5 + var_103_6 and not isNil(var_103_4) then
				local var_103_7 = (arg_100_1.time_ - var_103_5) / var_103_6

				if arg_100_1.var_.characterEffect3008ui_story and not isNil(var_103_4) then
					local var_103_8 = Mathf.Lerp(0, 0.5, var_103_7)

					arg_100_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_100_1.var_.characterEffect3008ui_story.fillRatio = var_103_8
				end
			end

			if arg_100_1.time_ >= var_103_5 + var_103_6 and arg_100_1.time_ < var_103_5 + var_103_6 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect3008ui_story then
				local var_103_9 = 0.5

				arg_100_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_100_1.var_.characterEffect3008ui_story.fillRatio = var_103_9
			end

			local var_103_10 = 0

			if var_103_10 < arg_100_1.time_ and arg_100_1.time_ <= var_103_10 + arg_103_0 then
				arg_100_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action445")
			end

			local var_103_11 = 0

			if var_103_11 < arg_100_1.time_ and arg_100_1.time_ <= var_103_11 + arg_103_0 then
				arg_100_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_103_12 = 0
			local var_103_13 = 0.375

			if var_103_12 < arg_100_1.time_ and arg_100_1.time_ <= var_103_12 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_14 = arg_100_1:FormatText(StoryNameCfg[13].name)

				arg_100_1.leftNameTxt_.text = var_103_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_15 = arg_100_1:GetWordFromCfg(103031025)
				local var_103_16 = arg_100_1:FormatText(var_103_15.content)

				arg_100_1.text_.text = var_103_16

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_17 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031025", "story_v_out_103031.awb") ~= 0 then
					local var_103_20 = manager.audio:GetVoiceLength("story_v_out_103031", "103031025", "story_v_out_103031.awb") / 1000

					if var_103_20 + var_103_12 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_20 + var_103_12
					end

					if var_103_15.prefab_name ~= "" and arg_100_1.actors_[var_103_15.prefab_name] ~= nil then
						local var_103_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_15.prefab_name].transform, "story_v_out_103031", "103031025", "story_v_out_103031.awb")

						arg_100_1:RecordAudio("103031025", var_103_21)
						arg_100_1:RecordAudio("103031025", var_103_21)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_103031", "103031025", "story_v_out_103031.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_103031", "103031025", "story_v_out_103031.awb")
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
	Play103031026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 103031026
		arg_104_1.duration_ = 5.1

		local var_104_0 = {
			ja = 4.7,
			ko = 3.966,
			zh = 3.6,
			en = 5.1
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
				arg_104_0:Play103031027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["4010ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect4010ui_story == nil then
				arg_104_1.var_.characterEffect4010ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.1

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect4010ui_story and not isNil(var_107_0) then
					arg_104_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect4010ui_story then
				arg_104_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_107_4 = arg_104_1.actors_["1019ui_story"]
			local var_107_5 = 0

			if var_107_5 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 and not isNil(var_107_4) and arg_104_1.var_.characterEffect1019ui_story == nil then
				arg_104_1.var_.characterEffect1019ui_story = var_107_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_6 = 0.1

			if var_107_5 <= arg_104_1.time_ and arg_104_1.time_ < var_107_5 + var_107_6 and not isNil(var_107_4) then
				local var_107_7 = (arg_104_1.time_ - var_107_5) / var_107_6

				if arg_104_1.var_.characterEffect1019ui_story and not isNil(var_107_4) then
					local var_107_8 = Mathf.Lerp(0, 0.5, var_107_7)

					arg_104_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1019ui_story.fillRatio = var_107_8
				end
			end

			if arg_104_1.time_ >= var_107_5 + var_107_6 and arg_104_1.time_ < var_107_5 + var_107_6 + arg_107_0 and not isNil(var_107_4) and arg_104_1.var_.characterEffect1019ui_story then
				local var_107_9 = 0.5

				arg_104_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1019ui_story.fillRatio = var_107_9
			end

			local var_107_10 = 0

			if var_107_10 < arg_104_1.time_ and arg_104_1.time_ <= var_107_10 + arg_107_0 then
				arg_104_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_107_11 = 0
			local var_107_12 = 0.35

			if var_107_11 < arg_104_1.time_ and arg_104_1.time_ <= var_107_11 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_13 = arg_104_1:FormatText(StoryNameCfg[42].name)

				arg_104_1.leftNameTxt_.text = var_107_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_14 = arg_104_1:GetWordFromCfg(103031026)
				local var_107_15 = arg_104_1:FormatText(var_107_14.content)

				arg_104_1.text_.text = var_107_15

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_16 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031026", "story_v_out_103031.awb") ~= 0 then
					local var_107_19 = manager.audio:GetVoiceLength("story_v_out_103031", "103031026", "story_v_out_103031.awb") / 1000

					if var_107_19 + var_107_11 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_19 + var_107_11
					end

					if var_107_14.prefab_name ~= "" and arg_104_1.actors_[var_107_14.prefab_name] ~= nil then
						local var_107_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_14.prefab_name].transform, "story_v_out_103031", "103031026", "story_v_out_103031.awb")

						arg_104_1:RecordAudio("103031026", var_107_20)
						arg_104_1:RecordAudio("103031026", var_107_20)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_103031", "103031026", "story_v_out_103031.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_103031", "103031026", "story_v_out_103031.awb")
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
	Play103031027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 103031027
		arg_108_1.duration_ = 1.07

		local var_108_0 = {
			ja = 1.066,
			ko = 1,
			zh = 0.999999999999,
			en = 0.999999999999
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
				arg_108_0:Play103031028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1019ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1019ui_story == nil then
				arg_108_1.var_.characterEffect1019ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.1

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect1019ui_story and not isNil(var_111_0) then
					arg_108_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1019ui_story then
				arg_108_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_111_4 = arg_108_1.actors_["4010ui_story"]
			local var_111_5 = 0

			if var_111_5 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect4010ui_story == nil then
				arg_108_1.var_.characterEffect4010ui_story = var_111_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_6 = 0.1

			if var_111_5 <= arg_108_1.time_ and arg_108_1.time_ < var_111_5 + var_111_6 and not isNil(var_111_4) then
				local var_111_7 = (arg_108_1.time_ - var_111_5) / var_111_6

				if arg_108_1.var_.characterEffect4010ui_story and not isNil(var_111_4) then
					local var_111_8 = Mathf.Lerp(0, 0.5, var_111_7)

					arg_108_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_108_1.var_.characterEffect4010ui_story.fillRatio = var_111_8
				end
			end

			if arg_108_1.time_ >= var_111_5 + var_111_6 and arg_108_1.time_ < var_111_5 + var_111_6 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect4010ui_story then
				local var_111_9 = 0.5

				arg_108_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_108_1.var_.characterEffect4010ui_story.fillRatio = var_111_9
			end

			local var_111_10 = 0

			if var_111_10 < arg_108_1.time_ and arg_108_1.time_ <= var_111_10 + arg_111_0 then
				arg_108_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_111_11 = 0
			local var_111_12 = 0.05

			if var_111_11 < arg_108_1.time_ and arg_108_1.time_ <= var_111_11 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_13 = arg_108_1:FormatText(StoryNameCfg[13].name)

				arg_108_1.leftNameTxt_.text = var_111_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_14 = arg_108_1:GetWordFromCfg(103031027)
				local var_111_15 = arg_108_1:FormatText(var_111_14.content)

				arg_108_1.text_.text = var_111_15

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_16 = 2
				local var_111_17 = utf8.len(var_111_15)
				local var_111_18 = var_111_16 <= 0 and var_111_12 or var_111_12 * (var_111_17 / var_111_16)

				if var_111_18 > 0 and var_111_12 < var_111_18 then
					arg_108_1.talkMaxDuration = var_111_18

					if var_111_18 + var_111_11 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_18 + var_111_11
					end
				end

				arg_108_1.text_.text = var_111_15
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031027", "story_v_out_103031.awb") ~= 0 then
					local var_111_19 = manager.audio:GetVoiceLength("story_v_out_103031", "103031027", "story_v_out_103031.awb") / 1000

					if var_111_19 + var_111_11 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_19 + var_111_11
					end

					if var_111_14.prefab_name ~= "" and arg_108_1.actors_[var_111_14.prefab_name] ~= nil then
						local var_111_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_14.prefab_name].transform, "story_v_out_103031", "103031027", "story_v_out_103031.awb")

						arg_108_1:RecordAudio("103031027", var_111_20)
						arg_108_1:RecordAudio("103031027", var_111_20)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_103031", "103031027", "story_v_out_103031.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_103031", "103031027", "story_v_out_103031.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_21 = math.max(var_111_12, arg_108_1.talkMaxDuration)

			if var_111_11 <= arg_108_1.time_ and arg_108_1.time_ < var_111_11 + var_111_21 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_11) / var_111_21

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_11 + var_111_21 and arg_108_1.time_ < var_111_11 + var_111_21 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play103031028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 103031028
		arg_112_1.duration_ = 4.87

		local var_112_0 = {
			ja = 4.7,
			ko = 4,
			zh = 4.2,
			en = 4.866
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
				arg_112_0:Play103031029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = "2020_tpose"

			if arg_112_1.actors_[var_115_0] == nil then
				local var_115_1 = Asset.Load("Char/" .. "2020_tpose")

				if not isNil(var_115_1) then
					local var_115_2 = Object.Instantiate(Asset.Load("Char/" .. "2020_tpose"), arg_112_1.stage_.transform)

					var_115_2.name = var_115_0
					var_115_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_112_1.actors_[var_115_0] = var_115_2

					local var_115_3 = var_115_2:GetComponentInChildren(typeof(CharacterEffect))

					var_115_3.enabled = true

					local var_115_4 = GameObjectTools.GetOrAddComponent(var_115_2, typeof(DynamicBoneHelper))

					if var_115_4 then
						var_115_4:EnableDynamicBone(false)
					end

					arg_112_1:ShowWeapon(var_115_3.transform, false)

					arg_112_1.var_[var_115_0 .. "Animator"] = var_115_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_112_1.var_[var_115_0 .. "Animator"].applyRootMotion = true
					arg_112_1.var_[var_115_0 .. "LipSync"] = var_115_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_115_5 = arg_112_1.actors_["2020_tpose"]
			local var_115_6 = 0

			if var_115_6 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 and not isNil(var_115_5) and arg_112_1.var_.characterEffect2020_tpose == nil then
				arg_112_1.var_.characterEffect2020_tpose = var_115_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_7 = 0.1

			if var_115_6 <= arg_112_1.time_ and arg_112_1.time_ < var_115_6 + var_115_7 and not isNil(var_115_5) then
				local var_115_8 = (arg_112_1.time_ - var_115_6) / var_115_7

				if arg_112_1.var_.characterEffect2020_tpose and not isNil(var_115_5) then
					arg_112_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_6 + var_115_7 and arg_112_1.time_ < var_115_6 + var_115_7 + arg_115_0 and not isNil(var_115_5) and arg_112_1.var_.characterEffect2020_tpose then
				arg_112_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_115_9 = arg_112_1.actors_["1019ui_story"]
			local var_115_10 = 0

			if var_115_10 < arg_112_1.time_ and arg_112_1.time_ <= var_115_10 + arg_115_0 and not isNil(var_115_9) and arg_112_1.var_.characterEffect1019ui_story == nil then
				arg_112_1.var_.characterEffect1019ui_story = var_115_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_11 = 0.1

			if var_115_10 <= arg_112_1.time_ and arg_112_1.time_ < var_115_10 + var_115_11 and not isNil(var_115_9) then
				local var_115_12 = (arg_112_1.time_ - var_115_10) / var_115_11

				if arg_112_1.var_.characterEffect1019ui_story and not isNil(var_115_9) then
					local var_115_13 = Mathf.Lerp(0, 0.5, var_115_12)

					arg_112_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1019ui_story.fillRatio = var_115_13
				end
			end

			if arg_112_1.time_ >= var_115_10 + var_115_11 and arg_112_1.time_ < var_115_10 + var_115_11 + arg_115_0 and not isNil(var_115_9) and arg_112_1.var_.characterEffect1019ui_story then
				local var_115_14 = 0.5

				arg_112_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1019ui_story.fillRatio = var_115_14
			end

			local var_115_15 = arg_112_1.actors_["1019ui_story"].transform
			local var_115_16 = 0

			if var_115_16 < arg_112_1.time_ and arg_112_1.time_ <= var_115_16 + arg_115_0 then
				arg_112_1.var_.moveOldPos1019ui_story = var_115_15.localPosition
			end

			local var_115_17 = 0.001

			if var_115_16 <= arg_112_1.time_ and arg_112_1.time_ < var_115_16 + var_115_17 then
				local var_115_18 = (arg_112_1.time_ - var_115_16) / var_115_17
				local var_115_19 = Vector3.New(0, 100, 0)

				var_115_15.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1019ui_story, var_115_19, var_115_18)

				local var_115_20 = manager.ui.mainCamera.transform.position - var_115_15.position

				var_115_15.forward = Vector3.New(var_115_20.x, var_115_20.y, var_115_20.z)

				local var_115_21 = var_115_15.localEulerAngles

				var_115_21.z = 0
				var_115_21.x = 0
				var_115_15.localEulerAngles = var_115_21
			end

			if arg_112_1.time_ >= var_115_16 + var_115_17 and arg_112_1.time_ < var_115_16 + var_115_17 + arg_115_0 then
				var_115_15.localPosition = Vector3.New(0, 100, 0)

				local var_115_22 = manager.ui.mainCamera.transform.position - var_115_15.position

				var_115_15.forward = Vector3.New(var_115_22.x, var_115_22.y, var_115_22.z)

				local var_115_23 = var_115_15.localEulerAngles

				var_115_23.z = 0
				var_115_23.x = 0
				var_115_15.localEulerAngles = var_115_23
			end

			local var_115_24 = arg_112_1.actors_["4010ui_story"].transform
			local var_115_25 = 0

			if var_115_25 < arg_112_1.time_ and arg_112_1.time_ <= var_115_25 + arg_115_0 then
				arg_112_1.var_.moveOldPos4010ui_story = var_115_24.localPosition
			end

			local var_115_26 = 0.001

			if var_115_25 <= arg_112_1.time_ and arg_112_1.time_ < var_115_25 + var_115_26 then
				local var_115_27 = (arg_112_1.time_ - var_115_25) / var_115_26
				local var_115_28 = Vector3.New(0, 100, 0)

				var_115_24.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos4010ui_story, var_115_28, var_115_27)

				local var_115_29 = manager.ui.mainCamera.transform.position - var_115_24.position

				var_115_24.forward = Vector3.New(var_115_29.x, var_115_29.y, var_115_29.z)

				local var_115_30 = var_115_24.localEulerAngles

				var_115_30.z = 0
				var_115_30.x = 0
				var_115_24.localEulerAngles = var_115_30
			end

			if arg_112_1.time_ >= var_115_25 + var_115_26 and arg_112_1.time_ < var_115_25 + var_115_26 + arg_115_0 then
				var_115_24.localPosition = Vector3.New(0, 100, 0)

				local var_115_31 = manager.ui.mainCamera.transform.position - var_115_24.position

				var_115_24.forward = Vector3.New(var_115_31.x, var_115_31.y, var_115_31.z)

				local var_115_32 = var_115_24.localEulerAngles

				var_115_32.z = 0
				var_115_32.x = 0
				var_115_24.localEulerAngles = var_115_32
			end

			local var_115_33 = arg_112_1.actors_["2020_tpose"].transform
			local var_115_34 = 0

			if var_115_34 < arg_112_1.time_ and arg_112_1.time_ <= var_115_34 + arg_115_0 then
				arg_112_1.var_.moveOldPos2020_tpose = var_115_33.localPosition

				local var_115_35 = GameObjectTools.GetOrAddComponent(var_115_33.gameObject, typeof(DynamicBoneHelper))

				if var_115_35 then
					var_115_35:EnableDynamicBone(false)
				end
			end

			local var_115_36 = 0.001

			if var_115_34 <= arg_112_1.time_ and arg_112_1.time_ < var_115_34 + var_115_36 then
				local var_115_37 = (arg_112_1.time_ - var_115_34) / var_115_36
				local var_115_38 = Vector3.New(-0.7, -1.2, -4.1)

				var_115_33.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos2020_tpose, var_115_38, var_115_37)

				local var_115_39 = manager.ui.mainCamera.transform.position - var_115_33.position

				var_115_33.forward = Vector3.New(var_115_39.x, var_115_39.y, var_115_39.z)

				local var_115_40 = var_115_33.localEulerAngles

				var_115_40.z = 0
				var_115_40.x = 0
				var_115_33.localEulerAngles = var_115_40
			end

			if arg_112_1.time_ >= var_115_34 + var_115_36 and arg_112_1.time_ < var_115_34 + var_115_36 + arg_115_0 then
				var_115_33.localPosition = Vector3.New(-0.7, -1.2, -4.1)

				local var_115_41 = manager.ui.mainCamera.transform.position - var_115_33.position

				var_115_33.forward = Vector3.New(var_115_41.x, var_115_41.y, var_115_41.z)

				local var_115_42 = var_115_33.localEulerAngles

				var_115_42.z = 0
				var_115_42.x = 0
				var_115_33.localEulerAngles = var_115_42

				local var_115_43 = GameObjectTools.GetOrAddComponent(var_115_33.gameObject, typeof(DynamicBoneHelper))

				if var_115_43 then
					var_115_43:EnableDynamicBone(true)
				end
			end

			local var_115_44 = 0

			if var_115_44 < arg_112_1.time_ and arg_112_1.time_ <= var_115_44 + arg_115_0 then
				arg_112_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_115_45 = 0
			local var_115_46 = 0.45

			if var_115_45 < arg_112_1.time_ and arg_112_1.time_ <= var_115_45 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_47 = arg_112_1:FormatText(StoryNameCfg[34].name)

				arg_112_1.leftNameTxt_.text = var_115_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_48 = arg_112_1:GetWordFromCfg(103031028)
				local var_115_49 = arg_112_1:FormatText(var_115_48.content)

				arg_112_1.text_.text = var_115_49

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_50 = 18
				local var_115_51 = utf8.len(var_115_49)
				local var_115_52 = var_115_50 <= 0 and var_115_46 or var_115_46 * (var_115_51 / var_115_50)

				if var_115_52 > 0 and var_115_46 < var_115_52 then
					arg_112_1.talkMaxDuration = var_115_52

					if var_115_52 + var_115_45 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_52 + var_115_45
					end
				end

				arg_112_1.text_.text = var_115_49
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031028", "story_v_out_103031.awb") ~= 0 then
					local var_115_53 = manager.audio:GetVoiceLength("story_v_out_103031", "103031028", "story_v_out_103031.awb") / 1000

					if var_115_53 + var_115_45 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_53 + var_115_45
					end

					if var_115_48.prefab_name ~= "" and arg_112_1.actors_[var_115_48.prefab_name] ~= nil then
						local var_115_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_48.prefab_name].transform, "story_v_out_103031", "103031028", "story_v_out_103031.awb")

						arg_112_1:RecordAudio("103031028", var_115_54)
						arg_112_1:RecordAudio("103031028", var_115_54)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_103031", "103031028", "story_v_out_103031.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_103031", "103031028", "story_v_out_103031.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_55 = math.max(var_115_46, arg_112_1.talkMaxDuration)

			if var_115_45 <= arg_112_1.time_ and arg_112_1.time_ < var_115_45 + var_115_55 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_45) / var_115_55

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_45 + var_115_55 and arg_112_1.time_ < var_115_45 + var_115_55 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
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
				actorName = "4010ui_story",
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
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play103031029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 103031029
		arg_116_1.duration_ = 4.27

		local var_116_0 = {
			ja = 3.166,
			ko = 4,
			zh = 4.133,
			en = 4.266
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
				arg_116_0:Play103031030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = "2030_tpose"

			if arg_116_1.actors_[var_119_0] == nil then
				local var_119_1 = Asset.Load("Char/" .. "2030_tpose")

				if not isNil(var_119_1) then
					local var_119_2 = Object.Instantiate(Asset.Load("Char/" .. "2030_tpose"), arg_116_1.stage_.transform)

					var_119_2.name = var_119_0
					var_119_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_116_1.actors_[var_119_0] = var_119_2

					local var_119_3 = var_119_2:GetComponentInChildren(typeof(CharacterEffect))

					var_119_3.enabled = true

					local var_119_4 = GameObjectTools.GetOrAddComponent(var_119_2, typeof(DynamicBoneHelper))

					if var_119_4 then
						var_119_4:EnableDynamicBone(false)
					end

					arg_116_1:ShowWeapon(var_119_3.transform, false)

					arg_116_1.var_[var_119_0 .. "Animator"] = var_119_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_116_1.var_[var_119_0 .. "Animator"].applyRootMotion = true
					arg_116_1.var_[var_119_0 .. "LipSync"] = var_119_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_119_5 = arg_116_1.actors_["2030_tpose"]
			local var_119_6 = 0

			if var_119_6 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 and not isNil(var_119_5) and arg_116_1.var_.characterEffect2030_tpose == nil then
				arg_116_1.var_.characterEffect2030_tpose = var_119_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_7 = 0.1

			if var_119_6 <= arg_116_1.time_ and arg_116_1.time_ < var_119_6 + var_119_7 and not isNil(var_119_5) then
				local var_119_8 = (arg_116_1.time_ - var_119_6) / var_119_7

				if arg_116_1.var_.characterEffect2030_tpose and not isNil(var_119_5) then
					arg_116_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_6 + var_119_7 and arg_116_1.time_ < var_119_6 + var_119_7 + arg_119_0 and not isNil(var_119_5) and arg_116_1.var_.characterEffect2030_tpose then
				arg_116_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_119_9 = arg_116_1.actors_["2020_tpose"]
			local var_119_10 = 0

			if var_119_10 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect2020_tpose == nil then
				arg_116_1.var_.characterEffect2020_tpose = var_119_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_11 = 0.1

			if var_119_10 <= arg_116_1.time_ and arg_116_1.time_ < var_119_10 + var_119_11 and not isNil(var_119_9) then
				local var_119_12 = (arg_116_1.time_ - var_119_10) / var_119_11

				if arg_116_1.var_.characterEffect2020_tpose and not isNil(var_119_9) then
					local var_119_13 = Mathf.Lerp(0, 0.5, var_119_12)

					arg_116_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_116_1.var_.characterEffect2020_tpose.fillRatio = var_119_13
				end
			end

			if arg_116_1.time_ >= var_119_10 + var_119_11 and arg_116_1.time_ < var_119_10 + var_119_11 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect2020_tpose then
				local var_119_14 = 0.5

				arg_116_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_116_1.var_.characterEffect2020_tpose.fillRatio = var_119_14
			end

			local var_119_15 = arg_116_1.actors_["2030_tpose"].transform
			local var_119_16 = 0

			if var_119_16 < arg_116_1.time_ and arg_116_1.time_ <= var_119_16 + arg_119_0 then
				arg_116_1.var_.moveOldPos2030_tpose = var_119_15.localPosition

				local var_119_17 = GameObjectTools.GetOrAddComponent(var_119_15.gameObject, typeof(DynamicBoneHelper))

				if var_119_17 then
					var_119_17:EnableDynamicBone(false)
				end
			end

			local var_119_18 = 0.001

			if var_119_16 <= arg_116_1.time_ and arg_116_1.time_ < var_119_16 + var_119_18 then
				local var_119_19 = (arg_116_1.time_ - var_119_16) / var_119_18
				local var_119_20 = Vector3.New(0.7, -1.2, -4.2)

				var_119_15.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos2030_tpose, var_119_20, var_119_19)

				local var_119_21 = manager.ui.mainCamera.transform.position - var_119_15.position

				var_119_15.forward = Vector3.New(var_119_21.x, var_119_21.y, var_119_21.z)

				local var_119_22 = var_119_15.localEulerAngles

				var_119_22.z = 0
				var_119_22.x = 0
				var_119_15.localEulerAngles = var_119_22
			end

			if arg_116_1.time_ >= var_119_16 + var_119_18 and arg_116_1.time_ < var_119_16 + var_119_18 + arg_119_0 then
				var_119_15.localPosition = Vector3.New(0.7, -1.2, -4.2)

				local var_119_23 = manager.ui.mainCamera.transform.position - var_119_15.position

				var_119_15.forward = Vector3.New(var_119_23.x, var_119_23.y, var_119_23.z)

				local var_119_24 = var_119_15.localEulerAngles

				var_119_24.z = 0
				var_119_24.x = 0
				var_119_15.localEulerAngles = var_119_24

				local var_119_25 = GameObjectTools.GetOrAddComponent(var_119_15.gameObject, typeof(DynamicBoneHelper))

				if var_119_25 then
					var_119_25:EnableDynamicBone(true)
				end
			end

			local var_119_26 = 0

			if var_119_26 < arg_116_1.time_ and arg_116_1.time_ <= var_119_26 + arg_119_0 then
				arg_116_1:PlayTimeline("2030_tpose", "StoryTimeline/CharAction/story2030/story2030action/2030action1_1")
			end

			local var_119_27 = 0
			local var_119_28 = 0.5

			if var_119_27 < arg_116_1.time_ and arg_116_1.time_ <= var_119_27 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_29 = arg_116_1:FormatText(StoryNameCfg[34].name)

				arg_116_1.leftNameTxt_.text = var_119_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_30 = arg_116_1:GetWordFromCfg(103031029)
				local var_119_31 = arg_116_1:FormatText(var_119_30.content)

				arg_116_1.text_.text = var_119_31

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_32 = 20
				local var_119_33 = utf8.len(var_119_31)
				local var_119_34 = var_119_32 <= 0 and var_119_28 or var_119_28 * (var_119_33 / var_119_32)

				if var_119_34 > 0 and var_119_28 < var_119_34 then
					arg_116_1.talkMaxDuration = var_119_34

					if var_119_34 + var_119_27 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_34 + var_119_27
					end
				end

				arg_116_1.text_.text = var_119_31
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031029", "story_v_out_103031.awb") ~= 0 then
					local var_119_35 = manager.audio:GetVoiceLength("story_v_out_103031", "103031029", "story_v_out_103031.awb") / 1000

					if var_119_35 + var_119_27 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_35 + var_119_27
					end

					if var_119_30.prefab_name ~= "" and arg_116_1.actors_[var_119_30.prefab_name] ~= nil then
						local var_119_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_30.prefab_name].transform, "story_v_out_103031", "103031029", "story_v_out_103031.awb")

						arg_116_1:RecordAudio("103031029", var_119_36)
						arg_116_1:RecordAudio("103031029", var_119_36)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_103031", "103031029", "story_v_out_103031.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_103031", "103031029", "story_v_out_103031.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_37 = math.max(var_119_28, arg_116_1.talkMaxDuration)

			if var_119_27 <= arg_116_1.time_ and arg_116_1.time_ < var_119_27 + var_119_37 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_27) / var_119_37

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_27 + var_119_37 and arg_116_1.time_ < var_119_27 + var_119_37 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
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

		arg_116_1:InitPlayNodeList()
	end,
	Play103031030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 103031030
		arg_120_1.duration_ = 7.83

		local var_120_0 = {
			ja = 7.833,
			ko = 5.666,
			zh = 6.3,
			en = 5.366
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
				arg_120_0:Play103031031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["4010ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect4010ui_story == nil then
				arg_120_1.var_.characterEffect4010ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.1

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect4010ui_story and not isNil(var_123_0) then
					arg_120_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect4010ui_story then
				arg_120_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_123_4 = arg_120_1.actors_["2030_tpose"]
			local var_123_5 = 0

			if var_123_5 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 and not isNil(var_123_4) and arg_120_1.var_.characterEffect2030_tpose == nil then
				arg_120_1.var_.characterEffect2030_tpose = var_123_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_6 = 0.1

			if var_123_5 <= arg_120_1.time_ and arg_120_1.time_ < var_123_5 + var_123_6 and not isNil(var_123_4) then
				local var_123_7 = (arg_120_1.time_ - var_123_5) / var_123_6

				if arg_120_1.var_.characterEffect2030_tpose and not isNil(var_123_4) then
					local var_123_8 = Mathf.Lerp(0, 0.5, var_123_7)

					arg_120_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_120_1.var_.characterEffect2030_tpose.fillRatio = var_123_8
				end
			end

			if arg_120_1.time_ >= var_123_5 + var_123_6 and arg_120_1.time_ < var_123_5 + var_123_6 + arg_123_0 and not isNil(var_123_4) and arg_120_1.var_.characterEffect2030_tpose then
				local var_123_9 = 0.5

				arg_120_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_120_1.var_.characterEffect2030_tpose.fillRatio = var_123_9
			end

			local var_123_10 = arg_120_1.actors_["2030_tpose"].transform
			local var_123_11 = 0

			if var_123_11 < arg_120_1.time_ and arg_120_1.time_ <= var_123_11 + arg_123_0 then
				arg_120_1.var_.moveOldPos2030_tpose = var_123_10.localPosition

				local var_123_12 = GameObjectTools.GetOrAddComponent(var_123_10.gameObject, typeof(DynamicBoneHelper))

				if var_123_12 then
					var_123_12:EnableDynamicBone(false)
				end
			end

			local var_123_13 = 0.001

			if var_123_11 <= arg_120_1.time_ and arg_120_1.time_ < var_123_11 + var_123_13 then
				local var_123_14 = (arg_120_1.time_ - var_123_11) / var_123_13
				local var_123_15 = Vector3.New(0, 100, 0)

				var_123_10.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos2030_tpose, var_123_15, var_123_14)

				local var_123_16 = manager.ui.mainCamera.transform.position - var_123_10.position

				var_123_10.forward = Vector3.New(var_123_16.x, var_123_16.y, var_123_16.z)

				local var_123_17 = var_123_10.localEulerAngles

				var_123_17.z = 0
				var_123_17.x = 0
				var_123_10.localEulerAngles = var_123_17
			end

			if arg_120_1.time_ >= var_123_11 + var_123_13 and arg_120_1.time_ < var_123_11 + var_123_13 + arg_123_0 then
				var_123_10.localPosition = Vector3.New(0, 100, 0)

				local var_123_18 = manager.ui.mainCamera.transform.position - var_123_10.position

				var_123_10.forward = Vector3.New(var_123_18.x, var_123_18.y, var_123_18.z)

				local var_123_19 = var_123_10.localEulerAngles

				var_123_19.z = 0
				var_123_19.x = 0
				var_123_10.localEulerAngles = var_123_19

				local var_123_20 = GameObjectTools.GetOrAddComponent(var_123_10.gameObject, typeof(DynamicBoneHelper))

				if var_123_20 then
					var_123_20:EnableDynamicBone(true)
				end
			end

			local var_123_21 = arg_120_1.actors_["2020_tpose"].transform
			local var_123_22 = 0

			if var_123_22 < arg_120_1.time_ and arg_120_1.time_ <= var_123_22 + arg_123_0 then
				arg_120_1.var_.moveOldPos2020_tpose = var_123_21.localPosition

				local var_123_23 = GameObjectTools.GetOrAddComponent(var_123_21.gameObject, typeof(DynamicBoneHelper))

				if var_123_23 then
					var_123_23:EnableDynamicBone(false)
				end
			end

			local var_123_24 = 0.001

			if var_123_22 <= arg_120_1.time_ and arg_120_1.time_ < var_123_22 + var_123_24 then
				local var_123_25 = (arg_120_1.time_ - var_123_22) / var_123_24
				local var_123_26 = Vector3.New(0, 100, 0)

				var_123_21.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos2020_tpose, var_123_26, var_123_25)

				local var_123_27 = manager.ui.mainCamera.transform.position - var_123_21.position

				var_123_21.forward = Vector3.New(var_123_27.x, var_123_27.y, var_123_27.z)

				local var_123_28 = var_123_21.localEulerAngles

				var_123_28.z = 0
				var_123_28.x = 0
				var_123_21.localEulerAngles = var_123_28
			end

			if arg_120_1.time_ >= var_123_22 + var_123_24 and arg_120_1.time_ < var_123_22 + var_123_24 + arg_123_0 then
				var_123_21.localPosition = Vector3.New(0, 100, 0)

				local var_123_29 = manager.ui.mainCamera.transform.position - var_123_21.position

				var_123_21.forward = Vector3.New(var_123_29.x, var_123_29.y, var_123_29.z)

				local var_123_30 = var_123_21.localEulerAngles

				var_123_30.z = 0
				var_123_30.x = 0
				var_123_21.localEulerAngles = var_123_30

				local var_123_31 = GameObjectTools.GetOrAddComponent(var_123_21.gameObject, typeof(DynamicBoneHelper))

				if var_123_31 then
					var_123_31:EnableDynamicBone(true)
				end
			end

			local var_123_32 = arg_120_1.actors_["4010ui_story"].transform
			local var_123_33 = 0

			if var_123_33 < arg_120_1.time_ and arg_120_1.time_ <= var_123_33 + arg_123_0 then
				arg_120_1.var_.moveOldPos4010ui_story = var_123_32.localPosition
			end

			local var_123_34 = 0.001

			if var_123_33 <= arg_120_1.time_ and arg_120_1.time_ < var_123_33 + var_123_34 then
				local var_123_35 = (arg_120_1.time_ - var_123_33) / var_123_34
				local var_123_36 = Vector3.New(0, -1.59, -5.2)

				var_123_32.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos4010ui_story, var_123_36, var_123_35)

				local var_123_37 = manager.ui.mainCamera.transform.position - var_123_32.position

				var_123_32.forward = Vector3.New(var_123_37.x, var_123_37.y, var_123_37.z)

				local var_123_38 = var_123_32.localEulerAngles

				var_123_38.z = 0
				var_123_38.x = 0
				var_123_32.localEulerAngles = var_123_38
			end

			if arg_120_1.time_ >= var_123_33 + var_123_34 and arg_120_1.time_ < var_123_33 + var_123_34 + arg_123_0 then
				var_123_32.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_123_39 = manager.ui.mainCamera.transform.position - var_123_32.position

				var_123_32.forward = Vector3.New(var_123_39.x, var_123_39.y, var_123_39.z)

				local var_123_40 = var_123_32.localEulerAngles

				var_123_40.z = 0
				var_123_40.x = 0
				var_123_32.localEulerAngles = var_123_40
			end

			local var_123_41 = 0

			if var_123_41 < arg_120_1.time_ and arg_120_1.time_ <= var_123_41 + arg_123_0 then
				arg_120_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			local var_123_42 = 0

			if var_123_42 < arg_120_1.time_ and arg_120_1.time_ <= var_123_42 + arg_123_0 then
				arg_120_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_123_43 = 0
			local var_123_44 = 0.575

			if var_123_43 < arg_120_1.time_ and arg_120_1.time_ <= var_123_43 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_45 = arg_120_1:FormatText(StoryNameCfg[42].name)

				arg_120_1.leftNameTxt_.text = var_123_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_46 = arg_120_1:GetWordFromCfg(103031030)
				local var_123_47 = arg_120_1:FormatText(var_123_46.content)

				arg_120_1.text_.text = var_123_47

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_48 = 23
				local var_123_49 = utf8.len(var_123_47)
				local var_123_50 = var_123_48 <= 0 and var_123_44 or var_123_44 * (var_123_49 / var_123_48)

				if var_123_50 > 0 and var_123_44 < var_123_50 then
					arg_120_1.talkMaxDuration = var_123_50

					if var_123_50 + var_123_43 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_50 + var_123_43
					end
				end

				arg_120_1.text_.text = var_123_47
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031030", "story_v_out_103031.awb") ~= 0 then
					local var_123_51 = manager.audio:GetVoiceLength("story_v_out_103031", "103031030", "story_v_out_103031.awb") / 1000

					if var_123_51 + var_123_43 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_51 + var_123_43
					end

					if var_123_46.prefab_name ~= "" and arg_120_1.actors_[var_123_46.prefab_name] ~= nil then
						local var_123_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_46.prefab_name].transform, "story_v_out_103031", "103031030", "story_v_out_103031.awb")

						arg_120_1:RecordAudio("103031030", var_123_52)
						arg_120_1:RecordAudio("103031030", var_123_52)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_103031", "103031030", "story_v_out_103031.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_103031", "103031030", "story_v_out_103031.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_53 = math.max(var_123_44, arg_120_1.talkMaxDuration)

			if var_123_43 <= arg_120_1.time_ and arg_120_1.time_ < var_123_43 + var_123_53 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_43) / var_123_53

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_43 + var_123_53 and arg_120_1.time_ < var_123_43 + var_123_53 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
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
				actorName = "4010ui_story",
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
	Play103031031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 103031031
		arg_124_1.duration_ = 6.73

		local var_124_0 = {
			ja = 6.733,
			ko = 5.066,
			zh = 6.066,
			en = 6.433
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
			arg_124_1.auto_ = false
		end

		function arg_124_1.playNext_(arg_126_0)
			arg_124_1.onStoryFinished_()
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1011ui_story"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1011ui_story == nil then
				arg_124_1.var_.characterEffect1011ui_story = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.1

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.characterEffect1011ui_story and not isNil(var_127_0) then
					arg_124_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1011ui_story then
				arg_124_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_127_4 = arg_124_1.actors_["4010ui_story"]
			local var_127_5 = 0

			if var_127_5 < arg_124_1.time_ and arg_124_1.time_ <= var_127_5 + arg_127_0 and not isNil(var_127_4) and arg_124_1.var_.characterEffect4010ui_story == nil then
				arg_124_1.var_.characterEffect4010ui_story = var_127_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_6 = 0.1

			if var_127_5 <= arg_124_1.time_ and arg_124_1.time_ < var_127_5 + var_127_6 and not isNil(var_127_4) then
				local var_127_7 = (arg_124_1.time_ - var_127_5) / var_127_6

				if arg_124_1.var_.characterEffect4010ui_story and not isNil(var_127_4) then
					local var_127_8 = Mathf.Lerp(0, 0.5, var_127_7)

					arg_124_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_124_1.var_.characterEffect4010ui_story.fillRatio = var_127_8
				end
			end

			if arg_124_1.time_ >= var_127_5 + var_127_6 and arg_124_1.time_ < var_127_5 + var_127_6 + arg_127_0 and not isNil(var_127_4) and arg_124_1.var_.characterEffect4010ui_story then
				local var_127_9 = 0.5

				arg_124_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_124_1.var_.characterEffect4010ui_story.fillRatio = var_127_9
			end

			local var_127_10 = arg_124_1.actors_["4010ui_story"].transform
			local var_127_11 = 0

			if var_127_11 < arg_124_1.time_ and arg_124_1.time_ <= var_127_11 + arg_127_0 then
				arg_124_1.var_.moveOldPos4010ui_story = var_127_10.localPosition
			end

			local var_127_12 = 0.001

			if var_127_11 <= arg_124_1.time_ and arg_124_1.time_ < var_127_11 + var_127_12 then
				local var_127_13 = (arg_124_1.time_ - var_127_11) / var_127_12
				local var_127_14 = Vector3.New(0, 100, 0)

				var_127_10.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos4010ui_story, var_127_14, var_127_13)

				local var_127_15 = manager.ui.mainCamera.transform.position - var_127_10.position

				var_127_10.forward = Vector3.New(var_127_15.x, var_127_15.y, var_127_15.z)

				local var_127_16 = var_127_10.localEulerAngles

				var_127_16.z = 0
				var_127_16.x = 0
				var_127_10.localEulerAngles = var_127_16
			end

			if arg_124_1.time_ >= var_127_11 + var_127_12 and arg_124_1.time_ < var_127_11 + var_127_12 + arg_127_0 then
				var_127_10.localPosition = Vector3.New(0, 100, 0)

				local var_127_17 = manager.ui.mainCamera.transform.position - var_127_10.position

				var_127_10.forward = Vector3.New(var_127_17.x, var_127_17.y, var_127_17.z)

				local var_127_18 = var_127_10.localEulerAngles

				var_127_18.z = 0
				var_127_18.x = 0
				var_127_10.localEulerAngles = var_127_18
			end

			local var_127_19 = arg_124_1.actors_["1011ui_story"].transform
			local var_127_20 = 0

			if var_127_20 < arg_124_1.time_ and arg_124_1.time_ <= var_127_20 + arg_127_0 then
				arg_124_1.var_.moveOldPos1011ui_story = var_127_19.localPosition
			end

			local var_127_21 = 0.001

			if var_127_20 <= arg_124_1.time_ and arg_124_1.time_ < var_127_20 + var_127_21 then
				local var_127_22 = (arg_124_1.time_ - var_127_20) / var_127_21
				local var_127_23 = Vector3.New(0, -0.71, -6)

				var_127_19.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1011ui_story, var_127_23, var_127_22)

				local var_127_24 = manager.ui.mainCamera.transform.position - var_127_19.position

				var_127_19.forward = Vector3.New(var_127_24.x, var_127_24.y, var_127_24.z)

				local var_127_25 = var_127_19.localEulerAngles

				var_127_25.z = 0
				var_127_25.x = 0
				var_127_19.localEulerAngles = var_127_25
			end

			if arg_124_1.time_ >= var_127_20 + var_127_21 and arg_124_1.time_ < var_127_20 + var_127_21 + arg_127_0 then
				var_127_19.localPosition = Vector3.New(0, -0.71, -6)

				local var_127_26 = manager.ui.mainCamera.transform.position - var_127_19.position

				var_127_19.forward = Vector3.New(var_127_26.x, var_127_26.y, var_127_26.z)

				local var_127_27 = var_127_19.localEulerAngles

				var_127_27.z = 0
				var_127_27.x = 0
				var_127_19.localEulerAngles = var_127_27
			end

			local var_127_28 = 0

			if var_127_28 < arg_124_1.time_ and arg_124_1.time_ <= var_127_28 + arg_127_0 then
				arg_124_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_127_29 = 0

			if var_127_29 < arg_124_1.time_ and arg_124_1.time_ <= var_127_29 + arg_127_0 then
				arg_124_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_127_30 = 0
			local var_127_31 = 0.55

			if var_127_30 < arg_124_1.time_ and arg_124_1.time_ <= var_127_30 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_32 = arg_124_1:FormatText(StoryNameCfg[37].name)

				arg_124_1.leftNameTxt_.text = var_127_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_33 = arg_124_1:GetWordFromCfg(103031031)
				local var_127_34 = arg_124_1:FormatText(var_127_33.content)

				arg_124_1.text_.text = var_127_34

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_35 = 22
				local var_127_36 = utf8.len(var_127_34)
				local var_127_37 = var_127_35 <= 0 and var_127_31 or var_127_31 * (var_127_36 / var_127_35)

				if var_127_37 > 0 and var_127_31 < var_127_37 then
					arg_124_1.talkMaxDuration = var_127_37

					if var_127_37 + var_127_30 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_37 + var_127_30
					end
				end

				arg_124_1.text_.text = var_127_34
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031031", "story_v_out_103031.awb") ~= 0 then
					local var_127_38 = manager.audio:GetVoiceLength("story_v_out_103031", "103031031", "story_v_out_103031.awb") / 1000

					if var_127_38 + var_127_30 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_38 + var_127_30
					end

					if var_127_33.prefab_name ~= "" and arg_124_1.actors_[var_127_33.prefab_name] ~= nil then
						local var_127_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_33.prefab_name].transform, "story_v_out_103031", "103031031", "story_v_out_103031.awb")

						arg_124_1:RecordAudio("103031031", var_127_39)
						arg_124_1:RecordAudio("103031031", var_127_39)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_103031", "103031031", "story_v_out_103031.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_103031", "103031031", "story_v_out_103031.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_40 = math.max(var_127_31, arg_124_1.talkMaxDuration)

			if var_127_30 <= arg_124_1.time_ and arg_124_1.time_ < var_127_30 + var_127_40 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_30) / var_127_40

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_30 + var_127_40 and arg_124_1.time_ < var_127_30 + var_127_40 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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

		arg_124_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B08b"
	},
	voices = {
		"story_v_out_103031.awb"
	}
}
