return {
	Play325762001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325762001
		arg_1_1.duration_ = 9.63

		local var_1_0 = {
			zh = 7.06666666666667,
			ja = 9.63266666666667
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
				arg_1_0:Play325762002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J02"

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
				local var_4_5 = arg_1_1.bgs_.J02

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
					if iter_4_0 ~= "J02" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 2

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(0, 0, 0)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_24 = "1077ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1077ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1077ui_story"), arg_1_1.stage_.transform)

					var_4_26.name = var_4_24
					var_4_26.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_24] = var_4_26

					local var_4_27 = var_4_26:GetComponentInChildren(typeof(CharacterEffect))

					var_4_27.enabled = true

					local var_4_28 = GameObjectTools.GetOrAddComponent(var_4_26, typeof(DynamicBoneHelper))

					if var_4_28 then
						var_4_28:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_27.transform, false)

					arg_1_1.var_[var_4_24 .. "Animator"] = var_4_27.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_24 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_24 .. "LipSync"] = var_4_27.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_29 = arg_1_1.actors_["1077ui_story"].transform
			local var_4_30 = 1.86666666666667

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1077ui_story = var_4_29.localPosition

				local var_4_31 = GameObjectTools.GetOrAddComponent(var_4_29.gameObject, typeof(DynamicBoneHelper))

				if var_4_31 then
					var_4_31:EnableDynamicBone(false)
				end
			end

			local var_4_32 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_30) / var_4_32
				local var_4_34 = Vector3.New(-0.03, -1.02, -5.92)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1077ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_29.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_29.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_30 + var_4_32 and arg_1_1.time_ < var_4_30 + var_4_32 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_4_37 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_37.x, var_4_37.y, var_4_37.z)

				local var_4_38 = var_4_29.localEulerAngles

				var_4_38.z = 0
				var_4_38.x = 0
				var_4_29.localEulerAngles = var_4_38

				local var_4_39 = GameObjectTools.GetOrAddComponent(var_4_29.gameObject, typeof(DynamicBoneHelper))

				if var_4_39 then
					var_4_39:EnableDynamicBone(true)
				end
			end

			local var_4_40 = arg_1_1.actors_["1077ui_story"]
			local var_4_41 = 1.86666666666667

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect1077ui_story == nil then
				arg_1_1.var_.characterEffect1077ui_story = var_4_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_42 = 0.200000002980232

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 and not isNil(var_4_40) then
				local var_4_43 = (arg_1_1.time_ - var_4_41) / var_4_42

				if arg_1_1.var_.characterEffect1077ui_story and not isNil(var_4_40) then
					arg_1_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect1077ui_story then
				arg_1_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_4_44 = 1.86666666666667

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_4_45 = 1.86666666666667

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_4_46 = 0.1
			local var_4_47 = 1

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				local var_4_48 = "play"
				local var_4_49 = "effect"

				arg_1_1:AudioAction(var_4_48, var_4_49, "se_story_148", "se_story_148_amb_drone", "")
			end

			local var_4_50 = 0
			local var_4_51 = 1

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_52 = "play"
				local var_4_53 = "music"

				arg_1_1:AudioAction(var_4_52, var_4_53, "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown.awb")

				local var_4_54 = ""
				local var_4_55 = manager.audio:GetAudioName("bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown")

				if var_4_55 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_55 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_55

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_55
						arg_1_1.bgmTxt2_.text = var_4_55
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

			local var_4_56 = 1.86666666666667
			local var_4_57 = 0.7

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_58 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_58:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_59 = arg_1_1:FormatText(StoryNameCfg[1467].name)

				arg_1_1.leftNameTxt_.text = var_4_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_60 = arg_1_1:GetWordFromCfg(325762001)
				local var_4_61 = arg_1_1:FormatText(var_4_60.content)

				arg_1_1.text_.text = var_4_61

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_62 = 28
				local var_4_63 = utf8.len(var_4_61)
				local var_4_64 = var_4_62 <= 0 and var_4_57 or var_4_57 * (var_4_63 / var_4_62)

				if var_4_64 > 0 and var_4_57 < var_4_64 then
					arg_1_1.talkMaxDuration = var_4_64
					var_4_56 = var_4_56 + 0.3

					if var_4_64 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_64 + var_4_56
					end
				end

				arg_1_1.text_.text = var_4_61
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325762", "325762001", "story_v_out_325762.awb") ~= 0 then
					local var_4_65 = manager.audio:GetVoiceLength("story_v_out_325762", "325762001", "story_v_out_325762.awb") / 1000

					if var_4_65 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_56
					end

					if var_4_60.prefab_name ~= "" and arg_1_1.actors_[var_4_60.prefab_name] ~= nil then
						local var_4_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_60.prefab_name].transform, "story_v_out_325762", "325762001", "story_v_out_325762.awb")

						arg_1_1:RecordAudio("325762001", var_4_66)
						arg_1_1:RecordAudio("325762001", var_4_66)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_325762", "325762001", "story_v_out_325762.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_325762", "325762001", "story_v_out_325762.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_67 = var_4_56 + 0.3
			local var_4_68 = math.max(var_4_57, arg_1_1.talkMaxDuration)

			if var_4_67 <= arg_1_1.time_ and arg_1_1.time_ < var_4_67 + var_4_68 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_67) / var_4_68

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_67 + var_4_68 and arg_1_1.time_ < var_4_67 + var_4_68 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play325762002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325762002
		arg_8_1.duration_ = 4.1

		local var_8_0 = {
			zh = 3.833,
			ja = 4.1
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
				arg_8_0:Play325762003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.475

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[1467].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:GetWordFromCfg(325762002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 19
				local var_11_6 = utf8.len(var_11_4)
				local var_11_7 = var_11_5 <= 0 and var_11_1 or var_11_1 * (var_11_6 / var_11_5)

				if var_11_7 > 0 and var_11_1 < var_11_7 then
					arg_8_1.talkMaxDuration = var_11_7

					if var_11_7 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325762", "325762002", "story_v_out_325762.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_out_325762", "325762002", "story_v_out_325762.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_325762", "325762002", "story_v_out_325762.awb")

						arg_8_1:RecordAudio("325762002", var_11_9)
						arg_8_1:RecordAudio("325762002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_325762", "325762002", "story_v_out_325762.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_325762", "325762002", "story_v_out_325762.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_10 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_10 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_10

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_10 and arg_8_1.time_ < var_11_0 + var_11_10 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play325762003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325762003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325762004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1077ui_story"].transform
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.var_.moveOldPos1077ui_story = var_15_0.localPosition

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0.gameObject, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end
			end

			local var_15_3 = 0.001

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_3 then
				local var_15_4 = (arg_12_1.time_ - var_15_1) / var_15_3
				local var_15_5 = Vector3.New(0, 100, 0)

				var_15_0.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1077ui_story, var_15_5, var_15_4)

				local var_15_6 = manager.ui.mainCamera.transform.position - var_15_0.position

				var_15_0.forward = Vector3.New(var_15_6.x, var_15_6.y, var_15_6.z)

				local var_15_7 = var_15_0.localEulerAngles

				var_15_7.z = 0
				var_15_7.x = 0
				var_15_0.localEulerAngles = var_15_7
			end

			if arg_12_1.time_ >= var_15_1 + var_15_3 and arg_12_1.time_ < var_15_1 + var_15_3 + arg_15_0 then
				var_15_0.localPosition = Vector3.New(0, 100, 0)

				local var_15_8 = manager.ui.mainCamera.transform.position - var_15_0.position

				var_15_0.forward = Vector3.New(var_15_8.x, var_15_8.y, var_15_8.z)

				local var_15_9 = var_15_0.localEulerAngles

				var_15_9.z = 0
				var_15_9.x = 0
				var_15_0.localEulerAngles = var_15_9

				local var_15_10 = GameObjectTools.GetOrAddComponent(var_15_0.gameObject, typeof(DynamicBoneHelper))

				if var_15_10 then
					var_15_10:EnableDynamicBone(true)
				end
			end

			local var_15_11 = arg_12_1.actors_["1077ui_story"]
			local var_15_12 = 0

			if var_15_12 < arg_12_1.time_ and arg_12_1.time_ <= var_15_12 + arg_15_0 and not isNil(var_15_11) and arg_12_1.var_.characterEffect1077ui_story == nil then
				arg_12_1.var_.characterEffect1077ui_story = var_15_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_13 = 0.200000002980232

			if var_15_12 <= arg_12_1.time_ and arg_12_1.time_ < var_15_12 + var_15_13 and not isNil(var_15_11) then
				local var_15_14 = (arg_12_1.time_ - var_15_12) / var_15_13

				if arg_12_1.var_.characterEffect1077ui_story and not isNil(var_15_11) then
					local var_15_15 = Mathf.Lerp(0, 0.5, var_15_14)

					arg_12_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1077ui_story.fillRatio = var_15_15
				end
			end

			if arg_12_1.time_ >= var_15_12 + var_15_13 and arg_12_1.time_ < var_15_12 + var_15_13 + arg_15_0 and not isNil(var_15_11) and arg_12_1.var_.characterEffect1077ui_story then
				local var_15_16 = 0.5

				arg_12_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1077ui_story.fillRatio = var_15_16
			end

			local var_15_17 = 0
			local var_15_18 = 0.475

			if var_15_17 < arg_12_1.time_ and arg_12_1.time_ <= var_15_17 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_19 = arg_12_1:GetWordFromCfg(325762003)
				local var_15_20 = arg_12_1:FormatText(var_15_19.content)

				arg_12_1.text_.text = var_15_20

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_21 = 19
				local var_15_22 = utf8.len(var_15_20)
				local var_15_23 = var_15_21 <= 0 and var_15_18 or var_15_18 * (var_15_22 / var_15_21)

				if var_15_23 > 0 and var_15_18 < var_15_23 then
					arg_12_1.talkMaxDuration = var_15_23

					if var_15_23 + var_15_17 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_23 + var_15_17
					end
				end

				arg_12_1.text_.text = var_15_20
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_24 = math.max(var_15_18, arg_12_1.talkMaxDuration)

			if var_15_17 <= arg_12_1.time_ and arg_12_1.time_ < var_15_17 + var_15_24 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_17) / var_15_24

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_17 + var_15_24 and arg_12_1.time_ < var_15_17 + var_15_24 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play325762004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325762004
		arg_16_1.duration_ = 2

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play325762005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1075ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1075ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_16_1.stage_.transform)

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

			local var_19_5 = arg_16_1.actors_["1075ui_story"].transform
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.var_.moveOldPos1075ui_story = var_19_5.localPosition
			end

			local var_19_7 = 0.001

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7
				local var_19_9 = Vector3.New(0, -1.055, -6.16)

				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1075ui_story, var_19_9, var_19_8)

				local var_19_10 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_10.x, var_19_10.y, var_19_10.z)

				local var_19_11 = var_19_5.localEulerAngles

				var_19_11.z = 0
				var_19_11.x = 0
				var_19_5.localEulerAngles = var_19_11
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_19_12 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_12.x, var_19_12.y, var_19_12.z)

				local var_19_13 = var_19_5.localEulerAngles

				var_19_13.z = 0
				var_19_13.x = 0
				var_19_5.localEulerAngles = var_19_13
			end

			local var_19_14 = arg_16_1.actors_["1075ui_story"]
			local var_19_15 = 0

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 and not isNil(var_19_14) and arg_16_1.var_.characterEffect1075ui_story == nil then
				arg_16_1.var_.characterEffect1075ui_story = var_19_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_16 = 0.200000002980232

			if var_19_15 <= arg_16_1.time_ and arg_16_1.time_ < var_19_15 + var_19_16 and not isNil(var_19_14) then
				local var_19_17 = (arg_16_1.time_ - var_19_15) / var_19_16

				if arg_16_1.var_.characterEffect1075ui_story and not isNil(var_19_14) then
					arg_16_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_15 + var_19_16 and arg_16_1.time_ < var_19_15 + var_19_16 + arg_19_0 and not isNil(var_19_14) and arg_16_1.var_.characterEffect1075ui_story then
				arg_16_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_19_18 = 0

			if var_19_18 < arg_16_1.time_ and arg_16_1.time_ <= var_19_18 + arg_19_0 then
				arg_16_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_19_19 = 0

			if var_19_19 < arg_16_1.time_ and arg_16_1.time_ <= var_19_19 + arg_19_0 then
				arg_16_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_19_20 = 0
			local var_19_21 = 0.075

			if var_19_20 < arg_16_1.time_ and arg_16_1.time_ <= var_19_20 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_22 = arg_16_1:FormatText(StoryNameCfg[381].name)

				arg_16_1.leftNameTxt_.text = var_19_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_23 = arg_16_1:GetWordFromCfg(325762004)
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

				if manager.audio:GetVoiceLength("story_v_out_325762", "325762004", "story_v_out_325762.awb") ~= 0 then
					local var_19_28 = manager.audio:GetVoiceLength("story_v_out_325762", "325762004", "story_v_out_325762.awb") / 1000

					if var_19_28 + var_19_20 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_28 + var_19_20
					end

					if var_19_23.prefab_name ~= "" and arg_16_1.actors_[var_19_23.prefab_name] ~= nil then
						local var_19_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_23.prefab_name].transform, "story_v_out_325762", "325762004", "story_v_out_325762.awb")

						arg_16_1:RecordAudio("325762004", var_19_29)
						arg_16_1:RecordAudio("325762004", var_19_29)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325762", "325762004", "story_v_out_325762.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325762", "325762004", "story_v_out_325762.awb")
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
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play325762005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325762005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play325762006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1075ui_story"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos1075ui_story = var_23_0.localPosition
			end

			local var_23_2 = 0.001

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2
				local var_23_4 = Vector3.New(0, 100, 0)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1075ui_story, var_23_4, var_23_3)

				local var_23_5 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_5.x, var_23_5.y, var_23_5.z)

				local var_23_6 = var_23_0.localEulerAngles

				var_23_6.z = 0
				var_23_6.x = 0
				var_23_0.localEulerAngles = var_23_6
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(0, 100, 0)

				local var_23_7 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_7.x, var_23_7.y, var_23_7.z)

				local var_23_8 = var_23_0.localEulerAngles

				var_23_8.z = 0
				var_23_8.x = 0
				var_23_0.localEulerAngles = var_23_8
			end

			local var_23_9 = arg_20_1.actors_["1075ui_story"]
			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect1075ui_story == nil then
				arg_20_1.var_.characterEffect1075ui_story = var_23_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_11 = 0.200000002980232

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_11 and not isNil(var_23_9) then
				local var_23_12 = (arg_20_1.time_ - var_23_10) / var_23_11

				if arg_20_1.var_.characterEffect1075ui_story and not isNil(var_23_9) then
					local var_23_13 = Mathf.Lerp(0, 0.5, var_23_12)

					arg_20_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1075ui_story.fillRatio = var_23_13
				end
			end

			if arg_20_1.time_ >= var_23_10 + var_23_11 and arg_20_1.time_ < var_23_10 + var_23_11 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect1075ui_story then
				local var_23_14 = 0.5

				arg_20_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1075ui_story.fillRatio = var_23_14
			end

			local var_23_15 = 0
			local var_23_16 = 0.45

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_17 = arg_20_1:GetWordFromCfg(325762005)
				local var_23_18 = arg_20_1:FormatText(var_23_17.content)

				arg_20_1.text_.text = var_23_18

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_19 = 18
				local var_23_20 = utf8.len(var_23_18)
				local var_23_21 = var_23_19 <= 0 and var_23_16 or var_23_16 * (var_23_20 / var_23_19)

				if var_23_21 > 0 and var_23_16 < var_23_21 then
					arg_20_1.talkMaxDuration = var_23_21

					if var_23_21 + var_23_15 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_21 + var_23_15
					end
				end

				arg_20_1.text_.text = var_23_18
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_22 = math.max(var_23_16, arg_20_1.talkMaxDuration)

			if var_23_15 <= arg_20_1.time_ and arg_20_1.time_ < var_23_15 + var_23_22 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_15) / var_23_22

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_15 + var_23_22 and arg_20_1.time_ < var_23_15 + var_23_22 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play325762006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325762006
		arg_24_1.duration_ = 5.7

		local var_24_0 = {
			zh = 5,
			ja = 5.7
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
				arg_24_0:Play325762007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1075ui_story"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos1075ui_story = var_27_0.localPosition
			end

			local var_27_2 = 0.001

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2
				local var_27_4 = Vector3.New(0, -1.055, -6.16)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1075ui_story, var_27_4, var_27_3)

				local var_27_5 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_5.x, var_27_5.y, var_27_5.z)

				local var_27_6 = var_27_0.localEulerAngles

				var_27_6.z = 0
				var_27_6.x = 0
				var_27_0.localEulerAngles = var_27_6
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_27_7 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_7.x, var_27_7.y, var_27_7.z)

				local var_27_8 = var_27_0.localEulerAngles

				var_27_8.z = 0
				var_27_8.x = 0
				var_27_0.localEulerAngles = var_27_8
			end

			local var_27_9 = arg_24_1.actors_["1075ui_story"]
			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect1075ui_story == nil then
				arg_24_1.var_.characterEffect1075ui_story = var_27_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_11 = 0.200000002980232

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_11 and not isNil(var_27_9) then
				local var_27_12 = (arg_24_1.time_ - var_27_10) / var_27_11

				if arg_24_1.var_.characterEffect1075ui_story and not isNil(var_27_9) then
					arg_24_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_10 + var_27_11 and arg_24_1.time_ < var_27_10 + var_27_11 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect1075ui_story then
				arg_24_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_27_13 = 0
			local var_27_14 = 0.6

			if var_27_13 < arg_24_1.time_ and arg_24_1.time_ <= var_27_13 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_15 = arg_24_1:FormatText(StoryNameCfg[381].name)

				arg_24_1.leftNameTxt_.text = var_27_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_16 = arg_24_1:GetWordFromCfg(325762006)
				local var_27_17 = arg_24_1:FormatText(var_27_16.content)

				arg_24_1.text_.text = var_27_17

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_18 = 24
				local var_27_19 = utf8.len(var_27_17)
				local var_27_20 = var_27_18 <= 0 and var_27_14 or var_27_14 * (var_27_19 / var_27_18)

				if var_27_20 > 0 and var_27_14 < var_27_20 then
					arg_24_1.talkMaxDuration = var_27_20

					if var_27_20 + var_27_13 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_20 + var_27_13
					end
				end

				arg_24_1.text_.text = var_27_17
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325762", "325762006", "story_v_out_325762.awb") ~= 0 then
					local var_27_21 = manager.audio:GetVoiceLength("story_v_out_325762", "325762006", "story_v_out_325762.awb") / 1000

					if var_27_21 + var_27_13 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_21 + var_27_13
					end

					if var_27_16.prefab_name ~= "" and arg_24_1.actors_[var_27_16.prefab_name] ~= nil then
						local var_27_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_16.prefab_name].transform, "story_v_out_325762", "325762006", "story_v_out_325762.awb")

						arg_24_1:RecordAudio("325762006", var_27_22)
						arg_24_1:RecordAudio("325762006", var_27_22)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325762", "325762006", "story_v_out_325762.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325762", "325762006", "story_v_out_325762.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_23 = math.max(var_27_14, arg_24_1.talkMaxDuration)

			if var_27_13 <= arg_24_1.time_ and arg_24_1.time_ < var_27_13 + var_27_23 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_13) / var_27_23

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_13 + var_27_23 and arg_24_1.time_ < var_27_13 + var_27_23 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play325762007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325762007
		arg_28_1.duration_ = 7.57

		local var_28_0 = {
			zh = 7.566,
			ja = 7.133
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
				arg_28_0:Play325762008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1075ui_story"].transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.var_.moveOldPos1075ui_story = var_31_0.localPosition
			end

			local var_31_2 = 0.001

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2
				local var_31_4 = Vector3.New(-0.7, -1.055, -6.16)

				var_31_0.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1075ui_story, var_31_4, var_31_3)

				local var_31_5 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_5.x, var_31_5.y, var_31_5.z)

				local var_31_6 = var_31_0.localEulerAngles

				var_31_6.z = 0
				var_31_6.x = 0
				var_31_0.localEulerAngles = var_31_6
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 then
				var_31_0.localPosition = Vector3.New(-0.7, -1.055, -6.16)

				local var_31_7 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_7.x, var_31_7.y, var_31_7.z)

				local var_31_8 = var_31_0.localEulerAngles

				var_31_8.z = 0
				var_31_8.x = 0
				var_31_0.localEulerAngles = var_31_8
			end

			local var_31_9 = arg_28_1.actors_["1077ui_story"].transform
			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.var_.moveOldPos1077ui_story = var_31_9.localPosition

				local var_31_11 = GameObjectTools.GetOrAddComponent(var_31_9.gameObject, typeof(DynamicBoneHelper))

				if var_31_11 then
					var_31_11:EnableDynamicBone(false)
				end
			end

			local var_31_12 = 0.001

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_12 then
				local var_31_13 = (arg_28_1.time_ - var_31_10) / var_31_12
				local var_31_14 = Vector3.New(0.8, -1.02, -5.92)

				var_31_9.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1077ui_story, var_31_14, var_31_13)

				local var_31_15 = manager.ui.mainCamera.transform.position - var_31_9.position

				var_31_9.forward = Vector3.New(var_31_15.x, var_31_15.y, var_31_15.z)

				local var_31_16 = var_31_9.localEulerAngles

				var_31_16.z = 0
				var_31_16.x = 0
				var_31_9.localEulerAngles = var_31_16
			end

			if arg_28_1.time_ >= var_31_10 + var_31_12 and arg_28_1.time_ < var_31_10 + var_31_12 + arg_31_0 then
				var_31_9.localPosition = Vector3.New(0.8, -1.02, -5.92)

				local var_31_17 = manager.ui.mainCamera.transform.position - var_31_9.position

				var_31_9.forward = Vector3.New(var_31_17.x, var_31_17.y, var_31_17.z)

				local var_31_18 = var_31_9.localEulerAngles

				var_31_18.z = 0
				var_31_18.x = 0
				var_31_9.localEulerAngles = var_31_18

				local var_31_19 = GameObjectTools.GetOrAddComponent(var_31_9.gameObject, typeof(DynamicBoneHelper))

				if var_31_19 then
					var_31_19:EnableDynamicBone(true)
				end
			end

			local var_31_20 = arg_28_1.actors_["1077ui_story"]
			local var_31_21 = 0

			if var_31_21 < arg_28_1.time_ and arg_28_1.time_ <= var_31_21 + arg_31_0 and not isNil(var_31_20) and arg_28_1.var_.characterEffect1077ui_story == nil then
				arg_28_1.var_.characterEffect1077ui_story = var_31_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_22 = 0.200000002980232

			if var_31_21 <= arg_28_1.time_ and arg_28_1.time_ < var_31_21 + var_31_22 and not isNil(var_31_20) then
				local var_31_23 = (arg_28_1.time_ - var_31_21) / var_31_22

				if arg_28_1.var_.characterEffect1077ui_story and not isNil(var_31_20) then
					arg_28_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_21 + var_31_22 and arg_28_1.time_ < var_31_21 + var_31_22 + arg_31_0 and not isNil(var_31_20) and arg_28_1.var_.characterEffect1077ui_story then
				arg_28_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_31_24 = arg_28_1.actors_["1075ui_story"]
			local var_31_25 = 0

			if var_31_25 < arg_28_1.time_ and arg_28_1.time_ <= var_31_25 + arg_31_0 and not isNil(var_31_24) and arg_28_1.var_.characterEffect1075ui_story == nil then
				arg_28_1.var_.characterEffect1075ui_story = var_31_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_26 = 0.200000002980232

			if var_31_25 <= arg_28_1.time_ and arg_28_1.time_ < var_31_25 + var_31_26 and not isNil(var_31_24) then
				local var_31_27 = (arg_28_1.time_ - var_31_25) / var_31_26

				if arg_28_1.var_.characterEffect1075ui_story and not isNil(var_31_24) then
					local var_31_28 = Mathf.Lerp(0, 0.5, var_31_27)

					arg_28_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1075ui_story.fillRatio = var_31_28
				end
			end

			if arg_28_1.time_ >= var_31_25 + var_31_26 and arg_28_1.time_ < var_31_25 + var_31_26 + arg_31_0 and not isNil(var_31_24) and arg_28_1.var_.characterEffect1075ui_story then
				local var_31_29 = 0.5

				arg_28_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1075ui_story.fillRatio = var_31_29
			end

			local var_31_30 = 0

			if var_31_30 < arg_28_1.time_ and arg_28_1.time_ <= var_31_30 + arg_31_0 then
				arg_28_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_1")
			end

			local var_31_31 = 0

			if var_31_31 < arg_28_1.time_ and arg_28_1.time_ <= var_31_31 + arg_31_0 then
				arg_28_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_31_32 = 0
			local var_31_33 = 0.875

			if var_31_32 < arg_28_1.time_ and arg_28_1.time_ <= var_31_32 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_34 = arg_28_1:FormatText(StoryNameCfg[1467].name)

				arg_28_1.leftNameTxt_.text = var_31_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_35 = arg_28_1:GetWordFromCfg(325762007)
				local var_31_36 = arg_28_1:FormatText(var_31_35.content)

				arg_28_1.text_.text = var_31_36

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_37 = 35
				local var_31_38 = utf8.len(var_31_36)
				local var_31_39 = var_31_37 <= 0 and var_31_33 or var_31_33 * (var_31_38 / var_31_37)

				if var_31_39 > 0 and var_31_33 < var_31_39 then
					arg_28_1.talkMaxDuration = var_31_39

					if var_31_39 + var_31_32 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_39 + var_31_32
					end
				end

				arg_28_1.text_.text = var_31_36
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325762", "325762007", "story_v_out_325762.awb") ~= 0 then
					local var_31_40 = manager.audio:GetVoiceLength("story_v_out_325762", "325762007", "story_v_out_325762.awb") / 1000

					if var_31_40 + var_31_32 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_40 + var_31_32
					end

					if var_31_35.prefab_name ~= "" and arg_28_1.actors_[var_31_35.prefab_name] ~= nil then
						local var_31_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_35.prefab_name].transform, "story_v_out_325762", "325762007", "story_v_out_325762.awb")

						arg_28_1:RecordAudio("325762007", var_31_41)
						arg_28_1:RecordAudio("325762007", var_31_41)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325762", "325762007", "story_v_out_325762.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325762", "325762007", "story_v_out_325762.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_42 = math.max(var_31_33, arg_28_1.talkMaxDuration)

			if var_31_32 <= arg_28_1.time_ and arg_28_1.time_ < var_31_32 + var_31_42 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_32) / var_31_42

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_32 + var_31_42 and arg_28_1.time_ < var_31_32 + var_31_42 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play325762008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325762008
		arg_32_1.duration_ = 8

		local var_32_0 = {
			zh = 6.166,
			ja = 8
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
				arg_32_0:Play325762009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1075ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1075ui_story == nil then
				arg_32_1.var_.characterEffect1075ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1075ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1075ui_story then
				arg_32_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["1077ui_story"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect1077ui_story == nil then
				arg_32_1.var_.characterEffect1077ui_story = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.200000002980232

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect1077ui_story and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1077ui_story.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect1077ui_story then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1077ui_story.fillRatio = var_35_9
			end

			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_35_11 = 0

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_35_12 = 0
			local var_35_13 = 0.75

			if var_35_12 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_14 = arg_32_1:FormatText(StoryNameCfg[381].name)

				arg_32_1.leftNameTxt_.text = var_35_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_15 = arg_32_1:GetWordFromCfg(325762008)
				local var_35_16 = arg_32_1:FormatText(var_35_15.content)

				arg_32_1.text_.text = var_35_16

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_17 = 30
				local var_35_18 = utf8.len(var_35_16)
				local var_35_19 = var_35_17 <= 0 and var_35_13 or var_35_13 * (var_35_18 / var_35_17)

				if var_35_19 > 0 and var_35_13 < var_35_19 then
					arg_32_1.talkMaxDuration = var_35_19

					if var_35_19 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_19 + var_35_12
					end
				end

				arg_32_1.text_.text = var_35_16
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325762", "325762008", "story_v_out_325762.awb") ~= 0 then
					local var_35_20 = manager.audio:GetVoiceLength("story_v_out_325762", "325762008", "story_v_out_325762.awb") / 1000

					if var_35_20 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_20 + var_35_12
					end

					if var_35_15.prefab_name ~= "" and arg_32_1.actors_[var_35_15.prefab_name] ~= nil then
						local var_35_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_15.prefab_name].transform, "story_v_out_325762", "325762008", "story_v_out_325762.awb")

						arg_32_1:RecordAudio("325762008", var_35_21)
						arg_32_1:RecordAudio("325762008", var_35_21)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_325762", "325762008", "story_v_out_325762.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_325762", "325762008", "story_v_out_325762.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_22 = math.max(var_35_13, arg_32_1.talkMaxDuration)

			if var_35_12 <= arg_32_1.time_ and arg_32_1.time_ < var_35_12 + var_35_22 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_12) / var_35_22

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_12 + var_35_22 and arg_32_1.time_ < var_35_12 + var_35_22 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play325762009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325762009
		arg_36_1.duration_ = 3.8

		local var_36_0 = {
			zh = 2.733,
			ja = 3.8
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
				arg_36_0:Play325762010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1077ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1077ui_story == nil then
				arg_36_1.var_.characterEffect1077ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1077ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1077ui_story then
				arg_36_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["1075ui_story"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1075ui_story == nil then
				arg_36_1.var_.characterEffect1075ui_story = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.200000002980232

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect1075ui_story and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1075ui_story.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1075ui_story then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1075ui_story.fillRatio = var_39_9
			end

			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077actionlink/1077action483")
			end

			local var_39_11 = 0
			local var_39_12 = 0.35

			if var_39_11 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_13 = arg_36_1:FormatText(StoryNameCfg[1467].name)

				arg_36_1.leftNameTxt_.text = var_39_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_14 = arg_36_1:GetWordFromCfg(325762009)
				local var_39_15 = arg_36_1:FormatText(var_39_14.content)

				arg_36_1.text_.text = var_39_15

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_16 = 14
				local var_39_17 = utf8.len(var_39_15)
				local var_39_18 = var_39_16 <= 0 and var_39_12 or var_39_12 * (var_39_17 / var_39_16)

				if var_39_18 > 0 and var_39_12 < var_39_18 then
					arg_36_1.talkMaxDuration = var_39_18

					if var_39_18 + var_39_11 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_18 + var_39_11
					end
				end

				arg_36_1.text_.text = var_39_15
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325762", "325762009", "story_v_out_325762.awb") ~= 0 then
					local var_39_19 = manager.audio:GetVoiceLength("story_v_out_325762", "325762009", "story_v_out_325762.awb") / 1000

					if var_39_19 + var_39_11 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_19 + var_39_11
					end

					if var_39_14.prefab_name ~= "" and arg_36_1.actors_[var_39_14.prefab_name] ~= nil then
						local var_39_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_14.prefab_name].transform, "story_v_out_325762", "325762009", "story_v_out_325762.awb")

						arg_36_1:RecordAudio("325762009", var_39_20)
						arg_36_1:RecordAudio("325762009", var_39_20)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_325762", "325762009", "story_v_out_325762.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_325762", "325762009", "story_v_out_325762.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_21 = math.max(var_39_12, arg_36_1.talkMaxDuration)

			if var_39_11 <= arg_36_1.time_ and arg_36_1.time_ < var_39_11 + var_39_21 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_11) / var_39_21

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_11 + var_39_21 and arg_36_1.time_ < var_39_11 + var_39_21 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play325762010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325762010
		arg_40_1.duration_ = 7.1

		local var_40_0 = {
			zh = 5.9,
			ja = 7.1
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
				arg_40_0:Play325762011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1075ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1075ui_story == nil then
				arg_40_1.var_.characterEffect1075ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1075ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1075ui_story then
				arg_40_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_43_4 = arg_40_1.actors_["1077ui_story"]
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1077ui_story == nil then
				arg_40_1.var_.characterEffect1077ui_story = var_43_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.200000002980232

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 and not isNil(var_43_4) then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6

				if arg_40_1.var_.characterEffect1077ui_story and not isNil(var_43_4) then
					local var_43_8 = Mathf.Lerp(0, 0.5, var_43_7)

					arg_40_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1077ui_story.fillRatio = var_43_8
				end
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1077ui_story then
				local var_43_9 = 0.5

				arg_40_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1077ui_story.fillRatio = var_43_9
			end

			local var_43_10 = 0
			local var_43_11 = 0.8

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_12 = arg_40_1:FormatText(StoryNameCfg[381].name)

				arg_40_1.leftNameTxt_.text = var_43_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_13 = arg_40_1:GetWordFromCfg(325762010)
				local var_43_14 = arg_40_1:FormatText(var_43_13.content)

				arg_40_1.text_.text = var_43_14

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_15 = 32
				local var_43_16 = utf8.len(var_43_14)
				local var_43_17 = var_43_15 <= 0 and var_43_11 or var_43_11 * (var_43_16 / var_43_15)

				if var_43_17 > 0 and var_43_11 < var_43_17 then
					arg_40_1.talkMaxDuration = var_43_17

					if var_43_17 + var_43_10 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_17 + var_43_10
					end
				end

				arg_40_1.text_.text = var_43_14
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325762", "325762010", "story_v_out_325762.awb") ~= 0 then
					local var_43_18 = manager.audio:GetVoiceLength("story_v_out_325762", "325762010", "story_v_out_325762.awb") / 1000

					if var_43_18 + var_43_10 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_18 + var_43_10
					end

					if var_43_13.prefab_name ~= "" and arg_40_1.actors_[var_43_13.prefab_name] ~= nil then
						local var_43_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_13.prefab_name].transform, "story_v_out_325762", "325762010", "story_v_out_325762.awb")

						arg_40_1:RecordAudio("325762010", var_43_19)
						arg_40_1:RecordAudio("325762010", var_43_19)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_325762", "325762010", "story_v_out_325762.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_325762", "325762010", "story_v_out_325762.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_20 = math.max(var_43_11, arg_40_1.talkMaxDuration)

			if var_43_10 <= arg_40_1.time_ and arg_40_1.time_ < var_43_10 + var_43_20 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_10) / var_43_20

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_10 + var_43_20 and arg_40_1.time_ < var_43_10 + var_43_20 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play325762011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325762011
		arg_44_1.duration_ = 4.9

		local var_44_0 = {
			zh = 3.6,
			ja = 4.9
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
				arg_44_0:Play325762012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_47_2 = 0
			local var_47_3 = 0.475

			if var_47_2 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_4 = arg_44_1:FormatText(StoryNameCfg[381].name)

				arg_44_1.leftNameTxt_.text = var_47_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_5 = arg_44_1:GetWordFromCfg(325762011)
				local var_47_6 = arg_44_1:FormatText(var_47_5.content)

				arg_44_1.text_.text = var_47_6

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_7 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_325762", "325762011", "story_v_out_325762.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_out_325762", "325762011", "story_v_out_325762.awb") / 1000

					if var_47_10 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_2
					end

					if var_47_5.prefab_name ~= "" and arg_44_1.actors_[var_47_5.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_5.prefab_name].transform, "story_v_out_325762", "325762011", "story_v_out_325762.awb")

						arg_44_1:RecordAudio("325762011", var_47_11)
						arg_44_1:RecordAudio("325762011", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_325762", "325762011", "story_v_out_325762.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_325762", "325762011", "story_v_out_325762.awb")
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
	Play325762012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325762012
		arg_48_1.duration_ = 7.3

		local var_48_0 = {
			zh = 6.333,
			ja = 7.3
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
				arg_48_0:Play325762013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1077ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1077ui_story == nil then
				arg_48_1.var_.characterEffect1077ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1077ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1077ui_story then
				arg_48_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["1075ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1075ui_story == nil then
				arg_48_1.var_.characterEffect1075ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.200000002980232

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect1075ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1075ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1075ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1075ui_story.fillRatio = var_51_9
			end

			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_2")
			end

			local var_51_11 = 0

			if var_51_11 < arg_48_1.time_ and arg_48_1.time_ <= var_51_11 + arg_51_0 then
				arg_48_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_51_12 = 0
			local var_51_13 = 0.725

			if var_51_12 < arg_48_1.time_ and arg_48_1.time_ <= var_51_12 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_14 = arg_48_1:FormatText(StoryNameCfg[1467].name)

				arg_48_1.leftNameTxt_.text = var_51_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_15 = arg_48_1:GetWordFromCfg(325762012)
				local var_51_16 = arg_48_1:FormatText(var_51_15.content)

				arg_48_1.text_.text = var_51_16

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_17 = 29
				local var_51_18 = utf8.len(var_51_16)
				local var_51_19 = var_51_17 <= 0 and var_51_13 or var_51_13 * (var_51_18 / var_51_17)

				if var_51_19 > 0 and var_51_13 < var_51_19 then
					arg_48_1.talkMaxDuration = var_51_19

					if var_51_19 + var_51_12 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_19 + var_51_12
					end
				end

				arg_48_1.text_.text = var_51_16
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325762", "325762012", "story_v_out_325762.awb") ~= 0 then
					local var_51_20 = manager.audio:GetVoiceLength("story_v_out_325762", "325762012", "story_v_out_325762.awb") / 1000

					if var_51_20 + var_51_12 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_20 + var_51_12
					end

					if var_51_15.prefab_name ~= "" and arg_48_1.actors_[var_51_15.prefab_name] ~= nil then
						local var_51_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_15.prefab_name].transform, "story_v_out_325762", "325762012", "story_v_out_325762.awb")

						arg_48_1:RecordAudio("325762012", var_51_21)
						arg_48_1:RecordAudio("325762012", var_51_21)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_325762", "325762012", "story_v_out_325762.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_325762", "325762012", "story_v_out_325762.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_22 = math.max(var_51_13, arg_48_1.talkMaxDuration)

			if var_51_12 <= arg_48_1.time_ and arg_48_1.time_ < var_51_12 + var_51_22 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_12) / var_51_22

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_12 + var_51_22 and arg_48_1.time_ < var_51_12 + var_51_22 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play325762013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325762013
		arg_52_1.duration_ = 10.47

		local var_52_0 = {
			zh = 6.533,
			ja = 10.466
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
				arg_52_0:Play325762014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.825

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[1467].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_3 = arg_52_1:GetWordFromCfg(325762013)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 33
				local var_55_6 = utf8.len(var_55_4)
				local var_55_7 = var_55_5 <= 0 and var_55_1 or var_55_1 * (var_55_6 / var_55_5)

				if var_55_7 > 0 and var_55_1 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_4
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325762", "325762013", "story_v_out_325762.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_325762", "325762013", "story_v_out_325762.awb") / 1000

					if var_55_8 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_0
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_325762", "325762013", "story_v_out_325762.awb")

						arg_52_1:RecordAudio("325762013", var_55_9)
						arg_52_1:RecordAudio("325762013", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_325762", "325762013", "story_v_out_325762.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_325762", "325762013", "story_v_out_325762.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_10 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_10 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_10

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_10 and arg_52_1.time_ < var_55_0 + var_55_10 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play325762014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325762014
		arg_56_1.duration_ = 4.63

		local var_56_0 = {
			zh = 3.2,
			ja = 4.633
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
				arg_56_0:Play325762015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1075ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1075ui_story == nil then
				arg_56_1.var_.characterEffect1075ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1075ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1075ui_story then
				arg_56_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_59_4 = arg_56_1.actors_["1077ui_story"]
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect1077ui_story == nil then
				arg_56_1.var_.characterEffect1077ui_story = var_59_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_6 = 0.200000002980232

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 and not isNil(var_59_4) then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6

				if arg_56_1.var_.characterEffect1077ui_story and not isNil(var_59_4) then
					local var_59_8 = Mathf.Lerp(0, 0.5, var_59_7)

					arg_56_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1077ui_story.fillRatio = var_59_8
				end
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect1077ui_story then
				local var_59_9 = 0.5

				arg_56_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1077ui_story.fillRatio = var_59_9
			end

			local var_59_10 = 0
			local var_59_11 = 0.3

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_12 = arg_56_1:FormatText(StoryNameCfg[381].name)

				arg_56_1.leftNameTxt_.text = var_59_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_13 = arg_56_1:GetWordFromCfg(325762014)
				local var_59_14 = arg_56_1:FormatText(var_59_13.content)

				arg_56_1.text_.text = var_59_14

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_15 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_325762", "325762014", "story_v_out_325762.awb") ~= 0 then
					local var_59_18 = manager.audio:GetVoiceLength("story_v_out_325762", "325762014", "story_v_out_325762.awb") / 1000

					if var_59_18 + var_59_10 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_18 + var_59_10
					end

					if var_59_13.prefab_name ~= "" and arg_56_1.actors_[var_59_13.prefab_name] ~= nil then
						local var_59_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_13.prefab_name].transform, "story_v_out_325762", "325762014", "story_v_out_325762.awb")

						arg_56_1:RecordAudio("325762014", var_59_19)
						arg_56_1:RecordAudio("325762014", var_59_19)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_325762", "325762014", "story_v_out_325762.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_325762", "325762014", "story_v_out_325762.awb")
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
	Play325762015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325762015
		arg_60_1.duration_ = 3.47

		local var_60_0 = {
			zh = 2.366,
			ja = 3.466
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
			arg_60_1.auto_ = false
		end

		function arg_60_1.playNext_(arg_62_0)
			arg_60_1.onStoryFinished_()
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1077ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1077ui_story == nil then
				arg_60_1.var_.characterEffect1077ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1077ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1077ui_story then
				arg_60_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_63_4 = arg_60_1.actors_["1075ui_story"]
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1075ui_story == nil then
				arg_60_1.var_.characterEffect1075ui_story = var_63_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.200000002980232

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 and not isNil(var_63_4) then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6

				if arg_60_1.var_.characterEffect1075ui_story and not isNil(var_63_4) then
					local var_63_8 = Mathf.Lerp(0, 0.5, var_63_7)

					arg_60_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1075ui_story.fillRatio = var_63_8
				end
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1075ui_story then
				local var_63_9 = 0.5

				arg_60_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1075ui_story.fillRatio = var_63_9
			end

			local var_63_10 = 0
			local var_63_11 = 1

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				local var_63_12 = "play"
				local var_63_13 = "effect"

				arg_60_1:AudioAction(var_63_12, var_63_13, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_63_14 = 0
			local var_63_15 = 0.35

			if var_63_14 < arg_60_1.time_ and arg_60_1.time_ <= var_63_14 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_16 = arg_60_1:FormatText(StoryNameCfg[1467].name)

				arg_60_1.leftNameTxt_.text = var_63_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_17 = arg_60_1:GetWordFromCfg(325762015)
				local var_63_18 = arg_60_1:FormatText(var_63_17.content)

				arg_60_1.text_.text = var_63_18

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_19 = 14
				local var_63_20 = utf8.len(var_63_18)
				local var_63_21 = var_63_19 <= 0 and var_63_15 or var_63_15 * (var_63_20 / var_63_19)

				if var_63_21 > 0 and var_63_15 < var_63_21 then
					arg_60_1.talkMaxDuration = var_63_21

					if var_63_21 + var_63_14 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_21 + var_63_14
					end
				end

				arg_60_1.text_.text = var_63_18
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325762", "325762015", "story_v_out_325762.awb") ~= 0 then
					local var_63_22 = manager.audio:GetVoiceLength("story_v_out_325762", "325762015", "story_v_out_325762.awb") / 1000

					if var_63_22 + var_63_14 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_22 + var_63_14
					end

					if var_63_17.prefab_name ~= "" and arg_60_1.actors_[var_63_17.prefab_name] ~= nil then
						local var_63_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_17.prefab_name].transform, "story_v_out_325762", "325762015", "story_v_out_325762.awb")

						arg_60_1:RecordAudio("325762015", var_63_23)
						arg_60_1:RecordAudio("325762015", var_63_23)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_325762", "325762015", "story_v_out_325762.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_325762", "325762015", "story_v_out_325762.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_24 = math.max(var_63_15, arg_60_1.talkMaxDuration)

			if var_63_14 <= arg_60_1.time_ and arg_60_1.time_ < var_63_14 + var_63_24 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_14) / var_63_24

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_14 + var_63_24 and arg_60_1.time_ < var_63_14 + var_63_24 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J02"
	},
	voices = {
		"story_v_out_325762.awb"
	}
}
