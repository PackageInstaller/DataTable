return {
	Play1108407001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1108407001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1108407002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B13"

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
				local var_4_5 = arg_1_1.bgs_.B13

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
					if iter_4_0 ~= "B13" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

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

			local var_4_24 = 1
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet.awb")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet")

				if var_4_29 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			local var_4_30 = 0
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "effect"

				arg_1_1:AudioAction(var_4_32, var_4_33, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_34 = 0.2
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "effect"

				arg_1_1:AudioAction(var_4_36, var_4_37, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 2
			local var_4_39 = 0.175

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

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_41 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_42 = arg_1_1:GetWordFromCfg(1108407001)
				local var_4_43 = arg_1_1:FormatText(var_4_42.content)

				arg_1_1.text_.text = var_4_43

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_44 = 7
				local var_4_45 = utf8.len(var_4_43)
				local var_4_46 = var_4_44 <= 0 and var_4_39 or var_4_39 * (var_4_45 / var_4_44)

				if var_4_46 > 0 and var_4_39 < var_4_46 then
					arg_1_1.talkMaxDuration = var_4_46
					var_4_38 = var_4_38 + 0.3

					if var_4_46 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_46 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_43
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_47 = var_4_38 + 0.3
			local var_4_48 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_47 <= arg_1_1.time_ and arg_1_1.time_ < var_4_47 + var_4_48 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_47) / var_4_48

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_47 + var_4_48 and arg_1_1.time_ < var_4_47 + var_4_48 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1108407002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1108407002
		arg_8_1.duration_ = 4.97

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1108407003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1084ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1084ui_story"].transform
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.var_.moveOldPos1084ui_story = var_11_5.localPosition
			end

			local var_11_7 = 0.001

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7
				local var_11_9 = Vector3.New(0, -0.97, -6)

				var_11_5.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1084ui_story, var_11_9, var_11_8)

				local var_11_10 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_10.x, var_11_10.y, var_11_10.z)

				local var_11_11 = var_11_5.localEulerAngles

				var_11_11.z = 0
				var_11_11.x = 0
				var_11_5.localEulerAngles = var_11_11
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 then
				var_11_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_11_12 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_12.x, var_11_12.y, var_11_12.z)

				local var_11_13 = var_11_5.localEulerAngles

				var_11_13.z = 0
				var_11_13.x = 0
				var_11_5.localEulerAngles = var_11_13
			end

			local var_11_14 = arg_8_1.actors_["1084ui_story"]
			local var_11_15 = 0

			if var_11_15 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 and not isNil(var_11_14) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_16 = 0.200000002980232

			if var_11_15 <= arg_8_1.time_ and arg_8_1.time_ < var_11_15 + var_11_16 and not isNil(var_11_14) then
				local var_11_17 = (arg_8_1.time_ - var_11_15) / var_11_16

				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_14) then
					arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_15 + var_11_16 and arg_8_1.time_ < var_11_15 + var_11_16 + arg_11_0 and not isNil(var_11_14) and arg_8_1.var_.characterEffect1084ui_story then
				arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_11_18 = 0

			if var_11_18 < arg_8_1.time_ and arg_8_1.time_ <= var_11_18 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_11_19 = 0

			if var_11_19 < arg_8_1.time_ and arg_8_1.time_ <= var_11_19 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_11_20 = 0
			local var_11_21 = 0.475

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_22 = arg_8_1:FormatText(StoryNameCfg[6].name)

				arg_8_1.leftNameTxt_.text = var_11_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_23 = arg_8_1:GetWordFromCfg(1108407002)
				local var_11_24 = arg_8_1:FormatText(var_11_23.content)

				arg_8_1.text_.text = var_11_24

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_25 = 19
				local var_11_26 = utf8.len(var_11_24)
				local var_11_27 = var_11_25 <= 0 and var_11_21 or var_11_21 * (var_11_26 / var_11_25)

				if var_11_27 > 0 and var_11_21 < var_11_27 then
					arg_8_1.talkMaxDuration = var_11_27

					if var_11_27 + var_11_20 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_27 + var_11_20
					end
				end

				arg_8_1.text_.text = var_11_24
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407002", "story_v_side_new_1108407.awb") ~= 0 then
					local var_11_28 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407002", "story_v_side_new_1108407.awb") / 1000

					if var_11_28 + var_11_20 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_28 + var_11_20
					end

					if var_11_23.prefab_name ~= "" and arg_8_1.actors_[var_11_23.prefab_name] ~= nil then
						local var_11_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_23.prefab_name].transform, "story_v_side_new_1108407", "1108407002", "story_v_side_new_1108407.awb")

						arg_8_1:RecordAudio("1108407002", var_11_29)
						arg_8_1:RecordAudio("1108407002", var_11_29)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407002", "story_v_side_new_1108407.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407002", "story_v_side_new_1108407.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_30 = math.max(var_11_21, arg_8_1.talkMaxDuration)

			if var_11_20 <= arg_8_1.time_ and arg_8_1.time_ < var_11_20 + var_11_30 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_20) / var_11_30

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_20 + var_11_30 and arg_8_1.time_ < var_11_20 + var_11_30 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play1108407003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1108407003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1108407004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1084ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.200000002980232

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1084ui_story.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1084ui_story then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1084ui_story.fillRatio = var_15_5
			end

			local var_15_6 = 0
			local var_15_7 = 0.3

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_8 = arg_12_1:FormatText(StoryNameCfg[7].name)

				arg_12_1.leftNameTxt_.text = var_15_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_9 = arg_12_1:GetWordFromCfg(1108407003)
				local var_15_10 = arg_12_1:FormatText(var_15_9.content)

				arg_12_1.text_.text = var_15_10

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 12
				local var_15_12 = utf8.len(var_15_10)
				local var_15_13 = var_15_11 <= 0 and var_15_7 or var_15_7 * (var_15_12 / var_15_11)

				if var_15_13 > 0 and var_15_7 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_10
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_14 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_14 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_14

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_14 and arg_12_1.time_ < var_15_6 + var_15_14 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play1108407004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1108407004
		arg_16_1.duration_ = 3.43

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1108407005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1084ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.200000002980232

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_0) then
					arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1084ui_story then
				arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_19_4 = 0

			if var_19_4 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_19_5 = 0

			if var_19_5 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_19_6 = 0
			local var_19_7 = 0.6

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_8 = arg_16_1:FormatText(StoryNameCfg[6].name)

				arg_16_1.leftNameTxt_.text = var_19_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_9 = arg_16_1:GetWordFromCfg(1108407004)
				local var_19_10 = arg_16_1:FormatText(var_19_9.content)

				arg_16_1.text_.text = var_19_10

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_11 = 24
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407004", "story_v_side_new_1108407.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407004", "story_v_side_new_1108407.awb") / 1000

					if var_19_14 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_6
					end

					if var_19_9.prefab_name ~= "" and arg_16_1.actors_[var_19_9.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_9.prefab_name].transform, "story_v_side_new_1108407", "1108407004", "story_v_side_new_1108407.awb")

						arg_16_1:RecordAudio("1108407004", var_19_15)
						arg_16_1:RecordAudio("1108407004", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407004", "story_v_side_new_1108407.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407004", "story_v_side_new_1108407.awb")
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
	Play1108407005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1108407005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play1108407006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1084ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1084ui_story == nil then
				arg_20_1.var_.characterEffect1084ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.200000002980232

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1084ui_story and not isNil(var_23_0) then
					local var_23_4 = Mathf.Lerp(0, 0.5, var_23_3)

					arg_20_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1084ui_story.fillRatio = var_23_4
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1084ui_story then
				local var_23_5 = 0.5

				arg_20_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1084ui_story.fillRatio = var_23_5
			end

			local var_23_6 = 0
			local var_23_7 = 0.9

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_8 = arg_20_1:FormatText(StoryNameCfg[7].name)

				arg_20_1.leftNameTxt_.text = var_23_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_9 = arg_20_1:GetWordFromCfg(1108407005)
				local var_23_10 = arg_20_1:FormatText(var_23_9.content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 36
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
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_14 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_14 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_14

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_14 and arg_20_1.time_ < var_23_6 + var_23_14 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play1108407006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 1108407006
		arg_24_1.duration_ = 9

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play1108407007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "STblack"

			if arg_24_1.bgs_[var_27_0] == nil then
				local var_27_1 = Object.Instantiate(arg_24_1.paintGo_)

				var_27_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_27_0)
				var_27_1.name = var_27_0
				var_27_1.transform.parent = arg_24_1.stage_.transform
				var_27_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.bgs_[var_27_0] = var_27_1
			end

			local var_27_2 = 2

			if var_27_2 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				local var_27_3 = manager.ui.mainCamera.transform.localPosition
				local var_27_4 = Vector3.New(0, 0, 10) + Vector3.New(var_27_3.x, var_27_3.y, 0)
				local var_27_5 = arg_24_1.bgs_.STblack

				var_27_5.transform.localPosition = var_27_4
				var_27_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_27_6 = var_27_5:GetComponent("SpriteRenderer")

				if var_27_6 and var_27_6.sprite then
					local var_27_7 = (var_27_5.transform.localPosition - var_27_3).z
					local var_27_8 = manager.ui.mainCameraCom_
					local var_27_9 = 2 * var_27_7 * Mathf.Tan(var_27_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_27_10 = var_27_9 * var_27_8.aspect
					local var_27_11 = var_27_6.sprite.bounds.size.x
					local var_27_12 = var_27_6.sprite.bounds.size.y
					local var_27_13 = var_27_10 / var_27_11
					local var_27_14 = var_27_9 / var_27_12
					local var_27_15 = var_27_14 < var_27_13 and var_27_13 or var_27_14

					var_27_5.transform.localScale = Vector3.New(var_27_15, var_27_15, 0)
				end

				for iter_27_0, iter_27_1 in pairs(arg_24_1.bgs_) do
					if iter_27_0 ~= "STblack" then
						iter_27_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_27_16 = 3.999999999999

			if var_27_16 < arg_24_1.time_ and arg_24_1.time_ <= var_27_16 + arg_27_0 then
				arg_24_1.allBtn_.enabled = false
			end

			local var_27_17 = 0.3

			if arg_24_1.time_ >= var_27_16 + var_27_17 and arg_24_1.time_ < var_27_16 + var_27_17 + arg_27_0 then
				arg_24_1.allBtn_.enabled = true
			end

			local var_27_18 = 0

			if var_27_18 < arg_24_1.time_ and arg_24_1.time_ <= var_27_18 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_19 = 2

			if var_27_18 <= arg_24_1.time_ and arg_24_1.time_ < var_27_18 + var_27_19 then
				local var_27_20 = (arg_24_1.time_ - var_27_18) / var_27_19
				local var_27_21 = Color.New(0, 0, 0)

				var_27_21.a = Mathf.Lerp(0, 1, var_27_20)
				arg_24_1.mask_.color = var_27_21
			end

			if arg_24_1.time_ >= var_27_18 + var_27_19 and arg_24_1.time_ < var_27_18 + var_27_19 + arg_27_0 then
				local var_27_22 = Color.New(0, 0, 0)

				var_27_22.a = 1
				arg_24_1.mask_.color = var_27_22
			end

			local var_27_23 = 2

			if var_27_23 < arg_24_1.time_ and arg_24_1.time_ <= var_27_23 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_24 = 2

			if var_27_23 <= arg_24_1.time_ and arg_24_1.time_ < var_27_23 + var_27_24 then
				local var_27_25 = (arg_24_1.time_ - var_27_23) / var_27_24
				local var_27_26 = Color.New(0, 0, 0)

				var_27_26.a = Mathf.Lerp(1, 0, var_27_25)
				arg_24_1.mask_.color = var_27_26
			end

			if arg_24_1.time_ >= var_27_23 + var_27_24 and arg_24_1.time_ < var_27_23 + var_27_24 + arg_27_0 then
				local var_27_27 = Color.New(0, 0, 0)
				local var_27_28 = 0

				arg_24_1.mask_.enabled = false
				var_27_27.a = var_27_28
				arg_24_1.mask_.color = var_27_27
			end

			local var_27_29 = arg_24_1.actors_["1084ui_story"].transform
			local var_27_30 = 1.96599999815226

			if var_27_30 < arg_24_1.time_ and arg_24_1.time_ <= var_27_30 + arg_27_0 then
				arg_24_1.var_.moveOldPos1084ui_story = var_27_29.localPosition
			end

			local var_27_31 = 0.001

			if var_27_30 <= arg_24_1.time_ and arg_24_1.time_ < var_27_30 + var_27_31 then
				local var_27_32 = (arg_24_1.time_ - var_27_30) / var_27_31
				local var_27_33 = Vector3.New(0, 100, 0)

				var_27_29.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1084ui_story, var_27_33, var_27_32)

				local var_27_34 = manager.ui.mainCamera.transform.position - var_27_29.position

				var_27_29.forward = Vector3.New(var_27_34.x, var_27_34.y, var_27_34.z)

				local var_27_35 = var_27_29.localEulerAngles

				var_27_35.z = 0
				var_27_35.x = 0
				var_27_29.localEulerAngles = var_27_35
			end

			if arg_24_1.time_ >= var_27_30 + var_27_31 and arg_24_1.time_ < var_27_30 + var_27_31 + arg_27_0 then
				var_27_29.localPosition = Vector3.New(0, 100, 0)

				local var_27_36 = manager.ui.mainCamera.transform.position - var_27_29.position

				var_27_29.forward = Vector3.New(var_27_36.x, var_27_36.y, var_27_36.z)

				local var_27_37 = var_27_29.localEulerAngles

				var_27_37.z = 0
				var_27_37.x = 0
				var_27_29.localEulerAngles = var_27_37
			end

			if arg_24_1.frameCnt_ <= 1 then
				arg_24_1.dialog_:SetActive(false)
			end

			local var_27_38 = 3.999999999999
			local var_27_39 = 1.75

			if var_27_38 < arg_24_1.time_ and arg_24_1.time_ <= var_27_38 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				arg_24_1.dialog_:SetActive(true)

				arg_24_1.dialogCg_.alpha = 0

				local var_27_40 = LeanTween.value(arg_24_1.dialog_, 0, 1, 0.3)

				var_27_40:setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
					arg_24_1.dialogCg_.alpha = arg_28_0
				end))
				var_27_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_24_1.dialog_)
					var_27_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_24_1.duration_ = arg_24_1.duration_ + 0.3

				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_41 = arg_24_1:GetWordFromCfg(1108407006)
				local var_27_42 = arg_24_1:FormatText(var_27_41.content)

				arg_24_1.text_.text = var_27_42

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_43 = 70
				local var_27_44 = utf8.len(var_27_42)
				local var_27_45 = var_27_43 <= 0 and var_27_39 or var_27_39 * (var_27_44 / var_27_43)

				if var_27_45 > 0 and var_27_39 < var_27_45 then
					arg_24_1.talkMaxDuration = var_27_45
					var_27_38 = var_27_38 + 0.3

					if var_27_45 + var_27_38 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_45 + var_27_38
					end
				end

				arg_24_1.text_.text = var_27_42
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_46 = var_27_38 + 0.3
			local var_27_47 = math.max(var_27_39, arg_24_1.talkMaxDuration)

			if var_27_46 <= arg_24_1.time_ and arg_24_1.time_ < var_27_46 + var_27_47 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_46) / var_27_47

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_46 + var_27_47 and arg_24_1.time_ < var_27_46 + var_27_47 + arg_27_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play1108407007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 1108407007
		arg_30_1.duration_ = 7

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play1108407008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = "H05"

			if arg_30_1.bgs_[var_33_0] == nil then
				local var_33_1 = Object.Instantiate(arg_30_1.paintGo_)

				var_33_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_33_0)
				var_33_1.name = var_33_0
				var_33_1.transform.parent = arg_30_1.stage_.transform
				var_33_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_30_1.bgs_[var_33_0] = var_33_1
			end

			local var_33_2 = 0

			if var_33_2 < arg_30_1.time_ and arg_30_1.time_ <= var_33_2 + arg_33_0 then
				local var_33_3 = manager.ui.mainCamera.transform.localPosition
				local var_33_4 = Vector3.New(0, 0, 10) + Vector3.New(var_33_3.x, var_33_3.y, 0)
				local var_33_5 = arg_30_1.bgs_.H05

				var_33_5.transform.localPosition = var_33_4
				var_33_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_33_6 = var_33_5:GetComponent("SpriteRenderer")

				if var_33_6 and var_33_6.sprite then
					local var_33_7 = (var_33_5.transform.localPosition - var_33_3).z
					local var_33_8 = manager.ui.mainCameraCom_
					local var_33_9 = 2 * var_33_7 * Mathf.Tan(var_33_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_33_10 = var_33_9 * var_33_8.aspect
					local var_33_11 = var_33_6.sprite.bounds.size.x
					local var_33_12 = var_33_6.sprite.bounds.size.y
					local var_33_13 = var_33_10 / var_33_11
					local var_33_14 = var_33_9 / var_33_12
					local var_33_15 = var_33_14 < var_33_13 and var_33_13 or var_33_14

					var_33_5.transform.localScale = Vector3.New(var_33_15, var_33_15, 0)
				end

				for iter_33_0, iter_33_1 in pairs(arg_30_1.bgs_) do
					if iter_33_0 ~= "H05" then
						iter_33_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_33_16 = 2

			if var_33_16 < arg_30_1.time_ and arg_30_1.time_ <= var_33_16 + arg_33_0 then
				arg_30_1.allBtn_.enabled = false
			end

			local var_33_17 = 0.3

			if arg_30_1.time_ >= var_33_16 + var_33_17 and arg_30_1.time_ < var_33_16 + var_33_17 + arg_33_0 then
				arg_30_1.allBtn_.enabled = true
			end

			local var_33_18 = 0

			if var_33_18 < arg_30_1.time_ and arg_30_1.time_ <= var_33_18 + arg_33_0 then
				arg_30_1.mask_.enabled = true
				arg_30_1.mask_.raycastTarget = true

				arg_30_1:SetGaussion(false)
			end

			local var_33_19 = 2

			if var_33_18 <= arg_30_1.time_ and arg_30_1.time_ < var_33_18 + var_33_19 then
				local var_33_20 = (arg_30_1.time_ - var_33_18) / var_33_19
				local var_33_21 = Color.New(0, 0, 0)

				var_33_21.a = Mathf.Lerp(1, 0, var_33_20)
				arg_30_1.mask_.color = var_33_21
			end

			if arg_30_1.time_ >= var_33_18 + var_33_19 and arg_30_1.time_ < var_33_18 + var_33_19 + arg_33_0 then
				local var_33_22 = Color.New(0, 0, 0)
				local var_33_23 = 0

				arg_30_1.mask_.enabled = false
				var_33_22.a = var_33_23
				arg_30_1.mask_.color = var_33_22
			end

			local var_33_24 = 1.2
			local var_33_25 = 1

			if var_33_24 < arg_30_1.time_ and arg_30_1.time_ <= var_33_24 + arg_33_0 then
				local var_33_26 = "play"
				local var_33_27 = "effect"

				arg_30_1:AudioAction(var_33_26, var_33_27, "se_story_133", "se_story_133_sea", "")
			end

			local var_33_28 = 0.2
			local var_33_29 = 1

			if var_33_28 < arg_30_1.time_ and arg_30_1.time_ <= var_33_28 + arg_33_0 then
				local var_33_30 = "stop"
				local var_33_31 = "effect"

				arg_30_1:AudioAction(var_33_30, var_33_31, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_30_1.frameCnt_ <= 1 then
				arg_30_1.dialog_:SetActive(false)
			end

			local var_33_32 = 2
			local var_33_33 = 1.25

			if var_33_32 < arg_30_1.time_ and arg_30_1.time_ <= var_33_32 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				arg_30_1.dialog_:SetActive(true)

				arg_30_1.dialogCg_.alpha = 0

				local var_33_34 = LeanTween.value(arg_30_1.dialog_, 0, 1, 0.3)

				var_33_34:setOnUpdate(LuaHelper.FloatAction(function(arg_34_0)
					arg_30_1.dialogCg_.alpha = arg_34_0
				end))
				var_33_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_30_1.dialog_)
					var_33_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_30_1.duration_ = arg_30_1.duration_ + 0.3

				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_35 = arg_30_1:GetWordFromCfg(1108407007)
				local var_33_36 = arg_30_1:FormatText(var_33_35.content)

				arg_30_1.text_.text = var_33_36

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_37 = 50
				local var_33_38 = utf8.len(var_33_36)
				local var_33_39 = var_33_37 <= 0 and var_33_33 or var_33_33 * (var_33_38 / var_33_37)

				if var_33_39 > 0 and var_33_33 < var_33_39 then
					arg_30_1.talkMaxDuration = var_33_39
					var_33_32 = var_33_32 + 0.3

					if var_33_39 + var_33_32 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_39 + var_33_32
					end
				end

				arg_30_1.text_.text = var_33_36
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_40 = var_33_32 + 0.3
			local var_33_41 = math.max(var_33_33, arg_30_1.talkMaxDuration)

			if var_33_40 <= arg_30_1.time_ and arg_30_1.time_ < var_33_40 + var_33_41 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_40) / var_33_41

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_40 + var_33_41 and arg_30_1.time_ < var_33_40 + var_33_41 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play1108407008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1108407008
		arg_36_1.duration_ = 6.57

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play1108407009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1084ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos1084ui_story = var_39_0.localPosition
			end

			local var_39_2 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2
				local var_39_4 = Vector3.New(0, -0.97, -6)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1084ui_story, var_39_4, var_39_3)

				local var_39_5 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_5.x, var_39_5.y, var_39_5.z)

				local var_39_6 = var_39_0.localEulerAngles

				var_39_6.z = 0
				var_39_6.x = 0
				var_39_0.localEulerAngles = var_39_6
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_39_7 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_7.x, var_39_7.y, var_39_7.z)

				local var_39_8 = var_39_0.localEulerAngles

				var_39_8.z = 0
				var_39_8.x = 0
				var_39_0.localEulerAngles = var_39_8
			end

			local var_39_9 = arg_36_1.actors_["1084ui_story"]
			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 and not isNil(var_39_9) and arg_36_1.var_.characterEffect1084ui_story == nil then
				arg_36_1.var_.characterEffect1084ui_story = var_39_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_11 = 0.200000002980232

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_11 and not isNil(var_39_9) then
				local var_39_12 = (arg_36_1.time_ - var_39_10) / var_39_11

				if arg_36_1.var_.characterEffect1084ui_story and not isNil(var_39_9) then
					arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_10 + var_39_11 and arg_36_1.time_ < var_39_10 + var_39_11 + arg_39_0 and not isNil(var_39_9) and arg_36_1.var_.characterEffect1084ui_story then
				arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_39_13 = 0

			if var_39_13 < arg_36_1.time_ and arg_36_1.time_ <= var_39_13 + arg_39_0 then
				arg_36_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_39_14 = 0

			if var_39_14 < arg_36_1.time_ and arg_36_1.time_ <= var_39_14 + arg_39_0 then
				arg_36_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_39_15 = 0
			local var_39_16 = 0.675

			if var_39_15 < arg_36_1.time_ and arg_36_1.time_ <= var_39_15 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_17 = arg_36_1:FormatText(StoryNameCfg[6].name)

				arg_36_1.leftNameTxt_.text = var_39_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_18 = arg_36_1:GetWordFromCfg(1108407008)
				local var_39_19 = arg_36_1:FormatText(var_39_18.content)

				arg_36_1.text_.text = var_39_19

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_20 = 27
				local var_39_21 = utf8.len(var_39_19)
				local var_39_22 = var_39_20 <= 0 and var_39_16 or var_39_16 * (var_39_21 / var_39_20)

				if var_39_22 > 0 and var_39_16 < var_39_22 then
					arg_36_1.talkMaxDuration = var_39_22

					if var_39_22 + var_39_15 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_22 + var_39_15
					end
				end

				arg_36_1.text_.text = var_39_19
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407008", "story_v_side_new_1108407.awb") ~= 0 then
					local var_39_23 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407008", "story_v_side_new_1108407.awb") / 1000

					if var_39_23 + var_39_15 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_23 + var_39_15
					end

					if var_39_18.prefab_name ~= "" and arg_36_1.actors_[var_39_18.prefab_name] ~= nil then
						local var_39_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_18.prefab_name].transform, "story_v_side_new_1108407", "1108407008", "story_v_side_new_1108407.awb")

						arg_36_1:RecordAudio("1108407008", var_39_24)
						arg_36_1:RecordAudio("1108407008", var_39_24)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407008", "story_v_side_new_1108407.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407008", "story_v_side_new_1108407.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_25 = math.max(var_39_16, arg_36_1.talkMaxDuration)

			if var_39_15 <= arg_36_1.time_ and arg_36_1.time_ < var_39_15 + var_39_25 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_15) / var_39_25

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_15 + var_39_25 and arg_36_1.time_ < var_39_15 + var_39_25 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play1108407009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1108407009
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play1108407010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1084ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1084ui_story and not isNil(var_43_0) then
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1084ui_story.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1084ui_story then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1084ui_story.fillRatio = var_43_5
			end

			local var_43_6 = 0
			local var_43_7 = 0.675

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_8 = arg_40_1:FormatText(StoryNameCfg[7].name)

				arg_40_1.leftNameTxt_.text = var_43_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_9 = arg_40_1:GetWordFromCfg(1108407009)
				local var_43_10 = arg_40_1:FormatText(var_43_9.content)

				arg_40_1.text_.text = var_43_10

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_11 = 27
				local var_43_12 = utf8.len(var_43_10)
				local var_43_13 = var_43_11 <= 0 and var_43_7 or var_43_7 * (var_43_12 / var_43_11)

				if var_43_13 > 0 and var_43_7 < var_43_13 then
					arg_40_1.talkMaxDuration = var_43_13

					if var_43_13 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_13 + var_43_6
					end
				end

				arg_40_1.text_.text = var_43_10
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_14 = math.max(var_43_7, arg_40_1.talkMaxDuration)

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_14 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_6) / var_43_14

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_6 + var_43_14 and arg_40_1.time_ < var_43_6 + var_43_14 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play1108407010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 1108407010
		arg_44_1.duration_ = 5.43

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play1108407011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1084ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos1084ui_story = var_47_0.localPosition
			end

			local var_47_2 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2
				local var_47_4 = Vector3.New(0, -0.97, -6)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1084ui_story, var_47_4, var_47_3)

				local var_47_5 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_5.x, var_47_5.y, var_47_5.z)

				local var_47_6 = var_47_0.localEulerAngles

				var_47_6.z = 0
				var_47_6.x = 0
				var_47_0.localEulerAngles = var_47_6
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_47_7 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_7.x, var_47_7.y, var_47_7.z)

				local var_47_8 = var_47_0.localEulerAngles

				var_47_8.z = 0
				var_47_8.x = 0
				var_47_0.localEulerAngles = var_47_8
			end

			local var_47_9 = arg_44_1.actors_["1084ui_story"]
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = var_47_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.200000002980232

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 and not isNil(var_47_9) then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11

				if arg_44_1.var_.characterEffect1084ui_story and not isNil(var_47_9) then
					arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_10 + var_47_11 and arg_44_1.time_ < var_47_10 + var_47_11 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1084ui_story then
				arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_47_13 = 0

			if var_47_13 < arg_44_1.time_ and arg_44_1.time_ <= var_47_13 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_47_14 = 0

			if var_47_14 < arg_44_1.time_ and arg_44_1.time_ <= var_47_14 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_47_15 = 0
			local var_47_16 = 0.95

			if var_47_15 < arg_44_1.time_ and arg_44_1.time_ <= var_47_15 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_17 = arg_44_1:FormatText(StoryNameCfg[6].name)

				arg_44_1.leftNameTxt_.text = var_47_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_18 = arg_44_1:GetWordFromCfg(1108407010)
				local var_47_19 = arg_44_1:FormatText(var_47_18.content)

				arg_44_1.text_.text = var_47_19

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_20 = 38
				local var_47_21 = utf8.len(var_47_19)
				local var_47_22 = var_47_20 <= 0 and var_47_16 or var_47_16 * (var_47_21 / var_47_20)

				if var_47_22 > 0 and var_47_16 < var_47_22 then
					arg_44_1.talkMaxDuration = var_47_22

					if var_47_22 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_22 + var_47_15
					end
				end

				arg_44_1.text_.text = var_47_19
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407010", "story_v_side_new_1108407.awb") ~= 0 then
					local var_47_23 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407010", "story_v_side_new_1108407.awb") / 1000

					if var_47_23 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_23 + var_47_15
					end

					if var_47_18.prefab_name ~= "" and arg_44_1.actors_[var_47_18.prefab_name] ~= nil then
						local var_47_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_18.prefab_name].transform, "story_v_side_new_1108407", "1108407010", "story_v_side_new_1108407.awb")

						arg_44_1:RecordAudio("1108407010", var_47_24)
						arg_44_1:RecordAudio("1108407010", var_47_24)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407010", "story_v_side_new_1108407.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407010", "story_v_side_new_1108407.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_25 = math.max(var_47_16, arg_44_1.talkMaxDuration)

			if var_47_15 <= arg_44_1.time_ and arg_44_1.time_ < var_47_15 + var_47_25 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_15) / var_47_25

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_15 + var_47_25 and arg_44_1.time_ < var_47_15 + var_47_25 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play1108407011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1108407011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play1108407012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1084ui_story"].transform
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.var_.moveOldPos1084ui_story = var_51_0.localPosition
			end

			local var_51_2 = 0.001

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2
				local var_51_4 = Vector3.New(0, 100, 0)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1084ui_story, var_51_4, var_51_3)

				local var_51_5 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_5.x, var_51_5.y, var_51_5.z)

				local var_51_6 = var_51_0.localEulerAngles

				var_51_6.z = 0
				var_51_6.x = 0
				var_51_0.localEulerAngles = var_51_6
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 then
				var_51_0.localPosition = Vector3.New(0, 100, 0)

				local var_51_7 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_7.x, var_51_7.y, var_51_7.z)

				local var_51_8 = var_51_0.localEulerAngles

				var_51_8.z = 0
				var_51_8.x = 0
				var_51_0.localEulerAngles = var_51_8
			end

			local var_51_9 = arg_48_1.actors_["1084ui_story"]
			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_11 = 0.200000002980232

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_11 and not isNil(var_51_9) then
				local var_51_12 = (arg_48_1.time_ - var_51_10) / var_51_11

				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_9) then
					local var_51_13 = Mathf.Lerp(0, 0.5, var_51_12)

					arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1084ui_story.fillRatio = var_51_13
				end
			end

			if arg_48_1.time_ >= var_51_10 + var_51_11 and arg_48_1.time_ < var_51_10 + var_51_11 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect1084ui_story then
				local var_51_14 = 0.5

				arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1084ui_story.fillRatio = var_51_14
			end

			local var_51_15 = 0
			local var_51_16 = 1.475

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_17 = arg_48_1:GetWordFromCfg(1108407011)
				local var_51_18 = arg_48_1:FormatText(var_51_17.content)

				arg_48_1.text_.text = var_51_18

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_19 = 59
				local var_51_20 = utf8.len(var_51_18)
				local var_51_21 = var_51_19 <= 0 and var_51_16 or var_51_16 * (var_51_20 / var_51_19)

				if var_51_21 > 0 and var_51_16 < var_51_21 then
					arg_48_1.talkMaxDuration = var_51_21

					if var_51_21 + var_51_15 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_21 + var_51_15
					end
				end

				arg_48_1.text_.text = var_51_18
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_22 = math.max(var_51_16, arg_48_1.talkMaxDuration)

			if var_51_15 <= arg_48_1.time_ and arg_48_1.time_ < var_51_15 + var_51_22 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_15) / var_51_22

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_15 + var_51_22 and arg_48_1.time_ < var_51_15 + var_51_22 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play1108407012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1108407012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play1108407013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.85

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[7].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:GetWordFromCfg(1108407012)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 34
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
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_8 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_8 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_8

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_8 and arg_52_1.time_ < var_55_0 + var_55_8 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play1108407013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 1108407013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play1108407014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1084ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos1084ui_story = var_59_0.localPosition
			end

			local var_59_2 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2
				local var_59_4 = Vector3.New(0, -0.97, -6)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1084ui_story, var_59_4, var_59_3)

				local var_59_5 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_5.x, var_59_5.y, var_59_5.z)

				local var_59_6 = var_59_0.localEulerAngles

				var_59_6.z = 0
				var_59_6.x = 0
				var_59_0.localEulerAngles = var_59_6
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_59_7 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_7.x, var_59_7.y, var_59_7.z)

				local var_59_8 = var_59_0.localEulerAngles

				var_59_8.z = 0
				var_59_8.x = 0
				var_59_0.localEulerAngles = var_59_8
			end

			local var_59_9 = arg_56_1.actors_["1084ui_story"]
			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect1084ui_story == nil then
				arg_56_1.var_.characterEffect1084ui_story = var_59_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_11 = 0.200000002980232

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_11 and not isNil(var_59_9) then
				local var_59_12 = (arg_56_1.time_ - var_59_10) / var_59_11

				if arg_56_1.var_.characterEffect1084ui_story and not isNil(var_59_9) then
					arg_56_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_10 + var_59_11 and arg_56_1.time_ < var_59_10 + var_59_11 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect1084ui_story then
				arg_56_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_59_13 = 0

			if var_59_13 < arg_56_1.time_ and arg_56_1.time_ <= var_59_13 + arg_59_0 then
				arg_56_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_59_14 = 0

			if var_59_14 < arg_56_1.time_ and arg_56_1.time_ <= var_59_14 + arg_59_0 then
				arg_56_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_59_15 = 0
			local var_59_16 = 0.625

			if var_59_15 < arg_56_1.time_ and arg_56_1.time_ <= var_59_15 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_17 = arg_56_1:FormatText(StoryNameCfg[6].name)

				arg_56_1.leftNameTxt_.text = var_59_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_18 = arg_56_1:GetWordFromCfg(1108407013)
				local var_59_19 = arg_56_1:FormatText(var_59_18.content)

				arg_56_1.text_.text = var_59_19

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_20 = 25
				local var_59_21 = utf8.len(var_59_19)
				local var_59_22 = var_59_20 <= 0 and var_59_16 or var_59_16 * (var_59_21 / var_59_20)

				if var_59_22 > 0 and var_59_16 < var_59_22 then
					arg_56_1.talkMaxDuration = var_59_22

					if var_59_22 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_22 + var_59_15
					end
				end

				arg_56_1.text_.text = var_59_19
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407013", "story_v_side_new_1108407.awb") ~= 0 then
					local var_59_23 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407013", "story_v_side_new_1108407.awb") / 1000

					if var_59_23 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_23 + var_59_15
					end

					if var_59_18.prefab_name ~= "" and arg_56_1.actors_[var_59_18.prefab_name] ~= nil then
						local var_59_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_18.prefab_name].transform, "story_v_side_new_1108407", "1108407013", "story_v_side_new_1108407.awb")

						arg_56_1:RecordAudio("1108407013", var_59_24)
						arg_56_1:RecordAudio("1108407013", var_59_24)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407013", "story_v_side_new_1108407.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407013", "story_v_side_new_1108407.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_25 = math.max(var_59_16, arg_56_1.talkMaxDuration)

			if var_59_15 <= arg_56_1.time_ and arg_56_1.time_ < var_59_15 + var_59_25 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_15) / var_59_25

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_15 + var_59_25 and arg_56_1.time_ < var_59_15 + var_59_25 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play1108407014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 1108407014
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play1108407015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1084ui_story"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos1084ui_story = var_63_0.localPosition
			end

			local var_63_2 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2
				local var_63_4 = Vector3.New(0, 100, 0)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1084ui_story, var_63_4, var_63_3)

				local var_63_5 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_5.x, var_63_5.y, var_63_5.z)

				local var_63_6 = var_63_0.localEulerAngles

				var_63_6.z = 0
				var_63_6.x = 0
				var_63_0.localEulerAngles = var_63_6
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(0, 100, 0)

				local var_63_7 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_7.x, var_63_7.y, var_63_7.z)

				local var_63_8 = var_63_0.localEulerAngles

				var_63_8.z = 0
				var_63_8.x = 0
				var_63_0.localEulerAngles = var_63_8
			end

			local var_63_9 = arg_60_1.actors_["1084ui_story"]
			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 and not isNil(var_63_9) and arg_60_1.var_.characterEffect1084ui_story == nil then
				arg_60_1.var_.characterEffect1084ui_story = var_63_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_11 = 0.200000002980232

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_11 and not isNil(var_63_9) then
				local var_63_12 = (arg_60_1.time_ - var_63_10) / var_63_11

				if arg_60_1.var_.characterEffect1084ui_story and not isNil(var_63_9) then
					local var_63_13 = Mathf.Lerp(0, 0.5, var_63_12)

					arg_60_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1084ui_story.fillRatio = var_63_13
				end
			end

			if arg_60_1.time_ >= var_63_10 + var_63_11 and arg_60_1.time_ < var_63_10 + var_63_11 + arg_63_0 and not isNil(var_63_9) and arg_60_1.var_.characterEffect1084ui_story then
				local var_63_14 = 0.5

				arg_60_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1084ui_story.fillRatio = var_63_14
			end

			local var_63_15 = 0
			local var_63_16 = 1.175

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_17 = arg_60_1:GetWordFromCfg(1108407014)
				local var_63_18 = arg_60_1:FormatText(var_63_17.content)

				arg_60_1.text_.text = var_63_18

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_19 = 47
				local var_63_20 = utf8.len(var_63_18)
				local var_63_21 = var_63_19 <= 0 and var_63_16 or var_63_16 * (var_63_20 / var_63_19)

				if var_63_21 > 0 and var_63_16 < var_63_21 then
					arg_60_1.talkMaxDuration = var_63_21

					if var_63_21 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_21 + var_63_15
					end
				end

				arg_60_1.text_.text = var_63_18
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_22 = math.max(var_63_16, arg_60_1.talkMaxDuration)

			if var_63_15 <= arg_60_1.time_ and arg_60_1.time_ < var_63_15 + var_63_22 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_15) / var_63_22

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_15 + var_63_22 and arg_60_1.time_ < var_63_15 + var_63_22 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play1108407015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 1108407015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play1108407016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 0.85

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_2 = arg_64_1:FormatText(StoryNameCfg[7].name)

				arg_64_1.leftNameTxt_.text = var_67_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:GetWordFromCfg(1108407015)
				local var_67_4 = arg_64_1:FormatText(var_67_3.content)

				arg_64_1.text_.text = var_67_4

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 34
				local var_67_6 = utf8.len(var_67_4)
				local var_67_7 = var_67_5 <= 0 and var_67_1 or var_67_1 * (var_67_6 / var_67_5)

				if var_67_7 > 0 and var_67_1 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_4
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_8 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_8 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_8

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_8 and arg_64_1.time_ < var_67_0 + var_67_8 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play1108407016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 1108407016
		arg_68_1.duration_ = 2.37

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play1108407017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1084ui_story"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos1084ui_story = var_71_0.localPosition
			end

			local var_71_2 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2
				local var_71_4 = Vector3.New(0, -0.97, -6)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1084ui_story, var_71_4, var_71_3)

				local var_71_5 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_5.x, var_71_5.y, var_71_5.z)

				local var_71_6 = var_71_0.localEulerAngles

				var_71_6.z = 0
				var_71_6.x = 0
				var_71_0.localEulerAngles = var_71_6
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_71_7 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_7.x, var_71_7.y, var_71_7.z)

				local var_71_8 = var_71_0.localEulerAngles

				var_71_8.z = 0
				var_71_8.x = 0
				var_71_0.localEulerAngles = var_71_8
			end

			local var_71_9 = arg_68_1.actors_["1084ui_story"]
			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 and not isNil(var_71_9) and arg_68_1.var_.characterEffect1084ui_story == nil then
				arg_68_1.var_.characterEffect1084ui_story = var_71_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_11 = 0.200000002980232

			if var_71_10 <= arg_68_1.time_ and arg_68_1.time_ < var_71_10 + var_71_11 and not isNil(var_71_9) then
				local var_71_12 = (arg_68_1.time_ - var_71_10) / var_71_11

				if arg_68_1.var_.characterEffect1084ui_story and not isNil(var_71_9) then
					arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_10 + var_71_11 and arg_68_1.time_ < var_71_10 + var_71_11 + arg_71_0 and not isNil(var_71_9) and arg_68_1.var_.characterEffect1084ui_story then
				arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_71_13 = 0

			if var_71_13 < arg_68_1.time_ and arg_68_1.time_ <= var_71_13 + arg_71_0 then
				arg_68_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_71_14 = 0

			if var_71_14 < arg_68_1.time_ and arg_68_1.time_ <= var_71_14 + arg_71_0 then
				arg_68_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_71_15 = 0
			local var_71_16 = 0.225

			if var_71_15 < arg_68_1.time_ and arg_68_1.time_ <= var_71_15 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_17 = arg_68_1:FormatText(StoryNameCfg[6].name)

				arg_68_1.leftNameTxt_.text = var_71_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_18 = arg_68_1:GetWordFromCfg(1108407016)
				local var_71_19 = arg_68_1:FormatText(var_71_18.content)

				arg_68_1.text_.text = var_71_19

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_20 = 9
				local var_71_21 = utf8.len(var_71_19)
				local var_71_22 = var_71_20 <= 0 and var_71_16 or var_71_16 * (var_71_21 / var_71_20)

				if var_71_22 > 0 and var_71_16 < var_71_22 then
					arg_68_1.talkMaxDuration = var_71_22

					if var_71_22 + var_71_15 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_22 + var_71_15
					end
				end

				arg_68_1.text_.text = var_71_19
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407016", "story_v_side_new_1108407.awb") ~= 0 then
					local var_71_23 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407016", "story_v_side_new_1108407.awb") / 1000

					if var_71_23 + var_71_15 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_23 + var_71_15
					end

					if var_71_18.prefab_name ~= "" and arg_68_1.actors_[var_71_18.prefab_name] ~= nil then
						local var_71_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_18.prefab_name].transform, "story_v_side_new_1108407", "1108407016", "story_v_side_new_1108407.awb")

						arg_68_1:RecordAudio("1108407016", var_71_24)
						arg_68_1:RecordAudio("1108407016", var_71_24)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407016", "story_v_side_new_1108407.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407016", "story_v_side_new_1108407.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_25 = math.max(var_71_16, arg_68_1.talkMaxDuration)

			if var_71_15 <= arg_68_1.time_ and arg_68_1.time_ < var_71_15 + var_71_25 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_15) / var_71_25

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_15 + var_71_25 and arg_68_1.time_ < var_71_15 + var_71_25 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play1108407017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 1108407017
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play1108407018(arg_72_1)
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

			local var_75_9 = arg_72_1.actors_["1084ui_story"]
			local var_75_10 = 0

			if var_75_10 < arg_72_1.time_ and arg_72_1.time_ <= var_75_10 + arg_75_0 and not isNil(var_75_9) and arg_72_1.var_.characterEffect1084ui_story == nil then
				arg_72_1.var_.characterEffect1084ui_story = var_75_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_11 = 0.200000002980232

			if var_75_10 <= arg_72_1.time_ and arg_72_1.time_ < var_75_10 + var_75_11 and not isNil(var_75_9) then
				local var_75_12 = (arg_72_1.time_ - var_75_10) / var_75_11

				if arg_72_1.var_.characterEffect1084ui_story and not isNil(var_75_9) then
					local var_75_13 = Mathf.Lerp(0, 0.5, var_75_12)

					arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1084ui_story.fillRatio = var_75_13
				end
			end

			if arg_72_1.time_ >= var_75_10 + var_75_11 and arg_72_1.time_ < var_75_10 + var_75_11 + arg_75_0 and not isNil(var_75_9) and arg_72_1.var_.characterEffect1084ui_story then
				local var_75_14 = 0.5

				arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1084ui_story.fillRatio = var_75_14
			end

			local var_75_15 = 0
			local var_75_16 = 0.65

			if var_75_15 < arg_72_1.time_ and arg_72_1.time_ <= var_75_15 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_17 = arg_72_1:GetWordFromCfg(1108407017)
				local var_75_18 = arg_72_1:FormatText(var_75_17.content)

				arg_72_1.text_.text = var_75_18

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_19 = 26
				local var_75_20 = utf8.len(var_75_18)
				local var_75_21 = var_75_19 <= 0 and var_75_16 or var_75_16 * (var_75_20 / var_75_19)

				if var_75_21 > 0 and var_75_16 < var_75_21 then
					arg_72_1.talkMaxDuration = var_75_21

					if var_75_21 + var_75_15 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_21 + var_75_15
					end
				end

				arg_72_1.text_.text = var_75_18
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_22 = math.max(var_75_16, arg_72_1.talkMaxDuration)

			if var_75_15 <= arg_72_1.time_ and arg_72_1.time_ < var_75_15 + var_75_22 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_15) / var_75_22

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_15 + var_75_22 and arg_72_1.time_ < var_75_15 + var_75_22 + arg_75_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play1108407018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 1108407018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play1108407019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 0.65

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_2 = arg_76_1:FormatText(StoryNameCfg[7].name)

				arg_76_1.leftNameTxt_.text = var_79_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_3 = arg_76_1:GetWordFromCfg(1108407018)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 26
				local var_79_6 = utf8.len(var_79_4)
				local var_79_7 = var_79_5 <= 0 and var_79_1 or var_79_1 * (var_79_6 / var_79_5)

				if var_79_7 > 0 and var_79_1 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_8 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_8 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_8

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_8 and arg_76_1.time_ < var_79_0 + var_79_8 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play1108407019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 1108407019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play1108407020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 0.525

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

				local var_83_2 = arg_80_1:GetWordFromCfg(1108407019)
				local var_83_3 = arg_80_1:FormatText(var_83_2.content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_4 = 21
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
	Play1108407020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 1108407020
		arg_84_1.duration_ = 5.9

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play1108407021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1084ui_story"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos1084ui_story = var_87_0.localPosition
			end

			local var_87_2 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2
				local var_87_4 = Vector3.New(0, -0.97, -6)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1084ui_story, var_87_4, var_87_3)

				local var_87_5 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_5.x, var_87_5.y, var_87_5.z)

				local var_87_6 = var_87_0.localEulerAngles

				var_87_6.z = 0
				var_87_6.x = 0
				var_87_0.localEulerAngles = var_87_6
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_87_7 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_7.x, var_87_7.y, var_87_7.z)

				local var_87_8 = var_87_0.localEulerAngles

				var_87_8.z = 0
				var_87_8.x = 0
				var_87_0.localEulerAngles = var_87_8
			end

			local var_87_9 = arg_84_1.actors_["1084ui_story"]
			local var_87_10 = 0

			if var_87_10 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 and not isNil(var_87_9) and arg_84_1.var_.characterEffect1084ui_story == nil then
				arg_84_1.var_.characterEffect1084ui_story = var_87_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_11 = 0.200000002980232

			if var_87_10 <= arg_84_1.time_ and arg_84_1.time_ < var_87_10 + var_87_11 and not isNil(var_87_9) then
				local var_87_12 = (arg_84_1.time_ - var_87_10) / var_87_11

				if arg_84_1.var_.characterEffect1084ui_story and not isNil(var_87_9) then
					arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_10 + var_87_11 and arg_84_1.time_ < var_87_10 + var_87_11 + arg_87_0 and not isNil(var_87_9) and arg_84_1.var_.characterEffect1084ui_story then
				arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_87_13 = 0

			if var_87_13 < arg_84_1.time_ and arg_84_1.time_ <= var_87_13 + arg_87_0 then
				arg_84_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_87_14 = 0

			if var_87_14 < arg_84_1.time_ and arg_84_1.time_ <= var_87_14 + arg_87_0 then
				arg_84_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_87_15 = 0
			local var_87_16 = 0.525

			if var_87_15 < arg_84_1.time_ and arg_84_1.time_ <= var_87_15 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_17 = arg_84_1:FormatText(StoryNameCfg[6].name)

				arg_84_1.leftNameTxt_.text = var_87_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_18 = arg_84_1:GetWordFromCfg(1108407020)
				local var_87_19 = arg_84_1:FormatText(var_87_18.content)

				arg_84_1.text_.text = var_87_19

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_20 = 21
				local var_87_21 = utf8.len(var_87_19)
				local var_87_22 = var_87_20 <= 0 and var_87_16 or var_87_16 * (var_87_21 / var_87_20)

				if var_87_22 > 0 and var_87_16 < var_87_22 then
					arg_84_1.talkMaxDuration = var_87_22

					if var_87_22 + var_87_15 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_22 + var_87_15
					end
				end

				arg_84_1.text_.text = var_87_19
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407020", "story_v_side_new_1108407.awb") ~= 0 then
					local var_87_23 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407020", "story_v_side_new_1108407.awb") / 1000

					if var_87_23 + var_87_15 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_23 + var_87_15
					end

					if var_87_18.prefab_name ~= "" and arg_84_1.actors_[var_87_18.prefab_name] ~= nil then
						local var_87_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_18.prefab_name].transform, "story_v_side_new_1108407", "1108407020", "story_v_side_new_1108407.awb")

						arg_84_1:RecordAudio("1108407020", var_87_24)
						arg_84_1:RecordAudio("1108407020", var_87_24)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407020", "story_v_side_new_1108407.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407020", "story_v_side_new_1108407.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_25 = math.max(var_87_16, arg_84_1.talkMaxDuration)

			if var_87_15 <= arg_84_1.time_ and arg_84_1.time_ < var_87_15 + var_87_25 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_15) / var_87_25

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_15 + var_87_25 and arg_84_1.time_ < var_87_15 + var_87_25 + arg_87_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play1108407021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 1108407021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play1108407022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1084ui_story"].transform
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.var_.moveOldPos1084ui_story = var_91_0.localPosition
			end

			local var_91_2 = 0.001

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2
				local var_91_4 = Vector3.New(0, 100, 0)

				var_91_0.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1084ui_story, var_91_4, var_91_3)

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

			local var_91_9 = arg_88_1.actors_["1084ui_story"]
			local var_91_10 = 0

			if var_91_10 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 and not isNil(var_91_9) and arg_88_1.var_.characterEffect1084ui_story == nil then
				arg_88_1.var_.characterEffect1084ui_story = var_91_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_11 = 0.200000002980232

			if var_91_10 <= arg_88_1.time_ and arg_88_1.time_ < var_91_10 + var_91_11 and not isNil(var_91_9) then
				local var_91_12 = (arg_88_1.time_ - var_91_10) / var_91_11

				if arg_88_1.var_.characterEffect1084ui_story and not isNil(var_91_9) then
					local var_91_13 = Mathf.Lerp(0, 0.5, var_91_12)

					arg_88_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1084ui_story.fillRatio = var_91_13
				end
			end

			if arg_88_1.time_ >= var_91_10 + var_91_11 and arg_88_1.time_ < var_91_10 + var_91_11 + arg_91_0 and not isNil(var_91_9) and arg_88_1.var_.characterEffect1084ui_story then
				local var_91_14 = 0.5

				arg_88_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1084ui_story.fillRatio = var_91_14
			end

			local var_91_15 = 0
			local var_91_16 = 1.475

			if var_91_15 < arg_88_1.time_ and arg_88_1.time_ <= var_91_15 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_17 = arg_88_1:GetWordFromCfg(1108407021)
				local var_91_18 = arg_88_1:FormatText(var_91_17.content)

				arg_88_1.text_.text = var_91_18

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_19 = 59
				local var_91_20 = utf8.len(var_91_18)
				local var_91_21 = var_91_19 <= 0 and var_91_16 or var_91_16 * (var_91_20 / var_91_19)

				if var_91_21 > 0 and var_91_16 < var_91_21 then
					arg_88_1.talkMaxDuration = var_91_21

					if var_91_21 + var_91_15 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_21 + var_91_15
					end
				end

				arg_88_1.text_.text = var_91_18
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_22 = math.max(var_91_16, arg_88_1.talkMaxDuration)

			if var_91_15 <= arg_88_1.time_ and arg_88_1.time_ < var_91_15 + var_91_22 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_15) / var_91_22

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_15 + var_91_22 and arg_88_1.time_ < var_91_15 + var_91_22 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play1108407022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 1108407022
		arg_92_1.duration_ = 3.63

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play1108407023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1084ui_story"].transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos1084ui_story = var_95_0.localPosition
			end

			local var_95_2 = 0.001

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2
				local var_95_4 = Vector3.New(0, -0.97, -6)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1084ui_story, var_95_4, var_95_3)

				local var_95_5 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_5.x, var_95_5.y, var_95_5.z)

				local var_95_6 = var_95_0.localEulerAngles

				var_95_6.z = 0
				var_95_6.x = 0
				var_95_0.localEulerAngles = var_95_6
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_95_7 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_7.x, var_95_7.y, var_95_7.z)

				local var_95_8 = var_95_0.localEulerAngles

				var_95_8.z = 0
				var_95_8.x = 0
				var_95_0.localEulerAngles = var_95_8
			end

			local var_95_9 = arg_92_1.actors_["1084ui_story"]
			local var_95_10 = 0

			if var_95_10 < arg_92_1.time_ and arg_92_1.time_ <= var_95_10 + arg_95_0 and not isNil(var_95_9) and arg_92_1.var_.characterEffect1084ui_story == nil then
				arg_92_1.var_.characterEffect1084ui_story = var_95_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_11 = 0.200000002980232

			if var_95_10 <= arg_92_1.time_ and arg_92_1.time_ < var_95_10 + var_95_11 and not isNil(var_95_9) then
				local var_95_12 = (arg_92_1.time_ - var_95_10) / var_95_11

				if arg_92_1.var_.characterEffect1084ui_story and not isNil(var_95_9) then
					arg_92_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_10 + var_95_11 and arg_92_1.time_ < var_95_10 + var_95_11 + arg_95_0 and not isNil(var_95_9) and arg_92_1.var_.characterEffect1084ui_story then
				arg_92_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_95_13 = 0

			if var_95_13 < arg_92_1.time_ and arg_92_1.time_ <= var_95_13 + arg_95_0 then
				arg_92_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_95_14 = 0

			if var_95_14 < arg_92_1.time_ and arg_92_1.time_ <= var_95_14 + arg_95_0 then
				arg_92_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_95_15 = 0
			local var_95_16 = 0.7

			if var_95_15 < arg_92_1.time_ and arg_92_1.time_ <= var_95_15 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_17 = arg_92_1:FormatText(StoryNameCfg[6].name)

				arg_92_1.leftNameTxt_.text = var_95_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_18 = arg_92_1:GetWordFromCfg(1108407022)
				local var_95_19 = arg_92_1:FormatText(var_95_18.content)

				arg_92_1.text_.text = var_95_19

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_20 = 13
				local var_95_21 = utf8.len(var_95_19)
				local var_95_22 = var_95_20 <= 0 and var_95_16 or var_95_16 * (var_95_21 / var_95_20)

				if var_95_22 > 0 and var_95_16 < var_95_22 then
					arg_92_1.talkMaxDuration = var_95_22

					if var_95_22 + var_95_15 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_22 + var_95_15
					end
				end

				arg_92_1.text_.text = var_95_19
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407022", "story_v_side_new_1108407.awb") ~= 0 then
					local var_95_23 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407022", "story_v_side_new_1108407.awb") / 1000

					if var_95_23 + var_95_15 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_23 + var_95_15
					end

					if var_95_18.prefab_name ~= "" and arg_92_1.actors_[var_95_18.prefab_name] ~= nil then
						local var_95_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_18.prefab_name].transform, "story_v_side_new_1108407", "1108407022", "story_v_side_new_1108407.awb")

						arg_92_1:RecordAudio("1108407022", var_95_24)
						arg_92_1:RecordAudio("1108407022", var_95_24)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407022", "story_v_side_new_1108407.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407022", "story_v_side_new_1108407.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_25 = math.max(var_95_16, arg_92_1.talkMaxDuration)

			if var_95_15 <= arg_92_1.time_ and arg_92_1.time_ < var_95_15 + var_95_25 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_15) / var_95_25

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_15 + var_95_25 and arg_92_1.time_ < var_95_15 + var_95_25 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play1108407023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 1108407023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play1108407024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1084ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1084ui_story == nil then
				arg_96_1.var_.characterEffect1084ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1084ui_story and not isNil(var_99_0) then
					local var_99_4 = Mathf.Lerp(0, 0.5, var_99_3)

					arg_96_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1084ui_story.fillRatio = var_99_4
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1084ui_story then
				local var_99_5 = 0.5

				arg_96_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1084ui_story.fillRatio = var_99_5
			end

			local var_99_6 = 0
			local var_99_7 = 1.25

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_8 = arg_96_1:FormatText(StoryNameCfg[7].name)

				arg_96_1.leftNameTxt_.text = var_99_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_9 = arg_96_1:GetWordFromCfg(1108407023)
				local var_99_10 = arg_96_1:FormatText(var_99_9.content)

				arg_96_1.text_.text = var_99_10

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_11 = 50
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
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_14 = math.max(var_99_7, arg_96_1.talkMaxDuration)

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_14 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_6) / var_99_14

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_6 + var_99_14 and arg_96_1.time_ < var_99_6 + var_99_14 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play1108407024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 1108407024
		arg_100_1.duration_ = 5.2

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play1108407025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1084ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1084ui_story == nil then
				arg_100_1.var_.characterEffect1084ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1084ui_story and not isNil(var_103_0) then
					arg_100_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1084ui_story then
				arg_100_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_103_4 = 0

			if var_103_4 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_103_5 = 0

			if var_103_5 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 then
				arg_100_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_103_6 = 0
			local var_103_7 = 0.575

			if var_103_6 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_8 = arg_100_1:FormatText(StoryNameCfg[6].name)

				arg_100_1.leftNameTxt_.text = var_103_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_9 = arg_100_1:GetWordFromCfg(1108407024)
				local var_103_10 = arg_100_1:FormatText(var_103_9.content)

				arg_100_1.text_.text = var_103_10

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_11 = 23
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407024", "story_v_side_new_1108407.awb") ~= 0 then
					local var_103_14 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407024", "story_v_side_new_1108407.awb") / 1000

					if var_103_14 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_14 + var_103_6
					end

					if var_103_9.prefab_name ~= "" and arg_100_1.actors_[var_103_9.prefab_name] ~= nil then
						local var_103_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_9.prefab_name].transform, "story_v_side_new_1108407", "1108407024", "story_v_side_new_1108407.awb")

						arg_100_1:RecordAudio("1108407024", var_103_15)
						arg_100_1:RecordAudio("1108407024", var_103_15)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407024", "story_v_side_new_1108407.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407024", "story_v_side_new_1108407.awb")
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
	Play1108407025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 1108407025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play1108407026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1084ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1084ui_story == nil then
				arg_104_1.var_.characterEffect1084ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.200000002980232

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect1084ui_story and not isNil(var_107_0) then
					local var_107_4 = Mathf.Lerp(0, 0.5, var_107_3)

					arg_104_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1084ui_story.fillRatio = var_107_4
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1084ui_story then
				local var_107_5 = 0.5

				arg_104_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1084ui_story.fillRatio = var_107_5
			end

			local var_107_6 = 0
			local var_107_7 = 0.8

			if var_107_6 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_8 = arg_104_1:FormatText(StoryNameCfg[7].name)

				arg_104_1.leftNameTxt_.text = var_107_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_9 = arg_104_1:GetWordFromCfg(1108407025)
				local var_107_10 = arg_104_1:FormatText(var_107_9.content)

				arg_104_1.text_.text = var_107_10

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_11 = 32
				local var_107_12 = utf8.len(var_107_10)
				local var_107_13 = var_107_11 <= 0 and var_107_7 or var_107_7 * (var_107_12 / var_107_11)

				if var_107_13 > 0 and var_107_7 < var_107_13 then
					arg_104_1.talkMaxDuration = var_107_13

					if var_107_13 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_13 + var_107_6
					end
				end

				arg_104_1.text_.text = var_107_10
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_14 = math.max(var_107_7, arg_104_1.talkMaxDuration)

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_14 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_6) / var_107_14

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_6 + var_107_14 and arg_104_1.time_ < var_107_6 + var_107_14 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play1108407026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 1108407026
		arg_108_1.duration_ = 7.33

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play1108407027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1084ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1084ui_story == nil then
				arg_108_1.var_.characterEffect1084ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect1084ui_story and not isNil(var_111_0) then
					arg_108_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1084ui_story then
				arg_108_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_111_4 = 0

			if var_111_4 < arg_108_1.time_ and arg_108_1.time_ <= var_111_4 + arg_111_0 then
				arg_108_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_111_5 = 0

			if var_111_5 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 then
				arg_108_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_111_6 = 0
			local var_111_7 = 0.575

			if var_111_6 < arg_108_1.time_ and arg_108_1.time_ <= var_111_6 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_8 = arg_108_1:FormatText(StoryNameCfg[6].name)

				arg_108_1.leftNameTxt_.text = var_111_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_9 = arg_108_1:GetWordFromCfg(1108407026)
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407026", "story_v_side_new_1108407.awb") ~= 0 then
					local var_111_14 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407026", "story_v_side_new_1108407.awb") / 1000

					if var_111_14 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_14 + var_111_6
					end

					if var_111_9.prefab_name ~= "" and arg_108_1.actors_[var_111_9.prefab_name] ~= nil then
						local var_111_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_9.prefab_name].transform, "story_v_side_new_1108407", "1108407026", "story_v_side_new_1108407.awb")

						arg_108_1:RecordAudio("1108407026", var_111_15)
						arg_108_1:RecordAudio("1108407026", var_111_15)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407026", "story_v_side_new_1108407.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407026", "story_v_side_new_1108407.awb")
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
	Play1108407027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 1108407027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play1108407028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1084ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1084ui_story == nil then
				arg_112_1.var_.characterEffect1084ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect1084ui_story and not isNil(var_115_0) then
					local var_115_4 = Mathf.Lerp(0, 0.5, var_115_3)

					arg_112_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1084ui_story.fillRatio = var_115_4
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1084ui_story then
				local var_115_5 = 0.5

				arg_112_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1084ui_story.fillRatio = var_115_5
			end

			local var_115_6 = 0
			local var_115_7 = 0.825

			if var_115_6 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_8 = arg_112_1:FormatText(StoryNameCfg[7].name)

				arg_112_1.leftNameTxt_.text = var_115_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_9 = arg_112_1:GetWordFromCfg(1108407027)
				local var_115_10 = arg_112_1:FormatText(var_115_9.content)

				arg_112_1.text_.text = var_115_10

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_11 = 33
				local var_115_12 = utf8.len(var_115_10)
				local var_115_13 = var_115_11 <= 0 and var_115_7 or var_115_7 * (var_115_12 / var_115_11)

				if var_115_13 > 0 and var_115_7 < var_115_13 then
					arg_112_1.talkMaxDuration = var_115_13

					if var_115_13 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_13 + var_115_6
					end
				end

				arg_112_1.text_.text = var_115_10
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_14 = math.max(var_115_7, arg_112_1.talkMaxDuration)

			if var_115_6 <= arg_112_1.time_ and arg_112_1.time_ < var_115_6 + var_115_14 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_6) / var_115_14

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_6 + var_115_14 and arg_112_1.time_ < var_115_6 + var_115_14 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play1108407028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 1108407028
		arg_116_1.duration_ = 1.17

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play1108407029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1084ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1084ui_story == nil then
				arg_116_1.var_.characterEffect1084ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect1084ui_story and not isNil(var_119_0) then
					arg_116_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1084ui_story then
				arg_116_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_119_4 = 0

			if var_119_4 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_119_5 = 0

			if var_119_5 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 then
				arg_116_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_119_6 = 0
			local var_119_7 = 0.075

			if var_119_6 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_8 = arg_116_1:FormatText(StoryNameCfg[6].name)

				arg_116_1.leftNameTxt_.text = var_119_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_9 = arg_116_1:GetWordFromCfg(1108407028)
				local var_119_10 = arg_116_1:FormatText(var_119_9.content)

				arg_116_1.text_.text = var_119_10

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_11 = 3
				local var_119_12 = utf8.len(var_119_10)
				local var_119_13 = var_119_11 <= 0 and var_119_7 or var_119_7 * (var_119_12 / var_119_11)

				if var_119_13 > 0 and var_119_7 < var_119_13 then
					arg_116_1.talkMaxDuration = var_119_13

					if var_119_13 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_13 + var_119_6
					end
				end

				arg_116_1.text_.text = var_119_10
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407028", "story_v_side_new_1108407.awb") ~= 0 then
					local var_119_14 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407028", "story_v_side_new_1108407.awb") / 1000

					if var_119_14 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_14 + var_119_6
					end

					if var_119_9.prefab_name ~= "" and arg_116_1.actors_[var_119_9.prefab_name] ~= nil then
						local var_119_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_9.prefab_name].transform, "story_v_side_new_1108407", "1108407028", "story_v_side_new_1108407.awb")

						arg_116_1:RecordAudio("1108407028", var_119_15)
						arg_116_1:RecordAudio("1108407028", var_119_15)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407028", "story_v_side_new_1108407.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407028", "story_v_side_new_1108407.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_16 = math.max(var_119_7, arg_116_1.talkMaxDuration)

			if var_119_6 <= arg_116_1.time_ and arg_116_1.time_ < var_119_6 + var_119_16 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_6) / var_119_16

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_6 + var_119_16 and arg_116_1.time_ < var_119_6 + var_119_16 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play1108407029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 1108407029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play1108407030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1084ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1084ui_story == nil then
				arg_120_1.var_.characterEffect1084ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect1084ui_story and not isNil(var_123_0) then
					local var_123_4 = Mathf.Lerp(0, 0.5, var_123_3)

					arg_120_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1084ui_story.fillRatio = var_123_4
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1084ui_story then
				local var_123_5 = 0.5

				arg_120_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1084ui_story.fillRatio = var_123_5
			end

			local var_123_6 = 0
			local var_123_7 = 0.225

			if var_123_6 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_8 = arg_120_1:FormatText(StoryNameCfg[7].name)

				arg_120_1.leftNameTxt_.text = var_123_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_9 = arg_120_1:GetWordFromCfg(1108407029)
				local var_123_10 = arg_120_1:FormatText(var_123_9.content)

				arg_120_1.text_.text = var_123_10

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_11 = 9
				local var_123_12 = utf8.len(var_123_10)
				local var_123_13 = var_123_11 <= 0 and var_123_7 or var_123_7 * (var_123_12 / var_123_11)

				if var_123_13 > 0 and var_123_7 < var_123_13 then
					arg_120_1.talkMaxDuration = var_123_13

					if var_123_13 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_13 + var_123_6
					end
				end

				arg_120_1.text_.text = var_123_10
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_14 = math.max(var_123_7, arg_120_1.talkMaxDuration)

			if var_123_6 <= arg_120_1.time_ and arg_120_1.time_ < var_123_6 + var_123_14 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_6) / var_123_14

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_6 + var_123_14 and arg_120_1.time_ < var_123_6 + var_123_14 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play1108407030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 1108407030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play1108407031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1084ui_story"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos1084ui_story = var_127_0.localPosition
			end

			local var_127_2 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2
				local var_127_4 = Vector3.New(0, 100, 0)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1084ui_story, var_127_4, var_127_3)

				local var_127_5 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_5.x, var_127_5.y, var_127_5.z)

				local var_127_6 = var_127_0.localEulerAngles

				var_127_6.z = 0
				var_127_6.x = 0
				var_127_0.localEulerAngles = var_127_6
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 then
				var_127_0.localPosition = Vector3.New(0, 100, 0)

				local var_127_7 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_7.x, var_127_7.y, var_127_7.z)

				local var_127_8 = var_127_0.localEulerAngles

				var_127_8.z = 0
				var_127_8.x = 0
				var_127_0.localEulerAngles = var_127_8
			end

			local var_127_9 = 0
			local var_127_10 = 1.3

			if var_127_9 < arg_124_1.time_ and arg_124_1.time_ <= var_127_9 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_11 = arg_124_1:GetWordFromCfg(1108407030)
				local var_127_12 = arg_124_1:FormatText(var_127_11.content)

				arg_124_1.text_.text = var_127_12

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_13 = 52
				local var_127_14 = utf8.len(var_127_12)
				local var_127_15 = var_127_13 <= 0 and var_127_10 or var_127_10 * (var_127_14 / var_127_13)

				if var_127_15 > 0 and var_127_10 < var_127_15 then
					arg_124_1.talkMaxDuration = var_127_15

					if var_127_15 + var_127_9 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_15 + var_127_9
					end
				end

				arg_124_1.text_.text = var_127_12
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_16 = math.max(var_127_10, arg_124_1.talkMaxDuration)

			if var_127_9 <= arg_124_1.time_ and arg_124_1.time_ < var_127_9 + var_127_16 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_9) / var_127_16

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_9 + var_127_16 and arg_124_1.time_ < var_127_9 + var_127_16 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play1108407031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 1108407031
		arg_128_1.duration_ = 1.43

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play1108407032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1084ui_story"].transform
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.var_.moveOldPos1084ui_story = var_131_0.localPosition
			end

			local var_131_2 = 0.001

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2
				local var_131_4 = Vector3.New(0, -0.97, -6)

				var_131_0.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1084ui_story, var_131_4, var_131_3)

				local var_131_5 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_5.x, var_131_5.y, var_131_5.z)

				local var_131_6 = var_131_0.localEulerAngles

				var_131_6.z = 0
				var_131_6.x = 0
				var_131_0.localEulerAngles = var_131_6
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 then
				var_131_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_131_7 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_7.x, var_131_7.y, var_131_7.z)

				local var_131_8 = var_131_0.localEulerAngles

				var_131_8.z = 0
				var_131_8.x = 0
				var_131_0.localEulerAngles = var_131_8
			end

			local var_131_9 = arg_128_1.actors_["1084ui_story"]
			local var_131_10 = 0

			if var_131_10 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 and not isNil(var_131_9) and arg_128_1.var_.characterEffect1084ui_story == nil then
				arg_128_1.var_.characterEffect1084ui_story = var_131_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_11 = 0.200000002980232

			if var_131_10 <= arg_128_1.time_ and arg_128_1.time_ < var_131_10 + var_131_11 and not isNil(var_131_9) then
				local var_131_12 = (arg_128_1.time_ - var_131_10) / var_131_11

				if arg_128_1.var_.characterEffect1084ui_story and not isNil(var_131_9) then
					arg_128_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_10 + var_131_11 and arg_128_1.time_ < var_131_10 + var_131_11 + arg_131_0 and not isNil(var_131_9) and arg_128_1.var_.characterEffect1084ui_story then
				arg_128_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_131_13 = 0

			if var_131_13 < arg_128_1.time_ and arg_128_1.time_ <= var_131_13 + arg_131_0 then
				arg_128_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_131_14 = 0

			if var_131_14 < arg_128_1.time_ and arg_128_1.time_ <= var_131_14 + arg_131_0 then
				arg_128_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_131_15 = 0
			local var_131_16 = 0.125

			if var_131_15 < arg_128_1.time_ and arg_128_1.time_ <= var_131_15 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_17 = arg_128_1:FormatText(StoryNameCfg[6].name)

				arg_128_1.leftNameTxt_.text = var_131_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_18 = arg_128_1:GetWordFromCfg(1108407031)
				local var_131_19 = arg_128_1:FormatText(var_131_18.content)

				arg_128_1.text_.text = var_131_19

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_20 = 5
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407031", "story_v_side_new_1108407.awb") ~= 0 then
					local var_131_23 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407031", "story_v_side_new_1108407.awb") / 1000

					if var_131_23 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_23 + var_131_15
					end

					if var_131_18.prefab_name ~= "" and arg_128_1.actors_[var_131_18.prefab_name] ~= nil then
						local var_131_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_18.prefab_name].transform, "story_v_side_new_1108407", "1108407031", "story_v_side_new_1108407.awb")

						arg_128_1:RecordAudio("1108407031", var_131_24)
						arg_128_1:RecordAudio("1108407031", var_131_24)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407031", "story_v_side_new_1108407.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407031", "story_v_side_new_1108407.awb")
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play1108407032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 1108407032
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play1108407033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1084ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1084ui_story == nil then
				arg_132_1.var_.characterEffect1084ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect1084ui_story and not isNil(var_135_0) then
					local var_135_4 = Mathf.Lerp(0, 0.5, var_135_3)

					arg_132_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1084ui_story.fillRatio = var_135_4
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1084ui_story then
				local var_135_5 = 0.5

				arg_132_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1084ui_story.fillRatio = var_135_5
			end

			local var_135_6 = 0
			local var_135_7 = 0.525

			if var_135_6 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_8 = arg_132_1:FormatText(StoryNameCfg[7].name)

				arg_132_1.leftNameTxt_.text = var_135_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_9 = arg_132_1:GetWordFromCfg(1108407032)
				local var_135_10 = arg_132_1:FormatText(var_135_9.content)

				arg_132_1.text_.text = var_135_10

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_11 = 21
				local var_135_12 = utf8.len(var_135_10)
				local var_135_13 = var_135_11 <= 0 and var_135_7 or var_135_7 * (var_135_12 / var_135_11)

				if var_135_13 > 0 and var_135_7 < var_135_13 then
					arg_132_1.talkMaxDuration = var_135_13

					if var_135_13 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_13 + var_135_6
					end
				end

				arg_132_1.text_.text = var_135_10
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_14 = math.max(var_135_7, arg_132_1.talkMaxDuration)

			if var_135_6 <= arg_132_1.time_ and arg_132_1.time_ < var_135_6 + var_135_14 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_6) / var_135_14

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_6 + var_135_14 and arg_132_1.time_ < var_135_6 + var_135_14 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play1108407033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 1108407033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play1108407034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1084ui_story"].transform
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.var_.moveOldPos1084ui_story = var_139_0.localPosition
			end

			local var_139_2 = 0.001

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2
				local var_139_4 = Vector3.New(0, 100, 0)

				var_139_0.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1084ui_story, var_139_4, var_139_3)

				local var_139_5 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_5.x, var_139_5.y, var_139_5.z)

				local var_139_6 = var_139_0.localEulerAngles

				var_139_6.z = 0
				var_139_6.x = 0
				var_139_0.localEulerAngles = var_139_6
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 then
				var_139_0.localPosition = Vector3.New(0, 100, 0)

				local var_139_7 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_7.x, var_139_7.y, var_139_7.z)

				local var_139_8 = var_139_0.localEulerAngles

				var_139_8.z = 0
				var_139_8.x = 0
				var_139_0.localEulerAngles = var_139_8
			end

			local var_139_9 = 0
			local var_139_10 = 1.525

			if var_139_9 < arg_136_1.time_ and arg_136_1.time_ <= var_139_9 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_11 = arg_136_1:GetWordFromCfg(1108407033)
				local var_139_12 = arg_136_1:FormatText(var_139_11.content)

				arg_136_1.text_.text = var_139_12

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_13 = 61
				local var_139_14 = utf8.len(var_139_12)
				local var_139_15 = var_139_13 <= 0 and var_139_10 or var_139_10 * (var_139_14 / var_139_13)

				if var_139_15 > 0 and var_139_10 < var_139_15 then
					arg_136_1.talkMaxDuration = var_139_15

					if var_139_15 + var_139_9 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_15 + var_139_9
					end
				end

				arg_136_1.text_.text = var_139_12
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_16 = math.max(var_139_10, arg_136_1.talkMaxDuration)

			if var_139_9 <= arg_136_1.time_ and arg_136_1.time_ < var_139_9 + var_139_16 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_9) / var_139_16

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_9 + var_139_16 and arg_136_1.time_ < var_139_9 + var_139_16 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play1108407034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 1108407034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play1108407035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0
			local var_143_1 = 1.025

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_2 = arg_140_1:GetWordFromCfg(1108407034)
				local var_143_3 = arg_140_1:FormatText(var_143_2.content)

				arg_140_1.text_.text = var_143_3

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_4 = 41
				local var_143_5 = utf8.len(var_143_3)
				local var_143_6 = var_143_4 <= 0 and var_143_1 or var_143_1 * (var_143_5 / var_143_4)

				if var_143_6 > 0 and var_143_1 < var_143_6 then
					arg_140_1.talkMaxDuration = var_143_6

					if var_143_6 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_6 + var_143_0
					end
				end

				arg_140_1.text_.text = var_143_3
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_7 = math.max(var_143_1, arg_140_1.talkMaxDuration)

			if var_143_0 <= arg_140_1.time_ and arg_140_1.time_ < var_143_0 + var_143_7 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_0) / var_143_7

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_0 + var_143_7 and arg_140_1.time_ < var_143_0 + var_143_7 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play1108407035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 1108407035
		arg_144_1.duration_ = 9.17

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play1108407036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1084ui_story"].transform
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.var_.moveOldPos1084ui_story = var_147_0.localPosition
			end

			local var_147_2 = 0.001

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2
				local var_147_4 = Vector3.New(0, -0.97, -6)

				var_147_0.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1084ui_story, var_147_4, var_147_3)

				local var_147_5 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_5.x, var_147_5.y, var_147_5.z)

				local var_147_6 = var_147_0.localEulerAngles

				var_147_6.z = 0
				var_147_6.x = 0
				var_147_0.localEulerAngles = var_147_6
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 then
				var_147_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_147_7 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_7.x, var_147_7.y, var_147_7.z)

				local var_147_8 = var_147_0.localEulerAngles

				var_147_8.z = 0
				var_147_8.x = 0
				var_147_0.localEulerAngles = var_147_8
			end

			local var_147_9 = arg_144_1.actors_["1084ui_story"]
			local var_147_10 = 0

			if var_147_10 < arg_144_1.time_ and arg_144_1.time_ <= var_147_10 + arg_147_0 and not isNil(var_147_9) and arg_144_1.var_.characterEffect1084ui_story == nil then
				arg_144_1.var_.characterEffect1084ui_story = var_147_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_11 = 0.200000002980232

			if var_147_10 <= arg_144_1.time_ and arg_144_1.time_ < var_147_10 + var_147_11 and not isNil(var_147_9) then
				local var_147_12 = (arg_144_1.time_ - var_147_10) / var_147_11

				if arg_144_1.var_.characterEffect1084ui_story and not isNil(var_147_9) then
					arg_144_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_10 + var_147_11 and arg_144_1.time_ < var_147_10 + var_147_11 + arg_147_0 and not isNil(var_147_9) and arg_144_1.var_.characterEffect1084ui_story then
				arg_144_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_147_13 = 0

			if var_147_13 < arg_144_1.time_ and arg_144_1.time_ <= var_147_13 + arg_147_0 then
				arg_144_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_147_14 = 0

			if var_147_14 < arg_144_1.time_ and arg_144_1.time_ <= var_147_14 + arg_147_0 then
				arg_144_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_147_15 = 0
			local var_147_16 = 1.25

			if var_147_15 < arg_144_1.time_ and arg_144_1.time_ <= var_147_15 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_17 = arg_144_1:FormatText(StoryNameCfg[6].name)

				arg_144_1.leftNameTxt_.text = var_147_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_18 = arg_144_1:GetWordFromCfg(1108407035)
				local var_147_19 = arg_144_1:FormatText(var_147_18.content)

				arg_144_1.text_.text = var_147_19

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_20 = 50
				local var_147_21 = utf8.len(var_147_19)
				local var_147_22 = var_147_20 <= 0 and var_147_16 or var_147_16 * (var_147_21 / var_147_20)

				if var_147_22 > 0 and var_147_16 < var_147_22 then
					arg_144_1.talkMaxDuration = var_147_22

					if var_147_22 + var_147_15 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_22 + var_147_15
					end
				end

				arg_144_1.text_.text = var_147_19
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407035", "story_v_side_new_1108407.awb") ~= 0 then
					local var_147_23 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407035", "story_v_side_new_1108407.awb") / 1000

					if var_147_23 + var_147_15 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_23 + var_147_15
					end

					if var_147_18.prefab_name ~= "" and arg_144_1.actors_[var_147_18.prefab_name] ~= nil then
						local var_147_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_18.prefab_name].transform, "story_v_side_new_1108407", "1108407035", "story_v_side_new_1108407.awb")

						arg_144_1:RecordAudio("1108407035", var_147_24)
						arg_144_1:RecordAudio("1108407035", var_147_24)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407035", "story_v_side_new_1108407.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407035", "story_v_side_new_1108407.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_25 = math.max(var_147_16, arg_144_1.talkMaxDuration)

			if var_147_15 <= arg_144_1.time_ and arg_144_1.time_ < var_147_15 + var_147_25 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_15) / var_147_25

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_15 + var_147_25 and arg_144_1.time_ < var_147_15 + var_147_25 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play1108407036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 1108407036
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play1108407037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1084ui_story"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1084ui_story == nil then
				arg_148_1.var_.characterEffect1084ui_story = var_151_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.200000002980232

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.characterEffect1084ui_story and not isNil(var_151_0) then
					local var_151_4 = Mathf.Lerp(0, 0.5, var_151_3)

					arg_148_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1084ui_story.fillRatio = var_151_4
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1084ui_story then
				local var_151_5 = 0.5

				arg_148_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1084ui_story.fillRatio = var_151_5
			end

			local var_151_6 = 0
			local var_151_7 = 0.675

			if var_151_6 < arg_148_1.time_ and arg_148_1.time_ <= var_151_6 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_8 = arg_148_1:FormatText(StoryNameCfg[7].name)

				arg_148_1.leftNameTxt_.text = var_151_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_9 = arg_148_1:GetWordFromCfg(1108407036)
				local var_151_10 = arg_148_1:FormatText(var_151_9.content)

				arg_148_1.text_.text = var_151_10

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_11 = 27
				local var_151_12 = utf8.len(var_151_10)
				local var_151_13 = var_151_11 <= 0 and var_151_7 or var_151_7 * (var_151_12 / var_151_11)

				if var_151_13 > 0 and var_151_7 < var_151_13 then
					arg_148_1.talkMaxDuration = var_151_13

					if var_151_13 + var_151_6 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_13 + var_151_6
					end
				end

				arg_148_1.text_.text = var_151_10
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_14 = math.max(var_151_7, arg_148_1.talkMaxDuration)

			if var_151_6 <= arg_148_1.time_ and arg_148_1.time_ < var_151_6 + var_151_14 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_6) / var_151_14

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_6 + var_151_14 and arg_148_1.time_ < var_151_6 + var_151_14 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play1108407037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 1108407037
		arg_152_1.duration_ = 2.73

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play1108407038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1084ui_story"].transform
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.var_.moveOldPos1084ui_story = var_155_0.localPosition
			end

			local var_155_2 = 0.001

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2
				local var_155_4 = Vector3.New(0, -0.97, -6)

				var_155_0.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1084ui_story, var_155_4, var_155_3)

				local var_155_5 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_5.x, var_155_5.y, var_155_5.z)

				local var_155_6 = var_155_0.localEulerAngles

				var_155_6.z = 0
				var_155_6.x = 0
				var_155_0.localEulerAngles = var_155_6
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 then
				var_155_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_155_7 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_7.x, var_155_7.y, var_155_7.z)

				local var_155_8 = var_155_0.localEulerAngles

				var_155_8.z = 0
				var_155_8.x = 0
				var_155_0.localEulerAngles = var_155_8
			end

			local var_155_9 = arg_152_1.actors_["1084ui_story"]
			local var_155_10 = 0

			if var_155_10 < arg_152_1.time_ and arg_152_1.time_ <= var_155_10 + arg_155_0 and not isNil(var_155_9) and arg_152_1.var_.characterEffect1084ui_story == nil then
				arg_152_1.var_.characterEffect1084ui_story = var_155_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_11 = 0.200000002980232

			if var_155_10 <= arg_152_1.time_ and arg_152_1.time_ < var_155_10 + var_155_11 and not isNil(var_155_9) then
				local var_155_12 = (arg_152_1.time_ - var_155_10) / var_155_11

				if arg_152_1.var_.characterEffect1084ui_story and not isNil(var_155_9) then
					arg_152_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_10 + var_155_11 and arg_152_1.time_ < var_155_10 + var_155_11 + arg_155_0 and not isNil(var_155_9) and arg_152_1.var_.characterEffect1084ui_story then
				arg_152_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_155_13 = 0

			if var_155_13 < arg_152_1.time_ and arg_152_1.time_ <= var_155_13 + arg_155_0 then
				arg_152_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_155_14 = 0

			if var_155_14 < arg_152_1.time_ and arg_152_1.time_ <= var_155_14 + arg_155_0 then
				arg_152_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_155_15 = 0
			local var_155_16 = 0.225

			if var_155_15 < arg_152_1.time_ and arg_152_1.time_ <= var_155_15 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_17 = arg_152_1:FormatText(StoryNameCfg[6].name)

				arg_152_1.leftNameTxt_.text = var_155_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_18 = arg_152_1:GetWordFromCfg(1108407037)
				local var_155_19 = arg_152_1:FormatText(var_155_18.content)

				arg_152_1.text_.text = var_155_19

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_20 = 9
				local var_155_21 = utf8.len(var_155_19)
				local var_155_22 = var_155_20 <= 0 and var_155_16 or var_155_16 * (var_155_21 / var_155_20)

				if var_155_22 > 0 and var_155_16 < var_155_22 then
					arg_152_1.talkMaxDuration = var_155_22

					if var_155_22 + var_155_15 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_22 + var_155_15
					end
				end

				arg_152_1.text_.text = var_155_19
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407037", "story_v_side_new_1108407.awb") ~= 0 then
					local var_155_23 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407037", "story_v_side_new_1108407.awb") / 1000

					if var_155_23 + var_155_15 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_23 + var_155_15
					end

					if var_155_18.prefab_name ~= "" and arg_152_1.actors_[var_155_18.prefab_name] ~= nil then
						local var_155_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_18.prefab_name].transform, "story_v_side_new_1108407", "1108407037", "story_v_side_new_1108407.awb")

						arg_152_1:RecordAudio("1108407037", var_155_24)
						arg_152_1:RecordAudio("1108407037", var_155_24)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407037", "story_v_side_new_1108407.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407037", "story_v_side_new_1108407.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_25 = math.max(var_155_16, arg_152_1.talkMaxDuration)

			if var_155_15 <= arg_152_1.time_ and arg_152_1.time_ < var_155_15 + var_155_25 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_15) / var_155_25

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_15 + var_155_25 and arg_152_1.time_ < var_155_15 + var_155_25 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play1108407038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 1108407038
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play1108407039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1084ui_story"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1084ui_story == nil then
				arg_156_1.var_.characterEffect1084ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect1084ui_story and not isNil(var_159_0) then
					local var_159_4 = Mathf.Lerp(0, 0.5, var_159_3)

					arg_156_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1084ui_story.fillRatio = var_159_4
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1084ui_story then
				local var_159_5 = 0.5

				arg_156_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1084ui_story.fillRatio = var_159_5
			end

			local var_159_6 = 0
			local var_159_7 = 0.85

			if var_159_6 < arg_156_1.time_ and arg_156_1.time_ <= var_159_6 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_8 = arg_156_1:FormatText(StoryNameCfg[7].name)

				arg_156_1.leftNameTxt_.text = var_159_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_9 = arg_156_1:GetWordFromCfg(1108407038)
				local var_159_10 = arg_156_1:FormatText(var_159_9.content)

				arg_156_1.text_.text = var_159_10

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_11 = 34
				local var_159_12 = utf8.len(var_159_10)
				local var_159_13 = var_159_11 <= 0 and var_159_7 or var_159_7 * (var_159_12 / var_159_11)

				if var_159_13 > 0 and var_159_7 < var_159_13 then
					arg_156_1.talkMaxDuration = var_159_13

					if var_159_13 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_13 + var_159_6
					end
				end

				arg_156_1.text_.text = var_159_10
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_14 = math.max(var_159_7, arg_156_1.talkMaxDuration)

			if var_159_6 <= arg_156_1.time_ and arg_156_1.time_ < var_159_6 + var_159_14 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_6) / var_159_14

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_6 + var_159_14 and arg_156_1.time_ < var_159_6 + var_159_14 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play1108407039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 1108407039
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play1108407040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1084ui_story"].transform
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.var_.moveOldPos1084ui_story = var_163_0.localPosition
			end

			local var_163_2 = 0.001

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2
				local var_163_4 = Vector3.New(0, 100, 0)

				var_163_0.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1084ui_story, var_163_4, var_163_3)

				local var_163_5 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_5.x, var_163_5.y, var_163_5.z)

				local var_163_6 = var_163_0.localEulerAngles

				var_163_6.z = 0
				var_163_6.x = 0
				var_163_0.localEulerAngles = var_163_6
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 then
				var_163_0.localPosition = Vector3.New(0, 100, 0)

				local var_163_7 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_7.x, var_163_7.y, var_163_7.z)

				local var_163_8 = var_163_0.localEulerAngles

				var_163_8.z = 0
				var_163_8.x = 0
				var_163_0.localEulerAngles = var_163_8
			end

			local var_163_9 = 0
			local var_163_10 = 0.8

			if var_163_9 < arg_160_1.time_ and arg_160_1.time_ <= var_163_9 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_11 = arg_160_1:GetWordFromCfg(1108407039)
				local var_163_12 = arg_160_1:FormatText(var_163_11.content)

				arg_160_1.text_.text = var_163_12

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_13 = 32
				local var_163_14 = utf8.len(var_163_12)
				local var_163_15 = var_163_13 <= 0 and var_163_10 or var_163_10 * (var_163_14 / var_163_13)

				if var_163_15 > 0 and var_163_10 < var_163_15 then
					arg_160_1.talkMaxDuration = var_163_15

					if var_163_15 + var_163_9 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_15 + var_163_9
					end
				end

				arg_160_1.text_.text = var_163_12
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_16 = math.max(var_163_10, arg_160_1.talkMaxDuration)

			if var_163_9 <= arg_160_1.time_ and arg_160_1.time_ < var_163_9 + var_163_16 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_9) / var_163_16

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_9 + var_163_16 and arg_160_1.time_ < var_163_9 + var_163_16 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play1108407040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 1108407040
		arg_164_1.duration_ = 4.43

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play1108407041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1084ui_story"].transform
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.var_.moveOldPos1084ui_story = var_167_0.localPosition
			end

			local var_167_2 = 0.001

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2
				local var_167_4 = Vector3.New(0, -0.97, -6)

				var_167_0.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1084ui_story, var_167_4, var_167_3)

				local var_167_5 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_5.x, var_167_5.y, var_167_5.z)

				local var_167_6 = var_167_0.localEulerAngles

				var_167_6.z = 0
				var_167_6.x = 0
				var_167_0.localEulerAngles = var_167_6
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 then
				var_167_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_167_7 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_7.x, var_167_7.y, var_167_7.z)

				local var_167_8 = var_167_0.localEulerAngles

				var_167_8.z = 0
				var_167_8.x = 0
				var_167_0.localEulerAngles = var_167_8
			end

			local var_167_9 = arg_164_1.actors_["1084ui_story"]
			local var_167_10 = 0

			if var_167_10 < arg_164_1.time_ and arg_164_1.time_ <= var_167_10 + arg_167_0 and not isNil(var_167_9) and arg_164_1.var_.characterEffect1084ui_story == nil then
				arg_164_1.var_.characterEffect1084ui_story = var_167_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_11 = 0.200000002980232

			if var_167_10 <= arg_164_1.time_ and arg_164_1.time_ < var_167_10 + var_167_11 and not isNil(var_167_9) then
				local var_167_12 = (arg_164_1.time_ - var_167_10) / var_167_11

				if arg_164_1.var_.characterEffect1084ui_story and not isNil(var_167_9) then
					arg_164_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_10 + var_167_11 and arg_164_1.time_ < var_167_10 + var_167_11 + arg_167_0 and not isNil(var_167_9) and arg_164_1.var_.characterEffect1084ui_story then
				arg_164_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_167_13 = 0

			if var_167_13 < arg_164_1.time_ and arg_164_1.time_ <= var_167_13 + arg_167_0 then
				arg_164_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_167_14 = 0

			if var_167_14 < arg_164_1.time_ and arg_164_1.time_ <= var_167_14 + arg_167_0 then
				arg_164_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_167_15 = 0
			local var_167_16 = 0.55

			if var_167_15 < arg_164_1.time_ and arg_164_1.time_ <= var_167_15 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_17 = arg_164_1:FormatText(StoryNameCfg[6].name)

				arg_164_1.leftNameTxt_.text = var_167_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_18 = arg_164_1:GetWordFromCfg(1108407040)
				local var_167_19 = arg_164_1:FormatText(var_167_18.content)

				arg_164_1.text_.text = var_167_19

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_20 = 22
				local var_167_21 = utf8.len(var_167_19)
				local var_167_22 = var_167_20 <= 0 and var_167_16 or var_167_16 * (var_167_21 / var_167_20)

				if var_167_22 > 0 and var_167_16 < var_167_22 then
					arg_164_1.talkMaxDuration = var_167_22

					if var_167_22 + var_167_15 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_22 + var_167_15
					end
				end

				arg_164_1.text_.text = var_167_19
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407040", "story_v_side_new_1108407.awb") ~= 0 then
					local var_167_23 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407040", "story_v_side_new_1108407.awb") / 1000

					if var_167_23 + var_167_15 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_23 + var_167_15
					end

					if var_167_18.prefab_name ~= "" and arg_164_1.actors_[var_167_18.prefab_name] ~= nil then
						local var_167_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_18.prefab_name].transform, "story_v_side_new_1108407", "1108407040", "story_v_side_new_1108407.awb")

						arg_164_1:RecordAudio("1108407040", var_167_24)
						arg_164_1:RecordAudio("1108407040", var_167_24)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407040", "story_v_side_new_1108407.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407040", "story_v_side_new_1108407.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_25 = math.max(var_167_16, arg_164_1.talkMaxDuration)

			if var_167_15 <= arg_164_1.time_ and arg_164_1.time_ < var_167_15 + var_167_25 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_15) / var_167_25

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_15 + var_167_25 and arg_164_1.time_ < var_167_15 + var_167_25 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play1108407041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 1108407041
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play1108407042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1084ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1084ui_story == nil then
				arg_168_1.var_.characterEffect1084ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect1084ui_story and not isNil(var_171_0) then
					local var_171_4 = Mathf.Lerp(0, 0.5, var_171_3)

					arg_168_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_168_1.var_.characterEffect1084ui_story.fillRatio = var_171_4
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1084ui_story then
				local var_171_5 = 0.5

				arg_168_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_168_1.var_.characterEffect1084ui_story.fillRatio = var_171_5
			end

			local var_171_6 = 0
			local var_171_7 = 0.45

			if var_171_6 < arg_168_1.time_ and arg_168_1.time_ <= var_171_6 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_8 = arg_168_1:FormatText(StoryNameCfg[7].name)

				arg_168_1.leftNameTxt_.text = var_171_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_9 = arg_168_1:GetWordFromCfg(1108407041)
				local var_171_10 = arg_168_1:FormatText(var_171_9.content)

				arg_168_1.text_.text = var_171_10

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_11 = 18
				local var_171_12 = utf8.len(var_171_10)
				local var_171_13 = var_171_11 <= 0 and var_171_7 or var_171_7 * (var_171_12 / var_171_11)

				if var_171_13 > 0 and var_171_7 < var_171_13 then
					arg_168_1.talkMaxDuration = var_171_13

					if var_171_13 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_13 + var_171_6
					end
				end

				arg_168_1.text_.text = var_171_10
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_14 = math.max(var_171_7, arg_168_1.talkMaxDuration)

			if var_171_6 <= arg_168_1.time_ and arg_168_1.time_ < var_171_6 + var_171_14 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_6) / var_171_14

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_6 + var_171_14 and arg_168_1.time_ < var_171_6 + var_171_14 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play1108407042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 1108407042
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play1108407043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1084ui_story"].transform
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.var_.moveOldPos1084ui_story = var_175_0.localPosition
			end

			local var_175_2 = 0.001

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2
				local var_175_4 = Vector3.New(0, 100, 0)

				var_175_0.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1084ui_story, var_175_4, var_175_3)

				local var_175_5 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_5.x, var_175_5.y, var_175_5.z)

				local var_175_6 = var_175_0.localEulerAngles

				var_175_6.z = 0
				var_175_6.x = 0
				var_175_0.localEulerAngles = var_175_6
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 then
				var_175_0.localPosition = Vector3.New(0, 100, 0)

				local var_175_7 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_7.x, var_175_7.y, var_175_7.z)

				local var_175_8 = var_175_0.localEulerAngles

				var_175_8.z = 0
				var_175_8.x = 0
				var_175_0.localEulerAngles = var_175_8
			end

			local var_175_9 = 0
			local var_175_10 = 1.075

			if var_175_9 < arg_172_1.time_ and arg_172_1.time_ <= var_175_9 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_11 = arg_172_1:GetWordFromCfg(1108407042)
				local var_175_12 = arg_172_1:FormatText(var_175_11.content)

				arg_172_1.text_.text = var_175_12

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_13 = 43
				local var_175_14 = utf8.len(var_175_12)
				local var_175_15 = var_175_13 <= 0 and var_175_10 or var_175_10 * (var_175_14 / var_175_13)

				if var_175_15 > 0 and var_175_10 < var_175_15 then
					arg_172_1.talkMaxDuration = var_175_15

					if var_175_15 + var_175_9 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_15 + var_175_9
					end
				end

				arg_172_1.text_.text = var_175_12
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_16 = math.max(var_175_10, arg_172_1.talkMaxDuration)

			if var_175_9 <= arg_172_1.time_ and arg_172_1.time_ < var_175_9 + var_175_16 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_9) / var_175_16

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_9 + var_175_16 and arg_172_1.time_ < var_175_9 + var_175_16 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play1108407043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 1108407043
		arg_176_1.duration_ = 4

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play1108407044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1084ui_story"].transform
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				arg_176_1.var_.moveOldPos1084ui_story = var_179_0.localPosition
			end

			local var_179_2 = 0.001

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2
				local var_179_4 = Vector3.New(0, -0.97, -6)

				var_179_0.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1084ui_story, var_179_4, var_179_3)

				local var_179_5 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_5.x, var_179_5.y, var_179_5.z)

				local var_179_6 = var_179_0.localEulerAngles

				var_179_6.z = 0
				var_179_6.x = 0
				var_179_0.localEulerAngles = var_179_6
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 then
				var_179_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_179_7 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_7.x, var_179_7.y, var_179_7.z)

				local var_179_8 = var_179_0.localEulerAngles

				var_179_8.z = 0
				var_179_8.x = 0
				var_179_0.localEulerAngles = var_179_8
			end

			local var_179_9 = arg_176_1.actors_["1084ui_story"]
			local var_179_10 = 0

			if var_179_10 < arg_176_1.time_ and arg_176_1.time_ <= var_179_10 + arg_179_0 and not isNil(var_179_9) and arg_176_1.var_.characterEffect1084ui_story == nil then
				arg_176_1.var_.characterEffect1084ui_story = var_179_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_11 = 0.200000002980232

			if var_179_10 <= arg_176_1.time_ and arg_176_1.time_ < var_179_10 + var_179_11 and not isNil(var_179_9) then
				local var_179_12 = (arg_176_1.time_ - var_179_10) / var_179_11

				if arg_176_1.var_.characterEffect1084ui_story and not isNil(var_179_9) then
					arg_176_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_10 + var_179_11 and arg_176_1.time_ < var_179_10 + var_179_11 + arg_179_0 and not isNil(var_179_9) and arg_176_1.var_.characterEffect1084ui_story then
				arg_176_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_179_13 = 0

			if var_179_13 < arg_176_1.time_ and arg_176_1.time_ <= var_179_13 + arg_179_0 then
				arg_176_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_179_14 = 0

			if var_179_14 < arg_176_1.time_ and arg_176_1.time_ <= var_179_14 + arg_179_0 then
				arg_176_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_179_15 = 0
			local var_179_16 = 0.4

			if var_179_15 < arg_176_1.time_ and arg_176_1.time_ <= var_179_15 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_17 = arg_176_1:FormatText(StoryNameCfg[6].name)

				arg_176_1.leftNameTxt_.text = var_179_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_18 = arg_176_1:GetWordFromCfg(1108407043)
				local var_179_19 = arg_176_1:FormatText(var_179_18.content)

				arg_176_1.text_.text = var_179_19

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_20 = 16
				local var_179_21 = utf8.len(var_179_19)
				local var_179_22 = var_179_20 <= 0 and var_179_16 or var_179_16 * (var_179_21 / var_179_20)

				if var_179_22 > 0 and var_179_16 < var_179_22 then
					arg_176_1.talkMaxDuration = var_179_22

					if var_179_22 + var_179_15 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_22 + var_179_15
					end
				end

				arg_176_1.text_.text = var_179_19
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407043", "story_v_side_new_1108407.awb") ~= 0 then
					local var_179_23 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407043", "story_v_side_new_1108407.awb") / 1000

					if var_179_23 + var_179_15 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_23 + var_179_15
					end

					if var_179_18.prefab_name ~= "" and arg_176_1.actors_[var_179_18.prefab_name] ~= nil then
						local var_179_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_18.prefab_name].transform, "story_v_side_new_1108407", "1108407043", "story_v_side_new_1108407.awb")

						arg_176_1:RecordAudio("1108407043", var_179_24)
						arg_176_1:RecordAudio("1108407043", var_179_24)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407043", "story_v_side_new_1108407.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407043", "story_v_side_new_1108407.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_25 = math.max(var_179_16, arg_176_1.talkMaxDuration)

			if var_179_15 <= arg_176_1.time_ and arg_176_1.time_ < var_179_15 + var_179_25 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_15) / var_179_25

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_15 + var_179_25 and arg_176_1.time_ < var_179_15 + var_179_25 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play1108407044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 1108407044
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play1108407045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1084ui_story"].transform
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.var_.moveOldPos1084ui_story = var_183_0.localPosition
			end

			local var_183_2 = 0.001

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2
				local var_183_4 = Vector3.New(0, 100, 0)

				var_183_0.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1084ui_story, var_183_4, var_183_3)

				local var_183_5 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_5.x, var_183_5.y, var_183_5.z)

				local var_183_6 = var_183_0.localEulerAngles

				var_183_6.z = 0
				var_183_6.x = 0
				var_183_0.localEulerAngles = var_183_6
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 then
				var_183_0.localPosition = Vector3.New(0, 100, 0)

				local var_183_7 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_7.x, var_183_7.y, var_183_7.z)

				local var_183_8 = var_183_0.localEulerAngles

				var_183_8.z = 0
				var_183_8.x = 0
				var_183_0.localEulerAngles = var_183_8
			end

			local var_183_9 = arg_180_1.actors_["1084ui_story"]
			local var_183_10 = 0

			if var_183_10 < arg_180_1.time_ and arg_180_1.time_ <= var_183_10 + arg_183_0 and not isNil(var_183_9) and arg_180_1.var_.characterEffect1084ui_story == nil then
				arg_180_1.var_.characterEffect1084ui_story = var_183_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_11 = 0.200000002980232

			if var_183_10 <= arg_180_1.time_ and arg_180_1.time_ < var_183_10 + var_183_11 and not isNil(var_183_9) then
				local var_183_12 = (arg_180_1.time_ - var_183_10) / var_183_11

				if arg_180_1.var_.characterEffect1084ui_story and not isNil(var_183_9) then
					local var_183_13 = Mathf.Lerp(0, 0.5, var_183_12)

					arg_180_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1084ui_story.fillRatio = var_183_13
				end
			end

			if arg_180_1.time_ >= var_183_10 + var_183_11 and arg_180_1.time_ < var_183_10 + var_183_11 + arg_183_0 and not isNil(var_183_9) and arg_180_1.var_.characterEffect1084ui_story then
				local var_183_14 = 0.5

				arg_180_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1084ui_story.fillRatio = var_183_14
			end

			local var_183_15 = 0
			local var_183_16 = 0.925

			if var_183_15 < arg_180_1.time_ and arg_180_1.time_ <= var_183_15 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_17 = arg_180_1:GetWordFromCfg(1108407044)
				local var_183_18 = arg_180_1:FormatText(var_183_17.content)

				arg_180_1.text_.text = var_183_18

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_19 = 37
				local var_183_20 = utf8.len(var_183_18)
				local var_183_21 = var_183_19 <= 0 and var_183_16 or var_183_16 * (var_183_20 / var_183_19)

				if var_183_21 > 0 and var_183_16 < var_183_21 then
					arg_180_1.talkMaxDuration = var_183_21

					if var_183_21 + var_183_15 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_21 + var_183_15
					end
				end

				arg_180_1.text_.text = var_183_18
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_22 = math.max(var_183_16, arg_180_1.talkMaxDuration)

			if var_183_15 <= arg_180_1.time_ and arg_180_1.time_ < var_183_15 + var_183_22 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_15) / var_183_22

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_15 + var_183_22 and arg_180_1.time_ < var_183_15 + var_183_22 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play1108407045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 1108407045
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play1108407046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0
			local var_187_1 = 0.375

			if var_187_0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_2 = arg_184_1:FormatText(StoryNameCfg[7].name)

				arg_184_1.leftNameTxt_.text = var_187_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_3 = arg_184_1:GetWordFromCfg(1108407045)
				local var_187_4 = arg_184_1:FormatText(var_187_3.content)

				arg_184_1.text_.text = var_187_4

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_5 = 15
				local var_187_6 = utf8.len(var_187_4)
				local var_187_7 = var_187_5 <= 0 and var_187_1 or var_187_1 * (var_187_6 / var_187_5)

				if var_187_7 > 0 and var_187_1 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_0
					end
				end

				arg_184_1.text_.text = var_187_4
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_8 = math.max(var_187_1, arg_184_1.talkMaxDuration)

			if var_187_0 <= arg_184_1.time_ and arg_184_1.time_ < var_187_0 + var_187_8 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_0) / var_187_8

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_0 + var_187_8 and arg_184_1.time_ < var_187_0 + var_187_8 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play1108407046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 1108407046
		arg_188_1.duration_ = 7.67

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play1108407047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1084ui_story"].transform
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.var_.moveOldPos1084ui_story = var_191_0.localPosition
			end

			local var_191_2 = 0.001

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2
				local var_191_4 = Vector3.New(0, -0.97, -6)

				var_191_0.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1084ui_story, var_191_4, var_191_3)

				local var_191_5 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_5.x, var_191_5.y, var_191_5.z)

				local var_191_6 = var_191_0.localEulerAngles

				var_191_6.z = 0
				var_191_6.x = 0
				var_191_0.localEulerAngles = var_191_6
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 then
				var_191_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_191_7 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_7.x, var_191_7.y, var_191_7.z)

				local var_191_8 = var_191_0.localEulerAngles

				var_191_8.z = 0
				var_191_8.x = 0
				var_191_0.localEulerAngles = var_191_8
			end

			local var_191_9 = arg_188_1.actors_["1084ui_story"]
			local var_191_10 = 0

			if var_191_10 < arg_188_1.time_ and arg_188_1.time_ <= var_191_10 + arg_191_0 and not isNil(var_191_9) and arg_188_1.var_.characterEffect1084ui_story == nil then
				arg_188_1.var_.characterEffect1084ui_story = var_191_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_11 = 0.200000002980232

			if var_191_10 <= arg_188_1.time_ and arg_188_1.time_ < var_191_10 + var_191_11 and not isNil(var_191_9) then
				local var_191_12 = (arg_188_1.time_ - var_191_10) / var_191_11

				if arg_188_1.var_.characterEffect1084ui_story and not isNil(var_191_9) then
					arg_188_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= var_191_10 + var_191_11 and arg_188_1.time_ < var_191_10 + var_191_11 + arg_191_0 and not isNil(var_191_9) and arg_188_1.var_.characterEffect1084ui_story then
				arg_188_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_191_13 = 0

			if var_191_13 < arg_188_1.time_ and arg_188_1.time_ <= var_191_13 + arg_191_0 then
				arg_188_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_191_14 = 0

			if var_191_14 < arg_188_1.time_ and arg_188_1.time_ <= var_191_14 + arg_191_0 then
				arg_188_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_191_15 = 0
			local var_191_16 = 0.9

			if var_191_15 < arg_188_1.time_ and arg_188_1.time_ <= var_191_15 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_17 = arg_188_1:FormatText(StoryNameCfg[6].name)

				arg_188_1.leftNameTxt_.text = var_191_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_18 = arg_188_1:GetWordFromCfg(1108407046)
				local var_191_19 = arg_188_1:FormatText(var_191_18.content)

				arg_188_1.text_.text = var_191_19

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_20 = 36
				local var_191_21 = utf8.len(var_191_19)
				local var_191_22 = var_191_20 <= 0 and var_191_16 or var_191_16 * (var_191_21 / var_191_20)

				if var_191_22 > 0 and var_191_16 < var_191_22 then
					arg_188_1.talkMaxDuration = var_191_22

					if var_191_22 + var_191_15 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_22 + var_191_15
					end
				end

				arg_188_1.text_.text = var_191_19
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407046", "story_v_side_new_1108407.awb") ~= 0 then
					local var_191_23 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407046", "story_v_side_new_1108407.awb") / 1000

					if var_191_23 + var_191_15 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_23 + var_191_15
					end

					if var_191_18.prefab_name ~= "" and arg_188_1.actors_[var_191_18.prefab_name] ~= nil then
						local var_191_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_18.prefab_name].transform, "story_v_side_new_1108407", "1108407046", "story_v_side_new_1108407.awb")

						arg_188_1:RecordAudio("1108407046", var_191_24)
						arg_188_1:RecordAudio("1108407046", var_191_24)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407046", "story_v_side_new_1108407.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407046", "story_v_side_new_1108407.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_25 = math.max(var_191_16, arg_188_1.talkMaxDuration)

			if var_191_15 <= arg_188_1.time_ and arg_188_1.time_ < var_191_15 + var_191_25 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_15) / var_191_25

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_15 + var_191_25 and arg_188_1.time_ < var_191_15 + var_191_25 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play1108407047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 1108407047
		arg_192_1.duration_ = 11.53

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play1108407048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_195_2 = 0
			local var_195_3 = 1.15

			if var_195_2 < arg_192_1.time_ and arg_192_1.time_ <= var_195_2 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_4 = arg_192_1:FormatText(StoryNameCfg[6].name)

				arg_192_1.leftNameTxt_.text = var_195_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_5 = arg_192_1:GetWordFromCfg(1108407047)
				local var_195_6 = arg_192_1:FormatText(var_195_5.content)

				arg_192_1.text_.text = var_195_6

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_7 = 46
				local var_195_8 = utf8.len(var_195_6)
				local var_195_9 = var_195_7 <= 0 and var_195_3 or var_195_3 * (var_195_8 / var_195_7)

				if var_195_9 > 0 and var_195_3 < var_195_9 then
					arg_192_1.talkMaxDuration = var_195_9

					if var_195_9 + var_195_2 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_9 + var_195_2
					end
				end

				arg_192_1.text_.text = var_195_6
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407047", "story_v_side_new_1108407.awb") ~= 0 then
					local var_195_10 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407047", "story_v_side_new_1108407.awb") / 1000

					if var_195_10 + var_195_2 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_10 + var_195_2
					end

					if var_195_5.prefab_name ~= "" and arg_192_1.actors_[var_195_5.prefab_name] ~= nil then
						local var_195_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_5.prefab_name].transform, "story_v_side_new_1108407", "1108407047", "story_v_side_new_1108407.awb")

						arg_192_1:RecordAudio("1108407047", var_195_11)
						arg_192_1:RecordAudio("1108407047", var_195_11)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407047", "story_v_side_new_1108407.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407047", "story_v_side_new_1108407.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_12 = math.max(var_195_3, arg_192_1.talkMaxDuration)

			if var_195_2 <= arg_192_1.time_ and arg_192_1.time_ < var_195_2 + var_195_12 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_2) / var_195_12

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_2 + var_195_12 and arg_192_1.time_ < var_195_2 + var_195_12 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play1108407048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 1108407048
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play1108407049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["1084ui_story"]
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.characterEffect1084ui_story == nil then
				arg_196_1.var_.characterEffect1084ui_story = var_199_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_2 = 0.200000002980232

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 and not isNil(var_199_0) then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2

				if arg_196_1.var_.characterEffect1084ui_story and not isNil(var_199_0) then
					local var_199_4 = Mathf.Lerp(0, 0.5, var_199_3)

					arg_196_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_196_1.var_.characterEffect1084ui_story.fillRatio = var_199_4
				end
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.characterEffect1084ui_story then
				local var_199_5 = 0.5

				arg_196_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_196_1.var_.characterEffect1084ui_story.fillRatio = var_199_5
			end

			local var_199_6 = 0
			local var_199_7 = 2

			if var_199_6 < arg_196_1.time_ and arg_196_1.time_ <= var_199_6 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_8 = arg_196_1:FormatText(StoryNameCfg[7].name)

				arg_196_1.leftNameTxt_.text = var_199_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, true)
				arg_196_1.iconController_:SetSelectedState("hero")

				arg_196_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_196_1.callingController_:SetSelectedState("normal")

				arg_196_1.keyicon_.color = Color.New(1, 1, 1)
				arg_196_1.icon_.color = Color.New(1, 1, 1)

				local var_199_9 = arg_196_1:GetWordFromCfg(1108407048)
				local var_199_10 = arg_196_1:FormatText(var_199_9.content)

				arg_196_1.text_.text = var_199_10

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_11 = 80
				local var_199_12 = utf8.len(var_199_10)
				local var_199_13 = var_199_11 <= 0 and var_199_7 or var_199_7 * (var_199_12 / var_199_11)

				if var_199_13 > 0 and var_199_7 < var_199_13 then
					arg_196_1.talkMaxDuration = var_199_13

					if var_199_13 + var_199_6 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_13 + var_199_6
					end
				end

				arg_196_1.text_.text = var_199_10
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_14 = math.max(var_199_7, arg_196_1.talkMaxDuration)

			if var_199_6 <= arg_196_1.time_ and arg_196_1.time_ < var_199_6 + var_199_14 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_6) / var_199_14

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_6 + var_199_14 and arg_196_1.time_ < var_199_6 + var_199_14 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play1108407049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 1108407049
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play1108407050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0
			local var_203_1 = 1.475

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_2 = arg_200_1:FormatText(StoryNameCfg[7].name)

				arg_200_1.leftNameTxt_.text = var_203_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_3 = arg_200_1:GetWordFromCfg(1108407049)
				local var_203_4 = arg_200_1:FormatText(var_203_3.content)

				arg_200_1.text_.text = var_203_4

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_5 = 59
				local var_203_6 = utf8.len(var_203_4)
				local var_203_7 = var_203_5 <= 0 and var_203_1 or var_203_1 * (var_203_6 / var_203_5)

				if var_203_7 > 0 and var_203_1 < var_203_7 then
					arg_200_1.talkMaxDuration = var_203_7

					if var_203_7 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_7 + var_203_0
					end
				end

				arg_200_1.text_.text = var_203_4
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_8 = math.max(var_203_1, arg_200_1.talkMaxDuration)

			if var_203_0 <= arg_200_1.time_ and arg_200_1.time_ < var_203_0 + var_203_8 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_0) / var_203_8

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_0 + var_203_8 and arg_200_1.time_ < var_203_0 + var_203_8 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play1108407050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 1108407050
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play1108407051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1084ui_story"].transform
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 then
				arg_204_1.var_.moveOldPos1084ui_story = var_207_0.localPosition
			end

			local var_207_2 = 0.001

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2
				local var_207_4 = Vector3.New(0, 100, 0)

				var_207_0.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1084ui_story, var_207_4, var_207_3)

				local var_207_5 = manager.ui.mainCamera.transform.position - var_207_0.position

				var_207_0.forward = Vector3.New(var_207_5.x, var_207_5.y, var_207_5.z)

				local var_207_6 = var_207_0.localEulerAngles

				var_207_6.z = 0
				var_207_6.x = 0
				var_207_0.localEulerAngles = var_207_6
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 then
				var_207_0.localPosition = Vector3.New(0, 100, 0)

				local var_207_7 = manager.ui.mainCamera.transform.position - var_207_0.position

				var_207_0.forward = Vector3.New(var_207_7.x, var_207_7.y, var_207_7.z)

				local var_207_8 = var_207_0.localEulerAngles

				var_207_8.z = 0
				var_207_8.x = 0
				var_207_0.localEulerAngles = var_207_8
			end

			local var_207_9 = 0
			local var_207_10 = 1.4

			if var_207_9 < arg_204_1.time_ and arg_204_1.time_ <= var_207_9 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_11 = arg_204_1:GetWordFromCfg(1108407050)
				local var_207_12 = arg_204_1:FormatText(var_207_11.content)

				arg_204_1.text_.text = var_207_12

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_13 = 56
				local var_207_14 = utf8.len(var_207_12)
				local var_207_15 = var_207_13 <= 0 and var_207_10 or var_207_10 * (var_207_14 / var_207_13)

				if var_207_15 > 0 and var_207_10 < var_207_15 then
					arg_204_1.talkMaxDuration = var_207_15

					if var_207_15 + var_207_9 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_15 + var_207_9
					end
				end

				arg_204_1.text_.text = var_207_12
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_16 = math.max(var_207_10, arg_204_1.talkMaxDuration)

			if var_207_9 <= arg_204_1.time_ and arg_204_1.time_ < var_207_9 + var_207_16 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_9) / var_207_16

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_9 + var_207_16 and arg_204_1.time_ < var_207_9 + var_207_16 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play1108407051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 1108407051
		arg_208_1.duration_ = 5.77

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play1108407052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["1084ui_story"].transform
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.var_.moveOldPos1084ui_story = var_211_0.localPosition
			end

			local var_211_2 = 0.001

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2
				local var_211_4 = Vector3.New(0, -0.97, -6)

				var_211_0.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1084ui_story, var_211_4, var_211_3)

				local var_211_5 = manager.ui.mainCamera.transform.position - var_211_0.position

				var_211_0.forward = Vector3.New(var_211_5.x, var_211_5.y, var_211_5.z)

				local var_211_6 = var_211_0.localEulerAngles

				var_211_6.z = 0
				var_211_6.x = 0
				var_211_0.localEulerAngles = var_211_6
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 then
				var_211_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_211_7 = manager.ui.mainCamera.transform.position - var_211_0.position

				var_211_0.forward = Vector3.New(var_211_7.x, var_211_7.y, var_211_7.z)

				local var_211_8 = var_211_0.localEulerAngles

				var_211_8.z = 0
				var_211_8.x = 0
				var_211_0.localEulerAngles = var_211_8
			end

			local var_211_9 = arg_208_1.actors_["1084ui_story"]
			local var_211_10 = 0

			if var_211_10 < arg_208_1.time_ and arg_208_1.time_ <= var_211_10 + arg_211_0 and not isNil(var_211_9) and arg_208_1.var_.characterEffect1084ui_story == nil then
				arg_208_1.var_.characterEffect1084ui_story = var_211_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_11 = 0.200000002980232

			if var_211_10 <= arg_208_1.time_ and arg_208_1.time_ < var_211_10 + var_211_11 and not isNil(var_211_9) then
				local var_211_12 = (arg_208_1.time_ - var_211_10) / var_211_11

				if arg_208_1.var_.characterEffect1084ui_story and not isNil(var_211_9) then
					arg_208_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= var_211_10 + var_211_11 and arg_208_1.time_ < var_211_10 + var_211_11 + arg_211_0 and not isNil(var_211_9) and arg_208_1.var_.characterEffect1084ui_story then
				arg_208_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_211_13 = 0

			if var_211_13 < arg_208_1.time_ and arg_208_1.time_ <= var_211_13 + arg_211_0 then
				arg_208_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_211_14 = 0

			if var_211_14 < arg_208_1.time_ and arg_208_1.time_ <= var_211_14 + arg_211_0 then
				arg_208_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_211_15 = 0
			local var_211_16 = 0.575

			if var_211_15 < arg_208_1.time_ and arg_208_1.time_ <= var_211_15 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_17 = arg_208_1:FormatText(StoryNameCfg[6].name)

				arg_208_1.leftNameTxt_.text = var_211_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_18 = arg_208_1:GetWordFromCfg(1108407051)
				local var_211_19 = arg_208_1:FormatText(var_211_18.content)

				arg_208_1.text_.text = var_211_19

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_20 = 23
				local var_211_21 = utf8.len(var_211_19)
				local var_211_22 = var_211_20 <= 0 and var_211_16 or var_211_16 * (var_211_21 / var_211_20)

				if var_211_22 > 0 and var_211_16 < var_211_22 then
					arg_208_1.talkMaxDuration = var_211_22

					if var_211_22 + var_211_15 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_22 + var_211_15
					end
				end

				arg_208_1.text_.text = var_211_19
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407051", "story_v_side_new_1108407.awb") ~= 0 then
					local var_211_23 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407051", "story_v_side_new_1108407.awb") / 1000

					if var_211_23 + var_211_15 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_23 + var_211_15
					end

					if var_211_18.prefab_name ~= "" and arg_208_1.actors_[var_211_18.prefab_name] ~= nil then
						local var_211_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_18.prefab_name].transform, "story_v_side_new_1108407", "1108407051", "story_v_side_new_1108407.awb")

						arg_208_1:RecordAudio("1108407051", var_211_24)
						arg_208_1:RecordAudio("1108407051", var_211_24)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407051", "story_v_side_new_1108407.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407051", "story_v_side_new_1108407.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_25 = math.max(var_211_16, arg_208_1.talkMaxDuration)

			if var_211_15 <= arg_208_1.time_ and arg_208_1.time_ < var_211_15 + var_211_25 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_15) / var_211_25

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_15 + var_211_25 and arg_208_1.time_ < var_211_15 + var_211_25 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play1108407052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 1108407052
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play1108407053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["1084ui_story"]
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1084ui_story == nil then
				arg_212_1.var_.characterEffect1084ui_story = var_215_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_2 = 0.200000002980232

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 and not isNil(var_215_0) then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2

				if arg_212_1.var_.characterEffect1084ui_story and not isNil(var_215_0) then
					local var_215_4 = Mathf.Lerp(0, 0.5, var_215_3)

					arg_212_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_212_1.var_.characterEffect1084ui_story.fillRatio = var_215_4
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1084ui_story then
				local var_215_5 = 0.5

				arg_212_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_212_1.var_.characterEffect1084ui_story.fillRatio = var_215_5
			end

			local var_215_6 = 0
			local var_215_7 = 1.425

			if var_215_6 < arg_212_1.time_ and arg_212_1.time_ <= var_215_6 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_8 = arg_212_1:FormatText(StoryNameCfg[7].name)

				arg_212_1.leftNameTxt_.text = var_215_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, true)
				arg_212_1.iconController_:SetSelectedState("hero")

				arg_212_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_212_1.callingController_:SetSelectedState("normal")

				arg_212_1.keyicon_.color = Color.New(1, 1, 1)
				arg_212_1.icon_.color = Color.New(1, 1, 1)

				local var_215_9 = arg_212_1:GetWordFromCfg(1108407052)
				local var_215_10 = arg_212_1:FormatText(var_215_9.content)

				arg_212_1.text_.text = var_215_10

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_11 = 57
				local var_215_12 = utf8.len(var_215_10)
				local var_215_13 = var_215_11 <= 0 and var_215_7 or var_215_7 * (var_215_12 / var_215_11)

				if var_215_13 > 0 and var_215_7 < var_215_13 then
					arg_212_1.talkMaxDuration = var_215_13

					if var_215_13 + var_215_6 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_13 + var_215_6
					end
				end

				arg_212_1.text_.text = var_215_10
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_14 = math.max(var_215_7, arg_212_1.talkMaxDuration)

			if var_215_6 <= arg_212_1.time_ and arg_212_1.time_ < var_215_6 + var_215_14 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_6) / var_215_14

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_6 + var_215_14 and arg_212_1.time_ < var_215_6 + var_215_14 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play1108407053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 1108407053
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play1108407054(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 0
			local var_219_1 = 1.275

			if var_219_0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_2 = arg_216_1:FormatText(StoryNameCfg[7].name)

				arg_216_1.leftNameTxt_.text = var_219_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, true)
				arg_216_1.iconController_:SetSelectedState("hero")

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_3 = arg_216_1:GetWordFromCfg(1108407053)
				local var_219_4 = arg_216_1:FormatText(var_219_3.content)

				arg_216_1.text_.text = var_219_4

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_5 = 51
				local var_219_6 = utf8.len(var_219_4)
				local var_219_7 = var_219_5 <= 0 and var_219_1 or var_219_1 * (var_219_6 / var_219_5)

				if var_219_7 > 0 and var_219_1 < var_219_7 then
					arg_216_1.talkMaxDuration = var_219_7

					if var_219_7 + var_219_0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_7 + var_219_0
					end
				end

				arg_216_1.text_.text = var_219_4
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_8 = math.max(var_219_1, arg_216_1.talkMaxDuration)

			if var_219_0 <= arg_216_1.time_ and arg_216_1.time_ < var_219_0 + var_219_8 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_0) / var_219_8

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_0 + var_219_8 and arg_216_1.time_ < var_219_0 + var_219_8 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play1108407054 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 1108407054
		arg_220_1.duration_ = 1.13

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play1108407055(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["1084ui_story"]
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect1084ui_story == nil then
				arg_220_1.var_.characterEffect1084ui_story = var_223_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_2 = 0.200000002980232

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 and not isNil(var_223_0) then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2

				if arg_220_1.var_.characterEffect1084ui_story and not isNil(var_223_0) then
					arg_220_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect1084ui_story then
				arg_220_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_223_4 = 0

			if var_223_4 < arg_220_1.time_ and arg_220_1.time_ <= var_223_4 + arg_223_0 then
				arg_220_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_223_5 = 0

			if var_223_5 < arg_220_1.time_ and arg_220_1.time_ <= var_223_5 + arg_223_0 then
				arg_220_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_223_6 = 0
			local var_223_7 = 0.075

			if var_223_6 < arg_220_1.time_ and arg_220_1.time_ <= var_223_6 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_8 = arg_220_1:FormatText(StoryNameCfg[6].name)

				arg_220_1.leftNameTxt_.text = var_223_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_9 = arg_220_1:GetWordFromCfg(1108407054)
				local var_223_10 = arg_220_1:FormatText(var_223_9.content)

				arg_220_1.text_.text = var_223_10

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_11 = 3
				local var_223_12 = utf8.len(var_223_10)
				local var_223_13 = var_223_11 <= 0 and var_223_7 or var_223_7 * (var_223_12 / var_223_11)

				if var_223_13 > 0 and var_223_7 < var_223_13 then
					arg_220_1.talkMaxDuration = var_223_13

					if var_223_13 + var_223_6 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_13 + var_223_6
					end
				end

				arg_220_1.text_.text = var_223_10
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407054", "story_v_side_new_1108407.awb") ~= 0 then
					local var_223_14 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407054", "story_v_side_new_1108407.awb") / 1000

					if var_223_14 + var_223_6 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_14 + var_223_6
					end

					if var_223_9.prefab_name ~= "" and arg_220_1.actors_[var_223_9.prefab_name] ~= nil then
						local var_223_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_9.prefab_name].transform, "story_v_side_new_1108407", "1108407054", "story_v_side_new_1108407.awb")

						arg_220_1:RecordAudio("1108407054", var_223_15)
						arg_220_1:RecordAudio("1108407054", var_223_15)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407054", "story_v_side_new_1108407.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407054", "story_v_side_new_1108407.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_16 = math.max(var_223_7, arg_220_1.talkMaxDuration)

			if var_223_6 <= arg_220_1.time_ and arg_220_1.time_ < var_223_6 + var_223_16 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_6) / var_223_16

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_6 + var_223_16 and arg_220_1.time_ < var_223_6 + var_223_16 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play1108407055 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 1108407055
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play1108407056(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["1084ui_story"].transform
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 then
				arg_224_1.var_.moveOldPos1084ui_story = var_227_0.localPosition
			end

			local var_227_2 = 0.001

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2
				local var_227_4 = Vector3.New(0, 100, 0)

				var_227_0.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1084ui_story, var_227_4, var_227_3)

				local var_227_5 = manager.ui.mainCamera.transform.position - var_227_0.position

				var_227_0.forward = Vector3.New(var_227_5.x, var_227_5.y, var_227_5.z)

				local var_227_6 = var_227_0.localEulerAngles

				var_227_6.z = 0
				var_227_6.x = 0
				var_227_0.localEulerAngles = var_227_6
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 then
				var_227_0.localPosition = Vector3.New(0, 100, 0)

				local var_227_7 = manager.ui.mainCamera.transform.position - var_227_0.position

				var_227_0.forward = Vector3.New(var_227_7.x, var_227_7.y, var_227_7.z)

				local var_227_8 = var_227_0.localEulerAngles

				var_227_8.z = 0
				var_227_8.x = 0
				var_227_0.localEulerAngles = var_227_8
			end

			local var_227_9 = arg_224_1.actors_["1084ui_story"]
			local var_227_10 = 0

			if var_227_10 < arg_224_1.time_ and arg_224_1.time_ <= var_227_10 + arg_227_0 and not isNil(var_227_9) and arg_224_1.var_.characterEffect1084ui_story == nil then
				arg_224_1.var_.characterEffect1084ui_story = var_227_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_11 = 0.200000002980232

			if var_227_10 <= arg_224_1.time_ and arg_224_1.time_ < var_227_10 + var_227_11 and not isNil(var_227_9) then
				local var_227_12 = (arg_224_1.time_ - var_227_10) / var_227_11

				if arg_224_1.var_.characterEffect1084ui_story and not isNil(var_227_9) then
					local var_227_13 = Mathf.Lerp(0, 0.5, var_227_12)

					arg_224_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1084ui_story.fillRatio = var_227_13
				end
			end

			if arg_224_1.time_ >= var_227_10 + var_227_11 and arg_224_1.time_ < var_227_10 + var_227_11 + arg_227_0 and not isNil(var_227_9) and arg_224_1.var_.characterEffect1084ui_story then
				local var_227_14 = 0.5

				arg_224_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1084ui_story.fillRatio = var_227_14
			end

			local var_227_15 = 0
			local var_227_16 = 1

			if var_227_15 < arg_224_1.time_ and arg_224_1.time_ <= var_227_15 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, false)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_17 = arg_224_1:GetWordFromCfg(1108407055)
				local var_227_18 = arg_224_1:FormatText(var_227_17.content)

				arg_224_1.text_.text = var_227_18

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_19 = 40
				local var_227_20 = utf8.len(var_227_18)
				local var_227_21 = var_227_19 <= 0 and var_227_16 or var_227_16 * (var_227_20 / var_227_19)

				if var_227_21 > 0 and var_227_16 < var_227_21 then
					arg_224_1.talkMaxDuration = var_227_21

					if var_227_21 + var_227_15 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_21 + var_227_15
					end
				end

				arg_224_1.text_.text = var_227_18
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_22 = math.max(var_227_16, arg_224_1.talkMaxDuration)

			if var_227_15 <= arg_224_1.time_ and arg_224_1.time_ < var_227_15 + var_227_22 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_15) / var_227_22

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_15 + var_227_22 and arg_224_1.time_ < var_227_15 + var_227_22 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_224_1:InitPlayNodeList()
	end,
	Play1108407056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 1108407056
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play1108407057(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0
			local var_231_1 = 1.2

			if var_231_0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_2 = arg_228_1:FormatText(StoryNameCfg[7].name)

				arg_228_1.leftNameTxt_.text = var_231_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_3 = arg_228_1:GetWordFromCfg(1108407056)
				local var_231_4 = arg_228_1:FormatText(var_231_3.content)

				arg_228_1.text_.text = var_231_4

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_5 = 48
				local var_231_6 = utf8.len(var_231_4)
				local var_231_7 = var_231_5 <= 0 and var_231_1 or var_231_1 * (var_231_6 / var_231_5)

				if var_231_7 > 0 and var_231_1 < var_231_7 then
					arg_228_1.talkMaxDuration = var_231_7

					if var_231_7 + var_231_0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_7 + var_231_0
					end
				end

				arg_228_1.text_.text = var_231_4
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_8 = math.max(var_231_1, arg_228_1.talkMaxDuration)

			if var_231_0 <= arg_228_1.time_ and arg_228_1.time_ < var_231_0 + var_231_8 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_0) / var_231_8

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_0 + var_231_8 and arg_228_1.time_ < var_231_0 + var_231_8 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play1108407057 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 1108407057
		arg_232_1.duration_ = 4.6

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play1108407058(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["1084ui_story"].transform
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.var_.moveOldPos1084ui_story = var_235_0.localPosition
			end

			local var_235_2 = 0.001

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2
				local var_235_4 = Vector3.New(0, -0.97, -6)

				var_235_0.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1084ui_story, var_235_4, var_235_3)

				local var_235_5 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_5.x, var_235_5.y, var_235_5.z)

				local var_235_6 = var_235_0.localEulerAngles

				var_235_6.z = 0
				var_235_6.x = 0
				var_235_0.localEulerAngles = var_235_6
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 then
				var_235_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_235_7 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_7.x, var_235_7.y, var_235_7.z)

				local var_235_8 = var_235_0.localEulerAngles

				var_235_8.z = 0
				var_235_8.x = 0
				var_235_0.localEulerAngles = var_235_8
			end

			local var_235_9 = arg_232_1.actors_["1084ui_story"]
			local var_235_10 = 0

			if var_235_10 < arg_232_1.time_ and arg_232_1.time_ <= var_235_10 + arg_235_0 and not isNil(var_235_9) and arg_232_1.var_.characterEffect1084ui_story == nil then
				arg_232_1.var_.characterEffect1084ui_story = var_235_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_11 = 0.200000002980232

			if var_235_10 <= arg_232_1.time_ and arg_232_1.time_ < var_235_10 + var_235_11 and not isNil(var_235_9) then
				local var_235_12 = (arg_232_1.time_ - var_235_10) / var_235_11

				if arg_232_1.var_.characterEffect1084ui_story and not isNil(var_235_9) then
					arg_232_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= var_235_10 + var_235_11 and arg_232_1.time_ < var_235_10 + var_235_11 + arg_235_0 and not isNil(var_235_9) and arg_232_1.var_.characterEffect1084ui_story then
				arg_232_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_235_13 = 0

			if var_235_13 < arg_232_1.time_ and arg_232_1.time_ <= var_235_13 + arg_235_0 then
				arg_232_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_235_14 = 0

			if var_235_14 < arg_232_1.time_ and arg_232_1.time_ <= var_235_14 + arg_235_0 then
				arg_232_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_235_15 = 0
			local var_235_16 = 0.325

			if var_235_15 < arg_232_1.time_ and arg_232_1.time_ <= var_235_15 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_17 = arg_232_1:FormatText(StoryNameCfg[6].name)

				arg_232_1.leftNameTxt_.text = var_235_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_18 = arg_232_1:GetWordFromCfg(1108407057)
				local var_235_19 = arg_232_1:FormatText(var_235_18.content)

				arg_232_1.text_.text = var_235_19

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_20 = 13
				local var_235_21 = utf8.len(var_235_19)
				local var_235_22 = var_235_20 <= 0 and var_235_16 or var_235_16 * (var_235_21 / var_235_20)

				if var_235_22 > 0 and var_235_16 < var_235_22 then
					arg_232_1.talkMaxDuration = var_235_22

					if var_235_22 + var_235_15 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_22 + var_235_15
					end
				end

				arg_232_1.text_.text = var_235_19
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407057", "story_v_side_new_1108407.awb") ~= 0 then
					local var_235_23 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407057", "story_v_side_new_1108407.awb") / 1000

					if var_235_23 + var_235_15 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_23 + var_235_15
					end

					if var_235_18.prefab_name ~= "" and arg_232_1.actors_[var_235_18.prefab_name] ~= nil then
						local var_235_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_18.prefab_name].transform, "story_v_side_new_1108407", "1108407057", "story_v_side_new_1108407.awb")

						arg_232_1:RecordAudio("1108407057", var_235_24)
						arg_232_1:RecordAudio("1108407057", var_235_24)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407057", "story_v_side_new_1108407.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407057", "story_v_side_new_1108407.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_25 = math.max(var_235_16, arg_232_1.talkMaxDuration)

			if var_235_15 <= arg_232_1.time_ and arg_232_1.time_ < var_235_15 + var_235_25 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_15) / var_235_25

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_15 + var_235_25 and arg_232_1.time_ < var_235_15 + var_235_25 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play1108407058 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 1108407058
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play1108407059(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["1084ui_story"]
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect1084ui_story == nil then
				arg_236_1.var_.characterEffect1084ui_story = var_239_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.200000002980232

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 and not isNil(var_239_0) then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2

				if arg_236_1.var_.characterEffect1084ui_story and not isNil(var_239_0) then
					local var_239_4 = Mathf.Lerp(0, 0.5, var_239_3)

					arg_236_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_236_1.var_.characterEffect1084ui_story.fillRatio = var_239_4
				end
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect1084ui_story then
				local var_239_5 = 0.5

				arg_236_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_236_1.var_.characterEffect1084ui_story.fillRatio = var_239_5
			end

			local var_239_6 = 0
			local var_239_7 = 0.5

			if var_239_6 < arg_236_1.time_ and arg_236_1.time_ <= var_239_6 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_8 = arg_236_1:FormatText(StoryNameCfg[7].name)

				arg_236_1.leftNameTxt_.text = var_239_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_9 = arg_236_1:GetWordFromCfg(1108407058)
				local var_239_10 = arg_236_1:FormatText(var_239_9.content)

				arg_236_1.text_.text = var_239_10

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_11 = 20
				local var_239_12 = utf8.len(var_239_10)
				local var_239_13 = var_239_11 <= 0 and var_239_7 or var_239_7 * (var_239_12 / var_239_11)

				if var_239_13 > 0 and var_239_7 < var_239_13 then
					arg_236_1.talkMaxDuration = var_239_13

					if var_239_13 + var_239_6 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_13 + var_239_6
					end
				end

				arg_236_1.text_.text = var_239_10
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_14 = math.max(var_239_7, arg_236_1.talkMaxDuration)

			if var_239_6 <= arg_236_1.time_ and arg_236_1.time_ < var_239_6 + var_239_14 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_6) / var_239_14

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_6 + var_239_14 and arg_236_1.time_ < var_239_6 + var_239_14 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play1108407059 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 1108407059
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play1108407060(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["1084ui_story"].transform
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1.var_.moveOldPos1084ui_story = var_243_0.localPosition
			end

			local var_243_2 = 0.001

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2
				local var_243_4 = Vector3.New(0, 100, 0)

				var_243_0.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos1084ui_story, var_243_4, var_243_3)

				local var_243_5 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_5.x, var_243_5.y, var_243_5.z)

				local var_243_6 = var_243_0.localEulerAngles

				var_243_6.z = 0
				var_243_6.x = 0
				var_243_0.localEulerAngles = var_243_6
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 then
				var_243_0.localPosition = Vector3.New(0, 100, 0)

				local var_243_7 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_7.x, var_243_7.y, var_243_7.z)

				local var_243_8 = var_243_0.localEulerAngles

				var_243_8.z = 0
				var_243_8.x = 0
				var_243_0.localEulerAngles = var_243_8
			end

			local var_243_9 = 0
			local var_243_10 = 0.8

			if var_243_9 < arg_240_1.time_ and arg_240_1.time_ <= var_243_9 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_11 = arg_240_1:GetWordFromCfg(1108407059)
				local var_243_12 = arg_240_1:FormatText(var_243_11.content)

				arg_240_1.text_.text = var_243_12

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_13 = 32
				local var_243_14 = utf8.len(var_243_12)
				local var_243_15 = var_243_13 <= 0 and var_243_10 or var_243_10 * (var_243_14 / var_243_13)

				if var_243_15 > 0 and var_243_10 < var_243_15 then
					arg_240_1.talkMaxDuration = var_243_15

					if var_243_15 + var_243_9 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_15 + var_243_9
					end
				end

				arg_240_1.text_.text = var_243_12
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_16 = math.max(var_243_10, arg_240_1.talkMaxDuration)

			if var_243_9 <= arg_240_1.time_ and arg_240_1.time_ < var_243_9 + var_243_16 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_9) / var_243_16

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_9 + var_243_16 and arg_240_1.time_ < var_243_9 + var_243_16 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play1108407060 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 1108407060
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play1108407061(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0
			local var_247_1 = 0.325

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_2 = arg_244_1:GetWordFromCfg(1108407060)
				local var_247_3 = arg_244_1:FormatText(var_247_2.content)

				arg_244_1.text_.text = var_247_3

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_4 = 13
				local var_247_5 = utf8.len(var_247_3)
				local var_247_6 = var_247_4 <= 0 and var_247_1 or var_247_1 * (var_247_5 / var_247_4)

				if var_247_6 > 0 and var_247_1 < var_247_6 then
					arg_244_1.talkMaxDuration = var_247_6

					if var_247_6 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_6 + var_247_0
					end
				end

				arg_244_1.text_.text = var_247_3
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_7 = math.max(var_247_1, arg_244_1.talkMaxDuration)

			if var_247_0 <= arg_244_1.time_ and arg_244_1.time_ < var_247_0 + var_247_7 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_0) / var_247_7

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_0 + var_247_7 and arg_244_1.time_ < var_247_0 + var_247_7 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play1108407061 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 1108407061
		arg_248_1.duration_ = 2.9

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play1108407062(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["1084ui_story"].transform
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 then
				arg_248_1.var_.moveOldPos1084ui_story = var_251_0.localPosition
			end

			local var_251_2 = 0.001

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2
				local var_251_4 = Vector3.New(0, -0.97, -6)

				var_251_0.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1084ui_story, var_251_4, var_251_3)

				local var_251_5 = manager.ui.mainCamera.transform.position - var_251_0.position

				var_251_0.forward = Vector3.New(var_251_5.x, var_251_5.y, var_251_5.z)

				local var_251_6 = var_251_0.localEulerAngles

				var_251_6.z = 0
				var_251_6.x = 0
				var_251_0.localEulerAngles = var_251_6
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 then
				var_251_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_251_7 = manager.ui.mainCamera.transform.position - var_251_0.position

				var_251_0.forward = Vector3.New(var_251_7.x, var_251_7.y, var_251_7.z)

				local var_251_8 = var_251_0.localEulerAngles

				var_251_8.z = 0
				var_251_8.x = 0
				var_251_0.localEulerAngles = var_251_8
			end

			local var_251_9 = arg_248_1.actors_["1084ui_story"]
			local var_251_10 = 0

			if var_251_10 < arg_248_1.time_ and arg_248_1.time_ <= var_251_10 + arg_251_0 and not isNil(var_251_9) and arg_248_1.var_.characterEffect1084ui_story == nil then
				arg_248_1.var_.characterEffect1084ui_story = var_251_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_11 = 0.200000002980232

			if var_251_10 <= arg_248_1.time_ and arg_248_1.time_ < var_251_10 + var_251_11 and not isNil(var_251_9) then
				local var_251_12 = (arg_248_1.time_ - var_251_10) / var_251_11

				if arg_248_1.var_.characterEffect1084ui_story and not isNil(var_251_9) then
					arg_248_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= var_251_10 + var_251_11 and arg_248_1.time_ < var_251_10 + var_251_11 + arg_251_0 and not isNil(var_251_9) and arg_248_1.var_.characterEffect1084ui_story then
				arg_248_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_251_13 = 0

			if var_251_13 < arg_248_1.time_ and arg_248_1.time_ <= var_251_13 + arg_251_0 then
				arg_248_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_251_14 = 0

			if var_251_14 < arg_248_1.time_ and arg_248_1.time_ <= var_251_14 + arg_251_0 then
				arg_248_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_251_15 = 0
			local var_251_16 = 0.5

			if var_251_15 < arg_248_1.time_ and arg_248_1.time_ <= var_251_15 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_17 = arg_248_1:FormatText(StoryNameCfg[6].name)

				arg_248_1.leftNameTxt_.text = var_251_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_18 = arg_248_1:GetWordFromCfg(1108407061)
				local var_251_19 = arg_248_1:FormatText(var_251_18.content)

				arg_248_1.text_.text = var_251_19

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_20 = 20
				local var_251_21 = utf8.len(var_251_19)
				local var_251_22 = var_251_20 <= 0 and var_251_16 or var_251_16 * (var_251_21 / var_251_20)

				if var_251_22 > 0 and var_251_16 < var_251_22 then
					arg_248_1.talkMaxDuration = var_251_22

					if var_251_22 + var_251_15 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_22 + var_251_15
					end
				end

				arg_248_1.text_.text = var_251_19
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407061", "story_v_side_new_1108407.awb") ~= 0 then
					local var_251_23 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407061", "story_v_side_new_1108407.awb") / 1000

					if var_251_23 + var_251_15 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_23 + var_251_15
					end

					if var_251_18.prefab_name ~= "" and arg_248_1.actors_[var_251_18.prefab_name] ~= nil then
						local var_251_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_18.prefab_name].transform, "story_v_side_new_1108407", "1108407061", "story_v_side_new_1108407.awb")

						arg_248_1:RecordAudio("1108407061", var_251_24)
						arg_248_1:RecordAudio("1108407061", var_251_24)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407061", "story_v_side_new_1108407.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407061", "story_v_side_new_1108407.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_25 = math.max(var_251_16, arg_248_1.talkMaxDuration)

			if var_251_15 <= arg_248_1.time_ and arg_248_1.time_ < var_251_15 + var_251_25 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_15) / var_251_25

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_15 + var_251_25 and arg_248_1.time_ < var_251_15 + var_251_25 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play1108407062 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 1108407062
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play1108407063(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["1084ui_story"]
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect1084ui_story == nil then
				arg_252_1.var_.characterEffect1084ui_story = var_255_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_2 = 0.200000002980232

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 and not isNil(var_255_0) then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2

				if arg_252_1.var_.characterEffect1084ui_story and not isNil(var_255_0) then
					local var_255_4 = Mathf.Lerp(0, 0.5, var_255_3)

					arg_252_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1084ui_story.fillRatio = var_255_4
				end
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect1084ui_story then
				local var_255_5 = 0.5

				arg_252_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1084ui_story.fillRatio = var_255_5
			end

			local var_255_6 = 0
			local var_255_7 = 0.375

			if var_255_6 < arg_252_1.time_ and arg_252_1.time_ <= var_255_6 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_8 = arg_252_1:FormatText(StoryNameCfg[7].name)

				arg_252_1.leftNameTxt_.text = var_255_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_9 = arg_252_1:GetWordFromCfg(1108407062)
				local var_255_10 = arg_252_1:FormatText(var_255_9.content)

				arg_252_1.text_.text = var_255_10

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_11 = 15
				local var_255_12 = utf8.len(var_255_10)
				local var_255_13 = var_255_11 <= 0 and var_255_7 or var_255_7 * (var_255_12 / var_255_11)

				if var_255_13 > 0 and var_255_7 < var_255_13 then
					arg_252_1.talkMaxDuration = var_255_13

					if var_255_13 + var_255_6 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_13 + var_255_6
					end
				end

				arg_252_1.text_.text = var_255_10
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_14 = math.max(var_255_7, arg_252_1.talkMaxDuration)

			if var_255_6 <= arg_252_1.time_ and arg_252_1.time_ < var_255_6 + var_255_14 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_6) / var_255_14

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_6 + var_255_14 and arg_252_1.time_ < var_255_6 + var_255_14 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play1108407063 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 1108407063
		arg_256_1.duration_ = 8.3

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play1108407064(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["1084ui_story"]
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1084ui_story == nil then
				arg_256_1.var_.characterEffect1084ui_story = var_259_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_2 = 0.200000002980232

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 and not isNil(var_259_0) then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / var_259_2

				if arg_256_1.var_.characterEffect1084ui_story and not isNil(var_259_0) then
					arg_256_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1084ui_story then
				arg_256_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_259_4 = 0

			if var_259_4 < arg_256_1.time_ and arg_256_1.time_ <= var_259_4 + arg_259_0 then
				arg_256_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_259_5 = 0

			if var_259_5 < arg_256_1.time_ and arg_256_1.time_ <= var_259_5 + arg_259_0 then
				arg_256_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_259_6 = 0
			local var_259_7 = 1.175

			if var_259_6 < arg_256_1.time_ and arg_256_1.time_ <= var_259_6 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_8 = arg_256_1:FormatText(StoryNameCfg[6].name)

				arg_256_1.leftNameTxt_.text = var_259_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_9 = arg_256_1:GetWordFromCfg(1108407063)
				local var_259_10 = arg_256_1:FormatText(var_259_9.content)

				arg_256_1.text_.text = var_259_10

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_11 = 47
				local var_259_12 = utf8.len(var_259_10)
				local var_259_13 = var_259_11 <= 0 and var_259_7 or var_259_7 * (var_259_12 / var_259_11)

				if var_259_13 > 0 and var_259_7 < var_259_13 then
					arg_256_1.talkMaxDuration = var_259_13

					if var_259_13 + var_259_6 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_13 + var_259_6
					end
				end

				arg_256_1.text_.text = var_259_10
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407063", "story_v_side_new_1108407.awb") ~= 0 then
					local var_259_14 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407063", "story_v_side_new_1108407.awb") / 1000

					if var_259_14 + var_259_6 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_14 + var_259_6
					end

					if var_259_9.prefab_name ~= "" and arg_256_1.actors_[var_259_9.prefab_name] ~= nil then
						local var_259_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_9.prefab_name].transform, "story_v_side_new_1108407", "1108407063", "story_v_side_new_1108407.awb")

						arg_256_1:RecordAudio("1108407063", var_259_15)
						arg_256_1:RecordAudio("1108407063", var_259_15)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407063", "story_v_side_new_1108407.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407063", "story_v_side_new_1108407.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_16 = math.max(var_259_7, arg_256_1.talkMaxDuration)

			if var_259_6 <= arg_256_1.time_ and arg_256_1.time_ < var_259_6 + var_259_16 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_6) / var_259_16

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_6 + var_259_16 and arg_256_1.time_ < var_259_6 + var_259_16 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play1108407064 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 1108407064
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play1108407065(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = arg_260_1.actors_["1084ui_story"]
			local var_263_1 = 0

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.characterEffect1084ui_story == nil then
				arg_260_1.var_.characterEffect1084ui_story = var_263_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_2 = 0.200000002980232

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_2 and not isNil(var_263_0) then
				local var_263_3 = (arg_260_1.time_ - var_263_1) / var_263_2

				if arg_260_1.var_.characterEffect1084ui_story and not isNil(var_263_0) then
					local var_263_4 = Mathf.Lerp(0, 0.5, var_263_3)

					arg_260_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_260_1.var_.characterEffect1084ui_story.fillRatio = var_263_4
				end
			end

			if arg_260_1.time_ >= var_263_1 + var_263_2 and arg_260_1.time_ < var_263_1 + var_263_2 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.characterEffect1084ui_story then
				local var_263_5 = 0.5

				arg_260_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_260_1.var_.characterEffect1084ui_story.fillRatio = var_263_5
			end

			local var_263_6 = 0
			local var_263_7 = 0.575

			if var_263_6 < arg_260_1.time_ and arg_260_1.time_ <= var_263_6 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_8 = arg_260_1:FormatText(StoryNameCfg[7].name)

				arg_260_1.leftNameTxt_.text = var_263_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_9 = arg_260_1:GetWordFromCfg(1108407064)
				local var_263_10 = arg_260_1:FormatText(var_263_9.content)

				arg_260_1.text_.text = var_263_10

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_11 = 23
				local var_263_12 = utf8.len(var_263_10)
				local var_263_13 = var_263_11 <= 0 and var_263_7 or var_263_7 * (var_263_12 / var_263_11)

				if var_263_13 > 0 and var_263_7 < var_263_13 then
					arg_260_1.talkMaxDuration = var_263_13

					if var_263_13 + var_263_6 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_13 + var_263_6
					end
				end

				arg_260_1.text_.text = var_263_10
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_14 = math.max(var_263_7, arg_260_1.talkMaxDuration)

			if var_263_6 <= arg_260_1.time_ and arg_260_1.time_ < var_263_6 + var_263_14 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_6) / var_263_14

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_6 + var_263_14 and arg_260_1.time_ < var_263_6 + var_263_14 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play1108407065 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 1108407065
		arg_264_1.duration_ = 4.5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play1108407066(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["1084ui_story"]
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect1084ui_story == nil then
				arg_264_1.var_.characterEffect1084ui_story = var_267_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_2 = 0.200000002980232

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_2 and not isNil(var_267_0) then
				local var_267_3 = (arg_264_1.time_ - var_267_1) / var_267_2

				if arg_264_1.var_.characterEffect1084ui_story and not isNil(var_267_0) then
					arg_264_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= var_267_1 + var_267_2 and arg_264_1.time_ < var_267_1 + var_267_2 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect1084ui_story then
				arg_264_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_267_4 = 0

			if var_267_4 < arg_264_1.time_ and arg_264_1.time_ <= var_267_4 + arg_267_0 then
				arg_264_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_267_5 = 0

			if var_267_5 < arg_264_1.time_ and arg_264_1.time_ <= var_267_5 + arg_267_0 then
				arg_264_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_267_6 = 0
			local var_267_7 = 0.55

			if var_267_6 < arg_264_1.time_ and arg_264_1.time_ <= var_267_6 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_8 = arg_264_1:FormatText(StoryNameCfg[6].name)

				arg_264_1.leftNameTxt_.text = var_267_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_9 = arg_264_1:GetWordFromCfg(1108407065)
				local var_267_10 = arg_264_1:FormatText(var_267_9.content)

				arg_264_1.text_.text = var_267_10

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_11 = 22
				local var_267_12 = utf8.len(var_267_10)
				local var_267_13 = var_267_11 <= 0 and var_267_7 or var_267_7 * (var_267_12 / var_267_11)

				if var_267_13 > 0 and var_267_7 < var_267_13 then
					arg_264_1.talkMaxDuration = var_267_13

					if var_267_13 + var_267_6 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_13 + var_267_6
					end
				end

				arg_264_1.text_.text = var_267_10
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407065", "story_v_side_new_1108407.awb") ~= 0 then
					local var_267_14 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407065", "story_v_side_new_1108407.awb") / 1000

					if var_267_14 + var_267_6 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_14 + var_267_6
					end

					if var_267_9.prefab_name ~= "" and arg_264_1.actors_[var_267_9.prefab_name] ~= nil then
						local var_267_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_9.prefab_name].transform, "story_v_side_new_1108407", "1108407065", "story_v_side_new_1108407.awb")

						arg_264_1:RecordAudio("1108407065", var_267_15)
						arg_264_1:RecordAudio("1108407065", var_267_15)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407065", "story_v_side_new_1108407.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407065", "story_v_side_new_1108407.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_16 = math.max(var_267_7, arg_264_1.talkMaxDuration)

			if var_267_6 <= arg_264_1.time_ and arg_264_1.time_ < var_267_6 + var_267_16 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_6) / var_267_16

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_6 + var_267_16 and arg_264_1.time_ < var_267_6 + var_267_16 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play1108407066 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 1108407066
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play1108407067(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = arg_268_1.actors_["1084ui_story"]
			local var_271_1 = 0

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 and not isNil(var_271_0) and arg_268_1.var_.characterEffect1084ui_story == nil then
				arg_268_1.var_.characterEffect1084ui_story = var_271_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_2 = 0.200000002980232

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_2 and not isNil(var_271_0) then
				local var_271_3 = (arg_268_1.time_ - var_271_1) / var_271_2

				if arg_268_1.var_.characterEffect1084ui_story and not isNil(var_271_0) then
					local var_271_4 = Mathf.Lerp(0, 0.5, var_271_3)

					arg_268_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_268_1.var_.characterEffect1084ui_story.fillRatio = var_271_4
				end
			end

			if arg_268_1.time_ >= var_271_1 + var_271_2 and arg_268_1.time_ < var_271_1 + var_271_2 + arg_271_0 and not isNil(var_271_0) and arg_268_1.var_.characterEffect1084ui_story then
				local var_271_5 = 0.5

				arg_268_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_268_1.var_.characterEffect1084ui_story.fillRatio = var_271_5
			end

			local var_271_6 = 0
			local var_271_7 = 0.3

			if var_271_6 < arg_268_1.time_ and arg_268_1.time_ <= var_271_6 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_8 = arg_268_1:FormatText(StoryNameCfg[7].name)

				arg_268_1.leftNameTxt_.text = var_271_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_9 = arg_268_1:GetWordFromCfg(1108407066)
				local var_271_10 = arg_268_1:FormatText(var_271_9.content)

				arg_268_1.text_.text = var_271_10

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_11 = 12
				local var_271_12 = utf8.len(var_271_10)
				local var_271_13 = var_271_11 <= 0 and var_271_7 or var_271_7 * (var_271_12 / var_271_11)

				if var_271_13 > 0 and var_271_7 < var_271_13 then
					arg_268_1.talkMaxDuration = var_271_13

					if var_271_13 + var_271_6 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_13 + var_271_6
					end
				end

				arg_268_1.text_.text = var_271_10
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_14 = math.max(var_271_7, arg_268_1.talkMaxDuration)

			if var_271_6 <= arg_268_1.time_ and arg_268_1.time_ < var_271_6 + var_271_14 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_6) / var_271_14

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_6 + var_271_14 and arg_268_1.time_ < var_271_6 + var_271_14 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play1108407067 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 1108407067
		arg_272_1.duration_ = 6.1

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play1108407068(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = arg_272_1.actors_["1084ui_story"]
			local var_275_1 = 0

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 and not isNil(var_275_0) and arg_272_1.var_.characterEffect1084ui_story == nil then
				arg_272_1.var_.characterEffect1084ui_story = var_275_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_2 = 0.200000002980232

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_2 and not isNil(var_275_0) then
				local var_275_3 = (arg_272_1.time_ - var_275_1) / var_275_2

				if arg_272_1.var_.characterEffect1084ui_story and not isNil(var_275_0) then
					arg_272_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= var_275_1 + var_275_2 and arg_272_1.time_ < var_275_1 + var_275_2 + arg_275_0 and not isNil(var_275_0) and arg_272_1.var_.characterEffect1084ui_story then
				arg_272_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_275_4 = 0

			if var_275_4 < arg_272_1.time_ and arg_272_1.time_ <= var_275_4 + arg_275_0 then
				arg_272_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_275_5 = 0

			if var_275_5 < arg_272_1.time_ and arg_272_1.time_ <= var_275_5 + arg_275_0 then
				arg_272_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_275_6 = 0
			local var_275_7 = 0.925

			if var_275_6 < arg_272_1.time_ and arg_272_1.time_ <= var_275_6 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_8 = arg_272_1:FormatText(StoryNameCfg[6].name)

				arg_272_1.leftNameTxt_.text = var_275_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_9 = arg_272_1:GetWordFromCfg(1108407067)
				local var_275_10 = arg_272_1:FormatText(var_275_9.content)

				arg_272_1.text_.text = var_275_10

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_11 = 37
				local var_275_12 = utf8.len(var_275_10)
				local var_275_13 = var_275_11 <= 0 and var_275_7 or var_275_7 * (var_275_12 / var_275_11)

				if var_275_13 > 0 and var_275_7 < var_275_13 then
					arg_272_1.talkMaxDuration = var_275_13

					if var_275_13 + var_275_6 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_13 + var_275_6
					end
				end

				arg_272_1.text_.text = var_275_10
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407067", "story_v_side_new_1108407.awb") ~= 0 then
					local var_275_14 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407067", "story_v_side_new_1108407.awb") / 1000

					if var_275_14 + var_275_6 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_14 + var_275_6
					end

					if var_275_9.prefab_name ~= "" and arg_272_1.actors_[var_275_9.prefab_name] ~= nil then
						local var_275_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_9.prefab_name].transform, "story_v_side_new_1108407", "1108407067", "story_v_side_new_1108407.awb")

						arg_272_1:RecordAudio("1108407067", var_275_15)
						arg_272_1:RecordAudio("1108407067", var_275_15)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407067", "story_v_side_new_1108407.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407067", "story_v_side_new_1108407.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_16 = math.max(var_275_7, arg_272_1.talkMaxDuration)

			if var_275_6 <= arg_272_1.time_ and arg_272_1.time_ < var_275_6 + var_275_16 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_6) / var_275_16

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_6 + var_275_16 and arg_272_1.time_ < var_275_6 + var_275_16 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play1108407068 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 1108407068
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play1108407069(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["1084ui_story"]
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.characterEffect1084ui_story == nil then
				arg_276_1.var_.characterEffect1084ui_story = var_279_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_2 = 0.200000002980232

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_2 and not isNil(var_279_0) then
				local var_279_3 = (arg_276_1.time_ - var_279_1) / var_279_2

				if arg_276_1.var_.characterEffect1084ui_story and not isNil(var_279_0) then
					local var_279_4 = Mathf.Lerp(0, 0.5, var_279_3)

					arg_276_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_276_1.var_.characterEffect1084ui_story.fillRatio = var_279_4
				end
			end

			if arg_276_1.time_ >= var_279_1 + var_279_2 and arg_276_1.time_ < var_279_1 + var_279_2 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.characterEffect1084ui_story then
				local var_279_5 = 0.5

				arg_276_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_276_1.var_.characterEffect1084ui_story.fillRatio = var_279_5
			end

			local var_279_6 = 0
			local var_279_7 = 0.3

			if var_279_6 < arg_276_1.time_ and arg_276_1.time_ <= var_279_6 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_8 = arg_276_1:FormatText(StoryNameCfg[7].name)

				arg_276_1.leftNameTxt_.text = var_279_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_9 = arg_276_1:GetWordFromCfg(1108407068)
				local var_279_10 = arg_276_1:FormatText(var_279_9.content)

				arg_276_1.text_.text = var_279_10

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_11 = 12
				local var_279_12 = utf8.len(var_279_10)
				local var_279_13 = var_279_11 <= 0 and var_279_7 or var_279_7 * (var_279_12 / var_279_11)

				if var_279_13 > 0 and var_279_7 < var_279_13 then
					arg_276_1.talkMaxDuration = var_279_13

					if var_279_13 + var_279_6 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_13 + var_279_6
					end
				end

				arg_276_1.text_.text = var_279_10
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_14 = math.max(var_279_7, arg_276_1.talkMaxDuration)

			if var_279_6 <= arg_276_1.time_ and arg_276_1.time_ < var_279_6 + var_279_14 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_6) / var_279_14

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_6 + var_279_14 and arg_276_1.time_ < var_279_6 + var_279_14 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play1108407069 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 1108407069
		arg_280_1.duration_ = 2.4

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play1108407070(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = arg_280_1.actors_["1084ui_story"]
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect1084ui_story == nil then
				arg_280_1.var_.characterEffect1084ui_story = var_283_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_2 = 0.200000002980232

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_2 and not isNil(var_283_0) then
				local var_283_3 = (arg_280_1.time_ - var_283_1) / var_283_2

				if arg_280_1.var_.characterEffect1084ui_story and not isNil(var_283_0) then
					arg_280_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= var_283_1 + var_283_2 and arg_280_1.time_ < var_283_1 + var_283_2 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect1084ui_story then
				arg_280_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_283_4 = 0

			if var_283_4 < arg_280_1.time_ and arg_280_1.time_ <= var_283_4 + arg_283_0 then
				arg_280_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_283_5 = 0

			if var_283_5 < arg_280_1.time_ and arg_280_1.time_ <= var_283_5 + arg_283_0 then
				arg_280_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_283_6 = 0
			local var_283_7 = 0.225

			if var_283_6 < arg_280_1.time_ and arg_280_1.time_ <= var_283_6 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_8 = arg_280_1:FormatText(StoryNameCfg[6].name)

				arg_280_1.leftNameTxt_.text = var_283_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_9 = arg_280_1:GetWordFromCfg(1108407069)
				local var_283_10 = arg_280_1:FormatText(var_283_9.content)

				arg_280_1.text_.text = var_283_10

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_11 = 9
				local var_283_12 = utf8.len(var_283_10)
				local var_283_13 = var_283_11 <= 0 and var_283_7 or var_283_7 * (var_283_12 / var_283_11)

				if var_283_13 > 0 and var_283_7 < var_283_13 then
					arg_280_1.talkMaxDuration = var_283_13

					if var_283_13 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_13 + var_283_6
					end
				end

				arg_280_1.text_.text = var_283_10
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407069", "story_v_side_new_1108407.awb") ~= 0 then
					local var_283_14 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407069", "story_v_side_new_1108407.awb") / 1000

					if var_283_14 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_14 + var_283_6
					end

					if var_283_9.prefab_name ~= "" and arg_280_1.actors_[var_283_9.prefab_name] ~= nil then
						local var_283_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_9.prefab_name].transform, "story_v_side_new_1108407", "1108407069", "story_v_side_new_1108407.awb")

						arg_280_1:RecordAudio("1108407069", var_283_15)
						arg_280_1:RecordAudio("1108407069", var_283_15)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407069", "story_v_side_new_1108407.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407069", "story_v_side_new_1108407.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_16 = math.max(var_283_7, arg_280_1.talkMaxDuration)

			if var_283_6 <= arg_280_1.time_ and arg_280_1.time_ < var_283_6 + var_283_16 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_6) / var_283_16

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_6 + var_283_16 and arg_280_1.time_ < var_283_6 + var_283_16 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play1108407070 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 1108407070
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play1108407071(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["1084ui_story"]
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect1084ui_story == nil then
				arg_284_1.var_.characterEffect1084ui_story = var_287_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_2 = 0.200000002980232

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 and not isNil(var_287_0) then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / var_287_2

				if arg_284_1.var_.characterEffect1084ui_story and not isNil(var_287_0) then
					local var_287_4 = Mathf.Lerp(0, 0.5, var_287_3)

					arg_284_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_284_1.var_.characterEffect1084ui_story.fillRatio = var_287_4
				end
			end

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect1084ui_story then
				local var_287_5 = 0.5

				arg_284_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_284_1.var_.characterEffect1084ui_story.fillRatio = var_287_5
			end

			local var_287_6 = 0
			local var_287_7 = 0.825

			if var_287_6 < arg_284_1.time_ and arg_284_1.time_ <= var_287_6 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_8 = arg_284_1:FormatText(StoryNameCfg[7].name)

				arg_284_1.leftNameTxt_.text = var_287_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_9 = arg_284_1:GetWordFromCfg(1108407070)
				local var_287_10 = arg_284_1:FormatText(var_287_9.content)

				arg_284_1.text_.text = var_287_10

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_11 = 33
				local var_287_12 = utf8.len(var_287_10)
				local var_287_13 = var_287_11 <= 0 and var_287_7 or var_287_7 * (var_287_12 / var_287_11)

				if var_287_13 > 0 and var_287_7 < var_287_13 then
					arg_284_1.talkMaxDuration = var_287_13

					if var_287_13 + var_287_6 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_13 + var_287_6
					end
				end

				arg_284_1.text_.text = var_287_10
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_14 = math.max(var_287_7, arg_284_1.talkMaxDuration)

			if var_287_6 <= arg_284_1.time_ and arg_284_1.time_ < var_287_6 + var_287_14 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_6) / var_287_14

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_6 + var_287_14 and arg_284_1.time_ < var_287_6 + var_287_14 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play1108407071 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 1108407071
		arg_288_1.duration_ = 8.23

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play1108407072(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["1084ui_story"]
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect1084ui_story == nil then
				arg_288_1.var_.characterEffect1084ui_story = var_291_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_2 = 0.200000002980232

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 and not isNil(var_291_0) then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2

				if arg_288_1.var_.characterEffect1084ui_story and not isNil(var_291_0) then
					arg_288_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect1084ui_story then
				arg_288_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_291_4 = 0

			if var_291_4 < arg_288_1.time_ and arg_288_1.time_ <= var_291_4 + arg_291_0 then
				arg_288_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_291_5 = 0

			if var_291_5 < arg_288_1.time_ and arg_288_1.time_ <= var_291_5 + arg_291_0 then
				arg_288_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_291_6 = 0
			local var_291_7 = 0.725

			if var_291_6 < arg_288_1.time_ and arg_288_1.time_ <= var_291_6 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_8 = arg_288_1:FormatText(StoryNameCfg[6].name)

				arg_288_1.leftNameTxt_.text = var_291_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_9 = arg_288_1:GetWordFromCfg(1108407071)
				local var_291_10 = arg_288_1:FormatText(var_291_9.content)

				arg_288_1.text_.text = var_291_10

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_11 = 29
				local var_291_12 = utf8.len(var_291_10)
				local var_291_13 = var_291_11 <= 0 and var_291_7 or var_291_7 * (var_291_12 / var_291_11)

				if var_291_13 > 0 and var_291_7 < var_291_13 then
					arg_288_1.talkMaxDuration = var_291_13

					if var_291_13 + var_291_6 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_13 + var_291_6
					end
				end

				arg_288_1.text_.text = var_291_10
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407071", "story_v_side_new_1108407.awb") ~= 0 then
					local var_291_14 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407071", "story_v_side_new_1108407.awb") / 1000

					if var_291_14 + var_291_6 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_14 + var_291_6
					end

					if var_291_9.prefab_name ~= "" and arg_288_1.actors_[var_291_9.prefab_name] ~= nil then
						local var_291_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_9.prefab_name].transform, "story_v_side_new_1108407", "1108407071", "story_v_side_new_1108407.awb")

						arg_288_1:RecordAudio("1108407071", var_291_15)
						arg_288_1:RecordAudio("1108407071", var_291_15)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407071", "story_v_side_new_1108407.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407071", "story_v_side_new_1108407.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_16 = math.max(var_291_7, arg_288_1.talkMaxDuration)

			if var_291_6 <= arg_288_1.time_ and arg_288_1.time_ < var_291_6 + var_291_16 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_6) / var_291_16

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_6 + var_291_16 and arg_288_1.time_ < var_291_6 + var_291_16 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play1108407072 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 1108407072
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play1108407073(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["1084ui_story"]
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.characterEffect1084ui_story == nil then
				arg_292_1.var_.characterEffect1084ui_story = var_295_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_2 = 0.200000002980232

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_2 and not isNil(var_295_0) then
				local var_295_3 = (arg_292_1.time_ - var_295_1) / var_295_2

				if arg_292_1.var_.characterEffect1084ui_story and not isNil(var_295_0) then
					local var_295_4 = Mathf.Lerp(0, 0.5, var_295_3)

					arg_292_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_292_1.var_.characterEffect1084ui_story.fillRatio = var_295_4
				end
			end

			if arg_292_1.time_ >= var_295_1 + var_295_2 and arg_292_1.time_ < var_295_1 + var_295_2 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.characterEffect1084ui_story then
				local var_295_5 = 0.5

				arg_292_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_292_1.var_.characterEffect1084ui_story.fillRatio = var_295_5
			end

			local var_295_6 = 0
			local var_295_7 = 0.8

			if var_295_6 < arg_292_1.time_ and arg_292_1.time_ <= var_295_6 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_8 = arg_292_1:FormatText(StoryNameCfg[7].name)

				arg_292_1.leftNameTxt_.text = var_295_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_9 = arg_292_1:GetWordFromCfg(1108407072)
				local var_295_10 = arg_292_1:FormatText(var_295_9.content)

				arg_292_1.text_.text = var_295_10

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_11 = 32
				local var_295_12 = utf8.len(var_295_10)
				local var_295_13 = var_295_11 <= 0 and var_295_7 or var_295_7 * (var_295_12 / var_295_11)

				if var_295_13 > 0 and var_295_7 < var_295_13 then
					arg_292_1.talkMaxDuration = var_295_13

					if var_295_13 + var_295_6 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_13 + var_295_6
					end
				end

				arg_292_1.text_.text = var_295_10
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_14 = math.max(var_295_7, arg_292_1.talkMaxDuration)

			if var_295_6 <= arg_292_1.time_ and arg_292_1.time_ < var_295_6 + var_295_14 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_6) / var_295_14

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_6 + var_295_14 and arg_292_1.time_ < var_295_6 + var_295_14 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play1108407073 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 1108407073
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play1108407074(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["1084ui_story"].transform
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.var_.moveOldPos1084ui_story = var_299_0.localPosition
			end

			local var_299_2 = 0.001

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_2 then
				local var_299_3 = (arg_296_1.time_ - var_299_1) / var_299_2
				local var_299_4 = Vector3.New(0, 100, 0)

				var_299_0.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1084ui_story, var_299_4, var_299_3)

				local var_299_5 = manager.ui.mainCamera.transform.position - var_299_0.position

				var_299_0.forward = Vector3.New(var_299_5.x, var_299_5.y, var_299_5.z)

				local var_299_6 = var_299_0.localEulerAngles

				var_299_6.z = 0
				var_299_6.x = 0
				var_299_0.localEulerAngles = var_299_6
			end

			if arg_296_1.time_ >= var_299_1 + var_299_2 and arg_296_1.time_ < var_299_1 + var_299_2 + arg_299_0 then
				var_299_0.localPosition = Vector3.New(0, 100, 0)

				local var_299_7 = manager.ui.mainCamera.transform.position - var_299_0.position

				var_299_0.forward = Vector3.New(var_299_7.x, var_299_7.y, var_299_7.z)

				local var_299_8 = var_299_0.localEulerAngles

				var_299_8.z = 0
				var_299_8.x = 0
				var_299_0.localEulerAngles = var_299_8
			end

			local var_299_9 = 0
			local var_299_10 = 1.15

			if var_299_9 < arg_296_1.time_ and arg_296_1.time_ <= var_299_9 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_11 = arg_296_1:GetWordFromCfg(1108407073)
				local var_299_12 = arg_296_1:FormatText(var_299_11.content)

				arg_296_1.text_.text = var_299_12

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_13 = 46
				local var_299_14 = utf8.len(var_299_12)
				local var_299_15 = var_299_13 <= 0 and var_299_10 or var_299_10 * (var_299_14 / var_299_13)

				if var_299_15 > 0 and var_299_10 < var_299_15 then
					arg_296_1.talkMaxDuration = var_299_15

					if var_299_15 + var_299_9 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_15 + var_299_9
					end
				end

				arg_296_1.text_.text = var_299_12
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_16 = math.max(var_299_10, arg_296_1.talkMaxDuration)

			if var_299_9 <= arg_296_1.time_ and arg_296_1.time_ < var_299_9 + var_299_16 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_9) / var_299_16

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_9 + var_299_16 and arg_296_1.time_ < var_299_9 + var_299_16 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play1108407074 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 1108407074
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play1108407075(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0
			local var_303_1 = 1.375

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_2 = arg_300_1:GetWordFromCfg(1108407074)
				local var_303_3 = arg_300_1:FormatText(var_303_2.content)

				arg_300_1.text_.text = var_303_3

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_4 = 55
				local var_303_5 = utf8.len(var_303_3)
				local var_303_6 = var_303_4 <= 0 and var_303_1 or var_303_1 * (var_303_5 / var_303_4)

				if var_303_6 > 0 and var_303_1 < var_303_6 then
					arg_300_1.talkMaxDuration = var_303_6

					if var_303_6 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_6 + var_303_0
					end
				end

				arg_300_1.text_.text = var_303_3
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_7 = math.max(var_303_1, arg_300_1.talkMaxDuration)

			if var_303_0 <= arg_300_1.time_ and arg_300_1.time_ < var_303_0 + var_303_7 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_0) / var_303_7

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_0 + var_303_7 and arg_300_1.time_ < var_303_0 + var_303_7 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play1108407075 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 1108407075
		arg_304_1.duration_ = 6.77

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play1108407076(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = arg_304_1.actors_["1084ui_story"].transform
			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 then
				arg_304_1.var_.moveOldPos1084ui_story = var_307_0.localPosition
			end

			local var_307_2 = 0.001

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_2 then
				local var_307_3 = (arg_304_1.time_ - var_307_1) / var_307_2
				local var_307_4 = Vector3.New(0, -0.97, -6)

				var_307_0.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1084ui_story, var_307_4, var_307_3)

				local var_307_5 = manager.ui.mainCamera.transform.position - var_307_0.position

				var_307_0.forward = Vector3.New(var_307_5.x, var_307_5.y, var_307_5.z)

				local var_307_6 = var_307_0.localEulerAngles

				var_307_6.z = 0
				var_307_6.x = 0
				var_307_0.localEulerAngles = var_307_6
			end

			if arg_304_1.time_ >= var_307_1 + var_307_2 and arg_304_1.time_ < var_307_1 + var_307_2 + arg_307_0 then
				var_307_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_307_7 = manager.ui.mainCamera.transform.position - var_307_0.position

				var_307_0.forward = Vector3.New(var_307_7.x, var_307_7.y, var_307_7.z)

				local var_307_8 = var_307_0.localEulerAngles

				var_307_8.z = 0
				var_307_8.x = 0
				var_307_0.localEulerAngles = var_307_8
			end

			local var_307_9 = arg_304_1.actors_["1084ui_story"]
			local var_307_10 = 0

			if var_307_10 < arg_304_1.time_ and arg_304_1.time_ <= var_307_10 + arg_307_0 and not isNil(var_307_9) and arg_304_1.var_.characterEffect1084ui_story == nil then
				arg_304_1.var_.characterEffect1084ui_story = var_307_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_11 = 0.200000002980232

			if var_307_10 <= arg_304_1.time_ and arg_304_1.time_ < var_307_10 + var_307_11 and not isNil(var_307_9) then
				local var_307_12 = (arg_304_1.time_ - var_307_10) / var_307_11

				if arg_304_1.var_.characterEffect1084ui_story and not isNil(var_307_9) then
					arg_304_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_304_1.time_ >= var_307_10 + var_307_11 and arg_304_1.time_ < var_307_10 + var_307_11 + arg_307_0 and not isNil(var_307_9) and arg_304_1.var_.characterEffect1084ui_story then
				arg_304_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_307_13 = 0

			if var_307_13 < arg_304_1.time_ and arg_304_1.time_ <= var_307_13 + arg_307_0 then
				arg_304_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_307_14 = 0

			if var_307_14 < arg_304_1.time_ and arg_304_1.time_ <= var_307_14 + arg_307_0 then
				arg_304_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_307_15 = 0
			local var_307_16 = 0.775

			if var_307_15 < arg_304_1.time_ and arg_304_1.time_ <= var_307_15 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_17 = arg_304_1:FormatText(StoryNameCfg[6].name)

				arg_304_1.leftNameTxt_.text = var_307_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_18 = arg_304_1:GetWordFromCfg(1108407075)
				local var_307_19 = arg_304_1:FormatText(var_307_18.content)

				arg_304_1.text_.text = var_307_19

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_20 = 31
				local var_307_21 = utf8.len(var_307_19)
				local var_307_22 = var_307_20 <= 0 and var_307_16 or var_307_16 * (var_307_21 / var_307_20)

				if var_307_22 > 0 and var_307_16 < var_307_22 then
					arg_304_1.talkMaxDuration = var_307_22

					if var_307_22 + var_307_15 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_22 + var_307_15
					end
				end

				arg_304_1.text_.text = var_307_19
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407075", "story_v_side_new_1108407.awb") ~= 0 then
					local var_307_23 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407075", "story_v_side_new_1108407.awb") / 1000

					if var_307_23 + var_307_15 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_23 + var_307_15
					end

					if var_307_18.prefab_name ~= "" and arg_304_1.actors_[var_307_18.prefab_name] ~= nil then
						local var_307_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_18.prefab_name].transform, "story_v_side_new_1108407", "1108407075", "story_v_side_new_1108407.awb")

						arg_304_1:RecordAudio("1108407075", var_307_24)
						arg_304_1:RecordAudio("1108407075", var_307_24)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407075", "story_v_side_new_1108407.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407075", "story_v_side_new_1108407.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_25 = math.max(var_307_16, arg_304_1.talkMaxDuration)

			if var_307_15 <= arg_304_1.time_ and arg_304_1.time_ < var_307_15 + var_307_25 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_15) / var_307_25

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_15 + var_307_25 and arg_304_1.time_ < var_307_15 + var_307_25 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play1108407076 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 1108407076
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play1108407077(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["1084ui_story"]
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.characterEffect1084ui_story == nil then
				arg_308_1.var_.characterEffect1084ui_story = var_311_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_2 = 0.200000002980232

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 and not isNil(var_311_0) then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2

				if arg_308_1.var_.characterEffect1084ui_story and not isNil(var_311_0) then
					local var_311_4 = Mathf.Lerp(0, 0.5, var_311_3)

					arg_308_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_308_1.var_.characterEffect1084ui_story.fillRatio = var_311_4
				end
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.characterEffect1084ui_story then
				local var_311_5 = 0.5

				arg_308_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_308_1.var_.characterEffect1084ui_story.fillRatio = var_311_5
			end

			local var_311_6 = 0
			local var_311_7 = 0.4

			if var_311_6 < arg_308_1.time_ and arg_308_1.time_ <= var_311_6 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_8 = arg_308_1:FormatText(StoryNameCfg[7].name)

				arg_308_1.leftNameTxt_.text = var_311_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, true)
				arg_308_1.iconController_:SetSelectedState("hero")

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_9 = arg_308_1:GetWordFromCfg(1108407076)
				local var_311_10 = arg_308_1:FormatText(var_311_9.content)

				arg_308_1.text_.text = var_311_10

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_11 = 16
				local var_311_12 = utf8.len(var_311_10)
				local var_311_13 = var_311_11 <= 0 and var_311_7 or var_311_7 * (var_311_12 / var_311_11)

				if var_311_13 > 0 and var_311_7 < var_311_13 then
					arg_308_1.talkMaxDuration = var_311_13

					if var_311_13 + var_311_6 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_13 + var_311_6
					end
				end

				arg_308_1.text_.text = var_311_10
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_14 = math.max(var_311_7, arg_308_1.talkMaxDuration)

			if var_311_6 <= arg_308_1.time_ and arg_308_1.time_ < var_311_6 + var_311_14 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_6) / var_311_14

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_6 + var_311_14 and arg_308_1.time_ < var_311_6 + var_311_14 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play1108407077 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 1108407077
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play1108407078(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["1084ui_story"].transform
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 then
				arg_312_1.var_.moveOldPos1084ui_story = var_315_0.localPosition
			end

			local var_315_2 = 0.001

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2
				local var_315_4 = Vector3.New(0, 100, 0)

				var_315_0.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1084ui_story, var_315_4, var_315_3)

				local var_315_5 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_5.x, var_315_5.y, var_315_5.z)

				local var_315_6 = var_315_0.localEulerAngles

				var_315_6.z = 0
				var_315_6.x = 0
				var_315_0.localEulerAngles = var_315_6
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 then
				var_315_0.localPosition = Vector3.New(0, 100, 0)

				local var_315_7 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_7.x, var_315_7.y, var_315_7.z)

				local var_315_8 = var_315_0.localEulerAngles

				var_315_8.z = 0
				var_315_8.x = 0
				var_315_0.localEulerAngles = var_315_8
			end

			local var_315_9 = 0
			local var_315_10 = 0.975

			if var_315_9 < arg_312_1.time_ and arg_312_1.time_ <= var_315_9 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_11 = arg_312_1:GetWordFromCfg(1108407077)
				local var_315_12 = arg_312_1:FormatText(var_315_11.content)

				arg_312_1.text_.text = var_315_12

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_13 = 39
				local var_315_14 = utf8.len(var_315_12)
				local var_315_15 = var_315_13 <= 0 and var_315_10 or var_315_10 * (var_315_14 / var_315_13)

				if var_315_15 > 0 and var_315_10 < var_315_15 then
					arg_312_1.talkMaxDuration = var_315_15

					if var_315_15 + var_315_9 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_15 + var_315_9
					end
				end

				arg_312_1.text_.text = var_315_12
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_16 = math.max(var_315_10, arg_312_1.talkMaxDuration)

			if var_315_9 <= arg_312_1.time_ and arg_312_1.time_ < var_315_9 + var_315_16 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_9) / var_315_16

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_9 + var_315_16 and arg_312_1.time_ < var_315_9 + var_315_16 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play1108407078 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 1108407078
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play1108407079(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0
			local var_319_1 = 0.3

			if var_319_0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_2 = arg_316_1:FormatText(StoryNameCfg[7].name)

				arg_316_1.leftNameTxt_.text = var_319_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_3 = arg_316_1:GetWordFromCfg(1108407078)
				local var_319_4 = arg_316_1:FormatText(var_319_3.content)

				arg_316_1.text_.text = var_319_4

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_5 = 12
				local var_319_6 = utf8.len(var_319_4)
				local var_319_7 = var_319_5 <= 0 and var_319_1 or var_319_1 * (var_319_6 / var_319_5)

				if var_319_7 > 0 and var_319_1 < var_319_7 then
					arg_316_1.talkMaxDuration = var_319_7

					if var_319_7 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_7 + var_319_0
					end
				end

				arg_316_1.text_.text = var_319_4
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_8 = math.max(var_319_1, arg_316_1.talkMaxDuration)

			if var_319_0 <= arg_316_1.time_ and arg_316_1.time_ < var_319_0 + var_319_8 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_0) / var_319_8

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_0 + var_319_8 and arg_316_1.time_ < var_319_0 + var_319_8 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play1108407079 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 1108407079
		arg_320_1.duration_ = 4.8

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play1108407080(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = arg_320_1.actors_["1084ui_story"].transform
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 then
				arg_320_1.var_.moveOldPos1084ui_story = var_323_0.localPosition
			end

			local var_323_2 = 0.001

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_2 then
				local var_323_3 = (arg_320_1.time_ - var_323_1) / var_323_2
				local var_323_4 = Vector3.New(0, -0.97, -6)

				var_323_0.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos1084ui_story, var_323_4, var_323_3)

				local var_323_5 = manager.ui.mainCamera.transform.position - var_323_0.position

				var_323_0.forward = Vector3.New(var_323_5.x, var_323_5.y, var_323_5.z)

				local var_323_6 = var_323_0.localEulerAngles

				var_323_6.z = 0
				var_323_6.x = 0
				var_323_0.localEulerAngles = var_323_6
			end

			if arg_320_1.time_ >= var_323_1 + var_323_2 and arg_320_1.time_ < var_323_1 + var_323_2 + arg_323_0 then
				var_323_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_323_7 = manager.ui.mainCamera.transform.position - var_323_0.position

				var_323_0.forward = Vector3.New(var_323_7.x, var_323_7.y, var_323_7.z)

				local var_323_8 = var_323_0.localEulerAngles

				var_323_8.z = 0
				var_323_8.x = 0
				var_323_0.localEulerAngles = var_323_8
			end

			local var_323_9 = arg_320_1.actors_["1084ui_story"]
			local var_323_10 = 0

			if var_323_10 < arg_320_1.time_ and arg_320_1.time_ <= var_323_10 + arg_323_0 and not isNil(var_323_9) and arg_320_1.var_.characterEffect1084ui_story == nil then
				arg_320_1.var_.characterEffect1084ui_story = var_323_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_11 = 0.200000002980232

			if var_323_10 <= arg_320_1.time_ and arg_320_1.time_ < var_323_10 + var_323_11 and not isNil(var_323_9) then
				local var_323_12 = (arg_320_1.time_ - var_323_10) / var_323_11

				if arg_320_1.var_.characterEffect1084ui_story and not isNil(var_323_9) then
					arg_320_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_320_1.time_ >= var_323_10 + var_323_11 and arg_320_1.time_ < var_323_10 + var_323_11 + arg_323_0 and not isNil(var_323_9) and arg_320_1.var_.characterEffect1084ui_story then
				arg_320_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_323_13 = 0

			if var_323_13 < arg_320_1.time_ and arg_320_1.time_ <= var_323_13 + arg_323_0 then
				arg_320_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_323_14 = 0

			if var_323_14 < arg_320_1.time_ and arg_320_1.time_ <= var_323_14 + arg_323_0 then
				arg_320_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_323_15 = 0
			local var_323_16 = 0.45

			if var_323_15 < arg_320_1.time_ and arg_320_1.time_ <= var_323_15 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_17 = arg_320_1:FormatText(StoryNameCfg[6].name)

				arg_320_1.leftNameTxt_.text = var_323_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_18 = arg_320_1:GetWordFromCfg(1108407079)
				local var_323_19 = arg_320_1:FormatText(var_323_18.content)

				arg_320_1.text_.text = var_323_19

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_20 = 18
				local var_323_21 = utf8.len(var_323_19)
				local var_323_22 = var_323_20 <= 0 and var_323_16 or var_323_16 * (var_323_21 / var_323_20)

				if var_323_22 > 0 and var_323_16 < var_323_22 then
					arg_320_1.talkMaxDuration = var_323_22

					if var_323_22 + var_323_15 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_22 + var_323_15
					end
				end

				arg_320_1.text_.text = var_323_19
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407079", "story_v_side_new_1108407.awb") ~= 0 then
					local var_323_23 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407079", "story_v_side_new_1108407.awb") / 1000

					if var_323_23 + var_323_15 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_23 + var_323_15
					end

					if var_323_18.prefab_name ~= "" and arg_320_1.actors_[var_323_18.prefab_name] ~= nil then
						local var_323_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_18.prefab_name].transform, "story_v_side_new_1108407", "1108407079", "story_v_side_new_1108407.awb")

						arg_320_1:RecordAudio("1108407079", var_323_24)
						arg_320_1:RecordAudio("1108407079", var_323_24)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407079", "story_v_side_new_1108407.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407079", "story_v_side_new_1108407.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_25 = math.max(var_323_16, arg_320_1.talkMaxDuration)

			if var_323_15 <= arg_320_1.time_ and arg_320_1.time_ < var_323_15 + var_323_25 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_15) / var_323_25

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_15 + var_323_25 and arg_320_1.time_ < var_323_15 + var_323_25 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_320_1:InitPlayNodeList()
	end,
	Play1108407080 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 1108407080
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play1108407081(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = arg_324_1.actors_["1084ui_story"]
			local var_327_1 = 0

			if var_327_1 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect1084ui_story == nil then
				arg_324_1.var_.characterEffect1084ui_story = var_327_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_2 = 0.200000002980232

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_2 and not isNil(var_327_0) then
				local var_327_3 = (arg_324_1.time_ - var_327_1) / var_327_2

				if arg_324_1.var_.characterEffect1084ui_story and not isNil(var_327_0) then
					local var_327_4 = Mathf.Lerp(0, 0.5, var_327_3)

					arg_324_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_324_1.var_.characterEffect1084ui_story.fillRatio = var_327_4
				end
			end

			if arg_324_1.time_ >= var_327_1 + var_327_2 and arg_324_1.time_ < var_327_1 + var_327_2 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect1084ui_story then
				local var_327_5 = 0.5

				arg_324_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_324_1.var_.characterEffect1084ui_story.fillRatio = var_327_5
			end

			local var_327_6 = 0
			local var_327_7 = 0.3

			if var_327_6 < arg_324_1.time_ and arg_324_1.time_ <= var_327_6 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_8 = arg_324_1:FormatText(StoryNameCfg[7].name)

				arg_324_1.leftNameTxt_.text = var_327_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_9 = arg_324_1:GetWordFromCfg(1108407080)
				local var_327_10 = arg_324_1:FormatText(var_327_9.content)

				arg_324_1.text_.text = var_327_10

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_11 = 12
				local var_327_12 = utf8.len(var_327_10)
				local var_327_13 = var_327_11 <= 0 and var_327_7 or var_327_7 * (var_327_12 / var_327_11)

				if var_327_13 > 0 and var_327_7 < var_327_13 then
					arg_324_1.talkMaxDuration = var_327_13

					if var_327_13 + var_327_6 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_13 + var_327_6
					end
				end

				arg_324_1.text_.text = var_327_10
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_14 = math.max(var_327_7, arg_324_1.talkMaxDuration)

			if var_327_6 <= arg_324_1.time_ and arg_324_1.time_ < var_327_6 + var_327_14 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_6) / var_327_14

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_6 + var_327_14 and arg_324_1.time_ < var_327_6 + var_327_14 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play1108407081 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 1108407081
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play1108407082(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = "ST2105"

			if arg_328_1.bgs_[var_331_0] == nil then
				local var_331_1 = Object.Instantiate(arg_328_1.paintGo_)

				var_331_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_331_0)
				var_331_1.name = var_331_0
				var_331_1.transform.parent = arg_328_1.stage_.transform
				var_331_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_328_1.bgs_[var_331_0] = var_331_1
			end

			local var_331_2 = 0

			if var_331_2 < arg_328_1.time_ and arg_328_1.time_ <= var_331_2 + arg_331_0 then
				local var_331_3 = manager.ui.mainCamera.transform.localPosition
				local var_331_4 = Vector3.New(0, 0, 10) + Vector3.New(var_331_3.x, var_331_3.y, 0)
				local var_331_5 = arg_328_1.bgs_.ST2105

				var_331_5.transform.localPosition = var_331_4
				var_331_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_331_6 = var_331_5:GetComponent("SpriteRenderer")

				if var_331_6 and var_331_6.sprite then
					local var_331_7 = (var_331_5.transform.localPosition - var_331_3).z
					local var_331_8 = manager.ui.mainCameraCom_
					local var_331_9 = 2 * var_331_7 * Mathf.Tan(var_331_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_331_10 = var_331_9 * var_331_8.aspect
					local var_331_11 = var_331_6.sprite.bounds.size.x
					local var_331_12 = var_331_6.sprite.bounds.size.y
					local var_331_13 = var_331_10 / var_331_11
					local var_331_14 = var_331_9 / var_331_12
					local var_331_15 = var_331_14 < var_331_13 and var_331_13 or var_331_14

					var_331_5.transform.localScale = Vector3.New(var_331_15, var_331_15, 0)
				end

				for iter_331_0, iter_331_1 in pairs(arg_328_1.bgs_) do
					if iter_331_0 ~= "ST2105" then
						iter_331_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_331_16 = 0

			if var_331_16 < arg_328_1.time_ and arg_328_1.time_ <= var_331_16 + arg_331_0 then
				arg_328_1.allBtn_.enabled = false
			end

			local var_331_17 = 0.3

			if arg_328_1.time_ >= var_331_16 + var_331_17 and arg_328_1.time_ < var_331_16 + var_331_17 + arg_331_0 then
				arg_328_1.allBtn_.enabled = true
			end

			local var_331_18 = 0

			if var_331_18 < arg_328_1.time_ and arg_328_1.time_ <= var_331_18 + arg_331_0 then
				arg_328_1.mask_.enabled = true
				arg_328_1.mask_.raycastTarget = true

				arg_328_1:SetGaussion(false)
			end

			local var_331_19 = 2

			if var_331_18 <= arg_328_1.time_ and arg_328_1.time_ < var_331_18 + var_331_19 then
				local var_331_20 = (arg_328_1.time_ - var_331_18) / var_331_19
				local var_331_21 = Color.New(0, 0, 0)

				var_331_21.a = Mathf.Lerp(1, 0, var_331_20)
				arg_328_1.mask_.color = var_331_21
			end

			if arg_328_1.time_ >= var_331_18 + var_331_19 and arg_328_1.time_ < var_331_18 + var_331_19 + arg_331_0 then
				local var_331_22 = Color.New(0, 0, 0)
				local var_331_23 = 0

				arg_328_1.mask_.enabled = false
				var_331_22.a = var_331_23
				arg_328_1.mask_.color = var_331_22
			end

			local var_331_24 = arg_328_1.actors_["1084ui_story"].transform
			local var_331_25 = 0

			if var_331_25 < arg_328_1.time_ and arg_328_1.time_ <= var_331_25 + arg_331_0 then
				arg_328_1.var_.moveOldPos1084ui_story = var_331_24.localPosition
			end

			local var_331_26 = 0.001

			if var_331_25 <= arg_328_1.time_ and arg_328_1.time_ < var_331_25 + var_331_26 then
				local var_331_27 = (arg_328_1.time_ - var_331_25) / var_331_26
				local var_331_28 = Vector3.New(0, 100, 0)

				var_331_24.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos1084ui_story, var_331_28, var_331_27)

				local var_331_29 = manager.ui.mainCamera.transform.position - var_331_24.position

				var_331_24.forward = Vector3.New(var_331_29.x, var_331_29.y, var_331_29.z)

				local var_331_30 = var_331_24.localEulerAngles

				var_331_30.z = 0
				var_331_30.x = 0
				var_331_24.localEulerAngles = var_331_30
			end

			if arg_328_1.time_ >= var_331_25 + var_331_26 and arg_328_1.time_ < var_331_25 + var_331_26 + arg_331_0 then
				var_331_24.localPosition = Vector3.New(0, 100, 0)

				local var_331_31 = manager.ui.mainCamera.transform.position - var_331_24.position

				var_331_24.forward = Vector3.New(var_331_31.x, var_331_31.y, var_331_31.z)

				local var_331_32 = var_331_24.localEulerAngles

				var_331_32.z = 0
				var_331_32.x = 0
				var_331_24.localEulerAngles = var_331_32
			end

			local var_331_33 = 0
			local var_331_34 = 1.225

			if var_331_33 < arg_328_1.time_ and arg_328_1.time_ <= var_331_33 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0

				arg_328_1.dialog_:SetActive(true)

				arg_328_1.dialogCg_.alpha = 0

				local var_331_35 = LeanTween.value(arg_328_1.dialog_, 0, 1, 0.3)

				var_331_35:setOnUpdate(LuaHelper.FloatAction(function(arg_332_0)
					arg_328_1.dialogCg_.alpha = arg_332_0
				end))
				var_331_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_328_1.dialog_)
					var_331_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_328_1.duration_ = arg_328_1.duration_ + 0.3

				SetActive(arg_328_1.leftNameGo_, false)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_36 = arg_328_1:GetWordFromCfg(1108407081)
				local var_331_37 = arg_328_1:FormatText(var_331_36.content)

				arg_328_1.text_.text = var_331_37

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_38 = 49
				local var_331_39 = utf8.len(var_331_37)
				local var_331_40 = var_331_38 <= 0 and var_331_34 or var_331_34 * (var_331_39 / var_331_38)

				if var_331_40 > 0 and var_331_34 < var_331_40 then
					arg_328_1.talkMaxDuration = var_331_40
					var_331_33 = var_331_33 + 0.3

					if var_331_40 + var_331_33 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_40 + var_331_33
					end
				end

				arg_328_1.text_.text = var_331_37
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_41 = var_331_33 + 0.3
			local var_331_42 = math.max(var_331_34, arg_328_1.talkMaxDuration)

			if var_331_41 <= arg_328_1.time_ and arg_328_1.time_ < var_331_41 + var_331_42 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_41) / var_331_42

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_41 + var_331_42 and arg_328_1.time_ < var_331_41 + var_331_42 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_328_1:InitPlayNodeList()
	end,
	Play1108407082 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 1108407082
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play1108407083(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0
			local var_337_1 = 0.7

			if var_337_0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_2 = arg_334_1:GetWordFromCfg(1108407082)
				local var_337_3 = arg_334_1:FormatText(var_337_2.content)

				arg_334_1.text_.text = var_337_3

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_4 = 28
				local var_337_5 = utf8.len(var_337_3)
				local var_337_6 = var_337_4 <= 0 and var_337_1 or var_337_1 * (var_337_5 / var_337_4)

				if var_337_6 > 0 and var_337_1 < var_337_6 then
					arg_334_1.talkMaxDuration = var_337_6

					if var_337_6 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_6 + var_337_0
					end
				end

				arg_334_1.text_.text = var_337_3
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_7 = math.max(var_337_1, arg_334_1.talkMaxDuration)

			if var_337_0 <= arg_334_1.time_ and arg_334_1.time_ < var_337_0 + var_337_7 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_0) / var_337_7

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_0 + var_337_7 and arg_334_1.time_ < var_337_0 + var_337_7 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play1108407083 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 1108407083
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play1108407084(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0
			local var_341_1 = 0.5

			if var_341_0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_2 = arg_338_1:FormatText(StoryNameCfg[7].name)

				arg_338_1.leftNameTxt_.text = var_341_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_3 = arg_338_1:GetWordFromCfg(1108407083)
				local var_341_4 = arg_338_1:FormatText(var_341_3.content)

				arg_338_1.text_.text = var_341_4

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_5 = 20
				local var_341_6 = utf8.len(var_341_4)
				local var_341_7 = var_341_5 <= 0 and var_341_1 or var_341_1 * (var_341_6 / var_341_5)

				if var_341_7 > 0 and var_341_1 < var_341_7 then
					arg_338_1.talkMaxDuration = var_341_7

					if var_341_7 + var_341_0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_7 + var_341_0
					end
				end

				arg_338_1.text_.text = var_341_4
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_8 = math.max(var_341_1, arg_338_1.talkMaxDuration)

			if var_341_0 <= arg_338_1.time_ and arg_338_1.time_ < var_341_0 + var_341_8 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_0) / var_341_8

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_0 + var_341_8 and arg_338_1.time_ < var_341_0 + var_341_8 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play1108407084 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 1108407084
		arg_342_1.duration_ = 2.97

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play1108407085(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["1084ui_story"].transform
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 then
				arg_342_1.var_.moveOldPos1084ui_story = var_345_0.localPosition
			end

			local var_345_2 = 0.001

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2
				local var_345_4 = Vector3.New(0, -0.97, -6)

				var_345_0.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos1084ui_story, var_345_4, var_345_3)

				local var_345_5 = manager.ui.mainCamera.transform.position - var_345_0.position

				var_345_0.forward = Vector3.New(var_345_5.x, var_345_5.y, var_345_5.z)

				local var_345_6 = var_345_0.localEulerAngles

				var_345_6.z = 0
				var_345_6.x = 0
				var_345_0.localEulerAngles = var_345_6
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 then
				var_345_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_345_7 = manager.ui.mainCamera.transform.position - var_345_0.position

				var_345_0.forward = Vector3.New(var_345_7.x, var_345_7.y, var_345_7.z)

				local var_345_8 = var_345_0.localEulerAngles

				var_345_8.z = 0
				var_345_8.x = 0
				var_345_0.localEulerAngles = var_345_8
			end

			local var_345_9 = arg_342_1.actors_["1084ui_story"]
			local var_345_10 = 0

			if var_345_10 < arg_342_1.time_ and arg_342_1.time_ <= var_345_10 + arg_345_0 and not isNil(var_345_9) and arg_342_1.var_.characterEffect1084ui_story == nil then
				arg_342_1.var_.characterEffect1084ui_story = var_345_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_11 = 0.200000002980232

			if var_345_10 <= arg_342_1.time_ and arg_342_1.time_ < var_345_10 + var_345_11 and not isNil(var_345_9) then
				local var_345_12 = (arg_342_1.time_ - var_345_10) / var_345_11

				if arg_342_1.var_.characterEffect1084ui_story and not isNil(var_345_9) then
					arg_342_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_342_1.time_ >= var_345_10 + var_345_11 and arg_342_1.time_ < var_345_10 + var_345_11 + arg_345_0 and not isNil(var_345_9) and arg_342_1.var_.characterEffect1084ui_story then
				arg_342_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_345_13 = 0

			if var_345_13 < arg_342_1.time_ and arg_342_1.time_ <= var_345_13 + arg_345_0 then
				arg_342_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_345_14 = 0

			if var_345_14 < arg_342_1.time_ and arg_342_1.time_ <= var_345_14 + arg_345_0 then
				arg_342_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_345_15 = 0
			local var_345_16 = 0.55

			if var_345_15 < arg_342_1.time_ and arg_342_1.time_ <= var_345_15 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_17 = arg_342_1:FormatText(StoryNameCfg[6].name)

				arg_342_1.leftNameTxt_.text = var_345_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_18 = arg_342_1:GetWordFromCfg(1108407084)
				local var_345_19 = arg_342_1:FormatText(var_345_18.content)

				arg_342_1.text_.text = var_345_19

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_20 = 22
				local var_345_21 = utf8.len(var_345_19)
				local var_345_22 = var_345_20 <= 0 and var_345_16 or var_345_16 * (var_345_21 / var_345_20)

				if var_345_22 > 0 and var_345_16 < var_345_22 then
					arg_342_1.talkMaxDuration = var_345_22

					if var_345_22 + var_345_15 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_22 + var_345_15
					end
				end

				arg_342_1.text_.text = var_345_19
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407084", "story_v_side_new_1108407.awb") ~= 0 then
					local var_345_23 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407084", "story_v_side_new_1108407.awb") / 1000

					if var_345_23 + var_345_15 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_23 + var_345_15
					end

					if var_345_18.prefab_name ~= "" and arg_342_1.actors_[var_345_18.prefab_name] ~= nil then
						local var_345_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_18.prefab_name].transform, "story_v_side_new_1108407", "1108407084", "story_v_side_new_1108407.awb")

						arg_342_1:RecordAudio("1108407084", var_345_24)
						arg_342_1:RecordAudio("1108407084", var_345_24)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407084", "story_v_side_new_1108407.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407084", "story_v_side_new_1108407.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_25 = math.max(var_345_16, arg_342_1.talkMaxDuration)

			if var_345_15 <= arg_342_1.time_ and arg_342_1.time_ < var_345_15 + var_345_25 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_15) / var_345_25

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_15 + var_345_25 and arg_342_1.time_ < var_345_15 + var_345_25 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	Play1108407085 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 1108407085
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play1108407086(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["1084ui_story"]
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.characterEffect1084ui_story == nil then
				arg_346_1.var_.characterEffect1084ui_story = var_349_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_2 = 0.200000002980232

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_2 and not isNil(var_349_0) then
				local var_349_3 = (arg_346_1.time_ - var_349_1) / var_349_2

				if arg_346_1.var_.characterEffect1084ui_story and not isNil(var_349_0) then
					local var_349_4 = Mathf.Lerp(0, 0.5, var_349_3)

					arg_346_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_346_1.var_.characterEffect1084ui_story.fillRatio = var_349_4
				end
			end

			if arg_346_1.time_ >= var_349_1 + var_349_2 and arg_346_1.time_ < var_349_1 + var_349_2 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.characterEffect1084ui_story then
				local var_349_5 = 0.5

				arg_346_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_346_1.var_.characterEffect1084ui_story.fillRatio = var_349_5
			end

			local var_349_6 = 0
			local var_349_7 = 0.7

			if var_349_6 < arg_346_1.time_ and arg_346_1.time_ <= var_349_6 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_8 = arg_346_1:FormatText(StoryNameCfg[7].name)

				arg_346_1.leftNameTxt_.text = var_349_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_9 = arg_346_1:GetWordFromCfg(1108407085)
				local var_349_10 = arg_346_1:FormatText(var_349_9.content)

				arg_346_1.text_.text = var_349_10

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_11 = 28
				local var_349_12 = utf8.len(var_349_10)
				local var_349_13 = var_349_11 <= 0 and var_349_7 or var_349_7 * (var_349_12 / var_349_11)

				if var_349_13 > 0 and var_349_7 < var_349_13 then
					arg_346_1.talkMaxDuration = var_349_13

					if var_349_13 + var_349_6 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_13 + var_349_6
					end
				end

				arg_346_1.text_.text = var_349_10
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_14 = math.max(var_349_7, arg_346_1.talkMaxDuration)

			if var_349_6 <= arg_346_1.time_ and arg_346_1.time_ < var_349_6 + var_349_14 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_6) / var_349_14

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_6 + var_349_14 and arg_346_1.time_ < var_349_6 + var_349_14 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play1108407086 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 1108407086
		arg_350_1.duration_ = 7.8

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play1108407087(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["1084ui_story"]
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.characterEffect1084ui_story == nil then
				arg_350_1.var_.characterEffect1084ui_story = var_353_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_2 = 0.200000002980232

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 and not isNil(var_353_0) then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2

				if arg_350_1.var_.characterEffect1084ui_story and not isNil(var_353_0) then
					arg_350_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.characterEffect1084ui_story then
				arg_350_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_353_4 = 0

			if var_353_4 < arg_350_1.time_ and arg_350_1.time_ <= var_353_4 + arg_353_0 then
				arg_350_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_353_5 = 0

			if var_353_5 < arg_350_1.time_ and arg_350_1.time_ <= var_353_5 + arg_353_0 then
				arg_350_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_353_6 = 0
			local var_353_7 = 0.775

			if var_353_6 < arg_350_1.time_ and arg_350_1.time_ <= var_353_6 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_8 = arg_350_1:FormatText(StoryNameCfg[6].name)

				arg_350_1.leftNameTxt_.text = var_353_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_9 = arg_350_1:GetWordFromCfg(1108407086)
				local var_353_10 = arg_350_1:FormatText(var_353_9.content)

				arg_350_1.text_.text = var_353_10

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_11 = 31
				local var_353_12 = utf8.len(var_353_10)
				local var_353_13 = var_353_11 <= 0 and var_353_7 or var_353_7 * (var_353_12 / var_353_11)

				if var_353_13 > 0 and var_353_7 < var_353_13 then
					arg_350_1.talkMaxDuration = var_353_13

					if var_353_13 + var_353_6 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_13 + var_353_6
					end
				end

				arg_350_1.text_.text = var_353_10
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407086", "story_v_side_new_1108407.awb") ~= 0 then
					local var_353_14 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407086", "story_v_side_new_1108407.awb") / 1000

					if var_353_14 + var_353_6 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_14 + var_353_6
					end

					if var_353_9.prefab_name ~= "" and arg_350_1.actors_[var_353_9.prefab_name] ~= nil then
						local var_353_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_9.prefab_name].transform, "story_v_side_new_1108407", "1108407086", "story_v_side_new_1108407.awb")

						arg_350_1:RecordAudio("1108407086", var_353_15)
						arg_350_1:RecordAudio("1108407086", var_353_15)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407086", "story_v_side_new_1108407.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407086", "story_v_side_new_1108407.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_16 = math.max(var_353_7, arg_350_1.talkMaxDuration)

			if var_353_6 <= arg_350_1.time_ and arg_350_1.time_ < var_353_6 + var_353_16 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_6) / var_353_16

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_6 + var_353_16 and arg_350_1.time_ < var_353_6 + var_353_16 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play1108407087 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 1108407087
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play1108407088(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["1084ui_story"]
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect1084ui_story == nil then
				arg_354_1.var_.characterEffect1084ui_story = var_357_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_2 = 0.200000002980232

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 and not isNil(var_357_0) then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2

				if arg_354_1.var_.characterEffect1084ui_story and not isNil(var_357_0) then
					local var_357_4 = Mathf.Lerp(0, 0.5, var_357_3)

					arg_354_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_354_1.var_.characterEffect1084ui_story.fillRatio = var_357_4
				end
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect1084ui_story then
				local var_357_5 = 0.5

				arg_354_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_354_1.var_.characterEffect1084ui_story.fillRatio = var_357_5
			end

			local var_357_6 = 0
			local var_357_7 = 0.75

			if var_357_6 < arg_354_1.time_ and arg_354_1.time_ <= var_357_6 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_8 = arg_354_1:FormatText(StoryNameCfg[7].name)

				arg_354_1.leftNameTxt_.text = var_357_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, true)
				arg_354_1.iconController_:SetSelectedState("hero")

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_9 = arg_354_1:GetWordFromCfg(1108407087)
				local var_357_10 = arg_354_1:FormatText(var_357_9.content)

				arg_354_1.text_.text = var_357_10

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_11 = 30
				local var_357_12 = utf8.len(var_357_10)
				local var_357_13 = var_357_11 <= 0 and var_357_7 or var_357_7 * (var_357_12 / var_357_11)

				if var_357_13 > 0 and var_357_7 < var_357_13 then
					arg_354_1.talkMaxDuration = var_357_13

					if var_357_13 + var_357_6 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_13 + var_357_6
					end
				end

				arg_354_1.text_.text = var_357_10
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_14 = math.max(var_357_7, arg_354_1.talkMaxDuration)

			if var_357_6 <= arg_354_1.time_ and arg_354_1.time_ < var_357_6 + var_357_14 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_6) / var_357_14

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_6 + var_357_14 and arg_354_1.time_ < var_357_6 + var_357_14 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play1108407088 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 1108407088
		arg_358_1.duration_ = 9.87

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play1108407089(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0
			local var_361_1 = 1.3

			if var_361_0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_2 = arg_358_1:FormatText(StoryNameCfg[672].name)

				arg_358_1.leftNameTxt_.text = var_361_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_3 = arg_358_1:GetWordFromCfg(1108407088)
				local var_361_4 = arg_358_1:FormatText(var_361_3.content)

				arg_358_1.text_.text = var_361_4

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_5 = 52
				local var_361_6 = utf8.len(var_361_4)
				local var_361_7 = var_361_5 <= 0 and var_361_1 or var_361_1 * (var_361_6 / var_361_5)

				if var_361_7 > 0 and var_361_1 < var_361_7 then
					arg_358_1.talkMaxDuration = var_361_7

					if var_361_7 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_7 + var_361_0
					end
				end

				arg_358_1.text_.text = var_361_4
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407088", "story_v_side_new_1108407.awb") ~= 0 then
					local var_361_8 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407088", "story_v_side_new_1108407.awb") / 1000

					if var_361_8 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_8 + var_361_0
					end

					if var_361_3.prefab_name ~= "" and arg_358_1.actors_[var_361_3.prefab_name] ~= nil then
						local var_361_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_3.prefab_name].transform, "story_v_side_new_1108407", "1108407088", "story_v_side_new_1108407.awb")

						arg_358_1:RecordAudio("1108407088", var_361_9)
						arg_358_1:RecordAudio("1108407088", var_361_9)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407088", "story_v_side_new_1108407.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407088", "story_v_side_new_1108407.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_10 = math.max(var_361_1, arg_358_1.talkMaxDuration)

			if var_361_0 <= arg_358_1.time_ and arg_358_1.time_ < var_361_0 + var_361_10 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_0) / var_361_10

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_0 + var_361_10 and arg_358_1.time_ < var_361_0 + var_361_10 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play1108407089 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 1108407089
		arg_362_1.duration_ = 9.97

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play1108407090(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0
			local var_365_1 = 1.225

			if var_365_0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_2 = arg_362_1:FormatText(StoryNameCfg[672].name)

				arg_362_1.leftNameTxt_.text = var_365_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_3 = arg_362_1:GetWordFromCfg(1108407089)
				local var_365_4 = arg_362_1:FormatText(var_365_3.content)

				arg_362_1.text_.text = var_365_4

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_5 = 49
				local var_365_6 = utf8.len(var_365_4)
				local var_365_7 = var_365_5 <= 0 and var_365_1 or var_365_1 * (var_365_6 / var_365_5)

				if var_365_7 > 0 and var_365_1 < var_365_7 then
					arg_362_1.talkMaxDuration = var_365_7

					if var_365_7 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_7 + var_365_0
					end
				end

				arg_362_1.text_.text = var_365_4
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407089", "story_v_side_new_1108407.awb") ~= 0 then
					local var_365_8 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407089", "story_v_side_new_1108407.awb") / 1000

					if var_365_8 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_8 + var_365_0
					end

					if var_365_3.prefab_name ~= "" and arg_362_1.actors_[var_365_3.prefab_name] ~= nil then
						local var_365_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_3.prefab_name].transform, "story_v_side_new_1108407", "1108407089", "story_v_side_new_1108407.awb")

						arg_362_1:RecordAudio("1108407089", var_365_9)
						arg_362_1:RecordAudio("1108407089", var_365_9)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407089", "story_v_side_new_1108407.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407089", "story_v_side_new_1108407.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_10 = math.max(var_365_1, arg_362_1.talkMaxDuration)

			if var_365_0 <= arg_362_1.time_ and arg_362_1.time_ < var_365_0 + var_365_10 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_0) / var_365_10

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_0 + var_365_10 and arg_362_1.time_ < var_365_0 + var_365_10 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play1108407090 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 1108407090
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play1108407091(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["1084ui_story"].transform
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 then
				arg_366_1.var_.moveOldPos1084ui_story = var_369_0.localPosition
			end

			local var_369_2 = 0.001

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_2 then
				local var_369_3 = (arg_366_1.time_ - var_369_1) / var_369_2
				local var_369_4 = Vector3.New(0, 100, 0)

				var_369_0.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos1084ui_story, var_369_4, var_369_3)

				local var_369_5 = manager.ui.mainCamera.transform.position - var_369_0.position

				var_369_0.forward = Vector3.New(var_369_5.x, var_369_5.y, var_369_5.z)

				local var_369_6 = var_369_0.localEulerAngles

				var_369_6.z = 0
				var_369_6.x = 0
				var_369_0.localEulerAngles = var_369_6
			end

			if arg_366_1.time_ >= var_369_1 + var_369_2 and arg_366_1.time_ < var_369_1 + var_369_2 + arg_369_0 then
				var_369_0.localPosition = Vector3.New(0, 100, 0)

				local var_369_7 = manager.ui.mainCamera.transform.position - var_369_0.position

				var_369_0.forward = Vector3.New(var_369_7.x, var_369_7.y, var_369_7.z)

				local var_369_8 = var_369_0.localEulerAngles

				var_369_8.z = 0
				var_369_8.x = 0
				var_369_0.localEulerAngles = var_369_8
			end

			local var_369_9 = 0
			local var_369_10 = 1.525

			if var_369_9 < arg_366_1.time_ and arg_366_1.time_ <= var_369_9 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, false)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_11 = arg_366_1:GetWordFromCfg(1108407090)
				local var_369_12 = arg_366_1:FormatText(var_369_11.content)

				arg_366_1.text_.text = var_369_12

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_13 = 61
				local var_369_14 = utf8.len(var_369_12)
				local var_369_15 = var_369_13 <= 0 and var_369_10 or var_369_10 * (var_369_14 / var_369_13)

				if var_369_15 > 0 and var_369_10 < var_369_15 then
					arg_366_1.talkMaxDuration = var_369_15

					if var_369_15 + var_369_9 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_15 + var_369_9
					end
				end

				arg_366_1.text_.text = var_369_12
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_16 = math.max(var_369_10, arg_366_1.talkMaxDuration)

			if var_369_9 <= arg_366_1.time_ and arg_366_1.time_ < var_369_9 + var_369_16 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_9) / var_369_16

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_9 + var_369_16 and arg_366_1.time_ < var_369_9 + var_369_16 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_366_1:InitPlayNodeList()
	end,
	Play1108407091 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 1108407091
		arg_370_1.duration_ = 2

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play1108407092(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = arg_370_1.actors_["1084ui_story"].transform
			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 then
				arg_370_1.var_.moveOldPos1084ui_story = var_373_0.localPosition
			end

			local var_373_2 = 0.001

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_2 then
				local var_373_3 = (arg_370_1.time_ - var_373_1) / var_373_2
				local var_373_4 = Vector3.New(0, -0.97, -6)

				var_373_0.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos1084ui_story, var_373_4, var_373_3)

				local var_373_5 = manager.ui.mainCamera.transform.position - var_373_0.position

				var_373_0.forward = Vector3.New(var_373_5.x, var_373_5.y, var_373_5.z)

				local var_373_6 = var_373_0.localEulerAngles

				var_373_6.z = 0
				var_373_6.x = 0
				var_373_0.localEulerAngles = var_373_6
			end

			if arg_370_1.time_ >= var_373_1 + var_373_2 and arg_370_1.time_ < var_373_1 + var_373_2 + arg_373_0 then
				var_373_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_373_7 = manager.ui.mainCamera.transform.position - var_373_0.position

				var_373_0.forward = Vector3.New(var_373_7.x, var_373_7.y, var_373_7.z)

				local var_373_8 = var_373_0.localEulerAngles

				var_373_8.z = 0
				var_373_8.x = 0
				var_373_0.localEulerAngles = var_373_8
			end

			local var_373_9 = 0

			if var_373_9 < arg_370_1.time_ and arg_370_1.time_ <= var_373_9 + arg_373_0 then
				arg_370_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_373_10 = 0

			if var_373_10 < arg_370_1.time_ and arg_370_1.time_ <= var_373_10 + arg_373_0 then
				arg_370_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_373_11 = arg_370_1.actors_["1084ui_story"]
			local var_373_12 = 0

			if var_373_12 < arg_370_1.time_ and arg_370_1.time_ <= var_373_12 + arg_373_0 and not isNil(var_373_11) and arg_370_1.var_.characterEffect1084ui_story == nil then
				arg_370_1.var_.characterEffect1084ui_story = var_373_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_13 = 0.200000002980232

			if var_373_12 <= arg_370_1.time_ and arg_370_1.time_ < var_373_12 + var_373_13 and not isNil(var_373_11) then
				local var_373_14 = (arg_370_1.time_ - var_373_12) / var_373_13

				if arg_370_1.var_.characterEffect1084ui_story and not isNil(var_373_11) then
					arg_370_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_370_1.time_ >= var_373_12 + var_373_13 and arg_370_1.time_ < var_373_12 + var_373_13 + arg_373_0 and not isNil(var_373_11) and arg_370_1.var_.characterEffect1084ui_story then
				arg_370_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_373_15 = 0
			local var_373_16 = 0.05

			if var_373_15 < arg_370_1.time_ and arg_370_1.time_ <= var_373_15 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_17 = arg_370_1:FormatText(StoryNameCfg[334].name)

				arg_370_1.leftNameTxt_.text = var_373_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_18 = arg_370_1:GetWordFromCfg(1108407091)
				local var_373_19 = arg_370_1:FormatText(var_373_18.content)

				arg_370_1.text_.text = var_373_19

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_20 = 2
				local var_373_21 = utf8.len(var_373_19)
				local var_373_22 = var_373_20 <= 0 and var_373_16 or var_373_16 * (var_373_21 / var_373_20)

				if var_373_22 > 0 and var_373_16 < var_373_22 then
					arg_370_1.talkMaxDuration = var_373_22

					if var_373_22 + var_373_15 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_22 + var_373_15
					end
				end

				arg_370_1.text_.text = var_373_19
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407091", "story_v_side_new_1108407.awb") ~= 0 then
					local var_373_23 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407091", "story_v_side_new_1108407.awb") / 1000

					if var_373_23 + var_373_15 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_23 + var_373_15
					end

					if var_373_18.prefab_name ~= "" and arg_370_1.actors_[var_373_18.prefab_name] ~= nil then
						local var_373_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_18.prefab_name].transform, "story_v_side_new_1108407", "1108407091", "story_v_side_new_1108407.awb")

						arg_370_1:RecordAudio("1108407091", var_373_24)
						arg_370_1:RecordAudio("1108407091", var_373_24)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407091", "story_v_side_new_1108407.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407091", "story_v_side_new_1108407.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_25 = math.max(var_373_16, arg_370_1.talkMaxDuration)

			if var_373_15 <= arg_370_1.time_ and arg_370_1.time_ < var_373_15 + var_373_25 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_15) / var_373_25

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_15 + var_373_25 and arg_370_1.time_ < var_373_15 + var_373_25 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_370_1:InitPlayNodeList()
	end,
	Play1108407092 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 1108407092
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play1108407093(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = arg_374_1.actors_["1084ui_story"]
			local var_377_1 = 0

			if var_377_1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.characterEffect1084ui_story == nil then
				arg_374_1.var_.characterEffect1084ui_story = var_377_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_2 = 0.200000002980232

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_2 and not isNil(var_377_0) then
				local var_377_3 = (arg_374_1.time_ - var_377_1) / var_377_2

				if arg_374_1.var_.characterEffect1084ui_story and not isNil(var_377_0) then
					local var_377_4 = Mathf.Lerp(0, 0.5, var_377_3)

					arg_374_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_374_1.var_.characterEffect1084ui_story.fillRatio = var_377_4
				end
			end

			if arg_374_1.time_ >= var_377_1 + var_377_2 and arg_374_1.time_ < var_377_1 + var_377_2 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.characterEffect1084ui_story then
				local var_377_5 = 0.5

				arg_374_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_374_1.var_.characterEffect1084ui_story.fillRatio = var_377_5
			end

			local var_377_6 = 0
			local var_377_7 = 0.325

			if var_377_6 < arg_374_1.time_ and arg_374_1.time_ <= var_377_6 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_8 = arg_374_1:FormatText(StoryNameCfg[7].name)

				arg_374_1.leftNameTxt_.text = var_377_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, true)
				arg_374_1.iconController_:SetSelectedState("hero")

				arg_374_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_374_1.callingController_:SetSelectedState("normal")

				arg_374_1.keyicon_.color = Color.New(1, 1, 1)
				arg_374_1.icon_.color = Color.New(1, 1, 1)

				local var_377_9 = arg_374_1:GetWordFromCfg(1108407092)
				local var_377_10 = arg_374_1:FormatText(var_377_9.content)

				arg_374_1.text_.text = var_377_10

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_11 = 13
				local var_377_12 = utf8.len(var_377_10)
				local var_377_13 = var_377_11 <= 0 and var_377_7 or var_377_7 * (var_377_12 / var_377_11)

				if var_377_13 > 0 and var_377_7 < var_377_13 then
					arg_374_1.talkMaxDuration = var_377_13

					if var_377_13 + var_377_6 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_13 + var_377_6
					end
				end

				arg_374_1.text_.text = var_377_10
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_14 = math.max(var_377_7, arg_374_1.talkMaxDuration)

			if var_377_6 <= arg_374_1.time_ and arg_374_1.time_ < var_377_6 + var_377_14 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_6) / var_377_14

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_6 + var_377_14 and arg_374_1.time_ < var_377_6 + var_377_14 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play1108407093 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 1108407093
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play1108407094(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = arg_378_1.actors_["1084ui_story"].transform
			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 then
				arg_378_1.var_.moveOldPos1084ui_story = var_381_0.localPosition
			end

			local var_381_2 = 0.001

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_2 then
				local var_381_3 = (arg_378_1.time_ - var_381_1) / var_381_2
				local var_381_4 = Vector3.New(0, 100, 0)

				var_381_0.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos1084ui_story, var_381_4, var_381_3)

				local var_381_5 = manager.ui.mainCamera.transform.position - var_381_0.position

				var_381_0.forward = Vector3.New(var_381_5.x, var_381_5.y, var_381_5.z)

				local var_381_6 = var_381_0.localEulerAngles

				var_381_6.z = 0
				var_381_6.x = 0
				var_381_0.localEulerAngles = var_381_6
			end

			if arg_378_1.time_ >= var_381_1 + var_381_2 and arg_378_1.time_ < var_381_1 + var_381_2 + arg_381_0 then
				var_381_0.localPosition = Vector3.New(0, 100, 0)

				local var_381_7 = manager.ui.mainCamera.transform.position - var_381_0.position

				var_381_0.forward = Vector3.New(var_381_7.x, var_381_7.y, var_381_7.z)

				local var_381_8 = var_381_0.localEulerAngles

				var_381_8.z = 0
				var_381_8.x = 0
				var_381_0.localEulerAngles = var_381_8
			end

			local var_381_9 = 0
			local var_381_10 = 1.575

			if var_381_9 < arg_378_1.time_ and arg_378_1.time_ <= var_381_9 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, false)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_11 = arg_378_1:GetWordFromCfg(1108407093)
				local var_381_12 = arg_378_1:FormatText(var_381_11.content)

				arg_378_1.text_.text = var_381_12

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_13 = 63
				local var_381_14 = utf8.len(var_381_12)
				local var_381_15 = var_381_13 <= 0 and var_381_10 or var_381_10 * (var_381_14 / var_381_13)

				if var_381_15 > 0 and var_381_10 < var_381_15 then
					arg_378_1.talkMaxDuration = var_381_15

					if var_381_15 + var_381_9 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_15 + var_381_9
					end
				end

				arg_378_1.text_.text = var_381_12
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_16 = math.max(var_381_10, arg_378_1.talkMaxDuration)

			if var_381_9 <= arg_378_1.time_ and arg_378_1.time_ < var_381_9 + var_381_16 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_9) / var_381_16

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_9 + var_381_16 and arg_378_1.time_ < var_381_9 + var_381_16 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_378_1:InitPlayNodeList()
	end,
	Play1108407094 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 1108407094
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play1108407095(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0
			local var_385_1 = 1.35

			if var_385_0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_2 = arg_382_1:FormatText(StoryNameCfg[7].name)

				arg_382_1.leftNameTxt_.text = var_385_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_3 = arg_382_1:GetWordFromCfg(1108407094)
				local var_385_4 = arg_382_1:FormatText(var_385_3.content)

				arg_382_1.text_.text = var_385_4

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_5 = 54
				local var_385_6 = utf8.len(var_385_4)
				local var_385_7 = var_385_5 <= 0 and var_385_1 or var_385_1 * (var_385_6 / var_385_5)

				if var_385_7 > 0 and var_385_1 < var_385_7 then
					arg_382_1.talkMaxDuration = var_385_7

					if var_385_7 + var_385_0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_7 + var_385_0
					end
				end

				arg_382_1.text_.text = var_385_4
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_8 = math.max(var_385_1, arg_382_1.talkMaxDuration)

			if var_385_0 <= arg_382_1.time_ and arg_382_1.time_ < var_385_0 + var_385_8 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_0) / var_385_8

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_0 + var_385_8 and arg_382_1.time_ < var_385_0 + var_385_8 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play1108407095 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 1108407095
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play1108407096(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0
			local var_389_1 = 0.9

			if var_389_0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_2 = arg_386_1:FormatText(StoryNameCfg[7].name)

				arg_386_1.leftNameTxt_.text = var_389_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, true)
				arg_386_1.iconController_:SetSelectedState("hero")

				arg_386_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_386_1.callingController_:SetSelectedState("normal")

				arg_386_1.keyicon_.color = Color.New(1, 1, 1)
				arg_386_1.icon_.color = Color.New(1, 1, 1)

				local var_389_3 = arg_386_1:GetWordFromCfg(1108407095)
				local var_389_4 = arg_386_1:FormatText(var_389_3.content)

				arg_386_1.text_.text = var_389_4

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_5 = 36
				local var_389_6 = utf8.len(var_389_4)
				local var_389_7 = var_389_5 <= 0 and var_389_1 or var_389_1 * (var_389_6 / var_389_5)

				if var_389_7 > 0 and var_389_1 < var_389_7 then
					arg_386_1.talkMaxDuration = var_389_7

					if var_389_7 + var_389_0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_7 + var_389_0
					end
				end

				arg_386_1.text_.text = var_389_4
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_8 = math.max(var_389_1, arg_386_1.talkMaxDuration)

			if var_389_0 <= arg_386_1.time_ and arg_386_1.time_ < var_389_0 + var_389_8 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_0) / var_389_8

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_0 + var_389_8 and arg_386_1.time_ < var_389_0 + var_389_8 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play1108407096 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 1108407096
		arg_390_1.duration_ = 1.83

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play1108407097(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = arg_390_1.actors_["1084ui_story"].transform
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 then
				arg_390_1.var_.moveOldPos1084ui_story = var_393_0.localPosition
			end

			local var_393_2 = 0.001

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_2 then
				local var_393_3 = (arg_390_1.time_ - var_393_1) / var_393_2
				local var_393_4 = Vector3.New(0, -0.97, -6)

				var_393_0.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1084ui_story, var_393_4, var_393_3)

				local var_393_5 = manager.ui.mainCamera.transform.position - var_393_0.position

				var_393_0.forward = Vector3.New(var_393_5.x, var_393_5.y, var_393_5.z)

				local var_393_6 = var_393_0.localEulerAngles

				var_393_6.z = 0
				var_393_6.x = 0
				var_393_0.localEulerAngles = var_393_6
			end

			if arg_390_1.time_ >= var_393_1 + var_393_2 and arg_390_1.time_ < var_393_1 + var_393_2 + arg_393_0 then
				var_393_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_393_7 = manager.ui.mainCamera.transform.position - var_393_0.position

				var_393_0.forward = Vector3.New(var_393_7.x, var_393_7.y, var_393_7.z)

				local var_393_8 = var_393_0.localEulerAngles

				var_393_8.z = 0
				var_393_8.x = 0
				var_393_0.localEulerAngles = var_393_8
			end

			local var_393_9 = arg_390_1.actors_["1084ui_story"]
			local var_393_10 = 0

			if var_393_10 < arg_390_1.time_ and arg_390_1.time_ <= var_393_10 + arg_393_0 and not isNil(var_393_9) and arg_390_1.var_.characterEffect1084ui_story == nil then
				arg_390_1.var_.characterEffect1084ui_story = var_393_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_11 = 0.200000002980232

			if var_393_10 <= arg_390_1.time_ and arg_390_1.time_ < var_393_10 + var_393_11 and not isNil(var_393_9) then
				local var_393_12 = (arg_390_1.time_ - var_393_10) / var_393_11

				if arg_390_1.var_.characterEffect1084ui_story and not isNil(var_393_9) then
					arg_390_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= var_393_10 + var_393_11 and arg_390_1.time_ < var_393_10 + var_393_11 + arg_393_0 and not isNil(var_393_9) and arg_390_1.var_.characterEffect1084ui_story then
				arg_390_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_393_13 = 0

			if var_393_13 < arg_390_1.time_ and arg_390_1.time_ <= var_393_13 + arg_393_0 then
				arg_390_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_393_14 = 0

			if var_393_14 < arg_390_1.time_ and arg_390_1.time_ <= var_393_14 + arg_393_0 then
				arg_390_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_393_15 = 0
			local var_393_16 = 0.5

			if var_393_15 < arg_390_1.time_ and arg_390_1.time_ <= var_393_15 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_17 = arg_390_1:FormatText(StoryNameCfg[6].name)

				arg_390_1.leftNameTxt_.text = var_393_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_18 = arg_390_1:GetWordFromCfg(1108407096)
				local var_393_19 = arg_390_1:FormatText(var_393_18.content)

				arg_390_1.text_.text = var_393_19

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_20 = 20
				local var_393_21 = utf8.len(var_393_19)
				local var_393_22 = var_393_20 <= 0 and var_393_16 or var_393_16 * (var_393_21 / var_393_20)

				if var_393_22 > 0 and var_393_16 < var_393_22 then
					arg_390_1.talkMaxDuration = var_393_22

					if var_393_22 + var_393_15 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_22 + var_393_15
					end
				end

				arg_390_1.text_.text = var_393_19
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407096", "story_v_side_new_1108407.awb") ~= 0 then
					local var_393_23 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407096", "story_v_side_new_1108407.awb") / 1000

					if var_393_23 + var_393_15 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_23 + var_393_15
					end

					if var_393_18.prefab_name ~= "" and arg_390_1.actors_[var_393_18.prefab_name] ~= nil then
						local var_393_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_18.prefab_name].transform, "story_v_side_new_1108407", "1108407096", "story_v_side_new_1108407.awb")

						arg_390_1:RecordAudio("1108407096", var_393_24)
						arg_390_1:RecordAudio("1108407096", var_393_24)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407096", "story_v_side_new_1108407.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407096", "story_v_side_new_1108407.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_25 = math.max(var_393_16, arg_390_1.talkMaxDuration)

			if var_393_15 <= arg_390_1.time_ and arg_390_1.time_ < var_393_15 + var_393_25 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_15) / var_393_25

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_15 + var_393_25 and arg_390_1.time_ < var_393_15 + var_393_25 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play1108407097 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1108407097
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1108407098(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = arg_394_1.actors_["1084ui_story"].transform
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 then
				arg_394_1.var_.moveOldPos1084ui_story = var_397_0.localPosition
			end

			local var_397_2 = 0.001

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_2 then
				local var_397_3 = (arg_394_1.time_ - var_397_1) / var_397_2
				local var_397_4 = Vector3.New(0, 100, 0)

				var_397_0.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos1084ui_story, var_397_4, var_397_3)

				local var_397_5 = manager.ui.mainCamera.transform.position - var_397_0.position

				var_397_0.forward = Vector3.New(var_397_5.x, var_397_5.y, var_397_5.z)

				local var_397_6 = var_397_0.localEulerAngles

				var_397_6.z = 0
				var_397_6.x = 0
				var_397_0.localEulerAngles = var_397_6
			end

			if arg_394_1.time_ >= var_397_1 + var_397_2 and arg_394_1.time_ < var_397_1 + var_397_2 + arg_397_0 then
				var_397_0.localPosition = Vector3.New(0, 100, 0)

				local var_397_7 = manager.ui.mainCamera.transform.position - var_397_0.position

				var_397_0.forward = Vector3.New(var_397_7.x, var_397_7.y, var_397_7.z)

				local var_397_8 = var_397_0.localEulerAngles

				var_397_8.z = 0
				var_397_8.x = 0
				var_397_0.localEulerAngles = var_397_8
			end

			local var_397_9 = arg_394_1.actors_["1084ui_story"]
			local var_397_10 = 0

			if var_397_10 < arg_394_1.time_ and arg_394_1.time_ <= var_397_10 + arg_397_0 and not isNil(var_397_9) and arg_394_1.var_.characterEffect1084ui_story == nil then
				arg_394_1.var_.characterEffect1084ui_story = var_397_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_11 = 0.200000002980232

			if var_397_10 <= arg_394_1.time_ and arg_394_1.time_ < var_397_10 + var_397_11 and not isNil(var_397_9) then
				local var_397_12 = (arg_394_1.time_ - var_397_10) / var_397_11

				if arg_394_1.var_.characterEffect1084ui_story and not isNil(var_397_9) then
					local var_397_13 = Mathf.Lerp(0, 0.5, var_397_12)

					arg_394_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_394_1.var_.characterEffect1084ui_story.fillRatio = var_397_13
				end
			end

			if arg_394_1.time_ >= var_397_10 + var_397_11 and arg_394_1.time_ < var_397_10 + var_397_11 + arg_397_0 and not isNil(var_397_9) and arg_394_1.var_.characterEffect1084ui_story then
				local var_397_14 = 0.5

				arg_394_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_394_1.var_.characterEffect1084ui_story.fillRatio = var_397_14
			end

			local var_397_15 = 0
			local var_397_16 = 0.7

			if var_397_15 < arg_394_1.time_ and arg_394_1.time_ <= var_397_15 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_17 = arg_394_1:GetWordFromCfg(1108407097)
				local var_397_18 = arg_394_1:FormatText(var_397_17.content)

				arg_394_1.text_.text = var_397_18

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_19 = 28
				local var_397_20 = utf8.len(var_397_18)
				local var_397_21 = var_397_19 <= 0 and var_397_16 or var_397_16 * (var_397_20 / var_397_19)

				if var_397_21 > 0 and var_397_16 < var_397_21 then
					arg_394_1.talkMaxDuration = var_397_21

					if var_397_21 + var_397_15 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_21 + var_397_15
					end
				end

				arg_394_1.text_.text = var_397_18
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_22 = math.max(var_397_16, arg_394_1.talkMaxDuration)

			if var_397_15 <= arg_394_1.time_ and arg_394_1.time_ < var_397_15 + var_397_22 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_15) / var_397_22

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_15 + var_397_22 and arg_394_1.time_ < var_397_15 + var_397_22 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_394_1:InitPlayNodeList()
	end,
	Play1108407098 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1108407098
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1108407099(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0
			local var_401_1 = 0.05

			if var_401_0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_2 = arg_398_1:FormatText(StoryNameCfg[7].name)

				arg_398_1.leftNameTxt_.text = var_401_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, true)
				arg_398_1.iconController_:SetSelectedState("hero")

				arg_398_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_398_1.callingController_:SetSelectedState("normal")

				arg_398_1.keyicon_.color = Color.New(1, 1, 1)
				arg_398_1.icon_.color = Color.New(1, 1, 1)

				local var_401_3 = arg_398_1:GetWordFromCfg(1108407098)
				local var_401_4 = arg_398_1:FormatText(var_401_3.content)

				arg_398_1.text_.text = var_401_4

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_5 = 2
				local var_401_6 = utf8.len(var_401_4)
				local var_401_7 = var_401_5 <= 0 and var_401_1 or var_401_1 * (var_401_6 / var_401_5)

				if var_401_7 > 0 and var_401_1 < var_401_7 then
					arg_398_1.talkMaxDuration = var_401_7

					if var_401_7 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_7 + var_401_0
					end
				end

				arg_398_1.text_.text = var_401_4
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_8 = math.max(var_401_1, arg_398_1.talkMaxDuration)

			if var_401_0 <= arg_398_1.time_ and arg_398_1.time_ < var_401_0 + var_401_8 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_0) / var_401_8

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_0 + var_401_8 and arg_398_1.time_ < var_401_0 + var_401_8 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play1108407099 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 1108407099
		arg_402_1.duration_ = 3.1

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play1108407100(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = arg_402_1.actors_["1084ui_story"].transform
			local var_405_1 = 0

			if var_405_1 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 then
				arg_402_1.var_.moveOldPos1084ui_story = var_405_0.localPosition
			end

			local var_405_2 = 0.001

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_2 then
				local var_405_3 = (arg_402_1.time_ - var_405_1) / var_405_2
				local var_405_4 = Vector3.New(0, -0.97, -6)

				var_405_0.localPosition = Vector3.Lerp(arg_402_1.var_.moveOldPos1084ui_story, var_405_4, var_405_3)

				local var_405_5 = manager.ui.mainCamera.transform.position - var_405_0.position

				var_405_0.forward = Vector3.New(var_405_5.x, var_405_5.y, var_405_5.z)

				local var_405_6 = var_405_0.localEulerAngles

				var_405_6.z = 0
				var_405_6.x = 0
				var_405_0.localEulerAngles = var_405_6
			end

			if arg_402_1.time_ >= var_405_1 + var_405_2 and arg_402_1.time_ < var_405_1 + var_405_2 + arg_405_0 then
				var_405_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_405_7 = manager.ui.mainCamera.transform.position - var_405_0.position

				var_405_0.forward = Vector3.New(var_405_7.x, var_405_7.y, var_405_7.z)

				local var_405_8 = var_405_0.localEulerAngles

				var_405_8.z = 0
				var_405_8.x = 0
				var_405_0.localEulerAngles = var_405_8
			end

			local var_405_9 = arg_402_1.actors_["1084ui_story"]
			local var_405_10 = 0

			if var_405_10 < arg_402_1.time_ and arg_402_1.time_ <= var_405_10 + arg_405_0 and not isNil(var_405_9) and arg_402_1.var_.characterEffect1084ui_story == nil then
				arg_402_1.var_.characterEffect1084ui_story = var_405_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_11 = 0.200000002980232

			if var_405_10 <= arg_402_1.time_ and arg_402_1.time_ < var_405_10 + var_405_11 and not isNil(var_405_9) then
				local var_405_12 = (arg_402_1.time_ - var_405_10) / var_405_11

				if arg_402_1.var_.characterEffect1084ui_story and not isNil(var_405_9) then
					arg_402_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_402_1.time_ >= var_405_10 + var_405_11 and arg_402_1.time_ < var_405_10 + var_405_11 + arg_405_0 and not isNil(var_405_9) and arg_402_1.var_.characterEffect1084ui_story then
				arg_402_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_405_13 = 0

			if var_405_13 < arg_402_1.time_ and arg_402_1.time_ <= var_405_13 + arg_405_0 then
				arg_402_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_405_14 = 0

			if var_405_14 < arg_402_1.time_ and arg_402_1.time_ <= var_405_14 + arg_405_0 then
				arg_402_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_405_15 = 0
			local var_405_16 = 0.325

			if var_405_15 < arg_402_1.time_ and arg_402_1.time_ <= var_405_15 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_17 = arg_402_1:FormatText(StoryNameCfg[6].name)

				arg_402_1.leftNameTxt_.text = var_405_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_18 = arg_402_1:GetWordFromCfg(1108407099)
				local var_405_19 = arg_402_1:FormatText(var_405_18.content)

				arg_402_1.text_.text = var_405_19

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_20 = 13
				local var_405_21 = utf8.len(var_405_19)
				local var_405_22 = var_405_20 <= 0 and var_405_16 or var_405_16 * (var_405_21 / var_405_20)

				if var_405_22 > 0 and var_405_16 < var_405_22 then
					arg_402_1.talkMaxDuration = var_405_22

					if var_405_22 + var_405_15 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_22 + var_405_15
					end
				end

				arg_402_1.text_.text = var_405_19
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407099", "story_v_side_new_1108407.awb") ~= 0 then
					local var_405_23 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407099", "story_v_side_new_1108407.awb") / 1000

					if var_405_23 + var_405_15 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_23 + var_405_15
					end

					if var_405_18.prefab_name ~= "" and arg_402_1.actors_[var_405_18.prefab_name] ~= nil then
						local var_405_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_18.prefab_name].transform, "story_v_side_new_1108407", "1108407099", "story_v_side_new_1108407.awb")

						arg_402_1:RecordAudio("1108407099", var_405_24)
						arg_402_1:RecordAudio("1108407099", var_405_24)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407099", "story_v_side_new_1108407.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407099", "story_v_side_new_1108407.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_25 = math.max(var_405_16, arg_402_1.talkMaxDuration)

			if var_405_15 <= arg_402_1.time_ and arg_402_1.time_ < var_405_15 + var_405_25 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_15) / var_405_25

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_15 + var_405_25 and arg_402_1.time_ < var_405_15 + var_405_25 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_402_1:InitPlayNodeList()
	end,
	Play1108407100 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 1108407100
		arg_406_1.duration_ = 5

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play1108407101(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = arg_406_1.actors_["1084ui_story"]
			local var_409_1 = 0

			if var_409_1 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.characterEffect1084ui_story == nil then
				arg_406_1.var_.characterEffect1084ui_story = var_409_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_2 = 0.200000002980232

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_2 and not isNil(var_409_0) then
				local var_409_3 = (arg_406_1.time_ - var_409_1) / var_409_2

				if arg_406_1.var_.characterEffect1084ui_story and not isNil(var_409_0) then
					local var_409_4 = Mathf.Lerp(0, 0.5, var_409_3)

					arg_406_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_406_1.var_.characterEffect1084ui_story.fillRatio = var_409_4
				end
			end

			if arg_406_1.time_ >= var_409_1 + var_409_2 and arg_406_1.time_ < var_409_1 + var_409_2 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.characterEffect1084ui_story then
				local var_409_5 = 0.5

				arg_406_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_406_1.var_.characterEffect1084ui_story.fillRatio = var_409_5
			end

			local var_409_6 = 0
			local var_409_7 = 0.425

			if var_409_6 < arg_406_1.time_ and arg_406_1.time_ <= var_409_6 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_8 = arg_406_1:FormatText(StoryNameCfg[7].name)

				arg_406_1.leftNameTxt_.text = var_409_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_9 = arg_406_1:GetWordFromCfg(1108407100)
				local var_409_10 = arg_406_1:FormatText(var_409_9.content)

				arg_406_1.text_.text = var_409_10

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_11 = 17
				local var_409_12 = utf8.len(var_409_10)
				local var_409_13 = var_409_11 <= 0 and var_409_7 or var_409_7 * (var_409_12 / var_409_11)

				if var_409_13 > 0 and var_409_7 < var_409_13 then
					arg_406_1.talkMaxDuration = var_409_13

					if var_409_13 + var_409_6 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_13 + var_409_6
					end
				end

				arg_406_1.text_.text = var_409_10
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_14 = math.max(var_409_7, arg_406_1.talkMaxDuration)

			if var_409_6 <= arg_406_1.time_ and arg_406_1.time_ < var_409_6 + var_409_14 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_6) / var_409_14

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_6 + var_409_14 and arg_406_1.time_ < var_409_6 + var_409_14 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play1108407101 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 1108407101
		arg_410_1.duration_ = 3.47

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play1108407102(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = arg_410_1.actors_["1084ui_story"]
			local var_413_1 = 0

			if var_413_1 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 and not isNil(var_413_0) and arg_410_1.var_.characterEffect1084ui_story == nil then
				arg_410_1.var_.characterEffect1084ui_story = var_413_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_2 = 0.200000002980232

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_2 and not isNil(var_413_0) then
				local var_413_3 = (arg_410_1.time_ - var_413_1) / var_413_2

				if arg_410_1.var_.characterEffect1084ui_story and not isNil(var_413_0) then
					arg_410_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_410_1.time_ >= var_413_1 + var_413_2 and arg_410_1.time_ < var_413_1 + var_413_2 + arg_413_0 and not isNil(var_413_0) and arg_410_1.var_.characterEffect1084ui_story then
				arg_410_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_413_4 = 0

			if var_413_4 < arg_410_1.time_ and arg_410_1.time_ <= var_413_4 + arg_413_0 then
				arg_410_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_413_5 = 0

			if var_413_5 < arg_410_1.time_ and arg_410_1.time_ <= var_413_5 + arg_413_0 then
				arg_410_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_413_6 = 0
			local var_413_7 = 0.425

			if var_413_6 < arg_410_1.time_ and arg_410_1.time_ <= var_413_6 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_8 = arg_410_1:FormatText(StoryNameCfg[6].name)

				arg_410_1.leftNameTxt_.text = var_413_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_9 = arg_410_1:GetWordFromCfg(1108407101)
				local var_413_10 = arg_410_1:FormatText(var_413_9.content)

				arg_410_1.text_.text = var_413_10

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_11 = 17
				local var_413_12 = utf8.len(var_413_10)
				local var_413_13 = var_413_11 <= 0 and var_413_7 or var_413_7 * (var_413_12 / var_413_11)

				if var_413_13 > 0 and var_413_7 < var_413_13 then
					arg_410_1.talkMaxDuration = var_413_13

					if var_413_13 + var_413_6 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_13 + var_413_6
					end
				end

				arg_410_1.text_.text = var_413_10
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407101", "story_v_side_new_1108407.awb") ~= 0 then
					local var_413_14 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407101", "story_v_side_new_1108407.awb") / 1000

					if var_413_14 + var_413_6 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_14 + var_413_6
					end

					if var_413_9.prefab_name ~= "" and arg_410_1.actors_[var_413_9.prefab_name] ~= nil then
						local var_413_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_9.prefab_name].transform, "story_v_side_new_1108407", "1108407101", "story_v_side_new_1108407.awb")

						arg_410_1:RecordAudio("1108407101", var_413_15)
						arg_410_1:RecordAudio("1108407101", var_413_15)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407101", "story_v_side_new_1108407.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407101", "story_v_side_new_1108407.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_16 = math.max(var_413_7, arg_410_1.talkMaxDuration)

			if var_413_6 <= arg_410_1.time_ and arg_410_1.time_ < var_413_6 + var_413_16 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_6) / var_413_16

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_6 + var_413_16 and arg_410_1.time_ < var_413_6 + var_413_16 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play1108407102 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 1108407102
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play1108407103(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = arg_414_1.actors_["1084ui_story"]
			local var_417_1 = 0

			if var_417_1 < arg_414_1.time_ and arg_414_1.time_ <= var_417_1 + arg_417_0 and not isNil(var_417_0) and arg_414_1.var_.characterEffect1084ui_story == nil then
				arg_414_1.var_.characterEffect1084ui_story = var_417_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_2 = 0.200000002980232

			if var_417_1 <= arg_414_1.time_ and arg_414_1.time_ < var_417_1 + var_417_2 and not isNil(var_417_0) then
				local var_417_3 = (arg_414_1.time_ - var_417_1) / var_417_2

				if arg_414_1.var_.characterEffect1084ui_story and not isNil(var_417_0) then
					local var_417_4 = Mathf.Lerp(0, 0.5, var_417_3)

					arg_414_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_414_1.var_.characterEffect1084ui_story.fillRatio = var_417_4
				end
			end

			if arg_414_1.time_ >= var_417_1 + var_417_2 and arg_414_1.time_ < var_417_1 + var_417_2 + arg_417_0 and not isNil(var_417_0) and arg_414_1.var_.characterEffect1084ui_story then
				local var_417_5 = 0.5

				arg_414_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_414_1.var_.characterEffect1084ui_story.fillRatio = var_417_5
			end

			local var_417_6 = 0
			local var_417_7 = 0.875

			if var_417_6 < arg_414_1.time_ and arg_414_1.time_ <= var_417_6 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_8 = arg_414_1:FormatText(StoryNameCfg[7].name)

				arg_414_1.leftNameTxt_.text = var_417_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_9 = arg_414_1:GetWordFromCfg(1108407102)
				local var_417_10 = arg_414_1:FormatText(var_417_9.content)

				arg_414_1.text_.text = var_417_10

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_11 = 35
				local var_417_12 = utf8.len(var_417_10)
				local var_417_13 = var_417_11 <= 0 and var_417_7 or var_417_7 * (var_417_12 / var_417_11)

				if var_417_13 > 0 and var_417_7 < var_417_13 then
					arg_414_1.talkMaxDuration = var_417_13

					if var_417_13 + var_417_6 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_13 + var_417_6
					end
				end

				arg_414_1.text_.text = var_417_10
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_14 = math.max(var_417_7, arg_414_1.talkMaxDuration)

			if var_417_6 <= arg_414_1.time_ and arg_414_1.time_ < var_417_6 + var_417_14 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_6) / var_417_14

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_6 + var_417_14 and arg_414_1.time_ < var_417_6 + var_417_14 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play1108407103 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 1108407103
		arg_418_1.duration_ = 4.4

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play1108407104(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = arg_418_1.actors_["1084ui_story"]
			local var_421_1 = 0

			if var_421_1 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 and not isNil(var_421_0) and arg_418_1.var_.characterEffect1084ui_story == nil then
				arg_418_1.var_.characterEffect1084ui_story = var_421_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_2 = 0.200000002980232

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_2 and not isNil(var_421_0) then
				local var_421_3 = (arg_418_1.time_ - var_421_1) / var_421_2

				if arg_418_1.var_.characterEffect1084ui_story and not isNil(var_421_0) then
					arg_418_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_418_1.time_ >= var_421_1 + var_421_2 and arg_418_1.time_ < var_421_1 + var_421_2 + arg_421_0 and not isNil(var_421_0) and arg_418_1.var_.characterEffect1084ui_story then
				arg_418_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_421_4 = 0

			if var_421_4 < arg_418_1.time_ and arg_418_1.time_ <= var_421_4 + arg_421_0 then
				arg_418_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_421_5 = 0

			if var_421_5 < arg_418_1.time_ and arg_418_1.time_ <= var_421_5 + arg_421_0 then
				arg_418_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_421_6 = 0
			local var_421_7 = 0.35

			if var_421_6 < arg_418_1.time_ and arg_418_1.time_ <= var_421_6 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				local var_421_8 = arg_418_1:FormatText(StoryNameCfg[6].name)

				arg_418_1.leftNameTxt_.text = var_421_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_9 = arg_418_1:GetWordFromCfg(1108407103)
				local var_421_10 = arg_418_1:FormatText(var_421_9.content)

				arg_418_1.text_.text = var_421_10

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_11 = 14
				local var_421_12 = utf8.len(var_421_10)
				local var_421_13 = var_421_11 <= 0 and var_421_7 or var_421_7 * (var_421_12 / var_421_11)

				if var_421_13 > 0 and var_421_7 < var_421_13 then
					arg_418_1.talkMaxDuration = var_421_13

					if var_421_13 + var_421_6 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_13 + var_421_6
					end
				end

				arg_418_1.text_.text = var_421_10
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407103", "story_v_side_new_1108407.awb") ~= 0 then
					local var_421_14 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407103", "story_v_side_new_1108407.awb") / 1000

					if var_421_14 + var_421_6 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_14 + var_421_6
					end

					if var_421_9.prefab_name ~= "" and arg_418_1.actors_[var_421_9.prefab_name] ~= nil then
						local var_421_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_9.prefab_name].transform, "story_v_side_new_1108407", "1108407103", "story_v_side_new_1108407.awb")

						arg_418_1:RecordAudio("1108407103", var_421_15)
						arg_418_1:RecordAudio("1108407103", var_421_15)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407103", "story_v_side_new_1108407.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407103", "story_v_side_new_1108407.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_16 = math.max(var_421_7, arg_418_1.talkMaxDuration)

			if var_421_6 <= arg_418_1.time_ and arg_418_1.time_ < var_421_6 + var_421_16 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_6) / var_421_16

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_6 + var_421_16 and arg_418_1.time_ < var_421_6 + var_421_16 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play1108407104 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 1108407104
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play1108407105(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = arg_422_1.actors_["1084ui_story"].transform
			local var_425_1 = 0

			if var_425_1 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 then
				arg_422_1.var_.moveOldPos1084ui_story = var_425_0.localPosition
			end

			local var_425_2 = 0.001

			if var_425_1 <= arg_422_1.time_ and arg_422_1.time_ < var_425_1 + var_425_2 then
				local var_425_3 = (arg_422_1.time_ - var_425_1) / var_425_2
				local var_425_4 = Vector3.New(0, 100, 0)

				var_425_0.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPos1084ui_story, var_425_4, var_425_3)

				local var_425_5 = manager.ui.mainCamera.transform.position - var_425_0.position

				var_425_0.forward = Vector3.New(var_425_5.x, var_425_5.y, var_425_5.z)

				local var_425_6 = var_425_0.localEulerAngles

				var_425_6.z = 0
				var_425_6.x = 0
				var_425_0.localEulerAngles = var_425_6
			end

			if arg_422_1.time_ >= var_425_1 + var_425_2 and arg_422_1.time_ < var_425_1 + var_425_2 + arg_425_0 then
				var_425_0.localPosition = Vector3.New(0, 100, 0)

				local var_425_7 = manager.ui.mainCamera.transform.position - var_425_0.position

				var_425_0.forward = Vector3.New(var_425_7.x, var_425_7.y, var_425_7.z)

				local var_425_8 = var_425_0.localEulerAngles

				var_425_8.z = 0
				var_425_8.x = 0
				var_425_0.localEulerAngles = var_425_8
			end

			local var_425_9 = arg_422_1.actors_["1084ui_story"]
			local var_425_10 = 0

			if var_425_10 < arg_422_1.time_ and arg_422_1.time_ <= var_425_10 + arg_425_0 and not isNil(var_425_9) and arg_422_1.var_.characterEffect1084ui_story == nil then
				arg_422_1.var_.characterEffect1084ui_story = var_425_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_11 = 0.200000002980232

			if var_425_10 <= arg_422_1.time_ and arg_422_1.time_ < var_425_10 + var_425_11 and not isNil(var_425_9) then
				local var_425_12 = (arg_422_1.time_ - var_425_10) / var_425_11

				if arg_422_1.var_.characterEffect1084ui_story and not isNil(var_425_9) then
					local var_425_13 = Mathf.Lerp(0, 0.5, var_425_12)

					arg_422_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_422_1.var_.characterEffect1084ui_story.fillRatio = var_425_13
				end
			end

			if arg_422_1.time_ >= var_425_10 + var_425_11 and arg_422_1.time_ < var_425_10 + var_425_11 + arg_425_0 and not isNil(var_425_9) and arg_422_1.var_.characterEffect1084ui_story then
				local var_425_14 = 0.5

				arg_422_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_422_1.var_.characterEffect1084ui_story.fillRatio = var_425_14
			end

			local var_425_15 = 0
			local var_425_16 = 2.225

			if var_425_15 < arg_422_1.time_ and arg_422_1.time_ <= var_425_15 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, false)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_17 = arg_422_1:GetWordFromCfg(1108407104)
				local var_425_18 = arg_422_1:FormatText(var_425_17.content)

				arg_422_1.text_.text = var_425_18

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_19 = 89
				local var_425_20 = utf8.len(var_425_18)
				local var_425_21 = var_425_19 <= 0 and var_425_16 or var_425_16 * (var_425_20 / var_425_19)

				if var_425_21 > 0 and var_425_16 < var_425_21 then
					arg_422_1.talkMaxDuration = var_425_21

					if var_425_21 + var_425_15 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_21 + var_425_15
					end
				end

				arg_422_1.text_.text = var_425_18
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_22 = math.max(var_425_16, arg_422_1.talkMaxDuration)

			if var_425_15 <= arg_422_1.time_ and arg_422_1.time_ < var_425_15 + var_425_22 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_15) / var_425_22

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_15 + var_425_22 and arg_422_1.time_ < var_425_15 + var_425_22 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_422_1:InitPlayNodeList()
	end,
	Play1108407105 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 1108407105
		arg_426_1.duration_ = 7.9

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play1108407106(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = arg_426_1.actors_["1084ui_story"].transform
			local var_429_1 = 0

			if var_429_1 < arg_426_1.time_ and arg_426_1.time_ <= var_429_1 + arg_429_0 then
				arg_426_1.var_.moveOldPos1084ui_story = var_429_0.localPosition
			end

			local var_429_2 = 0.001

			if var_429_1 <= arg_426_1.time_ and arg_426_1.time_ < var_429_1 + var_429_2 then
				local var_429_3 = (arg_426_1.time_ - var_429_1) / var_429_2
				local var_429_4 = Vector3.New(0, -0.97, -6)

				var_429_0.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos1084ui_story, var_429_4, var_429_3)

				local var_429_5 = manager.ui.mainCamera.transform.position - var_429_0.position

				var_429_0.forward = Vector3.New(var_429_5.x, var_429_5.y, var_429_5.z)

				local var_429_6 = var_429_0.localEulerAngles

				var_429_6.z = 0
				var_429_6.x = 0
				var_429_0.localEulerAngles = var_429_6
			end

			if arg_426_1.time_ >= var_429_1 + var_429_2 and arg_426_1.time_ < var_429_1 + var_429_2 + arg_429_0 then
				var_429_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_429_7 = manager.ui.mainCamera.transform.position - var_429_0.position

				var_429_0.forward = Vector3.New(var_429_7.x, var_429_7.y, var_429_7.z)

				local var_429_8 = var_429_0.localEulerAngles

				var_429_8.z = 0
				var_429_8.x = 0
				var_429_0.localEulerAngles = var_429_8
			end

			local var_429_9 = arg_426_1.actors_["1084ui_story"]
			local var_429_10 = 0

			if var_429_10 < arg_426_1.time_ and arg_426_1.time_ <= var_429_10 + arg_429_0 and not isNil(var_429_9) and arg_426_1.var_.characterEffect1084ui_story == nil then
				arg_426_1.var_.characterEffect1084ui_story = var_429_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_11 = 0.200000002980232

			if var_429_10 <= arg_426_1.time_ and arg_426_1.time_ < var_429_10 + var_429_11 and not isNil(var_429_9) then
				local var_429_12 = (arg_426_1.time_ - var_429_10) / var_429_11

				if arg_426_1.var_.characterEffect1084ui_story and not isNil(var_429_9) then
					arg_426_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_426_1.time_ >= var_429_10 + var_429_11 and arg_426_1.time_ < var_429_10 + var_429_11 + arg_429_0 and not isNil(var_429_9) and arg_426_1.var_.characterEffect1084ui_story then
				arg_426_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_429_13 = 0

			if var_429_13 < arg_426_1.time_ and arg_426_1.time_ <= var_429_13 + arg_429_0 then
				arg_426_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_429_14 = 0

			if var_429_14 < arg_426_1.time_ and arg_426_1.time_ <= var_429_14 + arg_429_0 then
				arg_426_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_429_15 = 0
			local var_429_16 = 1.1

			if var_429_15 < arg_426_1.time_ and arg_426_1.time_ <= var_429_15 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_17 = arg_426_1:FormatText(StoryNameCfg[6].name)

				arg_426_1.leftNameTxt_.text = var_429_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_18 = arg_426_1:GetWordFromCfg(1108407105)
				local var_429_19 = arg_426_1:FormatText(var_429_18.content)

				arg_426_1.text_.text = var_429_19

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_20 = 44
				local var_429_21 = utf8.len(var_429_19)
				local var_429_22 = var_429_20 <= 0 and var_429_16 or var_429_16 * (var_429_21 / var_429_20)

				if var_429_22 > 0 and var_429_16 < var_429_22 then
					arg_426_1.talkMaxDuration = var_429_22

					if var_429_22 + var_429_15 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_22 + var_429_15
					end
				end

				arg_426_1.text_.text = var_429_19
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407105", "story_v_side_new_1108407.awb") ~= 0 then
					local var_429_23 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407105", "story_v_side_new_1108407.awb") / 1000

					if var_429_23 + var_429_15 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_23 + var_429_15
					end

					if var_429_18.prefab_name ~= "" and arg_426_1.actors_[var_429_18.prefab_name] ~= nil then
						local var_429_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_18.prefab_name].transform, "story_v_side_new_1108407", "1108407105", "story_v_side_new_1108407.awb")

						arg_426_1:RecordAudio("1108407105", var_429_24)
						arg_426_1:RecordAudio("1108407105", var_429_24)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407105", "story_v_side_new_1108407.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407105", "story_v_side_new_1108407.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_25 = math.max(var_429_16, arg_426_1.talkMaxDuration)

			if var_429_15 <= arg_426_1.time_ and arg_426_1.time_ < var_429_15 + var_429_25 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_15) / var_429_25

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_15 + var_429_25 and arg_426_1.time_ < var_429_15 + var_429_25 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_426_1:InitPlayNodeList()
	end,
	Play1108407106 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 1108407106
		arg_430_1.duration_ = 5

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play1108407107(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = arg_430_1.actors_["1084ui_story"]
			local var_433_1 = 0

			if var_433_1 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.characterEffect1084ui_story == nil then
				arg_430_1.var_.characterEffect1084ui_story = var_433_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_2 = 0.200000002980232

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_2 and not isNil(var_433_0) then
				local var_433_3 = (arg_430_1.time_ - var_433_1) / var_433_2

				if arg_430_1.var_.characterEffect1084ui_story and not isNil(var_433_0) then
					local var_433_4 = Mathf.Lerp(0, 0.5, var_433_3)

					arg_430_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_430_1.var_.characterEffect1084ui_story.fillRatio = var_433_4
				end
			end

			if arg_430_1.time_ >= var_433_1 + var_433_2 and arg_430_1.time_ < var_433_1 + var_433_2 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.characterEffect1084ui_story then
				local var_433_5 = 0.5

				arg_430_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_430_1.var_.characterEffect1084ui_story.fillRatio = var_433_5
			end

			local var_433_6 = 0
			local var_433_7 = 0.55

			if var_433_6 < arg_430_1.time_ and arg_430_1.time_ <= var_433_6 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_8 = arg_430_1:FormatText(StoryNameCfg[7].name)

				arg_430_1.leftNameTxt_.text = var_433_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, true)
				arg_430_1.iconController_:SetSelectedState("hero")

				arg_430_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_430_1.callingController_:SetSelectedState("normal")

				arg_430_1.keyicon_.color = Color.New(1, 1, 1)
				arg_430_1.icon_.color = Color.New(1, 1, 1)

				local var_433_9 = arg_430_1:GetWordFromCfg(1108407106)
				local var_433_10 = arg_430_1:FormatText(var_433_9.content)

				arg_430_1.text_.text = var_433_10

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_11 = 22
				local var_433_12 = utf8.len(var_433_10)
				local var_433_13 = var_433_11 <= 0 and var_433_7 or var_433_7 * (var_433_12 / var_433_11)

				if var_433_13 > 0 and var_433_7 < var_433_13 then
					arg_430_1.talkMaxDuration = var_433_13

					if var_433_13 + var_433_6 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_13 + var_433_6
					end
				end

				arg_430_1.text_.text = var_433_10
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)
				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_14 = math.max(var_433_7, arg_430_1.talkMaxDuration)

			if var_433_6 <= arg_430_1.time_ and arg_430_1.time_ < var_433_6 + var_433_14 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_6) / var_433_14

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_6 + var_433_14 and arg_430_1.time_ < var_433_6 + var_433_14 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play1108407107 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 1108407107
		arg_434_1.duration_ = 4.63

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play1108407108(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = arg_434_1.actors_["1084ui_story"]
			local var_437_1 = 0

			if var_437_1 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.characterEffect1084ui_story == nil then
				arg_434_1.var_.characterEffect1084ui_story = var_437_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_2 = 0.200000002980232

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_2 and not isNil(var_437_0) then
				local var_437_3 = (arg_434_1.time_ - var_437_1) / var_437_2

				if arg_434_1.var_.characterEffect1084ui_story and not isNil(var_437_0) then
					arg_434_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_434_1.time_ >= var_437_1 + var_437_2 and arg_434_1.time_ < var_437_1 + var_437_2 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.characterEffect1084ui_story then
				arg_434_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_437_4 = 0

			if var_437_4 < arg_434_1.time_ and arg_434_1.time_ <= var_437_4 + arg_437_0 then
				arg_434_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_437_5 = 0

			if var_437_5 < arg_434_1.time_ and arg_434_1.time_ <= var_437_5 + arg_437_0 then
				arg_434_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_437_6 = 0
			local var_437_7 = 0.55

			if var_437_6 < arg_434_1.time_ and arg_434_1.time_ <= var_437_6 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_8 = arg_434_1:FormatText(StoryNameCfg[6].name)

				arg_434_1.leftNameTxt_.text = var_437_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_9 = arg_434_1:GetWordFromCfg(1108407107)
				local var_437_10 = arg_434_1:FormatText(var_437_9.content)

				arg_434_1.text_.text = var_437_10

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_11 = 22
				local var_437_12 = utf8.len(var_437_10)
				local var_437_13 = var_437_11 <= 0 and var_437_7 or var_437_7 * (var_437_12 / var_437_11)

				if var_437_13 > 0 and var_437_7 < var_437_13 then
					arg_434_1.talkMaxDuration = var_437_13

					if var_437_13 + var_437_6 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_13 + var_437_6
					end
				end

				arg_434_1.text_.text = var_437_10
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407107", "story_v_side_new_1108407.awb") ~= 0 then
					local var_437_14 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407107", "story_v_side_new_1108407.awb") / 1000

					if var_437_14 + var_437_6 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_14 + var_437_6
					end

					if var_437_9.prefab_name ~= "" and arg_434_1.actors_[var_437_9.prefab_name] ~= nil then
						local var_437_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_9.prefab_name].transform, "story_v_side_new_1108407", "1108407107", "story_v_side_new_1108407.awb")

						arg_434_1:RecordAudio("1108407107", var_437_15)
						arg_434_1:RecordAudio("1108407107", var_437_15)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407107", "story_v_side_new_1108407.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407107", "story_v_side_new_1108407.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_16 = math.max(var_437_7, arg_434_1.talkMaxDuration)

			if var_437_6 <= arg_434_1.time_ and arg_434_1.time_ < var_437_6 + var_437_16 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_6) / var_437_16

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_6 + var_437_16 and arg_434_1.time_ < var_437_6 + var_437_16 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play1108407108 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 1108407108
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play1108407109(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = arg_438_1.actors_["1084ui_story"]
			local var_441_1 = 0

			if var_441_1 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.characterEffect1084ui_story == nil then
				arg_438_1.var_.characterEffect1084ui_story = var_441_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_2 = 0.200000002980232

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_2 and not isNil(var_441_0) then
				local var_441_3 = (arg_438_1.time_ - var_441_1) / var_441_2

				if arg_438_1.var_.characterEffect1084ui_story and not isNil(var_441_0) then
					local var_441_4 = Mathf.Lerp(0, 0.5, var_441_3)

					arg_438_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_438_1.var_.characterEffect1084ui_story.fillRatio = var_441_4
				end
			end

			if arg_438_1.time_ >= var_441_1 + var_441_2 and arg_438_1.time_ < var_441_1 + var_441_2 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.characterEffect1084ui_story then
				local var_441_5 = 0.5

				arg_438_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_438_1.var_.characterEffect1084ui_story.fillRatio = var_441_5
			end

			local var_441_6 = 0
			local var_441_7 = 1.1

			if var_441_6 < arg_438_1.time_ and arg_438_1.time_ <= var_441_6 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_8 = arg_438_1:FormatText(StoryNameCfg[7].name)

				arg_438_1.leftNameTxt_.text = var_441_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_9 = arg_438_1:GetWordFromCfg(1108407108)
				local var_441_10 = arg_438_1:FormatText(var_441_9.content)

				arg_438_1.text_.text = var_441_10

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_11 = 44
				local var_441_12 = utf8.len(var_441_10)
				local var_441_13 = var_441_11 <= 0 and var_441_7 or var_441_7 * (var_441_12 / var_441_11)

				if var_441_13 > 0 and var_441_7 < var_441_13 then
					arg_438_1.talkMaxDuration = var_441_13

					if var_441_13 + var_441_6 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_13 + var_441_6
					end
				end

				arg_438_1.text_.text = var_441_10
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_14 = math.max(var_441_7, arg_438_1.talkMaxDuration)

			if var_441_6 <= arg_438_1.time_ and arg_438_1.time_ < var_441_6 + var_441_14 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_6) / var_441_14

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_6 + var_441_14 and arg_438_1.time_ < var_441_6 + var_441_14 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play1108407109 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 1108407109
		arg_442_1.duration_ = 5

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play1108407110(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = arg_442_1.actors_["1084ui_story"].transform
			local var_445_1 = 0

			if var_445_1 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 then
				arg_442_1.var_.moveOldPos1084ui_story = var_445_0.localPosition
			end

			local var_445_2 = 0.001

			if var_445_1 <= arg_442_1.time_ and arg_442_1.time_ < var_445_1 + var_445_2 then
				local var_445_3 = (arg_442_1.time_ - var_445_1) / var_445_2
				local var_445_4 = Vector3.New(0, 100, 0)

				var_445_0.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos1084ui_story, var_445_4, var_445_3)

				local var_445_5 = manager.ui.mainCamera.transform.position - var_445_0.position

				var_445_0.forward = Vector3.New(var_445_5.x, var_445_5.y, var_445_5.z)

				local var_445_6 = var_445_0.localEulerAngles

				var_445_6.z = 0
				var_445_6.x = 0
				var_445_0.localEulerAngles = var_445_6
			end

			if arg_442_1.time_ >= var_445_1 + var_445_2 and arg_442_1.time_ < var_445_1 + var_445_2 + arg_445_0 then
				var_445_0.localPosition = Vector3.New(0, 100, 0)

				local var_445_7 = manager.ui.mainCamera.transform.position - var_445_0.position

				var_445_0.forward = Vector3.New(var_445_7.x, var_445_7.y, var_445_7.z)

				local var_445_8 = var_445_0.localEulerAngles

				var_445_8.z = 0
				var_445_8.x = 0
				var_445_0.localEulerAngles = var_445_8
			end

			local var_445_9 = 0
			local var_445_10 = 1.15

			if var_445_9 < arg_442_1.time_ and arg_442_1.time_ <= var_445_9 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, false)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_11 = arg_442_1:GetWordFromCfg(1108407109)
				local var_445_12 = arg_442_1:FormatText(var_445_11.content)

				arg_442_1.text_.text = var_445_12

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_13 = 46
				local var_445_14 = utf8.len(var_445_12)
				local var_445_15 = var_445_13 <= 0 and var_445_10 or var_445_10 * (var_445_14 / var_445_13)

				if var_445_15 > 0 and var_445_10 < var_445_15 then
					arg_442_1.talkMaxDuration = var_445_15

					if var_445_15 + var_445_9 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_15 + var_445_9
					end
				end

				arg_442_1.text_.text = var_445_12
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)
				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_16 = math.max(var_445_10, arg_442_1.talkMaxDuration)

			if var_445_9 <= arg_442_1.time_ and arg_442_1.time_ < var_445_9 + var_445_16 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_9) / var_445_16

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_9 + var_445_16 and arg_442_1.time_ < var_445_9 + var_445_16 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_442_1:InitPlayNodeList()
	end,
	Play1108407110 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 1108407110
		arg_446_1.duration_ = 10.03

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
			arg_446_1.auto_ = false
		end

		function arg_446_1.playNext_(arg_448_0)
			arg_446_1.onStoryFinished_()
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = arg_446_1.actors_["1084ui_story"].transform
			local var_449_1 = 0

			if var_449_1 < arg_446_1.time_ and arg_446_1.time_ <= var_449_1 + arg_449_0 then
				arg_446_1.var_.moveOldPos1084ui_story = var_449_0.localPosition
			end

			local var_449_2 = 0.001

			if var_449_1 <= arg_446_1.time_ and arg_446_1.time_ < var_449_1 + var_449_2 then
				local var_449_3 = (arg_446_1.time_ - var_449_1) / var_449_2
				local var_449_4 = Vector3.New(0, -0.97, -6)

				var_449_0.localPosition = Vector3.Lerp(arg_446_1.var_.moveOldPos1084ui_story, var_449_4, var_449_3)

				local var_449_5 = manager.ui.mainCamera.transform.position - var_449_0.position

				var_449_0.forward = Vector3.New(var_449_5.x, var_449_5.y, var_449_5.z)

				local var_449_6 = var_449_0.localEulerAngles

				var_449_6.z = 0
				var_449_6.x = 0
				var_449_0.localEulerAngles = var_449_6
			end

			if arg_446_1.time_ >= var_449_1 + var_449_2 and arg_446_1.time_ < var_449_1 + var_449_2 + arg_449_0 then
				var_449_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_449_7 = manager.ui.mainCamera.transform.position - var_449_0.position

				var_449_0.forward = Vector3.New(var_449_7.x, var_449_7.y, var_449_7.z)

				local var_449_8 = var_449_0.localEulerAngles

				var_449_8.z = 0
				var_449_8.x = 0
				var_449_0.localEulerAngles = var_449_8
			end

			local var_449_9 = arg_446_1.actors_["1084ui_story"]
			local var_449_10 = 0

			if var_449_10 < arg_446_1.time_ and arg_446_1.time_ <= var_449_10 + arg_449_0 and not isNil(var_449_9) and arg_446_1.var_.characterEffect1084ui_story == nil then
				arg_446_1.var_.characterEffect1084ui_story = var_449_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_11 = 0.200000002980232

			if var_449_10 <= arg_446_1.time_ and arg_446_1.time_ < var_449_10 + var_449_11 and not isNil(var_449_9) then
				local var_449_12 = (arg_446_1.time_ - var_449_10) / var_449_11

				if arg_446_1.var_.characterEffect1084ui_story and not isNil(var_449_9) then
					arg_446_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_446_1.time_ >= var_449_10 + var_449_11 and arg_446_1.time_ < var_449_10 + var_449_11 + arg_449_0 and not isNil(var_449_9) and arg_446_1.var_.characterEffect1084ui_story then
				arg_446_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_449_13 = 0

			if var_449_13 < arg_446_1.time_ and arg_446_1.time_ <= var_449_13 + arg_449_0 then
				arg_446_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_449_14 = 0

			if var_449_14 < arg_446_1.time_ and arg_446_1.time_ <= var_449_14 + arg_449_0 then
				arg_446_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_449_15 = 0
			local var_449_16 = 1

			if var_449_15 < arg_446_1.time_ and arg_446_1.time_ <= var_449_15 + arg_449_0 then
				local var_449_17 = "play"
				local var_449_18 = "effect"

				arg_446_1:AudioAction(var_449_17, var_449_18, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_449_19 = 0
			local var_449_20 = 1.35

			if var_449_19 < arg_446_1.time_ and arg_446_1.time_ <= var_449_19 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				local var_449_21 = arg_446_1:FormatText(StoryNameCfg[6].name)

				arg_446_1.leftNameTxt_.text = var_449_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_22 = arg_446_1:GetWordFromCfg(1108407110)
				local var_449_23 = arg_446_1:FormatText(var_449_22.content)

				arg_446_1.text_.text = var_449_23

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_24 = 53
				local var_449_25 = utf8.len(var_449_23)
				local var_449_26 = var_449_24 <= 0 and var_449_20 or var_449_20 * (var_449_25 / var_449_24)

				if var_449_26 > 0 and var_449_20 < var_449_26 then
					arg_446_1.talkMaxDuration = var_449_26

					if var_449_26 + var_449_19 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_26 + var_449_19
					end
				end

				arg_446_1.text_.text = var_449_23
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407110", "story_v_side_new_1108407.awb") ~= 0 then
					local var_449_27 = manager.audio:GetVoiceLength("story_v_side_new_1108407", "1108407110", "story_v_side_new_1108407.awb") / 1000

					if var_449_27 + var_449_19 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_27 + var_449_19
					end

					if var_449_22.prefab_name ~= "" and arg_446_1.actors_[var_449_22.prefab_name] ~= nil then
						local var_449_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_22.prefab_name].transform, "story_v_side_new_1108407", "1108407110", "story_v_side_new_1108407.awb")

						arg_446_1:RecordAudio("1108407110", var_449_28)
						arg_446_1:RecordAudio("1108407110", var_449_28)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_side_new_1108407", "1108407110", "story_v_side_new_1108407.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_side_new_1108407", "1108407110", "story_v_side_new_1108407.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_29 = math.max(var_449_20, arg_446_1.talkMaxDuration)

			if var_449_19 <= arg_446_1.time_ and arg_446_1.time_ < var_449_19 + var_449_29 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_19) / var_449_29

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_19 + var_449_29 and arg_446_1.time_ < var_449_19 + var_449_29 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_446_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/H05",
		"TextureConfig/Background/ST2105"
	},
	voices = {
		"story_v_side_new_1108407.awb"
	}
}
