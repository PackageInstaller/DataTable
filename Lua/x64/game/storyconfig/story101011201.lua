return {
	Play101121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 101121001
		arg_1_1.duration_ = 8.17

		local var_1_0 = {
			ja = 7.4,
			ko = 8.166,
			zh = 7.5,
			en = 8.033
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
				arg_1_0:Play101121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")

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

			local var_4_6 = "10002ui_story"

			if arg_1_1.actors_[var_4_6] == nil then
				local var_4_7 = Asset.Load("Char/" .. "10002ui_story")

				if not isNil(var_4_7) then
					local var_4_8 = Object.Instantiate(Asset.Load("Char/" .. "10002ui_story"), arg_1_1.stage_.transform)

					var_4_8.name = var_4_6
					var_4_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_6] = var_4_8

					local var_4_9 = var_4_8:GetComponentInChildren(typeof(CharacterEffect))

					var_4_9.enabled = true

					local var_4_10 = GameObjectTools.GetOrAddComponent(var_4_8, typeof(DynamicBoneHelper))

					if var_4_10 then
						var_4_10:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_9.transform, false)

					arg_1_1.var_[var_4_6 .. "Animator"] = var_4_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_6 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_6 .. "LipSync"] = var_4_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_11 = arg_1_1.actors_["10002ui_story"]
			local var_4_12 = 2

			if var_4_12 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 and not isNil(var_4_11) and arg_1_1.var_.characterEffect10002ui_story == nil then
				arg_1_1.var_.characterEffect10002ui_story = var_4_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_13 = 0.1

			if var_4_12 <= arg_1_1.time_ and arg_1_1.time_ < var_4_12 + var_4_13 and not isNil(var_4_11) then
				local var_4_14 = (arg_1_1.time_ - var_4_12) / var_4_13

				if arg_1_1.var_.characterEffect10002ui_story and not isNil(var_4_11) then
					arg_1_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_12 + var_4_13 and arg_1_1.time_ < var_4_12 + var_4_13 + arg_4_0 and not isNil(var_4_11) and arg_1_1.var_.characterEffect10002ui_story then
				arg_1_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_4_15 = "B03f"

			if arg_1_1.bgs_[var_4_15] == nil then
				local var_4_16 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_16:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_15)
				var_4_16.name = var_4_15
				var_4_16.transform.parent = arg_1_1.stage_.transform
				var_4_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_15] = var_4_16
			end

			local var_4_17 = arg_1_1.bgs_.B03f
			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				local var_4_19 = var_4_17:GetComponent("SpriteRenderer")

				if var_4_19 then
					arg_1_1.var_.alphaOldValueB03f = var_4_19.color.a
					arg_1_1.var_.alphaMatValueB03f = var_4_19
				end

				arg_1_1.var_.alphaOldValueB03f = 0
			end

			local var_4_20 = 1.5

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_20 then
				local var_4_21 = (arg_1_1.time_ - var_4_18) / var_4_20
				local var_4_22 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB03f, 1, var_4_21)

				if arg_1_1.var_.alphaMatValueB03f then
					local var_4_23 = arg_1_1.var_.alphaMatValueB03f.color

					var_4_23.a = var_4_22
					arg_1_1.var_.alphaMatValueB03f.color = var_4_23
				end
			end

			if arg_1_1.time_ >= var_4_18 + var_4_20 and arg_1_1.time_ < var_4_18 + var_4_20 + arg_4_0 and arg_1_1.var_.alphaMatValueB03f then
				local var_4_24 = arg_1_1.var_.alphaMatValueB03f
				local var_4_25 = var_4_24.color

				var_4_25.a = 1
				var_4_24.color = var_4_25
			end

			local var_4_26 = 0

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_27 = manager.ui.mainCamera.transform.localPosition
				local var_4_28 = Vector3.New(0, 0, 10) + Vector3.New(var_4_27.x, var_4_27.y, 0)
				local var_4_29 = arg_1_1.bgs_.B03f

				var_4_29.transform.localPosition = var_4_28
				var_4_29.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_30 = var_4_29:GetComponent("SpriteRenderer")

				if var_4_30 and var_4_30.sprite then
					local var_4_31 = (var_4_29.transform.localPosition - var_4_27).z
					local var_4_32 = manager.ui.mainCameraCom_
					local var_4_33 = 2 * var_4_31 * Mathf.Tan(var_4_32.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_34 = var_4_33 * var_4_32.aspect
					local var_4_35 = var_4_30.sprite.bounds.size.x
					local var_4_36 = var_4_30.sprite.bounds.size.y
					local var_4_37 = var_4_34 / var_4_35
					local var_4_38 = var_4_33 / var_4_36
					local var_4_39 = var_4_38 < var_4_37 and var_4_37 or var_4_38

					var_4_29.transform.localScale = Vector3.New(var_4_39, var_4_39, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B03f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_40 = arg_1_1.actors_["10002ui_story"].transform
			local var_4_41 = 1.79999995231628

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1.var_.moveOldPos10002ui_story = var_4_40.localPosition
			end

			local var_4_42 = 0.001

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 then
				local var_4_43 = (arg_1_1.time_ - var_4_41) / var_4_42
				local var_4_44 = Vector3.New(0, -1.2, -5.8)

				var_4_40.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10002ui_story, var_4_44, var_4_43)

				local var_4_45 = manager.ui.mainCamera.transform.position - var_4_40.position

				var_4_40.forward = Vector3.New(var_4_45.x, var_4_45.y, var_4_45.z)

				local var_4_46 = var_4_40.localEulerAngles

				var_4_46.z = 0
				var_4_46.x = 0
				var_4_40.localEulerAngles = var_4_46
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 then
				var_4_40.localPosition = Vector3.New(0, -1.2, -5.8)

				local var_4_47 = manager.ui.mainCamera.transform.position - var_4_40.position

				var_4_40.forward = Vector3.New(var_4_47.x, var_4_47.y, var_4_47.z)

				local var_4_48 = var_4_40.localEulerAngles

				var_4_48.z = 0
				var_4_48.x = 0
				var_4_40.localEulerAngles = var_4_48
			end

			local var_4_49 = 0.7

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				arg_1_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action1_1")
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
				arg_1_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_53 = 2
			local var_4_54 = 0.7

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

				local var_4_56 = arg_1_1:FormatText(StoryNameCfg[39].name)

				arg_1_1.leftNameTxt_.text = var_4_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_57 = arg_1_1:GetWordFromCfg(101121001)
				local var_4_58 = arg_1_1:FormatText(var_4_57.content)

				arg_1_1.text_.text = var_4_58

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_59 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121001", "story_v_out_101121.awb") ~= 0 then
					local var_4_62 = manager.audio:GetVoiceLength("story_v_out_101121", "101121001", "story_v_out_101121.awb") / 1000

					if var_4_62 + var_4_53 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_53
					end

					if var_4_57.prefab_name ~= "" and arg_1_1.actors_[var_4_57.prefab_name] ~= nil then
						local var_4_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_57.prefab_name].transform, "story_v_out_101121", "101121001", "story_v_out_101121.awb")

						arg_1_1:RecordAudio("101121001", var_4_63)
						arg_1_1:RecordAudio("101121001", var_4_63)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_101121", "101121001", "story_v_out_101121.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_101121", "101121001", "story_v_out_101121.awb")
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
				actorName = "10002ui_story",
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
	Play101121002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 101121002
		arg_8_1.duration_ = 4.3

		local var_8_0 = {
			ja = 2.8,
			ko = 3.9,
			zh = 4.3,
			en = 3.5
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
				arg_8_0:Play101121003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["10002ui_story"]
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect10002ui_story == nil then
				arg_8_1.var_.characterEffect10002ui_story = var_11_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_2 = 0.1

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 and not isNil(var_11_0) then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / var_11_2

				if arg_8_1.var_.characterEffect10002ui_story and not isNil(var_11_0) then
					local var_11_4 = Mathf.Lerp(0, 0.5, var_11_3)

					arg_8_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_8_1.var_.characterEffect10002ui_story.fillRatio = var_11_4
				end
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect10002ui_story then
				local var_11_5 = 0.5

				arg_8_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_8_1.var_.characterEffect10002ui_story.fillRatio = var_11_5
			end

			local var_11_6 = 0
			local var_11_7 = 0.35

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_8 = arg_8_1:FormatText(StoryNameCfg[29].name)

				arg_8_1.leftNameTxt_.text = var_11_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2021")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_9 = arg_8_1:GetWordFromCfg(101121002)
				local var_11_10 = arg_8_1:FormatText(var_11_9.content)

				arg_8_1.text_.text = var_11_10

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_11 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121002", "story_v_out_101121.awb") ~= 0 then
					local var_11_14 = manager.audio:GetVoiceLength("story_v_out_101121", "101121002", "story_v_out_101121.awb") / 1000

					if var_11_14 + var_11_6 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_6
					end

					if var_11_9.prefab_name ~= "" and arg_8_1.actors_[var_11_9.prefab_name] ~= nil then
						local var_11_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_9.prefab_name].transform, "story_v_out_101121", "101121002", "story_v_out_101121.awb")

						arg_8_1:RecordAudio("101121002", var_11_15)
						arg_8_1:RecordAudio("101121002", var_11_15)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_101121", "101121002", "story_v_out_101121.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_101121", "101121002", "story_v_out_101121.awb")
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
	Play101121003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 101121003
		arg_12_1.duration_ = 10.13

		local var_12_0 = {
			ja = 7.133,
			ko = 9.5,
			zh = 6.633,
			en = 10.133
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
				arg_12_0:Play101121004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["10002ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect10002ui_story == nil then
				arg_12_1.var_.characterEffect10002ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.1

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect10002ui_story and not isNil(var_15_0) then
					arg_12_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect10002ui_story then
				arg_12_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_15_4 = 0

			if var_15_4 < arg_12_1.time_ and arg_12_1.time_ <= var_15_4 + arg_15_0 then
				arg_12_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_15_5 = 0
			local var_15_6 = 0.65

			if var_15_5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_7 = arg_12_1:FormatText(StoryNameCfg[39].name)

				arg_12_1.leftNameTxt_.text = var_15_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_8 = arg_12_1:GetWordFromCfg(101121003)
				local var_15_9 = arg_12_1:FormatText(var_15_8.content)

				arg_12_1.text_.text = var_15_9

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_10 = 22
				local var_15_11 = utf8.len(var_15_9)
				local var_15_12 = var_15_10 <= 0 and var_15_6 or var_15_6 * (var_15_11 / var_15_10)

				if var_15_12 > 0 and var_15_6 < var_15_12 then
					arg_12_1.talkMaxDuration = var_15_12

					if var_15_12 + var_15_5 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_12 + var_15_5
					end
				end

				arg_12_1.text_.text = var_15_9
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121003", "story_v_out_101121.awb") ~= 0 then
					local var_15_13 = manager.audio:GetVoiceLength("story_v_out_101121", "101121003", "story_v_out_101121.awb") / 1000

					if var_15_13 + var_15_5 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_5
					end

					if var_15_8.prefab_name ~= "" and arg_12_1.actors_[var_15_8.prefab_name] ~= nil then
						local var_15_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_8.prefab_name].transform, "story_v_out_101121", "101121003", "story_v_out_101121.awb")

						arg_12_1:RecordAudio("101121003", var_15_14)
						arg_12_1:RecordAudio("101121003", var_15_14)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_101121", "101121003", "story_v_out_101121.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_101121", "101121003", "story_v_out_101121.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_15 = math.max(var_15_6, arg_12_1.talkMaxDuration)

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_15 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_5) / var_15_15

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_5 + var_15_15 and arg_12_1.time_ < var_15_5 + var_15_15 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play101121004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 101121004
		arg_16_1.duration_ = 7.67

		local var_16_0 = {
			ja = 7.666,
			ko = 4,
			zh = 4.7,
			en = 6.6
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
				arg_16_0:Play101121005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["10002ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect10002ui_story == nil then
				arg_16_1.var_.characterEffect10002ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.1

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect10002ui_story and not isNil(var_19_0) then
					local var_19_4 = Mathf.Lerp(0, 0.5, var_19_3)

					arg_16_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_16_1.var_.characterEffect10002ui_story.fillRatio = var_19_4
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect10002ui_story then
				local var_19_5 = 0.5

				arg_16_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_16_1.var_.characterEffect10002ui_story.fillRatio = var_19_5
			end

			local var_19_6 = 0
			local var_19_7 = 0.25

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_8 = arg_16_1:FormatText(StoryNameCfg[29].name)

				arg_16_1.leftNameTxt_.text = var_19_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2021")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_9 = arg_16_1:GetWordFromCfg(101121004)
				local var_19_10 = arg_16_1:FormatText(var_19_9.content)

				arg_16_1.text_.text = var_19_10

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_11 = 11
				local var_19_12 = utf8.len(var_19_10)
				local var_19_13 = var_19_11 <= 0 and var_19_7 or var_19_7 * (var_19_12 / var_19_11)

				if var_19_13 > 0 and var_19_7 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_6
					end
				end

				arg_16_1.text_.text = var_19_10
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121004", "story_v_out_101121.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_out_101121", "101121004", "story_v_out_101121.awb") / 1000

					if var_19_14 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_6
					end

					if var_19_9.prefab_name ~= "" and arg_16_1.actors_[var_19_9.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_9.prefab_name].transform, "story_v_out_101121", "101121004", "story_v_out_101121.awb")

						arg_16_1:RecordAudio("101121004", var_19_15)
						arg_16_1:RecordAudio("101121004", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_101121", "101121004", "story_v_out_101121.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_101121", "101121004", "story_v_out_101121.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_16 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_16 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_16

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_16 and arg_16_1.time_ < var_19_6 + var_19_16 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play101121005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 101121005
		arg_20_1.duration_ = 4.83

		local var_20_0 = {
			ja = 4.4,
			ko = 4.833,
			zh = 3.166,
			en = 3.766
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
				arg_20_0:Play101121006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["10002ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect10002ui_story == nil then
				arg_20_1.var_.characterEffect10002ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.1

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect10002ui_story and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect10002ui_story then
				arg_20_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_23_4 = 0

			if var_23_4 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_23_5 = 0
			local var_23_6 = 0.425

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_7 = arg_20_1:FormatText(StoryNameCfg[39].name)

				arg_20_1.leftNameTxt_.text = var_23_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_8 = arg_20_1:GetWordFromCfg(101121005)
				local var_23_9 = arg_20_1:FormatText(var_23_8.content)

				arg_20_1.text_.text = var_23_9

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_10 = 13
				local var_23_11 = utf8.len(var_23_9)
				local var_23_12 = var_23_10 <= 0 and var_23_6 or var_23_6 * (var_23_11 / var_23_10)

				if var_23_12 > 0 and var_23_6 < var_23_12 then
					arg_20_1.talkMaxDuration = var_23_12

					if var_23_12 + var_23_5 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_12 + var_23_5
					end
				end

				arg_20_1.text_.text = var_23_9
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121005", "story_v_out_101121.awb") ~= 0 then
					local var_23_13 = manager.audio:GetVoiceLength("story_v_out_101121", "101121005", "story_v_out_101121.awb") / 1000

					if var_23_13 + var_23_5 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_5
					end

					if var_23_8.prefab_name ~= "" and arg_20_1.actors_[var_23_8.prefab_name] ~= nil then
						local var_23_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_8.prefab_name].transform, "story_v_out_101121", "101121005", "story_v_out_101121.awb")

						arg_20_1:RecordAudio("101121005", var_23_14)
						arg_20_1:RecordAudio("101121005", var_23_14)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_101121", "101121005", "story_v_out_101121.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_101121", "101121005", "story_v_out_101121.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_15 = math.max(var_23_6, arg_20_1.talkMaxDuration)

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_15 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_5) / var_23_15

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_5 + var_23_15 and arg_20_1.time_ < var_23_5 + var_23_15 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play101121006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 101121006
		arg_24_1.duration_ = 3

		local var_24_0 = {
			ja = 2.833,
			ko = 3,
			zh = 2.8,
			en = 2.233
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
				arg_24_0:Play101121007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["10002ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect10002ui_story == nil then
				arg_24_1.var_.characterEffect10002ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.1

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect10002ui_story and not isNil(var_27_0) then
					local var_27_4 = Mathf.Lerp(0, 0.5, var_27_3)

					arg_24_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_24_1.var_.characterEffect10002ui_story.fillRatio = var_27_4
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect10002ui_story then
				local var_27_5 = 0.5

				arg_24_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_24_1.var_.characterEffect10002ui_story.fillRatio = var_27_5
			end

			local var_27_6 = 0
			local var_27_7 = 0.15

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_8 = arg_24_1:FormatText(StoryNameCfg[29].name)

				arg_24_1.leftNameTxt_.text = var_27_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2021")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_9 = arg_24_1:GetWordFromCfg(101121006)
				local var_27_10 = arg_24_1:FormatText(var_27_9.content)

				arg_24_1.text_.text = var_27_10

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_11 = 6
				local var_27_12 = utf8.len(var_27_10)
				local var_27_13 = var_27_11 <= 0 and var_27_7 or var_27_7 * (var_27_12 / var_27_11)

				if var_27_13 > 0 and var_27_7 < var_27_13 then
					arg_24_1.talkMaxDuration = var_27_13

					if var_27_13 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_13 + var_27_6
					end
				end

				arg_24_1.text_.text = var_27_10
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121006", "story_v_out_101121.awb") ~= 0 then
					local var_27_14 = manager.audio:GetVoiceLength("story_v_out_101121", "101121006", "story_v_out_101121.awb") / 1000

					if var_27_14 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_14 + var_27_6
					end

					if var_27_9.prefab_name ~= "" and arg_24_1.actors_[var_27_9.prefab_name] ~= nil then
						local var_27_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_9.prefab_name].transform, "story_v_out_101121", "101121006", "story_v_out_101121.awb")

						arg_24_1:RecordAudio("101121006", var_27_15)
						arg_24_1:RecordAudio("101121006", var_27_15)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_101121", "101121006", "story_v_out_101121.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_101121", "101121006", "story_v_out_101121.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_16 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_16 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_16

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_16 and arg_24_1.time_ < var_27_6 + var_27_16 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play101121007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 101121007
		arg_28_1.duration_ = 6.23

		local var_28_0 = {
			ja = 6.233,
			ko = 4.9,
			zh = 3.266,
			en = 5.133
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
				arg_28_0:Play101121008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["10002ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect10002ui_story == nil then
				arg_28_1.var_.characterEffect10002ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect10002ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect10002ui_story then
				arg_28_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_31_4 = 0

			if var_31_4 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action2_1")
			end

			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_31_6 = 0
			local var_31_7 = 0.425

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_8 = arg_28_1:FormatText(StoryNameCfg[39].name)

				arg_28_1.leftNameTxt_.text = var_31_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_9 = arg_28_1:GetWordFromCfg(101121007)
				local var_31_10 = arg_28_1:FormatText(var_31_9.content)

				arg_28_1.text_.text = var_31_10

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_11 = 13
				local var_31_12 = utf8.len(var_31_10)
				local var_31_13 = var_31_11 <= 0 and var_31_7 or var_31_7 * (var_31_12 / var_31_11)

				if var_31_13 > 0 and var_31_7 < var_31_13 then
					arg_28_1.talkMaxDuration = var_31_13

					if var_31_13 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_6
					end
				end

				arg_28_1.text_.text = var_31_10
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121007", "story_v_out_101121.awb") ~= 0 then
					local var_31_14 = manager.audio:GetVoiceLength("story_v_out_101121", "101121007", "story_v_out_101121.awb") / 1000

					if var_31_14 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_14 + var_31_6
					end

					if var_31_9.prefab_name ~= "" and arg_28_1.actors_[var_31_9.prefab_name] ~= nil then
						local var_31_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_9.prefab_name].transform, "story_v_out_101121", "101121007", "story_v_out_101121.awb")

						arg_28_1:RecordAudio("101121007", var_31_15)
						arg_28_1:RecordAudio("101121007", var_31_15)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_101121", "101121007", "story_v_out_101121.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_101121", "101121007", "story_v_out_101121.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_16 = math.max(var_31_7, arg_28_1.talkMaxDuration)

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_16 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_6) / var_31_16

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_6 + var_31_16 and arg_28_1.time_ < var_31_6 + var_31_16 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play101121008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 101121008
		arg_32_1.duration_ = 2.77

		local var_32_0 = {
			ja = 2.766,
			ko = 1.466,
			zh = 1.966,
			en = 1.133
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
				arg_32_0:Play101121009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["10002ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect10002ui_story == nil then
				arg_32_1.var_.characterEffect10002ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect10002ui_story and not isNil(var_35_0) then
					local var_35_4 = Mathf.Lerp(0, 0.5, var_35_3)

					arg_32_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_32_1.var_.characterEffect10002ui_story.fillRatio = var_35_4
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect10002ui_story then
				local var_35_5 = 0.5

				arg_32_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_32_1.var_.characterEffect10002ui_story.fillRatio = var_35_5
			end

			local var_35_6 = 0
			local var_35_7 = 0.075

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_8 = arg_32_1:FormatText(StoryNameCfg[29].name)

				arg_32_1.leftNameTxt_.text = var_35_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2021")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_9 = arg_32_1:GetWordFromCfg(101121008)
				local var_35_10 = arg_32_1:FormatText(var_35_9.content)

				arg_32_1.text_.text = var_35_10

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_11 = 3
				local var_35_12 = utf8.len(var_35_10)
				local var_35_13 = var_35_11 <= 0 and var_35_7 or var_35_7 * (var_35_12 / var_35_11)

				if var_35_13 > 0 and var_35_7 < var_35_13 then
					arg_32_1.talkMaxDuration = var_35_13

					if var_35_13 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_6
					end
				end

				arg_32_1.text_.text = var_35_10
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121008", "story_v_out_101121.awb") ~= 0 then
					local var_35_14 = manager.audio:GetVoiceLength("story_v_out_101121", "101121008", "story_v_out_101121.awb") / 1000

					if var_35_14 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_14 + var_35_6
					end

					if var_35_9.prefab_name ~= "" and arg_32_1.actors_[var_35_9.prefab_name] ~= nil then
						local var_35_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_9.prefab_name].transform, "story_v_out_101121", "101121008", "story_v_out_101121.awb")

						arg_32_1:RecordAudio("101121008", var_35_15)
						arg_32_1:RecordAudio("101121008", var_35_15)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_101121", "101121008", "story_v_out_101121.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_101121", "101121008", "story_v_out_101121.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_16 = math.max(var_35_7, arg_32_1.talkMaxDuration)

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_16 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_6) / var_35_16

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_6 + var_35_16 and arg_32_1.time_ < var_35_6 + var_35_16 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play101121009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 101121009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play101121010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 1.325

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_2 = arg_36_1:GetWordFromCfg(101121009)
				local var_39_3 = arg_36_1:FormatText(var_39_2.content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 53
				local var_39_5 = utf8.len(var_39_3)
				local var_39_6 = var_39_4 <= 0 and var_39_1 or var_39_1 * (var_39_5 / var_39_4)

				if var_39_6 > 0 and var_39_1 < var_39_6 then
					arg_36_1.talkMaxDuration = var_39_6

					if var_39_6 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_7 and arg_36_1.time_ < var_39_0 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play101121010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 101121010
		arg_40_1.duration_ = 4

		local var_40_0 = {
			ja = 2.5,
			ko = 2.9,
			zh = 4,
			en = 3.733
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
				arg_40_0:Play101121011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["10002ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect10002ui_story == nil then
				arg_40_1.var_.characterEffect10002ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect10002ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect10002ui_story then
				arg_40_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_43_4 = 0

			if var_43_4 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_43_5 = 0
			local var_43_6 = 0.275

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_7 = arg_40_1:FormatText(StoryNameCfg[39].name)

				arg_40_1.leftNameTxt_.text = var_43_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_8 = arg_40_1:GetWordFromCfg(101121010)
				local var_43_9 = arg_40_1:FormatText(var_43_8.content)

				arg_40_1.text_.text = var_43_9

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_10 = 7
				local var_43_11 = utf8.len(var_43_9)
				local var_43_12 = var_43_10 <= 0 and var_43_6 or var_43_6 * (var_43_11 / var_43_10)

				if var_43_12 > 0 and var_43_6 < var_43_12 then
					arg_40_1.talkMaxDuration = var_43_12

					if var_43_12 + var_43_5 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_12 + var_43_5
					end
				end

				arg_40_1.text_.text = var_43_9
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121010", "story_v_out_101121.awb") ~= 0 then
					local var_43_13 = manager.audio:GetVoiceLength("story_v_out_101121", "101121010", "story_v_out_101121.awb") / 1000

					if var_43_13 + var_43_5 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_13 + var_43_5
					end

					if var_43_8.prefab_name ~= "" and arg_40_1.actors_[var_43_8.prefab_name] ~= nil then
						local var_43_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_8.prefab_name].transform, "story_v_out_101121", "101121010", "story_v_out_101121.awb")

						arg_40_1:RecordAudio("101121010", var_43_14)
						arg_40_1:RecordAudio("101121010", var_43_14)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_101121", "101121010", "story_v_out_101121.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_101121", "101121010", "story_v_out_101121.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_15 = math.max(var_43_6, arg_40_1.talkMaxDuration)

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_15 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_5) / var_43_15

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_5 + var_43_15 and arg_40_1.time_ < var_43_5 + var_43_15 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play101121011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 101121011
		arg_44_1.duration_ = 3.23

		local var_44_0 = {
			ja = 3.233,
			ko = 1.2,
			zh = 1.633,
			en = 0.966
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
				arg_44_0:Play101121012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["10002ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect10002ui_story == nil then
				arg_44_1.var_.characterEffect10002ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect10002ui_story and not isNil(var_47_0) then
					local var_47_4 = Mathf.Lerp(0, 0.5, var_47_3)

					arg_44_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_44_1.var_.characterEffect10002ui_story.fillRatio = var_47_4
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect10002ui_story then
				local var_47_5 = 0.5

				arg_44_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_44_1.var_.characterEffect10002ui_story.fillRatio = var_47_5
			end

			local var_47_6 = 0
			local var_47_7 = 0.05

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_8 = arg_44_1:FormatText(StoryNameCfg[29].name)

				arg_44_1.leftNameTxt_.text = var_47_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2021")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_9 = arg_44_1:GetWordFromCfg(101121011)
				local var_47_10 = arg_44_1:FormatText(var_47_9.content)

				arg_44_1.text_.text = var_47_10

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_11 = 2
				local var_47_12 = utf8.len(var_47_10)
				local var_47_13 = var_47_11 <= 0 and var_47_7 or var_47_7 * (var_47_12 / var_47_11)

				if var_47_13 > 0 and var_47_7 < var_47_13 then
					arg_44_1.talkMaxDuration = var_47_13

					if var_47_13 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_13 + var_47_6
					end
				end

				arg_44_1.text_.text = var_47_10
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121011", "story_v_out_101121.awb") ~= 0 then
					local var_47_14 = manager.audio:GetVoiceLength("story_v_out_101121", "101121011", "story_v_out_101121.awb") / 1000

					if var_47_14 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_14 + var_47_6
					end

					if var_47_9.prefab_name ~= "" and arg_44_1.actors_[var_47_9.prefab_name] ~= nil then
						local var_47_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_9.prefab_name].transform, "story_v_out_101121", "101121011", "story_v_out_101121.awb")

						arg_44_1:RecordAudio("101121011", var_47_15)
						arg_44_1:RecordAudio("101121011", var_47_15)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_101121", "101121011", "story_v_out_101121.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_101121", "101121011", "story_v_out_101121.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_16 = math.max(var_47_7, arg_44_1.talkMaxDuration)

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_16 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_6) / var_47_16

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_6 + var_47_16 and arg_44_1.time_ < var_47_6 + var_47_16 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play101121012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 101121012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play101121013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["10002ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect10002ui_story == nil then
				arg_48_1.var_.characterEffect10002ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect10002ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect10002ui_story then
				arg_48_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_51_4 = 0
			local var_51_5 = 1.175

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

				local var_51_6 = arg_48_1:GetWordFromCfg(101121012)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_8 = 47
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
	Play101121013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 101121013
		arg_52_1.duration_ = 3.4

		local var_52_0 = {
			ja = 3.4,
			ko = 2.566,
			zh = 2.4,
			en = 3.133
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
				arg_52_0:Play101121014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 1

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				local var_55_2 = "play"
				local var_55_3 = "effect"

				arg_52_1:AudioAction(var_55_2, var_55_3, "se_story_1", "se_story_1_doorslam", "")
			end

			local var_55_4 = arg_52_1.actors_["10002ui_story"]
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect10002ui_story == nil then
				arg_52_1.var_.characterEffect10002ui_story = var_55_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_6 = 0.1

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 and not isNil(var_55_4) then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6

				if arg_52_1.var_.characterEffect10002ui_story and not isNil(var_55_4) then
					local var_55_8 = Mathf.Lerp(0, 0.5, var_55_7)

					arg_52_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_52_1.var_.characterEffect10002ui_story.fillRatio = var_55_8
				end
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect10002ui_story then
				local var_55_9 = 0.5

				arg_52_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_52_1.var_.characterEffect10002ui_story.fillRatio = var_55_9
			end

			local var_55_10 = manager.ui.mainCamera.transform
			local var_55_11 = 0

			if var_55_11 < arg_52_1.time_ and arg_52_1.time_ <= var_55_11 + arg_55_0 then
				arg_52_1.var_.shakeOldPosMainCamera = var_55_10.localPosition
			end

			local var_55_12 = 0.600000023841858

			if var_55_11 <= arg_52_1.time_ and arg_52_1.time_ < var_55_11 + var_55_12 then
				local var_55_13 = (arg_52_1.time_ - var_55_11) / 0.066
				local var_55_14, var_55_15 = math.modf(var_55_13)

				var_55_10.localPosition = Vector3.New(var_55_15 * 0.13, var_55_15 * 0.13, var_55_15 * 0.13) + arg_52_1.var_.shakeOldPosMainCamera
			end

			if arg_52_1.time_ >= var_55_11 + var_55_12 and arg_52_1.time_ < var_55_11 + var_55_12 + arg_55_0 then
				var_55_10.localPosition = arg_52_1.var_.shakeOldPosMainCamera
			end

			local var_55_16 = arg_52_1.actors_["10002ui_story"].transform
			local var_55_17 = 0

			if var_55_17 < arg_52_1.time_ and arg_52_1.time_ <= var_55_17 + arg_55_0 then
				arg_52_1.var_.moveOldPos10002ui_story = var_55_16.localPosition
			end

			local var_55_18 = 0.001

			if var_55_17 <= arg_52_1.time_ and arg_52_1.time_ < var_55_17 + var_55_18 then
				local var_55_19 = (arg_52_1.time_ - var_55_17) / var_55_18
				local var_55_20 = Vector3.New(0, 100, 0)

				var_55_16.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10002ui_story, var_55_20, var_55_19)

				local var_55_21 = manager.ui.mainCamera.transform.position - var_55_16.position

				var_55_16.forward = Vector3.New(var_55_21.x, var_55_21.y, var_55_21.z)

				local var_55_22 = var_55_16.localEulerAngles

				var_55_22.z = 0
				var_55_22.x = 0
				var_55_16.localEulerAngles = var_55_22
			end

			if arg_52_1.time_ >= var_55_17 + var_55_18 and arg_52_1.time_ < var_55_17 + var_55_18 + arg_55_0 then
				var_55_16.localPosition = Vector3.New(0, 100, 0)

				local var_55_23 = manager.ui.mainCamera.transform.position - var_55_16.position

				var_55_16.forward = Vector3.New(var_55_23.x, var_55_23.y, var_55_23.z)

				local var_55_24 = var_55_16.localEulerAngles

				var_55_24.z = 0
				var_55_24.x = 0
				var_55_16.localEulerAngles = var_55_24
			end

			local var_55_25 = "10001_tpose"

			if arg_52_1.actors_[var_55_25] == nil then
				local var_55_26 = Asset.Load("Char/" .. "10001_tpose")

				if not isNil(var_55_26) then
					local var_55_27 = Object.Instantiate(Asset.Load("Char/" .. "10001_tpose"), arg_52_1.stage_.transform)

					var_55_27.name = var_55_25
					var_55_27.transform.localPosition = Vector3.New(0, 100, 0)
					arg_52_1.actors_[var_55_25] = var_55_27

					local var_55_28 = var_55_27:GetComponentInChildren(typeof(CharacterEffect))

					var_55_28.enabled = true

					local var_55_29 = GameObjectTools.GetOrAddComponent(var_55_27, typeof(DynamicBoneHelper))

					if var_55_29 then
						var_55_29:EnableDynamicBone(false)
					end

					arg_52_1:ShowWeapon(var_55_28.transform, false)

					arg_52_1.var_[var_55_25 .. "Animator"] = var_55_28.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_52_1.var_[var_55_25 .. "Animator"].applyRootMotion = true
					arg_52_1.var_[var_55_25 .. "LipSync"] = var_55_28.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_55_30 = 0

			if var_55_30 < arg_52_1.time_ and arg_52_1.time_ <= var_55_30 + arg_55_0 then
				arg_52_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_55_31 = 0
			local var_55_32 = 0.225

			if var_55_31 < arg_52_1.time_ and arg_52_1.time_ <= var_55_31 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_33 = arg_52_1:FormatText(StoryNameCfg[31].name)

				arg_52_1.leftNameTxt_.text = var_55_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_34 = arg_52_1:GetWordFromCfg(101121013)
				local var_55_35 = arg_52_1:FormatText(var_55_34.content)

				arg_52_1.text_.text = var_55_35

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_36 = 9
				local var_55_37 = utf8.len(var_55_35)
				local var_55_38 = var_55_36 <= 0 and var_55_32 or var_55_32 * (var_55_37 / var_55_36)

				if var_55_38 > 0 and var_55_32 < var_55_38 then
					arg_52_1.talkMaxDuration = var_55_38

					if var_55_38 + var_55_31 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_38 + var_55_31
					end
				end

				arg_52_1.text_.text = var_55_35
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121013", "story_v_out_101121.awb") ~= 0 then
					local var_55_39 = manager.audio:GetVoiceLength("story_v_out_101121", "101121013", "story_v_out_101121.awb") / 1000

					if var_55_39 + var_55_31 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_39 + var_55_31
					end

					if var_55_34.prefab_name ~= "" and arg_52_1.actors_[var_55_34.prefab_name] ~= nil then
						local var_55_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_34.prefab_name].transform, "story_v_out_101121", "101121013", "story_v_out_101121.awb")

						arg_52_1:RecordAudio("101121013", var_55_40)
						arg_52_1:RecordAudio("101121013", var_55_40)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_101121", "101121013", "story_v_out_101121.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_101121", "101121013", "story_v_out_101121.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_41 = math.max(var_55_32, arg_52_1.talkMaxDuration)

			if var_55_31 <= arg_52_1.time_ and arg_52_1.time_ < var_55_31 + var_55_41 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_31) / var_55_41

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_31 + var_55_41 and arg_52_1.time_ < var_55_31 + var_55_41 + arg_55_0 then
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
	Play101121014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 101121014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play101121015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.525

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_2 = arg_56_1:GetWordFromCfg(101121014)
				local var_59_3 = arg_56_1:FormatText(var_59_2.content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 21
				local var_59_5 = utf8.len(var_59_3)
				local var_59_6 = var_59_4 <= 0 and var_59_1 or var_59_1 * (var_59_5 / var_59_4)

				if var_59_6 > 0 and var_59_1 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_7 and arg_56_1.time_ < var_59_0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play101121015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 101121015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play101121016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 1.025

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_2 = arg_60_1:GetWordFromCfg(101121015)
				local var_63_3 = arg_60_1:FormatText(var_63_2.content)

				arg_60_1.text_.text = var_63_3

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 40
				local var_63_5 = utf8.len(var_63_3)
				local var_63_6 = var_63_4 <= 0 and var_63_1 or var_63_1 * (var_63_5 / var_63_4)

				if var_63_6 > 0 and var_63_1 < var_63_6 then
					arg_60_1.talkMaxDuration = var_63_6

					if var_63_6 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_6 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_3
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_7 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_7 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_7

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_7 and arg_60_1.time_ < var_63_0 + var_63_7 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play101121016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 101121016
		arg_64_1.duration_ = 2.63

		local var_64_0 = {
			ja = 2.633,
			ko = 1.999999999999,
			zh = 2.366,
			en = 1.999999999999
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
				arg_64_0:Play101121017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["10002ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect10002ui_story == nil then
				arg_64_1.var_.characterEffect10002ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.1

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect10002ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect10002ui_story then
				arg_64_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_67_4 = 0

			if var_67_4 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action5_2")
			end

			local var_67_5 = arg_64_1.actors_["10002ui_story"].transform
			local var_67_6 = 0

			if var_67_6 < arg_64_1.time_ and arg_64_1.time_ <= var_67_6 + arg_67_0 then
				arg_64_1.var_.moveOldPos10002ui_story = var_67_5.localPosition
			end

			local var_67_7 = 0.001

			if var_67_6 <= arg_64_1.time_ and arg_64_1.time_ < var_67_6 + var_67_7 then
				local var_67_8 = (arg_64_1.time_ - var_67_6) / var_67_7
				local var_67_9 = Vector3.New(-0.7, -1.2, -5.8)

				var_67_5.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10002ui_story, var_67_9, var_67_8)

				local var_67_10 = manager.ui.mainCamera.transform.position - var_67_5.position

				var_67_5.forward = Vector3.New(var_67_10.x, var_67_10.y, var_67_10.z)

				local var_67_11 = var_67_5.localEulerAngles

				var_67_11.z = 0
				var_67_11.x = 0
				var_67_5.localEulerAngles = var_67_11
			end

			if arg_64_1.time_ >= var_67_6 + var_67_7 and arg_64_1.time_ < var_67_6 + var_67_7 + arg_67_0 then
				var_67_5.localPosition = Vector3.New(-0.7, -1.2, -5.8)

				local var_67_12 = manager.ui.mainCamera.transform.position - var_67_5.position

				var_67_5.forward = Vector3.New(var_67_12.x, var_67_12.y, var_67_12.z)

				local var_67_13 = var_67_5.localEulerAngles

				var_67_13.z = 0
				var_67_13.x = 0
				var_67_5.localEulerAngles = var_67_13
			end

			local var_67_14 = 0

			if var_67_14 < arg_64_1.time_ and arg_64_1.time_ <= var_67_14 + arg_67_0 then
				arg_64_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_67_15 = 0
			local var_67_16 = 0.1

			if var_67_15 < arg_64_1.time_ and arg_64_1.time_ <= var_67_15 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_17 = arg_64_1:FormatText(StoryNameCfg[39].name)

				arg_64_1.leftNameTxt_.text = var_67_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_18 = arg_64_1:GetWordFromCfg(101121016)
				local var_67_19 = arg_64_1:FormatText(var_67_18.content)

				arg_64_1.text_.text = var_67_19

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_20 = 4
				local var_67_21 = utf8.len(var_67_19)
				local var_67_22 = var_67_20 <= 0 and var_67_16 or var_67_16 * (var_67_21 / var_67_20)

				if var_67_22 > 0 and var_67_16 < var_67_22 then
					arg_64_1.talkMaxDuration = var_67_22

					if var_67_22 + var_67_15 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_22 + var_67_15
					end
				end

				arg_64_1.text_.text = var_67_19
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121016", "story_v_out_101121.awb") ~= 0 then
					local var_67_23 = manager.audio:GetVoiceLength("story_v_out_101121", "101121016", "story_v_out_101121.awb") / 1000

					if var_67_23 + var_67_15 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_23 + var_67_15
					end

					if var_67_18.prefab_name ~= "" and arg_64_1.actors_[var_67_18.prefab_name] ~= nil then
						local var_67_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_18.prefab_name].transform, "story_v_out_101121", "101121016", "story_v_out_101121.awb")

						arg_64_1:RecordAudio("101121016", var_67_24)
						arg_64_1:RecordAudio("101121016", var_67_24)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_101121", "101121016", "story_v_out_101121.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_101121", "101121016", "story_v_out_101121.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_25 = math.max(var_67_16, arg_64_1.talkMaxDuration)

			if var_67_15 <= arg_64_1.time_ and arg_64_1.time_ < var_67_15 + var_67_25 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_15) / var_67_25

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_15 + var_67_25 and arg_64_1.time_ < var_67_15 + var_67_25 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
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

		arg_64_1:InitPlayNodeList()
	end,
	Play101121017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 101121017
		arg_68_1.duration_ = 12.5

		local var_68_0 = {
			ja = 12.5,
			ko = 8.533,
			zh = 9.233,
			en = 12.466
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
				arg_68_0:Play101121018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["10001_tpose"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect10001_tpose == nil then
				arg_68_1.var_.characterEffect10001_tpose = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.1

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect10001_tpose and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect10001_tpose then
				arg_68_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_71_4 = arg_68_1.actors_["10002ui_story"]
			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect10002ui_story == nil then
				arg_68_1.var_.characterEffect10002ui_story = var_71_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_6 = 0.1

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_6 and not isNil(var_71_4) then
				local var_71_7 = (arg_68_1.time_ - var_71_5) / var_71_6

				if arg_68_1.var_.characterEffect10002ui_story and not isNil(var_71_4) then
					local var_71_8 = Mathf.Lerp(0, 0.5, var_71_7)

					arg_68_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_68_1.var_.characterEffect10002ui_story.fillRatio = var_71_8
				end
			end

			if arg_68_1.time_ >= var_71_5 + var_71_6 and arg_68_1.time_ < var_71_5 + var_71_6 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect10002ui_story then
				local var_71_9 = 0.5

				arg_68_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_68_1.var_.characterEffect10002ui_story.fillRatio = var_71_9
			end

			local var_71_10 = arg_68_1.actors_["10001_tpose"].transform
			local var_71_11 = 0

			if var_71_11 < arg_68_1.time_ and arg_68_1.time_ <= var_71_11 + arg_71_0 then
				arg_68_1.var_.moveOldPos10001_tpose = var_71_10.localPosition

				local var_71_12 = GameObjectTools.GetOrAddComponent(var_71_10.gameObject, typeof(DynamicBoneHelper))

				if var_71_12 then
					var_71_12:EnableDynamicBone(false)
				end
			end

			local var_71_13 = 0.001

			if var_71_11 <= arg_68_1.time_ and arg_68_1.time_ < var_71_11 + var_71_13 then
				local var_71_14 = (arg_68_1.time_ - var_71_11) / var_71_13
				local var_71_15 = Vector3.New(0.7, -1.23, -5.8)

				var_71_10.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10001_tpose, var_71_15, var_71_14)

				local var_71_16 = manager.ui.mainCamera.transform.position - var_71_10.position

				var_71_10.forward = Vector3.New(var_71_16.x, var_71_16.y, var_71_16.z)

				local var_71_17 = var_71_10.localEulerAngles

				var_71_17.z = 0
				var_71_17.x = 0
				var_71_10.localEulerAngles = var_71_17
			end

			if arg_68_1.time_ >= var_71_11 + var_71_13 and arg_68_1.time_ < var_71_11 + var_71_13 + arg_71_0 then
				var_71_10.localPosition = Vector3.New(0.7, -1.23, -5.8)

				local var_71_18 = manager.ui.mainCamera.transform.position - var_71_10.position

				var_71_10.forward = Vector3.New(var_71_18.x, var_71_18.y, var_71_18.z)

				local var_71_19 = var_71_10.localEulerAngles

				var_71_19.z = 0
				var_71_19.x = 0
				var_71_10.localEulerAngles = var_71_19

				local var_71_20 = GameObjectTools.GetOrAddComponent(var_71_10.gameObject, typeof(DynamicBoneHelper))

				if var_71_20 then
					var_71_20:EnableDynamicBone(true)
				end
			end

			local var_71_21 = 0

			if var_71_21 < arg_68_1.time_ and arg_68_1.time_ <= var_71_21 + arg_71_0 then
				arg_68_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action2_1")
			end

			local var_71_22 = 0

			if var_71_22 < arg_68_1.time_ and arg_68_1.time_ <= var_71_22 + arg_71_0 then
				arg_68_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_71_23 = 0
			local var_71_24 = 1.15

			if var_71_23 < arg_68_1.time_ and arg_68_1.time_ <= var_71_23 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_25 = arg_68_1:FormatText(StoryNameCfg[31].name)

				arg_68_1.leftNameTxt_.text = var_71_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_26 = arg_68_1:GetWordFromCfg(101121017)
				local var_71_27 = arg_68_1:FormatText(var_71_26.content)

				arg_68_1.text_.text = var_71_27

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_28 = 46
				local var_71_29 = utf8.len(var_71_27)
				local var_71_30 = var_71_28 <= 0 and var_71_24 or var_71_24 * (var_71_29 / var_71_28)

				if var_71_30 > 0 and var_71_24 < var_71_30 then
					arg_68_1.talkMaxDuration = var_71_30

					if var_71_30 + var_71_23 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_30 + var_71_23
					end
				end

				arg_68_1.text_.text = var_71_27
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121017", "story_v_out_101121.awb") ~= 0 then
					local var_71_31 = manager.audio:GetVoiceLength("story_v_out_101121", "101121017", "story_v_out_101121.awb") / 1000

					if var_71_31 + var_71_23 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_31 + var_71_23
					end

					if var_71_26.prefab_name ~= "" and arg_68_1.actors_[var_71_26.prefab_name] ~= nil then
						local var_71_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_26.prefab_name].transform, "story_v_out_101121", "101121017", "story_v_out_101121.awb")

						arg_68_1:RecordAudio("101121017", var_71_32)
						arg_68_1:RecordAudio("101121017", var_71_32)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_101121", "101121017", "story_v_out_101121.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_101121", "101121017", "story_v_out_101121.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_33 = math.max(var_71_24, arg_68_1.talkMaxDuration)

			if var_71_23 <= arg_68_1.time_ and arg_68_1.time_ < var_71_23 + var_71_33 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_23) / var_71_33

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_23 + var_71_33 and arg_68_1.time_ < var_71_23 + var_71_33 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play101121018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 101121018
		arg_72_1.duration_ = 5.67

		local var_72_0 = {
			ja = 3.466,
			ko = 2.266,
			zh = 2.866,
			en = 5.666
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
				arg_72_0:Play101121019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["10001_tpose"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect10001_tpose == nil then
				arg_72_1.var_.characterEffect10001_tpose = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.2

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect10001_tpose and not isNil(var_75_0) then
					local var_75_4 = Mathf.Lerp(0, 0.5, var_75_3)

					arg_72_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_72_1.var_.characterEffect10001_tpose.fillRatio = var_75_4
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect10001_tpose then
				local var_75_5 = 0.5

				arg_72_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_72_1.var_.characterEffect10001_tpose.fillRatio = var_75_5
			end

			local var_75_6 = arg_72_1.actors_["10002ui_story"]
			local var_75_7 = 0

			if var_75_7 < arg_72_1.time_ and arg_72_1.time_ <= var_75_7 + arg_75_0 and not isNil(var_75_6) and arg_72_1.var_.characterEffect10002ui_story == nil then
				arg_72_1.var_.characterEffect10002ui_story = var_75_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_8 = 0.2

			if var_75_7 <= arg_72_1.time_ and arg_72_1.time_ < var_75_7 + var_75_8 and not isNil(var_75_6) then
				local var_75_9 = (arg_72_1.time_ - var_75_7) / var_75_8

				if arg_72_1.var_.characterEffect10002ui_story and not isNil(var_75_6) then
					arg_72_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_7 + var_75_8 and arg_72_1.time_ < var_75_7 + var_75_8 + arg_75_0 and not isNil(var_75_6) and arg_72_1.var_.characterEffect10002ui_story then
				arg_72_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_75_10 = 0

			if var_75_10 < arg_72_1.time_ and arg_72_1.time_ <= var_75_10 + arg_75_0 then
				arg_72_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_75_11 = 0
			local var_75_12 = 0.35

			if var_75_11 < arg_72_1.time_ and arg_72_1.time_ <= var_75_11 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_13 = arg_72_1:FormatText(StoryNameCfg[39].name)

				arg_72_1.leftNameTxt_.text = var_75_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_14 = arg_72_1:GetWordFromCfg(101121018)
				local var_75_15 = arg_72_1:FormatText(var_75_14.content)

				arg_72_1.text_.text = var_75_15

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_16 = 6
				local var_75_17 = utf8.len(var_75_15)
				local var_75_18 = var_75_16 <= 0 and var_75_12 or var_75_12 * (var_75_17 / var_75_16)

				if var_75_18 > 0 and var_75_12 < var_75_18 then
					arg_72_1.talkMaxDuration = var_75_18

					if var_75_18 + var_75_11 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_18 + var_75_11
					end
				end

				arg_72_1.text_.text = var_75_15
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121018", "story_v_out_101121.awb") ~= 0 then
					local var_75_19 = manager.audio:GetVoiceLength("story_v_out_101121", "101121018", "story_v_out_101121.awb") / 1000

					if var_75_19 + var_75_11 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_19 + var_75_11
					end

					if var_75_14.prefab_name ~= "" and arg_72_1.actors_[var_75_14.prefab_name] ~= nil then
						local var_75_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_14.prefab_name].transform, "story_v_out_101121", "101121018", "story_v_out_101121.awb")

						arg_72_1:RecordAudio("101121018", var_75_20)
						arg_72_1:RecordAudio("101121018", var_75_20)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_101121", "101121018", "story_v_out_101121.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_101121", "101121018", "story_v_out_101121.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_21 = math.max(var_75_12, arg_72_1.talkMaxDuration)

			if var_75_11 <= arg_72_1.time_ and arg_72_1.time_ < var_75_11 + var_75_21 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_11) / var_75_21

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_11 + var_75_21 and arg_72_1.time_ < var_75_11 + var_75_21 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play101121019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 101121019
		arg_76_1.duration_ = 3.8

		local var_76_0 = {
			ja = 1.999999999999,
			ko = 3.8,
			zh = 3,
			en = 3.733
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
				arg_76_0:Play101121020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["10001_tpose"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect10001_tpose == nil then
				arg_76_1.var_.characterEffect10001_tpose = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.2

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect10001_tpose and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect10001_tpose then
				arg_76_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_79_4 = arg_76_1.actors_["10002ui_story"]
			local var_79_5 = 0

			if var_79_5 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect10002ui_story == nil then
				arg_76_1.var_.characterEffect10002ui_story = var_79_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_6 = 0.2

			if var_79_5 <= arg_76_1.time_ and arg_76_1.time_ < var_79_5 + var_79_6 and not isNil(var_79_4) then
				local var_79_7 = (arg_76_1.time_ - var_79_5) / var_79_6

				if arg_76_1.var_.characterEffect10002ui_story and not isNil(var_79_4) then
					local var_79_8 = Mathf.Lerp(0, 0.5, var_79_7)

					arg_76_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_76_1.var_.characterEffect10002ui_story.fillRatio = var_79_8
				end
			end

			if arg_76_1.time_ >= var_79_5 + var_79_6 and arg_76_1.time_ < var_79_5 + var_79_6 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect10002ui_story then
				local var_79_9 = 0.5

				arg_76_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_76_1.var_.characterEffect10002ui_story.fillRatio = var_79_9
			end

			local var_79_10 = 0

			if var_79_10 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 then
				arg_76_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action424")
			end

			local var_79_11 = 0

			if var_79_11 < arg_76_1.time_ and arg_76_1.time_ <= var_79_11 + arg_79_0 then
				arg_76_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_79_12 = 0
			local var_79_13 = 0.35

			if var_79_12 < arg_76_1.time_ and arg_76_1.time_ <= var_79_12 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_14 = arg_76_1:FormatText(StoryNameCfg[31].name)

				arg_76_1.leftNameTxt_.text = var_79_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_15 = arg_76_1:GetWordFromCfg(101121019)
				local var_79_16 = arg_76_1:FormatText(var_79_15.content)

				arg_76_1.text_.text = var_79_16

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_17 = 14
				local var_79_18 = utf8.len(var_79_16)
				local var_79_19 = var_79_17 <= 0 and var_79_13 or var_79_13 * (var_79_18 / var_79_17)

				if var_79_19 > 0 and var_79_13 < var_79_19 then
					arg_76_1.talkMaxDuration = var_79_19

					if var_79_19 + var_79_12 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_19 + var_79_12
					end
				end

				arg_76_1.text_.text = var_79_16
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121019", "story_v_out_101121.awb") ~= 0 then
					local var_79_20 = manager.audio:GetVoiceLength("story_v_out_101121", "101121019", "story_v_out_101121.awb") / 1000

					if var_79_20 + var_79_12 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_20 + var_79_12
					end

					if var_79_15.prefab_name ~= "" and arg_76_1.actors_[var_79_15.prefab_name] ~= nil then
						local var_79_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_15.prefab_name].transform, "story_v_out_101121", "101121019", "story_v_out_101121.awb")

						arg_76_1:RecordAudio("101121019", var_79_21)
						arg_76_1:RecordAudio("101121019", var_79_21)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_101121", "101121019", "story_v_out_101121.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_101121", "101121019", "story_v_out_101121.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_22 = math.max(var_79_13, arg_76_1.talkMaxDuration)

			if var_79_12 <= arg_76_1.time_ and arg_76_1.time_ < var_79_12 + var_79_22 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_12) / var_79_22

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_12 + var_79_22 and arg_76_1.time_ < var_79_12 + var_79_22 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play101121020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 101121020
		arg_80_1.duration_ = 14.57

		local var_80_0 = {
			ja = 14.566,
			ko = 8.6,
			zh = 9.033,
			en = 11.5
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
				arg_80_0:Play101121021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_83_1 = 0
			local var_83_2 = 1.15

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_3 = arg_80_1:FormatText(StoryNameCfg[31].name)

				arg_80_1.leftNameTxt_.text = var_83_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_4 = arg_80_1:GetWordFromCfg(101121020)
				local var_83_5 = arg_80_1:FormatText(var_83_4.content)

				arg_80_1.text_.text = var_83_5

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_6 = 46
				local var_83_7 = utf8.len(var_83_5)
				local var_83_8 = var_83_6 <= 0 and var_83_2 or var_83_2 * (var_83_7 / var_83_6)

				if var_83_8 > 0 and var_83_2 < var_83_8 then
					arg_80_1.talkMaxDuration = var_83_8

					if var_83_8 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_5
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121020", "story_v_out_101121.awb") ~= 0 then
					local var_83_9 = manager.audio:GetVoiceLength("story_v_out_101121", "101121020", "story_v_out_101121.awb") / 1000

					if var_83_9 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_1
					end

					if var_83_4.prefab_name ~= "" and arg_80_1.actors_[var_83_4.prefab_name] ~= nil then
						local var_83_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_4.prefab_name].transform, "story_v_out_101121", "101121020", "story_v_out_101121.awb")

						arg_80_1:RecordAudio("101121020", var_83_10)
						arg_80_1:RecordAudio("101121020", var_83_10)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_101121", "101121020", "story_v_out_101121.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_101121", "101121020", "story_v_out_101121.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_11 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_11 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_11

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_11 and arg_80_1.time_ < var_83_1 + var_83_11 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play101121021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 101121021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play101121022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["10001_tpose"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect10001_tpose == nil then
				arg_84_1.var_.characterEffect10001_tpose = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.1

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect10001_tpose and not isNil(var_87_0) then
					local var_87_4 = Mathf.Lerp(0, 0.5, var_87_3)

					arg_84_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_84_1.var_.characterEffect10001_tpose.fillRatio = var_87_4
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect10001_tpose then
				local var_87_5 = 0.5

				arg_84_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_84_1.var_.characterEffect10001_tpose.fillRatio = var_87_5
			end

			local var_87_6 = 0
			local var_87_7 = 0.875

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_8 = arg_84_1:GetWordFromCfg(101121021)
				local var_87_9 = arg_84_1:FormatText(var_87_8.content)

				arg_84_1.text_.text = var_87_9

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_10 = 35
				local var_87_11 = utf8.len(var_87_9)
				local var_87_12 = var_87_10 <= 0 and var_87_7 or var_87_7 * (var_87_11 / var_87_10)

				if var_87_12 > 0 and var_87_7 < var_87_12 then
					arg_84_1.talkMaxDuration = var_87_12

					if var_87_12 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_12 + var_87_6
					end
				end

				arg_84_1.text_.text = var_87_9
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_13 = math.max(var_87_7, arg_84_1.talkMaxDuration)

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_13 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_6) / var_87_13

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_6 + var_87_13 and arg_84_1.time_ < var_87_6 + var_87_13 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play101121022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 101121022
		arg_88_1.duration_ = 6

		local var_88_0 = {
			ja = 2.433,
			ko = 1.999999999999,
			zh = 3.5,
			en = 6
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
				arg_88_0:Play101121023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["10002ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect10002ui_story == nil then
				arg_88_1.var_.characterEffect10002ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.1

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect10002ui_story and not isNil(var_91_0) then
					arg_88_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect10002ui_story then
				arg_88_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_91_4 = 0

			if var_91_4 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_91_5 = 0
			local var_91_6 = 0.15

			if var_91_5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_7 = arg_88_1:FormatText(StoryNameCfg[39].name)

				arg_88_1.leftNameTxt_.text = var_91_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_8 = arg_88_1:GetWordFromCfg(101121022)
				local var_91_9 = arg_88_1:FormatText(var_91_8.content)

				arg_88_1.text_.text = var_91_9

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_10 = 6
				local var_91_11 = utf8.len(var_91_9)
				local var_91_12 = var_91_10 <= 0 and var_91_6 or var_91_6 * (var_91_11 / var_91_10)

				if var_91_12 > 0 and var_91_6 < var_91_12 then
					arg_88_1.talkMaxDuration = var_91_12

					if var_91_12 + var_91_5 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_12 + var_91_5
					end
				end

				arg_88_1.text_.text = var_91_9
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121022", "story_v_out_101121.awb") ~= 0 then
					local var_91_13 = manager.audio:GetVoiceLength("story_v_out_101121", "101121022", "story_v_out_101121.awb") / 1000

					if var_91_13 + var_91_5 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_5
					end

					if var_91_8.prefab_name ~= "" and arg_88_1.actors_[var_91_8.prefab_name] ~= nil then
						local var_91_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_8.prefab_name].transform, "story_v_out_101121", "101121022", "story_v_out_101121.awb")

						arg_88_1:RecordAudio("101121022", var_91_14)
						arg_88_1:RecordAudio("101121022", var_91_14)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_101121", "101121022", "story_v_out_101121.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_101121", "101121022", "story_v_out_101121.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_15 = math.max(var_91_6, arg_88_1.talkMaxDuration)

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_15 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_5) / var_91_15

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_5 + var_91_15 and arg_88_1.time_ < var_91_5 + var_91_15 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play101121023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 101121023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play101121024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["10002ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect10002ui_story == nil then
				arg_92_1.var_.characterEffect10002ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.1

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect10002ui_story and not isNil(var_95_0) then
					local var_95_4 = Mathf.Lerp(0, 0.5, var_95_3)

					arg_92_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_92_1.var_.characterEffect10002ui_story.fillRatio = var_95_4
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect10002ui_story then
				local var_95_5 = 0.5

				arg_92_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_92_1.var_.characterEffect10002ui_story.fillRatio = var_95_5
			end

			local var_95_6 = arg_92_1.actors_["10001_tpose"].transform
			local var_95_7 = 0

			if var_95_7 < arg_92_1.time_ and arg_92_1.time_ <= var_95_7 + arg_95_0 then
				arg_92_1.var_.moveOldPos10001_tpose = var_95_6.localPosition

				local var_95_8 = GameObjectTools.GetOrAddComponent(var_95_6.gameObject, typeof(DynamicBoneHelper))

				if var_95_8 then
					var_95_8:EnableDynamicBone(false)
				end
			end

			local var_95_9 = 0.001

			if var_95_7 <= arg_92_1.time_ and arg_92_1.time_ < var_95_7 + var_95_9 then
				local var_95_10 = (arg_92_1.time_ - var_95_7) / var_95_9
				local var_95_11 = Vector3.New(0, 100, 0)

				var_95_6.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10001_tpose, var_95_11, var_95_10)

				local var_95_12 = manager.ui.mainCamera.transform.position - var_95_6.position

				var_95_6.forward = Vector3.New(var_95_12.x, var_95_12.y, var_95_12.z)

				local var_95_13 = var_95_6.localEulerAngles

				var_95_13.z = 0
				var_95_13.x = 0
				var_95_6.localEulerAngles = var_95_13
			end

			if arg_92_1.time_ >= var_95_7 + var_95_9 and arg_92_1.time_ < var_95_7 + var_95_9 + arg_95_0 then
				var_95_6.localPosition = Vector3.New(0, 100, 0)

				local var_95_14 = manager.ui.mainCamera.transform.position - var_95_6.position

				var_95_6.forward = Vector3.New(var_95_14.x, var_95_14.y, var_95_14.z)

				local var_95_15 = var_95_6.localEulerAngles

				var_95_15.z = 0
				var_95_15.x = 0
				var_95_6.localEulerAngles = var_95_15

				local var_95_16 = GameObjectTools.GetOrAddComponent(var_95_6.gameObject, typeof(DynamicBoneHelper))

				if var_95_16 then
					var_95_16:EnableDynamicBone(true)
				end
			end

			local var_95_17 = arg_92_1.actors_["10002ui_story"].transform
			local var_95_18 = 0

			if var_95_18 < arg_92_1.time_ and arg_92_1.time_ <= var_95_18 + arg_95_0 then
				arg_92_1.var_.moveOldPos10002ui_story = var_95_17.localPosition
			end

			local var_95_19 = 0.001

			if var_95_18 <= arg_92_1.time_ and arg_92_1.time_ < var_95_18 + var_95_19 then
				local var_95_20 = (arg_92_1.time_ - var_95_18) / var_95_19
				local var_95_21 = Vector3.New(0, 100, 0)

				var_95_17.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10002ui_story, var_95_21, var_95_20)

				local var_95_22 = manager.ui.mainCamera.transform.position - var_95_17.position

				var_95_17.forward = Vector3.New(var_95_22.x, var_95_22.y, var_95_22.z)

				local var_95_23 = var_95_17.localEulerAngles

				var_95_23.z = 0
				var_95_23.x = 0
				var_95_17.localEulerAngles = var_95_23
			end

			if arg_92_1.time_ >= var_95_18 + var_95_19 and arg_92_1.time_ < var_95_18 + var_95_19 + arg_95_0 then
				var_95_17.localPosition = Vector3.New(0, 100, 0)

				local var_95_24 = manager.ui.mainCamera.transform.position - var_95_17.position

				var_95_17.forward = Vector3.New(var_95_24.x, var_95_24.y, var_95_24.z)

				local var_95_25 = var_95_17.localEulerAngles

				var_95_25.z = 0
				var_95_25.x = 0
				var_95_17.localEulerAngles = var_95_25
			end

			local var_95_26 = 0
			local var_95_27 = 1

			if var_95_26 < arg_92_1.time_ and arg_92_1.time_ <= var_95_26 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_28 = arg_92_1:GetWordFromCfg(101121023)
				local var_95_29 = arg_92_1:FormatText(var_95_28.content)

				arg_92_1.text_.text = var_95_29

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_30 = 40
				local var_95_31 = utf8.len(var_95_29)
				local var_95_32 = var_95_30 <= 0 and var_95_27 or var_95_27 * (var_95_31 / var_95_30)

				if var_95_32 > 0 and var_95_27 < var_95_32 then
					arg_92_1.talkMaxDuration = var_95_32

					if var_95_32 + var_95_26 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_32 + var_95_26
					end
				end

				arg_92_1.text_.text = var_95_29
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_33 = math.max(var_95_27, arg_92_1.talkMaxDuration)

			if var_95_26 <= arg_92_1.time_ and arg_92_1.time_ < var_95_26 + var_95_33 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_26) / var_95_33

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_26 + var_95_33 and arg_92_1.time_ < var_95_26 + var_95_33 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
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

		arg_92_1:InitPlayNodeList()
	end,
	Play101121024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 101121024
		arg_96_1.duration_ = 10.93

		local var_96_0 = {
			ja = 7.133,
			ko = 7.066,
			zh = 10.933,
			en = 9.433
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
				arg_96_0:Play101121025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["10002ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect10002ui_story == nil then
				arg_96_1.var_.characterEffect10002ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.1

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect10002ui_story and not isNil(var_99_0) then
					arg_96_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect10002ui_story then
				arg_96_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_99_4 = 0

			if var_99_4 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action5_2")
			end

			local var_99_5 = arg_96_1.actors_["10002ui_story"].transform
			local var_99_6 = 0

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.var_.moveOldPos10002ui_story = var_99_5.localPosition
			end

			local var_99_7 = 0.001

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_7 then
				local var_99_8 = (arg_96_1.time_ - var_99_6) / var_99_7
				local var_99_9 = Vector3.New(0, -1.2, -5.8)

				var_99_5.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10002ui_story, var_99_9, var_99_8)

				local var_99_10 = manager.ui.mainCamera.transform.position - var_99_5.position

				var_99_5.forward = Vector3.New(var_99_10.x, var_99_10.y, var_99_10.z)

				local var_99_11 = var_99_5.localEulerAngles

				var_99_11.z = 0
				var_99_11.x = 0
				var_99_5.localEulerAngles = var_99_11
			end

			if arg_96_1.time_ >= var_99_6 + var_99_7 and arg_96_1.time_ < var_99_6 + var_99_7 + arg_99_0 then
				var_99_5.localPosition = Vector3.New(0, -1.2, -5.8)

				local var_99_12 = manager.ui.mainCamera.transform.position - var_99_5.position

				var_99_5.forward = Vector3.New(var_99_12.x, var_99_12.y, var_99_12.z)

				local var_99_13 = var_99_5.localEulerAngles

				var_99_13.z = 0
				var_99_13.x = 0
				var_99_5.localEulerAngles = var_99_13
			end

			local var_99_14 = 0

			if var_99_14 < arg_96_1.time_ and arg_96_1.time_ <= var_99_14 + arg_99_0 then
				arg_96_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_99_15 = 0
			local var_99_16 = 0.65

			if var_99_15 < arg_96_1.time_ and arg_96_1.time_ <= var_99_15 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_17 = arg_96_1:FormatText(StoryNameCfg[39].name)

				arg_96_1.leftNameTxt_.text = var_99_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_18 = arg_96_1:GetWordFromCfg(101121024)
				local var_99_19 = arg_96_1:FormatText(var_99_18.content)

				arg_96_1.text_.text = var_99_19

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_20 = 26
				local var_99_21 = utf8.len(var_99_19)
				local var_99_22 = var_99_20 <= 0 and var_99_16 or var_99_16 * (var_99_21 / var_99_20)

				if var_99_22 > 0 and var_99_16 < var_99_22 then
					arg_96_1.talkMaxDuration = var_99_22

					if var_99_22 + var_99_15 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_22 + var_99_15
					end
				end

				arg_96_1.text_.text = var_99_19
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121024", "story_v_out_101121.awb") ~= 0 then
					local var_99_23 = manager.audio:GetVoiceLength("story_v_out_101121", "101121024", "story_v_out_101121.awb") / 1000

					if var_99_23 + var_99_15 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_23 + var_99_15
					end

					if var_99_18.prefab_name ~= "" and arg_96_1.actors_[var_99_18.prefab_name] ~= nil then
						local var_99_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_18.prefab_name].transform, "story_v_out_101121", "101121024", "story_v_out_101121.awb")

						arg_96_1:RecordAudio("101121024", var_99_24)
						arg_96_1:RecordAudio("101121024", var_99_24)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_101121", "101121024", "story_v_out_101121.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_101121", "101121024", "story_v_out_101121.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_25 = math.max(var_99_16, arg_96_1.talkMaxDuration)

			if var_99_15 <= arg_96_1.time_ and arg_96_1.time_ < var_99_15 + var_99_25 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_15) / var_99_25

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_15 + var_99_25 and arg_96_1.time_ < var_99_15 + var_99_25 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
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

		arg_96_1:InitPlayNodeList()
	end,
	Play101121025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 101121025
		arg_100_1.duration_ = 5.5

		local var_100_0 = {
			ja = 5.5,
			ko = 5.266,
			zh = 4.366,
			en = 4.233
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
				arg_100_0:Play101121026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["10001_tpose"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect10001_tpose == nil then
				arg_100_1.var_.characterEffect10001_tpose = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.1

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect10001_tpose and not isNil(var_103_0) then
					arg_100_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect10001_tpose then
				arg_100_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_103_4 = arg_100_1.actors_["10002ui_story"]
			local var_103_5 = 0

			if var_103_5 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect10002ui_story == nil then
				arg_100_1.var_.characterEffect10002ui_story = var_103_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_6 = 0.1

			if var_103_5 <= arg_100_1.time_ and arg_100_1.time_ < var_103_5 + var_103_6 and not isNil(var_103_4) then
				local var_103_7 = (arg_100_1.time_ - var_103_5) / var_103_6

				if arg_100_1.var_.characterEffect10002ui_story and not isNil(var_103_4) then
					local var_103_8 = Mathf.Lerp(0, 0.5, var_103_7)

					arg_100_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_100_1.var_.characterEffect10002ui_story.fillRatio = var_103_8
				end
			end

			if arg_100_1.time_ >= var_103_5 + var_103_6 and arg_100_1.time_ < var_103_5 + var_103_6 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect10002ui_story then
				local var_103_9 = 0.5

				arg_100_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_100_1.var_.characterEffect10002ui_story.fillRatio = var_103_9
			end

			local var_103_10 = arg_100_1.actors_["10002ui_story"].transform
			local var_103_11 = 0

			if var_103_11 < arg_100_1.time_ and arg_100_1.time_ <= var_103_11 + arg_103_0 then
				arg_100_1.var_.moveOldPos10002ui_story = var_103_10.localPosition
			end

			local var_103_12 = 0.001

			if var_103_11 <= arg_100_1.time_ and arg_100_1.time_ < var_103_11 + var_103_12 then
				local var_103_13 = (arg_100_1.time_ - var_103_11) / var_103_12
				local var_103_14 = Vector3.New(0, 100, 0)

				var_103_10.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10002ui_story, var_103_14, var_103_13)

				local var_103_15 = manager.ui.mainCamera.transform.position - var_103_10.position

				var_103_10.forward = Vector3.New(var_103_15.x, var_103_15.y, var_103_15.z)

				local var_103_16 = var_103_10.localEulerAngles

				var_103_16.z = 0
				var_103_16.x = 0
				var_103_10.localEulerAngles = var_103_16
			end

			if arg_100_1.time_ >= var_103_11 + var_103_12 and arg_100_1.time_ < var_103_11 + var_103_12 + arg_103_0 then
				var_103_10.localPosition = Vector3.New(0, 100, 0)

				local var_103_17 = manager.ui.mainCamera.transform.position - var_103_10.position

				var_103_10.forward = Vector3.New(var_103_17.x, var_103_17.y, var_103_17.z)

				local var_103_18 = var_103_10.localEulerAngles

				var_103_18.z = 0
				var_103_18.x = 0
				var_103_10.localEulerAngles = var_103_18
			end

			local var_103_19 = arg_100_1.actors_["10001_tpose"].transform
			local var_103_20 = 0

			if var_103_20 < arg_100_1.time_ and arg_100_1.time_ <= var_103_20 + arg_103_0 then
				arg_100_1.var_.moveOldPos10001_tpose = var_103_19.localPosition

				local var_103_21 = GameObjectTools.GetOrAddComponent(var_103_19.gameObject, typeof(DynamicBoneHelper))

				if var_103_21 then
					var_103_21:EnableDynamicBone(false)
				end
			end

			local var_103_22 = 0.001

			if var_103_20 <= arg_100_1.time_ and arg_100_1.time_ < var_103_20 + var_103_22 then
				local var_103_23 = (arg_100_1.time_ - var_103_20) / var_103_22
				local var_103_24 = Vector3.New(0, -1.23, -5.8)

				var_103_19.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10001_tpose, var_103_24, var_103_23)

				local var_103_25 = manager.ui.mainCamera.transform.position - var_103_19.position

				var_103_19.forward = Vector3.New(var_103_25.x, var_103_25.y, var_103_25.z)

				local var_103_26 = var_103_19.localEulerAngles

				var_103_26.z = 0
				var_103_26.x = 0
				var_103_19.localEulerAngles = var_103_26
			end

			if arg_100_1.time_ >= var_103_20 + var_103_22 and arg_100_1.time_ < var_103_20 + var_103_22 + arg_103_0 then
				var_103_19.localPosition = Vector3.New(0, -1.23, -5.8)

				local var_103_27 = manager.ui.mainCamera.transform.position - var_103_19.position

				var_103_19.forward = Vector3.New(var_103_27.x, var_103_27.y, var_103_27.z)

				local var_103_28 = var_103_19.localEulerAngles

				var_103_28.z = 0
				var_103_28.x = 0
				var_103_19.localEulerAngles = var_103_28

				local var_103_29 = GameObjectTools.GetOrAddComponent(var_103_19.gameObject, typeof(DynamicBoneHelper))

				if var_103_29 then
					var_103_29:EnableDynamicBone(true)
				end
			end

			local var_103_30 = 0

			if var_103_30 < arg_100_1.time_ and arg_100_1.time_ <= var_103_30 + arg_103_0 then
				arg_100_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action4_1")
			end

			local var_103_31 = 0

			if var_103_31 < arg_100_1.time_ and arg_100_1.time_ <= var_103_31 + arg_103_0 then
				arg_100_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_103_32 = 0
			local var_103_33 = 0.55

			if var_103_32 < arg_100_1.time_ and arg_100_1.time_ <= var_103_32 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_34 = arg_100_1:FormatText(StoryNameCfg[31].name)

				arg_100_1.leftNameTxt_.text = var_103_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_35 = arg_100_1:GetWordFromCfg(101121025)
				local var_103_36 = arg_100_1:FormatText(var_103_35.content)

				arg_100_1.text_.text = var_103_36

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_37 = 22
				local var_103_38 = utf8.len(var_103_36)
				local var_103_39 = var_103_37 <= 0 and var_103_33 or var_103_33 * (var_103_38 / var_103_37)

				if var_103_39 > 0 and var_103_33 < var_103_39 then
					arg_100_1.talkMaxDuration = var_103_39

					if var_103_39 + var_103_32 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_39 + var_103_32
					end
				end

				arg_100_1.text_.text = var_103_36
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121025", "story_v_out_101121.awb") ~= 0 then
					local var_103_40 = manager.audio:GetVoiceLength("story_v_out_101121", "101121025", "story_v_out_101121.awb") / 1000

					if var_103_40 + var_103_32 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_40 + var_103_32
					end

					if var_103_35.prefab_name ~= "" and arg_100_1.actors_[var_103_35.prefab_name] ~= nil then
						local var_103_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_35.prefab_name].transform, "story_v_out_101121", "101121025", "story_v_out_101121.awb")

						arg_100_1:RecordAudio("101121025", var_103_41)
						arg_100_1:RecordAudio("101121025", var_103_41)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_101121", "101121025", "story_v_out_101121.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_101121", "101121025", "story_v_out_101121.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_42 = math.max(var_103_33, arg_100_1.talkMaxDuration)

			if var_103_32 <= arg_100_1.time_ and arg_100_1.time_ < var_103_32 + var_103_42 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_32) / var_103_42

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_32 + var_103_42 and arg_100_1.time_ < var_103_32 + var_103_42 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
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
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play101121026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 101121026
		arg_104_1.duration_ = 11.4

		local var_104_0 = {
			ja = 9,
			ko = 6.233,
			zh = 7.4,
			en = 11.4
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
				arg_104_0:Play101121027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action442")
			end

			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_107_2 = 0
			local var_107_3 = 0.875

			if var_107_2 < arg_104_1.time_ and arg_104_1.time_ <= var_107_2 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_4 = arg_104_1:FormatText(StoryNameCfg[31].name)

				arg_104_1.leftNameTxt_.text = var_107_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_5 = arg_104_1:GetWordFromCfg(101121026)
				local var_107_6 = arg_104_1:FormatText(var_107_5.content)

				arg_104_1.text_.text = var_107_6

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_7 = 35
				local var_107_8 = utf8.len(var_107_6)
				local var_107_9 = var_107_7 <= 0 and var_107_3 or var_107_3 * (var_107_8 / var_107_7)

				if var_107_9 > 0 and var_107_3 < var_107_9 then
					arg_104_1.talkMaxDuration = var_107_9

					if var_107_9 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_9 + var_107_2
					end
				end

				arg_104_1.text_.text = var_107_6
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121026", "story_v_out_101121.awb") ~= 0 then
					local var_107_10 = manager.audio:GetVoiceLength("story_v_out_101121", "101121026", "story_v_out_101121.awb") / 1000

					if var_107_10 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_10 + var_107_2
					end

					if var_107_5.prefab_name ~= "" and arg_104_1.actors_[var_107_5.prefab_name] ~= nil then
						local var_107_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_5.prefab_name].transform, "story_v_out_101121", "101121026", "story_v_out_101121.awb")

						arg_104_1:RecordAudio("101121026", var_107_11)
						arg_104_1:RecordAudio("101121026", var_107_11)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_101121", "101121026", "story_v_out_101121.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_101121", "101121026", "story_v_out_101121.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_12 = math.max(var_107_3, arg_104_1.talkMaxDuration)

			if var_107_2 <= arg_104_1.time_ and arg_104_1.time_ < var_107_2 + var_107_12 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_2) / var_107_12

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_2 + var_107_12 and arg_104_1.time_ < var_107_2 + var_107_12 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play101121027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 101121027
		arg_108_1.duration_ = 13.83

		local var_108_0 = {
			ja = 13.833,
			ko = 7.966,
			zh = 11.033,
			en = 10.066
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
				arg_108_0:Play101121028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_111_1 = 0
			local var_111_2 = 1.2

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_3 = arg_108_1:FormatText(StoryNameCfg[31].name)

				arg_108_1.leftNameTxt_.text = var_111_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_4 = arg_108_1:GetWordFromCfg(101121027)
				local var_111_5 = arg_108_1:FormatText(var_111_4.content)

				arg_108_1.text_.text = var_111_5

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_6 = 48
				local var_111_7 = utf8.len(var_111_5)
				local var_111_8 = var_111_6 <= 0 and var_111_2 or var_111_2 * (var_111_7 / var_111_6)

				if var_111_8 > 0 and var_111_2 < var_111_8 then
					arg_108_1.talkMaxDuration = var_111_8

					if var_111_8 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_1
					end
				end

				arg_108_1.text_.text = var_111_5
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121027", "story_v_out_101121.awb") ~= 0 then
					local var_111_9 = manager.audio:GetVoiceLength("story_v_out_101121", "101121027", "story_v_out_101121.awb") / 1000

					if var_111_9 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_9 + var_111_1
					end

					if var_111_4.prefab_name ~= "" and arg_108_1.actors_[var_111_4.prefab_name] ~= nil then
						local var_111_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_4.prefab_name].transform, "story_v_out_101121", "101121027", "story_v_out_101121.awb")

						arg_108_1:RecordAudio("101121027", var_111_10)
						arg_108_1:RecordAudio("101121027", var_111_10)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_101121", "101121027", "story_v_out_101121.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_101121", "101121027", "story_v_out_101121.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_11 = math.max(var_111_2, arg_108_1.talkMaxDuration)

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_11 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_1) / var_111_11

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_1 + var_111_11 and arg_108_1.time_ < var_111_1 + var_111_11 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play101121028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 101121028
		arg_112_1.duration_ = 8.97

		local var_112_0 = {
			ja = 6.333,
			ko = 7.866,
			zh = 5,
			en = 8.966
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
				arg_112_0:Play101121029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["10002ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect10002ui_story == nil then
				arg_112_1.var_.characterEffect10002ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.1

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect10002ui_story and not isNil(var_115_0) then
					arg_112_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect10002ui_story then
				arg_112_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_115_4 = arg_112_1.actors_["10001_tpose"]
			local var_115_5 = 0

			if var_115_5 < arg_112_1.time_ and arg_112_1.time_ <= var_115_5 + arg_115_0 and not isNil(var_115_4) and arg_112_1.var_.characterEffect10001_tpose == nil then
				arg_112_1.var_.characterEffect10001_tpose = var_115_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_6 = 0.1

			if var_115_5 <= arg_112_1.time_ and arg_112_1.time_ < var_115_5 + var_115_6 and not isNil(var_115_4) then
				local var_115_7 = (arg_112_1.time_ - var_115_5) / var_115_6

				if arg_112_1.var_.characterEffect10001_tpose and not isNil(var_115_4) then
					local var_115_8 = Mathf.Lerp(0, 0.5, var_115_7)

					arg_112_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_112_1.var_.characterEffect10001_tpose.fillRatio = var_115_8
				end
			end

			if arg_112_1.time_ >= var_115_5 + var_115_6 and arg_112_1.time_ < var_115_5 + var_115_6 + arg_115_0 and not isNil(var_115_4) and arg_112_1.var_.characterEffect10001_tpose then
				local var_115_9 = 0.5

				arg_112_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_112_1.var_.characterEffect10001_tpose.fillRatio = var_115_9
			end

			local var_115_10 = arg_112_1.actors_["10001_tpose"].transform
			local var_115_11 = 0

			if var_115_11 < arg_112_1.time_ and arg_112_1.time_ <= var_115_11 + arg_115_0 then
				arg_112_1.var_.moveOldPos10001_tpose = var_115_10.localPosition

				local var_115_12 = GameObjectTools.GetOrAddComponent(var_115_10.gameObject, typeof(DynamicBoneHelper))

				if var_115_12 then
					var_115_12:EnableDynamicBone(false)
				end
			end

			local var_115_13 = 0.001

			if var_115_11 <= arg_112_1.time_ and arg_112_1.time_ < var_115_11 + var_115_13 then
				local var_115_14 = (arg_112_1.time_ - var_115_11) / var_115_13
				local var_115_15 = Vector3.New(0, 100, 0)

				var_115_10.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10001_tpose, var_115_15, var_115_14)

				local var_115_16 = manager.ui.mainCamera.transform.position - var_115_10.position

				var_115_10.forward = Vector3.New(var_115_16.x, var_115_16.y, var_115_16.z)

				local var_115_17 = var_115_10.localEulerAngles

				var_115_17.z = 0
				var_115_17.x = 0
				var_115_10.localEulerAngles = var_115_17
			end

			if arg_112_1.time_ >= var_115_11 + var_115_13 and arg_112_1.time_ < var_115_11 + var_115_13 + arg_115_0 then
				var_115_10.localPosition = Vector3.New(0, 100, 0)

				local var_115_18 = manager.ui.mainCamera.transform.position - var_115_10.position

				var_115_10.forward = Vector3.New(var_115_18.x, var_115_18.y, var_115_18.z)

				local var_115_19 = var_115_10.localEulerAngles

				var_115_19.z = 0
				var_115_19.x = 0
				var_115_10.localEulerAngles = var_115_19

				local var_115_20 = GameObjectTools.GetOrAddComponent(var_115_10.gameObject, typeof(DynamicBoneHelper))

				if var_115_20 then
					var_115_20:EnableDynamicBone(true)
				end
			end

			local var_115_21 = 0

			if var_115_21 < arg_112_1.time_ and arg_112_1.time_ <= var_115_21 + arg_115_0 then
				arg_112_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action5_2")
			end

			local var_115_22 = arg_112_1.actors_["10002ui_story"].transform
			local var_115_23 = 0

			if var_115_23 < arg_112_1.time_ and arg_112_1.time_ <= var_115_23 + arg_115_0 then
				arg_112_1.var_.moveOldPos10002ui_story = var_115_22.localPosition
			end

			local var_115_24 = 0.001

			if var_115_23 <= arg_112_1.time_ and arg_112_1.time_ < var_115_23 + var_115_24 then
				local var_115_25 = (arg_112_1.time_ - var_115_23) / var_115_24
				local var_115_26 = Vector3.New(0, -1.2, -5.8)

				var_115_22.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10002ui_story, var_115_26, var_115_25)

				local var_115_27 = manager.ui.mainCamera.transform.position - var_115_22.position

				var_115_22.forward = Vector3.New(var_115_27.x, var_115_27.y, var_115_27.z)

				local var_115_28 = var_115_22.localEulerAngles

				var_115_28.z = 0
				var_115_28.x = 0
				var_115_22.localEulerAngles = var_115_28
			end

			if arg_112_1.time_ >= var_115_23 + var_115_24 and arg_112_1.time_ < var_115_23 + var_115_24 + arg_115_0 then
				var_115_22.localPosition = Vector3.New(0, -1.2, -5.8)

				local var_115_29 = manager.ui.mainCamera.transform.position - var_115_22.position

				var_115_22.forward = Vector3.New(var_115_29.x, var_115_29.y, var_115_29.z)

				local var_115_30 = var_115_22.localEulerAngles

				var_115_30.z = 0
				var_115_30.x = 0
				var_115_22.localEulerAngles = var_115_30
			end

			local var_115_31 = 0

			if var_115_31 < arg_112_1.time_ and arg_112_1.time_ <= var_115_31 + arg_115_0 then
				arg_112_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action2_1")
			end

			local var_115_32 = 0

			if var_115_32 < arg_112_1.time_ and arg_112_1.time_ <= var_115_32 + arg_115_0 then
				arg_112_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_115_33 = 0
			local var_115_34 = 0.675

			if var_115_33 < arg_112_1.time_ and arg_112_1.time_ <= var_115_33 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_35 = arg_112_1:FormatText(StoryNameCfg[39].name)

				arg_112_1.leftNameTxt_.text = var_115_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_36 = arg_112_1:GetWordFromCfg(101121028)
				local var_115_37 = arg_112_1:FormatText(var_115_36.content)

				arg_112_1.text_.text = var_115_37

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_38 = 27
				local var_115_39 = utf8.len(var_115_37)
				local var_115_40 = var_115_38 <= 0 and var_115_34 or var_115_34 * (var_115_39 / var_115_38)

				if var_115_40 > 0 and var_115_34 < var_115_40 then
					arg_112_1.talkMaxDuration = var_115_40

					if var_115_40 + var_115_33 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_40 + var_115_33
					end
				end

				arg_112_1.text_.text = var_115_37
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121028", "story_v_out_101121.awb") ~= 0 then
					local var_115_41 = manager.audio:GetVoiceLength("story_v_out_101121", "101121028", "story_v_out_101121.awb") / 1000

					if var_115_41 + var_115_33 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_41 + var_115_33
					end

					if var_115_36.prefab_name ~= "" and arg_112_1.actors_[var_115_36.prefab_name] ~= nil then
						local var_115_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_36.prefab_name].transform, "story_v_out_101121", "101121028", "story_v_out_101121.awb")

						arg_112_1:RecordAudio("101121028", var_115_42)
						arg_112_1:RecordAudio("101121028", var_115_42)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_101121", "101121028", "story_v_out_101121.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_101121", "101121028", "story_v_out_101121.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_43 = math.max(var_115_34, arg_112_1.talkMaxDuration)

			if var_115_33 <= arg_112_1.time_ and arg_112_1.time_ < var_115_33 + var_115_43 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_33) / var_115_43

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_33 + var_115_43 and arg_112_1.time_ < var_115_33 + var_115_43 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
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

		arg_112_1:InitPlayNodeList()
	end,
	Play101121029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 101121029
		arg_116_1.duration_ = 3.07

		local var_116_0 = {
			ja = 2.3,
			ko = 3.066,
			zh = 2.7,
			en = 2.766
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
				arg_116_0:Play101121030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["10001_tpose"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect10001_tpose == nil then
				arg_116_1.var_.characterEffect10001_tpose = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.1

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect10001_tpose and not isNil(var_119_0) then
					arg_116_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect10001_tpose then
				arg_116_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_119_4 = arg_116_1.actors_["10002ui_story"]
			local var_119_5 = 0

			if var_119_5 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 and not isNil(var_119_4) and arg_116_1.var_.characterEffect10002ui_story == nil then
				arg_116_1.var_.characterEffect10002ui_story = var_119_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_6 = 0.1

			if var_119_5 <= arg_116_1.time_ and arg_116_1.time_ < var_119_5 + var_119_6 and not isNil(var_119_4) then
				local var_119_7 = (arg_116_1.time_ - var_119_5) / var_119_6

				if arg_116_1.var_.characterEffect10002ui_story and not isNil(var_119_4) then
					local var_119_8 = Mathf.Lerp(0, 0.5, var_119_7)

					arg_116_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_116_1.var_.characterEffect10002ui_story.fillRatio = var_119_8
				end
			end

			if arg_116_1.time_ >= var_119_5 + var_119_6 and arg_116_1.time_ < var_119_5 + var_119_6 + arg_119_0 and not isNil(var_119_4) and arg_116_1.var_.characterEffect10002ui_story then
				local var_119_9 = 0.5

				arg_116_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_116_1.var_.characterEffect10002ui_story.fillRatio = var_119_9
			end

			local var_119_10 = arg_116_1.actors_["10002ui_story"].transform
			local var_119_11 = 0

			if var_119_11 < arg_116_1.time_ and arg_116_1.time_ <= var_119_11 + arg_119_0 then
				arg_116_1.var_.moveOldPos10002ui_story = var_119_10.localPosition
			end

			local var_119_12 = 0.001

			if var_119_11 <= arg_116_1.time_ and arg_116_1.time_ < var_119_11 + var_119_12 then
				local var_119_13 = (arg_116_1.time_ - var_119_11) / var_119_12
				local var_119_14 = Vector3.New(0, 100, 0)

				var_119_10.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos10002ui_story, var_119_14, var_119_13)

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

			local var_119_19 = arg_116_1.actors_["10001_tpose"].transform
			local var_119_20 = 0

			if var_119_20 < arg_116_1.time_ and arg_116_1.time_ <= var_119_20 + arg_119_0 then
				arg_116_1.var_.moveOldPos10001_tpose = var_119_19.localPosition

				local var_119_21 = GameObjectTools.GetOrAddComponent(var_119_19.gameObject, typeof(DynamicBoneHelper))

				if var_119_21 then
					var_119_21:EnableDynamicBone(false)
				end
			end

			local var_119_22 = 0.001

			if var_119_20 <= arg_116_1.time_ and arg_116_1.time_ < var_119_20 + var_119_22 then
				local var_119_23 = (arg_116_1.time_ - var_119_20) / var_119_22
				local var_119_24 = Vector3.New(0, -1.23, -5.8)

				var_119_19.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos10001_tpose, var_119_24, var_119_23)

				local var_119_25 = manager.ui.mainCamera.transform.position - var_119_19.position

				var_119_19.forward = Vector3.New(var_119_25.x, var_119_25.y, var_119_25.z)

				local var_119_26 = var_119_19.localEulerAngles

				var_119_26.z = 0
				var_119_26.x = 0
				var_119_19.localEulerAngles = var_119_26
			end

			if arg_116_1.time_ >= var_119_20 + var_119_22 and arg_116_1.time_ < var_119_20 + var_119_22 + arg_119_0 then
				var_119_19.localPosition = Vector3.New(0, -1.23, -5.8)

				local var_119_27 = manager.ui.mainCamera.transform.position - var_119_19.position

				var_119_19.forward = Vector3.New(var_119_27.x, var_119_27.y, var_119_27.z)

				local var_119_28 = var_119_19.localEulerAngles

				var_119_28.z = 0
				var_119_28.x = 0
				var_119_19.localEulerAngles = var_119_28

				local var_119_29 = GameObjectTools.GetOrAddComponent(var_119_19.gameObject, typeof(DynamicBoneHelper))

				if var_119_29 then
					var_119_29:EnableDynamicBone(true)
				end
			end

			local var_119_30 = 0

			if var_119_30 < arg_116_1.time_ and arg_116_1.time_ <= var_119_30 + arg_119_0 then
				arg_116_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_119_31 = 0
			local var_119_32 = 0.25

			if var_119_31 < arg_116_1.time_ and arg_116_1.time_ <= var_119_31 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_33 = arg_116_1:FormatText(StoryNameCfg[31].name)

				arg_116_1.leftNameTxt_.text = var_119_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_34 = arg_116_1:GetWordFromCfg(101121029)
				local var_119_35 = arg_116_1:FormatText(var_119_34.content)

				arg_116_1.text_.text = var_119_35

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_36 = 10
				local var_119_37 = utf8.len(var_119_35)
				local var_119_38 = var_119_36 <= 0 and var_119_32 or var_119_32 * (var_119_37 / var_119_36)

				if var_119_38 > 0 and var_119_32 < var_119_38 then
					arg_116_1.talkMaxDuration = var_119_38

					if var_119_38 + var_119_31 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_38 + var_119_31
					end
				end

				arg_116_1.text_.text = var_119_35
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121029", "story_v_out_101121.awb") ~= 0 then
					local var_119_39 = manager.audio:GetVoiceLength("story_v_out_101121", "101121029", "story_v_out_101121.awb") / 1000

					if var_119_39 + var_119_31 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_39 + var_119_31
					end

					if var_119_34.prefab_name ~= "" and arg_116_1.actors_[var_119_34.prefab_name] ~= nil then
						local var_119_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_34.prefab_name].transform, "story_v_out_101121", "101121029", "story_v_out_101121.awb")

						arg_116_1:RecordAudio("101121029", var_119_40)
						arg_116_1:RecordAudio("101121029", var_119_40)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_101121", "101121029", "story_v_out_101121.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_101121", "101121029", "story_v_out_101121.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_41 = math.max(var_119_32, arg_116_1.talkMaxDuration)

			if var_119_31 <= arg_116_1.time_ and arg_116_1.time_ < var_119_31 + var_119_41 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_31) / var_119_41

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_31 + var_119_41 and arg_116_1.time_ < var_119_31 + var_119_41 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
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
				actorName = "10001_tpose",
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
	Play101121030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 101121030
		arg_120_1.duration_ = 11.23

		local var_120_0 = {
			ja = 11.233,
			ko = 8.966,
			zh = 8.233,
			en = 7
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
				arg_120_0:Play101121031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_123_1 = 0
			local var_123_2 = 1.025

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_3 = arg_120_1:FormatText(StoryNameCfg[31].name)

				arg_120_1.leftNameTxt_.text = var_123_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_4 = arg_120_1:GetWordFromCfg(101121030)
				local var_123_5 = arg_120_1:FormatText(var_123_4.content)

				arg_120_1.text_.text = var_123_5

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_6 = 41
				local var_123_7 = utf8.len(var_123_5)
				local var_123_8 = var_123_6 <= 0 and var_123_2 or var_123_2 * (var_123_7 / var_123_6)

				if var_123_8 > 0 and var_123_2 < var_123_8 then
					arg_120_1.talkMaxDuration = var_123_8

					if var_123_8 + var_123_1 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_1
					end
				end

				arg_120_1.text_.text = var_123_5
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121030", "story_v_out_101121.awb") ~= 0 then
					local var_123_9 = manager.audio:GetVoiceLength("story_v_out_101121", "101121030", "story_v_out_101121.awb") / 1000

					if var_123_9 + var_123_1 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_9 + var_123_1
					end

					if var_123_4.prefab_name ~= "" and arg_120_1.actors_[var_123_4.prefab_name] ~= nil then
						local var_123_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_4.prefab_name].transform, "story_v_out_101121", "101121030", "story_v_out_101121.awb")

						arg_120_1:RecordAudio("101121030", var_123_10)
						arg_120_1:RecordAudio("101121030", var_123_10)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_101121", "101121030", "story_v_out_101121.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_101121", "101121030", "story_v_out_101121.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_11 = math.max(var_123_2, arg_120_1.talkMaxDuration)

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_11 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_1) / var_123_11

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_1 + var_123_11 and arg_120_1.time_ < var_123_1 + var_123_11 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play101121031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 101121031
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play101121032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["10001_tpose"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect10001_tpose == nil then
				arg_124_1.var_.characterEffect10001_tpose = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.1

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.characterEffect10001_tpose and not isNil(var_127_0) then
					local var_127_4 = Mathf.Lerp(0, 0.5, var_127_3)

					arg_124_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_124_1.var_.characterEffect10001_tpose.fillRatio = var_127_4
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect10001_tpose then
				local var_127_5 = 0.5

				arg_124_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_124_1.var_.characterEffect10001_tpose.fillRatio = var_127_5
			end

			local var_127_6 = arg_124_1.actors_["10001_tpose"].transform
			local var_127_7 = 0

			if var_127_7 < arg_124_1.time_ and arg_124_1.time_ <= var_127_7 + arg_127_0 then
				arg_124_1.var_.moveOldPos10001_tpose = var_127_6.localPosition

				local var_127_8 = GameObjectTools.GetOrAddComponent(var_127_6.gameObject, typeof(DynamicBoneHelper))

				if var_127_8 then
					var_127_8:EnableDynamicBone(false)
				end
			end

			local var_127_9 = 0.001

			if var_127_7 <= arg_124_1.time_ and arg_124_1.time_ < var_127_7 + var_127_9 then
				local var_127_10 = (arg_124_1.time_ - var_127_7) / var_127_9
				local var_127_11 = Vector3.New(0, 100, 0)

				var_127_6.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10001_tpose, var_127_11, var_127_10)

				local var_127_12 = manager.ui.mainCamera.transform.position - var_127_6.position

				var_127_6.forward = Vector3.New(var_127_12.x, var_127_12.y, var_127_12.z)

				local var_127_13 = var_127_6.localEulerAngles

				var_127_13.z = 0
				var_127_13.x = 0
				var_127_6.localEulerAngles = var_127_13
			end

			if arg_124_1.time_ >= var_127_7 + var_127_9 and arg_124_1.time_ < var_127_7 + var_127_9 + arg_127_0 then
				var_127_6.localPosition = Vector3.New(0, 100, 0)

				local var_127_14 = manager.ui.mainCamera.transform.position - var_127_6.position

				var_127_6.forward = Vector3.New(var_127_14.x, var_127_14.y, var_127_14.z)

				local var_127_15 = var_127_6.localEulerAngles

				var_127_15.z = 0
				var_127_15.x = 0
				var_127_6.localEulerAngles = var_127_15

				local var_127_16 = GameObjectTools.GetOrAddComponent(var_127_6.gameObject, typeof(DynamicBoneHelper))

				if var_127_16 then
					var_127_16:EnableDynamicBone(true)
				end
			end

			local var_127_17 = arg_124_1.actors_["10002ui_story"].transform
			local var_127_18 = 0

			if var_127_18 < arg_124_1.time_ and arg_124_1.time_ <= var_127_18 + arg_127_0 then
				arg_124_1.var_.moveOldPos10002ui_story = var_127_17.localPosition
			end

			local var_127_19 = 0.001

			if var_127_18 <= arg_124_1.time_ and arg_124_1.time_ < var_127_18 + var_127_19 then
				local var_127_20 = (arg_124_1.time_ - var_127_18) / var_127_19
				local var_127_21 = Vector3.New(0, 100, 0)

				var_127_17.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10002ui_story, var_127_21, var_127_20)

				local var_127_22 = manager.ui.mainCamera.transform.position - var_127_17.position

				var_127_17.forward = Vector3.New(var_127_22.x, var_127_22.y, var_127_22.z)

				local var_127_23 = var_127_17.localEulerAngles

				var_127_23.z = 0
				var_127_23.x = 0
				var_127_17.localEulerAngles = var_127_23
			end

			if arg_124_1.time_ >= var_127_18 + var_127_19 and arg_124_1.time_ < var_127_18 + var_127_19 + arg_127_0 then
				var_127_17.localPosition = Vector3.New(0, 100, 0)

				local var_127_24 = manager.ui.mainCamera.transform.position - var_127_17.position

				var_127_17.forward = Vector3.New(var_127_24.x, var_127_24.y, var_127_24.z)

				local var_127_25 = var_127_17.localEulerAngles

				var_127_25.z = 0
				var_127_25.x = 0
				var_127_17.localEulerAngles = var_127_25
			end

			local var_127_26 = manager.ui.mainCamera.transform
			local var_127_27 = 0

			if var_127_27 < arg_124_1.time_ and arg_124_1.time_ <= var_127_27 + arg_127_0 then
				arg_124_1.var_.shakeOldPosMainCamera = var_127_26.localPosition
			end

			local var_127_28 = 0.600000023841858

			if var_127_27 <= arg_124_1.time_ and arg_124_1.time_ < var_127_27 + var_127_28 then
				local var_127_29 = (arg_124_1.time_ - var_127_27) / 0.066
				local var_127_30, var_127_31 = math.modf(var_127_29)

				var_127_26.localPosition = Vector3.New(var_127_31 * 0.13, var_127_31 * 0.13, var_127_31 * 0.13) + arg_124_1.var_.shakeOldPosMainCamera
			end

			if arg_124_1.time_ >= var_127_27 + var_127_28 and arg_124_1.time_ < var_127_27 + var_127_28 + arg_127_0 then
				var_127_26.localPosition = arg_124_1.var_.shakeOldPosMainCamera
			end

			local var_127_32 = 0
			local var_127_33 = 0.675

			if var_127_32 < arg_124_1.time_ and arg_124_1.time_ <= var_127_32 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_34 = arg_124_1:GetWordFromCfg(101121031)
				local var_127_35 = arg_124_1:FormatText(var_127_34.content)

				arg_124_1.text_.text = var_127_35

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_36 = 27
				local var_127_37 = utf8.len(var_127_35)
				local var_127_38 = var_127_36 <= 0 and var_127_33 or var_127_33 * (var_127_37 / var_127_36)

				if var_127_38 > 0 and var_127_33 < var_127_38 then
					arg_124_1.talkMaxDuration = var_127_38

					if var_127_38 + var_127_32 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_38 + var_127_32
					end
				end

				arg_124_1.text_.text = var_127_35
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_39 = math.max(var_127_33, arg_124_1.talkMaxDuration)

			if var_127_32 <= arg_124_1.time_ and arg_124_1.time_ < var_127_32 + var_127_39 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_32) / var_127_39

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_32 + var_127_39 and arg_124_1.time_ < var_127_32 + var_127_39 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
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

		arg_124_1:InitPlayNodeList()
	end,
	Play101121032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 101121032
		arg_128_1.duration_ = 2

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play101121033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["10002ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect10002ui_story == nil then
				arg_128_1.var_.characterEffect10002ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.1

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect10002ui_story and not isNil(var_131_0) then
					arg_128_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect10002ui_story then
				arg_128_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_131_4 = 0

			if var_131_4 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action5_2")
			end

			local var_131_5 = arg_128_1.actors_["10002ui_story"].transform
			local var_131_6 = 0

			if var_131_6 < arg_128_1.time_ and arg_128_1.time_ <= var_131_6 + arg_131_0 then
				arg_128_1.var_.moveOldPos10002ui_story = var_131_5.localPosition
			end

			local var_131_7 = 0.001

			if var_131_6 <= arg_128_1.time_ and arg_128_1.time_ < var_131_6 + var_131_7 then
				local var_131_8 = (arg_128_1.time_ - var_131_6) / var_131_7
				local var_131_9 = Vector3.New(0, -1.2, -5.8)

				var_131_5.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10002ui_story, var_131_9, var_131_8)

				local var_131_10 = manager.ui.mainCamera.transform.position - var_131_5.position

				var_131_5.forward = Vector3.New(var_131_10.x, var_131_10.y, var_131_10.z)

				local var_131_11 = var_131_5.localEulerAngles

				var_131_11.z = 0
				var_131_11.x = 0
				var_131_5.localEulerAngles = var_131_11
			end

			if arg_128_1.time_ >= var_131_6 + var_131_7 and arg_128_1.time_ < var_131_6 + var_131_7 + arg_131_0 then
				var_131_5.localPosition = Vector3.New(0, -1.2, -5.8)

				local var_131_12 = manager.ui.mainCamera.transform.position - var_131_5.position

				var_131_5.forward = Vector3.New(var_131_12.x, var_131_12.y, var_131_12.z)

				local var_131_13 = var_131_5.localEulerAngles

				var_131_13.z = 0
				var_131_13.x = 0
				var_131_5.localEulerAngles = var_131_13
			end

			local var_131_14 = 0

			if var_131_14 < arg_128_1.time_ and arg_128_1.time_ <= var_131_14 + arg_131_0 then
				arg_128_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_131_15 = 0
			local var_131_16 = 0.05

			if var_131_15 < arg_128_1.time_ and arg_128_1.time_ <= var_131_15 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_17 = arg_128_1:FormatText(StoryNameCfg[39].name)

				arg_128_1.leftNameTxt_.text = var_131_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_18 = arg_128_1:GetWordFromCfg(101121032)
				local var_131_19 = arg_128_1:FormatText(var_131_18.content)

				arg_128_1.text_.text = var_131_19

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_20 = 2
				local var_131_21 = utf8.len(var_131_19)
				local var_131_22 = var_131_20 <= 0 and var_131_16 or var_131_16 * (var_131_21 / var_131_20)

				if var_131_22 > 0 and var_131_16 < var_131_22 then
					arg_128_1.talkMaxDuration = var_131_22

					if var_131_22 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_22 + var_131_15
					end
				end

				arg_128_1.text_.text = var_131_19
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121032", "story_v_out_101121.awb") ~= 0 then
					local var_131_23 = manager.audio:GetVoiceLength("story_v_out_101121", "101121032", "story_v_out_101121.awb") / 1000

					if var_131_23 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_23 + var_131_15
					end

					if var_131_18.prefab_name ~= "" and arg_128_1.actors_[var_131_18.prefab_name] ~= nil then
						local var_131_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_18.prefab_name].transform, "story_v_out_101121", "101121032", "story_v_out_101121.awb")

						arg_128_1:RecordAudio("101121032", var_131_24)
						arg_128_1:RecordAudio("101121032", var_131_24)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_101121", "101121032", "story_v_out_101121.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_101121", "101121032", "story_v_out_101121.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_25 = math.max(var_131_16, arg_128_1.talkMaxDuration)

			if var_131_15 <= arg_128_1.time_ and arg_128_1.time_ < var_131_15 + var_131_25 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_15) / var_131_25

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_15 + var_131_25 and arg_128_1.time_ < var_131_15 + var_131_25 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
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

		arg_128_1:InitPlayNodeList()
	end,
	Play101121033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 101121033
		arg_132_1.duration_ = 8.57

		local var_132_0 = {
			ja = 7.066,
			ko = 8.566,
			zh = 7.7,
			en = 7.133
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
				arg_132_0:Play101121034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0
			local var_135_1 = 1

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				local var_135_2 = "play"
				local var_135_3 = "effect"

				arg_132_1:AudioAction(var_135_2, var_135_3, "se_story_1", "se_story_1_sweep", "")
			end

			local var_135_4 = arg_132_1.actors_["10002ui_story"]
			local var_135_5 = 0

			if var_135_5 < arg_132_1.time_ and arg_132_1.time_ <= var_135_5 + arg_135_0 and not isNil(var_135_4) and arg_132_1.var_.characterEffect10002ui_story == nil then
				arg_132_1.var_.characterEffect10002ui_story = var_135_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_6 = 0.1

			if var_135_5 <= arg_132_1.time_ and arg_132_1.time_ < var_135_5 + var_135_6 and not isNil(var_135_4) then
				local var_135_7 = (arg_132_1.time_ - var_135_5) / var_135_6

				if arg_132_1.var_.characterEffect10002ui_story and not isNil(var_135_4) then
					local var_135_8 = Mathf.Lerp(0, 0.5, var_135_7)

					arg_132_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_132_1.var_.characterEffect10002ui_story.fillRatio = var_135_8
				end
			end

			if arg_132_1.time_ >= var_135_5 + var_135_6 and arg_132_1.time_ < var_135_5 + var_135_6 + arg_135_0 and not isNil(var_135_4) and arg_132_1.var_.characterEffect10002ui_story then
				local var_135_9 = 0.5

				arg_132_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_132_1.var_.characterEffect10002ui_story.fillRatio = var_135_9
			end

			local var_135_10 = 0
			local var_135_11 = 0.7

			if var_135_10 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_12 = arg_132_1:FormatText(StoryNameCfg[29].name)

				arg_132_1.leftNameTxt_.text = var_135_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2021")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_13 = arg_132_1:GetWordFromCfg(101121033)
				local var_135_14 = arg_132_1:FormatText(var_135_13.content)

				arg_132_1.text_.text = var_135_14

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_15 = 27
				local var_135_16 = utf8.len(var_135_14)
				local var_135_17 = var_135_15 <= 0 and var_135_11 or var_135_11 * (var_135_16 / var_135_15)

				if var_135_17 > 0 and var_135_11 < var_135_17 then
					arg_132_1.talkMaxDuration = var_135_17

					if var_135_17 + var_135_10 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_17 + var_135_10
					end
				end

				arg_132_1.text_.text = var_135_14
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121033", "story_v_out_101121.awb") ~= 0 then
					local var_135_18 = manager.audio:GetVoiceLength("story_v_out_101121", "101121033", "story_v_out_101121.awb") / 1000

					if var_135_18 + var_135_10 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_18 + var_135_10
					end

					if var_135_13.prefab_name ~= "" and arg_132_1.actors_[var_135_13.prefab_name] ~= nil then
						local var_135_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_13.prefab_name].transform, "story_v_out_101121", "101121033", "story_v_out_101121.awb")

						arg_132_1:RecordAudio("101121033", var_135_19)
						arg_132_1:RecordAudio("101121033", var_135_19)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_101121", "101121033", "story_v_out_101121.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_101121", "101121033", "story_v_out_101121.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_20 = math.max(var_135_11, arg_132_1.talkMaxDuration)

			if var_135_10 <= arg_132_1.time_ and arg_132_1.time_ < var_135_10 + var_135_20 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_10) / var_135_20

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_10 + var_135_20 and arg_132_1.time_ < var_135_10 + var_135_20 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play101121034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 101121034
		arg_136_1.duration_ = 2.07

		local var_136_0 = {
			ja = 1.999999999999,
			ko = 2.066,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_136_0:Play101121035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["10002ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect10002ui_story == nil then
				arg_136_1.var_.characterEffect10002ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.1

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect10002ui_story and not isNil(var_139_0) then
					arg_136_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect10002ui_story then
				arg_136_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_139_4 = 0

			if var_139_4 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_139_5 = 0
			local var_139_6 = 0.125

			if var_139_5 < arg_136_1.time_ and arg_136_1.time_ <= var_139_5 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_7 = arg_136_1:FormatText(StoryNameCfg[39].name)

				arg_136_1.leftNameTxt_.text = var_139_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_8 = arg_136_1:GetWordFromCfg(101121034)
				local var_139_9 = arg_136_1:FormatText(var_139_8.content)

				arg_136_1.text_.text = var_139_9

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_10 = 5
				local var_139_11 = utf8.len(var_139_9)
				local var_139_12 = var_139_10 <= 0 and var_139_6 or var_139_6 * (var_139_11 / var_139_10)

				if var_139_12 > 0 and var_139_6 < var_139_12 then
					arg_136_1.talkMaxDuration = var_139_12

					if var_139_12 + var_139_5 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_12 + var_139_5
					end
				end

				arg_136_1.text_.text = var_139_9
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101121", "101121034", "story_v_out_101121.awb") ~= 0 then
					local var_139_13 = manager.audio:GetVoiceLength("story_v_out_101121", "101121034", "story_v_out_101121.awb") / 1000

					if var_139_13 + var_139_5 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_13 + var_139_5
					end

					if var_139_8.prefab_name ~= "" and arg_136_1.actors_[var_139_8.prefab_name] ~= nil then
						local var_139_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_8.prefab_name].transform, "story_v_out_101121", "101121034", "story_v_out_101121.awb")

						arg_136_1:RecordAudio("101121034", var_139_14)
						arg_136_1:RecordAudio("101121034", var_139_14)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_101121", "101121034", "story_v_out_101121.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_101121", "101121034", "story_v_out_101121.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_15 = math.max(var_139_6, arg_136_1.talkMaxDuration)

			if var_139_5 <= arg_136_1.time_ and arg_136_1.time_ < var_139_5 + var_139_15 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_5) / var_139_15

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_5 + var_139_15 and arg_136_1.time_ < var_139_5 + var_139_15 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play101121035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 101121035
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
			arg_140_1.auto_ = false
		end

		function arg_140_1.playNext_(arg_142_0)
			arg_140_1.onStoryFinished_()
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["10002ui_story"].transform
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.var_.moveOldPos10002ui_story = var_143_0.localPosition
			end

			local var_143_2 = 0.001

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2
				local var_143_4 = Vector3.New(0, 100, 0)

				var_143_0.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos10002ui_story, var_143_4, var_143_3)

				local var_143_5 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_5.x, var_143_5.y, var_143_5.z)

				local var_143_6 = var_143_0.localEulerAngles

				var_143_6.z = 0
				var_143_6.x = 0
				var_143_0.localEulerAngles = var_143_6
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 then
				var_143_0.localPosition = Vector3.New(0, 100, 0)

				local var_143_7 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_7.x, var_143_7.y, var_143_7.z)

				local var_143_8 = var_143_0.localEulerAngles

				var_143_8.z = 0
				var_143_8.x = 0
				var_143_0.localEulerAngles = var_143_8
			end

			local var_143_9 = 0
			local var_143_10 = 0.45

			if var_143_9 < arg_140_1.time_ and arg_140_1.time_ <= var_143_9 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_11 = arg_140_1:GetWordFromCfg(101121035)
				local var_143_12 = arg_140_1:FormatText(var_143_11.content)

				arg_140_1.text_.text = var_143_12

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_13 = 18
				local var_143_14 = utf8.len(var_143_12)
				local var_143_15 = var_143_13 <= 0 and var_143_10 or var_143_10 * (var_143_14 / var_143_13)

				if var_143_15 > 0 and var_143_10 < var_143_15 then
					arg_140_1.talkMaxDuration = var_143_15

					if var_143_15 + var_143_9 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_15 + var_143_9
					end
				end

				arg_140_1.text_.text = var_143_12
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_16 = math.max(var_143_10, arg_140_1.talkMaxDuration)

			if var_143_9 <= arg_140_1.time_ and arg_140_1.time_ < var_143_9 + var_143_16 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_9) / var_143_16

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_9 + var_143_16 and arg_140_1.time_ < var_143_9 + var_143_16 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
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

		arg_140_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B03f"
	},
	voices = {
		"story_v_out_101121.awb"
	}
}
