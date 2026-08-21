return {
	Play325091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325091001
		arg_1_1.duration_ = 6.6

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J29g"

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
				local var_4_5 = arg_1_1.bgs_.J29g

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
					if iter_4_0 ~= "J29g" then
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

			local var_4_24 = 0.1
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_143", "se_story_143_amb_drone_dark", "")
			end

			local var_4_28 = 0.6
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "effect"

				arg_1_1:AudioAction(var_4_30, var_4_31, "se_story_148", "se_story_148_footstep04", "")
			end

			local var_4_32 = 0
			local var_4_33 = 1

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "bgm_activity_5_1_story_jianzhong", "bgm_activity_5_1_story_jianzhong", "bgm_activity_5_1_story_jianzhong.awb")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("bgm_activity_5_1_story_jianzhong", "bgm_activity_5_1_story_jianzhong")

				if var_4_37 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_37 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_37

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_37
						arg_1_1.bgmTxt2_.text = var_4_37
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

			local var_4_38 = 1.6
			local var_4_39 = 1.15

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_41 = arg_1_1:GetWordFromCfg(325091001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 46
				local var_4_44 = utf8.len(var_4_42)
				local var_4_45 = var_4_43 <= 0 and var_4_39 or var_4_39 * (var_4_44 / var_4_43)

				if var_4_45 > 0 and var_4_39 < var_4_45 then
					arg_1_1.talkMaxDuration = var_4_45
					var_4_38 = var_4_38 + 0.3

					if var_4_45 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_42
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_46 = var_4_38 + 0.3
			local var_4_47 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_46 <= arg_1_1.time_ and arg_1_1.time_ < var_4_46 + var_4_47 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_46) / var_4_47

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_46 + var_4_47 and arg_1_1.time_ < var_4_46 + var_4_47 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play325091002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325091002
		arg_8_1.duration_ = 4.8

		local var_8_0 = {
			zh = 3.2,
			ja = 4.8
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
				arg_8_0:Play325091003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1077ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1077ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1077ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1077ui_story"].transform
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.var_.moveOldPos1077ui_story = var_11_5.localPosition

				local var_11_7 = GameObjectTools.GetOrAddComponent(var_11_5.gameObject, typeof(DynamicBoneHelper))

				if var_11_7 then
					var_11_7:EnableDynamicBone(false)
				end
			end

			local var_11_8 = 0.001

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_8 then
				local var_11_9 = (arg_8_1.time_ - var_11_6) / var_11_8
				local var_11_10 = Vector3.New(-0.03, -1.02, -5.92)

				var_11_5.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1077ui_story, var_11_10, var_11_9)

				local var_11_11 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_11.x, var_11_11.y, var_11_11.z)

				local var_11_12 = var_11_5.localEulerAngles

				var_11_12.z = 0
				var_11_12.x = 0
				var_11_5.localEulerAngles = var_11_12
			end

			if arg_8_1.time_ >= var_11_6 + var_11_8 and arg_8_1.time_ < var_11_6 + var_11_8 + arg_11_0 then
				var_11_5.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_11_13 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_13.x, var_11_13.y, var_11_13.z)

				local var_11_14 = var_11_5.localEulerAngles

				var_11_14.z = 0
				var_11_14.x = 0
				var_11_5.localEulerAngles = var_11_14

				local var_11_15 = GameObjectTools.GetOrAddComponent(var_11_5.gameObject, typeof(DynamicBoneHelper))

				if var_11_15 then
					var_11_15:EnableDynamicBone(true)
				end
			end

			local var_11_16 = arg_8_1.actors_["1077ui_story"]
			local var_11_17 = 0

			if var_11_17 < arg_8_1.time_ and arg_8_1.time_ <= var_11_17 + arg_11_0 and not isNil(var_11_16) and arg_8_1.var_.characterEffect1077ui_story == nil then
				arg_8_1.var_.characterEffect1077ui_story = var_11_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_18 = 0.200000002980232

			if var_11_17 <= arg_8_1.time_ and arg_8_1.time_ < var_11_17 + var_11_18 and not isNil(var_11_16) then
				local var_11_19 = (arg_8_1.time_ - var_11_17) / var_11_18

				if arg_8_1.var_.characterEffect1077ui_story and not isNil(var_11_16) then
					arg_8_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_17 + var_11_18 and arg_8_1.time_ < var_11_17 + var_11_18 + arg_11_0 and not isNil(var_11_16) and arg_8_1.var_.characterEffect1077ui_story then
				arg_8_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_11_20 = 0

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_11_21 = 0

			if var_11_21 < arg_8_1.time_ and arg_8_1.time_ <= var_11_21 + arg_11_0 then
				arg_8_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_11_22 = 0
			local var_11_23 = 0.375

			if var_11_22 < arg_8_1.time_ and arg_8_1.time_ <= var_11_22 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_24 = arg_8_1:FormatText(StoryNameCfg[1467].name)

				arg_8_1.leftNameTxt_.text = var_11_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_25 = arg_8_1:GetWordFromCfg(325091002)
				local var_11_26 = arg_8_1:FormatText(var_11_25.content)

				arg_8_1.text_.text = var_11_26

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_27 = 15
				local var_11_28 = utf8.len(var_11_26)
				local var_11_29 = var_11_27 <= 0 and var_11_23 or var_11_23 * (var_11_28 / var_11_27)

				if var_11_29 > 0 and var_11_23 < var_11_29 then
					arg_8_1.talkMaxDuration = var_11_29

					if var_11_29 + var_11_22 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_29 + var_11_22
					end
				end

				arg_8_1.text_.text = var_11_26
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091002", "story_v_out_325091.awb") ~= 0 then
					local var_11_30 = manager.audio:GetVoiceLength("story_v_out_325091", "325091002", "story_v_out_325091.awb") / 1000

					if var_11_30 + var_11_22 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_30 + var_11_22
					end

					if var_11_25.prefab_name ~= "" and arg_8_1.actors_[var_11_25.prefab_name] ~= nil then
						local var_11_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_25.prefab_name].transform, "story_v_out_325091", "325091002", "story_v_out_325091.awb")

						arg_8_1:RecordAudio("325091002", var_11_31)
						arg_8_1:RecordAudio("325091002", var_11_31)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_325091", "325091002", "story_v_out_325091.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_325091", "325091002", "story_v_out_325091.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_32 = math.max(var_11_23, arg_8_1.talkMaxDuration)

			if var_11_22 <= arg_8_1.time_ and arg_8_1.time_ < var_11_22 + var_11_32 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_22) / var_11_32

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_22 + var_11_32 and arg_8_1.time_ < var_11_22 + var_11_32 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
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

		arg_8_1:InitPlayNodeList()
	end,
	Play325091003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325091003
		arg_12_1.duration_ = 11.43

		local var_12_0 = {
			zh = 4.933,
			ja = 11.433
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
				arg_12_0:Play325091004(arg_12_1)
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
				local var_15_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_15_0.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1077ui_story, var_15_5, var_15_4)

				local var_15_6 = manager.ui.mainCamera.transform.position - var_15_0.position

				var_15_0.forward = Vector3.New(var_15_6.x, var_15_6.y, var_15_6.z)

				local var_15_7 = var_15_0.localEulerAngles

				var_15_7.z = 0
				var_15_7.x = 0
				var_15_0.localEulerAngles = var_15_7
			end

			if arg_12_1.time_ >= var_15_1 + var_15_3 and arg_12_1.time_ < var_15_1 + var_15_3 + arg_15_0 then
				var_15_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

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
			local var_15_18 = 0.575

			if var_15_17 < arg_12_1.time_ and arg_12_1.time_ <= var_15_17 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_19 = arg_12_1:FormatText(StoryNameCfg[1455].name)

				arg_12_1.leftNameTxt_.text = var_15_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_20 = arg_12_1:GetWordFromCfg(325091003)
				local var_15_21 = arg_12_1:FormatText(var_15_20.content)

				arg_12_1.text_.text = var_15_21

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_22 = 23
				local var_15_23 = utf8.len(var_15_21)
				local var_15_24 = var_15_22 <= 0 and var_15_18 or var_15_18 * (var_15_23 / var_15_22)

				if var_15_24 > 0 and var_15_18 < var_15_24 then
					arg_12_1.talkMaxDuration = var_15_24

					if var_15_24 + var_15_17 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_24 + var_15_17
					end
				end

				arg_12_1.text_.text = var_15_21
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091003", "story_v_out_325091.awb") ~= 0 then
					local var_15_25 = manager.audio:GetVoiceLength("story_v_out_325091", "325091003", "story_v_out_325091.awb") / 1000

					if var_15_25 + var_15_17 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_25 + var_15_17
					end

					if var_15_20.prefab_name ~= "" and arg_12_1.actors_[var_15_20.prefab_name] ~= nil then
						local var_15_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_20.prefab_name].transform, "story_v_out_325091", "325091003", "story_v_out_325091.awb")

						arg_12_1:RecordAudio("325091003", var_15_26)
						arg_12_1:RecordAudio("325091003", var_15_26)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_325091", "325091003", "story_v_out_325091.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_325091", "325091003", "story_v_out_325091.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_27 = math.max(var_15_18, arg_12_1.talkMaxDuration)

			if var_15_17 <= arg_12_1.time_ and arg_12_1.time_ < var_15_17 + var_15_27 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_17) / var_15_27

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_17 + var_15_27 and arg_12_1.time_ < var_15_17 + var_15_27 + arg_15_0 then
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
	Play325091004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325091004
		arg_16_1.duration_ = 3.4

		local var_16_0 = {
			zh = 1.999999999999,
			ja = 3.4
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
				arg_16_0:Play325091005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1077ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1077ui_story == nil then
				arg_16_1.var_.characterEffect1077ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.200000002980232

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect1077ui_story and not isNil(var_19_0) then
					arg_16_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1077ui_story then
				arg_16_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_19_4 = 0

			if var_19_4 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_1")
			end

			local var_19_5 = 0

			if var_19_5 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 then
				arg_16_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_19_6 = 0
			local var_19_7 = 0.2

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_8 = arg_16_1:FormatText(StoryNameCfg[1467].name)

				arg_16_1.leftNameTxt_.text = var_19_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_9 = arg_16_1:GetWordFromCfg(325091004)
				local var_19_10 = arg_16_1:FormatText(var_19_9.content)

				arg_16_1.text_.text = var_19_10

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_11 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091004", "story_v_out_325091.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_out_325091", "325091004", "story_v_out_325091.awb") / 1000

					if var_19_14 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_6
					end

					if var_19_9.prefab_name ~= "" and arg_16_1.actors_[var_19_9.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_9.prefab_name].transform, "story_v_out_325091", "325091004", "story_v_out_325091.awb")

						arg_16_1:RecordAudio("325091004", var_19_15)
						arg_16_1:RecordAudio("325091004", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325091", "325091004", "story_v_out_325091.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325091", "325091004", "story_v_out_325091.awb")
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
	Play325091005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325091005
		arg_20_1.duration_ = 7.6

		local var_20_0 = {
			zh = 4.2,
			ja = 7.6
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
				arg_20_0:Play325091006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1077ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1077ui_story == nil then
				arg_20_1.var_.characterEffect1077ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.200000002980232

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1077ui_story and not isNil(var_23_0) then
					local var_23_4 = Mathf.Lerp(0, 0.5, var_23_3)

					arg_20_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1077ui_story.fillRatio = var_23_4
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1077ui_story then
				local var_23_5 = 0.5

				arg_20_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1077ui_story.fillRatio = var_23_5
			end

			local var_23_6 = 0
			local var_23_7 = 0.5

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_8 = arg_20_1:FormatText(StoryNameCfg[1455].name)

				arg_20_1.leftNameTxt_.text = var_23_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_9 = arg_20_1:GetWordFromCfg(325091005)
				local var_23_10 = arg_20_1:FormatText(var_23_9.content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 20
				local var_23_12 = utf8.len(var_23_10)
				local var_23_13 = var_23_11 <= 0 and var_23_7 or var_23_7 * (var_23_12 / var_23_11)

				if var_23_13 > 0 and var_23_7 < var_23_13 then
					arg_20_1.talkMaxDuration = var_23_13

					if var_23_13 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_10
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091005", "story_v_out_325091.awb") ~= 0 then
					local var_23_14 = manager.audio:GetVoiceLength("story_v_out_325091", "325091005", "story_v_out_325091.awb") / 1000

					if var_23_14 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_6
					end

					if var_23_9.prefab_name ~= "" and arg_20_1.actors_[var_23_9.prefab_name] ~= nil then
						local var_23_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_9.prefab_name].transform, "story_v_out_325091", "325091005", "story_v_out_325091.awb")

						arg_20_1:RecordAudio("325091005", var_23_15)
						arg_20_1:RecordAudio("325091005", var_23_15)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325091", "325091005", "story_v_out_325091.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325091", "325091005", "story_v_out_325091.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_16 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_16 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_16

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_16 and arg_20_1.time_ < var_23_6 + var_23_16 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play325091006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325091006
		arg_24_1.duration_ = 9.13

		local var_24_0 = {
			zh = 7.166,
			ja = 9.133
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
				arg_24_0:Play325091007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.875

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[1455].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(325091006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 35
				local var_27_6 = utf8.len(var_27_4)
				local var_27_7 = var_27_5 <= 0 and var_27_1 or var_27_1 * (var_27_6 / var_27_5)

				if var_27_7 > 0 and var_27_1 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091006", "story_v_out_325091.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_325091", "325091006", "story_v_out_325091.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_325091", "325091006", "story_v_out_325091.awb")

						arg_24_1:RecordAudio("325091006", var_27_9)
						arg_24_1:RecordAudio("325091006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325091", "325091006", "story_v_out_325091.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325091", "325091006", "story_v_out_325091.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_10 and arg_24_1.time_ < var_27_0 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play325091007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325091007
		arg_28_1.duration_ = 6.9

		local var_28_0 = {
			zh = 5.8,
			ja = 6.9
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
				arg_28_0:Play325091008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.7

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[1455].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:GetWordFromCfg(325091007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 28
				local var_31_6 = utf8.len(var_31_4)
				local var_31_7 = var_31_5 <= 0 and var_31_1 or var_31_1 * (var_31_6 / var_31_5)

				if var_31_7 > 0 and var_31_1 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_4
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091007", "story_v_out_325091.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_325091", "325091007", "story_v_out_325091.awb") / 1000

					if var_31_8 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_0
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_325091", "325091007", "story_v_out_325091.awb")

						arg_28_1:RecordAudio("325091007", var_31_9)
						arg_28_1:RecordAudio("325091007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325091", "325091007", "story_v_out_325091.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325091", "325091007", "story_v_out_325091.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_10 and arg_28_1.time_ < var_31_0 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play325091008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325091008
		arg_32_1.duration_ = 5.2

		local var_32_0 = {
			zh = 3.933,
			ja = 5.2
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
				arg_32_0:Play325091009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1077ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1077ui_story == nil then
				arg_32_1.var_.characterEffect1077ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1077ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1077ui_story then
				arg_32_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_35_4 = 0

			if var_35_4 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_2")
			end

			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 then
				arg_32_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_35_6 = 0
			local var_35_7 = 0.55

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_8 = arg_32_1:FormatText(StoryNameCfg[1467].name)

				arg_32_1.leftNameTxt_.text = var_35_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_9 = arg_32_1:GetWordFromCfg(325091008)
				local var_35_10 = arg_32_1:FormatText(var_35_9.content)

				arg_32_1.text_.text = var_35_10

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_11 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091008", "story_v_out_325091.awb") ~= 0 then
					local var_35_14 = manager.audio:GetVoiceLength("story_v_out_325091", "325091008", "story_v_out_325091.awb") / 1000

					if var_35_14 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_14 + var_35_6
					end

					if var_35_9.prefab_name ~= "" and arg_32_1.actors_[var_35_9.prefab_name] ~= nil then
						local var_35_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_9.prefab_name].transform, "story_v_out_325091", "325091008", "story_v_out_325091.awb")

						arg_32_1:RecordAudio("325091008", var_35_15)
						arg_32_1:RecordAudio("325091008", var_35_15)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_325091", "325091008", "story_v_out_325091.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_325091", "325091008", "story_v_out_325091.awb")
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
	Play325091009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325091009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play325091010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1077ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos1077ui_story = var_39_0.localPosition

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_0.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end
			end

			local var_39_3 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_3 then
				local var_39_4 = (arg_36_1.time_ - var_39_1) / var_39_3
				local var_39_5 = Vector3.New(0, 100, 0)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1077ui_story, var_39_5, var_39_4)

				local var_39_6 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_6.x, var_39_6.y, var_39_6.z)

				local var_39_7 = var_39_0.localEulerAngles

				var_39_7.z = 0
				var_39_7.x = 0
				var_39_0.localEulerAngles = var_39_7
			end

			if arg_36_1.time_ >= var_39_1 + var_39_3 and arg_36_1.time_ < var_39_1 + var_39_3 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, 100, 0)

				local var_39_8 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_8.x, var_39_8.y, var_39_8.z)

				local var_39_9 = var_39_0.localEulerAngles

				var_39_9.z = 0
				var_39_9.x = 0
				var_39_0.localEulerAngles = var_39_9

				local var_39_10 = GameObjectTools.GetOrAddComponent(var_39_0.gameObject, typeof(DynamicBoneHelper))

				if var_39_10 then
					var_39_10:EnableDynamicBone(true)
				end
			end

			local var_39_11 = "1059ui_story"

			if arg_36_1.actors_[var_39_11] == nil then
				local var_39_12 = Asset.Load("Char/" .. "1059ui_story")

				if not isNil(var_39_12) then
					local var_39_13 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_36_1.stage_.transform)

					var_39_13.name = var_39_11
					var_39_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_36_1.actors_[var_39_11] = var_39_13

					local var_39_14 = var_39_13:GetComponentInChildren(typeof(CharacterEffect))

					var_39_14.enabled = true

					local var_39_15 = GameObjectTools.GetOrAddComponent(var_39_13, typeof(DynamicBoneHelper))

					if var_39_15 then
						var_39_15:EnableDynamicBone(false)
					end

					arg_36_1:ShowWeapon(var_39_14.transform, false)

					arg_36_1.var_[var_39_11 .. "Animator"] = var_39_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_36_1.var_[var_39_11 .. "Animator"].applyRootMotion = true
					arg_36_1.var_[var_39_11 .. "LipSync"] = var_39_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_39_16 = arg_36_1.actors_["1059ui_story"].transform
			local var_39_17 = 0

			if var_39_17 < arg_36_1.time_ and arg_36_1.time_ <= var_39_17 + arg_39_0 then
				arg_36_1.var_.moveOldPos1059ui_story = var_39_16.localPosition
			end

			local var_39_18 = 0.001

			if var_39_17 <= arg_36_1.time_ and arg_36_1.time_ < var_39_17 + var_39_18 then
				local var_39_19 = (arg_36_1.time_ - var_39_17) / var_39_18
				local var_39_20 = Vector3.New(0, 100, 0)

				var_39_16.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1059ui_story, var_39_20, var_39_19)

				local var_39_21 = manager.ui.mainCamera.transform.position - var_39_16.position

				var_39_16.forward = Vector3.New(var_39_21.x, var_39_21.y, var_39_21.z)

				local var_39_22 = var_39_16.localEulerAngles

				var_39_22.z = 0
				var_39_22.x = 0
				var_39_16.localEulerAngles = var_39_22
			end

			if arg_36_1.time_ >= var_39_17 + var_39_18 and arg_36_1.time_ < var_39_17 + var_39_18 + arg_39_0 then
				var_39_16.localPosition = Vector3.New(0, 100, 0)

				local var_39_23 = manager.ui.mainCamera.transform.position - var_39_16.position

				var_39_16.forward = Vector3.New(var_39_23.x, var_39_23.y, var_39_23.z)

				local var_39_24 = var_39_16.localEulerAngles

				var_39_24.z = 0
				var_39_24.x = 0
				var_39_16.localEulerAngles = var_39_24
			end

			local var_39_25 = arg_36_1.actors_["1077ui_story"]
			local var_39_26 = 0

			if var_39_26 < arg_36_1.time_ and arg_36_1.time_ <= var_39_26 + arg_39_0 and not isNil(var_39_25) and arg_36_1.var_.characterEffect1077ui_story == nil then
				arg_36_1.var_.characterEffect1077ui_story = var_39_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_27 = 0.200000002980232

			if var_39_26 <= arg_36_1.time_ and arg_36_1.time_ < var_39_26 + var_39_27 and not isNil(var_39_25) then
				local var_39_28 = (arg_36_1.time_ - var_39_26) / var_39_27

				if arg_36_1.var_.characterEffect1077ui_story and not isNil(var_39_25) then
					local var_39_29 = Mathf.Lerp(0, 0.5, var_39_28)

					arg_36_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1077ui_story.fillRatio = var_39_29
				end
			end

			if arg_36_1.time_ >= var_39_26 + var_39_27 and arg_36_1.time_ < var_39_26 + var_39_27 + arg_39_0 and not isNil(var_39_25) and arg_36_1.var_.characterEffect1077ui_story then
				local var_39_30 = 0.5

				arg_36_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1077ui_story.fillRatio = var_39_30
			end

			local var_39_31 = 0
			local var_39_32 = 1.125

			if var_39_31 < arg_36_1.time_ and arg_36_1.time_ <= var_39_31 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_33 = arg_36_1:GetWordFromCfg(325091009)
				local var_39_34 = arg_36_1:FormatText(var_39_33.content)

				arg_36_1.text_.text = var_39_34

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_35 = 45
				local var_39_36 = utf8.len(var_39_34)
				local var_39_37 = var_39_35 <= 0 and var_39_32 or var_39_32 * (var_39_36 / var_39_35)

				if var_39_37 > 0 and var_39_32 < var_39_37 then
					arg_36_1.talkMaxDuration = var_39_37

					if var_39_37 + var_39_31 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_37 + var_39_31
					end
				end

				arg_36_1.text_.text = var_39_34
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_38 = math.max(var_39_32, arg_36_1.talkMaxDuration)

			if var_39_31 <= arg_36_1.time_ and arg_36_1.time_ < var_39_31 + var_39_38 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_31) / var_39_38

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_31 + var_39_38 and arg_36_1.time_ < var_39_31 + var_39_38 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play325091010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325091010
		arg_40_1.duration_ = 9.6

		local var_40_0 = {
			zh = 6.4,
			ja = 9.6
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
				arg_40_0:Play325091011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.75

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[1455].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:GetWordFromCfg(325091010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 30
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091010", "story_v_out_325091.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_325091", "325091010", "story_v_out_325091.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_325091", "325091010", "story_v_out_325091.awb")

						arg_40_1:RecordAudio("325091010", var_43_9)
						arg_40_1:RecordAudio("325091010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_325091", "325091010", "story_v_out_325091.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_325091", "325091010", "story_v_out_325091.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_10 and arg_40_1.time_ < var_43_0 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play325091011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325091011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play325091012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.3
			local var_47_1 = 1

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				local var_47_2 = "play"
				local var_47_3 = "effect"

				arg_44_1:AudioAction(var_47_2, var_47_3, "se_story_1211", "se_story_1211_power", "")
			end

			local var_47_4 = 0
			local var_47_5 = 1.25

			if var_47_4 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_6 = arg_44_1:GetWordFromCfg(325091011)
				local var_47_7 = arg_44_1:FormatText(var_47_6.content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_8 = 50
				local var_47_9 = utf8.len(var_47_7)
				local var_47_10 = var_47_8 <= 0 and var_47_5 or var_47_5 * (var_47_9 / var_47_8)

				if var_47_10 > 0 and var_47_5 < var_47_10 then
					arg_44_1.talkMaxDuration = var_47_10

					if var_47_10 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_11 = math.max(var_47_5, arg_44_1.talkMaxDuration)

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_11 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_4) / var_47_11

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_4 + var_47_11 and arg_44_1.time_ < var_47_4 + var_47_11 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play325091012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325091012
		arg_48_1.duration_ = 7.7

		local var_48_0 = {
			zh = 5.233,
			ja = 7.7
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
				arg_48_0:Play325091013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.6

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[1455].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_3 = arg_48_1:GetWordFromCfg(325091012)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091012", "story_v_out_325091.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_325091", "325091012", "story_v_out_325091.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_325091", "325091012", "story_v_out_325091.awb")

						arg_48_1:RecordAudio("325091012", var_51_9)
						arg_48_1:RecordAudio("325091012", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_325091", "325091012", "story_v_out_325091.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_325091", "325091012", "story_v_out_325091.awb")
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
	Play325091013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325091013
		arg_52_1.duration_ = 8

		local var_52_0 = {
			zh = 4.1,
			ja = 8
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
				arg_52_0:Play325091014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1077ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos1077ui_story = var_55_0.localPosition

				local var_55_2 = GameObjectTools.GetOrAddComponent(var_55_0.gameObject, typeof(DynamicBoneHelper))

				if var_55_2 then
					var_55_2:EnableDynamicBone(false)
				end
			end

			local var_55_3 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_3 then
				local var_55_4 = (arg_52_1.time_ - var_55_1) / var_55_3
				local var_55_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1077ui_story, var_55_5, var_55_4)

				local var_55_6 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_6.x, var_55_6.y, var_55_6.z)

				local var_55_7 = var_55_0.localEulerAngles

				var_55_7.z = 0
				var_55_7.x = 0
				var_55_0.localEulerAngles = var_55_7
			end

			if arg_52_1.time_ >= var_55_1 + var_55_3 and arg_52_1.time_ < var_55_1 + var_55_3 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_55_8 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_8.x, var_55_8.y, var_55_8.z)

				local var_55_9 = var_55_0.localEulerAngles

				var_55_9.z = 0
				var_55_9.x = 0
				var_55_0.localEulerAngles = var_55_9

				local var_55_10 = GameObjectTools.GetOrAddComponent(var_55_0.gameObject, typeof(DynamicBoneHelper))

				if var_55_10 then
					var_55_10:EnableDynamicBone(true)
				end
			end

			local var_55_11 = arg_52_1.actors_["1077ui_story"]
			local var_55_12 = 0

			if var_55_12 < arg_52_1.time_ and arg_52_1.time_ <= var_55_12 + arg_55_0 and not isNil(var_55_11) and arg_52_1.var_.characterEffect1077ui_story == nil then
				arg_52_1.var_.characterEffect1077ui_story = var_55_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_13 = 0.200000002980232

			if var_55_12 <= arg_52_1.time_ and arg_52_1.time_ < var_55_12 + var_55_13 and not isNil(var_55_11) then
				local var_55_14 = (arg_52_1.time_ - var_55_12) / var_55_13

				if arg_52_1.var_.characterEffect1077ui_story and not isNil(var_55_11) then
					arg_52_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_12 + var_55_13 and arg_52_1.time_ < var_55_12 + var_55_13 + arg_55_0 and not isNil(var_55_11) and arg_52_1.var_.characterEffect1077ui_story then
				arg_52_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_55_15 = 0
			local var_55_16 = 0.45

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_17 = arg_52_1:FormatText(StoryNameCfg[1467].name)

				arg_52_1.leftNameTxt_.text = var_55_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_18 = arg_52_1:GetWordFromCfg(325091013)
				local var_55_19 = arg_52_1:FormatText(var_55_18.content)

				arg_52_1.text_.text = var_55_19

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_20 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091013", "story_v_out_325091.awb") ~= 0 then
					local var_55_23 = manager.audio:GetVoiceLength("story_v_out_325091", "325091013", "story_v_out_325091.awb") / 1000

					if var_55_23 + var_55_15 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_23 + var_55_15
					end

					if var_55_18.prefab_name ~= "" and arg_52_1.actors_[var_55_18.prefab_name] ~= nil then
						local var_55_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_18.prefab_name].transform, "story_v_out_325091", "325091013", "story_v_out_325091.awb")

						arg_52_1:RecordAudio("325091013", var_55_24)
						arg_52_1:RecordAudio("325091013", var_55_24)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_325091", "325091013", "story_v_out_325091.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_325091", "325091013", "story_v_out_325091.awb")
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
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play325091014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325091014
		arg_56_1.duration_ = 12.07

		local var_56_0 = {
			zh = 9.033,
			ja = 12.066
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
				arg_56_0:Play325091015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1077ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1077ui_story == nil then
				arg_56_1.var_.characterEffect1077ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1077ui_story and not isNil(var_59_0) then
					local var_59_4 = Mathf.Lerp(0, 0.5, var_59_3)

					arg_56_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1077ui_story.fillRatio = var_59_4
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1077ui_story then
				local var_59_5 = 0.5

				arg_56_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1077ui_story.fillRatio = var_59_5
			end

			local var_59_6 = 0
			local var_59_7 = 1.075

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_8 = arg_56_1:FormatText(StoryNameCfg[1455].name)

				arg_56_1.leftNameTxt_.text = var_59_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_9 = arg_56_1:GetWordFromCfg(325091014)
				local var_59_10 = arg_56_1:FormatText(var_59_9.content)

				arg_56_1.text_.text = var_59_10

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_11 = 43
				local var_59_12 = utf8.len(var_59_10)
				local var_59_13 = var_59_11 <= 0 and var_59_7 or var_59_7 * (var_59_12 / var_59_11)

				if var_59_13 > 0 and var_59_7 < var_59_13 then
					arg_56_1.talkMaxDuration = var_59_13

					if var_59_13 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_13 + var_59_6
					end
				end

				arg_56_1.text_.text = var_59_10
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091014", "story_v_out_325091.awb") ~= 0 then
					local var_59_14 = manager.audio:GetVoiceLength("story_v_out_325091", "325091014", "story_v_out_325091.awb") / 1000

					if var_59_14 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_14 + var_59_6
					end

					if var_59_9.prefab_name ~= "" and arg_56_1.actors_[var_59_9.prefab_name] ~= nil then
						local var_59_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_9.prefab_name].transform, "story_v_out_325091", "325091014", "story_v_out_325091.awb")

						arg_56_1:RecordAudio("325091014", var_59_15)
						arg_56_1:RecordAudio("325091014", var_59_15)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_325091", "325091014", "story_v_out_325091.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_325091", "325091014", "story_v_out_325091.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_16 = math.max(var_59_7, arg_56_1.talkMaxDuration)

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_16 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_6) / var_59_16

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_6 + var_59_16 and arg_56_1.time_ < var_59_6 + var_59_16 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play325091015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325091015
		arg_60_1.duration_ = 4.57

		local var_60_0 = {
			zh = 2.533,
			ja = 4.566
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
				arg_60_0:Play325091016(arg_60_1)
			end
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

			local var_63_4 = 0

			if var_63_4 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 then
				arg_60_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_63_6 = 0
			local var_63_7 = 0.325

			if var_63_6 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_8 = arg_60_1:FormatText(StoryNameCfg[1467].name)

				arg_60_1.leftNameTxt_.text = var_63_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_9 = arg_60_1:GetWordFromCfg(325091015)
				local var_63_10 = arg_60_1:FormatText(var_63_9.content)

				arg_60_1.text_.text = var_63_10

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_11 = 13
				local var_63_12 = utf8.len(var_63_10)
				local var_63_13 = var_63_11 <= 0 and var_63_7 or var_63_7 * (var_63_12 / var_63_11)

				if var_63_13 > 0 and var_63_7 < var_63_13 then
					arg_60_1.talkMaxDuration = var_63_13

					if var_63_13 + var_63_6 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_13 + var_63_6
					end
				end

				arg_60_1.text_.text = var_63_10
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091015", "story_v_out_325091.awb") ~= 0 then
					local var_63_14 = manager.audio:GetVoiceLength("story_v_out_325091", "325091015", "story_v_out_325091.awb") / 1000

					if var_63_14 + var_63_6 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_14 + var_63_6
					end

					if var_63_9.prefab_name ~= "" and arg_60_1.actors_[var_63_9.prefab_name] ~= nil then
						local var_63_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_9.prefab_name].transform, "story_v_out_325091", "325091015", "story_v_out_325091.awb")

						arg_60_1:RecordAudio("325091015", var_63_15)
						arg_60_1:RecordAudio("325091015", var_63_15)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_325091", "325091015", "story_v_out_325091.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_325091", "325091015", "story_v_out_325091.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_16 = math.max(var_63_7, arg_60_1.talkMaxDuration)

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_16 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_6) / var_63_16

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_6 + var_63_16 and arg_60_1.time_ < var_63_6 + var_63_16 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play325091016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325091016
		arg_64_1.duration_ = 11.37

		local var_64_0 = {
			zh = 6.8,
			ja = 11.366
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
				arg_64_0:Play325091017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1059ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1059ui_story == nil then
				arg_64_1.var_.characterEffect1059ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1059ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1059ui_story then
				arg_64_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_67_4 = arg_64_1.actors_["1077ui_story"]
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1077ui_story == nil then
				arg_64_1.var_.characterEffect1077ui_story = var_67_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.200000002980232

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 and not isNil(var_67_4) then
				local var_67_7 = (arg_64_1.time_ - var_67_5) / var_67_6

				if arg_64_1.var_.characterEffect1077ui_story and not isNil(var_67_4) then
					local var_67_8 = Mathf.Lerp(0, 0.5, var_67_7)

					arg_64_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1077ui_story.fillRatio = var_67_8
				end
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1077ui_story then
				local var_67_9 = 0.5

				arg_64_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1077ui_story.fillRatio = var_67_9
			end

			local var_67_10 = 0
			local var_67_11 = 0.725

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_12 = arg_64_1:FormatText(StoryNameCfg[1455].name)

				arg_64_1.leftNameTxt_.text = var_67_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_13 = arg_64_1:GetWordFromCfg(325091016)
				local var_67_14 = arg_64_1:FormatText(var_67_13.content)

				arg_64_1.text_.text = var_67_14

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_15 = 29
				local var_67_16 = utf8.len(var_67_14)
				local var_67_17 = var_67_15 <= 0 and var_67_11 or var_67_11 * (var_67_16 / var_67_15)

				if var_67_17 > 0 and var_67_11 < var_67_17 then
					arg_64_1.talkMaxDuration = var_67_17

					if var_67_17 + var_67_10 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_17 + var_67_10
					end
				end

				arg_64_1.text_.text = var_67_14
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091016", "story_v_out_325091.awb") ~= 0 then
					local var_67_18 = manager.audio:GetVoiceLength("story_v_out_325091", "325091016", "story_v_out_325091.awb") / 1000

					if var_67_18 + var_67_10 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_18 + var_67_10
					end

					if var_67_13.prefab_name ~= "" and arg_64_1.actors_[var_67_13.prefab_name] ~= nil then
						local var_67_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_13.prefab_name].transform, "story_v_out_325091", "325091016", "story_v_out_325091.awb")

						arg_64_1:RecordAudio("325091016", var_67_19)
						arg_64_1:RecordAudio("325091016", var_67_19)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_325091", "325091016", "story_v_out_325091.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_325091", "325091016", "story_v_out_325091.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_20 = math.max(var_67_11, arg_64_1.talkMaxDuration)

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_20 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_10) / var_67_20

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_10 + var_67_20 and arg_64_1.time_ < var_67_10 + var_67_20 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play325091017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 325091017
		arg_68_1.duration_ = 9.07

		local var_68_0 = {
			zh = 9.066,
			ja = 7.533
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
				arg_68_0:Play325091018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1077ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1077ui_story == nil then
				arg_68_1.var_.characterEffect1077ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.200000002980232

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect1077ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1077ui_story then
				arg_68_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_71_4 = 0
			local var_71_5 = 1.1

			if var_71_4 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_6 = arg_68_1:FormatText(StoryNameCfg[1467].name)

				arg_68_1.leftNameTxt_.text = var_71_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_7 = arg_68_1:GetWordFromCfg(325091017)
				local var_71_8 = arg_68_1:FormatText(var_71_7.content)

				arg_68_1.text_.text = var_71_8

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 44
				local var_71_10 = utf8.len(var_71_8)
				local var_71_11 = var_71_9 <= 0 and var_71_5 or var_71_5 * (var_71_10 / var_71_9)

				if var_71_11 > 0 and var_71_5 < var_71_11 then
					arg_68_1.talkMaxDuration = var_71_11

					if var_71_11 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_11 + var_71_4
					end
				end

				arg_68_1.text_.text = var_71_8
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091017", "story_v_out_325091.awb") ~= 0 then
					local var_71_12 = manager.audio:GetVoiceLength("story_v_out_325091", "325091017", "story_v_out_325091.awb") / 1000

					if var_71_12 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_12 + var_71_4
					end

					if var_71_7.prefab_name ~= "" and arg_68_1.actors_[var_71_7.prefab_name] ~= nil then
						local var_71_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_7.prefab_name].transform, "story_v_out_325091", "325091017", "story_v_out_325091.awb")

						arg_68_1:RecordAudio("325091017", var_71_13)
						arg_68_1:RecordAudio("325091017", var_71_13)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_325091", "325091017", "story_v_out_325091.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_325091", "325091017", "story_v_out_325091.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_14 = math.max(var_71_5, arg_68_1.talkMaxDuration)

			if var_71_4 <= arg_68_1.time_ and arg_68_1.time_ < var_71_4 + var_71_14 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_4) / var_71_14

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_4 + var_71_14 and arg_68_1.time_ < var_71_4 + var_71_14 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play325091018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 325091018
		arg_72_1.duration_ = 8.93

		local var_72_0 = {
			zh = 7.433,
			ja = 8.933
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
				arg_72_0:Play325091019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1077ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1077ui_story == nil then
				arg_72_1.var_.characterEffect1077ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.200000002980232

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1077ui_story and not isNil(var_75_0) then
					local var_75_4 = Mathf.Lerp(0, 0.5, var_75_3)

					arg_72_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1077ui_story.fillRatio = var_75_4
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1077ui_story then
				local var_75_5 = 0.5

				arg_72_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1077ui_story.fillRatio = var_75_5
			end

			local var_75_6 = 0
			local var_75_7 = 0.8

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_8 = arg_72_1:FormatText(StoryNameCfg[1455].name)

				arg_72_1.leftNameTxt_.text = var_75_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_9 = arg_72_1:GetWordFromCfg(325091018)
				local var_75_10 = arg_72_1:FormatText(var_75_9.content)

				arg_72_1.text_.text = var_75_10

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 32
				local var_75_12 = utf8.len(var_75_10)
				local var_75_13 = var_75_11 <= 0 and var_75_7 or var_75_7 * (var_75_12 / var_75_11)

				if var_75_13 > 0 and var_75_7 < var_75_13 then
					arg_72_1.talkMaxDuration = var_75_13

					if var_75_13 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_13 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_10
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091018", "story_v_out_325091.awb") ~= 0 then
					local var_75_14 = manager.audio:GetVoiceLength("story_v_out_325091", "325091018", "story_v_out_325091.awb") / 1000

					if var_75_14 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_14 + var_75_6
					end

					if var_75_9.prefab_name ~= "" and arg_72_1.actors_[var_75_9.prefab_name] ~= nil then
						local var_75_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_9.prefab_name].transform, "story_v_out_325091", "325091018", "story_v_out_325091.awb")

						arg_72_1:RecordAudio("325091018", var_75_15)
						arg_72_1:RecordAudio("325091018", var_75_15)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_325091", "325091018", "story_v_out_325091.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_325091", "325091018", "story_v_out_325091.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_16 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_16 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_6) / var_75_16

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_6 + var_75_16 and arg_72_1.time_ < var_75_6 + var_75_16 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play325091019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 325091019
		arg_76_1.duration_ = 4.1

		local var_76_0 = {
			zh = 1.999999999999,
			ja = 4.1
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
				arg_76_0:Play325091020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1077ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1077ui_story == nil then
				arg_76_1.var_.characterEffect1077ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect1077ui_story and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1077ui_story then
				arg_76_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_79_4 = 0

			if var_79_4 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_2")
			end

			local var_79_5 = 0

			if var_79_5 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 then
				arg_76_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_79_6 = 0
			local var_79_7 = 0.2

			if var_79_6 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_8 = arg_76_1:FormatText(StoryNameCfg[1467].name)

				arg_76_1.leftNameTxt_.text = var_79_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_9 = arg_76_1:GetWordFromCfg(325091019)
				local var_79_10 = arg_76_1:FormatText(var_79_9.content)

				arg_76_1.text_.text = var_79_10

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091019", "story_v_out_325091.awb") ~= 0 then
					local var_79_14 = manager.audio:GetVoiceLength("story_v_out_325091", "325091019", "story_v_out_325091.awb") / 1000

					if var_79_14 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_14 + var_79_6
					end

					if var_79_9.prefab_name ~= "" and arg_76_1.actors_[var_79_9.prefab_name] ~= nil then
						local var_79_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_9.prefab_name].transform, "story_v_out_325091", "325091019", "story_v_out_325091.awb")

						arg_76_1:RecordAudio("325091019", var_79_15)
						arg_76_1:RecordAudio("325091019", var_79_15)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_325091", "325091019", "story_v_out_325091.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_325091", "325091019", "story_v_out_325091.awb")
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
	Play325091020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 325091020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play325091021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1077ui_story"].transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos1077ui_story = var_83_0.localPosition

				local var_83_2 = GameObjectTools.GetOrAddComponent(var_83_0.gameObject, typeof(DynamicBoneHelper))

				if var_83_2 then
					var_83_2:EnableDynamicBone(false)
				end
			end

			local var_83_3 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_3 then
				local var_83_4 = (arg_80_1.time_ - var_83_1) / var_83_3
				local var_83_5 = Vector3.New(0, 100, 0)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1077ui_story, var_83_5, var_83_4)

				local var_83_6 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_6.x, var_83_6.y, var_83_6.z)

				local var_83_7 = var_83_0.localEulerAngles

				var_83_7.z = 0
				var_83_7.x = 0
				var_83_0.localEulerAngles = var_83_7
			end

			if arg_80_1.time_ >= var_83_1 + var_83_3 and arg_80_1.time_ < var_83_1 + var_83_3 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(0, 100, 0)

				local var_83_8 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_8.x, var_83_8.y, var_83_8.z)

				local var_83_9 = var_83_0.localEulerAngles

				var_83_9.z = 0
				var_83_9.x = 0
				var_83_0.localEulerAngles = var_83_9

				local var_83_10 = GameObjectTools.GetOrAddComponent(var_83_0.gameObject, typeof(DynamicBoneHelper))

				if var_83_10 then
					var_83_10:EnableDynamicBone(true)
				end
			end

			local var_83_11 = 0
			local var_83_12 = 1.3

			if var_83_11 < arg_80_1.time_ and arg_80_1.time_ <= var_83_11 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_13 = arg_80_1:GetWordFromCfg(325091020)
				local var_83_14 = arg_80_1:FormatText(var_83_13.content)

				arg_80_1.text_.text = var_83_14

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_15 = 52
				local var_83_16 = utf8.len(var_83_14)
				local var_83_17 = var_83_15 <= 0 and var_83_12 or var_83_12 * (var_83_16 / var_83_15)

				if var_83_17 > 0 and var_83_12 < var_83_17 then
					arg_80_1.talkMaxDuration = var_83_17

					if var_83_17 + var_83_11 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_17 + var_83_11
					end
				end

				arg_80_1.text_.text = var_83_14
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_18 = math.max(var_83_12, arg_80_1.talkMaxDuration)

			if var_83_11 <= arg_80_1.time_ and arg_80_1.time_ < var_83_11 + var_83_18 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_11) / var_83_18

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_11 + var_83_18 and arg_80_1.time_ < var_83_11 + var_83_18 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
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

		arg_80_1:InitPlayNodeList()
	end,
	Play325091021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 325091021
		arg_84_1.duration_ = 2.63

		local var_84_0 = {
			zh = 2.633,
			ja = 2.2
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
				arg_84_0:Play325091022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 0.2

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_2 = arg_84_1:FormatText(StoryNameCfg[1455].name)

				arg_84_1.leftNameTxt_.text = var_87_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_3 = arg_84_1:GetWordFromCfg(325091021)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 8
				local var_87_6 = utf8.len(var_87_4)
				local var_87_7 = var_87_5 <= 0 and var_87_1 or var_87_1 * (var_87_6 / var_87_5)

				if var_87_7 > 0 and var_87_1 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091021", "story_v_out_325091.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_325091", "325091021", "story_v_out_325091.awb") / 1000

					if var_87_8 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_0
					end

					if var_87_3.prefab_name ~= "" and arg_84_1.actors_[var_87_3.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_3.prefab_name].transform, "story_v_out_325091", "325091021", "story_v_out_325091.awb")

						arg_84_1:RecordAudio("325091021", var_87_9)
						arg_84_1:RecordAudio("325091021", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_325091", "325091021", "story_v_out_325091.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_325091", "325091021", "story_v_out_325091.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_10 and arg_84_1.time_ < var_87_0 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play325091022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 325091022
		arg_88_1.duration_ = 8.13

		local var_88_0 = {
			zh = 8.133,
			ja = 7.8
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
				arg_88_0:Play325091023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1077ui_story"].transform
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.var_.moveOldPos1077ui_story = var_91_0.localPosition

				local var_91_2 = GameObjectTools.GetOrAddComponent(var_91_0.gameObject, typeof(DynamicBoneHelper))

				if var_91_2 then
					var_91_2:EnableDynamicBone(false)
				end
			end

			local var_91_3 = 0.001

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_3 then
				local var_91_4 = (arg_88_1.time_ - var_91_1) / var_91_3
				local var_91_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_91_0.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1077ui_story, var_91_5, var_91_4)

				local var_91_6 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_6.x, var_91_6.y, var_91_6.z)

				local var_91_7 = var_91_0.localEulerAngles

				var_91_7.z = 0
				var_91_7.x = 0
				var_91_0.localEulerAngles = var_91_7
			end

			if arg_88_1.time_ >= var_91_1 + var_91_3 and arg_88_1.time_ < var_91_1 + var_91_3 + arg_91_0 then
				var_91_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_91_8 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_8.x, var_91_8.y, var_91_8.z)

				local var_91_9 = var_91_0.localEulerAngles

				var_91_9.z = 0
				var_91_9.x = 0
				var_91_0.localEulerAngles = var_91_9

				local var_91_10 = GameObjectTools.GetOrAddComponent(var_91_0.gameObject, typeof(DynamicBoneHelper))

				if var_91_10 then
					var_91_10:EnableDynamicBone(true)
				end
			end

			local var_91_11 = arg_88_1.actors_["1077ui_story"]
			local var_91_12 = 0

			if var_91_12 < arg_88_1.time_ and arg_88_1.time_ <= var_91_12 + arg_91_0 and not isNil(var_91_11) and arg_88_1.var_.characterEffect1077ui_story == nil then
				arg_88_1.var_.characterEffect1077ui_story = var_91_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_13 = 0.200000002980232

			if var_91_12 <= arg_88_1.time_ and arg_88_1.time_ < var_91_12 + var_91_13 and not isNil(var_91_11) then
				local var_91_14 = (arg_88_1.time_ - var_91_12) / var_91_13

				if arg_88_1.var_.characterEffect1077ui_story and not isNil(var_91_11) then
					arg_88_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_12 + var_91_13 and arg_88_1.time_ < var_91_12 + var_91_13 + arg_91_0 and not isNil(var_91_11) and arg_88_1.var_.characterEffect1077ui_story then
				arg_88_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_91_15 = 0
			local var_91_16 = 1

			if var_91_15 < arg_88_1.time_ and arg_88_1.time_ <= var_91_15 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_17 = arg_88_1:FormatText(StoryNameCfg[1467].name)

				arg_88_1.leftNameTxt_.text = var_91_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_18 = arg_88_1:GetWordFromCfg(325091022)
				local var_91_19 = arg_88_1:FormatText(var_91_18.content)

				arg_88_1.text_.text = var_91_19

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_20 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091022", "story_v_out_325091.awb") ~= 0 then
					local var_91_23 = manager.audio:GetVoiceLength("story_v_out_325091", "325091022", "story_v_out_325091.awb") / 1000

					if var_91_23 + var_91_15 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_23 + var_91_15
					end

					if var_91_18.prefab_name ~= "" and arg_88_1.actors_[var_91_18.prefab_name] ~= nil then
						local var_91_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_18.prefab_name].transform, "story_v_out_325091", "325091022", "story_v_out_325091.awb")

						arg_88_1:RecordAudio("325091022", var_91_24)
						arg_88_1:RecordAudio("325091022", var_91_24)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_325091", "325091022", "story_v_out_325091.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_325091", "325091022", "story_v_out_325091.awb")
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
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play325091023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 325091023
		arg_92_1.duration_ = 3.63

		local var_92_0 = {
			zh = 3.133,
			ja = 3.633
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
				arg_92_0:Play325091024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1077ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1077ui_story == nil then
				arg_92_1.var_.characterEffect1077ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1077ui_story and not isNil(var_95_0) then
					local var_95_4 = Mathf.Lerp(0, 0.5, var_95_3)

					arg_92_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1077ui_story.fillRatio = var_95_4
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1077ui_story then
				local var_95_5 = 0.5

				arg_92_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1077ui_story.fillRatio = var_95_5
			end

			local var_95_6 = 0
			local var_95_7 = 0.275

			if var_95_6 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_8 = arg_92_1:FormatText(StoryNameCfg[1455].name)

				arg_92_1.leftNameTxt_.text = var_95_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_9 = arg_92_1:GetWordFromCfg(325091023)
				local var_95_10 = arg_92_1:FormatText(var_95_9.content)

				arg_92_1.text_.text = var_95_10

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_11 = 11
				local var_95_12 = utf8.len(var_95_10)
				local var_95_13 = var_95_11 <= 0 and var_95_7 or var_95_7 * (var_95_12 / var_95_11)

				if var_95_13 > 0 and var_95_7 < var_95_13 then
					arg_92_1.talkMaxDuration = var_95_13

					if var_95_13 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_6
					end
				end

				arg_92_1.text_.text = var_95_10
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091023", "story_v_out_325091.awb") ~= 0 then
					local var_95_14 = manager.audio:GetVoiceLength("story_v_out_325091", "325091023", "story_v_out_325091.awb") / 1000

					if var_95_14 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_14 + var_95_6
					end

					if var_95_9.prefab_name ~= "" and arg_92_1.actors_[var_95_9.prefab_name] ~= nil then
						local var_95_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_9.prefab_name].transform, "story_v_out_325091", "325091023", "story_v_out_325091.awb")

						arg_92_1:RecordAudio("325091023", var_95_15)
						arg_92_1:RecordAudio("325091023", var_95_15)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_325091", "325091023", "story_v_out_325091.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_325091", "325091023", "story_v_out_325091.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_16 = math.max(var_95_7, arg_92_1.talkMaxDuration)

			if var_95_6 <= arg_92_1.time_ and arg_92_1.time_ < var_95_6 + var_95_16 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_6) / var_95_16

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_6 + var_95_16 and arg_92_1.time_ < var_95_6 + var_95_16 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play325091024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 325091024
		arg_96_1.duration_ = 7.17

		local var_96_0 = {
			zh = 5.466,
			ja = 7.166
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
				arg_96_0:Play325091025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1077ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1077ui_story == nil then
				arg_96_1.var_.characterEffect1077ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1077ui_story and not isNil(var_99_0) then
					arg_96_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1077ui_story then
				arg_96_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_99_4 = 0

			if var_99_4 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_99_5 = 0

			if var_99_5 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 then
				arg_96_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_99_6 = 0
			local var_99_7 = 0.6

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_8 = arg_96_1:FormatText(StoryNameCfg[1467].name)

				arg_96_1.leftNameTxt_.text = var_99_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_9 = arg_96_1:GetWordFromCfg(325091024)
				local var_99_10 = arg_96_1:FormatText(var_99_9.content)

				arg_96_1.text_.text = var_99_10

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_11 = 24
				local var_99_12 = utf8.len(var_99_10)
				local var_99_13 = var_99_11 <= 0 and var_99_7 or var_99_7 * (var_99_12 / var_99_11)

				if var_99_13 > 0 and var_99_7 < var_99_13 then
					arg_96_1.talkMaxDuration = var_99_13

					if var_99_13 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_13 + var_99_6
					end
				end

				arg_96_1.text_.text = var_99_10
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091024", "story_v_out_325091.awb") ~= 0 then
					local var_99_14 = manager.audio:GetVoiceLength("story_v_out_325091", "325091024", "story_v_out_325091.awb") / 1000

					if var_99_14 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_14 + var_99_6
					end

					if var_99_9.prefab_name ~= "" and arg_96_1.actors_[var_99_9.prefab_name] ~= nil then
						local var_99_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_9.prefab_name].transform, "story_v_out_325091", "325091024", "story_v_out_325091.awb")

						arg_96_1:RecordAudio("325091024", var_99_15)
						arg_96_1:RecordAudio("325091024", var_99_15)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_325091", "325091024", "story_v_out_325091.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_325091", "325091024", "story_v_out_325091.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_16 = math.max(var_99_7, arg_96_1.talkMaxDuration)

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_16 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_6) / var_99_16

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_6 + var_99_16 and arg_96_1.time_ < var_99_6 + var_99_16 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play325091025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 325091025
		arg_100_1.duration_ = 5.47

		local var_100_0 = {
			zh = 4.4,
			ja = 5.466
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
				arg_100_0:Play325091026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1077ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1077ui_story == nil then
				arg_100_1.var_.characterEffect1077ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1077ui_story and not isNil(var_103_0) then
					local var_103_4 = Mathf.Lerp(0, 0.5, var_103_3)

					arg_100_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1077ui_story.fillRatio = var_103_4
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1077ui_story then
				local var_103_5 = 0.5

				arg_100_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1077ui_story.fillRatio = var_103_5
			end

			local var_103_6 = 0
			local var_103_7 = 0.5

			if var_103_6 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_8 = arg_100_1:FormatText(StoryNameCfg[1455].name)

				arg_100_1.leftNameTxt_.text = var_103_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_9 = arg_100_1:GetWordFromCfg(325091025)
				local var_103_10 = arg_100_1:FormatText(var_103_9.content)

				arg_100_1.text_.text = var_103_10

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_11 = 20
				local var_103_12 = utf8.len(var_103_10)
				local var_103_13 = var_103_11 <= 0 and var_103_7 or var_103_7 * (var_103_12 / var_103_11)

				if var_103_13 > 0 and var_103_7 < var_103_13 then
					arg_100_1.talkMaxDuration = var_103_13

					if var_103_13 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_13 + var_103_6
					end
				end

				arg_100_1.text_.text = var_103_10
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091025", "story_v_out_325091.awb") ~= 0 then
					local var_103_14 = manager.audio:GetVoiceLength("story_v_out_325091", "325091025", "story_v_out_325091.awb") / 1000

					if var_103_14 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_14 + var_103_6
					end

					if var_103_9.prefab_name ~= "" and arg_100_1.actors_[var_103_9.prefab_name] ~= nil then
						local var_103_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_9.prefab_name].transform, "story_v_out_325091", "325091025", "story_v_out_325091.awb")

						arg_100_1:RecordAudio("325091025", var_103_15)
						arg_100_1:RecordAudio("325091025", var_103_15)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_325091", "325091025", "story_v_out_325091.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_325091", "325091025", "story_v_out_325091.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_16 = math.max(var_103_7, arg_100_1.talkMaxDuration)

			if var_103_6 <= arg_100_1.time_ and arg_100_1.time_ < var_103_6 + var_103_16 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_6) / var_103_16

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_6 + var_103_16 and arg_100_1.time_ < var_103_6 + var_103_16 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play325091026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 325091026
		arg_104_1.duration_ = 1.57

		local var_104_0 = {
			zh = 1.433,
			ja = 1.566
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
				arg_104_0:Play325091027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1077ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1077ui_story == nil then
				arg_104_1.var_.characterEffect1077ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.200000002980232

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect1077ui_story and not isNil(var_107_0) then
					arg_104_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1077ui_story then
				arg_104_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_107_4 = 0
			local var_107_5 = 0.125

			if var_107_4 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_6 = arg_104_1:FormatText(StoryNameCfg[1467].name)

				arg_104_1.leftNameTxt_.text = var_107_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_7 = arg_104_1:GetWordFromCfg(325091026)
				local var_107_8 = arg_104_1:FormatText(var_107_7.content)

				arg_104_1.text_.text = var_107_8

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_9 = 5
				local var_107_10 = utf8.len(var_107_8)
				local var_107_11 = var_107_9 <= 0 and var_107_5 or var_107_5 * (var_107_10 / var_107_9)

				if var_107_11 > 0 and var_107_5 < var_107_11 then
					arg_104_1.talkMaxDuration = var_107_11

					if var_107_11 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_11 + var_107_4
					end
				end

				arg_104_1.text_.text = var_107_8
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091026", "story_v_out_325091.awb") ~= 0 then
					local var_107_12 = manager.audio:GetVoiceLength("story_v_out_325091", "325091026", "story_v_out_325091.awb") / 1000

					if var_107_12 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_12 + var_107_4
					end

					if var_107_7.prefab_name ~= "" and arg_104_1.actors_[var_107_7.prefab_name] ~= nil then
						local var_107_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_7.prefab_name].transform, "story_v_out_325091", "325091026", "story_v_out_325091.awb")

						arg_104_1:RecordAudio("325091026", var_107_13)
						arg_104_1:RecordAudio("325091026", var_107_13)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_325091", "325091026", "story_v_out_325091.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_325091", "325091026", "story_v_out_325091.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_14 = math.max(var_107_5, arg_104_1.talkMaxDuration)

			if var_107_4 <= arg_104_1.time_ and arg_104_1.time_ < var_107_4 + var_107_14 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_4) / var_107_14

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_4 + var_107_14 and arg_104_1.time_ < var_107_4 + var_107_14 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play325091027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 325091027
		arg_108_1.duration_ = 7.4

		local var_108_0 = {
			zh = 5.566,
			ja = 7.4
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
				arg_108_0:Play325091028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1077ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1077ui_story == nil then
				arg_108_1.var_.characterEffect1077ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect1077ui_story and not isNil(var_111_0) then
					local var_111_4 = Mathf.Lerp(0, 0.5, var_111_3)

					arg_108_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1077ui_story.fillRatio = var_111_4
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1077ui_story then
				local var_111_5 = 0.5

				arg_108_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1077ui_story.fillRatio = var_111_5
			end

			local var_111_6 = 0
			local var_111_7 = 0.575

			if var_111_6 < arg_108_1.time_ and arg_108_1.time_ <= var_111_6 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_8 = arg_108_1:FormatText(StoryNameCfg[1455].name)

				arg_108_1.leftNameTxt_.text = var_111_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_9 = arg_108_1:GetWordFromCfg(325091027)
				local var_111_10 = arg_108_1:FormatText(var_111_9.content)

				arg_108_1.text_.text = var_111_10

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_11 = 23
				local var_111_12 = utf8.len(var_111_10)
				local var_111_13 = var_111_11 <= 0 and var_111_7 or var_111_7 * (var_111_12 / var_111_11)

				if var_111_13 > 0 and var_111_7 < var_111_13 then
					arg_108_1.talkMaxDuration = var_111_13

					if var_111_13 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_13 + var_111_6
					end
				end

				arg_108_1.text_.text = var_111_10
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091027", "story_v_out_325091.awb") ~= 0 then
					local var_111_14 = manager.audio:GetVoiceLength("story_v_out_325091", "325091027", "story_v_out_325091.awb") / 1000

					if var_111_14 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_14 + var_111_6
					end

					if var_111_9.prefab_name ~= "" and arg_108_1.actors_[var_111_9.prefab_name] ~= nil then
						local var_111_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_9.prefab_name].transform, "story_v_out_325091", "325091027", "story_v_out_325091.awb")

						arg_108_1:RecordAudio("325091027", var_111_15)
						arg_108_1:RecordAudio("325091027", var_111_15)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_325091", "325091027", "story_v_out_325091.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_325091", "325091027", "story_v_out_325091.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_16 = math.max(var_111_7, arg_108_1.talkMaxDuration)

			if var_111_6 <= arg_108_1.time_ and arg_108_1.time_ < var_111_6 + var_111_16 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_6) / var_111_16

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_6 + var_111_16 and arg_108_1.time_ < var_111_6 + var_111_16 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play325091028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 325091028
		arg_112_1.duration_ = 15.5

		local var_112_0 = {
			zh = 8.8,
			ja = 15.5
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
				arg_112_0:Play325091029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 1.175

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[1455].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_3 = arg_112_1:GetWordFromCfg(325091028)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 47
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

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091028", "story_v_out_325091.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_325091", "325091028", "story_v_out_325091.awb") / 1000

					if var_115_8 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_0
					end

					if var_115_3.prefab_name ~= "" and arg_112_1.actors_[var_115_3.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_3.prefab_name].transform, "story_v_out_325091", "325091028", "story_v_out_325091.awb")

						arg_112_1:RecordAudio("325091028", var_115_9)
						arg_112_1:RecordAudio("325091028", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_325091", "325091028", "story_v_out_325091.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_325091", "325091028", "story_v_out_325091.awb")
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
	Play325091029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 325091029
		arg_116_1.duration_ = 7.9

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play325091030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 1.53333333333333

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				local var_119_1 = manager.ui.mainCamera.transform.localPosition
				local var_119_2 = Vector3.New(0, 0, 10) + Vector3.New(var_119_1.x, var_119_1.y, 0)
				local var_119_3 = arg_116_1.bgs_.J29g

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
					if iter_119_0 ~= "J29g" then
						iter_119_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_119_14 = 1.53333333333333

			if var_119_14 < arg_116_1.time_ and arg_116_1.time_ <= var_119_14 + arg_119_0 then
				arg_116_1.allBtn_.enabled = false
			end

			local var_119_15 = 0.3

			if arg_116_1.time_ >= var_119_14 + var_119_15 and arg_116_1.time_ < var_119_14 + var_119_15 + arg_119_0 then
				arg_116_1.allBtn_.enabled = true
			end

			local var_119_16 = 0

			if var_119_16 < arg_116_1.time_ and arg_116_1.time_ <= var_119_16 + arg_119_0 then
				arg_116_1.mask_.enabled = true
				arg_116_1.mask_.raycastTarget = true

				arg_116_1:SetGaussion(false)
			end

			local var_119_17 = 1.53333333333333

			if var_119_16 <= arg_116_1.time_ and arg_116_1.time_ < var_119_16 + var_119_17 then
				local var_119_18 = (arg_116_1.time_ - var_119_16) / var_119_17
				local var_119_19 = Color.New(0, 0, 0)

				var_119_19.a = Mathf.Lerp(0, 1, var_119_18)
				arg_116_1.mask_.color = var_119_19
			end

			if arg_116_1.time_ >= var_119_16 + var_119_17 and arg_116_1.time_ < var_119_16 + var_119_17 + arg_119_0 then
				local var_119_20 = Color.New(0, 0, 0)

				var_119_20.a = 1
				arg_116_1.mask_.color = var_119_20
			end

			local var_119_21 = 1.53333333333333

			if var_119_21 < arg_116_1.time_ and arg_116_1.time_ <= var_119_21 + arg_119_0 then
				arg_116_1.mask_.enabled = true
				arg_116_1.mask_.raycastTarget = true

				arg_116_1:SetGaussion(false)
			end

			local var_119_22 = 2

			if var_119_21 <= arg_116_1.time_ and arg_116_1.time_ < var_119_21 + var_119_22 then
				local var_119_23 = (arg_116_1.time_ - var_119_21) / var_119_22
				local var_119_24 = Color.New(0, 0, 0)

				var_119_24.a = Mathf.Lerp(1, 0, var_119_23)
				arg_116_1.mask_.color = var_119_24
			end

			if arg_116_1.time_ >= var_119_21 + var_119_22 and arg_116_1.time_ < var_119_21 + var_119_22 + arg_119_0 then
				local var_119_25 = Color.New(0, 0, 0)
				local var_119_26 = 0

				arg_116_1.mask_.enabled = false
				var_119_25.a = var_119_26
				arg_116_1.mask_.color = var_119_25
			end

			local var_119_27 = arg_116_1.actors_["1077ui_story"].transform
			local var_119_28 = 1.53333333333333

			if var_119_28 < arg_116_1.time_ and arg_116_1.time_ <= var_119_28 + arg_119_0 then
				arg_116_1.var_.moveOldPos1077ui_story = var_119_27.localPosition

				local var_119_29 = GameObjectTools.GetOrAddComponent(var_119_27.gameObject, typeof(DynamicBoneHelper))

				if var_119_29 then
					var_119_29:EnableDynamicBone(false)
				end
			end

			local var_119_30 = 0.001

			if var_119_28 <= arg_116_1.time_ and arg_116_1.time_ < var_119_28 + var_119_30 then
				local var_119_31 = (arg_116_1.time_ - var_119_28) / var_119_30
				local var_119_32 = Vector3.New(0, 100, 0)

				var_119_27.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1077ui_story, var_119_32, var_119_31)

				local var_119_33 = manager.ui.mainCamera.transform.position - var_119_27.position

				var_119_27.forward = Vector3.New(var_119_33.x, var_119_33.y, var_119_33.z)

				local var_119_34 = var_119_27.localEulerAngles

				var_119_34.z = 0
				var_119_34.x = 0
				var_119_27.localEulerAngles = var_119_34
			end

			if arg_116_1.time_ >= var_119_28 + var_119_30 and arg_116_1.time_ < var_119_28 + var_119_30 + arg_119_0 then
				var_119_27.localPosition = Vector3.New(0, 100, 0)

				local var_119_35 = manager.ui.mainCamera.transform.position - var_119_27.position

				var_119_27.forward = Vector3.New(var_119_35.x, var_119_35.y, var_119_35.z)

				local var_119_36 = var_119_27.localEulerAngles

				var_119_36.z = 0
				var_119_36.x = 0
				var_119_27.localEulerAngles = var_119_36

				local var_119_37 = GameObjectTools.GetOrAddComponent(var_119_27.gameObject, typeof(DynamicBoneHelper))

				if var_119_37 then
					var_119_37:EnableDynamicBone(true)
				end
			end

			local var_119_38 = arg_116_1.actors_["1059ui_story"]
			local var_119_39 = 1.53333333333333

			if var_119_39 < arg_116_1.time_ and arg_116_1.time_ <= var_119_39 + arg_119_0 and not isNil(var_119_38) and arg_116_1.var_.characterEffect1059ui_story == nil then
				arg_116_1.var_.characterEffect1059ui_story = var_119_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_40 = 0.200000002980232

			if var_119_39 <= arg_116_1.time_ and arg_116_1.time_ < var_119_39 + var_119_40 and not isNil(var_119_38) then
				local var_119_41 = (arg_116_1.time_ - var_119_39) / var_119_40

				if arg_116_1.var_.characterEffect1059ui_story and not isNil(var_119_38) then
					local var_119_42 = Mathf.Lerp(0, 0.5, var_119_41)

					arg_116_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1059ui_story.fillRatio = var_119_42
				end
			end

			if arg_116_1.time_ >= var_119_39 + var_119_40 and arg_116_1.time_ < var_119_39 + var_119_40 + arg_119_0 and not isNil(var_119_38) and arg_116_1.var_.characterEffect1059ui_story then
				local var_119_43 = 0.5

				arg_116_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1059ui_story.fillRatio = var_119_43
			end

			if arg_116_1.frameCnt_ <= 1 then
				arg_116_1.dialog_:SetActive(false)
			end

			local var_119_44 = 2.9
			local var_119_45 = 0.925

			if var_119_44 < arg_116_1.time_ and arg_116_1.time_ <= var_119_44 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0

				arg_116_1.dialog_:SetActive(true)

				arg_116_1.dialogCg_.alpha = 0

				local var_119_46 = LeanTween.value(arg_116_1.dialog_, 0, 1, 0.3)

				var_119_46:setOnUpdate(LuaHelper.FloatAction(function(arg_120_0)
					arg_116_1.dialogCg_.alpha = arg_120_0
				end))
				var_119_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_116_1.dialog_)
					var_119_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_116_1.duration_ = arg_116_1.duration_ + 0.3

				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_47 = arg_116_1:GetWordFromCfg(325091029)
				local var_119_48 = arg_116_1:FormatText(var_119_47.content)

				arg_116_1.text_.text = var_119_48

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_49 = 37
				local var_119_50 = utf8.len(var_119_48)
				local var_119_51 = var_119_49 <= 0 and var_119_45 or var_119_45 * (var_119_50 / var_119_49)

				if var_119_51 > 0 and var_119_45 < var_119_51 then
					arg_116_1.talkMaxDuration = var_119_51
					var_119_44 = var_119_44 + 0.3

					if var_119_51 + var_119_44 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_51 + var_119_44
					end
				end

				arg_116_1.text_.text = var_119_48
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_52 = var_119_44 + 0.3
			local var_119_53 = math.max(var_119_45, arg_116_1.talkMaxDuration)

			if var_119_52 <= arg_116_1.time_ and arg_116_1.time_ < var_119_52 + var_119_53 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_52) / var_119_53

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_52 + var_119_53 and arg_116_1.time_ < var_119_52 + var_119_53 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.53333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play325091030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 325091030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play325091031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 0.85

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_2 = arg_122_1:GetWordFromCfg(325091030)
				local var_125_3 = arg_122_1:FormatText(var_125_2.content)

				arg_122_1.text_.text = var_125_3

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_4 = 34
				local var_125_5 = utf8.len(var_125_3)
				local var_125_6 = var_125_4 <= 0 and var_125_1 or var_125_1 * (var_125_5 / var_125_4)

				if var_125_6 > 0 and var_125_1 < var_125_6 then
					arg_122_1.talkMaxDuration = var_125_6

					if var_125_6 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_6 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_3
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_7 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_0 <= arg_122_1.time_ and arg_122_1.time_ < var_125_0 + var_125_7 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_0) / var_125_7

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_0 + var_125_7 and arg_122_1.time_ < var_125_0 + var_125_7 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play325091031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 325091031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play325091032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0
			local var_129_1 = 1.35

			if var_129_0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_2 = arg_126_1:GetWordFromCfg(325091031)
				local var_129_3 = arg_126_1:FormatText(var_129_2.content)

				arg_126_1.text_.text = var_129_3

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_4 = 54
				local var_129_5 = utf8.len(var_129_3)
				local var_129_6 = var_129_4 <= 0 and var_129_1 or var_129_1 * (var_129_5 / var_129_4)

				if var_129_6 > 0 and var_129_1 < var_129_6 then
					arg_126_1.talkMaxDuration = var_129_6

					if var_129_6 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_6 + var_129_0
					end
				end

				arg_126_1.text_.text = var_129_3
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_7 = math.max(var_129_1, arg_126_1.talkMaxDuration)

			if var_129_0 <= arg_126_1.time_ and arg_126_1.time_ < var_129_0 + var_129_7 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_0) / var_129_7

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_0 + var_129_7 and arg_126_1.time_ < var_129_0 + var_129_7 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play325091032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 325091032
		arg_130_1.duration_ = 2

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play325091033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["1077ui_story"].transform
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.var_.moveOldPos1077ui_story = var_133_0.localPosition

				local var_133_2 = GameObjectTools.GetOrAddComponent(var_133_0.gameObject, typeof(DynamicBoneHelper))

				if var_133_2 then
					var_133_2:EnableDynamicBone(false)
				end
			end

			local var_133_3 = 0.001

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_3 then
				local var_133_4 = (arg_130_1.time_ - var_133_1) / var_133_3
				local var_133_5 = Vector3.New(0, 100, 0)

				var_133_0.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1077ui_story, var_133_5, var_133_4)

				local var_133_6 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_6.x, var_133_6.y, var_133_6.z)

				local var_133_7 = var_133_0.localEulerAngles

				var_133_7.z = 0
				var_133_7.x = 0
				var_133_0.localEulerAngles = var_133_7
			end

			if arg_130_1.time_ >= var_133_1 + var_133_3 and arg_130_1.time_ < var_133_1 + var_133_3 + arg_133_0 then
				var_133_0.localPosition = Vector3.New(0, 100, 0)

				local var_133_8 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_8.x, var_133_8.y, var_133_8.z)

				local var_133_9 = var_133_0.localEulerAngles

				var_133_9.z = 0
				var_133_9.x = 0
				var_133_0.localEulerAngles = var_133_9

				local var_133_10 = GameObjectTools.GetOrAddComponent(var_133_0.gameObject, typeof(DynamicBoneHelper))

				if var_133_10 then
					var_133_10:EnableDynamicBone(true)
				end
			end

			local var_133_11 = arg_130_1.actors_["1077ui_story"]
			local var_133_12 = 0

			if var_133_12 < arg_130_1.time_ and arg_130_1.time_ <= var_133_12 + arg_133_0 and not isNil(var_133_11) and arg_130_1.var_.characterEffect1077ui_story == nil then
				arg_130_1.var_.characterEffect1077ui_story = var_133_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_13 = 0.200000002980232

			if var_133_12 <= arg_130_1.time_ and arg_130_1.time_ < var_133_12 + var_133_13 and not isNil(var_133_11) then
				local var_133_14 = (arg_130_1.time_ - var_133_12) / var_133_13

				if arg_130_1.var_.characterEffect1077ui_story and not isNil(var_133_11) then
					arg_130_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_12 + var_133_13 and arg_130_1.time_ < var_133_12 + var_133_13 + arg_133_0 and not isNil(var_133_11) and arg_130_1.var_.characterEffect1077ui_story then
				arg_130_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_133_15 = 0

			if var_133_15 < arg_130_1.time_ and arg_130_1.time_ <= var_133_15 + arg_133_0 then
				arg_130_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_1")
			end

			local var_133_16 = 0

			if var_133_16 < arg_130_1.time_ and arg_130_1.time_ <= var_133_16 + arg_133_0 then
				arg_130_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_133_17 = 0
			local var_133_18 = 0.2

			if var_133_17 < arg_130_1.time_ and arg_130_1.time_ <= var_133_17 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_19 = arg_130_1:FormatText(StoryNameCfg[1467].name)

				arg_130_1.leftNameTxt_.text = var_133_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_20 = arg_130_1:GetWordFromCfg(325091032)
				local var_133_21 = arg_130_1:FormatText(var_133_20.content)

				arg_130_1.text_.text = var_133_21

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_22 = 8
				local var_133_23 = utf8.len(var_133_21)
				local var_133_24 = var_133_22 <= 0 and var_133_18 or var_133_18 * (var_133_23 / var_133_22)

				if var_133_24 > 0 and var_133_18 < var_133_24 then
					arg_130_1.talkMaxDuration = var_133_24

					if var_133_24 + var_133_17 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_24 + var_133_17
					end
				end

				arg_130_1.text_.text = var_133_21
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091032", "story_v_out_325091.awb") ~= 0 then
					local var_133_25 = manager.audio:GetVoiceLength("story_v_out_325091", "325091032", "story_v_out_325091.awb") / 1000

					if var_133_25 + var_133_17 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_25 + var_133_17
					end

					if var_133_20.prefab_name ~= "" and arg_130_1.actors_[var_133_20.prefab_name] ~= nil then
						local var_133_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_20.prefab_name].transform, "story_v_out_325091", "325091032", "story_v_out_325091.awb")

						arg_130_1:RecordAudio("325091032", var_133_26)
						arg_130_1:RecordAudio("325091032", var_133_26)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_325091", "325091032", "story_v_out_325091.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_325091", "325091032", "story_v_out_325091.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_27 = math.max(var_133_18, arg_130_1.talkMaxDuration)

			if var_133_17 <= arg_130_1.time_ and arg_130_1.time_ < var_133_17 + var_133_27 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_17) / var_133_27

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_17 + var_133_27 and arg_130_1.time_ < var_133_17 + var_133_27 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
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

		arg_130_1:InitPlayNodeList()
	end,
	Play325091033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 325091033
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play325091034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1077ui_story"].transform
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.var_.moveOldPos1077ui_story = var_137_0.localPosition

				local var_137_2 = GameObjectTools.GetOrAddComponent(var_137_0.gameObject, typeof(DynamicBoneHelper))

				if var_137_2 then
					var_137_2:EnableDynamicBone(false)
				end
			end

			local var_137_3 = 0.001

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_3 then
				local var_137_4 = (arg_134_1.time_ - var_137_1) / var_137_3
				local var_137_5 = Vector3.New(0, 100, 0)

				var_137_0.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1077ui_story, var_137_5, var_137_4)

				local var_137_6 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_6.x, var_137_6.y, var_137_6.z)

				local var_137_7 = var_137_0.localEulerAngles

				var_137_7.z = 0
				var_137_7.x = 0
				var_137_0.localEulerAngles = var_137_7
			end

			if arg_134_1.time_ >= var_137_1 + var_137_3 and arg_134_1.time_ < var_137_1 + var_137_3 + arg_137_0 then
				var_137_0.localPosition = Vector3.New(0, 100, 0)

				local var_137_8 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_8.x, var_137_8.y, var_137_8.z)

				local var_137_9 = var_137_0.localEulerAngles

				var_137_9.z = 0
				var_137_9.x = 0
				var_137_0.localEulerAngles = var_137_9

				local var_137_10 = GameObjectTools.GetOrAddComponent(var_137_0.gameObject, typeof(DynamicBoneHelper))

				if var_137_10 then
					var_137_10:EnableDynamicBone(true)
				end
			end

			local var_137_11 = arg_134_1.actors_["1077ui_story"]
			local var_137_12 = 0

			if var_137_12 < arg_134_1.time_ and arg_134_1.time_ <= var_137_12 + arg_137_0 and not isNil(var_137_11) and arg_134_1.var_.characterEffect1077ui_story == nil then
				arg_134_1.var_.characterEffect1077ui_story = var_137_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_13 = 0.200000002980232

			if var_137_12 <= arg_134_1.time_ and arg_134_1.time_ < var_137_12 + var_137_13 and not isNil(var_137_11) then
				local var_137_14 = (arg_134_1.time_ - var_137_12) / var_137_13

				if arg_134_1.var_.characterEffect1077ui_story and not isNil(var_137_11) then
					local var_137_15 = Mathf.Lerp(0, 0.5, var_137_14)

					arg_134_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1077ui_story.fillRatio = var_137_15
				end
			end

			if arg_134_1.time_ >= var_137_12 + var_137_13 and arg_134_1.time_ < var_137_12 + var_137_13 + arg_137_0 and not isNil(var_137_11) and arg_134_1.var_.characterEffect1077ui_story then
				local var_137_16 = 0.5

				arg_134_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1077ui_story.fillRatio = var_137_16
			end

			local var_137_17 = 0.5
			local var_137_18 = 1

			if var_137_17 < arg_134_1.time_ and arg_134_1.time_ <= var_137_17 + arg_137_0 then
				local var_137_19 = "play"
				local var_137_20 = "effect"

				arg_134_1:AudioAction(var_137_19, var_137_20, "se_story_127", "se_story_127_dart", "")
			end

			local var_137_21 = 0
			local var_137_22 = 0.725

			if var_137_21 < arg_134_1.time_ and arg_134_1.time_ <= var_137_21 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_23 = arg_134_1:GetWordFromCfg(325091033)
				local var_137_24 = arg_134_1:FormatText(var_137_23.content)

				arg_134_1.text_.text = var_137_24

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_25 = 29
				local var_137_26 = utf8.len(var_137_24)
				local var_137_27 = var_137_25 <= 0 and var_137_22 or var_137_22 * (var_137_26 / var_137_25)

				if var_137_27 > 0 and var_137_22 < var_137_27 then
					arg_134_1.talkMaxDuration = var_137_27

					if var_137_27 + var_137_21 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_27 + var_137_21
					end
				end

				arg_134_1.text_.text = var_137_24
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_28 = math.max(var_137_22, arg_134_1.talkMaxDuration)

			if var_137_21 <= arg_134_1.time_ and arg_134_1.time_ < var_137_21 + var_137_28 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_21) / var_137_28

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_21 + var_137_28 and arg_134_1.time_ < var_137_21 + var_137_28 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
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

		arg_134_1:InitPlayNodeList()
	end,
	Play325091034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 325091034
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play325091035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0.5
			local var_141_1 = 1

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				local var_141_2 = "play"
				local var_141_3 = "effect"

				arg_138_1:AudioAction(var_141_2, var_141_3, "se_story_151", "se_story_151_dart_hit", "")
			end

			local var_141_4 = 0
			local var_141_5 = 1.3

			if var_141_4 < arg_138_1.time_ and arg_138_1.time_ <= var_141_4 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_6 = arg_138_1:GetWordFromCfg(325091034)
				local var_141_7 = arg_138_1:FormatText(var_141_6.content)

				arg_138_1.text_.text = var_141_7

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_8 = 52
				local var_141_9 = utf8.len(var_141_7)
				local var_141_10 = var_141_8 <= 0 and var_141_5 or var_141_5 * (var_141_9 / var_141_8)

				if var_141_10 > 0 and var_141_5 < var_141_10 then
					arg_138_1.talkMaxDuration = var_141_10

					if var_141_10 + var_141_4 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_10 + var_141_4
					end
				end

				arg_138_1.text_.text = var_141_7
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_11 = math.max(var_141_5, arg_138_1.talkMaxDuration)

			if var_141_4 <= arg_138_1.time_ and arg_138_1.time_ < var_141_4 + var_141_11 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_4) / var_141_11

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_4 + var_141_11 and arg_138_1.time_ < var_141_4 + var_141_11 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play325091035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 325091035
		arg_142_1.duration_ = 4.5

		local var_142_0 = {
			zh = 4.5,
			ja = 4.4
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play325091036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["1077ui_story"].transform
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.var_.moveOldPos1077ui_story = var_145_0.localPosition

				local var_145_2 = GameObjectTools.GetOrAddComponent(var_145_0.gameObject, typeof(DynamicBoneHelper))

				if var_145_2 then
					var_145_2:EnableDynamicBone(false)
				end
			end

			local var_145_3 = 0.001

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_3 then
				local var_145_4 = (arg_142_1.time_ - var_145_1) / var_145_3
				local var_145_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_145_0.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1077ui_story, var_145_5, var_145_4)

				local var_145_6 = manager.ui.mainCamera.transform.position - var_145_0.position

				var_145_0.forward = Vector3.New(var_145_6.x, var_145_6.y, var_145_6.z)

				local var_145_7 = var_145_0.localEulerAngles

				var_145_7.z = 0
				var_145_7.x = 0
				var_145_0.localEulerAngles = var_145_7
			end

			if arg_142_1.time_ >= var_145_1 + var_145_3 and arg_142_1.time_ < var_145_1 + var_145_3 + arg_145_0 then
				var_145_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_145_8 = manager.ui.mainCamera.transform.position - var_145_0.position

				var_145_0.forward = Vector3.New(var_145_8.x, var_145_8.y, var_145_8.z)

				local var_145_9 = var_145_0.localEulerAngles

				var_145_9.z = 0
				var_145_9.x = 0
				var_145_0.localEulerAngles = var_145_9

				local var_145_10 = GameObjectTools.GetOrAddComponent(var_145_0.gameObject, typeof(DynamicBoneHelper))

				if var_145_10 then
					var_145_10:EnableDynamicBone(true)
				end
			end

			local var_145_11 = arg_142_1.actors_["1077ui_story"]
			local var_145_12 = 0

			if var_145_12 < arg_142_1.time_ and arg_142_1.time_ <= var_145_12 + arg_145_0 and not isNil(var_145_11) and arg_142_1.var_.characterEffect1077ui_story == nil then
				arg_142_1.var_.characterEffect1077ui_story = var_145_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_13 = 0.200000002980232

			if var_145_12 <= arg_142_1.time_ and arg_142_1.time_ < var_145_12 + var_145_13 and not isNil(var_145_11) then
				local var_145_14 = (arg_142_1.time_ - var_145_12) / var_145_13

				if arg_142_1.var_.characterEffect1077ui_story and not isNil(var_145_11) then
					arg_142_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_12 + var_145_13 and arg_142_1.time_ < var_145_12 + var_145_13 + arg_145_0 and not isNil(var_145_11) and arg_142_1.var_.characterEffect1077ui_story then
				arg_142_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_145_15 = 0

			if var_145_15 < arg_142_1.time_ and arg_142_1.time_ <= var_145_15 + arg_145_0 then
				arg_142_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_1")
			end

			local var_145_16 = 0

			if var_145_16 < arg_142_1.time_ and arg_142_1.time_ <= var_145_16 + arg_145_0 then
				arg_142_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_145_17 = 0
			local var_145_18 = 0.55

			if var_145_17 < arg_142_1.time_ and arg_142_1.time_ <= var_145_17 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_19 = arg_142_1:FormatText(StoryNameCfg[1467].name)

				arg_142_1.leftNameTxt_.text = var_145_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_20 = arg_142_1:GetWordFromCfg(325091035)
				local var_145_21 = arg_142_1:FormatText(var_145_20.content)

				arg_142_1.text_.text = var_145_21

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_22 = 22
				local var_145_23 = utf8.len(var_145_21)
				local var_145_24 = var_145_22 <= 0 and var_145_18 or var_145_18 * (var_145_23 / var_145_22)

				if var_145_24 > 0 and var_145_18 < var_145_24 then
					arg_142_1.talkMaxDuration = var_145_24

					if var_145_24 + var_145_17 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_24 + var_145_17
					end
				end

				arg_142_1.text_.text = var_145_21
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091035", "story_v_out_325091.awb") ~= 0 then
					local var_145_25 = manager.audio:GetVoiceLength("story_v_out_325091", "325091035", "story_v_out_325091.awb") / 1000

					if var_145_25 + var_145_17 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_25 + var_145_17
					end

					if var_145_20.prefab_name ~= "" and arg_142_1.actors_[var_145_20.prefab_name] ~= nil then
						local var_145_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_20.prefab_name].transform, "story_v_out_325091", "325091035", "story_v_out_325091.awb")

						arg_142_1:RecordAudio("325091035", var_145_26)
						arg_142_1:RecordAudio("325091035", var_145_26)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_325091", "325091035", "story_v_out_325091.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_325091", "325091035", "story_v_out_325091.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_27 = math.max(var_145_18, arg_142_1.talkMaxDuration)

			if var_145_17 <= arg_142_1.time_ and arg_142_1.time_ < var_145_17 + var_145_27 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_17) / var_145_27

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_17 + var_145_27 and arg_142_1.time_ < var_145_17 + var_145_27 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
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

		arg_142_1:InitPlayNodeList()
	end,
	Play325091036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 325091036
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play325091037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1077ui_story"].transform
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.var_.moveOldPos1077ui_story = var_149_0.localPosition

				local var_149_2 = GameObjectTools.GetOrAddComponent(var_149_0.gameObject, typeof(DynamicBoneHelper))

				if var_149_2 then
					var_149_2:EnableDynamicBone(false)
				end
			end

			local var_149_3 = 0.001

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_3 then
				local var_149_4 = (arg_146_1.time_ - var_149_1) / var_149_3
				local var_149_5 = Vector3.New(0, 100, 0)

				var_149_0.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1077ui_story, var_149_5, var_149_4)

				local var_149_6 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_6.x, var_149_6.y, var_149_6.z)

				local var_149_7 = var_149_0.localEulerAngles

				var_149_7.z = 0
				var_149_7.x = 0
				var_149_0.localEulerAngles = var_149_7
			end

			if arg_146_1.time_ >= var_149_1 + var_149_3 and arg_146_1.time_ < var_149_1 + var_149_3 + arg_149_0 then
				var_149_0.localPosition = Vector3.New(0, 100, 0)

				local var_149_8 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_8.x, var_149_8.y, var_149_8.z)

				local var_149_9 = var_149_0.localEulerAngles

				var_149_9.z = 0
				var_149_9.x = 0
				var_149_0.localEulerAngles = var_149_9

				local var_149_10 = GameObjectTools.GetOrAddComponent(var_149_0.gameObject, typeof(DynamicBoneHelper))

				if var_149_10 then
					var_149_10:EnableDynamicBone(true)
				end
			end

			local var_149_11 = arg_146_1.actors_["1077ui_story"]
			local var_149_12 = 0

			if var_149_12 < arg_146_1.time_ and arg_146_1.time_ <= var_149_12 + arg_149_0 and not isNil(var_149_11) and arg_146_1.var_.characterEffect1077ui_story == nil then
				arg_146_1.var_.characterEffect1077ui_story = var_149_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_13 = 0.200000002980232

			if var_149_12 <= arg_146_1.time_ and arg_146_1.time_ < var_149_12 + var_149_13 and not isNil(var_149_11) then
				local var_149_14 = (arg_146_1.time_ - var_149_12) / var_149_13

				if arg_146_1.var_.characterEffect1077ui_story and not isNil(var_149_11) then
					local var_149_15 = Mathf.Lerp(0, 0.5, var_149_14)

					arg_146_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1077ui_story.fillRatio = var_149_15
				end
			end

			if arg_146_1.time_ >= var_149_12 + var_149_13 and arg_146_1.time_ < var_149_12 + var_149_13 + arg_149_0 and not isNil(var_149_11) and arg_146_1.var_.characterEffect1077ui_story then
				local var_149_16 = 0.5

				arg_146_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1077ui_story.fillRatio = var_149_16
			end

			local var_149_17 = 0.1
			local var_149_18 = 1

			if var_149_17 < arg_146_1.time_ and arg_146_1.time_ <= var_149_17 + arg_149_0 then
				local var_149_19 = "play"
				local var_149_20 = "effect"

				arg_146_1:AudioAction(var_149_19, var_149_20, "se_story_148", "se_story_148_monster_roll", "")
			end

			local var_149_21 = 0
			local var_149_22 = 0.975

			if var_149_21 < arg_146_1.time_ and arg_146_1.time_ <= var_149_21 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_23 = arg_146_1:GetWordFromCfg(325091036)
				local var_149_24 = arg_146_1:FormatText(var_149_23.content)

				arg_146_1.text_.text = var_149_24

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_25 = 39
				local var_149_26 = utf8.len(var_149_24)
				local var_149_27 = var_149_25 <= 0 and var_149_22 or var_149_22 * (var_149_26 / var_149_25)

				if var_149_27 > 0 and var_149_22 < var_149_27 then
					arg_146_1.talkMaxDuration = var_149_27

					if var_149_27 + var_149_21 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_27 + var_149_21
					end
				end

				arg_146_1.text_.text = var_149_24
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_28 = math.max(var_149_22, arg_146_1.talkMaxDuration)

			if var_149_21 <= arg_146_1.time_ and arg_146_1.time_ < var_149_21 + var_149_28 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_21) / var_149_28

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_21 + var_149_28 and arg_146_1.time_ < var_149_21 + var_149_28 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
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

		arg_146_1:InitPlayNodeList()
	end,
	Play325091037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 325091037
		arg_150_1.duration_ = 2.87

		local var_150_0 = {
			zh = 1.999999999999,
			ja = 2.866
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play325091038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["1077ui_story"].transform
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.var_.moveOldPos1077ui_story = var_153_0.localPosition

				local var_153_2 = GameObjectTools.GetOrAddComponent(var_153_0.gameObject, typeof(DynamicBoneHelper))

				if var_153_2 then
					var_153_2:EnableDynamicBone(false)
				end
			end

			local var_153_3 = 0.001

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_3 then
				local var_153_4 = (arg_150_1.time_ - var_153_1) / var_153_3
				local var_153_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_153_0.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1077ui_story, var_153_5, var_153_4)

				local var_153_6 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_6.x, var_153_6.y, var_153_6.z)

				local var_153_7 = var_153_0.localEulerAngles

				var_153_7.z = 0
				var_153_7.x = 0
				var_153_0.localEulerAngles = var_153_7
			end

			if arg_150_1.time_ >= var_153_1 + var_153_3 and arg_150_1.time_ < var_153_1 + var_153_3 + arg_153_0 then
				var_153_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_153_8 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_8.x, var_153_8.y, var_153_8.z)

				local var_153_9 = var_153_0.localEulerAngles

				var_153_9.z = 0
				var_153_9.x = 0
				var_153_0.localEulerAngles = var_153_9

				local var_153_10 = GameObjectTools.GetOrAddComponent(var_153_0.gameObject, typeof(DynamicBoneHelper))

				if var_153_10 then
					var_153_10:EnableDynamicBone(true)
				end
			end

			local var_153_11 = arg_150_1.actors_["1077ui_story"]
			local var_153_12 = 0

			if var_153_12 < arg_150_1.time_ and arg_150_1.time_ <= var_153_12 + arg_153_0 and not isNil(var_153_11) and arg_150_1.var_.characterEffect1077ui_story == nil then
				arg_150_1.var_.characterEffect1077ui_story = var_153_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_13 = 0.200000002980232

			if var_153_12 <= arg_150_1.time_ and arg_150_1.time_ < var_153_12 + var_153_13 and not isNil(var_153_11) then
				local var_153_14 = (arg_150_1.time_ - var_153_12) / var_153_13

				if arg_150_1.var_.characterEffect1077ui_story and not isNil(var_153_11) then
					arg_150_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= var_153_12 + var_153_13 and arg_150_1.time_ < var_153_12 + var_153_13 + arg_153_0 and not isNil(var_153_11) and arg_150_1.var_.characterEffect1077ui_story then
				arg_150_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_153_15 = 0

			if var_153_15 < arg_150_1.time_ and arg_150_1.time_ <= var_153_15 + arg_153_0 then
				arg_150_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_2")
			end

			local var_153_16 = 0

			if var_153_16 < arg_150_1.time_ and arg_150_1.time_ <= var_153_16 + arg_153_0 then
				arg_150_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_153_17 = 0
			local var_153_18 = 0.075

			if var_153_17 < arg_150_1.time_ and arg_150_1.time_ <= var_153_17 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_19 = arg_150_1:FormatText(StoryNameCfg[1467].name)

				arg_150_1.leftNameTxt_.text = var_153_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_20 = arg_150_1:GetWordFromCfg(325091037)
				local var_153_21 = arg_150_1:FormatText(var_153_20.content)

				arg_150_1.text_.text = var_153_21

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_22 = 3
				local var_153_23 = utf8.len(var_153_21)
				local var_153_24 = var_153_22 <= 0 and var_153_18 or var_153_18 * (var_153_23 / var_153_22)

				if var_153_24 > 0 and var_153_18 < var_153_24 then
					arg_150_1.talkMaxDuration = var_153_24

					if var_153_24 + var_153_17 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_24 + var_153_17
					end
				end

				arg_150_1.text_.text = var_153_21
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091037", "story_v_out_325091.awb") ~= 0 then
					local var_153_25 = manager.audio:GetVoiceLength("story_v_out_325091", "325091037", "story_v_out_325091.awb") / 1000

					if var_153_25 + var_153_17 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_25 + var_153_17
					end

					if var_153_20.prefab_name ~= "" and arg_150_1.actors_[var_153_20.prefab_name] ~= nil then
						local var_153_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_20.prefab_name].transform, "story_v_out_325091", "325091037", "story_v_out_325091.awb")

						arg_150_1:RecordAudio("325091037", var_153_26)
						arg_150_1:RecordAudio("325091037", var_153_26)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_325091", "325091037", "story_v_out_325091.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_325091", "325091037", "story_v_out_325091.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_27 = math.max(var_153_18, arg_150_1.talkMaxDuration)

			if var_153_17 <= arg_150_1.time_ and arg_150_1.time_ < var_153_17 + var_153_27 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_17) / var_153_27

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_17 + var_153_27 and arg_150_1.time_ < var_153_17 + var_153_27 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
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

		arg_150_1:InitPlayNodeList()
	end,
	Play325091038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 325091038
		arg_154_1.duration_ = 3.77

		local var_154_0 = {
			zh = 2.6,
			ja = 3.766
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
			arg_154_1.auto_ = false
		end

		function arg_154_1.playNext_(arg_156_0)
			arg_154_1.onStoryFinished_()
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1077ui_story"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1077ui_story == nil then
				arg_154_1.var_.characterEffect1077ui_story = var_157_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.200000002980232

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.characterEffect1077ui_story and not isNil(var_157_0) then
					local var_157_4 = Mathf.Lerp(0, 0.5, var_157_3)

					arg_154_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1077ui_story.fillRatio = var_157_4
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1077ui_story then
				local var_157_5 = 0.5

				arg_154_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1077ui_story.fillRatio = var_157_5
			end

			local var_157_6 = 0
			local var_157_7 = 1

			if var_157_6 < arg_154_1.time_ and arg_154_1.time_ <= var_157_6 + arg_157_0 then
				local var_157_8 = "play"
				local var_157_9 = "effect"

				arg_154_1:AudioAction(var_157_8, var_157_9, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_157_10 = 0
			local var_157_11 = 0.3

			if var_157_10 < arg_154_1.time_ and arg_154_1.time_ <= var_157_10 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_12 = arg_154_1:FormatText(StoryNameCfg[1455].name)

				arg_154_1.leftNameTxt_.text = var_157_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_13 = arg_154_1:GetWordFromCfg(325091038)
				local var_157_14 = arg_154_1:FormatText(var_157_13.content)

				arg_154_1.text_.text = var_157_14

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_15 = 12
				local var_157_16 = utf8.len(var_157_14)
				local var_157_17 = var_157_15 <= 0 and var_157_11 or var_157_11 * (var_157_16 / var_157_15)

				if var_157_17 > 0 and var_157_11 < var_157_17 then
					arg_154_1.talkMaxDuration = var_157_17

					if var_157_17 + var_157_10 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_17 + var_157_10
					end
				end

				arg_154_1.text_.text = var_157_14
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325091", "325091038", "story_v_out_325091.awb") ~= 0 then
					local var_157_18 = manager.audio:GetVoiceLength("story_v_out_325091", "325091038", "story_v_out_325091.awb") / 1000

					if var_157_18 + var_157_10 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_18 + var_157_10
					end

					if var_157_13.prefab_name ~= "" and arg_154_1.actors_[var_157_13.prefab_name] ~= nil then
						local var_157_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_13.prefab_name].transform, "story_v_out_325091", "325091038", "story_v_out_325091.awb")

						arg_154_1:RecordAudio("325091038", var_157_19)
						arg_154_1:RecordAudio("325091038", var_157_19)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_325091", "325091038", "story_v_out_325091.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_325091", "325091038", "story_v_out_325091.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_20 = math.max(var_157_11, arg_154_1.talkMaxDuration)

			if var_157_10 <= arg_154_1.time_ and arg_154_1.time_ < var_157_10 + var_157_20 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_10) / var_157_20

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_10 + var_157_20 and arg_154_1.time_ < var_157_10 + var_157_20 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J29g"
	},
	voices = {
		"story_v_out_325091.awb"
	}
}
