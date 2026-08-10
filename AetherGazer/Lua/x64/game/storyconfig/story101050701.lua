return {
	Play105071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 105071001
		arg_1_1.duration_ = 5.4

		local var_1_0 = {
			ja = 5.166,
			ko = 3.799999952315,
			zh = 5.4,
			en = 4.2
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
				arg_1_0:Play105071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "effect"

				arg_1_1:AudioAction(var_4_2, var_4_3, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_4 = "1013ui_story"

			if arg_1_1.actors_[var_4_4] == nil then
				local var_4_5 = Asset.Load("Char/" .. "1013ui_story")

				if not isNil(var_4_5) then
					local var_4_6 = Object.Instantiate(Asset.Load("Char/" .. "1013ui_story"), arg_1_1.stage_.transform)

					var_4_6.name = var_4_4
					var_4_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_4] = var_4_6

					local var_4_7 = var_4_6:GetComponentInChildren(typeof(CharacterEffect))

					var_4_7.enabled = true

					local var_4_8 = GameObjectTools.GetOrAddComponent(var_4_6, typeof(DynamicBoneHelper))

					if var_4_8 then
						var_4_8:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_7.transform, false)

					arg_1_1.var_[var_4_4 .. "Animator"] = var_4_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_4 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_4 .. "LipSync"] = var_4_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_9 = arg_1_1.actors_["1013ui_story"]
			local var_4_10 = 2

			if var_4_10 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 and not isNil(var_4_9) and arg_1_1.var_.characterEffect1013ui_story == nil then
				arg_1_1.var_.characterEffect1013ui_story = var_4_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_11 = 0.1

			if var_4_10 <= arg_1_1.time_ and arg_1_1.time_ < var_4_10 + var_4_11 and not isNil(var_4_9) then
				local var_4_12 = (arg_1_1.time_ - var_4_10) / var_4_11

				if arg_1_1.var_.characterEffect1013ui_story and not isNil(var_4_9) then
					arg_1_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_10 + var_4_11 and arg_1_1.time_ < var_4_10 + var_4_11 + arg_4_0 and not isNil(var_4_9) and arg_1_1.var_.characterEffect1013ui_story then
				arg_1_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_4_13 = "B01c"

			if arg_1_1.bgs_[var_4_13] == nil then
				local var_4_14 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_14:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_13)
				var_4_14.name = var_4_13
				var_4_14.transform.parent = arg_1_1.stage_.transform
				var_4_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_13] = var_4_14
			end

			local var_4_15 = arg_1_1.bgs_.B01c
			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				local var_4_17 = var_4_15:GetComponent("SpriteRenderer")

				if var_4_17 then
					arg_1_1.var_.alphaOldValueB01c = var_4_17.color.a
					arg_1_1.var_.alphaMatValueB01c = var_4_17
				end

				arg_1_1.var_.alphaOldValueB01c = 0
			end

			local var_4_18 = 1.5

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_18 then
				local var_4_19 = (arg_1_1.time_ - var_4_16) / var_4_18
				local var_4_20 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB01c, 1, var_4_19)

				if arg_1_1.var_.alphaMatValueB01c then
					local var_4_21 = arg_1_1.var_.alphaMatValueB01c.color

					var_4_21.a = var_4_20
					arg_1_1.var_.alphaMatValueB01c.color = var_4_21
				end
			end

			if arg_1_1.time_ >= var_4_16 + var_4_18 and arg_1_1.time_ < var_4_16 + var_4_18 + arg_4_0 and arg_1_1.var_.alphaMatValueB01c then
				local var_4_22 = arg_1_1.var_.alphaMatValueB01c
				local var_4_23 = var_4_22.color

				var_4_23.a = 1
				var_4_22.color = var_4_23
			end

			local var_4_24 = 0

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_25 = manager.ui.mainCamera.transform.localPosition
				local var_4_26 = Vector3.New(0, 0, 10) + Vector3.New(var_4_25.x, var_4_25.y, 0)
				local var_4_27 = arg_1_1.bgs_.B01c

				var_4_27.transform.localPosition = var_4_26
				var_4_27.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_28 = var_4_27:GetComponent("SpriteRenderer")

				if var_4_28 and var_4_28.sprite then
					local var_4_29 = (var_4_27.transform.localPosition - var_4_25).z
					local var_4_30 = manager.ui.mainCameraCom_
					local var_4_31 = 2 * var_4_29 * Mathf.Tan(var_4_30.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_32 = var_4_31 * var_4_30.aspect
					local var_4_33 = var_4_28.sprite.bounds.size.x
					local var_4_34 = var_4_28.sprite.bounds.size.y
					local var_4_35 = var_4_32 / var_4_33
					local var_4_36 = var_4_31 / var_4_34
					local var_4_37 = var_4_36 < var_4_35 and var_4_35 or var_4_36

					var_4_27.transform.localScale = Vector3.New(var_4_37, var_4_37, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B01c" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_38 = arg_1_1.actors_["1013ui_story"].transform
			local var_4_39 = 1.79999995231628

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				arg_1_1.var_.moveOldPos1013ui_story = var_4_38.localPosition
			end

			local var_4_40 = 0.001

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40
				local var_4_42 = Vector3.New(-0.7, -0.66, -6.15)

				var_4_38.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1013ui_story, var_4_42, var_4_41)

				local var_4_43 = manager.ui.mainCamera.transform.position - var_4_38.position

				var_4_38.forward = Vector3.New(var_4_43.x, var_4_43.y, var_4_43.z)

				local var_4_44 = var_4_38.localEulerAngles

				var_4_44.z = 0
				var_4_44.x = 0
				var_4_38.localEulerAngles = var_4_44
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 then
				var_4_38.localPosition = Vector3.New(-0.7, -0.66, -6.15)

				local var_4_45 = manager.ui.mainCamera.transform.position - var_4_38.position

				var_4_38.forward = Vector3.New(var_4_45.x, var_4_45.y, var_4_45.z)

				local var_4_46 = var_4_38.localEulerAngles

				var_4_46.z = 0
				var_4_46.x = 0
				var_4_38.localEulerAngles = var_4_46
			end

			local var_4_47 = 1.79999995231628

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				arg_1_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action10_1")
			end

			local var_4_48 = 0

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_49 = 2

			if arg_1_1.time_ >= var_4_48 + var_4_49 and arg_1_1.time_ < var_4_48 + var_4_49 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_50 = 0

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				arg_1_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_51 = 2
			local var_4_52 = 0.1

			if var_4_51 < arg_1_1.time_ and arg_1_1.time_ <= var_4_51 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_53 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_53:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_54 = arg_1_1:FormatText(StoryNameCfg[35].name)

				arg_1_1.leftNameTxt_.text = var_4_54

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_55 = arg_1_1:GetWordFromCfg(105071001)
				local var_4_56 = arg_1_1:FormatText(var_4_55.content)

				arg_1_1.text_.text = var_4_56

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_57 = 4
				local var_4_58 = utf8.len(var_4_56)
				local var_4_59 = var_4_57 <= 0 and var_4_52 or var_4_52 * (var_4_58 / var_4_57)

				if var_4_59 > 0 and var_4_52 < var_4_59 then
					arg_1_1.talkMaxDuration = var_4_59
					var_4_51 = var_4_51 + 0.3

					if var_4_59 + var_4_51 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_59 + var_4_51
					end
				end

				arg_1_1.text_.text = var_4_56
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071001", "story_v_out_105071.awb") ~= 0 then
					local var_4_60 = manager.audio:GetVoiceLength("story_v_out_105071", "105071001", "story_v_out_105071.awb") / 1000

					if var_4_60 + var_4_51 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_60 + var_4_51
					end

					if var_4_55.prefab_name ~= "" and arg_1_1.actors_[var_4_55.prefab_name] ~= nil then
						local var_4_61 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_55.prefab_name].transform, "story_v_out_105071", "105071001", "story_v_out_105071.awb")

						arg_1_1:RecordAudio("105071001", var_4_61)
						arg_1_1:RecordAudio("105071001", var_4_61)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_105071", "105071001", "story_v_out_105071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_105071", "105071001", "story_v_out_105071.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_62 = var_4_51 + 0.3
			local var_4_63 = math.max(var_4_52, arg_1_1.talkMaxDuration)

			if var_4_62 <= arg_1_1.time_ and arg_1_1.time_ < var_4_62 + var_4_63 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_62) / var_4_63

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_62 + var_4_63 and arg_1_1.time_ < var_4_62 + var_4_63 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
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
	Play105071002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 105071002
		arg_7_1.duration_ = 4.53

		local var_7_0 = {
			ja = 4.533,
			ko = 2.633,
			zh = 2.6,
			en = 1.999999999999
		}
		local var_7_1 = manager.audio:GetLocalizationFlag()

		if var_7_0[var_7_1] ~= nil then
			arg_7_1.duration_ = var_7_0[var_7_1]
		end

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play105071003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0
			local var_10_1 = 1

			if var_10_0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				local var_10_2 = "play"
				local var_10_3 = "music"

				arg_7_1:AudioAction(var_10_2, var_10_3, "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")

				local var_10_4 = ""
				local var_10_5 = manager.audio:GetAudioName("bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")

				if var_10_5 ~= "" then
					if arg_7_1.bgmTxt_.text ~= var_10_5 and arg_7_1.bgmTxt_.text ~= "" then
						if arg_7_1.bgmTxt2_.text ~= "" then
							arg_7_1.bgmTxt_.text = arg_7_1.bgmTxt2_.text
						end

						arg_7_1.bgmTxt2_.text = var_10_5

						arg_7_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_7_1.bgmTxt_.text = var_10_5
						arg_7_1.bgmTxt2_.text = var_10_5
					end

					if arg_7_1.bgmTimer then
						arg_7_1.bgmTimer:Stop()

						arg_7_1.bgmTimer = nil
					end

					if arg_7_1.settingData.show_music_name == 1 then
						arg_7_1.musicController:SetSelectedState("show")
						arg_7_1.musicAnimator_:Play("open", 0, 0)

						if arg_7_1.settingData.music_time ~= 0 then
							arg_7_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_7_1.settingData.music_time), function()
								if arg_7_1 == nil or isNil(arg_7_1.bgmTxt_) then
									return
								end

								arg_7_1.musicController:SetSelectedState("hide")
								arg_7_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_10_6 = "10002ui_story"

			if arg_7_1.actors_[var_10_6] == nil then
				local var_10_7 = Asset.Load("Char/" .. "10002ui_story")

				if not isNil(var_10_7) then
					local var_10_8 = Object.Instantiate(Asset.Load("Char/" .. "10002ui_story"), arg_7_1.stage_.transform)

					var_10_8.name = var_10_6
					var_10_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_7_1.actors_[var_10_6] = var_10_8

					local var_10_9 = var_10_8:GetComponentInChildren(typeof(CharacterEffect))

					var_10_9.enabled = true

					local var_10_10 = GameObjectTools.GetOrAddComponent(var_10_8, typeof(DynamicBoneHelper))

					if var_10_10 then
						var_10_10:EnableDynamicBone(false)
					end

					arg_7_1:ShowWeapon(var_10_9.transform, false)

					arg_7_1.var_[var_10_6 .. "Animator"] = var_10_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_7_1.var_[var_10_6 .. "Animator"].applyRootMotion = true
					arg_7_1.var_[var_10_6 .. "LipSync"] = var_10_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_10_11 = arg_7_1.actors_["10002ui_story"]
			local var_10_12 = 0

			if var_10_12 < arg_7_1.time_ and arg_7_1.time_ <= var_10_12 + arg_10_0 and not isNil(var_10_11) and arg_7_1.var_.characterEffect10002ui_story == nil then
				arg_7_1.var_.characterEffect10002ui_story = var_10_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_13 = 0.1

			if var_10_12 <= arg_7_1.time_ and arg_7_1.time_ < var_10_12 + var_10_13 and not isNil(var_10_11) then
				local var_10_14 = (arg_7_1.time_ - var_10_12) / var_10_13

				if arg_7_1.var_.characterEffect10002ui_story and not isNil(var_10_11) then
					arg_7_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= var_10_12 + var_10_13 and arg_7_1.time_ < var_10_12 + var_10_13 + arg_10_0 and not isNil(var_10_11) and arg_7_1.var_.characterEffect10002ui_story then
				arg_7_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_10_15 = arg_7_1.actors_["1013ui_story"]
			local var_10_16 = 0

			if var_10_16 < arg_7_1.time_ and arg_7_1.time_ <= var_10_16 + arg_10_0 and not isNil(var_10_15) and arg_7_1.var_.characterEffect1013ui_story == nil then
				arg_7_1.var_.characterEffect1013ui_story = var_10_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_17 = 0.1

			if var_10_16 <= arg_7_1.time_ and arg_7_1.time_ < var_10_16 + var_10_17 and not isNil(var_10_15) then
				local var_10_18 = (arg_7_1.time_ - var_10_16) / var_10_17

				if arg_7_1.var_.characterEffect1013ui_story and not isNil(var_10_15) then
					local var_10_19 = Mathf.Lerp(0, 0.5, var_10_18)

					arg_7_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1013ui_story.fillRatio = var_10_19
				end
			end

			if arg_7_1.time_ >= var_10_16 + var_10_17 and arg_7_1.time_ < var_10_16 + var_10_17 + arg_10_0 and not isNil(var_10_15) and arg_7_1.var_.characterEffect1013ui_story then
				local var_10_20 = 0.5

				arg_7_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1013ui_story.fillRatio = var_10_20
			end

			local var_10_21 = arg_7_1.actors_["10002ui_story"].transform
			local var_10_22 = 0

			if var_10_22 < arg_7_1.time_ and arg_7_1.time_ <= var_10_22 + arg_10_0 then
				arg_7_1.var_.moveOldPos10002ui_story = var_10_21.localPosition
			end

			local var_10_23 = 0.001

			if var_10_22 <= arg_7_1.time_ and arg_7_1.time_ < var_10_22 + var_10_23 then
				local var_10_24 = (arg_7_1.time_ - var_10_22) / var_10_23
				local var_10_25 = Vector3.New(0.7, -1.2, -5.8)

				var_10_21.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos10002ui_story, var_10_25, var_10_24)

				local var_10_26 = manager.ui.mainCamera.transform.position - var_10_21.position

				var_10_21.forward = Vector3.New(var_10_26.x, var_10_26.y, var_10_26.z)

				local var_10_27 = var_10_21.localEulerAngles

				var_10_27.z = 0
				var_10_27.x = 0
				var_10_21.localEulerAngles = var_10_27
			end

			if arg_7_1.time_ >= var_10_22 + var_10_23 and arg_7_1.time_ < var_10_22 + var_10_23 + arg_10_0 then
				var_10_21.localPosition = Vector3.New(0.7, -1.2, -5.8)

				local var_10_28 = manager.ui.mainCamera.transform.position - var_10_21.position

				var_10_21.forward = Vector3.New(var_10_28.x, var_10_28.y, var_10_28.z)

				local var_10_29 = var_10_21.localEulerAngles

				var_10_29.z = 0
				var_10_29.x = 0
				var_10_21.localEulerAngles = var_10_29
			end

			local var_10_30 = 0

			if var_10_30 < arg_7_1.time_ and arg_7_1.time_ <= var_10_30 + arg_10_0 then
				arg_7_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action1_1")
			end

			local var_10_31 = 0

			if var_10_31 < arg_7_1.time_ and arg_7_1.time_ <= var_10_31 + arg_10_0 then
				arg_7_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_10_32 = 0
			local var_10_33 = 0.25

			if var_10_32 < arg_7_1.time_ and arg_7_1.time_ <= var_10_32 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_34 = arg_7_1:FormatText(StoryNameCfg[39].name)

				arg_7_1.leftNameTxt_.text = var_10_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_35 = arg_7_1:GetWordFromCfg(105071002)
				local var_10_36 = arg_7_1:FormatText(var_10_35.content)

				arg_7_1.text_.text = var_10_36

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_37 = 8
				local var_10_38 = utf8.len(var_10_36)
				local var_10_39 = var_10_37 <= 0 and var_10_33 or var_10_33 * (var_10_38 / var_10_37)

				if var_10_39 > 0 and var_10_33 < var_10_39 then
					arg_7_1.talkMaxDuration = var_10_39

					if var_10_39 + var_10_32 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_39 + var_10_32
					end
				end

				arg_7_1.text_.text = var_10_36
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071002", "story_v_out_105071.awb") ~= 0 then
					local var_10_40 = manager.audio:GetVoiceLength("story_v_out_105071", "105071002", "story_v_out_105071.awb") / 1000

					if var_10_40 + var_10_32 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_40 + var_10_32
					end

					if var_10_35.prefab_name ~= "" and arg_7_1.actors_[var_10_35.prefab_name] ~= nil then
						local var_10_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_35.prefab_name].transform, "story_v_out_105071", "105071002", "story_v_out_105071.awb")

						arg_7_1:RecordAudio("105071002", var_10_41)
						arg_7_1:RecordAudio("105071002", var_10_41)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_105071", "105071002", "story_v_out_105071.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_105071", "105071002", "story_v_out_105071.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_42 = math.max(var_10_33, arg_7_1.talkMaxDuration)

			if var_10_32 <= arg_7_1.time_ and arg_7_1.time_ < var_10_32 + var_10_42 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_32) / var_10_42

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_32 + var_10_42 and arg_7_1.time_ < var_10_32 + var_10_42 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_7_1:InitPlayNodeList()
	end,
	Play105071003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 105071003
		arg_12_1.duration_ = 5.03

		local var_12_0 = {
			ja = 5.033,
			ko = 2.3,
			zh = 4.166,
			en = 4.233
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
				arg_12_0:Play105071004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1013ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1013ui_story == nil then
				arg_12_1.var_.characterEffect1013ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.1

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1013ui_story and not isNil(var_15_0) then
					arg_12_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1013ui_story then
				arg_12_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_15_4 = arg_12_1.actors_["10002ui_story"]
			local var_15_5 = 0

			if var_15_5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 and not isNil(var_15_4) and arg_12_1.var_.characterEffect10002ui_story == nil then
				arg_12_1.var_.characterEffect10002ui_story = var_15_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_6 = 0.1

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_6 and not isNil(var_15_4) then
				local var_15_7 = (arg_12_1.time_ - var_15_5) / var_15_6

				if arg_12_1.var_.characterEffect10002ui_story and not isNil(var_15_4) then
					local var_15_8 = Mathf.Lerp(0, 0.5, var_15_7)

					arg_12_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_12_1.var_.characterEffect10002ui_story.fillRatio = var_15_8
				end
			end

			if arg_12_1.time_ >= var_15_5 + var_15_6 and arg_12_1.time_ < var_15_5 + var_15_6 + arg_15_0 and not isNil(var_15_4) and arg_12_1.var_.characterEffect10002ui_story then
				local var_15_9 = 0.5

				arg_12_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_12_1.var_.characterEffect10002ui_story.fillRatio = var_15_9
			end

			local var_15_10 = 0

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action4104")
			end

			local var_15_11 = 0

			if var_15_11 < arg_12_1.time_ and arg_12_1.time_ <= var_15_11 + arg_15_0 then
				arg_12_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_15_12 = 0
			local var_15_13 = 0.25

			if var_15_12 < arg_12_1.time_ and arg_12_1.time_ <= var_15_12 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_14 = arg_12_1:FormatText(StoryNameCfg[35].name)

				arg_12_1.leftNameTxt_.text = var_15_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_15 = arg_12_1:GetWordFromCfg(105071003)
				local var_15_16 = arg_12_1:FormatText(var_15_15.content)

				arg_12_1.text_.text = var_15_16

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_17 = 10
				local var_15_18 = utf8.len(var_15_16)
				local var_15_19 = var_15_17 <= 0 and var_15_13 or var_15_13 * (var_15_18 / var_15_17)

				if var_15_19 > 0 and var_15_13 < var_15_19 then
					arg_12_1.talkMaxDuration = var_15_19

					if var_15_19 + var_15_12 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_19 + var_15_12
					end
				end

				arg_12_1.text_.text = var_15_16
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071003", "story_v_out_105071.awb") ~= 0 then
					local var_15_20 = manager.audio:GetVoiceLength("story_v_out_105071", "105071003", "story_v_out_105071.awb") / 1000

					if var_15_20 + var_15_12 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_20 + var_15_12
					end

					if var_15_15.prefab_name ~= "" and arg_12_1.actors_[var_15_15.prefab_name] ~= nil then
						local var_15_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_15.prefab_name].transform, "story_v_out_105071", "105071003", "story_v_out_105071.awb")

						arg_12_1:RecordAudio("105071003", var_15_21)
						arg_12_1:RecordAudio("105071003", var_15_21)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_105071", "105071003", "story_v_out_105071.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_105071", "105071003", "story_v_out_105071.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_22 = math.max(var_15_13, arg_12_1.talkMaxDuration)

			if var_15_12 <= arg_12_1.time_ and arg_12_1.time_ < var_15_12 + var_15_22 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_12) / var_15_22

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_12 + var_15_22 and arg_12_1.time_ < var_15_12 + var_15_22 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play105071004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 105071004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play105071005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["10002ui_story"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos10002ui_story = var_19_0.localPosition
			end

			local var_19_2 = 0.001

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2
				local var_19_4 = Vector3.New(0, 100, 0)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10002ui_story, var_19_4, var_19_3)

				local var_19_5 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_5.x, var_19_5.y, var_19_5.z)

				local var_19_6 = var_19_0.localEulerAngles

				var_19_6.z = 0
				var_19_6.x = 0
				var_19_0.localEulerAngles = var_19_6
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 then
				var_19_0.localPosition = Vector3.New(0, 100, 0)

				local var_19_7 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_7.x, var_19_7.y, var_19_7.z)

				local var_19_8 = var_19_0.localEulerAngles

				var_19_8.z = 0
				var_19_8.x = 0
				var_19_0.localEulerAngles = var_19_8
			end

			local var_19_9 = arg_16_1.actors_["1013ui_story"].transform
			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1.var_.moveOldPos1013ui_story = var_19_9.localPosition
			end

			local var_19_11 = 0.001

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_11 then
				local var_19_12 = (arg_16_1.time_ - var_19_10) / var_19_11
				local var_19_13 = Vector3.New(0, 100, 0)

				var_19_9.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1013ui_story, var_19_13, var_19_12)

				local var_19_14 = manager.ui.mainCamera.transform.position - var_19_9.position

				var_19_9.forward = Vector3.New(var_19_14.x, var_19_14.y, var_19_14.z)

				local var_19_15 = var_19_9.localEulerAngles

				var_19_15.z = 0
				var_19_15.x = 0
				var_19_9.localEulerAngles = var_19_15
			end

			if arg_16_1.time_ >= var_19_10 + var_19_11 and arg_16_1.time_ < var_19_10 + var_19_11 + arg_19_0 then
				var_19_9.localPosition = Vector3.New(0, 100, 0)

				local var_19_16 = manager.ui.mainCamera.transform.position - var_19_9.position

				var_19_9.forward = Vector3.New(var_19_16.x, var_19_16.y, var_19_16.z)

				local var_19_17 = var_19_9.localEulerAngles

				var_19_17.z = 0
				var_19_17.x = 0
				var_19_9.localEulerAngles = var_19_17
			end

			local var_19_18 = 0
			local var_19_19 = 0.825

			if var_19_18 < arg_16_1.time_ and arg_16_1.time_ <= var_19_18 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_20 = arg_16_1:GetWordFromCfg(105071004)
				local var_19_21 = arg_16_1:FormatText(var_19_20.content)

				arg_16_1.text_.text = var_19_21

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_22 = 33
				local var_19_23 = utf8.len(var_19_21)
				local var_19_24 = var_19_22 <= 0 and var_19_19 or var_19_19 * (var_19_23 / var_19_22)

				if var_19_24 > 0 and var_19_19 < var_19_24 then
					arg_16_1.talkMaxDuration = var_19_24

					if var_19_24 + var_19_18 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_24 + var_19_18
					end
				end

				arg_16_1.text_.text = var_19_21
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_25 = math.max(var_19_19, arg_16_1.talkMaxDuration)

			if var_19_18 <= arg_16_1.time_ and arg_16_1.time_ < var_19_18 + var_19_25 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_18) / var_19_25

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_18 + var_19_25 and arg_16_1.time_ < var_19_18 + var_19_25 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1013ui_story",
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
	Play105071005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 105071005
		arg_20_1.duration_ = 2

		local var_20_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2
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
				arg_20_0:Play105071006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1013ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1013ui_story == nil then
				arg_20_1.var_.characterEffect1013ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.1

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1013ui_story and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1013ui_story then
				arg_20_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_23_4 = arg_20_1.actors_["1013ui_story"].transform
			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 then
				arg_20_1.var_.moveOldPos1013ui_story = var_23_4.localPosition
			end

			local var_23_6 = 0.001

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_6 then
				local var_23_7 = (arg_20_1.time_ - var_23_5) / var_23_6
				local var_23_8 = Vector3.New(0, -0.66, -6.15)

				var_23_4.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1013ui_story, var_23_8, var_23_7)

				local var_23_9 = manager.ui.mainCamera.transform.position - var_23_4.position

				var_23_4.forward = Vector3.New(var_23_9.x, var_23_9.y, var_23_9.z)

				local var_23_10 = var_23_4.localEulerAngles

				var_23_10.z = 0
				var_23_10.x = 0
				var_23_4.localEulerAngles = var_23_10
			end

			if arg_20_1.time_ >= var_23_5 + var_23_6 and arg_20_1.time_ < var_23_5 + var_23_6 + arg_23_0 then
				var_23_4.localPosition = Vector3.New(0, -0.66, -6.15)

				local var_23_11 = manager.ui.mainCamera.transform.position - var_23_4.position

				var_23_4.forward = Vector3.New(var_23_11.x, var_23_11.y, var_23_11.z)

				local var_23_12 = var_23_4.localEulerAngles

				var_23_12.z = 0
				var_23_12.x = 0
				var_23_4.localEulerAngles = var_23_12
			end

			local var_23_13 = 0

			if var_23_13 < arg_20_1.time_ and arg_20_1.time_ <= var_23_13 + arg_23_0 then
				arg_20_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action5_1")
			end

			local var_23_14 = 0

			if var_23_14 < arg_20_1.time_ and arg_20_1.time_ <= var_23_14 + arg_23_0 then
				arg_20_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_23_15 = 0
			local var_23_16 = 0.1

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_17 = arg_20_1:FormatText(StoryNameCfg[35].name)

				arg_20_1.leftNameTxt_.text = var_23_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_18 = arg_20_1:GetWordFromCfg(105071005)
				local var_23_19 = arg_20_1:FormatText(var_23_18.content)

				arg_20_1.text_.text = var_23_19

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_20 = 4
				local var_23_21 = utf8.len(var_23_19)
				local var_23_22 = var_23_20 <= 0 and var_23_16 or var_23_16 * (var_23_21 / var_23_20)

				if var_23_22 > 0 and var_23_16 < var_23_22 then
					arg_20_1.talkMaxDuration = var_23_22

					if var_23_22 + var_23_15 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_22 + var_23_15
					end
				end

				arg_20_1.text_.text = var_23_19
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071005", "story_v_out_105071.awb") ~= 0 then
					local var_23_23 = manager.audio:GetVoiceLength("story_v_out_105071", "105071005", "story_v_out_105071.awb") / 1000

					if var_23_23 + var_23_15 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_23 + var_23_15
					end

					if var_23_18.prefab_name ~= "" and arg_20_1.actors_[var_23_18.prefab_name] ~= nil then
						local var_23_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_18.prefab_name].transform, "story_v_out_105071", "105071005", "story_v_out_105071.awb")

						arg_20_1:RecordAudio("105071005", var_23_24)
						arg_20_1:RecordAudio("105071005", var_23_24)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_105071", "105071005", "story_v_out_105071.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_105071", "105071005", "story_v_out_105071.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_25 = math.max(var_23_16, arg_20_1.talkMaxDuration)

			if var_23_15 <= arg_20_1.time_ and arg_20_1.time_ < var_23_15 + var_23_25 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_15) / var_23_25

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_15 + var_23_25 and arg_20_1.time_ < var_23_15 + var_23_25 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
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
	Play105071006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 105071006
		arg_24_1.duration_ = 2

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play105071007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = manager.ui.mainCamera.transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.shakeOldPosMainCamera = var_27_0.localPosition
			end

			local var_27_2 = 0.600000023841858

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / 0.066
				local var_27_4, var_27_5 = math.modf(var_27_3)

				var_27_0.localPosition = Vector3.New(var_27_5 * 0.13, var_27_5 * 0.13, var_27_5 * 0.13) + arg_24_1.var_.shakeOldPosMainCamera
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 then
				var_27_0.localPosition = arg_24_1.var_.shakeOldPosMainCamera
			end

			local var_27_6 = 0

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action459")
			end

			local var_27_7 = 0

			if var_27_7 < arg_24_1.time_ and arg_24_1.time_ <= var_27_7 + arg_27_0 then
				arg_24_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_27_8 = 0
			local var_27_9 = 0.1

			if var_27_8 < arg_24_1.time_ and arg_24_1.time_ <= var_27_8 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_10 = arg_24_1:FormatText(StoryNameCfg[35].name)

				arg_24_1.leftNameTxt_.text = var_27_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_11 = arg_24_1:GetWordFromCfg(105071006)
				local var_27_12 = arg_24_1:FormatText(var_27_11.content)

				arg_24_1.text_.text = var_27_12

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_13 = 4
				local var_27_14 = utf8.len(var_27_12)
				local var_27_15 = var_27_13 <= 0 and var_27_9 or var_27_9 * (var_27_14 / var_27_13)

				if var_27_15 > 0 and var_27_9 < var_27_15 then
					arg_24_1.talkMaxDuration = var_27_15

					if var_27_15 + var_27_8 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_15 + var_27_8
					end
				end

				arg_24_1.text_.text = var_27_12
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071006", "story_v_out_105071.awb") ~= 0 then
					local var_27_16 = manager.audio:GetVoiceLength("story_v_out_105071", "105071006", "story_v_out_105071.awb") / 1000

					if var_27_16 + var_27_8 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_16 + var_27_8
					end

					if var_27_11.prefab_name ~= "" and arg_24_1.actors_[var_27_11.prefab_name] ~= nil then
						local var_27_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_11.prefab_name].transform, "story_v_out_105071", "105071006", "story_v_out_105071.awb")

						arg_24_1:RecordAudio("105071006", var_27_17)
						arg_24_1:RecordAudio("105071006", var_27_17)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_105071", "105071006", "story_v_out_105071.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_105071", "105071006", "story_v_out_105071.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_18 = math.max(var_27_9, arg_24_1.talkMaxDuration)

			if var_27_8 <= arg_24_1.time_ and arg_24_1.time_ < var_27_8 + var_27_18 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_8) / var_27_18

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_8 + var_27_18 and arg_24_1.time_ < var_27_8 + var_27_18 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play105071007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 105071007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play105071008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 1

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				local var_31_2 = "play"
				local var_31_3 = "effect"

				arg_28_1:AudioAction(var_31_2, var_31_3, "se_story_5", "se_story_5_fist", "")
			end

			local var_31_4 = arg_28_1.actors_["1013ui_story"]
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect1013ui_story == nil then
				arg_28_1.var_.characterEffect1013ui_story = var_31_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.1

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 and not isNil(var_31_4) then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6

				if arg_28_1.var_.characterEffect1013ui_story and not isNil(var_31_4) then
					local var_31_8 = Mathf.Lerp(0, 0.5, var_31_7)

					arg_28_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1013ui_story.fillRatio = var_31_8
				end
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect1013ui_story then
				local var_31_9 = 0.5

				arg_28_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1013ui_story.fillRatio = var_31_9
			end

			local var_31_10 = manager.ui.mainCamera.transform
			local var_31_11 = 0

			if var_31_11 < arg_28_1.time_ and arg_28_1.time_ <= var_31_11 + arg_31_0 then
				arg_28_1.var_.shakeOldPosMainCamera = var_31_10.localPosition
			end

			local var_31_12 = 0.600000023841858

			if var_31_11 <= arg_28_1.time_ and arg_28_1.time_ < var_31_11 + var_31_12 then
				local var_31_13 = (arg_28_1.time_ - var_31_11) / 0.066
				local var_31_14, var_31_15 = math.modf(var_31_13)

				var_31_10.localPosition = Vector3.New(var_31_15 * 0.13, var_31_15 * 0.13, var_31_15 * 0.13) + arg_28_1.var_.shakeOldPosMainCamera
			end

			if arg_28_1.time_ >= var_31_11 + var_31_12 and arg_28_1.time_ < var_31_11 + var_31_12 + arg_31_0 then
				var_31_10.localPosition = arg_28_1.var_.shakeOldPosMainCamera
			end

			local var_31_16 = arg_28_1.actors_["1013ui_story"].transform
			local var_31_17 = 0

			if var_31_17 < arg_28_1.time_ and arg_28_1.time_ <= var_31_17 + arg_31_0 then
				arg_28_1.var_.moveOldPos1013ui_story = var_31_16.localPosition
			end

			local var_31_18 = 0.001

			if var_31_17 <= arg_28_1.time_ and arg_28_1.time_ < var_31_17 + var_31_18 then
				local var_31_19 = (arg_28_1.time_ - var_31_17) / var_31_18
				local var_31_20 = Vector3.New(0, 100, 0)

				var_31_16.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1013ui_story, var_31_20, var_31_19)

				local var_31_21 = manager.ui.mainCamera.transform.position - var_31_16.position

				var_31_16.forward = Vector3.New(var_31_21.x, var_31_21.y, var_31_21.z)

				local var_31_22 = var_31_16.localEulerAngles

				var_31_22.z = 0
				var_31_22.x = 0
				var_31_16.localEulerAngles = var_31_22
			end

			if arg_28_1.time_ >= var_31_17 + var_31_18 and arg_28_1.time_ < var_31_17 + var_31_18 + arg_31_0 then
				var_31_16.localPosition = Vector3.New(0, 100, 0)

				local var_31_23 = manager.ui.mainCamera.transform.position - var_31_16.position

				var_31_16.forward = Vector3.New(var_31_23.x, var_31_23.y, var_31_23.z)

				local var_31_24 = var_31_16.localEulerAngles

				var_31_24.z = 0
				var_31_24.x = 0
				var_31_16.localEulerAngles = var_31_24
			end

			local var_31_25 = 0
			local var_31_26 = 1.55

			if var_31_25 < arg_28_1.time_ and arg_28_1.time_ <= var_31_25 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_27 = arg_28_1:GetWordFromCfg(105071007)
				local var_31_28 = arg_28_1:FormatText(var_31_27.content)

				arg_28_1.text_.text = var_31_28

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_29 = 62
				local var_31_30 = utf8.len(var_31_28)
				local var_31_31 = var_31_29 <= 0 and var_31_26 or var_31_26 * (var_31_30 / var_31_29)

				if var_31_31 > 0 and var_31_26 < var_31_31 then
					arg_28_1.talkMaxDuration = var_31_31

					if var_31_31 + var_31_25 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_31 + var_31_25
					end
				end

				arg_28_1.text_.text = var_31_28
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_32 = math.max(var_31_26, arg_28_1.talkMaxDuration)

			if var_31_25 <= arg_28_1.time_ and arg_28_1.time_ < var_31_25 + var_31_32 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_25) / var_31_32

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_25 + var_31_32 and arg_28_1.time_ < var_31_25 + var_31_32 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
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
	Play105071008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 105071008
		arg_32_1.duration_ = 3.8

		local var_32_0 = {
			ja = 1.999999999999,
			ko = 2.833,
			zh = 3.8,
			en = 3.566
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
				arg_32_0:Play105071009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1013ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1013ui_story == nil then
				arg_32_1.var_.characterEffect1013ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1013ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1013ui_story then
				arg_32_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["1013ui_story"].transform
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 then
				arg_32_1.var_.moveOldPos1013ui_story = var_35_4.localPosition
			end

			local var_35_6 = 0.001

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6
				local var_35_8 = Vector3.New(0, -0.66, -6.15)

				var_35_4.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1013ui_story, var_35_8, var_35_7)

				local var_35_9 = manager.ui.mainCamera.transform.position - var_35_4.position

				var_35_4.forward = Vector3.New(var_35_9.x, var_35_9.y, var_35_9.z)

				local var_35_10 = var_35_4.localEulerAngles

				var_35_10.z = 0
				var_35_10.x = 0
				var_35_4.localEulerAngles = var_35_10
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 then
				var_35_4.localPosition = Vector3.New(0, -0.66, -6.15)

				local var_35_11 = manager.ui.mainCamera.transform.position - var_35_4.position

				var_35_4.forward = Vector3.New(var_35_11.x, var_35_11.y, var_35_11.z)

				local var_35_12 = var_35_4.localEulerAngles

				var_35_12.z = 0
				var_35_12.x = 0
				var_35_4.localEulerAngles = var_35_12
			end

			local var_35_13 = 0

			if var_35_13 < arg_32_1.time_ and arg_32_1.time_ <= var_35_13 + arg_35_0 then
				arg_32_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action13_2")
			end

			local var_35_14 = 0

			if var_35_14 < arg_32_1.time_ and arg_32_1.time_ <= var_35_14 + arg_35_0 then
				arg_32_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_35_15 = 0
			local var_35_16 = 0.25

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_17 = arg_32_1:FormatText(StoryNameCfg[35].name)

				arg_32_1.leftNameTxt_.text = var_35_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_18 = arg_32_1:GetWordFromCfg(105071008)
				local var_35_19 = arg_32_1:FormatText(var_35_18.content)

				arg_32_1.text_.text = var_35_19

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_20 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071008", "story_v_out_105071.awb") ~= 0 then
					local var_35_23 = manager.audio:GetVoiceLength("story_v_out_105071", "105071008", "story_v_out_105071.awb") / 1000

					if var_35_23 + var_35_15 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_23 + var_35_15
					end

					if var_35_18.prefab_name ~= "" and arg_32_1.actors_[var_35_18.prefab_name] ~= nil then
						local var_35_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_18.prefab_name].transform, "story_v_out_105071", "105071008", "story_v_out_105071.awb")

						arg_32_1:RecordAudio("105071008", var_35_24)
						arg_32_1:RecordAudio("105071008", var_35_24)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_105071", "105071008", "story_v_out_105071.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_105071", "105071008", "story_v_out_105071.awb")
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
				actorName = "1013ui_story",
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
	Play105071009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 105071009
		arg_36_1.duration_ = 2

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play105071010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["10002ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect10002ui_story == nil then
				arg_36_1.var_.characterEffect10002ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.1

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect10002ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect10002ui_story then
				arg_36_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["1013ui_story"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1013ui_story == nil then
				arg_36_1.var_.characterEffect1013ui_story = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.1

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect1013ui_story and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1013ui_story.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1013ui_story then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1013ui_story.fillRatio = var_39_9
			end

			local var_39_10 = arg_36_1.actors_["1013ui_story"].transform
			local var_39_11 = 0

			if var_39_11 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1.var_.moveOldPos1013ui_story = var_39_10.localPosition
			end

			local var_39_12 = 0.001

			if var_39_11 <= arg_36_1.time_ and arg_36_1.time_ < var_39_11 + var_39_12 then
				local var_39_13 = (arg_36_1.time_ - var_39_11) / var_39_12
				local var_39_14 = Vector3.New(0, 100, 0)

				var_39_10.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1013ui_story, var_39_14, var_39_13)

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

			local var_39_19 = arg_36_1.actors_["10002ui_story"].transform
			local var_39_20 = 0

			if var_39_20 < arg_36_1.time_ and arg_36_1.time_ <= var_39_20 + arg_39_0 then
				arg_36_1.var_.moveOldPos10002ui_story = var_39_19.localPosition
			end

			local var_39_21 = 0.001

			if var_39_20 <= arg_36_1.time_ and arg_36_1.time_ < var_39_20 + var_39_21 then
				local var_39_22 = (arg_36_1.time_ - var_39_20) / var_39_21
				local var_39_23 = Vector3.New(0, -1.2, -5.8)

				var_39_19.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10002ui_story, var_39_23, var_39_22)

				local var_39_24 = manager.ui.mainCamera.transform.position - var_39_19.position

				var_39_19.forward = Vector3.New(var_39_24.x, var_39_24.y, var_39_24.z)

				local var_39_25 = var_39_19.localEulerAngles

				var_39_25.z = 0
				var_39_25.x = 0
				var_39_19.localEulerAngles = var_39_25
			end

			if arg_36_1.time_ >= var_39_20 + var_39_21 and arg_36_1.time_ < var_39_20 + var_39_21 + arg_39_0 then
				var_39_19.localPosition = Vector3.New(0, -1.2, -5.8)

				local var_39_26 = manager.ui.mainCamera.transform.position - var_39_19.position

				var_39_19.forward = Vector3.New(var_39_26.x, var_39_26.y, var_39_26.z)

				local var_39_27 = var_39_19.localEulerAngles

				var_39_27.z = 0
				var_39_27.x = 0
				var_39_19.localEulerAngles = var_39_27
			end

			local var_39_28 = 0

			if var_39_28 < arg_36_1.time_ and arg_36_1.time_ <= var_39_28 + arg_39_0 then
				arg_36_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_1")
			end

			local var_39_29 = 0

			if var_39_29 < arg_36_1.time_ and arg_36_1.time_ <= var_39_29 + arg_39_0 then
				arg_36_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_39_30 = 0
			local var_39_31 = 0.1

			if var_39_30 < arg_36_1.time_ and arg_36_1.time_ <= var_39_30 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_32 = arg_36_1:FormatText(StoryNameCfg[39].name)

				arg_36_1.leftNameTxt_.text = var_39_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_33 = arg_36_1:GetWordFromCfg(105071009)
				local var_39_34 = arg_36_1:FormatText(var_39_33.content)

				arg_36_1.text_.text = var_39_34

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_35 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071009", "story_v_out_105071.awb") ~= 0 then
					local var_39_38 = manager.audio:GetVoiceLength("story_v_out_105071", "105071009", "story_v_out_105071.awb") / 1000

					if var_39_38 + var_39_30 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_38 + var_39_30
					end

					if var_39_33.prefab_name ~= "" and arg_36_1.actors_[var_39_33.prefab_name] ~= nil then
						local var_39_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_33.prefab_name].transform, "story_v_out_105071", "105071009", "story_v_out_105071.awb")

						arg_36_1:RecordAudio("105071009", var_39_39)
						arg_36_1:RecordAudio("105071009", var_39_39)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_105071", "105071009", "story_v_out_105071.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_105071", "105071009", "story_v_out_105071.awb")
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
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
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
	Play105071010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 105071010
		arg_40_1.duration_ = 4.37

		local var_40_0 = {
			ja = 3.5,
			ko = 2.566,
			zh = 4.366,
			en = 2.1
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
				arg_40_0:Play105071011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1013ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1013ui_story == nil then
				arg_40_1.var_.characterEffect1013ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1013ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1013ui_story then
				arg_40_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_43_4 = arg_40_1.actors_["10002ui_story"]
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect10002ui_story == nil then
				arg_40_1.var_.characterEffect10002ui_story = var_43_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.1

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 and not isNil(var_43_4) then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6

				if arg_40_1.var_.characterEffect10002ui_story and not isNil(var_43_4) then
					local var_43_8 = Mathf.Lerp(0, 0.5, var_43_7)

					arg_40_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_40_1.var_.characterEffect10002ui_story.fillRatio = var_43_8
				end
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect10002ui_story then
				local var_43_9 = 0.5

				arg_40_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_40_1.var_.characterEffect10002ui_story.fillRatio = var_43_9
			end

			local var_43_10 = arg_40_1.actors_["10002ui_story"].transform
			local var_43_11 = 0

			if var_43_11 < arg_40_1.time_ and arg_40_1.time_ <= var_43_11 + arg_43_0 then
				arg_40_1.var_.moveOldPos10002ui_story = var_43_10.localPosition
			end

			local var_43_12 = 0.001

			if var_43_11 <= arg_40_1.time_ and arg_40_1.time_ < var_43_11 + var_43_12 then
				local var_43_13 = (arg_40_1.time_ - var_43_11) / var_43_12
				local var_43_14 = Vector3.New(0, 100, 0)

				var_43_10.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10002ui_story, var_43_14, var_43_13)

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

			local var_43_19 = arg_40_1.actors_["1013ui_story"].transform
			local var_43_20 = 0

			if var_43_20 < arg_40_1.time_ and arg_40_1.time_ <= var_43_20 + arg_43_0 then
				arg_40_1.var_.moveOldPos1013ui_story = var_43_19.localPosition
			end

			local var_43_21 = 0.001

			if var_43_20 <= arg_40_1.time_ and arg_40_1.time_ < var_43_20 + var_43_21 then
				local var_43_22 = (arg_40_1.time_ - var_43_20) / var_43_21
				local var_43_23 = Vector3.New(0, -0.66, -6.15)

				var_43_19.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1013ui_story, var_43_23, var_43_22)

				local var_43_24 = manager.ui.mainCamera.transform.position - var_43_19.position

				var_43_19.forward = Vector3.New(var_43_24.x, var_43_24.y, var_43_24.z)

				local var_43_25 = var_43_19.localEulerAngles

				var_43_25.z = 0
				var_43_25.x = 0
				var_43_19.localEulerAngles = var_43_25
			end

			if arg_40_1.time_ >= var_43_20 + var_43_21 and arg_40_1.time_ < var_43_20 + var_43_21 + arg_43_0 then
				var_43_19.localPosition = Vector3.New(0, -0.66, -6.15)

				local var_43_26 = manager.ui.mainCamera.transform.position - var_43_19.position

				var_43_19.forward = Vector3.New(var_43_26.x, var_43_26.y, var_43_26.z)

				local var_43_27 = var_43_19.localEulerAngles

				var_43_27.z = 0
				var_43_27.x = 0
				var_43_19.localEulerAngles = var_43_27
			end

			local var_43_28 = 0

			if var_43_28 < arg_40_1.time_ and arg_40_1.time_ <= var_43_28 + arg_43_0 then
				arg_40_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action12_1")
			end

			local var_43_29 = 0

			if var_43_29 < arg_40_1.time_ and arg_40_1.time_ <= var_43_29 + arg_43_0 then
				arg_40_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_43_30 = 0
			local var_43_31 = 0.25

			if var_43_30 < arg_40_1.time_ and arg_40_1.time_ <= var_43_30 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_32 = arg_40_1:FormatText(StoryNameCfg[35].name)

				arg_40_1.leftNameTxt_.text = var_43_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_33 = arg_40_1:GetWordFromCfg(105071010)
				local var_43_34 = arg_40_1:FormatText(var_43_33.content)

				arg_40_1.text_.text = var_43_34

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_35 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071010", "story_v_out_105071.awb") ~= 0 then
					local var_43_38 = manager.audio:GetVoiceLength("story_v_out_105071", "105071010", "story_v_out_105071.awb") / 1000

					if var_43_38 + var_43_30 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_38 + var_43_30
					end

					if var_43_33.prefab_name ~= "" and arg_40_1.actors_[var_43_33.prefab_name] ~= nil then
						local var_43_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_33.prefab_name].transform, "story_v_out_105071", "105071010", "story_v_out_105071.awb")

						arg_40_1:RecordAudio("105071010", var_43_39)
						arg_40_1:RecordAudio("105071010", var_43_39)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_105071", "105071010", "story_v_out_105071.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_105071", "105071010", "story_v_out_105071.awb")
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
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1013ui_story",
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
	Play105071011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 105071011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play105071012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1013ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1013ui_story == nil then
				arg_44_1.var_.characterEffect1013ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1013ui_story and not isNil(var_47_0) then
					local var_47_4 = Mathf.Lerp(0, 0.5, var_47_3)

					arg_44_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1013ui_story.fillRatio = var_47_4
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1013ui_story then
				local var_47_5 = 0.5

				arg_44_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1013ui_story.fillRatio = var_47_5
			end

			local var_47_6 = arg_44_1.actors_["1013ui_story"].transform
			local var_47_7 = 0

			if var_47_7 < arg_44_1.time_ and arg_44_1.time_ <= var_47_7 + arg_47_0 then
				arg_44_1.var_.moveOldPos1013ui_story = var_47_6.localPosition
			end

			local var_47_8 = 0.001

			if var_47_7 <= arg_44_1.time_ and arg_44_1.time_ < var_47_7 + var_47_8 then
				local var_47_9 = (arg_44_1.time_ - var_47_7) / var_47_8
				local var_47_10 = Vector3.New(0, 100, 0)

				var_47_6.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1013ui_story, var_47_10, var_47_9)

				local var_47_11 = manager.ui.mainCamera.transform.position - var_47_6.position

				var_47_6.forward = Vector3.New(var_47_11.x, var_47_11.y, var_47_11.z)

				local var_47_12 = var_47_6.localEulerAngles

				var_47_12.z = 0
				var_47_12.x = 0
				var_47_6.localEulerAngles = var_47_12
			end

			if arg_44_1.time_ >= var_47_7 + var_47_8 and arg_44_1.time_ < var_47_7 + var_47_8 + arg_47_0 then
				var_47_6.localPosition = Vector3.New(0, 100, 0)

				local var_47_13 = manager.ui.mainCamera.transform.position - var_47_6.position

				var_47_6.forward = Vector3.New(var_47_13.x, var_47_13.y, var_47_13.z)

				local var_47_14 = var_47_6.localEulerAngles

				var_47_14.z = 0
				var_47_14.x = 0
				var_47_6.localEulerAngles = var_47_14
			end

			local var_47_15 = 0
			local var_47_16 = 1.05

			if var_47_15 < arg_44_1.time_ and arg_44_1.time_ <= var_47_15 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_17 = arg_44_1:GetWordFromCfg(105071011)
				local var_47_18 = arg_44_1:FormatText(var_47_17.content)

				arg_44_1.text_.text = var_47_18

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_19 = 42
				local var_47_20 = utf8.len(var_47_18)
				local var_47_21 = var_47_19 <= 0 and var_47_16 or var_47_16 * (var_47_20 / var_47_19)

				if var_47_21 > 0 and var_47_16 < var_47_21 then
					arg_44_1.talkMaxDuration = var_47_21

					if var_47_21 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_21 + var_47_15
					end
				end

				arg_44_1.text_.text = var_47_18
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_22 = math.max(var_47_16, arg_44_1.talkMaxDuration)

			if var_47_15 <= arg_44_1.time_ and arg_44_1.time_ < var_47_15 + var_47_22 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_15) / var_47_22

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_15 + var_47_22 and arg_44_1.time_ < var_47_15 + var_47_22 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
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
	Play105071012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 105071012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play105071013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 1

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				local var_51_2 = "play"
				local var_51_3 = "effect"

				arg_48_1:AudioAction(var_51_2, var_51_3, "se_story_5", "se_story_5_wall", "")
			end

			local var_51_4 = 0
			local var_51_5 = 0.9

			if var_51_4 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_6 = arg_48_1:GetWordFromCfg(105071012)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_8 = 36
				local var_51_9 = utf8.len(var_51_7)
				local var_51_10 = var_51_8 <= 0 and var_51_5 or var_51_5 * (var_51_9 / var_51_8)

				if var_51_10 > 0 and var_51_5 < var_51_10 then
					arg_48_1.talkMaxDuration = var_51_10

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_11 = math.max(var_51_5, arg_48_1.talkMaxDuration)

			if var_51_4 <= arg_48_1.time_ and arg_48_1.time_ < var_51_4 + var_51_11 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_4) / var_51_11

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_4 + var_51_11 and arg_48_1.time_ < var_51_4 + var_51_11 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play105071013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 105071013
		arg_52_1.duration_ = 3.7

		local var_52_0 = {
			ja = 3.7,
			ko = 2.2,
			zh = 2.666,
			en = 3.166
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
				arg_52_0:Play105071014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["10002ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect10002ui_story == nil then
				arg_52_1.var_.characterEffect10002ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.1

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect10002ui_story and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect10002ui_story then
				arg_52_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_55_4 = arg_52_1.actors_["10002ui_story"].transform
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 then
				arg_52_1.var_.moveOldPos10002ui_story = var_55_4.localPosition
			end

			local var_55_6 = 0.001

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6
				local var_55_8 = Vector3.New(-0.7, -1.2, -5.8)

				var_55_4.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10002ui_story, var_55_8, var_55_7)

				local var_55_9 = manager.ui.mainCamera.transform.position - var_55_4.position

				var_55_4.forward = Vector3.New(var_55_9.x, var_55_9.y, var_55_9.z)

				local var_55_10 = var_55_4.localEulerAngles

				var_55_10.z = 0
				var_55_10.x = 0
				var_55_4.localEulerAngles = var_55_10
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 then
				var_55_4.localPosition = Vector3.New(-0.7, -1.2, -5.8)

				local var_55_11 = manager.ui.mainCamera.transform.position - var_55_4.position

				var_55_4.forward = Vector3.New(var_55_11.x, var_55_11.y, var_55_11.z)

				local var_55_12 = var_55_4.localEulerAngles

				var_55_12.z = 0
				var_55_12.x = 0
				var_55_4.localEulerAngles = var_55_12
			end

			local var_55_13 = 0

			if var_55_13 < arg_52_1.time_ and arg_52_1.time_ <= var_55_13 + arg_55_0 then
				arg_52_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action1_1")
			end

			local var_55_14 = 0

			if var_55_14 < arg_52_1.time_ and arg_52_1.time_ <= var_55_14 + arg_55_0 then
				arg_52_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_55_15 = 0
			local var_55_16 = 0.225

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_17 = arg_52_1:FormatText(StoryNameCfg[39].name)

				arg_52_1.leftNameTxt_.text = var_55_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_18 = arg_52_1:GetWordFromCfg(105071013)
				local var_55_19 = arg_52_1:FormatText(var_55_18.content)

				arg_52_1.text_.text = var_55_19

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_20 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071013", "story_v_out_105071.awb") ~= 0 then
					local var_55_23 = manager.audio:GetVoiceLength("story_v_out_105071", "105071013", "story_v_out_105071.awb") / 1000

					if var_55_23 + var_55_15 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_23 + var_55_15
					end

					if var_55_18.prefab_name ~= "" and arg_52_1.actors_[var_55_18.prefab_name] ~= nil then
						local var_55_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_18.prefab_name].transform, "story_v_out_105071", "105071013", "story_v_out_105071.awb")

						arg_52_1:RecordAudio("105071013", var_55_24)
						arg_52_1:RecordAudio("105071013", var_55_24)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_105071", "105071013", "story_v_out_105071.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_105071", "105071013", "story_v_out_105071.awb")
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
				actorName = "10002ui_story",
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
	Play105071014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 105071014
		arg_56_1.duration_ = 8.7

		local var_56_0 = {
			ja = 8,
			ko = 7.866,
			zh = 8.7,
			en = 8.166
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
				arg_56_0:Play105071015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1013ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1013ui_story == nil then
				arg_56_1.var_.characterEffect1013ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.1

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1013ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1013ui_story then
				arg_56_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_59_4 = arg_56_1.actors_["10002ui_story"]
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect10002ui_story == nil then
				arg_56_1.var_.characterEffect10002ui_story = var_59_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_6 = 0.1

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 and not isNil(var_59_4) then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6

				if arg_56_1.var_.characterEffect10002ui_story and not isNil(var_59_4) then
					local var_59_8 = Mathf.Lerp(0, 0.5, var_59_7)

					arg_56_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_56_1.var_.characterEffect10002ui_story.fillRatio = var_59_8
				end
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect10002ui_story then
				local var_59_9 = 0.5

				arg_56_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_56_1.var_.characterEffect10002ui_story.fillRatio = var_59_9
			end

			local var_59_10 = arg_56_1.actors_["1013ui_story"].transform
			local var_59_11 = 0

			if var_59_11 < arg_56_1.time_ and arg_56_1.time_ <= var_59_11 + arg_59_0 then
				arg_56_1.var_.moveOldPos1013ui_story = var_59_10.localPosition
			end

			local var_59_12 = 0.001

			if var_59_11 <= arg_56_1.time_ and arg_56_1.time_ < var_59_11 + var_59_12 then
				local var_59_13 = (arg_56_1.time_ - var_59_11) / var_59_12
				local var_59_14 = Vector3.New(0.7, -0.66, -6.15)

				var_59_10.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1013ui_story, var_59_14, var_59_13)

				local var_59_15 = manager.ui.mainCamera.transform.position - var_59_10.position

				var_59_10.forward = Vector3.New(var_59_15.x, var_59_15.y, var_59_15.z)

				local var_59_16 = var_59_10.localEulerAngles

				var_59_16.z = 0
				var_59_16.x = 0
				var_59_10.localEulerAngles = var_59_16
			end

			if arg_56_1.time_ >= var_59_11 + var_59_12 and arg_56_1.time_ < var_59_11 + var_59_12 + arg_59_0 then
				var_59_10.localPosition = Vector3.New(0.7, -0.66, -6.15)

				local var_59_17 = manager.ui.mainCamera.transform.position - var_59_10.position

				var_59_10.forward = Vector3.New(var_59_17.x, var_59_17.y, var_59_17.z)

				local var_59_18 = var_59_10.localEulerAngles

				var_59_18.z = 0
				var_59_18.x = 0
				var_59_10.localEulerAngles = var_59_18
			end

			local var_59_19 = 0

			if var_59_19 < arg_56_1.time_ and arg_56_1.time_ <= var_59_19 + arg_59_0 then
				arg_56_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action7_1")
			end

			local var_59_20 = 0

			if var_59_20 < arg_56_1.time_ and arg_56_1.time_ <= var_59_20 + arg_59_0 then
				arg_56_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_59_21 = 0
			local var_59_22 = 0.7

			if var_59_21 < arg_56_1.time_ and arg_56_1.time_ <= var_59_21 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_23 = arg_56_1:FormatText(StoryNameCfg[35].name)

				arg_56_1.leftNameTxt_.text = var_59_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_24 = arg_56_1:GetWordFromCfg(105071014)
				local var_59_25 = arg_56_1:FormatText(var_59_24.content)

				arg_56_1.text_.text = var_59_25

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_26 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071014", "story_v_out_105071.awb") ~= 0 then
					local var_59_29 = manager.audio:GetVoiceLength("story_v_out_105071", "105071014", "story_v_out_105071.awb") / 1000

					if var_59_29 + var_59_21 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_29 + var_59_21
					end

					if var_59_24.prefab_name ~= "" and arg_56_1.actors_[var_59_24.prefab_name] ~= nil then
						local var_59_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_24.prefab_name].transform, "story_v_out_105071", "105071014", "story_v_out_105071.awb")

						arg_56_1:RecordAudio("105071014", var_59_30)
						arg_56_1:RecordAudio("105071014", var_59_30)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_105071", "105071014", "story_v_out_105071.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_105071", "105071014", "story_v_out_105071.awb")
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
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play105071015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 105071015
		arg_60_1.duration_ = 7

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play105071016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1013ui_story"]
			local var_63_1 = 2

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1013ui_story == nil then
				arg_60_1.var_.characterEffect1013ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.1

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1013ui_story and not isNil(var_63_0) then
					local var_63_4 = Mathf.Lerp(0, 0.5, var_63_3)

					arg_60_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1013ui_story.fillRatio = var_63_4
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1013ui_story then
				local var_63_5 = 0.5

				arg_60_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1013ui_story.fillRatio = var_63_5
			end

			local var_63_6 = arg_60_1.bgs_.B01c
			local var_63_7 = 0

			if var_63_7 < arg_60_1.time_ and arg_60_1.time_ <= var_63_7 + arg_63_0 then
				local var_63_8 = var_63_6:GetComponent("SpriteRenderer")

				if var_63_8 then
					arg_60_1.var_.alphaOldValueB01c = var_63_8.color.a
					arg_60_1.var_.alphaMatValueB01c = var_63_8
				end

				arg_60_1.var_.alphaOldValueB01c = 1
			end

			local var_63_9 = 1.5

			if var_63_7 <= arg_60_1.time_ and arg_60_1.time_ < var_63_7 + var_63_9 then
				local var_63_10 = (arg_60_1.time_ - var_63_7) / var_63_9
				local var_63_11 = Mathf.Lerp(arg_60_1.var_.alphaOldValueB01c, 0, var_63_10)

				if arg_60_1.var_.alphaMatValueB01c then
					local var_63_12 = arg_60_1.var_.alphaMatValueB01c.color

					var_63_12.a = var_63_11
					arg_60_1.var_.alphaMatValueB01c.color = var_63_12
				end
			end

			if arg_60_1.time_ >= var_63_7 + var_63_9 and arg_60_1.time_ < var_63_7 + var_63_9 + arg_63_0 and arg_60_1.var_.alphaMatValueB01c then
				local var_63_13 = arg_60_1.var_.alphaMatValueB01c
				local var_63_14 = var_63_13.color

				var_63_14.a = 0
				var_63_13.color = var_63_14
			end

			local var_63_15 = arg_60_1.bgs_.B01c.transform
			local var_63_16 = 1.5

			if var_63_16 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 then
				arg_60_1.var_.moveOldPosB01c = var_63_15.localPosition
			end

			local var_63_17 = 0.001

			if var_63_16 <= arg_60_1.time_ and arg_60_1.time_ < var_63_16 + var_63_17 then
				local var_63_18 = (arg_60_1.time_ - var_63_16) / var_63_17
				local var_63_19 = Vector3.New(0, -100, 10)

				var_63_15.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPosB01c, var_63_19, var_63_18)
			end

			if arg_60_1.time_ >= var_63_16 + var_63_17 and arg_60_1.time_ < var_63_16 + var_63_17 + arg_63_0 then
				var_63_15.localPosition = Vector3.New(0, -100, 10)
			end

			local var_63_20 = "B03f"

			if arg_60_1.bgs_[var_63_20] == nil then
				local var_63_21 = Object.Instantiate(arg_60_1.paintGo_)

				var_63_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_63_20)
				var_63_21.name = var_63_20
				var_63_21.transform.parent = arg_60_1.stage_.transform
				var_63_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.bgs_[var_63_20] = var_63_21
			end

			local var_63_22 = arg_60_1.bgs_.B03f
			local var_63_23 = 1.5

			if var_63_23 < arg_60_1.time_ and arg_60_1.time_ <= var_63_23 + arg_63_0 then
				local var_63_24 = var_63_22:GetComponent("SpriteRenderer")

				if var_63_24 then
					arg_60_1.var_.alphaOldValueB03f = var_63_24.color.a
					arg_60_1.var_.alphaMatValueB03f = var_63_24
				end

				arg_60_1.var_.alphaOldValueB03f = 0
			end

			local var_63_25 = 1.5

			if var_63_23 <= arg_60_1.time_ and arg_60_1.time_ < var_63_23 + var_63_25 then
				local var_63_26 = (arg_60_1.time_ - var_63_23) / var_63_25
				local var_63_27 = Mathf.Lerp(arg_60_1.var_.alphaOldValueB03f, 1, var_63_26)

				if arg_60_1.var_.alphaMatValueB03f then
					local var_63_28 = arg_60_1.var_.alphaMatValueB03f.color

					var_63_28.a = var_63_27
					arg_60_1.var_.alphaMatValueB03f.color = var_63_28
				end
			end

			if arg_60_1.time_ >= var_63_23 + var_63_25 and arg_60_1.time_ < var_63_23 + var_63_25 + arg_63_0 and arg_60_1.var_.alphaMatValueB03f then
				local var_63_29 = arg_60_1.var_.alphaMatValueB03f
				local var_63_30 = var_63_29.color

				var_63_30.a = 1
				var_63_29.color = var_63_30
			end

			local var_63_31 = 1.5

			if var_63_31 < arg_60_1.time_ and arg_60_1.time_ <= var_63_31 + arg_63_0 then
				local var_63_32 = manager.ui.mainCamera.transform.localPosition
				local var_63_33 = Vector3.New(0, 0, 10) + Vector3.New(var_63_32.x, var_63_32.y, 0)
				local var_63_34 = arg_60_1.bgs_.B03f

				var_63_34.transform.localPosition = var_63_33
				var_63_34.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_63_35 = var_63_34:GetComponent("SpriteRenderer")

				if var_63_35 and var_63_35.sprite then
					local var_63_36 = (var_63_34.transform.localPosition - var_63_32).z
					local var_63_37 = manager.ui.mainCameraCom_
					local var_63_38 = 2 * var_63_36 * Mathf.Tan(var_63_37.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_63_39 = var_63_38 * var_63_37.aspect
					local var_63_40 = var_63_35.sprite.bounds.size.x
					local var_63_41 = var_63_35.sprite.bounds.size.y
					local var_63_42 = var_63_39 / var_63_40
					local var_63_43 = var_63_38 / var_63_41
					local var_63_44 = var_63_43 < var_63_42 and var_63_42 or var_63_43

					var_63_34.transform.localScale = Vector3.New(var_63_44, var_63_44, 0)
				end

				for iter_63_0, iter_63_1 in pairs(arg_60_1.bgs_) do
					if iter_63_0 ~= "B03f" then
						iter_63_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_63_45 = arg_60_1.actors_["10002ui_story"].transform
			local var_63_46 = 0

			if var_63_46 < arg_60_1.time_ and arg_60_1.time_ <= var_63_46 + arg_63_0 then
				arg_60_1.var_.moveOldPos10002ui_story = var_63_45.localPosition
			end

			local var_63_47 = 0.001

			if var_63_46 <= arg_60_1.time_ and arg_60_1.time_ < var_63_46 + var_63_47 then
				local var_63_48 = (arg_60_1.time_ - var_63_46) / var_63_47
				local var_63_49 = Vector3.New(0, 100, 0)

				var_63_45.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10002ui_story, var_63_49, var_63_48)

				local var_63_50 = manager.ui.mainCamera.transform.position - var_63_45.position

				var_63_45.forward = Vector3.New(var_63_50.x, var_63_50.y, var_63_50.z)

				local var_63_51 = var_63_45.localEulerAngles

				var_63_51.z = 0
				var_63_51.x = 0
				var_63_45.localEulerAngles = var_63_51
			end

			if arg_60_1.time_ >= var_63_46 + var_63_47 and arg_60_1.time_ < var_63_46 + var_63_47 + arg_63_0 then
				var_63_45.localPosition = Vector3.New(0, 100, 0)

				local var_63_52 = manager.ui.mainCamera.transform.position - var_63_45.position

				var_63_45.forward = Vector3.New(var_63_52.x, var_63_52.y, var_63_52.z)

				local var_63_53 = var_63_45.localEulerAngles

				var_63_53.z = 0
				var_63_53.x = 0
				var_63_45.localEulerAngles = var_63_53
			end

			local var_63_54 = arg_60_1.actors_["1013ui_story"].transform
			local var_63_55 = 0

			if var_63_55 < arg_60_1.time_ and arg_60_1.time_ <= var_63_55 + arg_63_0 then
				arg_60_1.var_.moveOldPos1013ui_story = var_63_54.localPosition
			end

			local var_63_56 = 0.001

			if var_63_55 <= arg_60_1.time_ and arg_60_1.time_ < var_63_55 + var_63_56 then
				local var_63_57 = (arg_60_1.time_ - var_63_55) / var_63_56
				local var_63_58 = Vector3.New(0, 100, 0)

				var_63_54.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1013ui_story, var_63_58, var_63_57)

				local var_63_59 = manager.ui.mainCamera.transform.position - var_63_54.position

				var_63_54.forward = Vector3.New(var_63_59.x, var_63_59.y, var_63_59.z)

				local var_63_60 = var_63_54.localEulerAngles

				var_63_60.z = 0
				var_63_60.x = 0
				var_63_54.localEulerAngles = var_63_60
			end

			if arg_60_1.time_ >= var_63_55 + var_63_56 and arg_60_1.time_ < var_63_55 + var_63_56 + arg_63_0 then
				var_63_54.localPosition = Vector3.New(0, 100, 0)

				local var_63_61 = manager.ui.mainCamera.transform.position - var_63_54.position

				var_63_54.forward = Vector3.New(var_63_61.x, var_63_61.y, var_63_61.z)

				local var_63_62 = var_63_54.localEulerAngles

				var_63_62.z = 0
				var_63_62.x = 0
				var_63_54.localEulerAngles = var_63_62
			end

			local var_63_63 = 0

			if var_63_63 < arg_60_1.time_ and arg_60_1.time_ <= var_63_63 + arg_63_0 then
				arg_60_1.allBtn_.enabled = false
			end

			local var_63_64 = 2

			if arg_60_1.time_ >= var_63_63 + var_63_64 and arg_60_1.time_ < var_63_63 + var_63_64 + arg_63_0 then
				arg_60_1.allBtn_.enabled = true
			end

			if arg_60_1.frameCnt_ <= 1 then
				arg_60_1.dialog_:SetActive(false)
			end

			local var_63_65 = 2
			local var_63_66 = 1.4

			if var_63_65 < arg_60_1.time_ and arg_60_1.time_ <= var_63_65 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_67 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_67:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_60_1.dialogCg_.alpha = arg_64_0
				end))
				var_63_67:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_67:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_68 = arg_60_1:GetWordFromCfg(105071015)
				local var_63_69 = arg_60_1:FormatText(var_63_68.content)

				arg_60_1.text_.text = var_63_69

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_70 = 55
				local var_63_71 = utf8.len(var_63_69)
				local var_63_72 = var_63_70 <= 0 and var_63_66 or var_63_66 * (var_63_71 / var_63_70)

				if var_63_72 > 0 and var_63_66 < var_63_72 then
					arg_60_1.talkMaxDuration = var_63_72
					var_63_65 = var_63_65 + 0.3

					if var_63_72 + var_63_65 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_72 + var_63_65
					end
				end

				arg_60_1.text_.text = var_63_69
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_73 = var_63_65 + 0.3
			local var_63_74 = math.max(var_63_66, arg_60_1.talkMaxDuration)

			if var_63_73 <= arg_60_1.time_ and arg_60_1.time_ < var_63_73 + var_63_74 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_73) / var_63_74

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_73 + var_63_74 and arg_60_1.time_ < var_63_73 + var_63_74 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B01c",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play105071016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 105071016
		arg_66_1.duration_ = 5.2

		local var_66_0 = {
			ja = 5.2,
			ko = 4.4,
			zh = 4.566,
			en = 4.833
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
				arg_66_0:Play105071017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["10002ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect10002ui_story == nil then
				arg_66_1.var_.characterEffect10002ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.1

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect10002ui_story and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect10002ui_story then
				arg_66_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_69_4 = arg_66_1.actors_["10002ui_story"].transform
			local var_69_5 = 0

			if var_69_5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 then
				arg_66_1.var_.moveOldPos10002ui_story = var_69_4.localPosition
			end

			local var_69_6 = 0.001

			if var_69_5 <= arg_66_1.time_ and arg_66_1.time_ < var_69_5 + var_69_6 then
				local var_69_7 = (arg_66_1.time_ - var_69_5) / var_69_6
				local var_69_8 = Vector3.New(-0.7, -1.2, -5.8)

				var_69_4.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos10002ui_story, var_69_8, var_69_7)

				local var_69_9 = manager.ui.mainCamera.transform.position - var_69_4.position

				var_69_4.forward = Vector3.New(var_69_9.x, var_69_9.y, var_69_9.z)

				local var_69_10 = var_69_4.localEulerAngles

				var_69_10.z = 0
				var_69_10.x = 0
				var_69_4.localEulerAngles = var_69_10
			end

			if arg_66_1.time_ >= var_69_5 + var_69_6 and arg_66_1.time_ < var_69_5 + var_69_6 + arg_69_0 then
				var_69_4.localPosition = Vector3.New(-0.7, -1.2, -5.8)

				local var_69_11 = manager.ui.mainCamera.transform.position - var_69_4.position

				var_69_4.forward = Vector3.New(var_69_11.x, var_69_11.y, var_69_11.z)

				local var_69_12 = var_69_4.localEulerAngles

				var_69_12.z = 0
				var_69_12.x = 0
				var_69_4.localEulerAngles = var_69_12
			end

			local var_69_13 = 0

			if var_69_13 < arg_66_1.time_ and arg_66_1.time_ <= var_69_13 + arg_69_0 then
				arg_66_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action2_1")
			end

			local var_69_14 = 0

			if var_69_14 < arg_66_1.time_ and arg_66_1.time_ <= var_69_14 + arg_69_0 then
				arg_66_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_69_15 = 0
			local var_69_16 = 0.5

			if var_69_15 < arg_66_1.time_ and arg_66_1.time_ <= var_69_15 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_17 = arg_66_1:FormatText(StoryNameCfg[39].name)

				arg_66_1.leftNameTxt_.text = var_69_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_18 = arg_66_1:GetWordFromCfg(105071016)
				local var_69_19 = arg_66_1:FormatText(var_69_18.content)

				arg_66_1.text_.text = var_69_19

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_20 = 20
				local var_69_21 = utf8.len(var_69_19)
				local var_69_22 = var_69_20 <= 0 and var_69_16 or var_69_16 * (var_69_21 / var_69_20)

				if var_69_22 > 0 and var_69_16 < var_69_22 then
					arg_66_1.talkMaxDuration = var_69_22

					if var_69_22 + var_69_15 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_22 + var_69_15
					end
				end

				arg_66_1.text_.text = var_69_19
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071016", "story_v_out_105071.awb") ~= 0 then
					local var_69_23 = manager.audio:GetVoiceLength("story_v_out_105071", "105071016", "story_v_out_105071.awb") / 1000

					if var_69_23 + var_69_15 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_23 + var_69_15
					end

					if var_69_18.prefab_name ~= "" and arg_66_1.actors_[var_69_18.prefab_name] ~= nil then
						local var_69_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_18.prefab_name].transform, "story_v_out_105071", "105071016", "story_v_out_105071.awb")

						arg_66_1:RecordAudio("105071016", var_69_24)
						arg_66_1:RecordAudio("105071016", var_69_24)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_105071", "105071016", "story_v_out_105071.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_105071", "105071016", "story_v_out_105071.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_25 = math.max(var_69_16, arg_66_1.talkMaxDuration)

			if var_69_15 <= arg_66_1.time_ and arg_66_1.time_ < var_69_15 + var_69_25 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_15) / var_69_25

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_15 + var_69_25 and arg_66_1.time_ < var_69_15 + var_69_25 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play105071017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 105071017
		arg_70_1.duration_ = 2

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play105071018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1013ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1013ui_story == nil then
				arg_70_1.var_.characterEffect1013ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.1

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect1013ui_story and not isNil(var_73_0) then
					arg_70_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1013ui_story then
				arg_70_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_73_4 = arg_70_1.actors_["1013ui_story"].transform
			local var_73_5 = 0

			if var_73_5 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 then
				arg_70_1.var_.moveOldPos1013ui_story = var_73_4.localPosition
			end

			local var_73_6 = 0.001

			if var_73_5 <= arg_70_1.time_ and arg_70_1.time_ < var_73_5 + var_73_6 then
				local var_73_7 = (arg_70_1.time_ - var_73_5) / var_73_6
				local var_73_8 = Vector3.New(0.7, -0.66, -6.15)

				var_73_4.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1013ui_story, var_73_8, var_73_7)

				local var_73_9 = manager.ui.mainCamera.transform.position - var_73_4.position

				var_73_4.forward = Vector3.New(var_73_9.x, var_73_9.y, var_73_9.z)

				local var_73_10 = var_73_4.localEulerAngles

				var_73_10.z = 0
				var_73_10.x = 0
				var_73_4.localEulerAngles = var_73_10
			end

			if arg_70_1.time_ >= var_73_5 + var_73_6 and arg_70_1.time_ < var_73_5 + var_73_6 + arg_73_0 then
				var_73_4.localPosition = Vector3.New(0.7, -0.66, -6.15)

				local var_73_11 = manager.ui.mainCamera.transform.position - var_73_4.position

				var_73_4.forward = Vector3.New(var_73_11.x, var_73_11.y, var_73_11.z)

				local var_73_12 = var_73_4.localEulerAngles

				var_73_12.z = 0
				var_73_12.x = 0
				var_73_4.localEulerAngles = var_73_12
			end

			local var_73_13 = 0

			if var_73_13 < arg_70_1.time_ and arg_70_1.time_ <= var_73_13 + arg_73_0 then
				arg_70_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action3_1")
			end

			local var_73_14 = 0

			if var_73_14 < arg_70_1.time_ and arg_70_1.time_ <= var_73_14 + arg_73_0 then
				arg_70_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_73_15 = 0
			local var_73_16 = 0.075

			if var_73_15 < arg_70_1.time_ and arg_70_1.time_ <= var_73_15 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_17 = arg_70_1:FormatText(StoryNameCfg[35].name)

				arg_70_1.leftNameTxt_.text = var_73_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_18 = arg_70_1:GetWordFromCfg(105071017)
				local var_73_19 = arg_70_1:FormatText(var_73_18.content)

				arg_70_1.text_.text = var_73_19

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_20 = 3
				local var_73_21 = utf8.len(var_73_19)
				local var_73_22 = var_73_20 <= 0 and var_73_16 or var_73_16 * (var_73_21 / var_73_20)

				if var_73_22 > 0 and var_73_16 < var_73_22 then
					arg_70_1.talkMaxDuration = var_73_22

					if var_73_22 + var_73_15 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_22 + var_73_15
					end
				end

				arg_70_1.text_.text = var_73_19
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071017", "story_v_out_105071.awb") ~= 0 then
					local var_73_23 = manager.audio:GetVoiceLength("story_v_out_105071", "105071017", "story_v_out_105071.awb") / 1000

					if var_73_23 + var_73_15 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_23 + var_73_15
					end

					if var_73_18.prefab_name ~= "" and arg_70_1.actors_[var_73_18.prefab_name] ~= nil then
						local var_73_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_18.prefab_name].transform, "story_v_out_105071", "105071017", "story_v_out_105071.awb")

						arg_70_1:RecordAudio("105071017", var_73_24)
						arg_70_1:RecordAudio("105071017", var_73_24)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_105071", "105071017", "story_v_out_105071.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_105071", "105071017", "story_v_out_105071.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_25 = math.max(var_73_16, arg_70_1.talkMaxDuration)

			if var_73_15 <= arg_70_1.time_ and arg_70_1.time_ < var_73_15 + var_73_25 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_15) / var_73_25

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_15 + var_73_25 and arg_70_1.time_ < var_73_15 + var_73_25 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play105071018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 105071018
		arg_74_1.duration_ = 2

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play105071019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["10002ui_story"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect10002ui_story == nil then
				arg_74_1.var_.characterEffect10002ui_story = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.1

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect10002ui_story and not isNil(var_77_0) then
					arg_74_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect10002ui_story then
				arg_74_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_77_4 = arg_74_1.actors_["1013ui_story"]
			local var_77_5 = 0

			if var_77_5 < arg_74_1.time_ and arg_74_1.time_ <= var_77_5 + arg_77_0 and not isNil(var_77_4) and arg_74_1.var_.characterEffect1013ui_story == nil then
				arg_74_1.var_.characterEffect1013ui_story = var_77_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_6 = 0.1

			if var_77_5 <= arg_74_1.time_ and arg_74_1.time_ < var_77_5 + var_77_6 and not isNil(var_77_4) then
				local var_77_7 = (arg_74_1.time_ - var_77_5) / var_77_6

				if arg_74_1.var_.characterEffect1013ui_story and not isNil(var_77_4) then
					local var_77_8 = Mathf.Lerp(0, 0.5, var_77_7)

					arg_74_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1013ui_story.fillRatio = var_77_8
				end
			end

			if arg_74_1.time_ >= var_77_5 + var_77_6 and arg_74_1.time_ < var_77_5 + var_77_6 + arg_77_0 and not isNil(var_77_4) and arg_74_1.var_.characterEffect1013ui_story then
				local var_77_9 = 0.5

				arg_74_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1013ui_story.fillRatio = var_77_9
			end

			local var_77_10 = 0

			if var_77_10 < arg_74_1.time_ and arg_74_1.time_ <= var_77_10 + arg_77_0 then
				arg_74_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action2_2")
			end

			local var_77_11 = 0

			if var_77_11 < arg_74_1.time_ and arg_74_1.time_ <= var_77_11 + arg_77_0 then
				arg_74_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_77_12 = 0
			local var_77_13 = 0.1

			if var_77_12 < arg_74_1.time_ and arg_74_1.time_ <= var_77_12 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_14 = arg_74_1:FormatText(StoryNameCfg[39].name)

				arg_74_1.leftNameTxt_.text = var_77_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_15 = arg_74_1:GetWordFromCfg(105071018)
				local var_77_16 = arg_74_1:FormatText(var_77_15.content)

				arg_74_1.text_.text = var_77_16

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_17 = 4
				local var_77_18 = utf8.len(var_77_16)
				local var_77_19 = var_77_17 <= 0 and var_77_13 or var_77_13 * (var_77_18 / var_77_17)

				if var_77_19 > 0 and var_77_13 < var_77_19 then
					arg_74_1.talkMaxDuration = var_77_19

					if var_77_19 + var_77_12 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_19 + var_77_12
					end
				end

				arg_74_1.text_.text = var_77_16
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071018", "story_v_out_105071.awb") ~= 0 then
					local var_77_20 = manager.audio:GetVoiceLength("story_v_out_105071", "105071018", "story_v_out_105071.awb") / 1000

					if var_77_20 + var_77_12 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_20 + var_77_12
					end

					if var_77_15.prefab_name ~= "" and arg_74_1.actors_[var_77_15.prefab_name] ~= nil then
						local var_77_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_15.prefab_name].transform, "story_v_out_105071", "105071018", "story_v_out_105071.awb")

						arg_74_1:RecordAudio("105071018", var_77_21)
						arg_74_1:RecordAudio("105071018", var_77_21)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_105071", "105071018", "story_v_out_105071.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_105071", "105071018", "story_v_out_105071.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_22 = math.max(var_77_13, arg_74_1.talkMaxDuration)

			if var_77_12 <= arg_74_1.time_ and arg_74_1.time_ < var_77_12 + var_77_22 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_12) / var_77_22

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_12 + var_77_22 and arg_74_1.time_ < var_77_12 + var_77_22 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play105071019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 105071019
		arg_78_1.duration_ = 7.8

		local var_78_0 = {
			ja = 6,
			ko = 5.2,
			zh = 7.8,
			en = 4.933
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
				arg_78_0:Play105071020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1013ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1013ui_story == nil then
				arg_78_1.var_.characterEffect1013ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.1

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect1013ui_story and not isNil(var_81_0) then
					arg_78_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1013ui_story then
				arg_78_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_81_4 = arg_78_1.actors_["10002ui_story"]
			local var_81_5 = 0

			if var_81_5 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 and not isNil(var_81_4) and arg_78_1.var_.characterEffect10002ui_story == nil then
				arg_78_1.var_.characterEffect10002ui_story = var_81_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_6 = 0.1

			if var_81_5 <= arg_78_1.time_ and arg_78_1.time_ < var_81_5 + var_81_6 and not isNil(var_81_4) then
				local var_81_7 = (arg_78_1.time_ - var_81_5) / var_81_6

				if arg_78_1.var_.characterEffect10002ui_story and not isNil(var_81_4) then
					local var_81_8 = Mathf.Lerp(0, 0.5, var_81_7)

					arg_78_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_78_1.var_.characterEffect10002ui_story.fillRatio = var_81_8
				end
			end

			if arg_78_1.time_ >= var_81_5 + var_81_6 and arg_78_1.time_ < var_81_5 + var_81_6 + arg_81_0 and not isNil(var_81_4) and arg_78_1.var_.characterEffect10002ui_story then
				local var_81_9 = 0.5

				arg_78_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_78_1.var_.characterEffect10002ui_story.fillRatio = var_81_9
			end

			local var_81_10 = arg_78_1.actors_["1013ui_story"].transform
			local var_81_11 = 0

			if var_81_11 < arg_78_1.time_ and arg_78_1.time_ <= var_81_11 + arg_81_0 then
				arg_78_1.var_.moveOldPos1013ui_story = var_81_10.localPosition
			end

			local var_81_12 = 0.001

			if var_81_11 <= arg_78_1.time_ and arg_78_1.time_ < var_81_11 + var_81_12 then
				local var_81_13 = (arg_78_1.time_ - var_81_11) / var_81_12
				local var_81_14 = Vector3.New(0.7, -0.66, -6.15)

				var_81_10.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1013ui_story, var_81_14, var_81_13)

				local var_81_15 = manager.ui.mainCamera.transform.position - var_81_10.position

				var_81_10.forward = Vector3.New(var_81_15.x, var_81_15.y, var_81_15.z)

				local var_81_16 = var_81_10.localEulerAngles

				var_81_16.z = 0
				var_81_16.x = 0
				var_81_10.localEulerAngles = var_81_16
			end

			if arg_78_1.time_ >= var_81_11 + var_81_12 and arg_78_1.time_ < var_81_11 + var_81_12 + arg_81_0 then
				var_81_10.localPosition = Vector3.New(0.7, -0.66, -6.15)

				local var_81_17 = manager.ui.mainCamera.transform.position - var_81_10.position

				var_81_10.forward = Vector3.New(var_81_17.x, var_81_17.y, var_81_17.z)

				local var_81_18 = var_81_10.localEulerAngles

				var_81_18.z = 0
				var_81_18.x = 0
				var_81_10.localEulerAngles = var_81_18
			end

			local var_81_19 = 0

			if var_81_19 < arg_78_1.time_ and arg_78_1.time_ <= var_81_19 + arg_81_0 then
				arg_78_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action4311")
			end

			local var_81_20 = 0

			if var_81_20 < arg_78_1.time_ and arg_78_1.time_ <= var_81_20 + arg_81_0 then
				arg_78_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_81_21 = 0
			local var_81_22 = 0.6

			if var_81_21 < arg_78_1.time_ and arg_78_1.time_ <= var_81_21 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_23 = arg_78_1:FormatText(StoryNameCfg[35].name)

				arg_78_1.leftNameTxt_.text = var_81_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_24 = arg_78_1:GetWordFromCfg(105071019)
				local var_81_25 = arg_78_1:FormatText(var_81_24.content)

				arg_78_1.text_.text = var_81_25

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_26 = 23
				local var_81_27 = utf8.len(var_81_25)
				local var_81_28 = var_81_26 <= 0 and var_81_22 or var_81_22 * (var_81_27 / var_81_26)

				if var_81_28 > 0 and var_81_22 < var_81_28 then
					arg_78_1.talkMaxDuration = var_81_28

					if var_81_28 + var_81_21 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_28 + var_81_21
					end
				end

				arg_78_1.text_.text = var_81_25
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071019", "story_v_out_105071.awb") ~= 0 then
					local var_81_29 = manager.audio:GetVoiceLength("story_v_out_105071", "105071019", "story_v_out_105071.awb") / 1000

					if var_81_29 + var_81_21 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_29 + var_81_21
					end

					if var_81_24.prefab_name ~= "" and arg_78_1.actors_[var_81_24.prefab_name] ~= nil then
						local var_81_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_24.prefab_name].transform, "story_v_out_105071", "105071019", "story_v_out_105071.awb")

						arg_78_1:RecordAudio("105071019", var_81_30)
						arg_78_1:RecordAudio("105071019", var_81_30)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_105071", "105071019", "story_v_out_105071.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_105071", "105071019", "story_v_out_105071.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_31 = math.max(var_81_22, arg_78_1.talkMaxDuration)

			if var_81_21 <= arg_78_1.time_ and arg_78_1.time_ < var_81_21 + var_81_31 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_21) / var_81_31

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_21 + var_81_31 and arg_78_1.time_ < var_81_21 + var_81_31 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play105071020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 105071020
		arg_82_1.duration_ = 2.2

		local var_82_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.2
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
				arg_82_0:Play105071021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["10002ui_story"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect10002ui_story == nil then
				arg_82_1.var_.characterEffect10002ui_story = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.1

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect10002ui_story and not isNil(var_85_0) then
					arg_82_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect10002ui_story then
				arg_82_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_85_4 = arg_82_1.actors_["1013ui_story"]
			local var_85_5 = 0

			if var_85_5 < arg_82_1.time_ and arg_82_1.time_ <= var_85_5 + arg_85_0 and not isNil(var_85_4) and arg_82_1.var_.characterEffect1013ui_story == nil then
				arg_82_1.var_.characterEffect1013ui_story = var_85_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_6 = 0.1

			if var_85_5 <= arg_82_1.time_ and arg_82_1.time_ < var_85_5 + var_85_6 and not isNil(var_85_4) then
				local var_85_7 = (arg_82_1.time_ - var_85_5) / var_85_6

				if arg_82_1.var_.characterEffect1013ui_story and not isNil(var_85_4) then
					local var_85_8 = Mathf.Lerp(0, 0.5, var_85_7)

					arg_82_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1013ui_story.fillRatio = var_85_8
				end
			end

			if arg_82_1.time_ >= var_85_5 + var_85_6 and arg_82_1.time_ < var_85_5 + var_85_6 + arg_85_0 and not isNil(var_85_4) and arg_82_1.var_.characterEffect1013ui_story then
				local var_85_9 = 0.5

				arg_82_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1013ui_story.fillRatio = var_85_9
			end

			local var_85_10 = 0

			if var_85_10 < arg_82_1.time_ and arg_82_1.time_ <= var_85_10 + arg_85_0 then
				arg_82_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_85_11 = 0
			local var_85_12 = 0.075

			if var_85_11 < arg_82_1.time_ and arg_82_1.time_ <= var_85_11 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_13 = arg_82_1:FormatText(StoryNameCfg[39].name)

				arg_82_1.leftNameTxt_.text = var_85_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_14 = arg_82_1:GetWordFromCfg(105071020)
				local var_85_15 = arg_82_1:FormatText(var_85_14.content)

				arg_82_1.text_.text = var_85_15

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_16 = 3
				local var_85_17 = utf8.len(var_85_15)
				local var_85_18 = var_85_16 <= 0 and var_85_12 or var_85_12 * (var_85_17 / var_85_16)

				if var_85_18 > 0 and var_85_12 < var_85_18 then
					arg_82_1.talkMaxDuration = var_85_18

					if var_85_18 + var_85_11 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_18 + var_85_11
					end
				end

				arg_82_1.text_.text = var_85_15
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071020", "story_v_out_105071.awb") ~= 0 then
					local var_85_19 = manager.audio:GetVoiceLength("story_v_out_105071", "105071020", "story_v_out_105071.awb") / 1000

					if var_85_19 + var_85_11 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_19 + var_85_11
					end

					if var_85_14.prefab_name ~= "" and arg_82_1.actors_[var_85_14.prefab_name] ~= nil then
						local var_85_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_14.prefab_name].transform, "story_v_out_105071", "105071020", "story_v_out_105071.awb")

						arg_82_1:RecordAudio("105071020", var_85_20)
						arg_82_1:RecordAudio("105071020", var_85_20)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_105071", "105071020", "story_v_out_105071.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_105071", "105071020", "story_v_out_105071.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_21 = math.max(var_85_12, arg_82_1.talkMaxDuration)

			if var_85_11 <= arg_82_1.time_ and arg_82_1.time_ < var_85_11 + var_85_21 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_11) / var_85_21

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_11 + var_85_21 and arg_82_1.time_ < var_85_11 + var_85_21 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play105071021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 105071021
		arg_86_1.duration_ = 5.83

		local var_86_0 = {
			ja = 5.366,
			ko = 4.2,
			zh = 5.833,
			en = 3.6
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
				arg_86_0:Play105071022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1013ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1013ui_story == nil then
				arg_86_1.var_.characterEffect1013ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.1

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect1013ui_story and not isNil(var_89_0) then
					arg_86_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1013ui_story then
				arg_86_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_89_4 = arg_86_1.actors_["10002ui_story"]
			local var_89_5 = 0

			if var_89_5 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect10002ui_story == nil then
				arg_86_1.var_.characterEffect10002ui_story = var_89_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_6 = 0.1

			if var_89_5 <= arg_86_1.time_ and arg_86_1.time_ < var_89_5 + var_89_6 and not isNil(var_89_4) then
				local var_89_7 = (arg_86_1.time_ - var_89_5) / var_89_6

				if arg_86_1.var_.characterEffect10002ui_story and not isNil(var_89_4) then
					local var_89_8 = Mathf.Lerp(0, 0.5, var_89_7)

					arg_86_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_86_1.var_.characterEffect10002ui_story.fillRatio = var_89_8
				end
			end

			if arg_86_1.time_ >= var_89_5 + var_89_6 and arg_86_1.time_ < var_89_5 + var_89_6 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect10002ui_story then
				local var_89_9 = 0.5

				arg_86_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_86_1.var_.characterEffect10002ui_story.fillRatio = var_89_9
			end

			local var_89_10 = arg_86_1.actors_["1013ui_story"].transform
			local var_89_11 = 0

			if var_89_11 < arg_86_1.time_ and arg_86_1.time_ <= var_89_11 + arg_89_0 then
				arg_86_1.var_.moveOldPos1013ui_story = var_89_10.localPosition
			end

			local var_89_12 = 0.001

			if var_89_11 <= arg_86_1.time_ and arg_86_1.time_ < var_89_11 + var_89_12 then
				local var_89_13 = (arg_86_1.time_ - var_89_11) / var_89_12
				local var_89_14 = Vector3.New(0.7, -0.66, -6.15)

				var_89_10.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1013ui_story, var_89_14, var_89_13)

				local var_89_15 = manager.ui.mainCamera.transform.position - var_89_10.position

				var_89_10.forward = Vector3.New(var_89_15.x, var_89_15.y, var_89_15.z)

				local var_89_16 = var_89_10.localEulerAngles

				var_89_16.z = 0
				var_89_16.x = 0
				var_89_10.localEulerAngles = var_89_16
			end

			if arg_86_1.time_ >= var_89_11 + var_89_12 and arg_86_1.time_ < var_89_11 + var_89_12 + arg_89_0 then
				var_89_10.localPosition = Vector3.New(0.7, -0.66, -6.15)

				local var_89_17 = manager.ui.mainCamera.transform.position - var_89_10.position

				var_89_10.forward = Vector3.New(var_89_17.x, var_89_17.y, var_89_17.z)

				local var_89_18 = var_89_10.localEulerAngles

				var_89_18.z = 0
				var_89_18.x = 0
				var_89_10.localEulerAngles = var_89_18
			end

			local var_89_19 = arg_86_1.actors_["1013ui_story"].transform
			local var_89_20 = 0.033

			if var_89_20 < arg_86_1.time_ and arg_86_1.time_ <= var_89_20 + arg_89_0 then
				arg_86_1.var_.moveOldPos1013ui_story = var_89_19.localPosition
			end

			local var_89_21 = 0.5

			if var_89_20 <= arg_86_1.time_ and arg_86_1.time_ < var_89_20 + var_89_21 then
				local var_89_22 = (arg_86_1.time_ - var_89_20) / var_89_21
				local var_89_23 = Vector3.New(0, -0.66, -6.15)

				var_89_19.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1013ui_story, var_89_23, var_89_22)

				local var_89_24 = manager.ui.mainCamera.transform.position - var_89_19.position

				var_89_19.forward = Vector3.New(var_89_24.x, var_89_24.y, var_89_24.z)

				local var_89_25 = var_89_19.localEulerAngles

				var_89_25.z = 0
				var_89_25.x = 0
				var_89_19.localEulerAngles = var_89_25
			end

			if arg_86_1.time_ >= var_89_20 + var_89_21 and arg_86_1.time_ < var_89_20 + var_89_21 + arg_89_0 then
				var_89_19.localPosition = Vector3.New(0, -0.66, -6.15)

				local var_89_26 = manager.ui.mainCamera.transform.position - var_89_19.position

				var_89_19.forward = Vector3.New(var_89_26.x, var_89_26.y, var_89_26.z)

				local var_89_27 = var_89_19.localEulerAngles

				var_89_27.z = 0
				var_89_27.x = 0
				var_89_19.localEulerAngles = var_89_27
			end

			local var_89_28 = 0

			if var_89_28 < arg_86_1.time_ and arg_86_1.time_ <= var_89_28 + arg_89_0 then
				arg_86_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action11_2")
			end

			local var_89_29 = arg_86_1.actors_["10002ui_story"].transform
			local var_89_30 = 0

			if var_89_30 < arg_86_1.time_ and arg_86_1.time_ <= var_89_30 + arg_89_0 then
				arg_86_1.var_.moveOldPos10002ui_story = var_89_29.localPosition
			end

			local var_89_31 = 0.001

			if var_89_30 <= arg_86_1.time_ and arg_86_1.time_ < var_89_30 + var_89_31 then
				local var_89_32 = (arg_86_1.time_ - var_89_30) / var_89_31
				local var_89_33 = Vector3.New(0, 100, 0)

				var_89_29.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10002ui_story, var_89_33, var_89_32)

				local var_89_34 = manager.ui.mainCamera.transform.position - var_89_29.position

				var_89_29.forward = Vector3.New(var_89_34.x, var_89_34.y, var_89_34.z)

				local var_89_35 = var_89_29.localEulerAngles

				var_89_35.z = 0
				var_89_35.x = 0
				var_89_29.localEulerAngles = var_89_35
			end

			if arg_86_1.time_ >= var_89_30 + var_89_31 and arg_86_1.time_ < var_89_30 + var_89_31 + arg_89_0 then
				var_89_29.localPosition = Vector3.New(0, 100, 0)

				local var_89_36 = manager.ui.mainCamera.transform.position - var_89_29.position

				var_89_29.forward = Vector3.New(var_89_36.x, var_89_36.y, var_89_36.z)

				local var_89_37 = var_89_29.localEulerAngles

				var_89_37.z = 0
				var_89_37.x = 0
				var_89_29.localEulerAngles = var_89_37
			end

			local var_89_38 = 0

			if var_89_38 < arg_86_1.time_ and arg_86_1.time_ <= var_89_38 + arg_89_0 then
				arg_86_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_89_39 = 0
			local var_89_40 = 0.45

			if var_89_39 < arg_86_1.time_ and arg_86_1.time_ <= var_89_39 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_41 = arg_86_1:FormatText(StoryNameCfg[35].name)

				arg_86_1.leftNameTxt_.text = var_89_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_42 = arg_86_1:GetWordFromCfg(105071021)
				local var_89_43 = arg_86_1:FormatText(var_89_42.content)

				arg_86_1.text_.text = var_89_43

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_44 = 18
				local var_89_45 = utf8.len(var_89_43)
				local var_89_46 = var_89_44 <= 0 and var_89_40 or var_89_40 * (var_89_45 / var_89_44)

				if var_89_46 > 0 and var_89_40 < var_89_46 then
					arg_86_1.talkMaxDuration = var_89_46

					if var_89_46 + var_89_39 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_46 + var_89_39
					end
				end

				arg_86_1.text_.text = var_89_43
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071021", "story_v_out_105071.awb") ~= 0 then
					local var_89_47 = manager.audio:GetVoiceLength("story_v_out_105071", "105071021", "story_v_out_105071.awb") / 1000

					if var_89_47 + var_89_39 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_47 + var_89_39
					end

					if var_89_42.prefab_name ~= "" and arg_86_1.actors_[var_89_42.prefab_name] ~= nil then
						local var_89_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_42.prefab_name].transform, "story_v_out_105071", "105071021", "story_v_out_105071.awb")

						arg_86_1:RecordAudio("105071021", var_89_48)
						arg_86_1:RecordAudio("105071021", var_89_48)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_105071", "105071021", "story_v_out_105071.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_105071", "105071021", "story_v_out_105071.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_49 = math.max(var_89_40, arg_86_1.talkMaxDuration)

			if var_89_39 <= arg_86_1.time_ and arg_86_1.time_ < var_89_39 + var_89_49 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_39) / var_89_49

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_39 + var_89_49 and arg_86_1.time_ < var_89_39 + var_89_49 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play105071022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 105071022
		arg_90_1.duration_ = 7.73

		local var_90_0 = {
			ja = 5.5,
			ko = 6.9,
			zh = 7.733,
			en = 5.3
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play105071023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action3_1")
			end

			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_93_2 = 0
			local var_93_3 = 0.6

			if var_93_2 < arg_90_1.time_ and arg_90_1.time_ <= var_93_2 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_4 = arg_90_1:FormatText(StoryNameCfg[35].name)

				arg_90_1.leftNameTxt_.text = var_93_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_5 = arg_90_1:GetWordFromCfg(105071022)
				local var_93_6 = arg_90_1:FormatText(var_93_5.content)

				arg_90_1.text_.text = var_93_6

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_7 = 24
				local var_93_8 = utf8.len(var_93_6)
				local var_93_9 = var_93_7 <= 0 and var_93_3 or var_93_3 * (var_93_8 / var_93_7)

				if var_93_9 > 0 and var_93_3 < var_93_9 then
					arg_90_1.talkMaxDuration = var_93_9

					if var_93_9 + var_93_2 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_9 + var_93_2
					end
				end

				arg_90_1.text_.text = var_93_6
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071022", "story_v_out_105071.awb") ~= 0 then
					local var_93_10 = manager.audio:GetVoiceLength("story_v_out_105071", "105071022", "story_v_out_105071.awb") / 1000

					if var_93_10 + var_93_2 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_10 + var_93_2
					end

					if var_93_5.prefab_name ~= "" and arg_90_1.actors_[var_93_5.prefab_name] ~= nil then
						local var_93_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_5.prefab_name].transform, "story_v_out_105071", "105071022", "story_v_out_105071.awb")

						arg_90_1:RecordAudio("105071022", var_93_11)
						arg_90_1:RecordAudio("105071022", var_93_11)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_105071", "105071022", "story_v_out_105071.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_105071", "105071022", "story_v_out_105071.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_12 = math.max(var_93_3, arg_90_1.talkMaxDuration)

			if var_93_2 <= arg_90_1.time_ and arg_90_1.time_ < var_93_2 + var_93_12 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_2) / var_93_12

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_2 + var_93_12 and arg_90_1.time_ < var_93_2 + var_93_12 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play105071023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 105071023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play105071024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 1

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				local var_97_2 = "play"
				local var_97_3 = "effect"

				arg_94_1:AudioAction(var_97_2, var_97_3, "se_story_5", "se_story_5_stone", "")
			end

			local var_97_4 = arg_94_1.actors_["1013ui_story"]
			local var_97_5 = 0

			if var_97_5 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect1013ui_story == nil then
				arg_94_1.var_.characterEffect1013ui_story = var_97_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_6 = 0.1

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_6 and not isNil(var_97_4) then
				local var_97_7 = (arg_94_1.time_ - var_97_5) / var_97_6

				if arg_94_1.var_.characterEffect1013ui_story and not isNil(var_97_4) then
					local var_97_8 = Mathf.Lerp(0, 0.5, var_97_7)

					arg_94_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1013ui_story.fillRatio = var_97_8
				end
			end

			if arg_94_1.time_ >= var_97_5 + var_97_6 and arg_94_1.time_ < var_97_5 + var_97_6 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect1013ui_story then
				local var_97_9 = 0.5

				arg_94_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1013ui_story.fillRatio = var_97_9
			end

			local var_97_10 = arg_94_1.actors_["1013ui_story"].transform
			local var_97_11 = 0

			if var_97_11 < arg_94_1.time_ and arg_94_1.time_ <= var_97_11 + arg_97_0 then
				arg_94_1.var_.moveOldPos1013ui_story = var_97_10.localPosition
			end

			local var_97_12 = 0.001

			if var_97_11 <= arg_94_1.time_ and arg_94_1.time_ < var_97_11 + var_97_12 then
				local var_97_13 = (arg_94_1.time_ - var_97_11) / var_97_12
				local var_97_14 = Vector3.New(0, 100, 0)

				var_97_10.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1013ui_story, var_97_14, var_97_13)

				local var_97_15 = manager.ui.mainCamera.transform.position - var_97_10.position

				var_97_10.forward = Vector3.New(var_97_15.x, var_97_15.y, var_97_15.z)

				local var_97_16 = var_97_10.localEulerAngles

				var_97_16.z = 0
				var_97_16.x = 0
				var_97_10.localEulerAngles = var_97_16
			end

			if arg_94_1.time_ >= var_97_11 + var_97_12 and arg_94_1.time_ < var_97_11 + var_97_12 + arg_97_0 then
				var_97_10.localPosition = Vector3.New(0, 100, 0)

				local var_97_17 = manager.ui.mainCamera.transform.position - var_97_10.position

				var_97_10.forward = Vector3.New(var_97_17.x, var_97_17.y, var_97_17.z)

				local var_97_18 = var_97_10.localEulerAngles

				var_97_18.z = 0
				var_97_18.x = 0
				var_97_10.localEulerAngles = var_97_18
			end

			local var_97_19 = 0
			local var_97_20 = 0.925

			if var_97_19 < arg_94_1.time_ and arg_94_1.time_ <= var_97_19 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_21 = arg_94_1:GetWordFromCfg(105071023)
				local var_97_22 = arg_94_1:FormatText(var_97_21.content)

				arg_94_1.text_.text = var_97_22

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_23 = 37
				local var_97_24 = utf8.len(var_97_22)
				local var_97_25 = var_97_23 <= 0 and var_97_20 or var_97_20 * (var_97_24 / var_97_23)

				if var_97_25 > 0 and var_97_20 < var_97_25 then
					arg_94_1.talkMaxDuration = var_97_25

					if var_97_25 + var_97_19 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_25 + var_97_19
					end
				end

				arg_94_1.text_.text = var_97_22
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_26 = math.max(var_97_20, arg_94_1.talkMaxDuration)

			if var_97_19 <= arg_94_1.time_ and arg_94_1.time_ < var_97_19 + var_97_26 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_19) / var_97_26

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_19 + var_97_26 and arg_94_1.time_ < var_97_19 + var_97_26 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play105071024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 105071024
		arg_98_1.duration_ = 6.9

		local var_98_0 = {
			ja = 6.9,
			ko = 2.7,
			zh = 3.7,
			en = 3.833
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
				arg_98_0:Play105071025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1013ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1013ui_story == nil then
				arg_98_1.var_.characterEffect1013ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.1

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect1013ui_story and not isNil(var_101_0) then
					arg_98_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1013ui_story then
				arg_98_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_101_4 = arg_98_1.actors_["1013ui_story"].transform
			local var_101_5 = 0

			if var_101_5 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 then
				arg_98_1.var_.moveOldPos1013ui_story = var_101_4.localPosition
			end

			local var_101_6 = 0.001

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_6 then
				local var_101_7 = (arg_98_1.time_ - var_101_5) / var_101_6
				local var_101_8 = Vector3.New(0, -0.66, -6.15)

				var_101_4.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1013ui_story, var_101_8, var_101_7)

				local var_101_9 = manager.ui.mainCamera.transform.position - var_101_4.position

				var_101_4.forward = Vector3.New(var_101_9.x, var_101_9.y, var_101_9.z)

				local var_101_10 = var_101_4.localEulerAngles

				var_101_10.z = 0
				var_101_10.x = 0
				var_101_4.localEulerAngles = var_101_10
			end

			if arg_98_1.time_ >= var_101_5 + var_101_6 and arg_98_1.time_ < var_101_5 + var_101_6 + arg_101_0 then
				var_101_4.localPosition = Vector3.New(0, -0.66, -6.15)

				local var_101_11 = manager.ui.mainCamera.transform.position - var_101_4.position

				var_101_4.forward = Vector3.New(var_101_11.x, var_101_11.y, var_101_11.z)

				local var_101_12 = var_101_4.localEulerAngles

				var_101_12.z = 0
				var_101_12.x = 0
				var_101_4.localEulerAngles = var_101_12
			end

			local var_101_13 = 0

			if var_101_13 < arg_98_1.time_ and arg_98_1.time_ <= var_101_13 + arg_101_0 then
				arg_98_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action2_1")
			end

			local var_101_14 = 0

			if var_101_14 < arg_98_1.time_ and arg_98_1.time_ <= var_101_14 + arg_101_0 then
				arg_98_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_101_15 = 0
			local var_101_16 = 0.35

			if var_101_15 < arg_98_1.time_ and arg_98_1.time_ <= var_101_15 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_17 = arg_98_1:FormatText(StoryNameCfg[35].name)

				arg_98_1.leftNameTxt_.text = var_101_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_18 = arg_98_1:GetWordFromCfg(105071024)
				local var_101_19 = arg_98_1:FormatText(var_101_18.content)

				arg_98_1.text_.text = var_101_19

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_20 = 14
				local var_101_21 = utf8.len(var_101_19)
				local var_101_22 = var_101_20 <= 0 and var_101_16 or var_101_16 * (var_101_21 / var_101_20)

				if var_101_22 > 0 and var_101_16 < var_101_22 then
					arg_98_1.talkMaxDuration = var_101_22

					if var_101_22 + var_101_15 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_22 + var_101_15
					end
				end

				arg_98_1.text_.text = var_101_19
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071024", "story_v_out_105071.awb") ~= 0 then
					local var_101_23 = manager.audio:GetVoiceLength("story_v_out_105071", "105071024", "story_v_out_105071.awb") / 1000

					if var_101_23 + var_101_15 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_23 + var_101_15
					end

					if var_101_18.prefab_name ~= "" and arg_98_1.actors_[var_101_18.prefab_name] ~= nil then
						local var_101_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_18.prefab_name].transform, "story_v_out_105071", "105071024", "story_v_out_105071.awb")

						arg_98_1:RecordAudio("105071024", var_101_24)
						arg_98_1:RecordAudio("105071024", var_101_24)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_105071", "105071024", "story_v_out_105071.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_105071", "105071024", "story_v_out_105071.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_25 = math.max(var_101_16, arg_98_1.talkMaxDuration)

			if var_101_15 <= arg_98_1.time_ and arg_98_1.time_ < var_101_15 + var_101_25 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_15) / var_101_25

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_15 + var_101_25 and arg_98_1.time_ < var_101_15 + var_101_25 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play105071025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 105071025
		arg_102_1.duration_ = 5.7

		local var_102_0 = {
			ja = 4.633,
			ko = 4.066,
			zh = 4.333,
			en = 5.7
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
				arg_102_0:Play105071026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["10002ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect10002ui_story == nil then
				arg_102_1.var_.characterEffect10002ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.1

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect10002ui_story and not isNil(var_105_0) then
					arg_102_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect10002ui_story then
				arg_102_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_105_4 = arg_102_1.actors_["1013ui_story"]
			local var_105_5 = 0

			if var_105_5 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect1013ui_story == nil then
				arg_102_1.var_.characterEffect1013ui_story = var_105_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_6 = 0.1

			if var_105_5 <= arg_102_1.time_ and arg_102_1.time_ < var_105_5 + var_105_6 and not isNil(var_105_4) then
				local var_105_7 = (arg_102_1.time_ - var_105_5) / var_105_6

				if arg_102_1.var_.characterEffect1013ui_story and not isNil(var_105_4) then
					local var_105_8 = Mathf.Lerp(0, 0.5, var_105_7)

					arg_102_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1013ui_story.fillRatio = var_105_8
				end
			end

			if arg_102_1.time_ >= var_105_5 + var_105_6 and arg_102_1.time_ < var_105_5 + var_105_6 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect1013ui_story then
				local var_105_9 = 0.5

				arg_102_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1013ui_story.fillRatio = var_105_9
			end

			local var_105_10 = arg_102_1.actors_["1013ui_story"].transform
			local var_105_11 = 0

			if var_105_11 < arg_102_1.time_ and arg_102_1.time_ <= var_105_11 + arg_105_0 then
				arg_102_1.var_.moveOldPos1013ui_story = var_105_10.localPosition
			end

			local var_105_12 = 0.001

			if var_105_11 <= arg_102_1.time_ and arg_102_1.time_ < var_105_11 + var_105_12 then
				local var_105_13 = (arg_102_1.time_ - var_105_11) / var_105_12
				local var_105_14 = Vector3.New(0, 100, 0)

				var_105_10.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1013ui_story, var_105_14, var_105_13)

				local var_105_15 = manager.ui.mainCamera.transform.position - var_105_10.position

				var_105_10.forward = Vector3.New(var_105_15.x, var_105_15.y, var_105_15.z)

				local var_105_16 = var_105_10.localEulerAngles

				var_105_16.z = 0
				var_105_16.x = 0
				var_105_10.localEulerAngles = var_105_16
			end

			if arg_102_1.time_ >= var_105_11 + var_105_12 and arg_102_1.time_ < var_105_11 + var_105_12 + arg_105_0 then
				var_105_10.localPosition = Vector3.New(0, 100, 0)

				local var_105_17 = manager.ui.mainCamera.transform.position - var_105_10.position

				var_105_10.forward = Vector3.New(var_105_17.x, var_105_17.y, var_105_17.z)

				local var_105_18 = var_105_10.localEulerAngles

				var_105_18.z = 0
				var_105_18.x = 0
				var_105_10.localEulerAngles = var_105_18
			end

			local var_105_19 = arg_102_1.actors_["10002ui_story"].transform
			local var_105_20 = 0

			if var_105_20 < arg_102_1.time_ and arg_102_1.time_ <= var_105_20 + arg_105_0 then
				arg_102_1.var_.moveOldPos10002ui_story = var_105_19.localPosition
			end

			local var_105_21 = 0.001

			if var_105_20 <= arg_102_1.time_ and arg_102_1.time_ < var_105_20 + var_105_21 then
				local var_105_22 = (arg_102_1.time_ - var_105_20) / var_105_21
				local var_105_23 = Vector3.New(0, -1.2, -5.8)

				var_105_19.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos10002ui_story, var_105_23, var_105_22)

				local var_105_24 = manager.ui.mainCamera.transform.position - var_105_19.position

				var_105_19.forward = Vector3.New(var_105_24.x, var_105_24.y, var_105_24.z)

				local var_105_25 = var_105_19.localEulerAngles

				var_105_25.z = 0
				var_105_25.x = 0
				var_105_19.localEulerAngles = var_105_25
			end

			if arg_102_1.time_ >= var_105_20 + var_105_21 and arg_102_1.time_ < var_105_20 + var_105_21 + arg_105_0 then
				var_105_19.localPosition = Vector3.New(0, -1.2, -5.8)

				local var_105_26 = manager.ui.mainCamera.transform.position - var_105_19.position

				var_105_19.forward = Vector3.New(var_105_26.x, var_105_26.y, var_105_26.z)

				local var_105_27 = var_105_19.localEulerAngles

				var_105_27.z = 0
				var_105_27.x = 0
				var_105_19.localEulerAngles = var_105_27
			end

			local var_105_28 = 0

			if var_105_28 < arg_102_1.time_ and arg_102_1.time_ <= var_105_28 + arg_105_0 then
				arg_102_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action1_1")
			end

			local var_105_29 = 0

			if var_105_29 < arg_102_1.time_ and arg_102_1.time_ <= var_105_29 + arg_105_0 then
				arg_102_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_105_30 = 0
			local var_105_31 = 0.3

			if var_105_30 < arg_102_1.time_ and arg_102_1.time_ <= var_105_30 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_32 = arg_102_1:FormatText(StoryNameCfg[39].name)

				arg_102_1.leftNameTxt_.text = var_105_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_33 = arg_102_1:GetWordFromCfg(105071025)
				local var_105_34 = arg_102_1:FormatText(var_105_33.content)

				arg_102_1.text_.text = var_105_34

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_35 = 12
				local var_105_36 = utf8.len(var_105_34)
				local var_105_37 = var_105_35 <= 0 and var_105_31 or var_105_31 * (var_105_36 / var_105_35)

				if var_105_37 > 0 and var_105_31 < var_105_37 then
					arg_102_1.talkMaxDuration = var_105_37

					if var_105_37 + var_105_30 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_37 + var_105_30
					end
				end

				arg_102_1.text_.text = var_105_34
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071025", "story_v_out_105071.awb") ~= 0 then
					local var_105_38 = manager.audio:GetVoiceLength("story_v_out_105071", "105071025", "story_v_out_105071.awb") / 1000

					if var_105_38 + var_105_30 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_38 + var_105_30
					end

					if var_105_33.prefab_name ~= "" and arg_102_1.actors_[var_105_33.prefab_name] ~= nil then
						local var_105_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_33.prefab_name].transform, "story_v_out_105071", "105071025", "story_v_out_105071.awb")

						arg_102_1:RecordAudio("105071025", var_105_39)
						arg_102_1:RecordAudio("105071025", var_105_39)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_105071", "105071025", "story_v_out_105071.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_105071", "105071025", "story_v_out_105071.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_40 = math.max(var_105_31, arg_102_1.talkMaxDuration)

			if var_105_30 <= arg_102_1.time_ and arg_102_1.time_ < var_105_30 + var_105_40 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_30) / var_105_40

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_30 + var_105_40 and arg_102_1.time_ < var_105_30 + var_105_40 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play105071026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 105071026
		arg_106_1.duration_ = 9.7

		local var_106_0 = {
			ja = 9.7,
			ko = 3.866,
			zh = 4.333,
			en = 5.2
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
				arg_106_0:Play105071027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 1

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				local var_109_2 = "play"
				local var_109_3 = "effect"

				arg_106_1:AudioAction(var_109_2, var_109_3, "se_story", "se_story_robot_short", "")
			end

			local var_109_4 = "3005_tpose"

			if arg_106_1.actors_[var_109_4] == nil then
				local var_109_5 = Asset.Load("Char/" .. "3005_tpose")

				if not isNil(var_109_5) then
					local var_109_6 = Object.Instantiate(Asset.Load("Char/" .. "3005_tpose"), arg_106_1.stage_.transform)

					var_109_6.name = var_109_4
					var_109_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_106_1.actors_[var_109_4] = var_109_6

					local var_109_7 = var_109_6:GetComponentInChildren(typeof(CharacterEffect))

					var_109_7.enabled = true

					local var_109_8 = GameObjectTools.GetOrAddComponent(var_109_6, typeof(DynamicBoneHelper))

					if var_109_8 then
						var_109_8:EnableDynamicBone(false)
					end

					arg_106_1:ShowWeapon(var_109_7.transform, false)

					arg_106_1.var_[var_109_4 .. "Animator"] = var_109_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_106_1.var_[var_109_4 .. "Animator"].applyRootMotion = true
					arg_106_1.var_[var_109_4 .. "LipSync"] = var_109_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_109_9 = arg_106_1.actors_["3005_tpose"]
			local var_109_10 = 0

			if var_109_10 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect3005_tpose == nil then
				arg_106_1.var_.characterEffect3005_tpose = var_109_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_11 = 0.1

			if var_109_10 <= arg_106_1.time_ and arg_106_1.time_ < var_109_10 + var_109_11 and not isNil(var_109_9) then
				local var_109_12 = (arg_106_1.time_ - var_109_10) / var_109_11

				if arg_106_1.var_.characterEffect3005_tpose and not isNil(var_109_9) then
					arg_106_1.var_.characterEffect3005_tpose.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_10 + var_109_11 and arg_106_1.time_ < var_109_10 + var_109_11 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect3005_tpose then
				arg_106_1.var_.characterEffect3005_tpose.fillFlat = false
			end

			local var_109_13 = arg_106_1.actors_["10002ui_story"]
			local var_109_14 = 0

			if var_109_14 < arg_106_1.time_ and arg_106_1.time_ <= var_109_14 + arg_109_0 and not isNil(var_109_13) and arg_106_1.var_.characterEffect10002ui_story == nil then
				arg_106_1.var_.characterEffect10002ui_story = var_109_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_15 = 0.1

			if var_109_14 <= arg_106_1.time_ and arg_106_1.time_ < var_109_14 + var_109_15 and not isNil(var_109_13) then
				local var_109_16 = (arg_106_1.time_ - var_109_14) / var_109_15

				if arg_106_1.var_.characterEffect10002ui_story and not isNil(var_109_13) then
					local var_109_17 = Mathf.Lerp(0, 0.5, var_109_16)

					arg_106_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_106_1.var_.characterEffect10002ui_story.fillRatio = var_109_17
				end
			end

			if arg_106_1.time_ >= var_109_14 + var_109_15 and arg_106_1.time_ < var_109_14 + var_109_15 + arg_109_0 and not isNil(var_109_13) and arg_106_1.var_.characterEffect10002ui_story then
				local var_109_18 = 0.5

				arg_106_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_106_1.var_.characterEffect10002ui_story.fillRatio = var_109_18
			end

			local var_109_19 = arg_106_1.actors_["10002ui_story"].transform
			local var_109_20 = 0

			if var_109_20 < arg_106_1.time_ and arg_106_1.time_ <= var_109_20 + arg_109_0 then
				arg_106_1.var_.moveOldPos10002ui_story = var_109_19.localPosition
			end

			local var_109_21 = 0.001

			if var_109_20 <= arg_106_1.time_ and arg_106_1.time_ < var_109_20 + var_109_21 then
				local var_109_22 = (arg_106_1.time_ - var_109_20) / var_109_21
				local var_109_23 = Vector3.New(0, 100, 0)

				var_109_19.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos10002ui_story, var_109_23, var_109_22)

				local var_109_24 = manager.ui.mainCamera.transform.position - var_109_19.position

				var_109_19.forward = Vector3.New(var_109_24.x, var_109_24.y, var_109_24.z)

				local var_109_25 = var_109_19.localEulerAngles

				var_109_25.z = 0
				var_109_25.x = 0
				var_109_19.localEulerAngles = var_109_25
			end

			if arg_106_1.time_ >= var_109_20 + var_109_21 and arg_106_1.time_ < var_109_20 + var_109_21 + arg_109_0 then
				var_109_19.localPosition = Vector3.New(0, 100, 0)

				local var_109_26 = manager.ui.mainCamera.transform.position - var_109_19.position

				var_109_19.forward = Vector3.New(var_109_26.x, var_109_26.y, var_109_26.z)

				local var_109_27 = var_109_19.localEulerAngles

				var_109_27.z = 0
				var_109_27.x = 0
				var_109_19.localEulerAngles = var_109_27
			end

			local var_109_28 = arg_106_1.actors_["3005_tpose"].transform
			local var_109_29 = 0

			if var_109_29 < arg_106_1.time_ and arg_106_1.time_ <= var_109_29 + arg_109_0 then
				arg_106_1.var_.moveOldPos3005_tpose = var_109_28.localPosition

				local var_109_30 = GameObjectTools.GetOrAddComponent(var_109_28.gameObject, typeof(DynamicBoneHelper))

				if var_109_30 then
					var_109_30:EnableDynamicBone(false)
				end
			end

			local var_109_31 = 0.001

			if var_109_29 <= arg_106_1.time_ and arg_106_1.time_ < var_109_29 + var_109_31 then
				local var_109_32 = (arg_106_1.time_ - var_109_29) / var_109_31
				local var_109_33 = Vector3.New(-0.7, -1.95, -3.4)

				var_109_28.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos3005_tpose, var_109_33, var_109_32)

				local var_109_34 = manager.ui.mainCamera.transform.position - var_109_28.position

				var_109_28.forward = Vector3.New(var_109_34.x, var_109_34.y, var_109_34.z)

				local var_109_35 = var_109_28.localEulerAngles

				var_109_35.z = 0
				var_109_35.x = 0
				var_109_28.localEulerAngles = var_109_35
			end

			if arg_106_1.time_ >= var_109_29 + var_109_31 and arg_106_1.time_ < var_109_29 + var_109_31 + arg_109_0 then
				var_109_28.localPosition = Vector3.New(-0.7, -1.95, -3.4)

				local var_109_36 = manager.ui.mainCamera.transform.position - var_109_28.position

				var_109_28.forward = Vector3.New(var_109_36.x, var_109_36.y, var_109_36.z)

				local var_109_37 = var_109_28.localEulerAngles

				var_109_37.z = 0
				var_109_37.x = 0
				var_109_28.localEulerAngles = var_109_37

				local var_109_38 = GameObjectTools.GetOrAddComponent(var_109_28.gameObject, typeof(DynamicBoneHelper))

				if var_109_38 then
					var_109_38:EnableDynamicBone(true)
				end
			end

			local var_109_39 = 0

			if var_109_39 < arg_106_1.time_ and arg_106_1.time_ <= var_109_39 + arg_109_0 then
				arg_106_1:PlayTimeline("3005_tpose", "StoryTimeline/CharAction/story3005/story3005action/3005action1_1")
			end

			local var_109_40 = 0
			local var_109_41 = 0.35

			if var_109_40 < arg_106_1.time_ and arg_106_1.time_ <= var_109_40 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_42 = arg_106_1:FormatText(StoryNameCfg[69].name)

				arg_106_1.leftNameTxt_.text = var_109_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_43 = arg_106_1:GetWordFromCfg(105071026)
				local var_109_44 = arg_106_1:FormatText(var_109_43.content)

				arg_106_1.text_.text = var_109_44

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_45 = 14
				local var_109_46 = utf8.len(var_109_44)
				local var_109_47 = var_109_45 <= 0 and var_109_41 or var_109_41 * (var_109_46 / var_109_45)

				if var_109_47 > 0 and var_109_41 < var_109_47 then
					arg_106_1.talkMaxDuration = var_109_47

					if var_109_47 + var_109_40 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_47 + var_109_40
					end
				end

				arg_106_1.text_.text = var_109_44
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071026", "story_v_out_105071.awb") ~= 0 then
					local var_109_48 = manager.audio:GetVoiceLength("story_v_out_105071", "105071026", "story_v_out_105071.awb") / 1000

					if var_109_48 + var_109_40 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_48 + var_109_40
					end

					if var_109_43.prefab_name ~= "" and arg_106_1.actors_[var_109_43.prefab_name] ~= nil then
						local var_109_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_43.prefab_name].transform, "story_v_out_105071", "105071026", "story_v_out_105071.awb")

						arg_106_1:RecordAudio("105071026", var_109_49)
						arg_106_1:RecordAudio("105071026", var_109_49)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_105071", "105071026", "story_v_out_105071.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_105071", "105071026", "story_v_out_105071.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_50 = math.max(var_109_41, arg_106_1.talkMaxDuration)

			if var_109_40 <= arg_106_1.time_ and arg_106_1.time_ < var_109_40 + var_109_50 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_40) / var_109_50

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_40 + var_109_50 and arg_106_1.time_ < var_109_40 + var_109_50 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3005_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play105071027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 105071027
		arg_110_1.duration_ = 5.43

		local var_110_0 = {
			ja = 4.3,
			ko = 2.5,
			zh = 5.433,
			en = 5
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
				arg_110_0:Play105071028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 1

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				local var_113_2 = "play"
				local var_113_3 = "effect"

				arg_110_1:AudioAction(var_113_2, var_113_3, "se_story", "se_story_robot_short", "")
			end

			local var_113_4 = "2043_tpose"

			if arg_110_1.actors_[var_113_4] == nil then
				local var_113_5 = Asset.Load("Char/" .. "2043_tpose")

				if not isNil(var_113_5) then
					local var_113_6 = Object.Instantiate(Asset.Load("Char/" .. "2043_tpose"), arg_110_1.stage_.transform)

					var_113_6.name = var_113_4
					var_113_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_110_1.actors_[var_113_4] = var_113_6

					local var_113_7 = var_113_6:GetComponentInChildren(typeof(CharacterEffect))

					var_113_7.enabled = true

					local var_113_8 = GameObjectTools.GetOrAddComponent(var_113_6, typeof(DynamicBoneHelper))

					if var_113_8 then
						var_113_8:EnableDynamicBone(false)
					end

					arg_110_1:ShowWeapon(var_113_7.transform, false)

					arg_110_1.var_[var_113_4 .. "Animator"] = var_113_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_110_1.var_[var_113_4 .. "Animator"].applyRootMotion = true
					arg_110_1.var_[var_113_4 .. "LipSync"] = var_113_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_113_9 = arg_110_1.actors_["2043_tpose"]
			local var_113_10 = 0

			if var_113_10 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 and not isNil(var_113_9) and arg_110_1.var_.characterEffect2043_tpose == nil then
				arg_110_1.var_.characterEffect2043_tpose = var_113_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_11 = 0.1

			if var_113_10 <= arg_110_1.time_ and arg_110_1.time_ < var_113_10 + var_113_11 and not isNil(var_113_9) then
				local var_113_12 = (arg_110_1.time_ - var_113_10) / var_113_11

				if arg_110_1.var_.characterEffect2043_tpose and not isNil(var_113_9) then
					arg_110_1.var_.characterEffect2043_tpose.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_10 + var_113_11 and arg_110_1.time_ < var_113_10 + var_113_11 + arg_113_0 and not isNil(var_113_9) and arg_110_1.var_.characterEffect2043_tpose then
				arg_110_1.var_.characterEffect2043_tpose.fillFlat = false
			end

			local var_113_13 = arg_110_1.actors_["3005_tpose"]
			local var_113_14 = 0

			if var_113_14 < arg_110_1.time_ and arg_110_1.time_ <= var_113_14 + arg_113_0 and not isNil(var_113_13) and arg_110_1.var_.characterEffect3005_tpose == nil then
				arg_110_1.var_.characterEffect3005_tpose = var_113_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_15 = 0.1

			if var_113_14 <= arg_110_1.time_ and arg_110_1.time_ < var_113_14 + var_113_15 and not isNil(var_113_13) then
				local var_113_16 = (arg_110_1.time_ - var_113_14) / var_113_15

				if arg_110_1.var_.characterEffect3005_tpose and not isNil(var_113_13) then
					local var_113_17 = Mathf.Lerp(0, 0.5, var_113_16)

					arg_110_1.var_.characterEffect3005_tpose.fillFlat = true
					arg_110_1.var_.characterEffect3005_tpose.fillRatio = var_113_17
				end
			end

			if arg_110_1.time_ >= var_113_14 + var_113_15 and arg_110_1.time_ < var_113_14 + var_113_15 + arg_113_0 and not isNil(var_113_13) and arg_110_1.var_.characterEffect3005_tpose then
				local var_113_18 = 0.5

				arg_110_1.var_.characterEffect3005_tpose.fillFlat = true
				arg_110_1.var_.characterEffect3005_tpose.fillRatio = var_113_18
			end

			local var_113_19 = arg_110_1.actors_["2043_tpose"].transform
			local var_113_20 = 0

			if var_113_20 < arg_110_1.time_ and arg_110_1.time_ <= var_113_20 + arg_113_0 then
				arg_110_1.var_.moveOldPos2043_tpose = var_113_19.localPosition

				local var_113_21 = GameObjectTools.GetOrAddComponent(var_113_19.gameObject, typeof(DynamicBoneHelper))

				if var_113_21 then
					var_113_21:EnableDynamicBone(false)
				end
			end

			local var_113_22 = 0.001

			if var_113_20 <= arg_110_1.time_ and arg_110_1.time_ < var_113_20 + var_113_22 then
				local var_113_23 = (arg_110_1.time_ - var_113_20) / var_113_22
				local var_113_24 = Vector3.New(0.7, -0.95, -2)

				var_113_19.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos2043_tpose, var_113_24, var_113_23)

				local var_113_25 = manager.ui.mainCamera.transform.position - var_113_19.position

				var_113_19.forward = Vector3.New(var_113_25.x, var_113_25.y, var_113_25.z)

				local var_113_26 = var_113_19.localEulerAngles

				var_113_26.z = 0
				var_113_26.x = 0
				var_113_19.localEulerAngles = var_113_26
			end

			if arg_110_1.time_ >= var_113_20 + var_113_22 and arg_110_1.time_ < var_113_20 + var_113_22 + arg_113_0 then
				var_113_19.localPosition = Vector3.New(0.7, -0.95, -2)

				local var_113_27 = manager.ui.mainCamera.transform.position - var_113_19.position

				var_113_19.forward = Vector3.New(var_113_27.x, var_113_27.y, var_113_27.z)

				local var_113_28 = var_113_19.localEulerAngles

				var_113_28.z = 0
				var_113_28.x = 0
				var_113_19.localEulerAngles = var_113_28

				local var_113_29 = GameObjectTools.GetOrAddComponent(var_113_19.gameObject, typeof(DynamicBoneHelper))

				if var_113_29 then
					var_113_29:EnableDynamicBone(true)
				end
			end

			local var_113_30 = 0

			if var_113_30 < arg_110_1.time_ and arg_110_1.time_ <= var_113_30 + arg_113_0 then
				arg_110_1:PlayTimeline("2043_tpose", "StoryTimeline/CharAction/story2043/story2043action/2043action1_1")
			end

			local var_113_31 = 0
			local var_113_32 = 0.3

			if var_113_31 < arg_110_1.time_ and arg_110_1.time_ <= var_113_31 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_33 = arg_110_1:FormatText(StoryNameCfg[69].name)

				arg_110_1.leftNameTxt_.text = var_113_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_34 = arg_110_1:GetWordFromCfg(105071027)
				local var_113_35 = arg_110_1:FormatText(var_113_34.content)

				arg_110_1.text_.text = var_113_35

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_36 = 12
				local var_113_37 = utf8.len(var_113_35)
				local var_113_38 = var_113_36 <= 0 and var_113_32 or var_113_32 * (var_113_37 / var_113_36)

				if var_113_38 > 0 and var_113_32 < var_113_38 then
					arg_110_1.talkMaxDuration = var_113_38

					if var_113_38 + var_113_31 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_38 + var_113_31
					end
				end

				arg_110_1.text_.text = var_113_35
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071027", "story_v_out_105071.awb") ~= 0 then
					local var_113_39 = manager.audio:GetVoiceLength("story_v_out_105071", "105071027", "story_v_out_105071.awb") / 1000

					if var_113_39 + var_113_31 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_39 + var_113_31
					end

					if var_113_34.prefab_name ~= "" and arg_110_1.actors_[var_113_34.prefab_name] ~= nil then
						local var_113_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_34.prefab_name].transform, "story_v_out_105071", "105071027", "story_v_out_105071.awb")

						arg_110_1:RecordAudio("105071027", var_113_40)
						arg_110_1:RecordAudio("105071027", var_113_40)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_105071", "105071027", "story_v_out_105071.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_105071", "105071027", "story_v_out_105071.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_41 = math.max(var_113_32, arg_110_1.talkMaxDuration)

			if var_113_31 <= arg_110_1.time_ and arg_110_1.time_ < var_113_31 + var_113_41 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_31) / var_113_41

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_31 + var_113_41 and arg_110_1.time_ < var_113_31 + var_113_41 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2043_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play105071028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 105071028
		arg_114_1.duration_ = 8.17

		local var_114_0 = {
			ja = 8.166,
			ko = 5.1,
			zh = 6.1,
			en = 6.866
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
				arg_114_0:Play105071029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1013ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1013ui_story == nil then
				arg_114_1.var_.characterEffect1013ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.1

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect1013ui_story and not isNil(var_117_0) then
					arg_114_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1013ui_story then
				arg_114_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_117_4 = arg_114_1.actors_["2043_tpose"]
			local var_117_5 = 0

			if var_117_5 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect2043_tpose == nil then
				arg_114_1.var_.characterEffect2043_tpose = var_117_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_6 = 0.1

			if var_117_5 <= arg_114_1.time_ and arg_114_1.time_ < var_117_5 + var_117_6 and not isNil(var_117_4) then
				local var_117_7 = (arg_114_1.time_ - var_117_5) / var_117_6

				if arg_114_1.var_.characterEffect2043_tpose and not isNil(var_117_4) then
					local var_117_8 = Mathf.Lerp(0, 0.5, var_117_7)

					arg_114_1.var_.characterEffect2043_tpose.fillFlat = true
					arg_114_1.var_.characterEffect2043_tpose.fillRatio = var_117_8
				end
			end

			if arg_114_1.time_ >= var_117_5 + var_117_6 and arg_114_1.time_ < var_117_5 + var_117_6 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect2043_tpose then
				local var_117_9 = 0.5

				arg_114_1.var_.characterEffect2043_tpose.fillFlat = true
				arg_114_1.var_.characterEffect2043_tpose.fillRatio = var_117_9
			end

			local var_117_10 = arg_114_1.actors_["3005_tpose"].transform
			local var_117_11 = 0

			if var_117_11 < arg_114_1.time_ and arg_114_1.time_ <= var_117_11 + arg_117_0 then
				arg_114_1.var_.moveOldPos3005_tpose = var_117_10.localPosition

				local var_117_12 = GameObjectTools.GetOrAddComponent(var_117_10.gameObject, typeof(DynamicBoneHelper))

				if var_117_12 then
					var_117_12:EnableDynamicBone(false)
				end
			end

			local var_117_13 = 0.001

			if var_117_11 <= arg_114_1.time_ and arg_114_1.time_ < var_117_11 + var_117_13 then
				local var_117_14 = (arg_114_1.time_ - var_117_11) / var_117_13
				local var_117_15 = Vector3.New(0, 100, 0)

				var_117_10.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos3005_tpose, var_117_15, var_117_14)

				local var_117_16 = manager.ui.mainCamera.transform.position - var_117_10.position

				var_117_10.forward = Vector3.New(var_117_16.x, var_117_16.y, var_117_16.z)

				local var_117_17 = var_117_10.localEulerAngles

				var_117_17.z = 0
				var_117_17.x = 0
				var_117_10.localEulerAngles = var_117_17
			end

			if arg_114_1.time_ >= var_117_11 + var_117_13 and arg_114_1.time_ < var_117_11 + var_117_13 + arg_117_0 then
				var_117_10.localPosition = Vector3.New(0, 100, 0)

				local var_117_18 = manager.ui.mainCamera.transform.position - var_117_10.position

				var_117_10.forward = Vector3.New(var_117_18.x, var_117_18.y, var_117_18.z)

				local var_117_19 = var_117_10.localEulerAngles

				var_117_19.z = 0
				var_117_19.x = 0
				var_117_10.localEulerAngles = var_117_19

				local var_117_20 = GameObjectTools.GetOrAddComponent(var_117_10.gameObject, typeof(DynamicBoneHelper))

				if var_117_20 then
					var_117_20:EnableDynamicBone(true)
				end
			end

			local var_117_21 = arg_114_1.actors_["2043_tpose"].transform
			local var_117_22 = 0

			if var_117_22 < arg_114_1.time_ and arg_114_1.time_ <= var_117_22 + arg_117_0 then
				arg_114_1.var_.moveOldPos2043_tpose = var_117_21.localPosition

				local var_117_23 = GameObjectTools.GetOrAddComponent(var_117_21.gameObject, typeof(DynamicBoneHelper))

				if var_117_23 then
					var_117_23:EnableDynamicBone(false)
				end
			end

			local var_117_24 = 0.001

			if var_117_22 <= arg_114_1.time_ and arg_114_1.time_ < var_117_22 + var_117_24 then
				local var_117_25 = (arg_114_1.time_ - var_117_22) / var_117_24
				local var_117_26 = Vector3.New(0, 100, 0)

				var_117_21.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos2043_tpose, var_117_26, var_117_25)

				local var_117_27 = manager.ui.mainCamera.transform.position - var_117_21.position

				var_117_21.forward = Vector3.New(var_117_27.x, var_117_27.y, var_117_27.z)

				local var_117_28 = var_117_21.localEulerAngles

				var_117_28.z = 0
				var_117_28.x = 0
				var_117_21.localEulerAngles = var_117_28
			end

			if arg_114_1.time_ >= var_117_22 + var_117_24 and arg_114_1.time_ < var_117_22 + var_117_24 + arg_117_0 then
				var_117_21.localPosition = Vector3.New(0, 100, 0)

				local var_117_29 = manager.ui.mainCamera.transform.position - var_117_21.position

				var_117_21.forward = Vector3.New(var_117_29.x, var_117_29.y, var_117_29.z)

				local var_117_30 = var_117_21.localEulerAngles

				var_117_30.z = 0
				var_117_30.x = 0
				var_117_21.localEulerAngles = var_117_30

				local var_117_31 = GameObjectTools.GetOrAddComponent(var_117_21.gameObject, typeof(DynamicBoneHelper))

				if var_117_31 then
					var_117_31:EnableDynamicBone(true)
				end
			end

			local var_117_32 = arg_114_1.actors_["1013ui_story"].transform
			local var_117_33 = 0

			if var_117_33 < arg_114_1.time_ and arg_114_1.time_ <= var_117_33 + arg_117_0 then
				arg_114_1.var_.moveOldPos1013ui_story = var_117_32.localPosition
			end

			local var_117_34 = 0.001

			if var_117_33 <= arg_114_1.time_ and arg_114_1.time_ < var_117_33 + var_117_34 then
				local var_117_35 = (arg_114_1.time_ - var_117_33) / var_117_34
				local var_117_36 = Vector3.New(0, -0.66, -6.15)

				var_117_32.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1013ui_story, var_117_36, var_117_35)

				local var_117_37 = manager.ui.mainCamera.transform.position - var_117_32.position

				var_117_32.forward = Vector3.New(var_117_37.x, var_117_37.y, var_117_37.z)

				local var_117_38 = var_117_32.localEulerAngles

				var_117_38.z = 0
				var_117_38.x = 0
				var_117_32.localEulerAngles = var_117_38
			end

			if arg_114_1.time_ >= var_117_33 + var_117_34 and arg_114_1.time_ < var_117_33 + var_117_34 + arg_117_0 then
				var_117_32.localPosition = Vector3.New(0, -0.66, -6.15)

				local var_117_39 = manager.ui.mainCamera.transform.position - var_117_32.position

				var_117_32.forward = Vector3.New(var_117_39.x, var_117_39.y, var_117_39.z)

				local var_117_40 = var_117_32.localEulerAngles

				var_117_40.z = 0
				var_117_40.x = 0
				var_117_32.localEulerAngles = var_117_40
			end

			local var_117_41 = 0

			if var_117_41 < arg_114_1.time_ and arg_114_1.time_ <= var_117_41 + arg_117_0 then
				arg_114_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action4_1")
			end

			local var_117_42 = 0

			if var_117_42 < arg_114_1.time_ and arg_114_1.time_ <= var_117_42 + arg_117_0 then
				arg_114_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_117_43 = 0
			local var_117_44 = 0.55

			if var_117_43 < arg_114_1.time_ and arg_114_1.time_ <= var_117_43 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_45 = arg_114_1:FormatText(StoryNameCfg[35].name)

				arg_114_1.leftNameTxt_.text = var_117_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_46 = arg_114_1:GetWordFromCfg(105071028)
				local var_117_47 = arg_114_1:FormatText(var_117_46.content)

				arg_114_1.text_.text = var_117_47

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_48 = 22
				local var_117_49 = utf8.len(var_117_47)
				local var_117_50 = var_117_48 <= 0 and var_117_44 or var_117_44 * (var_117_49 / var_117_48)

				if var_117_50 > 0 and var_117_44 < var_117_50 then
					arg_114_1.talkMaxDuration = var_117_50

					if var_117_50 + var_117_43 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_50 + var_117_43
					end
				end

				arg_114_1.text_.text = var_117_47
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071028", "story_v_out_105071.awb") ~= 0 then
					local var_117_51 = manager.audio:GetVoiceLength("story_v_out_105071", "105071028", "story_v_out_105071.awb") / 1000

					if var_117_51 + var_117_43 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_51 + var_117_43
					end

					if var_117_46.prefab_name ~= "" and arg_114_1.actors_[var_117_46.prefab_name] ~= nil then
						local var_117_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_46.prefab_name].transform, "story_v_out_105071", "105071028", "story_v_out_105071.awb")

						arg_114_1:RecordAudio("105071028", var_117_52)
						arg_114_1:RecordAudio("105071028", var_117_52)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_105071", "105071028", "story_v_out_105071.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_105071", "105071028", "story_v_out_105071.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_53 = math.max(var_117_44, arg_114_1.talkMaxDuration)

			if var_117_43 <= arg_114_1.time_ and arg_114_1.time_ < var_117_43 + var_117_53 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_43) / var_117_53

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_43 + var_117_53 and arg_114_1.time_ < var_117_43 + var_117_53 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3005_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2043_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play105071029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 105071029
		arg_118_1.duration_ = 9

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play105071030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1013ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1013ui_story == nil then
				arg_118_1.var_.characterEffect1013ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.1

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect1013ui_story and not isNil(var_121_0) then
					local var_121_4 = Mathf.Lerp(0, 0.5, var_121_3)

					arg_118_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1013ui_story.fillRatio = var_121_4
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1013ui_story then
				local var_121_5 = 0.5

				arg_118_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1013ui_story.fillRatio = var_121_5
			end

			local var_121_6 = arg_118_1.actors_["1013ui_story"].transform
			local var_121_7 = 0

			if var_121_7 < arg_118_1.time_ and arg_118_1.time_ <= var_121_7 + arg_121_0 then
				arg_118_1.var_.moveOldPos1013ui_story = var_121_6.localPosition
			end

			local var_121_8 = 0.001

			if var_121_7 <= arg_118_1.time_ and arg_118_1.time_ < var_121_7 + var_121_8 then
				local var_121_9 = (arg_118_1.time_ - var_121_7) / var_121_8
				local var_121_10 = Vector3.New(10, -0.78, -5.4)

				var_121_6.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1013ui_story, var_121_10, var_121_9)

				local var_121_11 = manager.ui.mainCamera.transform.position - var_121_6.position

				var_121_6.forward = Vector3.New(var_121_11.x, var_121_11.y, var_121_11.z)

				local var_121_12 = var_121_6.localEulerAngles

				var_121_12.z = 0
				var_121_12.x = 0
				var_121_6.localEulerAngles = var_121_12
			end

			if arg_118_1.time_ >= var_121_7 + var_121_8 and arg_118_1.time_ < var_121_7 + var_121_8 + arg_121_0 then
				var_121_6.localPosition = Vector3.New(10, -0.78, -5.4)

				local var_121_13 = manager.ui.mainCamera.transform.position - var_121_6.position

				var_121_6.forward = Vector3.New(var_121_13.x, var_121_13.y, var_121_13.z)

				local var_121_14 = var_121_6.localEulerAngles

				var_121_14.z = 0
				var_121_14.x = 0
				var_121_6.localEulerAngles = var_121_14
			end

			local var_121_15 = 0

			if var_121_15 < arg_118_1.time_ and arg_118_1.time_ <= var_121_15 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_16 = 2

			if var_121_15 <= arg_118_1.time_ and arg_118_1.time_ < var_121_15 + var_121_16 then
				local var_121_17 = (arg_118_1.time_ - var_121_15) / var_121_16
				local var_121_18 = Color.New(0, 0, 0)

				var_121_18.a = Mathf.Lerp(0, 1, var_121_17)
				arg_118_1.mask_.color = var_121_18
			end

			if arg_118_1.time_ >= var_121_15 + var_121_16 and arg_118_1.time_ < var_121_15 + var_121_16 + arg_121_0 then
				local var_121_19 = Color.New(0, 0, 0)

				var_121_19.a = 1
				arg_118_1.mask_.color = var_121_19
			end

			local var_121_20 = 2

			if var_121_20 < arg_118_1.time_ and arg_118_1.time_ <= var_121_20 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_21 = 2

			if var_121_20 <= arg_118_1.time_ and arg_118_1.time_ < var_121_20 + var_121_21 then
				local var_121_22 = (arg_118_1.time_ - var_121_20) / var_121_21
				local var_121_23 = Color.New(0, 0, 0)

				var_121_23.a = Mathf.Lerp(1, 0, var_121_22)
				arg_118_1.mask_.color = var_121_23
			end

			if arg_118_1.time_ >= var_121_20 + var_121_21 and arg_118_1.time_ < var_121_20 + var_121_21 + arg_121_0 then
				local var_121_24 = Color.New(0, 0, 0)
				local var_121_25 = 0

				arg_118_1.mask_.enabled = false
				var_121_24.a = var_121_25
				arg_118_1.mask_.color = var_121_24
			end

			local var_121_26 = "S0507"

			if arg_118_1.bgs_[var_121_26] == nil then
				local var_121_27 = Object.Instantiate(arg_118_1.paintGo_)

				var_121_27:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_121_26)
				var_121_27.name = var_121_26
				var_121_27.transform.parent = arg_118_1.stage_.transform
				var_121_27.transform.localPosition = Vector3.New(0, 100, 0)
				arg_118_1.bgs_[var_121_26] = var_121_27
			end

			local var_121_28 = 2

			if var_121_28 < arg_118_1.time_ and arg_118_1.time_ <= var_121_28 + arg_121_0 then
				local var_121_29 = manager.ui.mainCamera.transform.localPosition
				local var_121_30 = Vector3.New(0, 0, 10) + Vector3.New(var_121_29.x, var_121_29.y, 0)
				local var_121_31 = arg_118_1.bgs_.S0507

				var_121_31.transform.localPosition = var_121_30
				var_121_31.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_121_32 = var_121_31:GetComponent("SpriteRenderer")

				if var_121_32 and var_121_32.sprite then
					local var_121_33 = (var_121_31.transform.localPosition - var_121_29).z
					local var_121_34 = manager.ui.mainCameraCom_
					local var_121_35 = 2 * var_121_33 * Mathf.Tan(var_121_34.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_121_36 = var_121_35 * var_121_34.aspect
					local var_121_37 = var_121_32.sprite.bounds.size.x
					local var_121_38 = var_121_32.sprite.bounds.size.y
					local var_121_39 = var_121_36 / var_121_37
					local var_121_40 = var_121_35 / var_121_38
					local var_121_41 = var_121_40 < var_121_39 and var_121_39 or var_121_40

					var_121_31.transform.localScale = Vector3.New(var_121_41, var_121_41, 0)
				end

				for iter_121_0, iter_121_1 in pairs(arg_118_1.bgs_) do
					if iter_121_0 ~= "S0507" then
						iter_121_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_121_42 = arg_118_1.bgs_.S0507.transform
			local var_121_43 = 2

			if var_121_43 < arg_118_1.time_ and arg_118_1.time_ <= var_121_43 + arg_121_0 then
				arg_118_1.var_.moveOldPosS0507 = var_121_42.localPosition
			end

			local var_121_44 = 0.001

			if var_121_43 <= arg_118_1.time_ and arg_118_1.time_ < var_121_43 + var_121_44 then
				local var_121_45 = (arg_118_1.time_ - var_121_43) / var_121_44
				local var_121_46 = Vector3.New(4.65, 3.19, -4.27)

				var_121_42.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPosS0507, var_121_46, var_121_45)
			end

			if arg_118_1.time_ >= var_121_43 + var_121_44 and arg_118_1.time_ < var_121_43 + var_121_44 + arg_121_0 then
				var_121_42.localPosition = Vector3.New(4.65, 3.19, -4.27)
			end

			local var_121_47 = arg_118_1.bgs_.S0507.transform
			local var_121_48 = 2.01666666666667

			if var_121_48 < arg_118_1.time_ and arg_118_1.time_ <= var_121_48 + arg_121_0 then
				arg_118_1.var_.moveOldPosS0507 = var_121_47.localPosition
			end

			local var_121_49 = 4

			if var_121_48 <= arg_118_1.time_ and arg_118_1.time_ < var_121_48 + var_121_49 then
				local var_121_50 = (arg_118_1.time_ - var_121_48) / var_121_49
				local var_121_51 = Vector3.New(4.65, 3.19, -3.01)

				var_121_47.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPosS0507, var_121_51, var_121_50)
			end

			if arg_118_1.time_ >= var_121_48 + var_121_49 and arg_118_1.time_ < var_121_48 + var_121_49 + arg_121_0 then
				var_121_47.localPosition = Vector3.New(4.65, 3.19, -3.01)
			end

			if arg_118_1.frameCnt_ <= 1 then
				arg_118_1.dialog_:SetActive(false)
			end

			local var_121_52 = 4
			local var_121_53 = 0.6

			if var_121_52 < arg_118_1.time_ and arg_118_1.time_ <= var_121_52 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0

				arg_118_1.dialog_:SetActive(true)

				arg_118_1.dialogCg_.alpha = 0

				local var_121_54 = LeanTween.value(arg_118_1.dialog_, 0, 1, 0.3)

				var_121_54:setOnUpdate(LuaHelper.FloatAction(function(arg_122_0)
					arg_118_1.dialogCg_.alpha = arg_122_0
				end))
				var_121_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_118_1.dialog_)
					var_121_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_118_1.duration_ = arg_118_1.duration_ + 0.3

				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_55 = arg_118_1:GetWordFromCfg(105071029)
				local var_121_56 = arg_118_1:FormatText(var_121_55.content)

				arg_118_1.text_.text = var_121_56

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_57 = 24
				local var_121_58 = utf8.len(var_121_56)
				local var_121_59 = var_121_57 <= 0 and var_121_53 or var_121_53 * (var_121_58 / var_121_57)

				if var_121_59 > 0 and var_121_53 < var_121_59 then
					arg_118_1.talkMaxDuration = var_121_59
					var_121_52 = var_121_52 + 0.3

					if var_121_59 + var_121_52 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_59 + var_121_52
					end
				end

				arg_118_1.text_.text = var_121_56
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_60 = var_121_52 + 0.3
			local var_121_61 = math.max(var_121_53, arg_118_1.talkMaxDuration)

			if var_121_60 <= arg_118_1.time_ and arg_118_1.time_ < var_121_60 + var_121_61 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_60) / var_121_61

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_60 + var_121_61 and arg_118_1.time_ < var_121_60 + var_121_61 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "S0507",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0507",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play105071030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 105071030
		arg_124_1.duration_ = 7.53

		local var_124_0 = {
			ja = 7.533,
			ko = 4.966,
			zh = 6.466,
			en = 6.266
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
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play105071031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.8

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[39].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jolin")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_3 = arg_124_1:GetWordFromCfg(105071030)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 32
				local var_127_6 = utf8.len(var_127_4)
				local var_127_7 = var_127_5 <= 0 and var_127_1 or var_127_1 * (var_127_6 / var_127_5)

				if var_127_7 > 0 and var_127_1 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071030", "story_v_out_105071.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_105071", "105071030", "story_v_out_105071.awb") / 1000

					if var_127_8 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_0
					end

					if var_127_3.prefab_name ~= "" and arg_124_1.actors_[var_127_3.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_3.prefab_name].transform, "story_v_out_105071", "105071030", "story_v_out_105071.awb")

						arg_124_1:RecordAudio("105071030", var_127_9)
						arg_124_1:RecordAudio("105071030", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_105071", "105071030", "story_v_out_105071.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_105071", "105071030", "story_v_out_105071.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_10 and arg_124_1.time_ < var_127_0 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play105071031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 105071031
		arg_128_1.duration_ = 6

		local var_128_0 = {
			ja = 3.266,
			ko = 4.966,
			zh = 4.3,
			en = 6
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
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play105071032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0
			local var_131_1 = 0.4

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_2 = arg_128_1:FormatText(StoryNameCfg[39].name)

				arg_128_1.leftNameTxt_.text = var_131_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jolin")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_3 = arg_128_1:GetWordFromCfg(105071031)
				local var_131_4 = arg_128_1:FormatText(var_131_3.content)

				arg_128_1.text_.text = var_131_4

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 16
				local var_131_6 = utf8.len(var_131_4)
				local var_131_7 = var_131_5 <= 0 and var_131_1 or var_131_1 * (var_131_6 / var_131_5)

				if var_131_7 > 0 and var_131_1 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_0
					end
				end

				arg_128_1.text_.text = var_131_4
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071031", "story_v_out_105071.awb") ~= 0 then
					local var_131_8 = manager.audio:GetVoiceLength("story_v_out_105071", "105071031", "story_v_out_105071.awb") / 1000

					if var_131_8 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_0
					end

					if var_131_3.prefab_name ~= "" and arg_128_1.actors_[var_131_3.prefab_name] ~= nil then
						local var_131_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_3.prefab_name].transform, "story_v_out_105071", "105071031", "story_v_out_105071.awb")

						arg_128_1:RecordAudio("105071031", var_131_9)
						arg_128_1:RecordAudio("105071031", var_131_9)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_105071", "105071031", "story_v_out_105071.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_105071", "105071031", "story_v_out_105071.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_10 = math.max(var_131_1, arg_128_1.talkMaxDuration)

			if var_131_0 <= arg_128_1.time_ and arg_128_1.time_ < var_131_0 + var_131_10 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_0) / var_131_10

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_0 + var_131_10 and arg_128_1.time_ < var_131_0 + var_131_10 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play105071032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 105071032
		arg_132_1.duration_ = 12.2

		local var_132_0 = {
			ja = 12.2,
			ko = 10.4,
			zh = 11.133,
			en = 9.666
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
			arg_132_1.auto_ = false
		end

		function arg_132_1.playNext_(arg_134_0)
			arg_132_1.onStoryFinished_()
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.mask_.enabled = true
				arg_132_1.mask_.raycastTarget = true

				arg_132_1:SetGaussion(false)
			end

			local var_135_1 = 2

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_1 then
				local var_135_2 = (arg_132_1.time_ - var_135_0) / var_135_1
				local var_135_3 = Color.New(0, 0, 0)

				var_135_3.a = Mathf.Lerp(0, 1, var_135_2)
				arg_132_1.mask_.color = var_135_3
			end

			if arg_132_1.time_ >= var_135_0 + var_135_1 and arg_132_1.time_ < var_135_0 + var_135_1 + arg_135_0 then
				local var_135_4 = Color.New(0, 0, 0)

				var_135_4.a = 1
				arg_132_1.mask_.color = var_135_4
			end

			local var_135_5 = 2

			if var_135_5 < arg_132_1.time_ and arg_132_1.time_ <= var_135_5 + arg_135_0 then
				arg_132_1.mask_.enabled = true
				arg_132_1.mask_.raycastTarget = true

				arg_132_1:SetGaussion(false)
			end

			local var_135_6 = 2

			if var_135_5 <= arg_132_1.time_ and arg_132_1.time_ < var_135_5 + var_135_6 then
				local var_135_7 = (arg_132_1.time_ - var_135_5) / var_135_6
				local var_135_8 = Color.New(0, 0, 0)

				var_135_8.a = Mathf.Lerp(1, 0, var_135_7)
				arg_132_1.mask_.color = var_135_8
			end

			if arg_132_1.time_ >= var_135_5 + var_135_6 and arg_132_1.time_ < var_135_5 + var_135_6 + arg_135_0 then
				local var_135_9 = Color.New(0, 0, 0)
				local var_135_10 = 0

				arg_132_1.mask_.enabled = false
				var_135_9.a = var_135_10
				arg_132_1.mask_.color = var_135_9
			end

			local var_135_11 = 2

			if var_135_11 < arg_132_1.time_ and arg_132_1.time_ <= var_135_11 + arg_135_0 then
				local var_135_12 = manager.ui.mainCamera.transform.localPosition
				local var_135_13 = Vector3.New(0, 0, 10) + Vector3.New(var_135_12.x, var_135_12.y, 0)
				local var_135_14 = arg_132_1.bgs_.S0507

				var_135_14.transform.localPosition = var_135_13
				var_135_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_135_15 = var_135_14:GetComponent("SpriteRenderer")

				if var_135_15 and var_135_15.sprite then
					local var_135_16 = (var_135_14.transform.localPosition - var_135_12).z
					local var_135_17 = manager.ui.mainCameraCom_
					local var_135_18 = 2 * var_135_16 * Mathf.Tan(var_135_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_135_19 = var_135_18 * var_135_17.aspect
					local var_135_20 = var_135_15.sprite.bounds.size.x
					local var_135_21 = var_135_15.sprite.bounds.size.y
					local var_135_22 = var_135_19 / var_135_20
					local var_135_23 = var_135_18 / var_135_21
					local var_135_24 = var_135_23 < var_135_22 and var_135_22 or var_135_23

					var_135_14.transform.localScale = Vector3.New(var_135_24, var_135_24, 0)
				end

				for iter_135_0, iter_135_1 in pairs(arg_132_1.bgs_) do
					if iter_135_0 ~= "S0507" then
						iter_135_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_132_1.frameCnt_ <= 1 then
				arg_132_1.dialog_:SetActive(false)
			end

			local var_135_25 = 4
			local var_135_26 = 0.85

			if var_135_25 < arg_132_1.time_ and arg_132_1.time_ <= var_135_25 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0

				arg_132_1.dialog_:SetActive(true)

				arg_132_1.dialogCg_.alpha = 0

				local var_135_27 = LeanTween.value(arg_132_1.dialog_, 0, 1, 0.3)

				var_135_27:setOnUpdate(LuaHelper.FloatAction(function(arg_136_0)
					arg_132_1.dialogCg_.alpha = arg_136_0
				end))
				var_135_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_132_1.dialog_)
					var_135_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_132_1.duration_ = arg_132_1.duration_ + 0.3

				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_28 = arg_132_1:FormatText(StoryNameCfg[35].name)

				arg_132_1.leftNameTxt_.text = var_135_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_29 = arg_132_1:GetWordFromCfg(105071032)
				local var_135_30 = arg_132_1:FormatText(var_135_29.content)

				arg_132_1.text_.text = var_135_30

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_31 = 33
				local var_135_32 = utf8.len(var_135_30)
				local var_135_33 = var_135_31 <= 0 and var_135_26 or var_135_26 * (var_135_32 / var_135_31)

				if var_135_33 > 0 and var_135_26 < var_135_33 then
					arg_132_1.talkMaxDuration = var_135_33
					var_135_25 = var_135_25 + 0.3

					if var_135_33 + var_135_25 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_33 + var_135_25
					end
				end

				arg_132_1.text_.text = var_135_30
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105071", "105071032", "story_v_out_105071.awb") ~= 0 then
					local var_135_34 = manager.audio:GetVoiceLength("story_v_out_105071", "105071032", "story_v_out_105071.awb") / 1000

					if var_135_34 + var_135_25 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_34 + var_135_25
					end

					if var_135_29.prefab_name ~= "" and arg_132_1.actors_[var_135_29.prefab_name] ~= nil then
						local var_135_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_29.prefab_name].transform, "story_v_out_105071", "105071032", "story_v_out_105071.awb")

						arg_132_1:RecordAudio("105071032", var_135_35)
						arg_132_1:RecordAudio("105071032", var_135_35)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_105071", "105071032", "story_v_out_105071.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_105071", "105071032", "story_v_out_105071.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_36 = var_135_25 + 0.3
			local var_135_37 = math.max(var_135_26, arg_132_1.talkMaxDuration)

			if var_135_36 <= arg_132_1.time_ and arg_132_1.time_ < var_135_36 + var_135_37 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_36) / var_135_37

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_36 + var_135_37 and arg_132_1.time_ < var_135_36 + var_135_37 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B01c",
		"TextureConfig/Background/B03f",
		"TextureConfig/Background/S0507"
	},
	voices = {
		"story_v_out_105071.awb"
	}
}
